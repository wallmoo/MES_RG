package kr.co.passcombine.set.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.passcombine.set.svc.LogStatusService;
import kr.co.passcombine.set.svc.SYInfoService;
import kr.co.passcombine.set.svc.SYInspService;
import kr.co.passcombine.set.util.ExportExcelUtil;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.vo.SYInspVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYProductOperStatusVO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/export")
public class ExportController {

	private static final Logger logger = LoggerFactory
			.getLogger(ExportController.class);
	@SuppressWarnings("unused")
	private static final String MAIN_PATH = "/export";

	@Inject
	private FileSystemResource fsResource;

	@Resource(name = "setLogStatusService")
	LogStatusService logStatusService;

	@Resource(name = "setInspService")
	SYInspService sYInspService;
	
	@RequestMapping(value = "/export_client_jqgrid", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	public String goExportClientJQGrid(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("ExportController.goExportClientJQGrid() is called. ");
		JSONObject resultData = new JSONObject();

		String excel_down_seq = request.getParameter("excel_down_seq");
		System.out.println("excel_down_seq :::  "+excel_down_seq);
		String fileName = request.getParameter("file_name");
		System.out.println("fileName :::  "+fileName);
		String sheet_name = request.getParameter("sheet_name");
		System.out.println("sheet_name :::  "+sheet_name);
		String sheet_title = request.getParameter("sheet_title");
		System.out.println("sheet_title :::  "+sheet_title);
		String header_col_ids = request.getParameter("header_col_ids");
		System.out.println("header_col_ids :::  "+header_col_ids);
		String header_col_names = request.getParameter("header_col_names");
		System.out.println("header_col_names :::  "+header_col_names);
		String header_col_aligns = request.getParameter("header_col_aligns");
		System.out.println("header_col_aligns :::  "+header_col_aligns);
		String header_col_widths = request.getParameter("header_col_widths");
	
		System.out.println("header_col_widths :::  "+header_col_widths);
		String body_data = request.getParameter("body_data");
		System.out.println("body_data :::  "+body_data);
	
	
	

	
	
	
		boolean result = false;
		String filePath = null, return_filePath = null;

		try {
			UUID uid = UUID.randomUUID();
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy = formatter_yyyy.format(new java.util.Date());
			String mm = formatter_mm.format(new java.util.Date());
			String dd = formatter_dd.format(new java.util.Date());

			String strDir = fsResource.getPath() + "/excel/export/" + yyyy
					+ "/" + mm + "/" + dd + "/";
			File d = new File(strDir);
			if (!d.isDirectory()) {
				d.mkdirs();
			}
		
			String[] arr_header_col_id = header_col_ids.split(",");			
			String[] arr_header_col_name = header_col_names.split(",");
			String[] arr_header_col_align = header_col_aligns.split(",");
			String[] arr_header_col_width = header_col_widths.split(",");
			Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
			ht_header.put("sheet_name", sheet_name);
			ht_header.put("sheet_title", sheet_title);
			ht_header.put("col_id", arr_header_col_id);
			ht_header.put("col_name", arr_header_col_name);
			ht_header.put("col_align", arr_header_col_align);
			ht_header.put("col_width", arr_header_col_width);

			filePath = fsResource.getPath() + "/excel/export/" + yyyy + "/"
					+ mm + "/" + dd + "/" + uid + ".xlsx";
			return_filePath = "/excel/export/" + yyyy + "/" + mm + "/" + dd
					+ "/" + uid + ".xlsx";

			JSONParser jsonParser = new JSONParser();
			JSONArray listBodyData = (JSONArray) jsonParser.parse(body_data
					.toString());
			
			System.out.println("listBodyData : " + listBodyData);

			result = ExportExcelUtil.createXls(filePath, ht_header,
					listBodyData);
			if (result) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("file_path", return_filePath);
				resultData.put("file_name", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("file_path", null);
			resultData.put("file_name", null);
		}
		return resultData.toJSONString();
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/export_server_jqgrid", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String goExportServerJQGrid(@ModelAttribute Object obj,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("ExportController.goExportServerJQGrid() is called. ");
		JSONObject resultData = new JSONObject();

		String excel_down_seq = request.getParameter("excel_down_seq");
		String fileName = request.getParameter("file_name");
		String sheet_name = request.getParameter("sheet_name");
		String sheet_title = request.getParameter("sheet_title");
		String header_col_ids = request.getParameter("header_col_ids");
		String header_col_names = request.getParameter("header_col_names");
		String header_col_aligns = request.getParameter("header_col_aligns");
		String header_col_widths = request.getParameter("header_col_widths");
		String cmd = request.getParameter("cmd");

		boolean result = false;
		String filePath = null, return_filePath = null;

		try {
			UUID uid = UUID.randomUUID();
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy = formatter_yyyy.format(new java.util.Date());
			String mm = formatter_mm.format(new java.util.Date());
			String dd = formatter_dd.format(new java.util.Date());

			String strDir = fsResource.getPath() + "excel/export/" + yyyy + "/"
					+ mm + "/" + dd + "/";
			File d = new File(strDir);
			if (!d.isDirectory()) {
				d.mkdirs();
			}

			String[] arr_header_col_id = header_col_ids.split(",");
			String[] arr_header_col_name = header_col_names.split(",");
			String[] arr_header_col_align = header_col_aligns.split(",");
			String[] arr_header_col_width = header_col_widths.split(",");
			Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
			ht_header.put("sheet_name", sheet_name);
			ht_header.put("sheet_title", sheet_title);
			ht_header.put("col_id", arr_header_col_id);
			ht_header.put("col_name", arr_header_col_name);
			ht_header.put("col_align", arr_header_col_align);
			ht_header.put("col_width", arr_header_col_width);

			filePath = fsResource.getPath() + "/excel/export/" + yyyy + "/"
					+ mm + "/" + dd + "/" + uid + ".xls";
			return_filePath = "/excel/export/" + yyyy + "/" + mm + "/" + dd
					+ "/" + uid + ".xls";

			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = "";

			// if("grid_goods_detail".equals(cmd)) {
			// LogStatusVo logVo = new LogStatusVo();
			// List<LogStatusVo> listLogStatus =
			// logStatusService.selectLogStatus(logVo);
			// listDataJsonString = ResponseUtils.getJsonResponse(response,
			// listLogStatus);
			// }

			JSONArray listBodyData = (JSONArray) jsonParser
					.parse(listDataJsonString);
			result = ExportExcelUtil.createXls(filePath, ht_header,
					listBodyData);
			if (result) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("file_path", return_filePath);
				resultData.put("file_name", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("file_path", null);
			resultData.put("file_name", null);
		}
		return resultData.toJSONString();
	}

	@RequestMapping(value = "/export_file_info", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	public String export_file_info(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("ExportController.export_file_info() is called. ");
		JSONObject resultData = new JSONObject();

		String excel_down_seq = request.getParameter("excel_down_seq");
		String fileName = request.getParameter("file_name");
		String sheet_name = request.getParameter("sheet_name");
		String sheet_title = request.getParameter("sheet_title");
		String header_col_ids = request.getParameter("header_col_ids");
		String header_col_names = request.getParameter("header_col_names");
		String header_col_aligns = request.getParameter("header_col_aligns");
		String header_col_widths = request.getParameter("header_col_widths");
		String body_data = request.getParameter("body_data");

		boolean result = false;
		String filePath = null, return_filePath = null;

		try {
			UUID uid = UUID.randomUUID();
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy = formatter_yyyy.format(new java.util.Date());
			String mm = formatter_mm.format(new java.util.Date());
			String dd = formatter_dd.format(new java.util.Date());

			String strDir = fsResource.getPath() + "/excel/export/" + yyyy
					+ "/" + mm + "/" + dd + "/";
			File d = new File(strDir);
			if (!d.isDirectory()) {
				d.mkdirs();
			}

			String[] arr_header_col_id = header_col_ids.split(",");
			String[] arr_header_col_name = header_col_names.split(",");
			String[] arr_header_col_align = header_col_aligns.split(",");
			String[] arr_header_col_width = header_col_widths.split(",");
			Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
			ht_header.put("sheet_name", sheet_name);
			ht_header.put("sheet_title", sheet_title);
			ht_header.put("col_id", arr_header_col_id);
			ht_header.put("col_name", arr_header_col_name);
			ht_header.put("col_align", arr_header_col_align);
			ht_header.put("col_width", arr_header_col_width);

			filePath = fsResource.getPath() + "/excel/export/" + yyyy + "/"
					+ mm + "/" + dd + "/" + uid + ".xlsx";
			return_filePath = "/excel/export/" + yyyy + "/" + mm + "/" + dd
					+ "/" + uid + ".xlsx";

			JSONParser jsonParser = new JSONParser();
			JSONArray listBodyData = (JSONArray) jsonParser.parse(body_data
					.toString());

			result = ExportExcelUtil.createXls(filePath, ht_header,
					listBodyData);
			if (result) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("file_path", return_filePath);
				resultData.put("file_name", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("file_path", null);
			resultData.put("file_name", null);
		}
		return resultData.toJSONString();
	}
	
	@Resource(name = "setInfoService")
	SYInfoService sYInfoService;
	
	
	@RequestMapping(value = "/export_client_jqgrid_2", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	public String goExportClientJQGrid_2(HttpServletRequest request,
			HttpServletResponse response,SYMaterialVo vo) throws Exception {
		logger.info("ExportController.goExportClientJQGrid() is called. ");
		JSONObject resultData = new JSONObject();

		String excel_down_seq = request.getParameter("excel_down_seq");
		System.out.println("excel_down_seq :::  "+excel_down_seq);
		String fileName = request.getParameter("file_name");
		System.out.println("fileName :::  "+fileName);
		String sheet_name = request.getParameter("sheet_name");
		System.out.println("sheet_name :::  "+sheet_name);
		String sheet_title = request.getParameter("sheet_title");
		System.out.println("sheet_title :::  "+sheet_title); 
		
		
		
		String header_col_ids = request.getParameter("header_col_ids");
		System.out.println("header_col_ids :::  "+header_col_ids);
		String header_col_names = request.getParameter("header_col_names");
		System.out.println("header_col_names :::  "+header_col_names);
		String header_col_aligns = request.getParameter("header_col_aligns");
		System.out.println("header_col_aligns :::  "+header_col_aligns);
		String header_col_widths = request.getParameter("header_col_widths");
	
		System.out.println("header_col_widths :::  "+header_col_widths);
		String body_data = request.getParameter("body_data");

	/*	String body_data = "[{"item_code\":"A","routing_nm1":"1","routing_nm2":"2","routing_nm3":"3"},{"item_code":"B","routing_nm1":"1","routing_nm2":"2","routing_nm3":"3"},{"item_code":"C","routing_nm1":"1","routing_nm2":"2","routing_nm3":"3"}]";
		System.out.println("body_data:::"+body_data);*/
	
	
	

	
	
	
		boolean result = false;
		String filePath = null, return_filePath = null;

		try {
			UUID uid = UUID.randomUUID();
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy = formatter_yyyy.format(new java.util.Date());
			String mm = formatter_mm.format(new java.util.Date());
			String dd = formatter_dd.format(new java.util.Date());

			String strDir = fsResource.getPath() + "/excel/export/" + yyyy
					+ "/" + mm + "/" + dd + "/";
			File d = new File(strDir);
			if (!d.isDirectory()) {
				d.mkdirs();
			}
			
			int max = sYInfoService.excelMax(vo)+1;
			System.out.println("max::::"+max);
			
//			String[] arr_header_col_id = header_col_ids.split(",");			
//			String[] arr_header_col_name = header_col_names.split(",");
//			String[] arr_header_col_align = header_col_aligns.split(",");
//			String[] arr_header_col_width = header_col_widths.split(",");
			
			
			String[] arr_header_col_id = new String[max];
			String[] arr_header_col_name = new String[max];
			String[] arr_header_col_align = new String[max];
			String[] arr_header_col_width = new String[max];
			Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
			
			
			
			for(int i =0; i< max; i++)
			{	
				if(i == 0)
				{
					arr_header_col_id[i] = "item_code";
					arr_header_col_name[i] = "P/N";
					
				}else if(i == 1){
					
					arr_header_col_id[i] = "item_nm";
					arr_header_col_name[i] = "품명";
					
				}else
				{
					arr_header_col_id[i] = "routing_nm"+i;
					arr_header_col_name[i] = "공정명"+i;
				
				}
				arr_header_col_align[i] = "center";
				arr_header_col_width[i] = "10";
				
				
			}
			
			
			ht_header.put("sheet_name", sheet_name);
			ht_header.put("sheet_title", sheet_title);
			ht_header.put("col_id", arr_header_col_id);
			ht_header.put("col_name", arr_header_col_name);
			ht_header.put("col_align", arr_header_col_align);
			ht_header.put("col_width", arr_header_col_width);

			filePath = fsResource.getPath() + "/excel/export/" + yyyy + "/"
					+ mm + "/" + dd + "/" + uid + ".xlsx";
			return_filePath = "/excel/export/" + yyyy + "/" + mm + "/" + dd
					+ "/" + uid + ".xlsx";
//			제품명 공정1  공정2   공정3
//			A 		1 		2 		3
//			B 		1 		2 		3
//			C 		1 		2 		3
			
//			String jsonDataString= "[[pc: a, pm : 품명a ,d,],[],[]]";
			
			
			List<SYMaterialVo> tempList = new ArrayList<SYMaterialVo>();
			//response =  [{"item_code\":"A","routing_nms":"1","2","3","4"},......] 

			tempList = sYInfoService.excelLoad(vo);
			
			JSONArray jArr = new JSONArray();
			
			for(int i = 0; i< tempList.size(); i++)
			{
				JSONObject jObj = new JSONObject();
				
				String item_code = "";
			
				jObj.put("item_code", tempList.get(i).getItem_code());
				jObj.put("item_nm", tempList.get(i).getItem_nm());
				
				for(int j = 0; j<max; j++)
				{
					String[] routing_nms = tempList.get(i).getRouting_nm().split(",");	
					
					System.out.println("Item_code:::"+tempList.get(i).getItem_code());
		
					
					try{
						System.out.println("routing_nms:::"+routing_nms[j]);
						jObj.put("routing_nm"+(j+1), routing_nms[j] );
					}catch(Exception e)
					{
						e.getStackTrace();
					}
				}
		
	
				
				jArr.add(jObj);
				
			}
		
			JSONParser jsonParser = new JSONParser();
			//JSONArray listBodyData = (JSONArray) jsonParser.parse(body_data.toString()); 
			//listBodyData =  new JSONArray(body_data);
			JSONArray listBodyData = jArr;
			System.out.println("listBodyData:::"+listBodyData);

			result = ExportExcelUtil.createXls(filePath, ht_header,
					listBodyData);
			if (result) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("file_path", return_filePath);
				resultData.put("file_name", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("file_path", null);
			resultData.put("file_name", null);
		}
		return resultData.toJSONString();
	}
	
	@RequestMapping(value = "/export_fnsh_insp", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings({ "unchecked", "unused" })
	public String export_fnsh_insp(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("ExportController.goExportClientJQGrid() is called. ");
		JSONObject resultData = new JSONObject();

		String fileName = "최종검사이력_작업실적.xlsx";		
		String sheet_name = "작업실적";
		String sheet_title = "작업실적";
		String header_col_ids = "val_seq,inspection_item,spec,min_spec,max_spec,insp_val,insp_rst";
		String header_col_names = "No,검사 항목 ,검사기준,규격(LSL),규격(USL),측정 data,측정결과";
		String header_col_aligns = "center,center,center,center,center,center,center";
		String header_col_widths = "10,10,10,10,10,10,10";
	
		String product_po = request.getParameter("product_po");
		String routing_code = request.getParameter("routing_code");
	
		SYInspVO vo = new SYInspVO(); 
		vo.setProduct_po(product_po);
		vo.setRouting_code(routing_code);
		List<SYInspVO> dataList = sYInspService.export_fnsh_insp(vo);
		
		
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		String listDataJsonString = ResponseUtils.getJsonResponse(response,	dataList);
		listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
		
		String body_data = listDataJArray.toJSONString();
		
		boolean result = false;
		String filePath = null, return_filePath = null;

		try {
			UUID uid = UUID.randomUUID();
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy = formatter_yyyy.format(new java.util.Date());
			String mm = formatter_mm.format(new java.util.Date());
			String dd = formatter_dd.format(new java.util.Date());

			String strDir = fsResource.getPath() + "/excel/export/" + yyyy
					+ "/" + mm + "/" + dd + "/";
			File d = new File(strDir);
			if (!d.isDirectory()) {
				d.mkdirs();
			}
		
			String[] arr_header_col_id = header_col_ids.split(",");			
			String[] arr_header_col_name = header_col_names.split(",");
			String[] arr_header_col_align = header_col_aligns.split(",");
			String[] arr_header_col_width = header_col_widths.split(",");
			Hashtable<String, Object> ht_header = new Hashtable<String, Object>();
			ht_header.put("sheet_name", sheet_name);
			ht_header.put("sheet_title", sheet_title);
			ht_header.put("col_id", arr_header_col_id);
			ht_header.put("col_name", arr_header_col_name);
			ht_header.put("col_align", arr_header_col_align);
			ht_header.put("col_width", arr_header_col_width);

			filePath = fsResource.getPath() + "/excel/export/" + yyyy + "/"
					+ mm + "/" + dd + "/" + uid + ".xlsx";
			return_filePath = "/excel/export/" + yyyy + "/" + mm + "/" + dd
					+ "/" + uid + ".xlsx";

			//JSONParser jsonParser = new JSONParser();
			JSONArray listBodyData = (JSONArray) jsonParser.parse(body_data
					.toString());
			
			System.out.println("listBodyData : " + listBodyData);

			result = ExportExcelUtil.createXls(filePath, ht_header,
					listBodyData);
			if (result) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("file_path", return_filePath);
				resultData.put("file_name", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("file_path", null);
			resultData.put("file_name", null);
		}
		return resultData.toJSONString();
	}
}