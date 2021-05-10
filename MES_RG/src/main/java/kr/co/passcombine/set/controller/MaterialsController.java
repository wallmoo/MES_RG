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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.passcombine.set.svc.SYGoalService;
import kr.co.passcombine.set.svc.SYInfoService;
import kr.co.passcombine.set.svc.SYMaterialService;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.fileUpload;
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

			
			//파일 업로드를 위한 준비
			OutputStream out = null;
			PrintWriter printWriter = null;
			MultipartFile fileList = (request).getFile("file[]");
			String basePath="/upload";
			System.out.println("패스는 "+basePath+"\n\n\n\n");
			
			Map<String, Object> file = fileUpload.saveFile(fileList, basePath, request);
			if(!file.isEmpty()) {
			file.put("CMM_FLE_TB_TYPE","A");//파일 종류를 넣는곳인데 뭔지모르겠으므로 보류
			file.put("CMM_FLE_REG_ID",SessionUtil.getMemberId(request));
			}
			
			//기본DAO셋팅
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

		// insertEstimate/update도 포함 
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
				//현재 거래처는 4개이므로 4번까지돌도록함
				for(int j=0; j<vo.size(); j++) {
					for(int i=0; i<4;i++) {
						Map<String, Object> valueMap = new HashMap();
						//초기화하지않으면 계속 같은값이 들어감.
						valueMap.putAll(vo.get(j));
						//a = b로하면 메모리가 같아져서 같은값이 들어감
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
					result = sYInfoServices.insertEstimate(valueList);//자재요청내역 저장
				}else {
					result = sYMaterialService.UpdateEstimate(vo);//자재요청내역 저장
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
		
		// change BOM Material Quantity
		@ResponseBody
		@RequestMapping(value = "/materials/updateBomQuantity", method = { RequestMethod.GET,
				RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String updateBomQuantity(@RequestParam Map<String,Object> vo, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.changeBOMQuantity is called.");

			JSONObject resultData = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			JSONParser parser = new JSONParser();
			String REG_ID = SessionUtil.getMemberId(request);
			vo.put("REG_ID",REG_ID);

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
	
}