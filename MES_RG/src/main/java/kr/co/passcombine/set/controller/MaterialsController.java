package kr.co.passcombine.set.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.passcombine.set.svc.SYGoalService;
import kr.co.passcombine.set.svc.SYInfoService;
import kr.co.passcombine.set.svc.SYMaterialService;
import kr.co.passcombine.set.util.PdfPage;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.fileUpload;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYTBomVo;
import kr.co.passcombine.set.vo.SYTMaterialVo;
@Controller
@RequestMapping("/materials")
public class MaterialsController {
	private static final Logger logger = LoggerFactory.getLogger(MaterialsController.class);
	@Resource(name = "setMateriaService")
	SYMaterialService sYMaterialService;
	

	@Resource(name = "setInfoService")
	SYInfoService sYInfoServices;


	// saveMaterial
		@ResponseBody
		@RequestMapping(value = "/account/saveMaterial", method = { RequestMethod.GET,
				RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String saveMaterial(@RequestParam Map<String,Object> vo, MultipartHttpServletRequest request,
				HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.saveAccount is called.");

			
			//?????? ???????????? ?????? ??????
			OutputStream out = null;
			PrintWriter printWriter = null;
			MultipartFile fileList = (request).getFile("file[]");
			String basePath="/upload";
			System.out.println("????????? "+basePath+"\n\n\n\n");
			
			Map<String, Object> file = fileUpload.saveFile(fileList, basePath, request);
			if(!file.isEmpty()) {
			file.put("CMM_FLE_TB_TYPE","A");//?????? ????????? ??????????????? ???????????????????????? ??????
			file.put("CMM_FLE_REG_ID",SessionUtil.getMemberId(request));
			}
			
			//??????DAO??????
			vo.put("MTL_REG_ID",SessionUtil.getMemberId(request));
			vo.put("REG_ID",SessionUtil.getMemberId(request));
			
			JSONObject resultData = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			JSONParser parser = new JSONParser();

			try {
				String MTL_IDX = "";
				int cnt = 0;

					cnt = sYMaterialService.insertMaterial2(vo,file);

					System.out.println("MTL_IDX = " + MTL_IDX);
	
					System.out.println("cnt = " + cnt);
	
					resultData.put("status", HttpStatus.OK.value());

			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}

			return resultData.toJSONString();
		}

		// insertEstimate/update??? ?????? 
		@ResponseBody
		@RequestMapping(value = "/info/insertEstimate", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public int insertEstimate(HttpServletRequest request, @RequestParam String jsonData) {
			List<Map<String, Object>> vo = null;

			logger.debug("FrontendController.insertEstimate is called." + request.getParameter("S_VDR_IDX1"));

			String REG_ID = SessionUtil.getMemberId(request);

			ObjectMapper mapper = new ObjectMapper();
			TypeReference<List<HashMap<String, Object>>> typeRef = new TypeReference<List<HashMap<String, Object>>>() { };
			List<Map<String,Object>> valueList = new ArrayList<Map<String,Object>>();
			try {
				vo = mapper.readValue(jsonData, typeRef);
				for (int i = 0; i < vo.size(); i++) {
					vo.get(i).put("REG_ID", REG_ID);
				}
				//?????? ???????????? 4???????????? 4?????????????????????
				for(int j=0; j<vo.size(); j++) {
					for(int i=0; i<4;i++) {
						Map<String, Object> valueMap = new HashMap();
						//???????????????????????? ?????? ???????????? ?????????.
						valueMap.putAll(vo.get(j));
						//a = b????????? ???????????? ???????????? ???????????? ?????????
						if(valueMap.containsKey("S_VDR_IDX"+i)) {
							if(!"ALL".equals((String)valueMap.get("S_VDR_IDX"+i))){
								valueMap.put("VDR_IDX",valueMap.get("S_VDR_IDX"+i));
								valueList.add(valueMap);
							}
						}
					}
				}
							
				System.out.println("Dd");
			} catch (IOException e1) {
				System.out.println(e1);
				e1.printStackTrace();
			}

			
			int result = 0;
			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {
				String flag = (String)vo.get(0).get("flag");
				if(flag.equals("I")) {
					result = sYInfoServices.insertEstimate(valueList);//?????????????????? ??????
				}else {
					result = sYMaterialService.UpdateEstimate(vo);//?????????????????? ??????
				}
				
				} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", null);
			}
			
			return result;
		}
		
		
		@ResponseBody
		@RequestMapping(value = "/materials/selectMaterial", method = { RequestMethod.GET,
				RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String materialsselectMaterial(@RequestParam Map<String,Object> vo, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.selectMaterial is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {
				// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );
				String REG_ID = SessionUtil.getMemberId(request);
				vo.put("REG_ID",REG_ID);
				List<Map<String,Object>> dataList = sYMaterialService.selectMaterials(vo);

				System.out.println("dataList");
				System.out.println(dataList);

				String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
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
		
		// change BOM Material Quantity > ?????? ??????
		@ResponseBody
		@RequestMapping(value = "/materials/updateBomQuantity", method = { RequestMethod.GET,
				RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String updateBomQuantity(@RequestParam Map<String,Object> vo, MultipartHttpServletRequest request,
				HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.changeBOMQuantity is called.");

			JSONObject resultData = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			JSONParser parser = new JSONParser();
			String REG_ID = SessionUtil.getMemberId(request);
			vo.put("REG_ID",REG_ID);
			vo.put("MTL_IDX",vo.get("hidden_MTLIDX"));
			vo.put("WHS_HIS_QTY",vo.get("COUNTT"));
			vo.put("MTL_BG",vo.get("TEXT_BG"));
			
			String flag = (String)vo.get("flag");
			if(flag.equals("I")) {
				vo.put("WHS_HIS_GB","IN");
			}else {
				vo.put("WHS_HIS_GB","OUT");
			}

			int cnt=0;
			try {
				cnt = sYMaterialService.updateEstimateOs(vo);

				resultData.put("status", HttpStatus.OK.value());

			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}

			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value = "/print", method = { RequestMethod.GET,
				RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public ModelAndView print(@RequestParam Map<String,Object> vo,
				HttpServletRequest request,
				HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.changeBOMQuantity is called.");
			/*
			PdfPage.PDFTEMP(request);
			return ""*/
			ModelAndView mav = new ModelAndView();
			Map<String,Object> base = sYMaterialService.base_info(vo);
			List<Map<String,Object>> dataList = sYMaterialService.info_List_project(vo);
			
			mav.addObject("BASE",base);
			mav.addObject("DATALIST",dataList);
			mav.setViewName("/common/pdf_Temp2");
			return mav;
		}
}