package kr.co.passcombine.set.controller;

import java.lang.reflect.Method;
import java.net.URLDecoder;
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
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.passcombine.set.svc.SYGoalService;
import kr.co.passcombine.set.svc.SYInfoService;
import kr.co.passcombine.set.svc.SYProductService;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.StringUtil;
import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYDeliveryOrderVo;
import kr.co.passcombine.set.vo.SYGoalVo;
import kr.co.passcombine.set.vo.SYIncome_insp_mstVo;
import kr.co.passcombine.set.vo.SYIncome_resultVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYInspectionMasterVo;
import kr.co.passcombine.set.vo.SYInstrumentVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYMemberVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYPrintVO;
import kr.co.passcombine.set.vo.SYProduct2Vo;
import kr.co.passcombine.set.vo.SYProductOperStatusVO;
import kr.co.passcombine.set.vo.SYProductUnOperationVO;
import kr.co.passcombine.set.vo.SYQualityVo;
import kr.co.passcombine.set.vo.SYRepairVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYWarehouseOutVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterHVo;
import kr.co.passcombine.set.vo.SYtool_repmt_hisVo;
import kr.co.passcombine.set.vo.SYHoldVo;
 

//

@Controller
@RequestMapping("/info")
public class InfoController {
	private static final Logger logger = LoggerFactory
			.getLogger(InfoController.class);

	@Resource(name = "setInfoService")
	SYInfoService sYInfoService;
	
