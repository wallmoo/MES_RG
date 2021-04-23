package kr.co.passcombine.set.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.passcombine.set.svc.SYFileService;
import kr.co.passcombine.set.svc.SYInfoService;
import kr.co.passcombine.set.svc.SYOverhaulService;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.StringUtil;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYFileVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYRepairVo;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.mvc.AbstractController;

import com.fasterxml.jackson.core.JsonParser;

@Controller
@RequestMapping("/file")
@PropertySource("classpath:/app.properties")
public class FileController extends AbstractController{
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
 
	@Resource
	private Environment environment;
	
	@Inject
	private FileSystemResource fsResource;
	
	@Resource(name = "setFileService")
	SYFileService syFileService;
	/*********************************************************************************/
	@Resource(name = "setInfoService")
	SYInfoService sYInfoService;
	@Resource(name = "setOverhaulService")
	SYOverhaulService syOverHaulService;
	
	/*********************************************************************************/

	/*
	 // just download
	@RequestMapping(value = "/attach_download", method = RequestMethod.GET)
	public ModelAndView fileDown(@RequestParam("file_path") String file_path, @RequestParam("file_name") String file_name) {
		ModelAndView returnMV = new ModelAndView();
		returnMV.setViewName("download");
		returnMV.addObject("file_path", fsResource.getPath() +"/" + file_path);
		returnMV.addObject("file_name", file_name);
		return returnMV; 
	}
	*/
	
	// excel file make -> download
	// @RequestMapping(value = "/attach_download", method = RequestMethod.GET)
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String output = ServletRequestUtils.getStringParameter(request, "output");
		
