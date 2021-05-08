package kr.co.passcombine.set.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.passcombine.set.svc.SYGoalService;
import kr.co.passcombine.set.svc.SYInfoService;
import kr.co.passcombine.set.svc.SYProductService;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.StringUtil;
import kr.co.passcombine.set.util.excelUpload;
import kr.co.passcombine.set.util.fileUpload;
import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYTBranchVo;
import kr.co.passcombine.set.vo.SYTClientVo;
import kr.co.passcombine.set.vo.SYTEstimateVo;
import kr.co.passcombine.set.vo.SYTMaterialOrderVo;
import kr.co.passcombine.set.vo.SYTMaterialRequestVo;
import kr.co.passcombine.set.vo.SYTMaterialVo;
import kr.co.passcombine.set.vo.SYTProjectVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYDeliveryOrderVo;
import kr.co.passcombine.set.vo.SYDrwFileInfoVo;
import kr.co.passcombine.set.vo.SYGoalVo;
import kr.co.passcombine.set.vo.SYTProjectVo;
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
import kr.co.passcombine.set.vo.SYTBomVo;
import kr.co.passcombine.set.vo.SYTVendorVo;
import kr.co.passcombine.set.vo.SYWarehouseOutVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterHVo;
import kr.co.passcombine.set.vo.SYtool_repmt_hisVo;
import kr.co.passcombine.set.vo.SYHoldVo;

//

@Controller
@RequestMapping("/info")
public class InfoController {
	private static final Logger logger = LoggerFactory.getLogger(InfoController.class);

	@Resource(name = "setInfoService")
	SYInfoService sYInfoService;

	@Resource(name = "setGoalService")
	SYGoalService sYGoalService;

	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView infoMenuNavigation(@PathVariable String menu_div, @PathVariable String menu_page,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.infoMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("info/" + menu_div + "/" + menu_page);

		return modelAndView;
	}

