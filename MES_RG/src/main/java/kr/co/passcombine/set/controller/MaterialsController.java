package kr.co.passcombine.set.controller;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.passcombine.set.svc.SYGoalService;
import kr.co.passcombine.set.svc.SYInfoService;
import kr.co.passcombine.set.svc.SYMaterialService;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.fileUpload;
@Controller
@RequestMapping("/materials")
public class MaterialsController {
	private static final Logger logger = LoggerFactory.getLogger(MaterialsController.class);
	@Resource(name = "setMateriaService")
	SYMaterialService sYMaterialService;

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

	
}