	@Resource(name = "setGoalService")
	SYGoalService sYGoalService;
	
	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView infoMenuNavigation(@PathVariable String menu_div,
			@PathVariable String menu_page, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.infoMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("info/" + menu_div + "/" + menu_page);

		return modelAndView;
	}
	
	
	// selectCdD
	@ResponseBody
	@RequestMapping(value = "/codeDetail/selectCdD", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCdD(@ModelAttribute SYCustomerVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectCdD is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYCustomerVo> dataList = sYInfoService.selectCdD(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// selectCdD
	@ResponseBody
	@RequestMapping(value = "/codeDetail/selectCdD_csmb", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCdD_csmb(@ModelAttribute SYCustomerVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectCdD_csmb is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYCustomerVo> dataList = sYInfoService.selectCdD_csmb(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// checkCustomer
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/customer/checkCustomer", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkCustomer(@ModelAttribute SYCustomerVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkCustomer() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkCustomer(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
    // selectCustomer
	@ResponseBody
	@RequestMapping(value = "/customer/selectCustomer", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCustomer(@ModelAttribute SYCustomerVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectCustomer is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYCustomerVo> dataList = sYInfoService.selectCustomer(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
		
		
	// saveCustomer
	@ResponseBody
	@RequestMapping(value = "/customer/saveCustomer", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveCustomer(@ModelAttribute SYCustomerVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveCustomer is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String customer_code = "";
			int cnt = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
				cnt = sYInfoService.insertCustomer(vo);
			} else if (flag.equals("U")) {
				customer_code = request.getParameter("customer_code");

				// hKey
				vo.setCustomer_code(customer_code);
				
				cnt = sYInfoService.updateCustomer(vo);
			}

			System.out.println("customer_code = " + customer_code);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
			
	// deleteCustomer
	@ResponseBody
	@RequestMapping(value = "/customer/deleteCustomer", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteCustomer(@ModelAttribute SYCustomerVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteCustomer() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteCustomer(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	// checkAccount
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/checkAccount", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkAccount(@ModelAttribute SYAccountVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkAccount() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkAccount(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	// selectAccount
	@ResponseBody
	@RequestMapping(value = "/account/selectAccount", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectAccount(@ModelAttribute SYAccountVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectAccount is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYAccountVo> dataList = sYInfoService.selectAccount(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
			
			
	// saveAccount
	@ResponseBody
	@RequestMapping(value = "/account/saveAccount", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveAccount(@ModelAttribute SYAccountVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveAccount is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String account_code = "";
			int cnt = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
//									account_code = sYInfoService.accountCdGen();
//
//									// hKey
//									vo.setAccount_code(account_code);
				
				cnt = sYInfoService.insertAccount(vo);
			} else if (flag.equals("U")) {
				account_code = request.getParameter("account_code");

				// hKey
				vo.setAccount_code(account_code);
				
				cnt = sYInfoService.updateAccount(vo);
			}

			System.out.println("account_code = " + account_code);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
					
	// deleteAccount
	@ResponseBody
	@RequestMapping(value = "/account/deleteAccount", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteAccount(@ModelAttribute SYAccountVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteAccount(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	
	// cw
	@ResponseBody
	@RequestMapping(value="/partition/selectPartition2" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=UTF-8")
	public String selectPartition2 (@ModelAttribute SYPartitionVO vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.selectPartition2() is called.");
		
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPartitionVO> dataList = sYInfoService.selectPartition2(vo);

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
	////////
	
	// jyp
	@ResponseBody
	@RequestMapping(value="/partition/selectPartition" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> selectPartition (@ModelAttribute SYPartitionVO vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.selectPartition() is called.");
		
		ResponseEntity<String> result = null;
		
		try {
			List<SYPartitionVO> dataList = sYInfoService.selectPartition(vo);
			
			result = ResponseUtils.getJSONResponse("success", dataList, HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}
		
		return result;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/partition/insPartition", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ResponseEntity<String> insPartition(@ModelAttribute SYPartitionVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		logger.debug("InfoController.insPartition() is called.");
		
		ResponseEntity<String> result = null;
		int cnt = 0;
		try {
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt = sYInfoService.insPartition(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch(Exception e) {
			logger.debug("error");
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/partition/updPartition", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ResponseEntity<String> updPartition(@ModelAttribute SYPartitionVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		logger.debug("InfoController.updPartition() is called.");
		
		ResponseEntity<String> result = null;
		int cnt = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt = sYInfoService.updPartition(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/partition/delPartition", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ResponseEntity<String> delPartition (@ModelAttribute SYPartitionVO vo , HttpServletRequest request, HttpServletResponse response, HttpSession session){
		logger.debug("InfoController.delPartition() is called.");
		ResponseEntity<String> result= null;
		int cnt = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt =  sYInfoService.updPartition(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}
		
		return result;
		
	}
	

	@ResponseBody
	@RequestMapping(value="/partition/delPartitionAll", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ResponseEntity<String> delPartitionAll (@ModelAttribute SYPartitionVO vo , HttpServletRequest request, HttpServletResponse response, HttpSession session){
		logger.debug("InfoController.delPartitionAll() is called.");
		ResponseEntity<String> result= null;
		int cnt = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt =  sYInfoService.delPartitionAll(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}
		
		return result;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/partition/selectPartitionList", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectPartitonList(@ModelAttribute SYPartitionVO vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectPartitionList() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPartitionVO> dataList = sYInfoService.selectPartitionList(vo);

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
	@RequestMapping(value="/partition/selectPartitionDetail", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectPartitonDetail(@ModelAttribute SYPartitionVO vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectPartitonDetail() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPartitionVO> dataList = sYInfoService.selectPartitionDetail(vo);

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
	@RequestMapping(value="/partition/insPartitionDetail", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String insPartitionDetail(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.insPartitionDetail is called.");
		
		Map<String, Object> params = new HashMap<>();
		params.put("creator", SessionUtil.getMemberId(request));
		params.put("updater", SessionUtil.getMemberId(request));
		
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		SYPartitionVO p = null;
		String methodNm = "";
		try {
			
			String paramStr = request.getParameter("param");
			logger.debug(paramStr);
			jsonArray = (JSONArray) parser.parse(paramStr); 

			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray();
			List<SYPartitionVO> lvo = new ArrayList<>();
			
			for(int i=0; i<jsonArray.size(); i++) {
			   JSONObject jObj = (JSONObject)jsonArray.get(i);
			   p = new SYPartitionVO();
			   Method[] m = p.getClass().getDeclaredMethods();
			   for(Object key : keyArr) { 
				   
			      String nKey = key.toString();
			      String nValue = "";
			      
			      if( jObj.get(nKey)==null ) 
			         continue;
			      else 
			         nValue = jObj.get(nKey).toString();
			      
			      
			      methodNm = "set".concat(nKey.substring(0,1).toUpperCase()).concat(nKey.substring(1));
			      
			      
			      for(Method mt : m) {
			    	  if(mt.getName().equals(methodNm)) {
			    		  mt.invoke(p, nValue);
			    		  break;
			    	  }
			      }
			      
			   }
			   lvo.add(p);
			}
			
			params.put("listParam", lvo);
			int cnt = 0;

			 cnt = sYInfoService.insPartitionDetail(params);
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("data", cnt);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/partition/delPartitionDetail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String delPartitionDetail(@ModelAttribute SYPartitionVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.delPartitionDetail() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.updPartitionDetail(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/machine/checkMachine", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkMachine(@ModelAttribute SYMachineVO vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkMachine() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkMachine(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/machine/selectMachine", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectMachine(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectMachine() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYMachineVO> dataList = sYInfoService.selectMachine(vo);

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
	@RequestMapping(value="/machine/insMachine", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String insMachine(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response){
		logger.debug("InfoController.insMachine() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		int cnt = 0;
		try {
			cnt = sYInfoService.insMachine(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("data", cnt);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/machine/updMachine", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String updMachine(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response){
		logger.debug("InfoController.updMachine() is called. / " + vo.getMachine_code());
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		int cnt = 0;
		try {
			cnt = sYInfoService.updMachine(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("data", cnt);

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/machine/delMachine", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String delMachine(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.delMachine is called.");
		
		SYMachineVO vo = new SYMachineVO();
		Map<String, Object> params = new HashMap<>();
		String[] keyCols = {"machine_code", "machine_nm"};
		JSONObject resultData = new JSONObject();
		int cnt = 0;
		try {
			StringUtil.getArrayParams(params, request, vo, keyCols);
			params.put("creator", SessionUtil.getMemberId(request));
			params.put("updater", SessionUtil.getMemberId(request));
			cnt = sYInfoService.delMachine(params);
			
			resultData.put("status", HttpStatus.OK.value());
			
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		logger.debug(resultData.toJSONString());
		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/machine/selectMachine_waiting", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectMachine_waiting(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectMachine_waiting() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYMachineVO> dataList = sYInfoService.selectMachine_waiting(vo);

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
	
	
	// selectMachine_class
	@ResponseBody
	@RequestMapping(value = "/machine/selectMachine_class", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMachine_class(@ModelAttribute SYMachineVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectMachine_class is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMachineVO> dataList = sYInfoService.selectMachine_class(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	
	
	
	
	
	//1113
	//machine_이름제거
	@ResponseBody
	@RequestMapping(value="/machine/selectMachine_nm", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMachine_nm(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectMachine_nm() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		
		try {
			List<SYMachineVO> dataList = sYInfoService.selectMachine_nm(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response,
					dataList);
			jsonArray = (JSONArray) parser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", jsonArray);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	// saveHold_Y hold_yn상태변경
	@ResponseBody
	@RequestMapping(value = "/machine/saveHold_Y", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_Y(@ModelAttribute SYMachineVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveHold_Y() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = sYInfoService.saveHold_Y(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	// saveHold_N hold_yn상태변경
	@ResponseBody
	@RequestMapping(value = "/machine/saveHold_N", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_N(@ModelAttribute SYMachineVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveHold_N() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			
			vo.setUpdater(SessionUtil.getMemberId(request));
			vo.setCreator(SessionUtil.getMemberId(request));

			result = sYInfoService.saveHold_N(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	// saveHold_N hold_yn상태변경
	@ResponseBody
	@RequestMapping(value = "/machine/updateHoldWaitingEnd", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateHoldWaitingEnd(@ModelAttribute SYProductUnOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateHoldWaitingEnd() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			
			vo.setUpdater(SessionUtil.getMemberId(request));
			vo.setMachine_nm(SessionUtil.getMemberId(request));
			result = sYInfoService.updateHoldWaitingEnd(vo);

			System.out.println("result = " + result);

			if(result == 999)
			{
				resultData.put("status", 777);
				resultData.put("rows", null);
			}else{
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", result);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	
	// saveHold_ALL_Y hold_yn상태변경
	@ResponseBody
	@RequestMapping(value = "/machine/saveHold_ALL_Y", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_ALL_Y(@ModelAttribute SYHoldVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveHold_ALL_Y() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = sYInfoService.saveHold_ALL_Y(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	
	// saveHold_ALL_N hold_yn상태변경
	@ResponseBody
	@RequestMapping(value = "/machine/saveHold_ALL_N", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_ALL_N(@ModelAttribute SYHoldVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveHold_ALL_N() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = sYInfoService.saveHold_ALL_N(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	
	
	// jyp
	
	// yb
	@ResponseBody
	@RequestMapping(value="/selectBomlist" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String selectBomlist (@ModelAttribute SYBomVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.selectBomlist() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int num = 0;
			List<SYBomVo> dataList = sYInfoService.selectBomlist(vo);
			List<SYBomVo> dataList2 = new ArrayList<SYBomVo>();
			for(int i = 0; dataList.size() > i ; i++) {
				if(dataList.get(i).getStufe() != 0) {
					if(dataList.get(i).getStufe() == 1) {
						num++;
						dataList2.add(dataList.get(i));
						for(int j = 0; dataList.size() > j ; j++) {
							if(dataList.get(j).getM_item_code().equals(dataList.get(i).getC_item_code())) {
								dataList2.add(dataList.get(j));
							}
						}
					}
				}else {
					dataList2.add(dataList.get(i));
				}
			}
			if(num == 0) {
				dataList2 = dataList;
			}
			String listDataJsonString = ResponseUtils.getJsonResponse(response,dataList2);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/insertBomlist" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String insertBomlist (@ModelAttribute SYBomVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.insertBomlist() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			List<SYBomVo> dataList = sYInfoService.selectBomlist(vo);
			if(dataList.size() != 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("msg", "fall");
			}else {
				int cnt = sYInfoService.insertBomlist(vo);
				if(cnt == 1) {
					resultData.put("status", HttpStatus.OK.value());
					resultData.put("msg", "success");
				}else {
					resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
					resultData.put("msg", "whatfall");
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/deleteBomlist" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String deleteBomlist (@ModelAttribute SYBomVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.deleteBomlist() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = 0;
			if(vo.getStufe() == 1) {
				SYBomVo vo2 = new SYBomVo();
				vo2.setProduct_item_code(vo.getProduct_item_code());
				vo2.setM_item_code(vo.getC_item_code());
				vo2.setBusiness_code(vo.getBusiness_code());
				cnt = sYInfoService.deleteBomlist(vo2);
			}
			if(cnt >= 0) {
				cnt = sYInfoService.deleteBomlist(vo);
			}
			if(cnt == 1) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("msg", "success");
			}else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("msg", "fall");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// yb
	
	///// sssss 
	
	// 20200925
	@ResponseBody
	@RequestMapping(value = "/print/selectPrintFI", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPrintFI(@ModelAttribute SYPrintVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPrintFI is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYPrintVO> dataList = sYInfoService.selectPrintFI(vo);
			
			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	
	// 20200922 
	@ResponseBody
	@RequestMapping(value = "/product/selectS_product2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectS_product2(@ModelAttribute SYProduct2Vo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectS_product2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			String gb = request.getParameter("gb");
			 
			List<SYProduct2Vo> dataList = new ArrayList<SYProduct2Vo>();
			if (gb.equals("i")) {
				dataList = sYInfoService.selectS_product2u(vo);
			} else if (gb.equals("u")) {
				dataList = sYInfoService.selectS_product2(vo);
			}
			
			System.out.println("dataList");
			System.out.println(dataList);
			
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
	@RequestMapping(value = "/product/selectS_product", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectS_product(@ModelAttribute SYProduct2Vo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectS_product is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			
			String gb = request.getParameter("gb");
			 System.out.println("gb="+gb);
			List<SYProduct2Vo> dataList = new ArrayList<SYProduct2Vo>();
			
			if (gb.equals("i")) {
				dataList = sYInfoService.selectS_product(vo);
			} else if (gb.equals("u")) {
				dataList = sYInfoService.selectS_productu(vo);
			}
			
			
			System.out.println("dataList");
			System.out.println(dataList);
			
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
	@RequestMapping(value = "/product/selectS_product_fail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectS_product_fail(@ModelAttribute SYProduct2Vo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectS_product_fail is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			
			String gb = request.getParameter("gb");
			 System.out.println("gb="+gb);
			List<SYProduct2Vo> dataList = new ArrayList<SYProduct2Vo>();
			
			if (gb.equals("i")) {
				dataList = sYInfoService.selectS_product_fail(vo);
			} else if (gb.equals("u")) {
				dataList = sYInfoService.selectS_productu_fail(vo);
			}
			
			
			System.out.println("dataList");
			System.out.println(dataList);
			
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
	// 20200922
	
	// jsjsjsjsjsjjs new 20200919
	// selectItemCode
	@ResponseBody
	@RequestMapping(value = "/material/selectItemCode", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemCode(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectItemCode is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMaterialVo> dataList = sYInfoService.selectItemCode(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	@RequestMapping(value = "/material/selectItemCode2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemCode2(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectItemCode2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMaterialVo> dataList = sYInfoService.selectItemCode2(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	@RequestMapping(value = "/material/selectItemCode3", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemCode3(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectItemCode3 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMaterialVo> dataList = sYInfoService.selectItemCode3(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// selectInspect_master2
		@ResponseBody
		@RequestMapping(value = "/process/selectInspection_master2", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectInspection_master2(@ModelAttribute SYInspectionMasterVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectInspection_master2 is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {
				// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
				// "UTF-8" );

				List<SYInspectionMasterVo> dataList = sYInfoService.selectInspection_master2(vo);

				System.out.println("dataList");
				System.out.println(dataList);
				
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
	
	// selectInstrumentTool
	@ResponseBody
	@RequestMapping(value = "/instrument/selectInstrumentTool", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectInstrumentTool(@ModelAttribute SYInstrumentVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectInstrumentTool is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYInstrumentVo> dataList = sYInfoService.selectInstrumentTool(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// instrument/insertInspection
	@ResponseBody
	@RequestMapping(value="/instrument/insertInspection" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String insertInspection (@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.insertInspection() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYInfoService.insertInspection(vo);
			
			System.out.println("cnt = " + cnt);

			// routing_master
			if ( cnt > 0 ) {
				vo.setQc_yn("Y");
				 cnt = sYInfoService.upRouting_mstQc_yn(vo);
			}
			
			System.out.println("22 cnt = " + cnt);
			
			resultData.put("status", HttpStatus.OK.value());
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}
	
	
	
	// insertInspection2
		@ResponseBody
		@RequestMapping(value = "/instrument/insertInspection2", method = { RequestMethod.GET,
				RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String insertInspection2(@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("InfoController.insertInspection2() is called.");

			JSONArray jsonArray = new JSONArray();
			JSONParser parser = new JSONParser();
			JSONObject resultData = new JSONObject();
			
			try {

				
				String gridData = request.getParameter("gridData");
			
				String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
				String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8" );
				
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				
				vo.setItem_code(item_code);
				vo.setRouting_code(routing_code);
				
				
				 System.out.println("gridDatagridDatagridDatagridDatagridData");
				 System.out.println(gridData);

				
				jsonArray = (JSONArray) parser.parse(gridData); // json 형변환 문자 > json
	            Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); // 첫번재 row인 얘 가져와서 key값 추출. ex gen_key, gen_name 배열타입
	            List<SYInspectionMasterVo> list = new ArrayList<SYInspectionMasterVo>(); 

				for(int i=0; i<jsonArray.size(); i++) {
					JSONObject jObj = (JSONObject)jsonArray.get(i);
					SYInspectionMasterVo dVo = new SYInspectionMasterVo();
					dVo.setCreator(SessionUtil.getMemberId(request));
					dVo.setUpdater(SessionUtil.getMemberId(request));
//						String old_rcC = "";
					
					for(Object key : keyArr) { 
						String nKey = key.toString();
						String nValue = "";
						
						if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
							continue;
						else 
							nValue = jObj.get(nKey).toString();
						
						if( "inspection_item".equals(nKey) ) dVo.setInspection_item(nValue);
						else if( "inspection_tool".equals(nKey) ) dVo.setInspection_tool(nValue);
						else if( "spec".equals(nKey) ) dVo.setSpec(nValue);
						else if( "min_spec".equals(nKey) ) dVo.setMin_spec(nValue);
						else if( "max_spec".equals(nKey) ) dVo.setMax_spec(nValue);
						
						else if( "inspection_gubun".equals(nKey) ) dVo.setInspection_gubun(nValue);
						else if( "inspection_gubun_nm".equals(nKey) ) dVo.setInspection_gubun_nm(nValue);
						
						else if( "inspection_method".equals(nKey) ) dVo.setInspection_method(nValue);
						else if( "inspection_method_nm".equals(nKey) ) dVo.setInspection_method_nm(nValue);
						}
					
					
					list.add(dVo);
				}
				
				vo.setUpdater(SessionUtil.getMemberId(request));
				int dCnt = sYInfoService.insertInspection2(list, vo);
				
				int result = 0;
				
				if ( dCnt > 0 ) {
					vo.setQc_yn("Y");
					dCnt = sYInfoService.upRouting_mstQc_yn(vo);
				}

				System.out.println("dCnt = " + dCnt);
				System.out.println("result = " + result);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", result);
			} catch(Exception e){
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", 0);
			}
			return resultData.toJSONString();
		}
		
	
	// updateInspection
	@ResponseBody
	@RequestMapping(value="/instrument/updateInspection" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String updateInspection (@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.updateInspection() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYInfoService.updateInspection(vo);
			
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}	
		
	// instrument/deleteInspection
	@ResponseBody
	@RequestMapping(value = "/instrument/deleteInspection", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteInspection(@ModelAttribute SYInspectionMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteInspection() is called.");
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteInspection(vo);

			System.out.println("result = " + result);
			
			List<SYInspectionMasterVo> dataLists = sYInfoService.selectInspection_master2(vo);
			System.out.println("dataLists.size() = " + dataLists.size());
			if ( dataLists.size() == 0 ) {
				vo.setQc_yn("N");
				result = sYInfoService.upRouting_mstQc_yn(vo);
				
				System.out.println("22 result = " + result);
			}
			

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}

	// selectRou_mstG
	@ResponseBody
	@RequestMapping(value = "/process/selectRou_mstG", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRou_mstG(@ModelAttribute SYRoutingMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectRou_mstG is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYRoutingMasterVo> dataList = sYInfoService.selectRou_mstG(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// material
	
	// checkMaterial
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/material/checkMaterial", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkMaterial(@ModelAttribute SYMaterialVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkMaterial() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkMaterial(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	// selectMaterial
	@ResponseBody
	@RequestMapping(value = "/material/selectMaterial2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterial2(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectMaterial2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMaterialVo> dataList = sYInfoService.selectMaterial2(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	// selectMaterial
	@ResponseBody
	@RequestMapping(value = "/material/selectMaterial3", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterial3(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectMaterial3 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMaterialVo> dataList = sYInfoService.selectMaterial3(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	// selectMaterial
		@ResponseBody
		@RequestMapping(value = "/material/selectMaterial", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectMaterial(@ModelAttribute SYMaterialVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectMaterial is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {
				// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
				// "UTF-8" );

				List<SYMaterialVo> dataList = sYInfoService.selectMaterial(vo);

				System.out.println("dataList");
				System.out.println(dataList);
				
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
	@RequestMapping(value = "/material/saveMaterial", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveMaterial(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveMaterial is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String item_code = "";
			int cnt = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
//							customer_code = sYInfoService.customerCdGen();
//
//							// hKey
//							vo.setCustomer_code(customer_code);
				
				cnt = sYInfoService.insertMaterial(vo);
			} else if (flag.equals("U")) {
				item_code = request.getParameter("item_code");

				// hKey
				vo.setItem_code(item_code);
				
				cnt = sYInfoService.updateMaterial(vo);
			}

			System.out.println("item_code = " + item_code);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
			
	// deleteMaterial
	@ResponseBody
	@RequestMapping(value = "/material/deleteMaterial", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteMaterial(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteMaterial() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteMaterial(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
				
	// process
	// selectRouting_master
	@ResponseBody
	@RequestMapping(value = "/process/selectRouting_master", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRouting_master(@ModelAttribute SYRoutingMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectRouting_master is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYRoutingMasterVo> dataList = sYInfoService.selectRouting_master(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	@RequestMapping(value="/selectUpdate_routing", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectUpdate_routing(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectUpdate_routing() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYRoutingMasterVo> dataList = sYInfoService.selectUpdate_routing(vo);

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
	
	
		// 성민
	// deleteCustomer
		@ResponseBody
		@RequestMapping(value = "/deleteWarehouse", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String deleteCustomer(@ModelAttribute SYWarehouseVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.deleteWarehouse() is called.");

			JSONObject resultData = new JSONObject();
			try {
				int result = 0;

				result = sYInfoService.deleteWarehouse(vo);

				System.out.println("result = " + result);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", result);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", 0);
			}
			return resultData.toJSONString();
		}
		
		
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/checkWarehouse", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkWarehouse(@ModelAttribute SYWarehouseVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkWarehouse() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkWarehouse(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/save_wh_mng", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String save_wh_mng(@ModelAttribute SYWarehouseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.save_wh_mng is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String warehouse_code = "";
			int cnt = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
				cnt = sYInfoService.insertWarehouse(vo);
			} else if (flag.equals("U")) {
				warehouse_code = request.getParameter("warehouse_code");

				// hKey
				vo.setWarehouse_code(warehouse_code);
				
				cnt = sYInfoService.updateWarehouse(vo);
			}

			System.out.println("warehouse_code = " + warehouse_code);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
   
	@ResponseBody
	@RequestMapping(value = "/select_wh_mng", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_wh_mng(@ModelAttribute SYWarehouseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.select_wh_mng is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYWarehouseVo> dataList = sYInfoService.select_wh_mng(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	
		// selectRouting_master
		@ResponseBody
		@RequestMapping(value = "/selectRouting_com_master", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectRouting_com_master(@ModelAttribute SYRoutingMasterVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectRouting_master is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {
				// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
				// "UTF-8" );

				List<SYRoutingMasterVo> dataList = sYInfoService.selectRouting_com_master(vo);

				System.out.println("dataList");
				System.out.println(dataList);
				
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
		@RequestMapping(value = "/selectRouting_com_master_2", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectRouting_com_master_2(@ModelAttribute SYRoutingMasterVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectRouting_com_master_2 is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {
				// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
				// "UTF-8" );

				List<SYRoutingMasterVo> dataList = sYInfoService.selectRouting_com_master_2(vo);

				System.out.println("dataList");
				System.out.println(dataList);
				
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
		//라우팅공통저장
		@ResponseBody
		@RequestMapping(value = "/saveRouting", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String saveRouting(@ModelAttribute SYRoutingMasterVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("InfoController.saveRouting() is called.");
			JSONArray jsonArray = new JSONArray();
			JSONParser parser = new JSONParser();
			JSONObject resultData = new JSONObject();
			try {
//		
//				String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8" );
//				String update_routing = URLDecoder.decode(request.getParameter("update_routing"), "UTF-8" );
//				String update_date = URLDecoder.decode(request.getParameter("update_date"), "UTF-8" );
//				
//				
//				vo.setRouting_code(routing_code);
//				vo.setUpdate_routing(update_routing);
//				vo.setUpdate_date(update_date);
//				vo.setUpdater(SessionUtil.getMemberId(request));
				

				String gridData = request.getParameter("gridData");
			
				
				vo.setUpdater(SessionUtil.getMemberId(request));
				
				System.out.println("gridDatagridDatagridDatagridDatagridData");
				System.out.println(gridData);

				jsonArray = (JSONArray) parser.parse(gridData); // json 형변환 문자 > json
	            Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
	            List<SYRoutingMasterVo> list = new ArrayList<SYRoutingMasterVo>(); 

				for(int i=0; i<jsonArray.size(); i++) {
					JSONObject jObj = (JSONObject)jsonArray.get(i);
					SYRoutingMasterVo dVo = new SYRoutingMasterVo();
					dVo.setUpdater(SessionUtil.getMemberNm(request));
		
					for(Object key : keyArr) { 
						String nKey = key.toString();
						String nValue = "";
						
						if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
							continue;
						else 
							nValue = jObj.get(nKey).toString();
						
						if( "detail_code".equals(nKey) ) dVo.setDetail_code(nValue);
						else if( "code_nm".equals(nKey) ) dVo.setCode_nm(nValue);
						else if( "update_routing".equals(nKey) ) dVo.setUpdate_routing(nValue);
						else if( "update_routing_code".equals(nKey) ) dVo.setUpdate_routing_code(nValue);
						else if( "update_date".equals(nKey) ) dVo.setUpdate_date(nValue);
						}
					
					
					list.add(dVo);
				}
				
				int dCnt = sYInfoService.saveRouting(list);
				
				int result = 0;
		
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", result);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", null);
			}
			return resultData.toJSONString();
		}
		//라우팅공통 삭제
		@ResponseBody
		@RequestMapping(value = "/deleteRoutingCom", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String deleteRoutingCom(@ModelAttribute SYRoutingMasterVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.deleteRoutingCom() is called.");

			JSONObject resultData = new JSONObject();
			try {
				int result = 0;

				result = sYInfoService.deleteRoutingCom(vo);

				System.out.println("result = " + result);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", result);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("rows", 0);
			}
			return resultData.toJSONString();
		}
	
	// saveRouting_master
	@ResponseBody
	@RequestMapping(value = "/process/saveRouting_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveRouting_master(@ModelAttribute SYMaterialVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveRouting_master() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
//		vo.setCreator(SessionUtil.getMemberId(request));
//		vo.setUpdater(SessionUtil.getMemberId(request));
		try {
			/*int q = 1;
			int p = 1;
			int s = 1;*/
			
			String gridData = request.getParameter("gridData");
			String itCd = request.getParameter("itCd");
			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYRoutingMasterVo> list = new ArrayList<SYRoutingMasterVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYRoutingMasterVo dVo = new SYRoutingMasterVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
//				String old_rcC = "";
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					
					if( "routing_seq".equals(nKey) ) dVo.setRouting_seq(nValue);
					else if( "routing_gubun".equals(nKey) ) dVo.setRouting_gubun(nValue);
					else if( "routing_code".equals(nKey) ) dVo.setRouting_code(nValue);
					else if( "old_routing_code".equals(nKey) ) dVo.setOld_routing_code(nValue);
					/*{
						System.out.println("old_routing_code = " + nValue);
						old_rcC = nValue;
					}*/
					else if( "routing_nm".equals(nKey) ) dVo.setRouting_nm(nValue);
					else if( "warehouse_gubun".equals(nKey) ) dVo.setWarehouse_gubun(nValue);
					else if ("outsourcing_gubun".equals(nKey) ) dVo.setOutsourcing_gubun(nValue); 
					else if ("machine_gubun".equals(nKey) ) dVo.setMachine_gubun(nValue);
				}
				
				if(dVo.getWarehouse_gubun().equals("공정창고포인트")) { //.equals("c-032-1"))
					dVo.setWarehouse_gubun("a");
				} else if(dVo.getWarehouse_gubun().equals("제품창고포인트")) {
					dVo.setWarehouse_gubun("b");
				}
				
				// old가 p인데 구분이 같은 p이면 old_routing_code가 있다면 수정이니... 기존 값 가져오기.
				/*if(!old_rcC.equals("")) {
					System.out.println("old_rcC.substring(0, 1) = " + old_rcC.substring(0, 1));
					if(old_rcC.substring(0, 1).equals(dVo.getRouting_code())) { // 같으면
						dVo.setRouting_code(old_rcC);
					}
				}*/
				
				/*if(dVo.getRouting_code() == "q") {
					dVo.setRouting_code("q"+q);
					q = q+1;
				} else if(dVo.getRouting_code() == "p") {
					dVo.setRouting_code("p"+p);
					p = p+1;
				} else if(dVo.getRouting_code() == "s") {
					dVo.setRouting_code("s"+s);
					s = s+1;
				}*/
				
				dVo.setItem_code(itCd);
				
				list.add(dVo);
			}
			vo.setRouting_yn("Y"); // 저장되면 이거 갑니다?
			vo.setItem_code(itCd);
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYInfoService.saveRouting_master(list, vo);
			
			int result = 0;

			System.out.println("dCnt = " + dCnt);
			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	 
	// delRouting_master
	@ResponseBody
	@RequestMapping(value = "/process/delRouting_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String delRouting_master(@ModelAttribute SYMaterialVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.delRouting_master() is called.");

		JSONObject resultData = new JSONObject();
		
//		vo.setCreator(SessionUtil.getMemberId(request));
//		vo.setUpdater(SessionUtil.getMemberId(request));
		try {
			
			String itCd = request.getParameter("itCd");
			String recordsLength = request.getParameter("recordsLength");
			System.out.println("recordsLength = " + recordsLength);
			
			vo.setItem_code(itCd);
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int dCnt = 0;
			
			vo.setRouting_yn("N"); // 전체 삭제
			dCnt = sYInfoService.delRouting_master(vo);
			
			int result = 0;

			System.out.println("dCnt = " + dCnt);
			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	//210108
	@ResponseBody
	@RequestMapping(value="/selectUpdate_routing_code", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectUpdate_routing_code(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectUpdate_routing_code() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYRoutingMasterVo> dataList = sYInfoService.selectUpdate_routing_code(vo);

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
	
	
	/*@ResponseBody
	@RequestMapping(value = "/process/saveRouting_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveRouting_master(@ModelAttribute SYMaterialVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveRouting_master() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
//		vo.setCreator(SessionUtil.getMemberId(request));
//		vo.setUpdater(SessionUtil.getMemberId(request));
		try {
			
			
			String gridData = request.getParameter("gridData");
			String itCd = request.getParameter("itCd");
			String recordsLength = request.getParameter("recordsLength");
			vo.setRecordsLength(recordsLength);
			
			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYRoutingMasterVo> list = new ArrayList<SYRoutingMasterVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYRoutingMasterVo dVo = new SYRoutingMasterVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					
					if( "routing_seq".equals(nKey) ) dVo.setRouting_seq(nValue);
					else if( "routing_gubun".equals(nKey) ) dVo.setRouting_gubun(nValue);
					else if( "routing_code".equals(nKey) ) dVo.setRouting_code(nValue);
					else if( "old_routing_code".equals(nKey) ) dVo.setOld_routing_code(nValue);
					else if( "routing_nm".equals(nKey) ) dVo.setRouting_nm(nValue);
					else if( "warehouse_gubun".equals(nKey) ) dVo.setWarehouse_gubun(nValue);
					else if( "recordsLength".equals(nKey) ) dVo.setRecordsLength(nValue);
				}
				
				if(dVo.getWarehouse_gubun().equals("공정창고포인트")) { //.equals("c-032-1"))
					dVo.setWarehouse_gubun("a");
				} else if(dVo.getWarehouse_gubun().equals("제품창고포인트")) {
					dVo.setWarehouse_gubun("b");
				}
				
				dVo.setItem_code(itCd);
				
				list.add(dVo);
			}
			
			vo.setItem_code(itCd);
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = 0;
			if( recordsLength == "0" ) { // 레코드가 없으면 다 삭제임
				vo.setRouting_yn("N"); // 전체 삭제
				dCnt = sYInfoService.delRouting_master(list, vo);
			} else {
				vo.setRouting_yn("Y"); // 저장
				dCnt = sYInfoService.saveRouting_master(list, vo);
			}
			int result = 0;

			System.out.println("dCnt = " + dCnt);
			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}*/
	
	
	
	
	
	// quality
	// selectQuality
	@ResponseBody
	@RequestMapping(value = "/material/selectQuality", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectQuality(@ModelAttribute SYQualityVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectQuality is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYQualityVo> dataList = sYInfoService.selectQuality(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	
	// selectInspect_master
	@ResponseBody
	@RequestMapping(value = "/process/selectInspect_master", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectInspect_master(@ModelAttribute SYInspectMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectInspect_master is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYInspectMasterVo> dataList = sYInfoService.selectInspect_master(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// saveInspect_master
	@ResponseBody
	@RequestMapping(value = "/process/saveInspect_master", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveInspect_master(@ModelAttribute SYInspectMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveInspect_master() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8" );
			String inspect_code = URLDecoder.decode(request.getParameter("inspect_code"), "UTF-8" );
			String routing_nm = URLDecoder.decode(request.getParameter("routing_nm"), "UTF-8" );
			String routing_gubun = URLDecoder.decode(request.getParameter("routing_gubun"), "UTF-8" );
			String inspect_nm = URLDecoder.decode(request.getParameter("inspect_nm"), "UTF-8" );
			String inspect_spec = URLDecoder.decode(request.getParameter("inspect_spec"), "UTF-8" );
	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setItem_code(item_code);
			vo.setRouting_code(routing_code);
			vo.setInspect_code(inspect_code);
			vo.setRouting_nm(routing_nm);
			vo.setRouting_gubun(routing_gubun);
			vo.setInspect_nm(inspect_nm);
			vo.setInspect_spec(inspect_spec);
			
	
			int cnt = sYInfoService.saveInspect_master(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	// deleteInspect_master
	@ResponseBody
	@RequestMapping(value = "/process/deleteInspect_master", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteInspect_master(@ModelAttribute SYInspectMasterVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteInspect_master() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteInspect_master(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	
	// updateRouting_master_qc
	@ResponseBody
	@RequestMapping(value = "/process/updateRouting_master_qc", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateRouting_master_qc(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.updateRouting_master_qc() is called.");

		JSONObject resultData = new JSONObject();
		
//			vo.setCreator(SessionUtil.getMemberId(request));
//			vo.setUpdater(SessionUtil.getMemberId(request));
		try {
			
			String item_code = request.getParameter("item_code");
			String routing_code = request.getParameter("routing_code");
			String qc_yn = request.getParameter("qc_yn");
			vo.setItem_code(item_code);
			vo.setRouting_code(routing_code);
			vo.setQc_yn(qc_yn);
		
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int dCnt = 0;
			
	
			dCnt = sYInfoService.updateRouting_master_qc(vo);
			
			int result = 0;

			System.out.println("dCnt = " + dCnt);
			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	// checkMaterial
		@SuppressWarnings("unchecked")
		@ResponseBody
		@RequestMapping(value = "/material/excelMax", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
		public String excelMax(@ModelAttribute SYMaterialVo vo, HttpServletRequest request) {
			logger.debug("FrontendController.excelMax() is called.");
			JSONObject resultData = new JSONObject();
			int exist_cnt = 0;
			try {
				exist_cnt = sYInfoService.excelMax(vo);
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("cnt", exist_cnt + "");
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
			return resultData.toJSONString();
		}
	
	@ResponseBody
	@RequestMapping(value = "/material/excelLoad", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String excelLoad(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.excelLoad is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMaterialVo> dataList = sYInfoService.excelLoad(vo);

			System.out.println("dataList");
			System.out.println("dataList::::"+dataList);
			
			
			
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
	
	
	// selectMaterial_menge
	@ResponseBody
	@RequestMapping(value = "/material/selectMaterial_menge", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterial_menge(@ModelAttribute SYMaterialVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectMaterial is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYMaterialVo> dataList = sYInfoService.selectMaterial_menge(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// selectIncome_inspect_master
	@ResponseBody
	@RequestMapping(value = "/income/selectIncome_inspect_master", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectIncome_inspect_master is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYIncome_insp_mstVo> dataList = sYInfoService.selectIncome_inspect_master(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// insertIncome_inspect_master

	@ResponseBody
	@RequestMapping(value = "/income/insertIncome_inspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String insertIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.insertIncome_inspect_master is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			int cnt = sYInfoService.insertIncome_inspect_master(vo);
	
			System.out.println("cnt = " + cnt);
			
			if ( cnt > 0 ) {
				vo.setReceiving_inspection_routing_yn("Y");
				 cnt = sYInfoService.upReceiving_inspection_yn(vo);
			}

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	
	
	// updateIncome_inspect_master
	@ResponseBody
	@RequestMapping(value = "/income/updateIncome_inspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateIncome_inspect_master is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			int cnt = sYInfoService.updateIncome_inspect_master(vo);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	// deleteIncome_inspect_master
	@ResponseBody
	@RequestMapping(value = "/income/deleteIncome_inspect_master", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteIncome_inspect_master() is called.");
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteIncome_inspect_master(vo);

			System.out.println("result = " + result);
			
			List<SYIncome_insp_mstVo> dataLists = sYInfoService.selectIncome_inspect_master(vo);
			System.out.println("dataLists.size() = " + dataLists.size());
			if ( dataLists.size() == 0 ) {
				vo.setReceiving_inspection_routing_yn("N");
				result = sYInfoService.upReceiving_inspection_yn(vo);
				
				System.out.println("22 result = " + result);
			}
			
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	// /inspection/selectIncome_result
	@ResponseBody
	@RequestMapping(value = "/inspection/selectIncome_result", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectIncome_result is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYIncome_resultVo> dataList = sYInfoService.selectIncome_result(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// selectIncome_result2
	@ResponseBody
	@RequestMapping(value = "/inspection/selectIncome_result2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result2(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectIncome_result2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYIncome_resultVo> dataList = sYInfoService.selectIncome_result2(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	@RequestMapping(value = "/inspection/selectIncome_result3", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result3(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectIncome_result3 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYIncome_resultVo> dataList = sYInfoService.selectIncome_result3(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	
	// saveIncome_result3
	@ResponseBody
	@RequestMapping(value = "/inspection/saveIncome_result3", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveIncome_result3(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveIncome_result3 is called.");
	
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			int cnt = sYInfoService.saveIncome_result3(vo);
			
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/inspection/saveIncome_result2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveIncome_result2(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveIncome_result2 is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			int cnt = sYInfoService.saveIncome_result2(vo);
			
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	// selectTool_replacement_his
	@ResponseBody
	@RequestMapping(value = "/trhis/selectTool_replacement_his", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectTool_replacement_his(@ModelAttribute SYtool_repmt_hisVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectTool_replacement_his is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYtool_repmt_hisVo> dataList = sYInfoService.selectTool_replacement_his(vo);

			System.out.println("dataList");
			System.out.println(dataList);
			
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
	@RequestMapping(value = "/trhis/saveTool_replacement_his", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveTool_replacement_his(@ModelAttribute SYtool_repmt_hisVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveTool_replacement_his is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String replacement_his = "";
			int cnt = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
//				replacement_his = sYInfoService.replacementHGen();
//
//				// hKey
//				vo.setReplacement_his(replacement_his);
				
				cnt = sYInfoService.insertTool_replacement_his(vo);
			} else if (flag.equals("U")) {
				replacement_his = request.getParameter("replacement_his");

				// hKey
				vo.setReplacement_his(replacement_his);
				
				cnt = sYInfoService.updateTool_replacement_his(vo);
			}

			System.out.println("replacement_his = " + replacement_his);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/trhis/deleteTool_replacement_his", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteTool_replacement_his(@ModelAttribute SYtool_repmt_hisVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteTool_replacement_his() is called.");

		JSONObject resultData = new JSONObject();
		
		vo.setUpdater(SessionUtil.getMemberId(request));
		
		try {
			int result = 0;

			result = sYInfoService.deleteTool_replacement_his(vo);

			System.out.println("result = " + result);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", result);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	// KPI 유형 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectItem", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectItem(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectItem() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectItem(vo);

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
	
	// KPI 월별 목표량 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectGoal", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectGoal(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoal() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoal(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoal", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoal(@ModelAttribute SYGoalVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoal() is called.");
	
		JSONObject resultData = new JSONObject();
		try {
	
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8" );
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8" );
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8" );
			try{
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8" );
				vo.setGoal(goal);
			}catch(Exception e1)
			{
	
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
	
			vo.setCode(code);
			vo.setYear(year);
			vo.setMonth(month);
	
	
	
			int cnt = sYGoalService.saveGoal(vo);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	//1210 kpi설비 목표
	
	// KPI 월별 목표량 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectGoalMachine", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectGoalMachine(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoalMachine() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalMachine(vo);

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
	
	// KPI 월별 목표량 가져오기 
		@ResponseBody
		@RequestMapping(value="/goal/selectGoalMachineAll", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		public String selectGoalMachineAll(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
			logger.debug("InfoController.selectGoalMachineAll() is called.");
			
			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {

				List<SYGoalVo> dataList = sYGoalService.selectGoalMachineAll(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalMachine", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalMachine(@ModelAttribute SYGoalVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalMachine() is called.");
	
		JSONObject resultData = new JSONObject();
		try {
			String master_code = URLDecoder.decode(request.getParameter("master_code"), "UTF-8" );
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8" );
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8" );
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8" );
			try{
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8" );
				vo.setGoal(goal);
			}catch(Exception e1)
			{
	
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
	
			vo.setCode(code);
			vo.setYear(year);
			vo.setMonth(month);
	
	
	
			int cnt = sYGoalService.saveGoalMachine(vo);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	//1210 kpi설비 목표
	
	// KPI 월별 목표량 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectGoalCustomer", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectGoalCustomer(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoalCustomer() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalCustomer(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalCustomer", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalCustomer(@ModelAttribute SYGoalVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalCustomer() is called.");
	
		JSONObject resultData = new JSONObject();
		try {
	
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8" );
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8" );
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8" );
			try{
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8" );
				vo.setGoal(goal);
			}catch(Exception e1)
			{
	
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
	
			vo.setCode(code);
			vo.setYear(year);
			vo.setMonth(month);
	
	
	
			int cnt = sYGoalService.saveGoalCustomer(vo);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}

	
	//1210 kpi설비 목표
	
	// KPI 월별 목표량 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectGoalAccount", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectGoalAccount(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoalAccount() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalAccount(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalAccount", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalAccount(@ModelAttribute SYGoalVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalAccount() is called.");
	
		JSONObject resultData = new JSONObject();
		try {
	
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8" );
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8" );
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8" );
			try{
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8" );
				vo.setGoal(goal);
			}catch(Exception e1)
			{
	
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
	
			vo.setCode(code);
			vo.setYear(year);
			vo.setMonth(month);
	
	
	
			int cnt = sYGoalService.saveGoalAccount(vo);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}

	//1215 kpi생산 목표
	
	// KPI 월별 목표량 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectGoalPrdct", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectGoalPrdct(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoalPrdct() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalPrdct(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalPrdct", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalPrdct(@ModelAttribute SYGoalVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalPrdct() is called.");
	
		JSONObject resultData = new JSONObject();
		try {
	
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8" );
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8" );
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8" );
			try{
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8" );
				vo.setGoal(goal);
			}catch(Exception e1)
			{
	
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
	
			vo.setCode(code);
			vo.setYear(year);
			vo.setMonth(month);
	
	
	
			int cnt = sYGoalService.saveGoalPrdct(vo);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	// KPI 월별 목표량 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectGoalRpr", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectGoalRpr(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoalRpr() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalRpr(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalRpr", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalRpr(@ModelAttribute SYGoalVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalRpr() is called.");
	
		JSONObject resultData = new JSONObject();
		try {
	
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8" );
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8" );
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8" );
			try{
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8" );
				vo.setGoal(goal);
			}catch(Exception e1)
			{
	
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
	
			vo.setCode(code);
			vo.setYear(year);
			vo.setMonth(month);
	
	
	
			int cnt = sYGoalService.saveGoalRpr(vo);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	
	//1217 kpi생산 목표
	
	// KPI 월별 목표량 가져오기 
	@ResponseBody
	@RequestMapping(value="/goal/selectGoalDfct", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String selectGoalDfct(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoalDfct() is called.");
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalDfct(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalDfct", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalDfct(@ModelAttribute SYGoalVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalDfct() is called.");
	
		JSONObject resultData = new JSONObject();
		try {
	
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8" );
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8" );
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8" );
			try{
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8" );
				vo.setGoal(goal);
			}catch(Exception e1)
			{
	
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
	
			vo.setCode(code);
			vo.setYear(year);
			vo.setMonth(month);
	
	
	
			int cnt = sYGoalService.saveGoalDfct(vo);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	
}