	// selectCdD
	@ResponseBody
	@RequestMapping(value = "/codeDetail/selectCdD", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCdD(@ModelAttribute SYCustomerVo vo, HttpServletRequest request, HttpServletResponse response,
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

	// selectCdD
	@ResponseBody
	@RequestMapping(value = "/codeDetail/selectCdD_csmb", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCdD_csmb(@ModelAttribute SYCustomerVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// checkCustomer
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/customer/checkCustomer", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
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
	@RequestMapping(value = "/customer/selectCustomer", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCustomer(@ModelAttribute SYCustomerVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// saveCustomer
	@ResponseBody
	@RequestMapping(value = "/customer/saveCustomer", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveCustomer(@ModelAttribute SYCustomerVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/customer/deleteCustomer", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteCustomer(@ModelAttribute SYCustomerVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	/**
	 * <pre>
	* 1. MethodName : Client
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 거래처관리
	* 4. 작성자       : DEV_KIMDEUKYONG
	* 5. 작성일       : 2021. 04. 26.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// checkClient
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/checkClient", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkClient(@ModelAttribute SYTClientVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkClient() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkClient(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	// selectClient
	@ResponseBody
	@RequestMapping(value = "/account/selectClient", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectClient(@ModelAttribute SYTClientVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectClient is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );

			List<SYTClientVo> dataList = sYInfoService.selectClient(vo);

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

	// saveClient
	@ResponseBody
	@RequestMapping(value = "/account/saveClient", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveClient(@ModelAttribute SYTClientVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveAccount is called.");

		vo.setCST_REG_ID(SessionUtil.getMemberId(request));
		
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String CST_IDX = "";
			int cnt = 0;
			int insertedIDX = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
				// account_code = sYInfoService.accountCdGen();

				// hKey
				// vo.setAccount_code(account_code);

				cnt = sYInfoService.insertClient(vo);

				insertedIDX = vo.getCST_IDX();// 등록된 CST_IDX 값 가져오기
			} else if (flag.equals("U")) {// Modify
				CST_IDX = request.getParameter("CST_IDX");

				// hKey
				vo.setCST_IDX(Integer.parseInt(CST_IDX));

				cnt = sYInfoService.updateClient(vo);
			}

			System.out.println("CST_IDX = " + insertedIDX);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	// deleteClient
	@ResponseBody
	@RequestMapping(value = "/account/deleteClient", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteClient(@ModelAttribute SYTClientVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteClient(vo);

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

	/**
	 * <pre>
	* 1. MethodName : Vendor
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 거래처관리
	* 4. 작성자       : DEV_KIMDEUKYONG
	* 5. 작성일       : 2021. 04. 25.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// checkVendor
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/checkVendor", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkVendor(@ModelAttribute SYTVendorVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkVendor() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkVendor(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	// selectVendor
	@ResponseBody
	@RequestMapping(value = "/account/selectVendor", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectVendor(@ModelAttribute SYTVendorVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectVendor is called.");
		try{
			if(session.getAttribute("member_vdr_idx")!=null) {
				String mem_vdr_idx=(String)session.getAttribute("member_vdr_idx");
				vo.setVDR_IDX(Integer.parseInt(mem_vdr_idx));
			};
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );

			List<SYTVendorVo> dataList = sYInfoService.selectVendor(vo);

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

	// saveVendor
	@ResponseBody
	@RequestMapping(value = "/account/saveVendor", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveVendor(@ModelAttribute SYTVendorVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveAccount is called.");

		vo.setVDR_REG_ID(SessionUtil.getMemberId(request));
		
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String VDR_IDX = "";
			int cnt = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
				// account_code = sYInfoService.accountCdGen();

				// hKey
				// vo.setAccount_code(account_code);

				cnt = sYInfoService.insertVendor(vo);
			} else if (flag.equals("U")) {// Modify
				VDR_IDX = request.getParameter("VDR_IDX");

				// hKey
				vo.setVDR_IDX(Integer.parseInt(VDR_IDX));

				cnt = sYInfoService.updateVendor(vo);
			}

			System.out.println("VDR_IDX = " + VDR_IDX);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	// deleteVendor
	@ResponseBody
	@RequestMapping(value = "/account/deleteVendor", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteVendor(@ModelAttribute SYTVendorVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteVendor(vo);

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

	/**
	 * <pre>
	* 1. MethodName : Branch
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 기업정보관리
	* 4. 작성자       : DEV_KIMDEUKYONG
	* 5. 작성일       : 2021. 04. 26.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// checkBranch
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/checkBranch", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkBranch(@ModelAttribute SYTBranchVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkBranch() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkBranch(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	// selectBranch
	@ResponseBody
	@RequestMapping(value = "/account/selectBranch", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectBranch(@ModelAttribute SYTBranchVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectBranch is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );

			List<SYTBranchVo> dataList = sYInfoService.selectBranch(vo);

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

	// saveBranch
	@ResponseBody
	@RequestMapping(value = "/account/saveBranch", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveBranch(@ModelAttribute SYTBranchVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveAccount is called.");

		vo.setBCO_REG_ID(SessionUtil.getMemberId(request));
		
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String BCO_IDX = "";
			int cnt = 0;

			String flag = request.getParameter("flag");

			if (flag.equals("I")) {
				// account_code = sYInfoService.accountCdGen();

				// hKey
				// vo.setAccount_code(account_code);

				cnt = sYInfoService.insertBranch(vo);
			} else if (flag.equals("U")) {// Modify
				BCO_IDX = request.getParameter("BCO_IDX");

				// hKey
				vo.setBCO_IDX(Integer.parseInt(BCO_IDX));

				cnt = sYInfoService.updateBranch(vo);
			}

			System.out.println("BCO_IDX = " + BCO_IDX);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	// deleteBranch
	@ResponseBody
	@RequestMapping(value = "/account/deleteBranch", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteBranch(@ModelAttribute SYTBranchVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteBranch(vo);

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

	/**
	 * <pre>
	* 1. MethodName : Material
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 자재관리
	* 4. 작성자       : DEV_KIMDEUKYONG
	* 5. 작성일       : 2021. 04. 26.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// checkMaterial
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/checkMaterial", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkMaterial(@ModelAttribute SYTMaterialVo vo, HttpServletRequest request) {
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
	@RequestMapping(value = "/account/selectMaterial", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterial(@ModelAttribute SYTMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectMaterial is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );

			List<SYTMaterialVo> dataList = sYInfoService.selectMaterial(vo);

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

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String MTL_IDX = "";
			int cnt = 0;

			String flag = (String)vo.get("flag");
			request.setAttribute("flag", flag);

			if (flag.equals("I")) {
				// account_code = sYInfoService.accountCdGen();

				// hKey
				// vo.setAccount_code(account_code);


				cnt = sYInfoService.insertMaterial(vo,file);
			} else if (flag.equals("U")) {// Modify
				MTL_IDX = request.getParameter("MTL_IDX");

				
				// hKey
				vo.put("MTL_IDX",(Integer.parseInt(MTL_IDX)));
				Map<String,Object> result = sYInfoService.selectFiles(vo);
				if(result!=null) {
					if(result.get("CMM_FLE_SYS_NM")!=null)
					fileUpload.delFile(request,result);
				}
				cnt = sYInfoService.updateMaterial(vo,file);
			}

			System.out.println("MTL_IDX = " + MTL_IDX);

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
	@RequestMapping(value = "/account/deleteMaterial", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteMaterial(@ModelAttribute SYTMaterialVo vo, MultipartHttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			Map<String, Object>vos = new HashMap<String,Object>();
			String MTL_IDX = request.getParameter("MTL_IDX");
			
			// hKey
			vos.put("MTL_IDX",(Integer.parseInt(MTL_IDX)));
			Map<String,Object> result = sYInfoService.selectFiles(vos);
			if(result!=null) {
				if(result.get("CMM_FLE_SYS_NM")!=null)
				fileUpload.delFile(request,result);
			}
			
			int results = 0;

			results = sYInfoService.deleteMaterial(vo);

			System.out.println("result = " + results);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", results);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}

	/**
	 * <pre>
	* 1. MethodName : Project
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 프로젝트 > 프로젝트 관리
	* 4. 작성자       : DEV_KIMDEUKYONG
	* 5. 작성일       : 2021. 04. 27.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// checkProject
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/checkProject", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkProject(@ModelAttribute SYTProjectVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.checkProject() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYInfoService.checkProject(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	// selectProject
	@ResponseBody
	@RequestMapping(value = "/account/selectProject", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProject(@ModelAttribute SYTProjectVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectProject is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			
//			String CST_IDX = "";
//			CST_IDX = request.getParameter("CST_IDX");
//			if(CST_IDX == null) CST_IDX = "";
//			vo.setPJT_IDX(Integer.parseInt(CST_IDX));
			 

			List<SYTProjectVo> dataList = sYInfoService.selectProject(vo);

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

	// saveProject
	@ResponseBody
	@RequestMapping(value = "/account/saveProject", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveProject(@ModelAttribute SYTProjectVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveAccount is called.");

		vo.setPJT_REG_ID(SessionUtil.getMemberId(request));
		
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String PJT_IDX = "";
			int cnt = 0;

			String flag = request.getParameter("flag");
			// String delivery_date =
			// URLDecoder.decode(request.getParameter("delivery_date"), "UTF-8" );

			if (flag.equals("I")) {
				// account_code = sYInfoService.accountCdGen();

				// hKey
				// vo.setAccount_code(account_code);

				cnt = sYInfoService.insertProject(vo);
			} else if (flag.equals("U")) {// Modify
				PJT_IDX = request.getParameter("PJT_IDX");

				// hKey
				vo.setPJT_IDX(Integer.parseInt(PJT_IDX));

				cnt = sYInfoService.updateProject(vo);
			}

			System.out.println("PJT_IDX = " + PJT_IDX);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	// deleteProject
	@ResponseBody
	@RequestMapping(value = "/account/deleteProject", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteProject(@ModelAttribute SYTProjectVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteProject(vo);

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

	@ResponseBody
	@RequestMapping(value = "/material/selectMaterial2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterial2(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// selectMaterial
	@ResponseBody
	@RequestMapping(value = "/material/selectMaterial3", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterial3(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// checkAccount
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/checkAccount", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
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
	@RequestMapping(value = "/account/selectAccount", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectAccount(@ModelAttribute SYAccountVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// saveAccount
	@ResponseBody
	@RequestMapping(value = "/account/saveAccount", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveAccount(@ModelAttribute SYAccountVo vo, HttpServletRequest request, HttpServletResponse response,
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
	@RequestMapping(value = "/account/deleteAccount", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteAccount(@ModelAttribute SYAccountVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/partition/selectPartition2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectPartition2(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.selectPartition2() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPartitionVO> dataList = sYInfoService.selectPartition2(vo);

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
	////////

	// jyp
	@ResponseBody
	@RequestMapping(value = "/partition/selectPartition", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> selectPartition(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.selectPartition() is called.");

		ResponseEntity<String> result = null;

		try {
			List<SYPartitionVO> dataList = sYInfoService.selectPartition(vo);

			result = ResponseUtils.getJSONResponse("success", dataList, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}

		return result;

	}

	@ResponseBody
	@RequestMapping(value = "/partition/insPartition", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> insPartition(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.insPartition() is called.");

		ResponseEntity<String> result = null;
		int cnt = 0;
		try {
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt = sYInfoService.insPartition(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch (Exception e) {
			logger.debug("error");
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}

		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/partition/updPartition", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> updPartition(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.updPartition() is called.");

		ResponseEntity<String> result = null;
		int cnt = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt = sYInfoService.updPartition(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}

		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/partition/delPartition", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> delPartition(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.delPartition() is called.");
		ResponseEntity<String> result = null;
		int cnt = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt = sYInfoService.updPartition(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}

		return result;

	}

	@ResponseBody
	@RequestMapping(value = "/partition/delPartitionAll", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> delPartitionAll(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.delPartitionAll() is called.");
		ResponseEntity<String> result = null;
		int cnt = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			cnt = sYInfoService.delPartitionAll(vo);
			result = ResponseUtils.getJSONResponse("success", cnt, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = ResponseUtils.getSimpleFailResponse();
		}

		return result;

	}

	@ResponseBody
	@RequestMapping(value = "/partition/selectPartitionList", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectPartitonList(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectPartitionList() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPartitionVO> dataList = sYInfoService.selectPartitionList(vo);

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

	@ResponseBody
	@RequestMapping(value = "/partition/selectPartitionDetail", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectPartitonDetail(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectPartitonDetail() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPartitionVO> dataList = sYInfoService.selectPartitionDetail(vo);

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

	@ResponseBody
	@RequestMapping(value = "/partition/insPartitionDetail", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
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

			Object[] keyArr = ((JSONObject) jsonArray.get(0)).keySet().toArray();
			List<SYPartitionVO> lvo = new ArrayList<>();

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject) jsonArray.get(i);
				p = new SYPartitionVO();
				Method[] m = p.getClass().getDeclaredMethods();
				for (Object key : keyArr) {

					String nKey = key.toString();
					String nValue = "";

					if (jObj.get(nKey) == null)
						continue;
					else
						nValue = jObj.get(nKey).toString();

					methodNm = "set".concat(nKey.substring(0, 1).toUpperCase()).concat(nKey.substring(1));

					for (Method mt : m) {
						if (mt.getName().equals(methodNm)) {
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
	@RequestMapping(value = "/partition/delPartitionDetail", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String delPartitionDetail(@ModelAttribute SYPartitionVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/machine/checkMachine", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
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
	@RequestMapping(value = "/machine/selectMachine", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectMachine(@ModelAttribute SYMachineVO vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectMachine() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYMachineVO> dataList = sYInfoService.selectMachine(vo);

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

	@ResponseBody
	@RequestMapping(value = "/machine/insMachine", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String insMachine(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response) {
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
	@RequestMapping(value = "/machine/updMachine", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String updMachine(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response) {
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
	@RequestMapping(value = "/machine/delMachine", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String delMachine(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.delMachine is called.");

		SYMachineVO vo = new SYMachineVO();
		Map<String, Object> params = new HashMap<>();
		String[] keyCols = { "machine_code", "machine_nm" };
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
	@RequestMapping(value = "/machine/selectMachine_waiting", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectMachine_waiting(@ModelAttribute SYMachineVO vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectMachine_waiting() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYMachineVO> dataList = sYInfoService.selectMachine_waiting(vo);

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

	// selectMachine_class
	@ResponseBody
	@RequestMapping(value = "/machine/selectMachine_class", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMachine_class(@ModelAttribute SYMachineVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// 1113
	// machine_이름제거
	@ResponseBody
	@RequestMapping(value = "/machine/selectMachine_nm", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMachine_nm(@ModelAttribute SYMachineVO vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectMachine_nm() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			List<SYMachineVO> dataList = sYInfoService.selectMachine_nm(vo);

			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
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
	@RequestMapping(value = "/machine/saveHold_Y", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_Y(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response,
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
	@RequestMapping(value = "/machine/saveHold_N", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_N(@ModelAttribute SYMachineVO vo, HttpServletRequest request, HttpServletResponse response,
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
	@RequestMapping(value = "/machine/updateHoldWaitingEnd", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateHoldWaitingEnd(@ModelAttribute SYProductUnOperationVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.updateHoldWaitingEnd() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			vo.setUpdater(SessionUtil.getMemberId(request));
			vo.setMachine_nm(SessionUtil.getMemberId(request));
			result = sYInfoService.updateHoldWaitingEnd(vo);

			System.out.println("result = " + result);

			if (result == 999) {
				resultData.put("status", 777);
				resultData.put("rows", null);
			} else {
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
	@RequestMapping(value = "/machine/saveHold_ALL_Y", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_ALL_Y(@ModelAttribute SYHoldVo vo, HttpServletRequest request, HttpServletResponse response,
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
	@RequestMapping(value = "/machine/saveHold_ALL_N", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveHold_ALL_N(@ModelAttribute SYHoldVo vo, HttpServletRequest request, HttpServletResponse response,
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
	@RequestMapping(value = "/selectBomlist", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked" })
	public String selectBomlist(@ModelAttribute SYBomVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.selectBomlist() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			int num = 0;
			List<SYBomVo> dataList = sYInfoService.selectBomlist(vo);
			List<SYBomVo> dataList2 = new ArrayList<SYBomVo>();
			for (int i = 0; dataList.size() > i; i++) {
				if (dataList.get(i).getStufe() != 0) {
					if (dataList.get(i).getStufe() == 1) {
						num++;
						dataList2.add(dataList.get(i));
						for (int j = 0; dataList.size() > j; j++) {
							if (dataList.get(j).getM_item_code().equals(dataList.get(i).getC_item_code())) {
								dataList2.add(dataList.get(j));
							}
						}
					}
				} else {
					dataList2.add(dataList.get(i));
				}
			}
			if (num == 0) {
				dataList2 = dataList;
			}
			String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList2);
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
	@RequestMapping(value = "/insertBomlist", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked" })
	public String insertBomlist(@ModelAttribute SYBomVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.insertBomlist() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			List<SYBomVo> dataList = sYInfoService.selectBomlist(vo);
			if (dataList.size() != 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("msg", "fall");
			} else {
				int cnt = sYInfoService.insertBomlist(vo);
				if (cnt == 1) {
					resultData.put("status", HttpStatus.OK.value());
					resultData.put("msg", "success");
				} else {
					resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
					resultData.put("msg", "whatfall");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/deleteBomlist", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked" })
	public String deleteBomlist(@ModelAttribute SYBomVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.deleteBomlist() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = 0;
			if (vo.getStufe() == 1) {
				SYBomVo vo2 = new SYBomVo();
				vo2.setProduct_item_code(vo.getProduct_item_code());
				vo2.setM_item_code(vo.getC_item_code());
				vo2.setBusiness_code(vo.getBusiness_code());
				cnt = sYInfoService.deleteBomlist(vo2);
			}
			if (cnt >= 0) {
				cnt = sYInfoService.deleteBomlist(vo);
			}
			if (cnt == 1) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("msg", "success");
			} else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("msg", "fall");
			}
		} catch (Exception e) {
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
	@RequestMapping(value = "/print/selectPrintFI", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPrintFI(@ModelAttribute SYPrintVO vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPrintFI is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYPrintVO> dataList = sYInfoService.selectPrintFI(vo);

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

	// 20200922
	@ResponseBody
	@RequestMapping(value = "/product/selectS_product2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectS_product2(@ModelAttribute SYProduct2Vo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	@ResponseBody
	@RequestMapping(value = "/product/selectS_product", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectS_product(@ModelAttribute SYProduct2Vo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectS_product is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			String gb = request.getParameter("gb");
			System.out.println("gb=" + gb);
			List<SYProduct2Vo> dataList = new ArrayList<SYProduct2Vo>();

			if (gb.equals("i")) {
				dataList = sYInfoService.selectS_product(vo);
			} else if (gb.equals("u")) {
				dataList = sYInfoService.selectS_productu(vo);
			}

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

	@ResponseBody
	@RequestMapping(value = "/product/selectS_product_fail", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectS_product_fail(@ModelAttribute SYProduct2Vo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectS_product_fail is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			String gb = request.getParameter("gb");
			System.out.println("gb=" + gb);
			List<SYProduct2Vo> dataList = new ArrayList<SYProduct2Vo>();

			if (gb.equals("i")) {
				dataList = sYInfoService.selectS_product_fail(vo);
			} else if (gb.equals("u")) {
				dataList = sYInfoService.selectS_productu_fail(vo);
			}

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
	// 20200922

	// jsjsjsjsjsjjs new 20200919
	// selectItemCode
	@ResponseBody
	@RequestMapping(value = "/material/selectItemCode", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemCode(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	@ResponseBody
	@RequestMapping(value = "/material/selectItemCode2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemCode2(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	@ResponseBody
	@RequestMapping(value = "/material/selectItemCode3", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemCode3(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// selectInspect_master2
	@ResponseBody
	@RequestMapping(value = "/process/selectInspection_master2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectInspection_master2(@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// selectInstrumentTool
	@ResponseBody
	@RequestMapping(value = "/instrument/selectInstrumentTool", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectInstrumentTool(@ModelAttribute SYInstrumentVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// instrument/insertInspection
	@ResponseBody
	@RequestMapping(value = "/instrument/insertInspection", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked" })
	public String insertInspection(@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.insertInspection() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYInfoService.insertInspection(vo);

			System.out.println("cnt = " + cnt);

			// routing_master
			if (cnt > 0) {
				vo.setQc_yn("Y");
				cnt = sYInfoService.upRouting_mstQc_yn(vo);
			}

			System.out.println("22 cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
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
	public String insertInspection2(@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.insertInspection2() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();

		try {

			String gridData = request.getParameter("gridData");

			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8");
			String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8");

			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setItem_code(item_code);
			vo.setRouting_code(routing_code);

			System.out.println("gridDatagridDatagridDatagridDatagridData");
			System.out.println(gridData);

			jsonArray = (JSONArray) parser.parse(gridData); // json 형변환 문자 > json
			Object[] keyArr = ((JSONObject) jsonArray.get(0)).keySet().toArray(); // 첫번재 row인 얘 가져와서 key값 추출. ex
																					// gen_key, gen_name 배열타입
			List<SYInspectionMasterVo> list = new ArrayList<SYInspectionMasterVo>();

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject) jsonArray.get(i);
				SYInspectionMasterVo dVo = new SYInspectionMasterVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
//						String old_rcC = "";

				for (Object key : keyArr) {
					String nKey = key.toString();
					String nValue = "";

					if (jObj.get(nKey) == null || jObj.get(nKey) == "")
						continue;
					else
						nValue = jObj.get(nKey).toString();

					if ("inspection_item".equals(nKey))
						dVo.setInspection_item(nValue);
					else if ("inspection_tool".equals(nKey))
						dVo.setInspection_tool(nValue);
					else if ("spec".equals(nKey))
						dVo.setSpec(nValue);
					else if ("min_spec".equals(nKey))
						dVo.setMin_spec(nValue);
					else if ("max_spec".equals(nKey))
						dVo.setMax_spec(nValue);

					else if ("inspection_gubun".equals(nKey))
						dVo.setInspection_gubun(nValue);
					else if ("inspection_gubun_nm".equals(nKey))
						dVo.setInspection_gubun_nm(nValue);

					else if ("inspection_method".equals(nKey))
						dVo.setInspection_method(nValue);
					else if ("inspection_method_nm".equals(nKey))
						dVo.setInspection_method_nm(nValue);
				}

				list.add(dVo);
			}

			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYInfoService.insertInspection2(list, vo);

			int result = 0;

			if (dCnt > 0) {
				vo.setQc_yn("Y");
				dCnt = sYInfoService.upRouting_mstQc_yn(vo);
			}

			System.out.println("dCnt = " + dCnt);
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

	// updateInspection
	@ResponseBody
	@RequestMapping(value = "/instrument/updateInspection", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked" })
	public String updateInspection(@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.updateInspection() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYInfoService.updateInspection(vo);

			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}

	// instrument/deleteInspection
	@ResponseBody
	@RequestMapping(value = "/instrument/deleteInspection", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteInspection(@ModelAttribute SYInspectionMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteInspection() is called.");
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteInspection(vo);

			System.out.println("result = " + result);

			List<SYInspectionMasterVo> dataLists = sYInfoService.selectInspection_master2(vo);
			System.out.println("dataLists.size() = " + dataLists.size());
			if (dataLists.size() == 0) {
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
	@RequestMapping(value = "/process/selectRou_mstG", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRou_mstG(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// process
	// selectRouting_master
	@ResponseBody
	@RequestMapping(value = "/process/selectRouting_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRouting_master(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	@ResponseBody
	@RequestMapping(value = "/selectUpdate_routing", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectUpdate_routing(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectUpdate_routing() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYRoutingMasterVo> dataList = sYInfoService.selectUpdate_routing(vo);

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

	// 성민
	// deleteCustomer
	@ResponseBody
	@RequestMapping(value = "/deleteWarehouse", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteCustomer(@ModelAttribute SYWarehouseVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/checkWarehouse", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
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
	public String save_wh_mng(@ModelAttribute SYWarehouseVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/select_wh_mng", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String select_wh_mng(@ModelAttribute SYWarehouseVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// selectRouting_master
	@ResponseBody
	@RequestMapping(value = "/selectRouting_com_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRouting_com_master(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	@ResponseBody
	@RequestMapping(value = "/selectRouting_com_master_2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRouting_com_master_2(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// 라우팅공통저장
	@ResponseBody
	@RequestMapping(value = "/saveRouting", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveRouting(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
			Object[] keyArr = ((JSONObject) jsonArray.get(0)).keySet().toArray();
			List<SYRoutingMasterVo> list = new ArrayList<SYRoutingMasterVo>();

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject) jsonArray.get(i);
				SYRoutingMasterVo dVo = new SYRoutingMasterVo();
				dVo.setUpdater(SessionUtil.getMemberNm(request));

				for (Object key : keyArr) {
					String nKey = key.toString();
					String nValue = "";

					if (jObj.get(nKey) == null || jObj.get(nKey) == "")
						continue;
					else
						nValue = jObj.get(nKey).toString();

					if ("detail_code".equals(nKey))
						dVo.setDetail_code(nValue);
					else if ("code_nm".equals(nKey))
						dVo.setCode_nm(nValue);
					else if ("update_routing".equals(nKey))
						dVo.setUpdate_routing(nValue);
					else if ("update_routing_code".equals(nKey))
						dVo.setUpdate_routing_code(nValue);
					else if ("update_date".equals(nKey))
						dVo.setUpdate_date(nValue);
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

	// 라우팅공통 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteRoutingCom", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteRoutingCom(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	public String saveRouting_master(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveRouting_master() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();

//		vo.setCreator(SessionUtil.getMemberId(request));
//		vo.setUpdater(SessionUtil.getMemberId(request));
		try {
			/*
			 * int q = 1; int p = 1; int s = 1;
			 */

			String gridData = request.getParameter("gridData");
			String itCd = request.getParameter("itCd");
			jsonArray = (JSONArray) parser.parse(gridData);
			Object[] keyArr = ((JSONObject) jsonArray.get(0)).keySet().toArray();
			List<SYRoutingMasterVo> list = new ArrayList<SYRoutingMasterVo>();

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject) jsonArray.get(i);
				SYRoutingMasterVo dVo = new SYRoutingMasterVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
//				String old_rcC = "";

				for (Object key : keyArr) {
					String nKey = key.toString();
					String nValue = "";

					if (jObj.get(nKey) == null || jObj.get(nKey) == "")
						continue;
					else
						nValue = jObj.get(nKey).toString();

					if ("routing_seq".equals(nKey))
						dVo.setRouting_seq(nValue);
					else if ("routing_gubun".equals(nKey))
						dVo.setRouting_gubun(nValue);
					else if ("routing_code".equals(nKey))
						dVo.setRouting_code(nValue);
					else if ("old_routing_code".equals(nKey))
						dVo.setOld_routing_code(nValue);
					/*
					 * { System.out.println("old_routing_code = " + nValue); old_rcC = nValue; }
					 */
					else if ("routing_nm".equals(nKey))
						dVo.setRouting_nm(nValue);
					else if ("warehouse_gubun".equals(nKey))
						dVo.setWarehouse_gubun(nValue);
					else if ("outsourcing_gubun".equals(nKey))
						dVo.setOutsourcing_gubun(nValue);
					else if ("machine_gubun".equals(nKey))
						dVo.setMachine_gubun(nValue);
				}

				if (dVo.getWarehouse_gubun().equals("공정창고포인트")) { // .equals("c-032-1"))
					dVo.setWarehouse_gubun("a");
				} else if (dVo.getWarehouse_gubun().equals("제품창고포인트")) {
					dVo.setWarehouse_gubun("b");
				}

				// old가 p인데 구분이 같은 p이면 old_routing_code가 있다면 수정이니... 기존 값 가져오기.
				/*
				 * if(!old_rcC.equals("")) { System.out.println("old_rcC.substring(0, 1) = " +
				 * old_rcC.substring(0, 1)); if(old_rcC.substring(0,
				 * 1).equals(dVo.getRouting_code())) { // 같으면 dVo.setRouting_code(old_rcC); } }
				 */

				/*
				 * if(dVo.getRouting_code() == "q") { dVo.setRouting_code("q"+q); q = q+1; }
				 * else if(dVo.getRouting_code() == "p") { dVo.setRouting_code("p"+p); p = p+1;
				 * } else if(dVo.getRouting_code() == "s") { dVo.setRouting_code("s"+s); s =
				 * s+1; }
				 */

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
		} catch (Exception e) {
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
	public String delRouting_master(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}

	// 210108
	@ResponseBody
	@RequestMapping(value = "/selectUpdate_routing_code", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectUpdate_routing_code(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectUpdate_routing_code() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYRoutingMasterVo> dataList = sYInfoService.selectUpdate_routing_code(vo);

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

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/process/saveRouting_master", method = {
	 * RequestMethod.GET, RequestMethod.POST }, produces =
	 * "application/json;charset=UTF-8")
	 * 
	 * @SuppressWarnings("unchecked") public String
	 * saveRouting_master(@ModelAttribute SYMaterialVo vo, HttpServletRequest
	 * request, HttpServletResponse response, HttpSession session) {
	 * logger.debug("FrontendController.saveRouting_master() is called.");
	 * 
	 * JSONArray jsonArray = new JSONArray(); JSONParser parser = new JSONParser();
	 * JSONObject resultData = new JSONObject();
	 * 
	 * // vo.setCreator(SessionUtil.getMemberId(request)); //
	 * vo.setUpdater(SessionUtil.getMemberId(request)); try {
	 * 
	 * 
	 * String gridData = request.getParameter("gridData"); String itCd =
	 * request.getParameter("itCd"); String recordsLength =
	 * request.getParameter("recordsLength"); vo.setRecordsLength(recordsLength);
	 * 
	 * jsonArray = (JSONArray) parser.parse(gridData); Object[] keyArr =
	 * ((JSONObject)jsonArray.get(0)).keySet().toArray(); List<SYRoutingMasterVo>
	 * list = new ArrayList<SYRoutingMasterVo>();
	 * 
	 * for(int i=0; i<jsonArray.size(); i++) { JSONObject jObj =
	 * (JSONObject)jsonArray.get(i); SYRoutingMasterVo dVo = new
	 * SYRoutingMasterVo(); dVo.setCreator(SessionUtil.getMemberId(request));
	 * dVo.setUpdater(SessionUtil.getMemberId(request));
	 * 
	 * for(Object key : keyArr) { String nKey = key.toString(); String nValue = "";
	 * 
	 * if( jObj.get(nKey)==null || jObj.get(nKey)=="") continue; else nValue =
	 * jObj.get(nKey).toString();
	 * 
	 * if( "routing_seq".equals(nKey) ) dVo.setRouting_seq(nValue); else if(
	 * "routing_gubun".equals(nKey) ) dVo.setRouting_gubun(nValue); else if(
	 * "routing_code".equals(nKey) ) dVo.setRouting_code(nValue); else if(
	 * "old_routing_code".equals(nKey) ) dVo.setOld_routing_code(nValue); else if(
	 * "routing_nm".equals(nKey) ) dVo.setRouting_nm(nValue); else if(
	 * "warehouse_gubun".equals(nKey) ) dVo.setWarehouse_gubun(nValue); else if(
	 * "recordsLength".equals(nKey) ) dVo.setRecordsLength(nValue); }
	 * 
	 * if(dVo.getWarehouse_gubun().equals("공정창고포인트")) { //.equals("c-032-1"))
	 * dVo.setWarehouse_gubun("a"); } else
	 * if(dVo.getWarehouse_gubun().equals("제품창고포인트")) { dVo.setWarehouse_gubun("b");
	 * }
	 * 
	 * dVo.setItem_code(itCd);
	 * 
	 * list.add(dVo); }
	 * 
	 * vo.setItem_code(itCd); vo.setUpdater(SessionUtil.getMemberId(request)); int
	 * dCnt = 0; if( recordsLength == "0" ) { // 레코드가 없으면 다 삭제임
	 * vo.setRouting_yn("N"); // 전체 삭제 dCnt = sYInfoService.delRouting_master(list,
	 * vo); } else { vo.setRouting_yn("Y"); // 저장 dCnt =
	 * sYInfoService.saveRouting_master(list, vo); } int result = 0;
	 * 
	 * System.out.println("dCnt = " + dCnt); System.out.println("result = " +
	 * result);
	 * 
	 * resultData.put("status", HttpStatus.OK.value()); resultData.put("rows",
	 * result); } catch(Exception e){ e.printStackTrace(); resultData.put("status",
	 * HttpStatus.INTERNAL_SERVER_ERROR.value()); resultData.put("rows", 0); }
	 * return resultData.toJSONString(); }
	 */

	// quality
	// selectQuality
	@ResponseBody
	@RequestMapping(value = "/material/selectQuality", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectQuality(@ModelAttribute SYQualityVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// selectInspect_master
	@ResponseBody
	@RequestMapping(value = "/process/selectInspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectInspect_master(@ModelAttribute SYInspectMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// saveInspect_master
	@ResponseBody
	@RequestMapping(value = "/process/saveInspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveInspect_master(@ModelAttribute SYInspectMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveInspect_master() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8");
			String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8");
			String inspect_code = URLDecoder.decode(request.getParameter("inspect_code"), "UTF-8");
			String routing_nm = URLDecoder.decode(request.getParameter("routing_nm"), "UTF-8");
			String routing_gubun = URLDecoder.decode(request.getParameter("routing_gubun"), "UTF-8");
			String inspect_nm = URLDecoder.decode(request.getParameter("inspect_nm"), "UTF-8");
			String inspect_spec = URLDecoder.decode(request.getParameter("inspect_spec"), "UTF-8");

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
	@RequestMapping(value = "/process/deleteInspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteInspect_master(@ModelAttribute SYInspectMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	public String updateRouting_master_qc(@ModelAttribute SYRoutingMasterVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}

	// checkMaterial
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/material/excelMax", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json; charset=utf-8")
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
	@RequestMapping(value = "/material/excelLoad", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String excelLoad(@ModelAttribute SYMaterialVo vo, HttpServletRequest request, HttpServletResponse response,
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
			System.out.println("dataList::::" + dataList);

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

	// selectMaterial_menge
	@ResponseBody
	@RequestMapping(value = "/material/selectMaterial_menge", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterial_menge(@ModelAttribute SYMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// selectIncome_inspect_master
	@ResponseBody
	@RequestMapping(value = "/income/selectIncome_inspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// insertIncome_inspect_master

	@ResponseBody
	@RequestMapping(value = "/income/insertIncome_inspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String insertIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.insertIncome_inspect_master is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			int cnt = sYInfoService.insertIncome_inspect_master(vo);

			System.out.println("cnt = " + cnt);

			if (cnt > 0) {
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
	public String updateIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/income/deleteIncome_inspect_master", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteIncome_inspect_master(@ModelAttribute SYIncome_insp_mstVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteIncome_inspect_master() is called.");
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteIncome_inspect_master(vo);

			System.out.println("result = " + result);

			List<SYIncome_insp_mstVo> dataLists = sYInfoService.selectIncome_inspect_master(vo);
			System.out.println("dataLists.size() = " + dataLists.size());
			if (dataLists.size() == 0) {
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
	@RequestMapping(value = "/inspection/selectIncome_result", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result(@ModelAttribute SYIncome_resultVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// selectIncome_result2
	@ResponseBody
	@RequestMapping(value = "/inspection/selectIncome_result2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result2(@ModelAttribute SYIncome_resultVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	@ResponseBody
	@RequestMapping(value = "/inspection/selectIncome_result3", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result3(@ModelAttribute SYIncome_resultVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	// saveIncome_result3
	@ResponseBody
	@RequestMapping(value = "/inspection/saveIncome_result3", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveIncome_result3(@ModelAttribute SYIncome_resultVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	public String saveIncome_result2(@ModelAttribute SYIncome_resultVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/trhis/selectTool_replacement_his", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectTool_replacement_his(@ModelAttribute SYtool_repmt_hisVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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

	@ResponseBody
	@RequestMapping(value = "/trhis/saveTool_replacement_his", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveTool_replacement_his(@ModelAttribute SYtool_repmt_hisVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/trhis/deleteTool_replacement_his", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteTool_replacement_his(@ModelAttribute SYtool_repmt_hisVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
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
	@RequestMapping(value = "/goal/selectItem", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectItem(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectItem() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectItem(vo);

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

	// KPI 월별 목표량 가져오기
	@ResponseBody
	@RequestMapping(value = "/goal/selectGoal", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoal(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoal() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoal(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoal", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoal(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoal() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8");
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8");
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8");
			try {
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8");
				vo.setGoal(goal);
			} catch (Exception e1) {

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

	// 1210 kpi설비 목표

	// KPI 월별 목표량 가져오기
	@ResponseBody
	@RequestMapping(value = "/goal/selectGoalMachine", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoalMachine(@ModelAttribute SYGoalVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectGoalMachine() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalMachine(vo);

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

	// KPI 월별 목표량 가져오기
	@ResponseBody
	@RequestMapping(value = "/goal/selectGoalMachineAll", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoalMachineAll(@ModelAttribute SYGoalVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectGoalMachineAll() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalMachineAll(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalMachine", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalMachine(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalMachine() is called.");

		JSONObject resultData = new JSONObject();
		try {
			String master_code = URLDecoder.decode(request.getParameter("master_code"), "UTF-8");
			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8");
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8");
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8");
			try {
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8");
				vo.setGoal(goal);
			} catch (Exception e1) {

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

	// 1210 kpi설비 목표

	// KPI 월별 목표량 가져오기
	@ResponseBody
	@RequestMapping(value = "/goal/selectGoalCustomer", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoalCustomer(@ModelAttribute SYGoalVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectGoalCustomer() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalCustomer(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalCustomer", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalCustomer(@ModelAttribute SYGoalVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("InfoController.saveGoalCustomer() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8");
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8");
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8");
			try {
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8");
				vo.setGoal(goal);
			} catch (Exception e1) {

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

	// 1210 kpi설비 목표

	// KPI 월별 목표량 가져오기
	@ResponseBody
	@RequestMapping(value = "/goal/selectGoalAccount", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoalAccount(@ModelAttribute SYGoalVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectGoalAccount() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalAccount(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalAccount", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalAccount(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8");
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8");
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8");
			try {
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8");
				vo.setGoal(goal);
			} catch (Exception e1) {

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

	// 1215 kpi생산 목표

	// KPI 월별 목표량 가져오기
	@ResponseBody
	@RequestMapping(value = "/goal/selectGoalPrdct", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoalPrdct(@ModelAttribute SYGoalVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectGoalPrdct() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalPrdct(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalPrdct", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalPrdct(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalPrdct() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8");
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8");
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8");
			try {
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8");
				vo.setGoal(goal);
			} catch (Exception e1) {

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
	@RequestMapping(value = "/goal/selectGoalRpr", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoalRpr(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.selectGoalRpr() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalRpr(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalRpr", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalRpr(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalRpr() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8");
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8");
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8");
			try {
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8");
				vo.setGoal(goal);
			} catch (Exception e1) {

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

	// 1217 kpi생산 목표

	// KPI 월별 목표량 가져오기
	@ResponseBody
	@RequestMapping(value = "/goal/selectGoalDfct", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectGoalDfct(@ModelAttribute SYGoalVo vo, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("InfoController.selectGoalDfct() is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYGoalVo> dataList = sYGoalService.selectGoalDfct(vo);

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

	// KPI 목표설정
	@ResponseBody
	@RequestMapping(value = "/goal/saveGoalDfct", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveGoalDfct(@ModelAttribute SYGoalVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("InfoController.saveGoalDfct() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String code = URLDecoder.decode(request.getParameter("code"), "UTF-8");
			String year = URLDecoder.decode(request.getParameter("year"), "UTF-8");
			String month = URLDecoder.decode(request.getParameter("month"), "UTF-8");
			try {
				String goal = URLDecoder.decode(request.getParameter("goal"), "UTF-8");
				vo.setGoal(goal);
			} catch (Exception e1) {

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

	/**
	 * <pre>
	* 1. MethodName : Project
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > BOM관리
	* 4. 작성자       : LEEJUNGHOON
	* 5. 작성일       : 2021. 04. 29.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// selectBOMbyProject
	@ResponseBody
	@RequestMapping(value = "/info/selectBOMbyProject", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectBOMbyProject(@ModelAttribute SYTProjectVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectBOMbyProject is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYTProjectVo> dataList = sYInfoService.selectBOMbyProject(vo);

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

	@ResponseBody
	@RequestMapping(value = "/info/selectBOMbyPRO", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectBOMbyPRO(@ModelAttribute SYTMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectBOMbyPRO is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYTMaterialVo> dataList = sYInfoService.selectBOMbyPRO(vo);

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

	@ResponseBody
	@RequestMapping(value = "/info/selectMaterialsBOM", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterialsBOM(@ModelAttribute SYTMaterialVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectMaterialsBOM is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYTMaterialVo> dataList = sYInfoService.selectMaterialsBOM(vo);

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

	@ResponseBody
	@RequestMapping(value = "/info/InsertMaterialsBOM", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public int InsertMaterialsBOM(HttpServletRequest request, @RequestParam String jsonData) {
		List<Map<String, Object>> vo = null;

		logger.debug("FrontendController.InsertMaterialsBOM is called.");

		String REG_ID = SessionUtil.getMemberId(request);

		ObjectMapper mapper = new ObjectMapper();
		TypeReference<List<HashMap<String, Object>>> typeRef = new TypeReference<List<HashMap<String, Object>>>() {
		};
		try {
			vo = mapper.readValue(jsonData, typeRef);
			System.out.println("Dd");
		} catch (IOException e1) {
			System.out.println(e1);
			e1.printStackTrace();
		}
		for (int i = 0; i < vo.size(); i++) {
			vo.get(i).put("REG_ID", REG_ID);
		}

		int result = 0;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			result = sYInfoService.InsertMaterialsBOM(vo);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return result;
	}

	// change BOM Material Quantity
	@ResponseBody
	@RequestMapping(value = "/info/updateBomQuantity", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateBomQuantity(@ModelAttribute SYTBomVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.changeBOMQuantity is called.");

		vo.setBOM_REG_ID(SessionUtil.getMemberId(request));
		vo.setBOM_REG_DT(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String PJT_IDX = "";
			String MTL_IDX = "";
			String BOM_MTL_QTY = "";

			int cnt = 0;

			PJT_IDX = request.getParameter("PJT_IDX");
			MTL_IDX = request.getParameter("MTL_IDX");
			BOM_MTL_QTY = request.getParameter("BOM_MTL_QTY");

			// hKey
			vo.setPJT_IDX(Integer.parseInt(PJT_IDX));
			vo.setMTL_IDX(Integer.parseInt(MTL_IDX));

			cnt = sYInfoService.updateBomQuantity(vo);

			System.out.println("BCO_IDX = " + PJT_IDX);
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	/**
	 * <pre>
	* 1. MethodName : Material Request
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 구매/자재 관리 > 자재 요청 관리
	* 4. 작성자       : DEV_LEEJUNGHUN
	* 5. 작성일       : 2021. 05. 03.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// selectMaterialRequest
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/info/selectMaterialRequest", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectMaterialRequest(@ModelAttribute SYTMaterialRequestVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectMaterialRequest is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"), "UTF-8" );

			/*
			 * String PJT_IDX = ""; PJT_IDX = request.getParameter("PJT_IDX");
			 * vo.setPJT_IDX( Integer.parseInt(PJT_IDX) );
			 */

			List<SYTMaterialRequestVo> dataList = sYInfoService.selectMaterialRequest(vo);

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

	// insertMaterialRequest
	@ResponseBody
	@RequestMapping(value = "/info/insertMaterialRequest", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public int insertMaterialRequest(HttpServletRequest request, @RequestParam String jsonData) {
		List<Map<String, Object>> vo = null;

		logger.debug("FrontendController.insertMaterialRequest is called.");

		String REG_ID = SessionUtil.getMemberId(request);
		String MTL_REQ_TYPE = "자재불출요청";

		ObjectMapper mapper = new ObjectMapper();
		TypeReference<List<HashMap<String, Object>>> typeRef = new TypeReference<List<HashMap<String, Object>>>() { };
		try {
			vo = mapper.readValue(jsonData, typeRef);
			System.out.println("Dd");
		} catch (IOException e1) {
			System.out.println(e1);
			e1.printStackTrace();
		}
		for (int i = 0; i < vo.size(); i++) {
			vo.get(i).put("REG_ID", REG_ID);
			vo.get(i).put("MTL_REQ_TYPE", MTL_REQ_TYPE);
		}

		int result = 0;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			result = sYInfoService.insertMaterialRequest(vo);//자재요청내역 저장
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return result;
	}

	// deleteMaterialRequest
	@ResponseBody
	@RequestMapping(value = "/account/deleteMaterialRequest", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteClient(@ModelAttribute SYTMaterialRequestVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteMaterialRequest(vo);

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

	
	//change Request Material Quantity
	@ResponseBody
	@RequestMapping(value = "/info/updateReqQuantity", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateReqQuantity(@ModelAttribute SYTMaterialRequestVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.changeBOMQuantity is called.");

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String MTL_REQ_IDX = "0";
			String MTL_REQ_QTY = "0";

			int cnt = 0;

			MTL_REQ_IDX = request.getParameter("MTL_REQ_IDX");
			MTL_REQ_QTY = request.getParameter("MTL_REQ_QTY");
			
			// hKey
			vo.setMTL_REQ_IDX(Integer.parseInt(MTL_REQ_IDX));
			vo.setMTL_REQ_QTY(MTL_REQ_QTY);

			cnt = sYInfoService.updateReqQuantity(vo);

			System.out.println("BCO_IDX = " + MTL_REQ_IDX);
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}	

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/info/selectMaterialD", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectMaterialD(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "jsonData") String jsonData) {

		logger.debug("FrontendController.selectMaterialD is called.");

		List<Map<String, Object>> vo = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();

		String REG_ID = SessionUtil.getMemberId(request);

		ObjectMapper mapper = new ObjectMapper();
		TypeReference<List<HashMap<String, Object>>> typeRef = new TypeReference<List<HashMap<String, Object>>>() {
		};
		try {
			vo = mapper.readValue(jsonData, typeRef);
		} catch (IOException e1) {
			System.out.println(e1);
			e1.printStackTrace();
		}
		try {
			List<SYTMaterialVo> dataList = sYInfoService.selectMaterialD(vo);

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


	/**
	 * <pre>
	* 1. MethodName : insertBOMExcel
	* 2. ClassName  : infoController.java
	* 3. Comment    : 관리자 > 기준정보관리 > BOM 관리 엑셀일괄업로드
	* 4. 작성자       : LJH
	* 5. 작성일       : 2021. 05. 05.
	 * </pre>
	 *
	 * @param testData, request
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/info/insertBOMExcel", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public int insertBOMExcel(MultipartHttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> testData) {
			//파일 업로드를 위한 준비
					OutputStream out = null;
					PrintWriter printWriter = null;
					MultipartFile file = request.getFile("excelFile");
					String[] colmn = {
							"MTL_IDX", "TYPE", "MTL_MKR_NO", "MTL_MKR_CD", "MTL_QTY", "DSNUM"
					};
					List<Map<String, Object>> vo = excelUpload.excelRead(file, colmn); //엑셀의 데이터 파싱함 (단 xlsx만가능)
					
					//파싱된데이터에 pjt_idx를 주입할준비
					Object Pjt = testData.get("pjidxHidden");
					String REG_ID = SessionUtil.getMemberId(request);
					
					for(int i=0; i<vo.size(); i++) {
						vo.get(i).put("PJT_IDX", Pjt);
						vo.get(i).put("REG_ID", REG_ID);
					}//pjt_idx를 주입함
					
					int result = sYInfoService.InsertBOMExcel(vo);
			return result;
		
	}
	/**
	 * <pre>
	* 1. MethodName : insertestimateVExcel
	* 2. ClassName  : infoController.java
	* 3. Comment    : 관리자 > 기준정보관리 > 구매견적관리(V)
	* 4. 작성자       : LJH
	* 5. 작성일       : 2021. 05. 07.
	 * </pre>
	 *
	 * @param testData, request
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/info/insertestimateVExcel", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public Map<String,Object> insertestimateVExcel(MultipartHttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> testData) {
			//파일 업로드를 위한 준비
					HashMap <String,Object> resultMap = new HashMap<String,Object>();	
					OutputStream out = null;
					PrintWriter printWriter = null;
					MultipartFile file = request.getFile("excelFile");
					String[] colmn = {
							"EST_IDX", "c1","c2", "c3", "c4", "c5","c6","c7",
							"MTL_EST_MOQ","c8","c9","MTL_EST_PRICE","MTL_TOT_PRICE","MTL_EST_DLV_DT","MTL_EST_BG"
					};
					String errors = "";
					List<Map<String, Object>> vo = excelUpload.excelRead(file, colmn); //엑셀의 데이터 파싱함 (단 xlsx만가능)
					int rownum=1;
					Boolean sucess = true;
					int maxsize = vo.size();
					for(int i=1; i<maxsize; i++) {
						try {
							vo.get(rownum).putAll(isval(vo.get(rownum), rownum));
							if("N".equals((String)vo.get(rownum).get("results"))) {
								vo.remove(rownum);
								errors+=rownum+" ";
								sucess=false;
							}else {
								rownum++;
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					vo.remove(0);
				
			 int result=sYInfoService.insertestimateV(vo);
			 resultMap.put("sucess",sucess);
			 resultMap.put("errors",errors);
			return resultMap;
		
	}
	public Map<String,Object> isval(Map<String,Object> vo, int i) throws Exception{
		try {
			int test=0; 
			if(!vo.containsKey("MTL_EST_MOQ")) {
				vo.put("MTL_EST_MOQ",0);
			}//EST_MOQ에 값을넣어둔다. 안하면 포이치에서 에러남
			else {
				test = Integer.parseInt((String)vo.get("MTL_EST_MOQ"));
			}
			
			if(!vo.containsKey("MTL_EST_PRICE")) {
				vo.put("MTL_EST_PRICE",0);
			}
			else {
				test = Integer.parseInt((String)vo.get("MTL_EST_PRICE"));
			}
			if(!vo.containsKey("MTL_EST_DLV_DT")) {
				vo.put("MTL_EST_DLV_DT",null);
			}
			if(!vo.containsKey("MTL_EST_BG")) {
				vo.put("MTL_EST_BG",null);
			}
				vo.put("results","Y");
		}catch (Exception e) {
			System.out.println((i) +"번쨰의 컬럼에 유효성 문제가 발생하였습니다.");
			System.out.println("원인은\n"+e +" \n 입니다");
			vo.put("results","N");
		}
		
		return vo;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/account/test", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public Map<String,Object> test(MultipartHttpServletRequest request, HttpServletResponse response,
			@RequestParam("files") MultipartFile file
			,@RequestParam Map<String, Object> testData) {
		String basePath="/upload";
		System.out.println("패스는 "+basePath+"\n\n\n\n");
		
		Map<String, Object> result = fileUpload.savePDF(file, basePath, request);
		return result;
	}
	
	
	@RequestMapping(value = "/pdfViewer", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView product_pdfViewer(HttpServletRequest request, HttpServletResponse response, HttpSession session
			,@RequestParam("path") String path
			) {
		// logger.debug("CommonController.pdfViewer() is called.");
		ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("file_path",path);
			modelAndView.addObject("isPDFs","Y");
			modelAndView.setViewName("common/pdf_viewer");

		return modelAndView;
	}

	
	/**
	 * <pre>
	* 1. MethodName : Estimate
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 구매/자재 관리 > 구매 견적 관리
	* 4. 작성자       : DEV_KIMDEUKYONG
	* 5. 작성일       : 2021. 05. 05.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// selectMaterialRequest
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/info/selectEstimate", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectEstimate(@ModelAttribute SYTEstimateVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectEstimate is called.");
		try{
			if(session.getAttribute("member_vdr_idx")!=null) {
				String mem_vdr_idx=(String)session.getAttribute("member_vdr_idx");
				vo.setVDR_IDX(Integer.parseInt(mem_vdr_idx));
			};
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYTEstimateVo> dataList = sYInfoService.selectEstimate(vo);

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

	// insertEstimate
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
			for(int i=0; i<4;i++) {
				Map<String, Object> valueMap = new HashMap();
				//초기화하지않으면 계속 같은값이 들어감.
				valueMap.putAll(vo.get(0));
				//a = b로하면 메모리가 같아져서 같은값이 들어감
				if(!"ALL".equals((String)valueMap.get("S_VDR_IDX"+i))){
					valueMap.put("VDR_IDX",valueMap.get("S_VDR_IDX"+i));
					valueList.add(valueMap);
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
			result = sYInfoService.insertEstimate(valueList);//자재요청내역 저장
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		
		return result;
	}
	//change Estimate Contents
	@ResponseBody
	@RequestMapping(value = "/info/updateEstVendor", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateEstVendor(@ModelAttribute SYTEstimateVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.updateEstVendor is called.");

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {		
			int cnt = 0;

			String EST_IDX = request.getParameter("EST_IDX");
			String MTL_EST_MOQ = request.getParameter("MTL_EST_MOQ");
			String MTL_EST_PRICE = request.getParameter("MTL_EST_PRICE");
			String MTL_EST_DLV_DT = request.getParameter("MTL_EST_DLV_DT");
			String MTL_EST_BG = request.getParameter("MTL_EST_BG");
			
			/* 날짜 초기화
			 * if(MTL_EST_DLV_DT == null || MTL_EST_DLV_DT.equals("") ||
			 * MTL_EST_DLV_DT.equals("null")) { MTL_EST_DLV_DT = new
			 * SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()); }
			 */
			
			// hKey
			vo.setEST_IDX(Integer.parseInt(EST_IDX));
			vo.setMTL_EST_MOQ(MTL_EST_MOQ);
			vo.setMTL_EST_PRICE(MTL_EST_PRICE);
			vo.setMTL_EST_DLV_DT(MTL_EST_DLV_DT);
			vo.setMTL_EST_BG(MTL_EST_BG);

			cnt = sYInfoService.updateEstVendor(vo);

			System.out.println("EST_IDX = " + EST_IDX);
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}	
	// deleteEstimate
	@ResponseBody
	@RequestMapping(value = "/account/deleteEstimate", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteClient(@ModelAttribute SYTEstimateVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteAccount() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYInfoService.deleteEstimate(vo);

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

	/**
	 * <pre>
	* 1. MethodName : Order
	* 2. ClassName  : InfoController.java
	* 3. Comment    : 관리자 > 구매/자재 관리 > 구매발주 관리
	* 4. 작성자       : DEV_KIMDEUKYONG
	* 5. 작성일       : 2021. 05. 07.
	 * </pre>
	 *
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	// selectMaterialRequest
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/info/selectMaterialOrder", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectMaterialOrder(@ModelAttribute SYTMaterialOrderVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectMaterialOrder is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYTMaterialOrderVo> dataList = sYInfoService.selectMaterialOrder(vo);

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
	//selectMaterialOrdDtl
	@ResponseBody
	@RequestMapping(value = "/info/selectMaterialOrdDTL", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public String selectMaterialOrdDTL(@ModelAttribute SYTMaterialOrderVo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.selectMaterialOrder is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYTMaterialOrderVo> dataList = sYInfoService.selectMaterialOrdDTL(vo);

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
	// insertMaterialOrder
	@ResponseBody
	@RequestMapping(value = "/info/insertMaterialOrder", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public int insertMaterialOrder(HttpServletRequest request, @RequestParam String jsonData) {
		HashMap<String, Object> vo = null;

		logger.debug("FrontendController.insertMaterialRequest is called.");

		String REG_ID = SessionUtil.getMemberId(request);
		
		ObjectMapper mapper = new ObjectMapper();
		TypeReference<HashMap<String, Object>> typeRef = new TypeReference<HashMap<String, Object>>() { };
		try {
			vo = mapper.readValue(jsonData, typeRef);
			System.out.println(vo);
		} catch (IOException e1) {
			System.out.println(e1);
			e1.printStackTrace();
		}

		int result = 0;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		
		try {
			Map<String, Object> mstMap = (Map<String, Object>) vo.get("mstData");
			mstMap.put("MTL_ORD_REG_ID", REG_ID);
			result = sYInfoService.insertMaterialOrderMST(mstMap);//발주내역 저장 return ORD_IDX
			if(result > 0) {
				List<Map<String, Object>> list = (List<Map<String, Object>>) vo.get("reqDataList");
				for(Map<String, Object> map : list) {
					map.put("ORD_IDX", mstMap.get("ORD_IDX"));
				}
				System.out.println(list);
				result = sYInfoService.insertMaterialOrder(list);//발주내역 저장
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return result;
	}	
	// saveBranch
	@ResponseBody
	@RequestMapping(value = "/info/updateAllMTL", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateAllMTL(@ModelAttribute SYTMaterialOrderVo vo, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveAccount is called.");

		vo.setMTL_ORD_REG_ID(SessionUtil.getMemberId(request));
		
		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			String ORD_IDX = "";
			int cnt = 0;
			int chkOrder = 0;
			
			String flag = request.getParameter("flag");

			ORD_IDX = request.getParameter("ord_IDX");
			vo.setORD_IDX(Integer.parseInt(ORD_IDX));
			
			//구매발주 상태 체크
			chkOrder = sYInfoService.chkOrdStatus(vo);
			if(chkOrder > 0) {
				//vo.get
			}
			//if(!old_rcC.equals("")) { System.out.println("old_rcC.substring(0, 1) = " +

			String MTL_ORD_STATUS = vo.getMTL_ORD_STATUS();// 등록된 CST_IDX 값 가져오기
			
			//ORD_IDX 세팅
			vo.setORD_IDX(Integer.parseInt(ORD_IDX));
			
			cnt = sYInfoService.updateAllMTL(vo);
			

			System.out.println("ORD_IDX = " + ORD_IDX);
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}	
	
}