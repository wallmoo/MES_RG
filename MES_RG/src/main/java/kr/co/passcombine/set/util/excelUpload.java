package kr.co.passcombine.set.util;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;


import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbookType;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import javax.servlet.http.HttpServletResponse;


public class excelUpload {
	public static List<Map<String, Object>> excelRead(MultipartFile OrgFile, String [] columName) {
		
		List<Map<String, Object>> list = null; 
		Map <String, Object> dataMap = null;
		
		try {
			File files = new File(OrgFile.getOriginalFilename());
			OrgFile.transferTo(files);
			
			FileInputStream xlsxFile= new FileInputStream(files);
			
			// 워크북 생성
			XSSFWorkbook workbook = new XSSFWorkbook(xlsxFile);
			
			// 함수 계산 객체
			FormulaEvaluator fe = workbook.getCreationHelper().createFormulaEvaluator();
			
			for( int s = 0 ; s < workbook.getNumberOfSheets() ; s++ ) { // Sheet Start
				
				list = new ArrayList<Map<String,Object>>();
				
				// 시트 추출
				XSSFSheet sheet = workbook.getSheetAt(s);

				for ( int r = 1 ; r < sheet.getPhysicalNumberOfRows() ; r++ ) { // Row Start
					
					dataMap = new HashMap<String, Object>();
					
					// 시트에대한 행 추출
					XSSFRow row = sheet.getRow(r);
					if ( row != null) { // Row Null Check Start
						
						for ( int c = 0 ; c < row.getPhysicalNumberOfCells() ; c++ ) { // Cell Start
							
							// 행에대한 셀을 추출
							XSSFCell cell = row.getCell(c);
							if ( cell != null) { // Cell Null Check Start
								
								XSSFCellStyle style = cell.getCellStyle();
								// 셀 타입에 따라값 처리
								switch ( cell.getCellType() ) {
									
									// String 타입
									case HSSFCell.CELL_TYPE_STRING : 
										dataMap.put(columName[c], cell.getStringCellValue());
										
										break;
										
									// Date or Number
									case HSSFCell.CELL_TYPE_NUMERIC : 
										/*
										 * 날짜 타입 포맷 (아래와 같은 형식이 아닐 경우 String값으로 치환됨)
										 * ex ) 2013년 10월 10일 12:34:56 PM, 2013-10-22  12:34:56 PM
										 * 
										 */
										if ("m/d/yy".equals(style.getDataFormatString()) || 
												"reserved-0x1f".equals(style.getDataFormatString())) { // 날짜 타입
											SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA); // 날짜 형식 지정
											dataMap.put(columName[c], sdf.format(cell.getDateCellValue()));
										} else { // 정수

											dataMap.put(columName[c], NumberFormat
															.getNumberInstance()
															.format(cell.getNumericCellValue())
															.replaceAll(",", ""));
										}
										break;
										
									// Boolean 타입
									case HSSFCell.CELL_TYPE_BOOLEAN : 
										dataMap.put(columName[c], cell.getBooleanCellValue());
										break;
										
									// 함수 타입
									case HSSFCell.CELL_TYPE_FORMULA :
										
										// 함수 타입에 따라 처리
										switch (fe.evaluateFormulaCell(cell)) {
											
											// Number
											case HSSFCell.CELL_TYPE_NUMERIC :
												dataMap.put(columName[c], NumberFormat
														.getNumberInstance()
														.format(cell.getNumericCellValue())
														.replaceAll(",", ""));
												break;
												
											// String
											case HSSFCell.CELL_TYPE_STRING :
												dataMap.put(columName[c], cell.getStringCellValue());
												break;
											
											//Boolean
											case HSSFCell.CELL_TYPE_BOOLEAN :
												dataMap.put(columName[c], cell.getBooleanCellValue());
												break;
										}
										break;
										
									// 공백일 경우
									case HSSFCell.CELL_TYPE_BLANK : break;
									// Error 일 경우
									case HSSFCell.CELL_TYPE_ERROR : break;
									
									// 그 밖의 타입은 String
									default : 
										dataMap.put(columName[c], cell.getStringCellValue());
										break;
								}
							} // Cell Null Check End
						} // Cell End
						if(!dataMap.isEmpty()){
							list.add(dataMap);
						}
					} // Row End
				} // Row Null Check End
			} // Sheet End

		} catch(Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	} 
}
