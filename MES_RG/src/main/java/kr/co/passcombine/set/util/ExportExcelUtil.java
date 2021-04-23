package kr.co.passcombine.set.util;

import java.io.*;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExportExcelUtil {
	private static final Logger logger = LoggerFactory.getLogger(ExportExcelUtil.class);
	
	/**
	 * Export 엑셀처리.
	 */
	@SuppressWarnings("unused")
	public static boolean createXls(String file_output, Hashtable<String, Object> opt, JSONArray listBodyData){
		boolean result = false;
		XSSFWorkbook workbook = null;
		// HSSFWorkbook workbook = null;
		FileOutputStream fs = null;
		
		try {
			File f = new File(file_output);
			if(!f.exists()) {
				String strDir = file_output.substring(0, file_output.lastIndexOf("/"));
				File desti = new File(strDir);
				desti.mkdirs();
				f.createNewFile();
			}
			
			workbook = new XSSFWorkbook();
			Map<String, CellStyle> styles = createStyles(workbook);
			
			XSSFSheet sheet = workbook.createSheet();
			workbook.setSheetName(0 , String.valueOf(opt.get("sheet_name")));
			PrintSetup printSetup = sheet.getPrintSetup();
			printSetup.setLandscape(true);
			sheet.setFitToPage(true);
			sheet.setHorizontallyCenter(true);
	  
			String[] col_id = (String[]) opt.get("col_id");
			String[] col_name = (String[]) opt.get("col_name");
			String[] col_align = (String[]) opt.get("col_align");
	      
			// title row
			Row titleRow = sheet.createRow(0);
			titleRow.setHeightInPoints(45);
			Cell titleCell = titleRow.createCell(0);
			titleCell.setCellValue(String.valueOf(opt.get("sheet_title")));
			titleCell.setCellStyle(styles.get("title"));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, (col_name.length-1)));
	      
			// header row
			Row headerRow = sheet.createRow(1);
			headerRow.setHeightInPoints(40);
			Cell headerCell;
			for (int i = 0; i < col_name.length; i++) {
				headerCell = headerRow.createCell(i);
				headerCell.setCellValue(StringUtil.replace2(col_name[i], "<br/>", "\r\n"));
				headerCell.setCellStyle(styles.get("header"));
			}
	  
//			System.out.println(listBodyData.toJSONString());
			// contents row
			int rownum = 2;
			if(listBodyData != null && listBodyData.size() > 0) {
				for(Object obj: listBodyData){
			  		JSONObject nobj = (JSONObject) obj;
			  		Row row = sheet.createRow(rownum++);
			  		for (int j = 0; j < col_name.length; j++) {
			  			Cell cell = row.createCell(j);
			  			String colId = col_id[j].toString();
			  			if(col_id[j] != null && colId.endsWith("_amt") || col_align[j].equals("right")){
			  				cell.setCellStyle(styles.get("cell_double"));
			  			} 
//			  			else if(col_id[j] != null && (colId.equals("eindt")||colId.equals("vendor_delivery_date")||colId.equals("aedat")) ){
//			  				System.out.println(colId);
//			  				cell.setCellStyle(styles.get("cell_date"));
//			  				cell.setCellValue(HSSFDateUtil.getExcelDate(new java.util.Date()));
//			  			    CellUtil.setCellStyleProperty(cell, workbook, CellUtil.DATA_FORMAT, HSSFDataFormat.getBuiltinFormat(("yyyy-MM-dd")));
//			  			} 
			  			else if(col_id[j] != null && (colId.equals("menge")||colId.equals("zdeli_menge")) ){
			  				cell.setCellStyle(styles.get("cell_number"));
			  			} else {
			  				cell.setCellStyle(styles.get("cell"));
			  			}
			  		}
				}
			}
	      
			// set sample data  ??
			if (listBodyData != null && listBodyData.size() > 0) {
				int i=0;
				for(Object obj: listBodyData){
					JSONObject nobj = (JSONObject) obj;
					Row row = sheet.getRow(2 + i);
					for (int j = 0; j < col_id.length; j++) {
						if (col_id[j] == null) continue;
						if (col_id[j] instanceof String) {
							if(col_id[j].toString().equals("rownum")) {
								row.getCell(j).setCellValue((i+1));
							} else {
								if(col_id[j].toString().endsWith("_amt") || col_align[j].equals("right")){
//									row.getCell(j).setCellStyle(styles.get("cell_double"));
									row.getCell(j).setCellValue( Double.parseDouble(String.valueOf(nobj.get(col_id[j]))) );
								} 
//								else if(col_id[j] != null && (col_id[j].toString().equals("eindt")||col_id[j].toString().equals("vendor_delivery_date")||col_id[j].toString().equals("aedat")) ){
//									String c_val = String.valueOf(nobj.get(col_id[j]));
//									System.out.println(c_val);
//									if( !"".equals(c_val) && c_val!=null && !"null".equals(c_val)) {
//										SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
//										Date to = transFormat.parse(c_val);
//										row.getCell(j).setCellValue(HSSFDateUtil.getExcelDate(to));
//									}
//					  			}  
								else {
//									if(col_align[j].equals("left")){
//										row.getCell(j).setCellStyle(styles.get("cell_left"));
//									} else {
//										row.getCell(j).setCellStyle(styles.get("cell"));
//									}
									String c_val = String.valueOf(nobj.get(col_id[j]));
//									System.out.println(col_id[j] + " : " + c_val);
									if(c_val != null && c_val == "null") c_val = ""; 
									else
										row.getCell(j).setCellValue( StringUtil.nullCheck(c_val) );
								}
							}
						} else {
							row.getCell(j).setCellValue((Double) nobj.get(col_id[j]));
						}
					}
					i++;
				}
			}
		
			for(int i=0; i<col_name.length; i++){
				sheet.autoSizeColumn((short)i);
				sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+512 );
			}
			fs = new FileOutputStream(f);
			workbook.write(fs);
		
			result = true;
		} catch (Exception e) {
			result = false;
			e.printStackTrace();
		} finally {
			if(fs!=null) {
				try {
					fs.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(workbook != null){
				try {
					workbook.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}
	
	private static Map<String, CellStyle> createStyles(Workbook wb){
	    Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
	    CellStyle style;
	    
	    Font titleFont = wb.createFont();        
	    titleFont.setFontHeightInPoints((short) 18); 
	    titleFont.setFontName("맑은 고딕");
	    titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
			
		Font headerFont = wb.createFont();        
		headerFont.setFontHeightInPoints((short) 10); 
		headerFont.setFontName("맑은 고딕");
		headerFont.setColor(IndexedColors.WHITE.getIndex());
		headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		
		Font bodyFont = wb.createFont();        
		bodyFont.setFontHeightInPoints((short) 9); 
		bodyFont.setFontName("맑은 고딕");
			
	    style = wb.createCellStyle();
	    style.setAlignment(CellStyle.ALIGN_CENTER);
	    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	    style.setFont(titleFont);
	    styles.put("title", style);
	
	    style = wb.createCellStyle();
	    style.setAlignment(CellStyle.ALIGN_CENTER);
	    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	    style.setBorderRight(CellStyle.BORDER_THIN);
	    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderLeft(CellStyle.BORDER_THIN);
	    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderTop(CellStyle.BORDER_THIN);
	    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderBottom(CellStyle.BORDER_MEDIUM);
	    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    style.setFont(headerFont);
	    style.setWrapText(true);
	    styles.put("header", style);
	
	    style = wb.createCellStyle();
	    style.setAlignment(CellStyle.ALIGN_CENTER);
	    style.setWrapText(true);
	    style.setBorderRight(CellStyle.BORDER_THIN);
	    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderLeft(CellStyle.BORDER_THIN);
	    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderTop(CellStyle.BORDER_THIN);
	    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderBottom(CellStyle.BORDER_THIN);
	    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    style.setFont(bodyFont);
	    styles.put("cell", style);
	    
	    style = wb.createCellStyle();
	    style.setAlignment(CellStyle.ALIGN_LEFT);
	    style.setWrapText(true);
	    style.setBorderRight(CellStyle.BORDER_THIN);
	    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderLeft(CellStyle.BORDER_THIN);
	    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderTop(CellStyle.BORDER_THIN);
	    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderBottom(CellStyle.BORDER_THIN);
	    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    style.setFont(bodyFont);
	    styles.put("cell_left", style);
	    
	    style = wb.createCellStyle();
	    style.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
	    style.setAlignment(CellStyle.ALIGN_RIGHT);
	    style.setWrapText(true);
	    style.setBorderRight(CellStyle.BORDER_THIN);
	    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderLeft(CellStyle.BORDER_THIN);
	    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderTop(CellStyle.BORDER_THIN);
	    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderBottom(CellStyle.BORDER_THIN);
	    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    style.setFont(bodyFont);
	    DataFormat df = wb.createDataFormat();
	    style.setDataFormat(df.getFormat("#,##0"));
	    styles.put("cell_number", style);
	    
	    style = wb.createCellStyle();
	    style.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
	    style.setAlignment(CellStyle.ALIGN_RIGHT);
	    style.setWrapText(true);
	    style.setBorderRight(CellStyle.BORDER_THIN);
	    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderLeft(CellStyle.BORDER_THIN);
	    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderTop(CellStyle.BORDER_THIN);
	    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderBottom(CellStyle.BORDER_THIN);
	    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    style.setFont(bodyFont);
	    styles.put("cell_double", style);
	    
	    style = wb.createCellStyle();
	    CreationHelper createHelper = wb.getCreationHelper();
		style.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd"));
//	    style.setDataFormat(HSSFDataFormat.getBuiltinFormat("yyyy-MM-DD"));
	    style.setAlignment(CellStyle.ALIGN_CENTER);
	    style.setWrapText(true);
	    style.setBorderRight(CellStyle.BORDER_THIN);
	    style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderLeft(CellStyle.BORDER_THIN);
	    style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderTop(CellStyle.BORDER_THIN);
	    style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    style.setBorderBottom(CellStyle.BORDER_THIN);
	    style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    style.setFont(bodyFont);
	    styles.put("cell_date", style);
	
	    style = wb.createCellStyle();
	    style.setAlignment(CellStyle.ALIGN_CENTER);
	    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	    style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
	    styles.put("formula", style);
	
	    style = wb.createCellStyle();
	    style.setAlignment(CellStyle.ALIGN_CENTER);
	    style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	    style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex());
	    style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
	    styles.put("formula_2", style);
	
	    return styles;
	}
}