		//dummy data
		Map<String,String> revenueData = new HashMap<String,String>();
		revenueData.put("Jan-2010", "$100,000,000");
		revenueData.put("Feb-2010", "$110,000,000");
		revenueData.put("Mar-2010", "$130,000,000");
		revenueData.put("Apr-2010", "$140,000,000");
		revenueData.put("May-2010", "$200,000,000");
//		
//		if(output ==null || "".equals(output)){
//			//return normal view
//			return new ModelAndView("RevenueSummary","revenueData",revenueData);
//			
//		}else if("EXCEL".equals(output.toUpperCase())){
			//return excel view
			return new ModelAndView("ExcelRevenueSummary","revenueData",revenueData);
			
//		}else{
//			//return normal view
//			return new ModelAndView("RevenueSummary","revenueData",revenueData);
//			
//		}
	}
	
	@RequestMapping(value = "/attach_download", method = RequestMethod.GET)
	public ModelAndView fileDown(@RequestParam("file_path") String file_path, @RequestParam("file_name") String file_name) {
		ModelAndView returnMV = new ModelAndView();
		returnMV.setViewName("download");
//		System.out.println("###################################");
//		System.out.println("file_name :: " + file_name);
//		System.out.println("file_path / :: " + fsResource.getPath() +"/(:>)" + file_path);
//		System.out.println("file_path :: " + fsResource.getPath() + file_path);
		try {
			returnMV.addObject("file_path", fsResource.getPath() + "/"+file_path); //  +"/"
			returnMV.addObject("file_name", URLDecoder.decode(file_name, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return returnMV; 
	}
	
	/*
	@RequestMapping(value = "/makeListFile", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ModelAndView makeListFile(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			String docName = "";
			String data = request.getParameter("csvBuffer");
			String fileName = request.getParameter("fileName");
			
			// header
			String header = request.getHeader("User-Agent");
			if( header.contains("MSIE") )	header = "MSIE";
			else if( header.contains("Chrome") ) header = "Chrome";
			else if( header.contains("Opera") ) header = "Opera";
			
			if( data!=null && fileName!=null ){
				data = URLDecoder.decode(data, "UTF-8");
				fileName = URLDecoder.decode(fileName, "UTF-8");
				response.setContentType("application/vnd.ms-excel");
				
				if( header.contains("MSIE") ) {
					docName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
					response.setHeader("Content-Disposition", "attachment;filename=\"" + docName + ".xls");
				} else if( header.contains("Chrome") ) {
					docName = new String(fileName.getBytes("UTF-8"), "ISO--8859-1");
					response.setHeader("Content-Disposition", "attachment;filename=\"" + docName + ".xls\"");
				} else {
					//
				}
				OutputStream out = new FileOutputStream(localFile);
				response.setHeader("Pragma", "no-cashe;");
				response.setHeader("Expires", "-1");
				out.write(data);
			}
		} catch( Exception e ) {
			e.printStackTrace();
			out.println(e.toString());
		}
	}
	*/
	
 
	
	@ResponseBody
	@RequestMapping(value = "/file_select_nopage", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String file_select_nopage(@ModelAttribute SYFileVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.file_select_nopage() is called.");
		List<SYFileVo> listCode = null;
		listCode = syFileService.selectFile_nopage(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,	listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/file_select", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String file_select(@ModelAttribute SYFileVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.file_select() is called.");
		List<SYFileVo> listCode = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			listCode = syFileService.selectFile(sVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response,listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/delFlagFile", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String delFlagFile(@ModelAttribute SYFileVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.file_select() is called.");
		List<SYFileVo> listCode = null;
		// sYprodService.insertSapProdOrd();
		sVo.setUpdater(SessionUtil.getMemberId(request));
		int result = syFileService.delFlagFile(sVo);
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response,	listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}

		return resultData.toJSONString();
	}
	
	 
	
	@ResponseBody
	@RequestMapping(value = "/delete_file", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteFile(@ModelAttribute SYFileVo fileVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FileController.deleteFile() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try{
			fileVo.setCreator(SessionUtil.getMemberId(request));
			fileVo.setUpdater(SessionUtil.getMemberId(request));
			fileVo.setFile_del_yn("Y");
			result = syFileService.deleteFile(fileVo);
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@RequestMapping(value = "/editor_attach_download", method = RequestMethod.GET)
	public ModelAndView EditorDown(@RequestParam("file_path") String file_path, @RequestParam("file_name") String file_name) {
		ModelAndView returnMV = new ModelAndView();
		returnMV.setViewName("download");
		returnMV.addObject("file_path", fsResource.getPath() + file_path);
		returnMV.addObject("file_name", file_name);
		return returnMV; 
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/editor_file_upload", produces="text/html;charset=UTF-8")
	@SuppressWarnings("rawtypes")
	public String goEditorFileUpload(@ModelAttribute SYFileVo fVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FileController.goEditorImgUpload() is called. ");
		String file_path = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
		MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
		if(map != null) {
			Iterator iter = map.keySet().iterator();
			while(iter.hasNext()) {
				SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
				SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
				SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
				String yyyy= formatter_yyyy.format(new java.util.Date());
				String mm= formatter_mm.format(new java.util.Date());
				String dd= formatter_dd.format(new java.util.Date());
				UUID uid = UUID.randomUUID();
				
				logger.debug("flow log : fsResource.getPath() : " + fsResource.getPath());
				String strDir = fsResource.getPath() +"/editor_file/"+yyyy+"/"+mm+"/"+dd+"/";
				File d = new File(strDir);
				if(!d.isDirectory()) {
					d.mkdirs();
				}
				
				String str = (String) iter.next();
				List<MultipartFile> fileList =  map.get(str);
				for(MultipartFile mpf : fileList) {
					String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());
					String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
					File localFile = new File(strDir + "_"+uid+"."+fileExt);
					OutputStream out = new FileOutputStream(localFile);
					out.write(mpf.getBytes());
					out.close();
					
					fVo.setFile_repo("1");
					fVo.setFile_cate("editor_file");
					fVo.setFile_path(yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
					fVo.setFile_name(filename);
					fVo.setFile_ext(fileExt);
					fVo.setFile_del_yn("N");
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));
					// fileService.insertFile(fVo);
					file_path = "/upload/"+fVo.getFile_cate()+"/"+fVo.getFile_path();
					logger.debug("flow log : file_path : " + file_path);
				}
			}
		}
		String ckeditorFuncNum = request.getParameter("CKEditorFuncNum");
		request.setAttribute("ckeditorFuncNum", ckeditorFuncNum);
		request.setAttribute("urlfile", "/" + file_path);
		return "manager/sitemap/data/editor_callback";
	}
	
	
	//was에 저장된 이미지파일 갖고오기
	@RequestMapping(value = "/get_img", method = RequestMethod.GET)
	  public ModelAndView get_img(@RequestParam("file_path") String file_path, @RequestParam("file_name") String file_name) {
			System.out.println("###############################################");
			System.out.println("file_path :: " + file_path);
			System.out.println("file_name :: " + file_name);
			System.out.println("fsResource.getPath() :: " + fsResource.getPath());
			ModelAndView returnMV = new ModelAndView();
			returnMV.setViewName("download");
			returnMV.addObject("file_path", fsResource.getPath() +"/" + file_path);
			returnMV.addObject("file_name", file_name);
		  return returnMV; 
	  }
	
		
	@RequestMapping(value = "/chn_mng_download", method = RequestMethod.GET)
	public ModelAndView chn_mng_download(@RequestParam("file_group") String file_group) {
			ModelAndView returnMV = new ModelAndView();
			returnMV.setViewName("download");
			
			SYFileVo vo = new SYFileVo();
			vo.setFile_group(file_group);
			List<SYFileVo> listCode = syFileService.selectFile_nopage(vo);
			
			String file_name = "";
			String file_path = "";
			
			for(int i=0 ;i<listCode.size(); i++)
			{
				file_path = listCode.get(i).getFile_path();
				file_name = listCode.get(i).getFile_name();
			}
			
			
			try {
				returnMV.addObject("file_path", fsResource.getPath() +"/" + file_path);
				returnMV.addObject("file_name", URLDecoder.decode(file_name, "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

		  return returnMV; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// jyp
		@ResponseBody
		@RequestMapping(value="/selectFileClass", method= { RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		public String selectFile (@ModelAttribute SYFileVo vo, HttpServletRequest request, HttpServletResponse response ,HttpSession session) {
			logger.debug("FrontendController.selectFileClass() is called.");

			JSONParser jsonParser = new JSONParser();
			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			try {
				List<SYFileVo> dataList = syFileService.selectFileClass(vo);
				
				String listDataJsonString = ResponseUtils.getJsonResponse(response,
						dataList);
				listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", listDataJArray);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", null);
			}

			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value="/insFileClass", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
		public String insFileClass(@ModelAttribute SYFileVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("Filecontroller.insFileClass() is called");
			JSONObject resultData = new JSONObject();
			try {
				int result = 0;
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				result = syFileService.insFileClass(vo);
				resultData.put("status", HttpStatus.OK);
				resultData.put("data", result);
				
			} catch(Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value="/updFileClass", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
		public String updFileClass(@ModelAttribute SYFileVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("Filecontroller.updFileClass() is called");
			JSONObject resultData = new JSONObject();
			try {
				int result = 0;
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				result = syFileService.updFileClass(vo);
				resultData.put("status", HttpStatus.OK);
				resultData.put("data", result);
				
			} catch(Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@Transactional
		@RequestMapping(value="/delFileClass", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		public String delFileClass(HttpServletRequest request, HttpServletResponse response) {
			logger.debug("InfoController.delFileClass is called.");
			
			SYFileVo vo = new SYFileVo();
			Map<String, Object> params = new HashMap<>();
			String[] keyCols = {"file_class_code"};
			JSONObject resultData = new JSONObject();
			int cnt = 0;
			try {
				StringUtil.getArrayParams(params, request, vo, keyCols);
				params.put("creator", SessionUtil.getMemberId(request));
				params.put("updater", SessionUtil.getMemberId(request));
				syFileService.delFileByClass(params);
				syFileService.delFileTypeByClass(params);
				cnt = syFileService.delFileClass(params);
				
				
				resultData.put("status", HttpStatus.OK.value());
				
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
			logger.debug(resultData.toJSONString());
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value="/selectFileType", method= { RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		public String selectFileType (@ModelAttribute SYFileVo vo, HttpServletRequest request, HttpServletResponse response ,HttpSession session) {
			logger.debug("FrontendController.selectFileType() is called.");

			JSONParser jsonParser = new JSONParser();
			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			try {
				List<SYFileVo> dataList = syFileService.selectFileType(vo);
				
				String listDataJsonString = ResponseUtils.getJsonResponse(response,
						dataList);
				listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", listDataJArray);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", null);
			}

			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value="/insFileType", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
		public String insFileType(@ModelAttribute SYFileVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("Filecontroller.insFileType() is called");
			JSONObject resultData = new JSONObject();
			try {
				int result = 0;
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				result = syFileService.insFileType(vo);
				resultData.put("status", HttpStatus.OK);
				resultData.put("data", result);
				
			} catch(Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value="/updFileType", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
		public String updFileType(@ModelAttribute SYFileVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("Filecontroller.updFileType() is called");
			JSONObject resultData = new JSONObject();
			try {
				int result = 0;
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				result = syFileService.updFileType(vo);
				resultData.put("status", HttpStatus.OK);
				resultData.put("data", result);
				
			} catch(Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@Transactional
		@RequestMapping(value="/delFileType", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		public String delFileType(HttpServletRequest request, HttpServletResponse response) {
			logger.debug("InfoController.delFileType is called.");
			
			SYFileVo vo = new SYFileVo();
			Map<String, Object> params = new HashMap<>();
			String[] keyCols = {"file_type_code"};
			JSONObject resultData = new JSONObject();
			int cnt = 0;
			try {
				StringUtil.getArrayParams(params, request, vo, keyCols);
				params.put("creator", SessionUtil.getMemberId(request));
				params.put("updater", SessionUtil.getMemberId(request));
				syFileService.delFileByType(params);
				cnt = syFileService.delFileType(params);
				
				resultData.put("status", HttpStatus.OK.value());
				
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
			logger.debug(resultData.toJSONString());
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value="/delFileInfo", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		public String delFileInfo(HttpServletRequest request, HttpServletResponse response) {
			logger.debug("InfoController.delFileType is called.");
			
			SYFileVo vo = new SYFileVo();
			Map<String, Object> params = new HashMap<>();
			String[] keyCols = {"file_group", "file_no"};
			JSONObject resultData = new JSONObject();
			int cnt = 0;
			try {
				StringUtil.getArrayParams(params, request, vo, keyCols);
				params.put("creator", SessionUtil.getMemberId(request));
				params.put("updater", SessionUtil.getMemberId(request));
				cnt = syFileService.delFileInfo(params);
				
				resultData.put("status", HttpStatus.OK.value());
				
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
			logger.debug(resultData.toJSONString());
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value="/updFileInfo", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
		public String updFileInfo(@ModelAttribute SYFileVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("Filecontroller.updFileInfo() is called");
			JSONObject resultData = new JSONObject();
			try {
				int result = 0;
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				result = syFileService.updFileInfo(vo);
				resultData.put("status", HttpStatus.OK);
				resultData.put("data", result);
				
			} catch(Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return resultData.toJSONString();
		}
		
		
		//prod_mng
		//file_upload
		@ResponseBody
		@RequestMapping(method = RequestMethod.POST, value = "/file_upload", produces="text/html;charset=UTF-8")
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public String file_upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
			logger.info("FileController.file_upload() is called. ");
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
		    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
		    		
		    
		    String fileClassCode = request.getParameter("file_class_code");
		    String fileTypeCode = request.getParameter("file_type_code");
		    String fileClass = request.getParameter("file_class");
		    String fileType = request.getParameter("file_type");
		    String revno = request.getParameter("file_rev_no");
		    String fileComment = request.getParameter("file_comment");
		    String mode = request.getParameter("mode");
		    String fileName = request.getParameter("file_name");
		    String inputFileName = request.getParameter("input_file_name");
		    String inputRevNo = request.getParameter("input_rev_no");
		    String nFileComment = "";
		    String nFileRevNo = "";
		    String file_group ="";
		    String file_no = "";
		    String inputDate = request.getParameter("input_date");
		    String nInputDate = "";
		    if("upd".equals(mode)) {
		    	nFileComment = request.getParameter("file_new_comment");
		    	nFileRevNo = request.getParameter("file_new_rev_no");
		    	file_group  = request.getParameter("file_group");
		    	file_no = request.getParameter("file_no");
		    	nInputDate = request.getParameter("input_new_date");
		    }
		   
		    
		    JSONObject resultData = new JSONObject();
		    JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			
			if(map != null) {
				Iterator iter = map.keySet().iterator();
				while(iter.hasNext()) {
					SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
					SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
					SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
					String yyyy= formatter_yyyy.format(new java.util.Date());
					String mm= formatter_mm.format(new java.util.Date());
					String dd= formatter_dd.format(new java.util.Date());
					
					UUID uid = UUID.randomUUID();

					String strDir = fsResource.getPath() +"/"+ fileClassCode +"/"+yyyy+"/"+mm+"/"+dd+"/";
					File d = new File(strDir);
									
					if(!d.isDirectory()) {
						d.mkdirs();
					}
					
					String str = (String) iter.next();
					List<MultipartFile> fileList =  map.get(str);
					
					List<SYFileVo> returnList = new ArrayList<SYFileVo>();
					
					for(MultipartFile mpf : fileList) {
					try {	
							String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());
							String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
							File localFile = new File(strDir + "_"+uid+"."+fileExt);
							
							OutputStream out = new FileOutputStream(localFile);
							out.write(mpf.getBytes());
							out.close();
							
							// DB에서 정보 저장하기 위한/
							SYFileVo fVo = new SYFileVo();
							if(file_group == null || file_group.equals("")){
								file_group = syFileService.selectFileKey();
								fVo.setFile_group(file_group);
							} else {
								fVo.setFile_group(file_group);
							}
							
							fVo.setFile_class_code(fileClassCode);
							fVo.setFile_class(fileClass);
							fVo.setFile_type_code(fileTypeCode);
							fVo.setFile_type(fileType);
							fVo.setFile_rev_no(revno);
							fVo.setInput_rev_no(inputRevNo);
							fVo.setInput_file_name(inputFileName);
							fVo.setFile_comment(fileComment);
							fVo.setInput_date(inputDate);
							
							
							if("upd".equals(mode)) {
								fVo.setFile_new_comment(nFileComment);
								fVo.setFile_new_rev_no(nFileRevNo);
								fVo.setInput_new_date(nInputDate);
							}
							
							
							fVo.setFile_repo("1");
							fVo.setFile_path(fileClassCode +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
							fVo.setFile_name(filename);
							fVo.setFile_ext(fileExt);
							fVo.setFile_del_yn("N");
							fVo.setFile_size((localFile.length() / 1024));
							fVo.setCreator_nm(SessionUtil.getMemberNm(request));
							fVo.setCreator(SessionUtil.getMemberId(request));
							fVo.setUpdater(SessionUtil.getMemberId(request));
							fVo.setFile_no(file_no);
							
							if("upd".equals(mode)) {
								SYFileVo updFileInfo = new SYFileVo();
								updFileInfo.setFile_final_yn("N");
								updFileInfo.setFile_group(fVo.getFile_group());
								updFileInfo.setFile_no(fVo.getFile_no());
								updFileInfo.setUpdater(SessionUtil.getMemberId(request));
								syFileService.updFileInfo(updFileInfo);
								
								fVo.setFile_final_yn("Y");
								syFileService.insNewFileInfo(fVo);
							}
							else if("ins".equals(mode)) {
								syFileService.insFileInfo(fVo);
							}
							
//							SYFileVo resultVo = new SYFileVo();
//							
//							resultVo.setFile_group(fVo.getFile_group());
//							resultVo.setFile_path(fVo.getFile_path());
//							resultVo.setFile_name(fVo.getFile_name());
//							
//							returnList.add(resultVo);
//						
//							String listDataJsonString = ResponseUtils.getJsonResponse(response, returnList);
//							listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
//							resultData.put("status", HttpStatus.OK.value());
//							resultData.put("rows", listDataJArray);
						 
							
							
			 			} catch(Exception e) {
				 			e.printStackTrace();
				 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				 			resultData.put("rows", null);
			 			} finally {
			 			}
					}
				}
			}
			return resultData.toJSONString();
		}
		
		
		//prod_mng
		//file_upload
		@ResponseBody
		@RequestMapping(method = RequestMethod.POST, value = "/repairReport/{reportCode}", produces="text/html;charset=UTF-8")
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public String repairReport_upload(HttpServletRequest request, HttpServletResponse response , @PathVariable String reportCode) throws Exception {
			logger.info("FileController.repairReport_upload() is called. ("+reportCode+")");
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
		    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
		    		
		    String file_group = request.getParameter("file_group");
		    String matnr = request.getParameter("matnr");
		    String file_cate = request.getParameter("file_repo");
		    String procDate = request.getParameter("proc_date");
		    String proManager = request.getParameter("proc_manager_nm");
		    String repairNum = request.getParameter("repair_num");
		    String proc2_outsourcing_price = request.getParameter("proc2_outsourcing_price");
		    String fileRepo = reportCode;
		    
		    JSONObject resultData = new JSONObject();
		    JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			
			if(map != null) {
				Iterator iter = map.keySet().iterator();
				while(iter.hasNext()) {
					SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
					SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
					SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
					String yyyy= formatter_yyyy.format(new java.util.Date());
					String mm= formatter_mm.format(new java.util.Date());
					String dd= formatter_dd.format(new java.util.Date());
					
					UUID uid = UUID.randomUUID();

					String strDir = fsResource.getPath() +"/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
					File d = new File(strDir);
									
					if(!d.isDirectory()) {
						d.mkdirs();
					}
					
					String str = (String) iter.next();
					List<MultipartFile> fileList =  map.get(str);
					
					List<SYFileVo> returnList = new ArrayList<SYFileVo>();
					
					for(MultipartFile mpf : fileList) {
					try {	
							String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());
							String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
							File localFile = new File(strDir + "_"+uid+"."+fileExt);
							
							OutputStream out = new FileOutputStream(localFile);
							out.write(mpf.getBytes());
							out.close();
							
							// DB에서 정보 저장하기 위한/
							SYFileVo fVo = new SYFileVo();
							if(file_group == null || file_group.equals("")){
								file_group = syFileService.selectRepairFileKey();
								fVo.setFile_group(file_group);
							} else {
								fVo.setFile_group(file_group);
							}
							fVo.setFile_repo(fileRepo);
							fVo.setMatnr(matnr);
							fVo.setFile_cate(file_cate);
							fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
							fVo.setFile_name(filename);
							fVo.setFile_ext(fileExt);
							fVo.setFile_del_yn("N");
							fVo.setFile_size((localFile.length() / 1024));
							fVo.setCreator(SessionUtil.getMemberId(request));
							fVo.setUpdater(SessionUtil.getMemberId(request));
							syFileService.insRepairReportFile(fVo);
							
//							SYFileVo resultVo = new SYFileVo();
//							
//							resultVo.setFile_group(fVo.getFile_group());
//							resultVo.setFile_path(fVo.getFile_path());
//							resultVo.setFile_name(fVo.getFile_name());
//							
//							returnList.add(resultVo);
//						
//							String listDataJsonString = ResponseUtils.getJsonResponse(response, returnList);
//							listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
//							resultData.put("status", HttpStatus.OK.value());
//							resultData.put("rows", listDataJArray);
							
							
							
							// ins repair report info
							
							SYRepairVo rvo = new SYRepairVo();
							rvo.setRepair_num(repairNum);
							
							switch (reportCode) {
							case "MD1271":
								rvo.setProc1_code(reportCode);
								rvo.setProc1_date(procDate);
								rvo.setProc1_manager_nm(proManager);
								rvo.setProc1_file_group(fVo.getFile_group());
								break;
							case "MD1272":
								rvo.setProc2_code(reportCode);
								rvo.setProc2_date(procDate);
								rvo.setProc2_manager_nm(proManager);
								rvo.setProc2_file_group(fVo.getFile_group());
								rvo.setProc2_outsourcing_price(proc2_outsourcing_price);
								break;
							case "MD1273":
								rvo.setProc3_code(reportCode);
								rvo.setProc3_date(procDate);
								rvo.setProc3_manager_nm(proManager);
								rvo.setProc3_file_group(fVo.getFile_group());
								break;
							case "MD1274":
								rvo.setProc4_code(reportCode);
								rvo.setProc4_date(procDate);
								rvo.setProc4_manager_nm(proManager);
								rvo.setProc4_file_group(fVo.getFile_group());
								break;
							case "MD1275":
								rvo.setProc5_code(reportCode);
								rvo.setProc5_date(procDate);
								rvo.setProc5_manager_nm(proManager);
								rvo.setProc5_file_group(fVo.getFile_group());
								break;
							case "MD1276":
								rvo.setProc6_code(reportCode);
								rvo.setProc6_date(procDate);
								rvo.setProc6_manager_nm(proManager);
								rvo.setProc6_file_group(fVo.getFile_group());
								break;
							default :
								throw new Exception("no parameter....");
							}
							rvo.setUpdater(SessionUtil.getMemberId(request));
							syOverHaulService.insRepairReportFile(rvo);
						 
							
							logger.debug("flow log : listDataJArray : "  + listDataJArray);
							
			 			} catch(Exception e) {
				 			e.printStackTrace();
				 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				 			resultData.put("rows", null);
			 			} finally {
//			 				if(fis != null) fis.close();
//			 				if(wb != null) wb.close();
			 			}
					}
				}
			}
			return resultData.toJSONString();
		}
	
		@ResponseBody
		@RequestMapping(value = "/delete_repair_file/{reportCode}", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String deleteRepairFile(@ModelAttribute SYFileVo fileVo, HttpServletRequest request, HttpServletResponse response, HttpSession session, @PathVariable String reportCode) {
			logger.debug("FileController.deleteRepairFile() is called. (" + reportCode + ")");
			JSONObject resultData = new JSONObject();
			int result = 0;
			try{
				fileVo.setCreator(SessionUtil.getMemberId(request));
				fileVo.setUpdater(SessionUtil.getMemberId(request));
				fileVo.setFile_del_yn("Y");
				result = syFileService.deleteRepairFile(fileVo);
				if (result < 0) {
					resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				} else {
					
					String repairNum = request.getParameter("repair_num");
					
					SYRepairVo rvo = new SYRepairVo();
					rvo.setRepair_num(repairNum);
					rvo.setReport_code(reportCode);
					
					
					syOverHaulService.delRepairReportFile(rvo);
					
					resultData.put("status", HttpStatus.OK.value());
				}
			} catch(Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
			return resultData.toJSONString();
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//
	
}