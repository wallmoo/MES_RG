package kr.co.passcombine.set.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.util.HSSFColor.GOLD;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.passcombine.set.dao.SYWarehousingDAO;
import kr.co.passcombine.set.svc.SYDeliveryOrderService;
import kr.co.passcombine.set.svc.SYDeliveryService;
import kr.co.passcombine.set.svc.SYDrwFileService;
import kr.co.passcombine.set.svc.SYInspService;
import kr.co.passcombine.set.svc.SYInstrumentService;
import kr.co.passcombine.set.svc.SYMachineMonitorService;
import kr.co.passcombine.set.svc.SYOrderService;
import kr.co.passcombine.set.svc.SYOverhaulService;
import kr.co.passcombine.set.svc.SYProductService;
import kr.co.passcombine.set.svc.SYPurchaseOrderService;
import kr.co.passcombine.set.svc.SYQualityFileService;
import kr.co.passcombine.set.svc.SYSelfInspFailService;
import kr.co.passcombine.set.svc.SYWarehouseService;
import kr.co.passcombine.set.svc.SYWarehousingService;
import kr.co.passcombine.set.svc.SYKPIService;
import kr.co.passcombine.set.svc.SYClaimService;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.StringUtil;
import kr.co.passcombine.set.vo.KPI_Per_Vo;
import kr.co.passcombine.set.vo.SYClaimVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYDeliveryOrderVo;
import kr.co.passcombine.set.vo.SYDeliveryVo;
import kr.co.passcombine.set.vo.SYDrwFileInfoVo;
import kr.co.passcombine.set.vo.SYFileVo;
import kr.co.passcombine.set.vo.SYGoalVo;
import kr.co.passcombine.set.vo.SYInspVO;
import kr.co.passcombine.set.vo.SYInstrumentVo;
import kr.co.passcombine.set.vo.SYItem_fairVo;
import kr.co.passcombine.set.vo.SYKPI_OperationVo;
import kr.co.passcombine.set.vo.SYKPI_ProductVo;
import kr.co.passcombine.set.vo.SYKPI_PurchaseVo;
import kr.co.passcombine.set.vo.SYKPI_RepairVo;
import kr.co.passcombine.set.vo.SYKPI_SalesVo;
import kr.co.passcombine.set.vo.SYMachineMonitorInfoVO;
import kr.co.passcombine.set.vo.SYMachineMonitorVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYProductAnalysisVO;
import kr.co.passcombine.set.vo.SYProductMonitoringVO;
import kr.co.passcombine.set.vo.SYProductOperStatusVO;
import kr.co.passcombine.set.vo.SYProductOperationVO;
import kr.co.passcombine.set.vo.SYProductUnOperationVO;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYPurchaseOrderVo;
import kr.co.passcombine.set.vo.SYQualityFileVo;
import kr.co.passcombine.set.vo.SYRepairAnalysisVo;
import kr.co.passcombine.set.vo.SYRepairVo;
import kr.co.passcombine.set.vo.SYSelf_InspFailVo;
import kr.co.passcombine.set.vo.SYWareHouseRawVo;
import kr.co.passcombine.set.vo.SYWareHousingVo;
import kr.co.passcombine.set.vo.SYWarehouseOutVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterDVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterHVo;
 

@Controller
@RequestMapping("/frontend")
public class FrontendController {
	private static final Logger logger = LoggerFactory
			.getLogger(FrontendController.class);

	@Inject
	private FileSystemResource fsResource;
	
	@Resource(name = "setOrderService")
	SYOrderService sYOrderService;

	@Resource(name = "setDeliveryService")
	SYDeliveryService sYDeliveryService;
	
	@Resource(name = "setDeliveryOrderService")
	SYDeliveryOrderService sYDeliveryOrderService;
	
	@Resource(name = "setDrwFileService")
	SYDrwFileService sYDrwFileService;
	
	@Resource(name = "setQualityFileService")
	SYQualityFileService sYQualityFileService;
	
	@Resource(name = "setPurchaseOrderService")
	SYPurchaseOrderService sYPurchaseOrderService;

	@Resource(name = "setWarehousingService")
	SYWarehousingService sYWarehousingService;
	
	@Resource(name = "setProductService")
	SYProductService sYProductService;
	
	@Resource(name = "setOverhaulService")
	SYOverhaulService sYOverhaulService;
	
	@Resource(name = "setWarehouseService")
	SYWarehouseService sYWarehouseService;
	
	@Resource(name = "setInstrumentService")
	SYInstrumentService sYInstrumentService;
	
	@Resource(name = "setClaimService")
	SYClaimService sYClaimService;
	
	@Resource(name = "setInspService")
	SYInspService sYInspService;
	
	@Resource(name = "setMachineMonitorService")
	SYMachineMonitorService sYMachineMonitorService;
	
	@Resource(name = "setKPIService")
	SYKPIService sYKPIService;
	
	@Resource(name = "setSelfInspFailService")
	SYSelfInspFailService sYSelfInspFailService;


	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView frontendMenuNavigation(@PathVariable String menu_div,
			@PathVariable String menu_page, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.frontendMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("frontend/" + menu_div + "/" + menu_page);

		if ("materials_process_sub_medi".equals(menu_page)) {
			modelAndView.addObject("routing_no", request.getParameter("routing_no"));
			modelAndView.addObject("routing_gno", request.getParameter("routing_gno"));
		} else if ("materials_process_sub_optImg".equals(menu_page)) {
			modelAndView.addObject("routing_no", request.getParameter("routing_no"));
			modelAndView.addObject("routing_gno", request.getParameter("routing_gno"));
		}
		return modelAndView;
	}

	
	// selectOrderNum
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOrderNum", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOrderNum(@ModelAttribute SYOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOrderNum is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			String order_num = sYOrderService.selectOrderNum();

			System.out.println("order_num");
			System.out.println(order_num);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("order_num", order_num);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("order_num", null);
		}
		return resultData.toJSONString();
	}
	// selectOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOrder", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOrder(@ModelAttribute SYOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOrder is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYOrderVo> dataList = sYOrderService.selectOrder(vo);

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
	
	// selectOrderAll
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOrderAll", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOrderAll(@ModelAttribute SYOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOrderAll is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYOrderVo> dataList = sYOrderService.selectOrderAll(vo);

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
	
	// selectOrder2
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOrder2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOrder2(@ModelAttribute SYOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOrder is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYOrderVo> dataList = sYOrderService.selectOrder2(vo);

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
	
	// selectOrderPlan
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOrderPlan", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOrderPlan(@ModelAttribute SYOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOrderPlan is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYOrderVo> dataList = sYOrderService.selectOrderPlan(vo);

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
	
	// saveOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/saveOrder", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveOrder(@ModelAttribute SYOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveOrder() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String order_num = URLDecoder.decode(request.getParameter("order_num"), "UTF-8" );	
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			//String item_nm = URLDecoder.decode(request.getParameter("item_nm"), "UTF-8" );
			
			String tmp = request.getParameter("item_nm").replace("%", "%25");
			String item_nm = new String(URLDecoder.decode(tmp ,"UTF-8"));
			item_nm = item_nm.replace("%25", "%") ;
			//String fast_yn = URLDecoder.decode(request.getParameter("fast_yn"), "UTF-8" );	
			
			String delivery_date = URLDecoder.decode(request.getParameter("delivery_date"), "UTF-8" );
			String customer_code = URLDecoder.decode(request.getParameter("customer_code"), "UTF-8" );
			String customer_nm = URLDecoder.decode(request.getParameter("customer_nm"), "UTF-8" );
			String request_num = URLDecoder.decode(request.getParameter("request_num"), "UTF-8" );
			
			String manager_nm = URLDecoder.decode(request.getParameter("manager_nm"), "UTF-8" );
			String land = URLDecoder.decode(request.getParameter("land"), "UTF-8" );
			
			String unit_price = URLDecoder.decode(request.getParameter("unit_price"), "UTF-8" );
			String menge = URLDecoder.decode(request.getParameter("menge"), "UTF-8" );
			String total_price = URLDecoder.decode(request.getParameter("total_price"), "UTF-8" );
			String success_status = URLDecoder.decode(request.getParameter("success_status"), "UTF-8" );		
	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setOrder_num(order_num);
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);
			
			vo.setDelivery_date(delivery_date);
			vo.setCustomer_code(customer_code);
			vo.setCustomer_nm(customer_nm);
			vo.setRequest_num(request_num);

			vo.setManager_nm(manager_nm);
			vo.setLand(land);
			
			vo.setUnit_price(unit_price);
			vo.setMenge(menge);
			vo.setTotal_price(total_price);
			vo.setSuccess_status(success_status);
			//vo.setFast_yn(fast_yn);
	
			int cnt = sYOrderService.saveOrder(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	// deleteOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/deleteOrder", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteOrder(@ModelAttribute SYOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteOrder() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYOrderService.deleteOrder(vo);

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
	
	
	// deleteOrder2
	@ResponseBody
	@RequestMapping(value = "/consumable/deleteOrder2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteOrder2(@ModelAttribute SYOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteOrder2() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = sYOrderService.deleteOrder2(vo);
			
			if(result == 888){
				resultData.put("status", 777);
			}else if (result == 0){
				
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", result);
			}

			System.out.println("result = " + result);

			
		} catch(Exception e){
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", 0);
		}
		return resultData.toJSONString();
	}
	
	
	
	// selectOrderProduct
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOrderProduct", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOrderProduct(@ModelAttribute SYOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOrderProduct is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYOrderVo> dataList = sYOrderService.selectOrderProduct(vo);

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
	
	//--------------------------------------------------------------------------------
	// Delivery Order
	
	// selectDeliveryOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/selectDeliveryOrder", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectDeliveryOrder(@ModelAttribute SYDeliveryOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectDeliveryOrder is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYDeliveryOrderVo> dataList = sYDeliveryOrderService.selectDeliveryOrder(vo);

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

	
	// saveDeliveryOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/saveDeliveryOrder", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveDeliveryOrder(@ModelAttribute SYDeliveryOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveDeliveryOrder() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String delivery_num = URLDecoder.decode(request.getParameter("delivery_num"), "UTF-8" );	
			String delivery_order_menge = URLDecoder.decode(request.getParameter("delivery_order_menge"), "UTF-8" );
			String delivery_order_date = URLDecoder.decode(request.getParameter("delivery_order_date"), "UTF-8" );
			
			String order_num = URLDecoder.decode(request.getParameter("order_num"), "UTF-8" );
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String item_nm = URLDecoder.decode(request.getParameter("item_nm"), "UTF-8" );
			
			String delivery_req_date = URLDecoder.decode(request.getParameter("delivery_req_date"), "UTF-8" );
			String customer_code = URLDecoder.decode(request.getParameter("customer_code"), "UTF-8" );
			String customer_nm = URLDecoder.decode(request.getParameter("customer_nm"), "UTF-8" );
			String land = URLDecoder.decode(request.getParameter("land"), "UTF-8" );
		
			String unit_price = URLDecoder.decode(request.getParameter("unit_price"), "UTF-8" );
			String menge = URLDecoder.decode(request.getParameter("menge"), "UTF-8" );
			String total_price = URLDecoder.decode(request.getParameter("total_price"), "UTF-8" );
			String success_status = URLDecoder.decode(request.getParameter("success_status"), "UTF-8" );		
	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setDelivery_num(delivery_num);
			vo.setDelivery_order_menge(delivery_order_menge);
			vo.setDelivery_order_date(delivery_order_date);
			
			vo.setOrder_num(order_num);
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);
			
			vo.setDelivery_req_date(delivery_req_date);
			vo.setCustomer_code(customer_code);
			vo.setCustomer_nm(customer_nm);
			vo.setLand(land);
			
			vo.setUnit_price(unit_price);
			vo.setMenge(menge);
			vo.setTotal_price(total_price);
			vo.setSuccess_status(success_status);
	
			int cnt = sYDeliveryOrderService.saveDeliveryOrder(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	// saveDeliveryOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/saveDeliveryOrder2", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveDeliveryOrder2(@ModelAttribute SYOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveDeliveryOrder() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		try {

			
			String gridData = request.getParameter("gridData");
		
			
			String order_num = URLDecoder.decode(request.getParameter("order_num"), "UTF-8" );
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String item_nm = URLDecoder.decode(request.getParameter("item_nm"), "UTF-8" );
			
			String delivery_req_date = URLDecoder.decode(request.getParameter("delivery_req_date"), "UTF-8" );
			String customer_code = URLDecoder.decode(request.getParameter("customer_code"), "UTF-8" );
			String customer_nm = URLDecoder.decode(request.getParameter("customer_nm"), "UTF-8" );
			String land = URLDecoder.decode(request.getParameter("land"), "UTF-8" );
		
			String unit_price = URLDecoder.decode(request.getParameter("unit_price"), "UTF-8" );
			String menge = URLDecoder.decode(request.getParameter("menge"), "UTF-8" );
			String total_price = URLDecoder.decode(request.getParameter("total_price"), "UTF-8" );

	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			vo.setOrder_num(order_num);
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);
			
			vo.setDelivery_date(delivery_req_date);
			vo.setCustomer_code(customer_code);
			vo.setCustomer_nm(customer_nm);
			vo.setLand(land);
			
			vo.setUnit_price(unit_price);
			vo.setMenge(menge);
			vo.setTotal_price(total_price);

			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYDeliveryOrderVo> list = new ArrayList<SYDeliveryOrderVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYDeliveryOrderVo dVo = new SYDeliveryOrderVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
//					String old_rcC = "";
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					
					if( "delivery_num".equals(nKey) ) dVo.setDelivery_num(nValue);
					else if( "delivery_order_menge".equals(nKey) ) dVo.setDelivery_order_menge(nValue);
					else if( "delivery_order_date".equals(nKey) ) dVo.setDelivery_order_date(nValue);
					
					else if( "success_status".equals(nKey) ) dVo.setSuccess_status(nValue);
				}
				
				
				list.add(dVo);
			}
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYDeliveryOrderService.saveDeliveryOrder2(list, vo);
			
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
	// saveDeliveryOrderAll
	@ResponseBody
	@RequestMapping(value = "/consumable/saveDeliveryOrderAll", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveDeliveryOrderAll(@ModelAttribute SYOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveDeliveryOrderAll() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		try {
	
			String gridData = request.getParameter("gridData");
	
			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYDeliveryOrderVo> list = new ArrayList<SYDeliveryOrderVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYDeliveryOrderVo dVo = new SYDeliveryOrderVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					 if( "order_num".equals(nKey) ) dVo.setOrder_num(nValue);
					else if( "item_code".equals(nKey) ) dVo.setItem_code(nValue);
					else if( "item_nm".equals(nKey) ) dVo.setItem_nm(nValue);
					else if( "delivery_req_date".equals(nKey) ) dVo.setDelivery_req_date(nValue);
					else if( "customer_code".equals(nKey) ) dVo.setCustomer_code(nValue);
					else if( "customer_nm".equals(nKey) ) dVo.setCustomer_nm(nValue);
					else if( "land".equals(nKey) ) dVo.setLand(nValue);
					else if( "unit_price".equals(nKey) ) dVo.setUnit_price(nValue);
					else if( "menge".equals(nKey) ) dVo.setMenge(nValue);
					else if( "total_price".equals(nKey) ) dVo.setTotal_price(nValue);

					else if( "delivery_num".equals(nKey) ) dVo.setDelivery_num(nValue);
					else if( "delivery_order_menge".equals(nKey) ) dVo.setDelivery_order_menge(nValue);
					else if( "delivery_order_date".equals(nKey) ) dVo.setDelivery_order_date(nValue);
					
					else if( "success_status".equals(nKey) ) dVo.setSuccess_status(nValue);
				}
				
				
				list.add(dVo);
			}
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYDeliveryOrderService.saveDeliveryOrderAll(list);
			
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
	
	// deleteDeliveryOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/deleteDeliveryOrder", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteDeliveryOrder(@ModelAttribute SYDeliveryOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteDeliveryOrder() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYDeliveryOrderService.deleteDeliveryOrder(vo);

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
	
	// delDeliveryOrder
		@ResponseBody
		@RequestMapping(value = "/consumable/delDeliveryOrder", method = { RequestMethod.GET,
				RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String delDeliveryOrder(@ModelAttribute SYDeliveryOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.delDeliveryOrder() is called.");

			JSONObject resultData = new JSONObject();
			try {


				int result = 0;

				result = sYDeliveryOrderService.delDeliveryOrder(vo);

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
	
	// updateSuccessStatus
	@ResponseBody
	@RequestMapping(value = "/consumable/updateSuccessStatus", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateSuccessStatus(@ModelAttribute SYDeliveryOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.updateSuccessStatus() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYDeliveryOrderService.updateSuccessStatus(vo);

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
	
	//--------------------------------------------------------------------------------
	// Delivery
	
	// selectDelivery
	@ResponseBody
	@RequestMapping(value = "/consumable/selectDelivery", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectDelivery(@ModelAttribute SYDeliveryVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectDelivery is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYDeliveryVo> dataList = sYDeliveryService.selectDelivery(vo);

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
	// saveDelivery
	@ResponseBody
	@RequestMapping(value = "/consumable/saveDelivery", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveDelivery(@ModelAttribute SYDeliveryVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveDelivery() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String delivery_num = URLDecoder.decode(request.getParameter("delivery_num"), "UTF-8" );	
			String delivery_menge = URLDecoder.decode(request.getParameter("delivery_menge"), "UTF-8" );
			String delivery_date = URLDecoder.decode(request.getParameter("delivery_date"), "UTF-8" );
			
			
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String item_nm = URLDecoder.decode(request.getParameter("item_nm"), "UTF-8" );
			String out_user = URLDecoder.decode(request.getParameter("out_user"), "UTF-8" );
			String out_comment = URLDecoder.decode(request.getParameter("out_comment"), "UTF-8" );
	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setDelivery_num(delivery_num);
			vo.setDelivery_menge(delivery_menge);
			vo.setDelivery_date(delivery_date);
			
			
	
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);

	
			int cnt = sYDeliveryService.saveDelivery(vo,out_user,out_comment);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	// saveDelivery
	@ResponseBody
	@RequestMapping(value = "/consumable/saveDeliveryMulti", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveDeliveryMulti(@ModelAttribute SYDeliveryVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveDelivery() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String delivery_num = URLDecoder.decode(request.getParameter("delivery_num"), "UTF-8" );	
			String delivery_menge = URLDecoder.decode(request.getParameter("delivery_menge"), "UTF-8" );
			String delivery_date = URLDecoder.decode(request.getParameter("delivery_date"), "UTF-8" );
			String real_send_delivery_menge = URLDecoder.decode(request.getParameter("real_send_delivery_menge"), "UTF-8" );
			
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String item_nm = URLDecoder.decode(request.getParameter("item_nm"), "UTF-8" );
			String out_user = URLDecoder.decode(request.getParameter("out_user"), "UTF-8" );
			String out_comment = URLDecoder.decode(request.getParameter("out_comment"), "UTF-8" );
	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setDelivery_num(delivery_num);
			vo.setDelivery_menge(delivery_menge);
			vo.setDelivery_date(delivery_date);
			vo.setReal_send_delivery_menge(real_send_delivery_menge);
			
	
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);

	
			int cnt = sYDeliveryService.saveDeliveryMulti(vo,out_user,out_comment);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}


	// deleteDelivery
	@ResponseBody
	@RequestMapping(value = "/consumable/deleteDelivery", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteDelivery(@ModelAttribute SYDeliveryVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteDelivery() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYDeliveryService.deleteDelivery(vo);

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
	
	
	// DRW FILE
	
	
	
	/// drwfile fnCheckPN check
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/drwfile/fnCheckPN", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String fnCheckPN(@ModelAttribute SYDrwFileInfoVo vo, HttpServletRequest request) {
		logger.debug("FrontendController.fnCheckPN() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = sYDrwFileService.fnCheckPN(vo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}


	// select file
	@ResponseBody
	@RequestMapping(value = "/drwfile/selectDrwFile", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectDrwFile(@ModelAttribute SYDrwFileInfoVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectDrwFile() is called.");
		List<SYDrwFileInfoVo> listCode = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			listCode = sYDrwFileService.selectDrwFile(sVo);
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
	
	
	
	// delFileInfo
	@ResponseBody
	@RequestMapping(value="/drwfile/delFileInfo", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String delFileInfo(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("InfoController.delFileType is called.");
		
		SYDrwFileInfoVo vo = new SYDrwFileInfoVo();
		Map<String, Object> params = new HashMap<>();
		String[] keyCols = {"file_group", "file_no"};
		JSONObject resultData = new JSONObject();
		int cnt = 0;
		try {
			StringUtil.getArrayParams(params, request, vo, keyCols);
			params.put("creator", SessionUtil.getMemberId(request));
			params.put("updater", SessionUtil.getMemberId(request));
			cnt = sYDrwFileService.delFileInfo(params);
			
			resultData.put("status", HttpStatus.OK.value());
			
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		logger.debug(resultData.toJSONString());
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/drwfile/updFileInfo", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
	public String updFileInfo(@ModelAttribute SYDrwFileInfoVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("Filecontroller.updFileInfo() is called");
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = sYDrwFileService.updFileInfo(vo);
			resultData.put("status", HttpStatus.OK);
			resultData.put("data", result);
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return resultData.toJSONString();
	}
	
	
	//file_upload_cad
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/drwfile/file_upload", produces="text/html;charset=UTF-8")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String file_upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FrontendController.file_upload() is called.");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
	    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();

	    
	    String business_nm = request.getParameter("business_nm");
	    String item_code = request.getParameter("item_code");
	    String item_nm = request.getParameter("item_nm");
	    String drw_no = request.getParameter("drw_no");
	    String drw_nm = request.getParameter("drw_nm");
	    String file_type = request.getParameter("file_type");
	   
	    String revno = request.getParameter("file_rev_no");
	    String fileComment = request.getParameter("file_comment");
		logger.info("revno : " + revno);
		logger.info("fileComment : " + fileComment);
	    
	    String mode = request.getParameter("mode");


	    String cad_file_path= request.getParameter("cad_file_path");   
	    String cad_file_name= request.getParameter("cad_file_name");   
	    String cad_file_ext= request.getParameter("cad_file_ext");   
	    String cad_file_size= request.getParameter("cad_file_size");   
	    
	    
	    String pdf_file_path= request.getParameter("pdf_file_path");   
	    String pdf_file_name= request.getParameter("pdf_file_name");   
	    String pdf_file_ext= request.getParameter("pdf_file_ext");   
	    String pdf_file_size= request.getParameter("pdf_file_size");   

	    
	    String typeString = request.getParameter("typeString");

	    String nFileComment = "";
	    String nFileRevNo = "";
	    String file_group ="";
	    String file_no = "";
	    
	    String file_cate = "drw";
	    
	    if("upd".equals(mode)) {
	    
	    	nFileRevNo = request.getParameter("file_new_rev_no");
	    	nFileComment = request.getParameter("file_new_comment");
	    	
	    	file_group  = request.getParameter("file_group");
	    	file_no = request.getParameter("file_no");
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

			
				String strDir = fsResource.getPath() +"/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
				File d = new File(strDir);

				if(!d.isDirectory()) {
					d.mkdirs();
				}
				
				String str = (String) iter.next();
				List<MultipartFile> fileList =  map.get(str);
				List<SYDrwFileInfoVo> returnList = new ArrayList<SYDrwFileInfoVo>();

				SYDrwFileInfoVo fVo = new SYDrwFileInfoVo();
				if(file_group == null || file_group.equals("")){
					file_group = sYDrwFileService.selectFileKey();
					fVo.setFile_group(file_group);
				} else {
					fVo.setFile_group(file_group);
				}

				fVo.setBusiness_nm(business_nm);
				fVo.setItem_code(item_code);
				fVo.setItem_nm(item_nm);
				fVo.setDrw_no(drw_no);
				fVo.setDrw_nm(drw_nm);
		
				fVo.setFile_rev_no(revno);
				fVo.setFile_comment(fileComment);
				
				
				if("upd".equals(mode)) {
					
	
					fVo.setFile_new_rev_no(nFileRevNo);
					fVo.setFile_new_comment(nFileComment);
				}

				fVo.setFile_repo("1");
			
				if("".equals(cad_file_size) || cad_file_size == null)
				{
					cad_file_size = "0";
				}
				if("".equals(pdf_file_size) || pdf_file_size == null)
				{
					pdf_file_size = "0";
				}
				if(!"".equals(cad_file_path))
				{
					fVo.setCad_file_path(cad_file_path);
					fVo.setCad_file_name(cad_file_name);
					fVo.setCad_file_ext(cad_file_ext);
					fVo.setCad_file_size(Long.parseLong(cad_file_size));
				}
				if(!"".equals(pdf_file_path))
				{
					fVo.setPdf_file_path(pdf_file_path);
					fVo.setPdf_file_name(pdf_file_name);
					fVo.setPdf_file_ext(pdf_file_ext);
					fVo.setPdf_file_size(Long.parseLong(pdf_file_size));
				}
				int count = 0;
		
				try {	
					for(MultipartFile mpf : fileList) 
					{
					
						String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());		
						String currentType = "";
						try{
							if(typeString.contains("#")){
								String type[] = typeString.split("#");
								currentType = type[count];
							}else
							{
								currentType = typeString;
							}
						}catch(Exception e9)
						{
							e9.getMessage();
						}
		
					
						
						
						String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
						File localFile = new File(strDir + "_"+uid+"."+fileExt);
						OutputStream out = new FileOutputStream(localFile);
						out.write(mpf.getBytes());
						out.close();
						
					
						if("cad".equals(currentType)){
							fVo.setCad_file_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
							fVo.setCad_file_name(filename);
							fVo.setCad_file_ext(fileExt);
							fVo.setCad_file_size((localFile.length() / 1024));
						}else if("pdf".equals(currentType))
						{
							fVo.setPdf_file_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
							fVo.setPdf_file_name(filename);
							fVo.setPdf_file_ext(fileExt);
							fVo.setPdf_file_size((localFile.length() / 1024));
						}
						
						count++;
						
					}
					fVo.setFile_del_yn("N"); // 얘는 나중에 물어보기 
					
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));
					fVo.setFile_no(file_no);
					//selectFileKey , updFileInfo, insNewFileInfo , insFileInfo
					if("upd".equals(mode)) {
						SYDrwFileInfoVo updFileInfo = new SYDrwFileInfoVo();
						updFileInfo.setFile_final_yn("N");
						updFileInfo.setFile_group(fVo.getFile_group());
						updFileInfo.setFile_no(fVo.getFile_no());
						updFileInfo.setUpdater(SessionUtil.getMemberId(request));
						sYDrwFileService.updFileInfo(updFileInfo);
						
						fVo.setFile_final_yn("Y");
						sYDrwFileService.insNewFileInfo(fVo);
					}
					else if("ins".equals(mode)) {
						sYDrwFileService.insFileInfo(fVo);
					}
						
	 			} catch(Exception e) {
		 			e.printStackTrace();
		 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		 			resultData.put("rows", null);
	 			} finally {
	 			}
				
			}
		}
		return resultData.toJSONString();
	}
	
	// selectQualityFile
	@ResponseBody
	@RequestMapping(value = "/qualityfile/selectQualityFile", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectQualityFile(@ModelAttribute SYQualityFileVo sVo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectQualityFile() is called.");
		List<SYQualityFileVo> listCode = null;
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			listCode = sYQualityFileService.selectFile(sVo);
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
	//file_upload
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/qualityfile/quality_file_upload", produces="text/html;charset=UTF-8")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String quality_file_upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FileController.quality_file_upload() is called. ");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
	    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
	    		
	    
	    String item_code = request.getParameter("item_code");
	    String item_nm = request.getParameter("item_nm");
	    String file_name = request.getParameter("file_name");
	    String mode = request.getParameter("mode");
	
	    String file_cate = "quality_file";
	    if("upd".equals(mode)) {

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

				String strDir = fsResource.getPath() +"/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
				File d = new File(strDir);
								
				if(!d.isDirectory()) {
					d.mkdirs();
				}
				
				String str = (String) iter.next();
				List<MultipartFile> fileList =  map.get(str);
				
				List<SYQualityFileVo> returnList = new ArrayList<SYQualityFileVo>();
				
				for(MultipartFile mpf : fileList) {
				try {	
						String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());
						String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
						File localFile = new File(strDir + "_"+uid+"."+fileExt);
						
						OutputStream out = new FileOutputStream(localFile);
						out.write(mpf.getBytes());
						out.close();
						
						// DB에서 정보 저장하기 위한/
						SYQualityFileVo fVo = new SYQualityFileVo();
				
						
						fVo.setItem_code(item_code);
						fVo.setItem_nm(item_nm);
						
	
						fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
						fVo.setFile_name(file_name);
						fVo.setFile_ext(fileExt);
					
						fVo.setFile_size((localFile.length() / 1024));
			
						fVo.setUpdater(SessionUtil.getMemberId(request));

						
						if("upd".equals(mode)) {
	
							sYQualityFileService.updFileInfo(fVo);
						}
						else if("ins".equals(mode)) {
							fVo.setCreator(SessionUtil.getMemberId(request));
							sYQualityFileService.insFileInfo(fVo);
						}

						
						
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
	
	
	//--------------------------------------------------------------------------------
	// Purchase Order
	
	
	
	// selectPurchaseOrderNum
	@ResponseBody
	@RequestMapping(value = "/consumable/selectPurchaseOrderNum", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseOrderNum(@ModelAttribute SYPurchaseOrderVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseOrderNum is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			String order_num = sYPurchaseOrderService.selectPurchaseOrderNum();

			System.out.println("order_num");
			System.out.println(order_num);
	
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("order_num", order_num);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("order_num", null);
		}
		return resultData.toJSONString();
	}
	
	// selectPurchaseOrderMain
	@ResponseBody
	@RequestMapping(value = "/consumable/selectPurchaseOrderMain", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseOrderMain(@ModelAttribute SYPurchaseOrderDetailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseOrderMain is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPurchaseOrderDetailVo> dataList = sYPurchaseOrderService.selectPurchaseOrderMain(vo);

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
	
	// selectPurchaseOrderDetail
	@ResponseBody
	@RequestMapping(value = "/consumable/selectPurchaseOrderDetail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseOrderDetail(@ModelAttribute SYPurchaseOrderDetailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseOrderDetail is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPurchaseOrderDetailVo> dataList = sYPurchaseOrderService.selectPurchaseOrderDetail(vo);

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
	
	// savePurchaseOrderDetail
	@ResponseBody
	@RequestMapping(value = "/consumable/savePurchaseOrderDetail", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String savePurchaseOrderDetail(@ModelAttribute SYPurchaseOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.savePurchaseOrderDetail() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		try {

			
			String gridData = request.getParameter("gridData");
		
			
			String purchase_order_num= URLDecoder.decode(request.getParameter("purchase_order_num"), "UTF-8" );
			String purchase_status= URLDecoder.decode(request.getParameter("purchase_status"), "UTF-8" );
			String purchase_status_main= URLDecoder.decode(request.getParameter("purchase_status_main"), "UTF-8" );

			String purchase_date= URLDecoder.decode(request.getParameter("purchase_date"), "UTF-8" );
			
			//String account_code= URLDecoder.decode(request.getParameter("account_code"), "UTF-8" );
			String account_nm= URLDecoder.decode(request.getParameter("account_nm"), "UTF-8" );
			

			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			vo.setPurchase_order_num(purchase_order_num);
			vo.setPurchase_status(purchase_status_main);
			vo.setPurchase_date(purchase_date);
		
			
			//vo.setAccount_code(account_code);
			vo.setAccount_nm(account_nm);
		

			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYPurchaseOrderDetailVo> list = new ArrayList<SYPurchaseOrderDetailVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYPurchaseOrderDetailVo dVo = new SYPurchaseOrderDetailVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					
					if( "purchase_num".equals(nKey) ) dVo.setPurchase_num(nValue);
					else if( "purchase_req_date".equals(nKey) )	
					{
						logger.debug("purchase_req_date : " + nValue);
						nValue = nValue.replace("-", "");
						nValue = nValue.replace("-", "");
						dVo.setPurchase_req_date(nValue);
						
					}
					else if( "purchase_status".equals(nKey) ) dVo.setPurchase_status(nValue);
					
					else if( "item_code".equals(nKey) ) dVo.setItem_code(nValue);
					else if( "item_nm".equals(nKey) ) dVo.setItem_nm(nValue);
					else if( "item_spec".equals(nKey) ) dVo.setItem_spec(nValue);
					else if( "item_type_code".equals(nKey) ) dVo.setItem_type_code(nValue);
					else if( "item_type_nm".equals(nKey) ) dVo.setItem_type_nm(nValue);
					else if( "unit_price".equals(nKey) ) dVo.setUnit_price(nValue);
					else if( "menge".equals(nKey) ) dVo.setMenge(nValue);
					else if( "in_menge".equals(nKey) ) dVo.setIn_menge(nValue);
					else if( "total_price".equals(nKey) ) dVo.setTotal_price(nValue);
				
				}
				
				
				list.add(dVo);
			}
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYPurchaseOrderService.savePurchaseOrderDetail(list, vo);
			
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
	
	// deletePurchaseOrderDetail
	@ResponseBody
	@RequestMapping(value = "/consumable/deletePurchaseOrderDetail", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deletePurchaseOrderDetail(@ModelAttribute SYPurchaseOrderDetailVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deletePurchaseOrderDetail() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYPurchaseOrderService.deletePurchaseOrderDetail(vo);

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
	
	// deletePurchaseOrder
	@ResponseBody
	@RequestMapping(value = "/consumable/deletePurchaseOrder", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deletePurchaseOrder(@ModelAttribute SYPurchaseOrderVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deletePurchaseOrder() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYPurchaseOrderService.deletePurchaseOrder(vo);

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
	

	
	// Warehouing
	//warehousing_file_upload - 원자재 
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/consumable/warehousing_file_upload", produces="text/html;charset=UTF-8")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String warehousing_file_upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FileController.warehousing_file_upload() is called. ");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
	    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
	    		
	    String purchase_order_num = request.getParameter("purchase_order_num");
	    String purchase_num = request.getParameter("purchase_num");
	    String warehousing_status = request.getParameter("warehousing_status");
	    String in_date = request.getParameter("in_date");
	    String item_code = request.getParameter("item_code");
	    String item_nm = request.getParameter("item_nm");
	    String item_spec = request.getParameter("item_spec");
	    String item_type_code = request.getParameter("item_type_code");
	    String item_type_nm = request.getParameter("item_type_nm");
	    String serial_no = request.getParameter("serial_no");
	    String meins = request.getParameter("meins");
	    
	    String in_menge = request.getParameter("in_menge");
	    String delivery_date = request.getParameter("delivery_date");
	    String in_ware_code = request.getParameter("in_ware_code");
	    String mill_sheet_no = request.getParameter("mill_sheet_no");
	    
	    String file_group = "";
	    String file_no = "";
	    String file_cate = "raw_doc";
	   
	   
	    
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
						SYWareHousingVo fVo = new SYWareHousingVo();
						if(file_group == null || file_group.equals("")){
							file_group = sYWarehousingService.selectFileKey();
							fVo.setFile_group(file_group);
						} else {
							fVo.setFile_group(file_group);
						}
	
				/*		 String warehousing_status = request.getParameter("warehousing_status");
						    String in_date = request.getParameter("in_date");
						    String item_code = request.getParameter("item_code");
						    String item_nm = request.getParameter("item_nm");
						    String item_spec = request.getParameter("item_spec");
						    String item_type_code = request.getParameter("item_type_code");
						    String item_type_nm = request.getParameter("item_type_nm");
						    String serial_no = request.getParameter("serial_no");
						    String meins = request.getParameter("meins");
						    
						    String in_menge = request.getParameter("in_menge");
						    String delivery_date = request.getParameter("delivery_date");

						    String mill_sheet_no = request.getParameter("mill_sheet_no");*/
						
						    
						fVo.setWarehousing_status(warehousing_status);
						fVo.setPurchase_order_num(purchase_order_num);
						fVo.setPurchase_num(purchase_num);
						fVo.setIn_date(in_date);
						fVo.setDelivery_date(delivery_date);
						fVo.setItem_code(item_code);
						fVo.setItem_nm(item_nm);
						fVo.setItem_spec(item_spec);
						fVo.setItem_type_code(item_type_code);
						fVo.setItem_type_nm(item_type_nm);
						fVo.setSerial_no(serial_no);
						fVo.setMeins(meins);
						
						fVo.setIn_menge(in_menge);
						fVo.setMill_sheet_no(mill_sheet_no);
						fVo.setIn_ware_code(in_ware_code);
				
						
						fVo.setFile_repo("1");
						fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
						fVo.setFile_name(filename);
						fVo.setFile_ext(fileExt);
						fVo.setDel_yn("N");
						fVo.setFile_size((localFile.length() / 1024));
		
						fVo.setCreator(SessionUtil.getMemberId(request));
						fVo.setUpdater(SessionUtil.getMemberId(request));
						fVo.setFile_no(file_no);
						
						sYWarehousingService.insertWarehousingProcess(fVo, purchase_order_num, purchase_num);
						
						
						
						
						
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
	
	// Warehouing
	//MOD_warehousing_file_upload - 원자재 
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/consumable/MOD_warehousing_file_upload", produces="text/html;charset=UTF-8")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String MOD_warehousing_file_upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FileController.MOD_warehousing_file_upload() is called. ");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
	    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
	    		
	
	    String in_date_doc = request.getParameter("in_date_doc");
	    String item_code = request.getParameter("item_code");
	  
	    String current_serial_no = request.getParameter("current_serial_no");
	    String serial_no = request.getParameter("serial_no");
	    String mill_sheet_no = request.getParameter("mill_sheet_no");
	    
	    String file_group = "";
	    String file_no = "";
	    String file_cate = "raw_doc";
	   
	   
	    
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
						SYWareHousingVo fVo = new SYWareHousingVo();
						if(file_group == null || file_group.equals("")){
							file_group = sYWarehousingService.selectFileKey();
							fVo.setFile_group(file_group);
						} else {
							fVo.setFile_group(file_group);
						}
	
				/*		 String warehousing_status = request.getParameter("warehousing_status");
						    String in_date = request.getParameter("in_date");
						    String item_code = request.getParameter("item_code");
						    String item_nm = request.getParameter("item_nm");
						    String item_spec = request.getParameter("item_spec");
						    String item_type_code = request.getParameter("item_type_code");
						    String item_type_nm = request.getParameter("item_type_nm");
						    String serial_no = request.getParameter("serial_no");
						    String meins = request.getParameter("meins");
						    
						    String in_menge = request.getParameter("in_menge");
						    String delivery_date = request.getParameter("delivery_date");

						    String mill_sheet_no = request.getParameter("mill_sheet_no");*/
						
						    
						fVo.setIn_date_doc(in_date_doc);
						fVo.setItem_code(item_code);
						fVo.setCurrent_serial_no(current_serial_no);
						fVo.setSerial_no(serial_no);
						
						fVo.setMill_sheet_no(mill_sheet_no);
				
						
						fVo.setFile_repo("1");
						fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
						fVo.setFile_name(filename);
						fVo.setFile_ext(fileExt);
						fVo.setDel_yn("N");
						fVo.setFile_size((localFile.length() / 1024));
		
					
						fVo.setUpdater(SessionUtil.getMemberId(request));
						fVo.setFile_no(file_no);
						
						sYWarehousingService.updateWarehousingProcess(fVo);
						
						
						
						
						
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
	
	// Warehouing
	//insertWarehouing - 원자재  외의 것 
	@ResponseBody
	@RequestMapping(value = "/consumable/insertWarehouing", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String insertWarehousing(@ModelAttribute SYWareHousingVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.insertWarehouing() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String purchase_order_num = request.getParameter("purchase_order_num");
		    String purchase_num = request.getParameter("purchase_num");
		  
		    String in_date = request.getParameter("in_date");
		    String delivery_date = request.getParameter("delivery_date");
		    String item_code = request.getParameter("item_code");
		    String item_nm = request.getParameter("item_nm");
		    String item_spec = request.getParameter("item_spec");
		    String item_type_code = request.getParameter("item_type_code");
		    String item_type_nm = request.getParameter("item_type_nm");

		    String meins = request.getParameter("meins");
		    
		    String in_menge = request.getParameter("in_menge");
		    
		    String in_ware_code = request.getParameter("in_ware_code");
			
	

			vo.setPurchase_order_num(purchase_order_num);
			vo.setPurchase_num(purchase_num);
			vo.setIn_date(in_date);
			vo.setDelivery_date(delivery_date);
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);
			vo.setItem_spec(item_spec);
			vo.setItem_type_code(item_type_code);
			vo.setItem_type_nm(item_type_nm);

			vo.setMeins(meins);
			
			vo.setIn_menge(in_menge);
			vo.setDel_yn("N");
			vo.setIn_ware_code(in_ware_code);

			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			
			int cnt = sYWarehousingService.insertWarehousingProcess(vo, purchase_order_num, purchase_num);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	// selectWarehousing
	@ResponseBody
	@RequestMapping(value = "/consumable/selectWarehousing", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehousing(@ModelAttribute SYWareHousingVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehousing is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYWareHousingVo> dataList = sYWarehousingService.selectWarehousing(vo);

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
	
	// selectWarehousingMng
	@ResponseBody
	@RequestMapping(value = "/consumable/selectWarehousingMng", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehousingMng(@ModelAttribute SYWareHousingVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehousingMng is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYWareHousingVo> dataList = sYWarehousingService.selectWarehousingMng(vo);

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
	// selectWarehousingMng
	@ResponseBody
	@RequestMapping(value = "/consumable/selectWarehousingMngEtc", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehousingMngEtc(@ModelAttribute SYWareHousingVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehousingMngEtc is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYWareHousingVo> dataList = sYWarehousingService.selectWarehousingMngEtc(vo);

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
	
	// saveWarehouseIn
	@ResponseBody
	@RequestMapping(value = "/consumable/saveWarehouseIn", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveWarehouseIn(@ModelAttribute SYWareHousingVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveWarehouseIn() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			result = sYWarehousingService.saveWarehouseIn(vo);

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
	// saveWarehouseOut
	@ResponseBody
	@RequestMapping(value = "/consumable/saveWarehouseOut", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveWarehouseOut(@ModelAttribute SYWarehouseOutVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveWarehouseOut() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			result = sYWarehousingService.saveWarehouseOut(vo);

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
	
	// selectWarehouseHis
		@ResponseBody
		@RequestMapping(value = "/consumable/selectWarehouseHis", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectWarehouseHis(@ModelAttribute SYWareHousingVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectWarehouseHis is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {

				
				List<SYWareHousingVo> dataList = sYWarehousingService.selectWarehouseHis(vo);

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
		
		
	
	// selectWarehousingRawMng
	@ResponseBody
	@RequestMapping(value = "/consumable/selectWarehouseRawMng", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouseRawMng(@ModelAttribute SYWareHouseRawVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouseRawMng is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYWareHouseRawVo> dataList = sYWarehousingService.selectWarehouseRawMng(vo);

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
	
	
	// deleteWarehousing
	@ResponseBody
	@RequestMapping(value = "/consumable/deleteWarehousing", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteWarehousing(@ModelAttribute SYWareHousingVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteWarehousing() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYWarehousingService.deleteWarehousingProcess(vo);

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
	
	
	
	
	
	//--------------------------------------------------------------------------------
	// product
	// selectProduct
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProduct", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProduct(@ModelAttribute SYProductVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProduct is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductVO> dataList = sYProductService.selectProduct(vo);

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
	
	// selectProduct_one
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProduct_one", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProduct_one(@ModelAttribute SYProductVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProduct_one is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductVO> dataList = sYProductService.selectProduct_one(vo);

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
	@RequestMapping(value = "/consumable/selectProduct_V1", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProduct_V1(@ModelAttribute SYProductVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProduct is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductVO> dataList = sYProductService.selectProduct_V1(vo);

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
		
	// deleteProduct
	@ResponseBody
	@RequestMapping(value = "/consumable/deleteProduct", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteProduct(@ModelAttribute SYProductVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteProduct() is called.");

		JSONObject resultData = new JSONObject();
		try {

			int result = 0;

			result = sYProductService.deleteProduct(vo);

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
	// saveProductProcess
	@ResponseBody
	@RequestMapping(value = "/consumable/saveProductProcess", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveProductProcess(@ModelAttribute SYProductVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveProductProcess() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		try {
			
			String gridData = request.getParameter("gridData");
			String idx = request.getParameter("idx");
		
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			

			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYProductVO> list = new ArrayList<SYProductVO>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				
				if(i == Integer.parseInt(idx)){
				
			
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYProductVO pVo = new SYProductVO();
				pVo.setCreator(SessionUtil.getMemberId(request));
				pVo.setUpdater(SessionUtil.getMemberId(request));
//						String old_rcC = "";
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					if( "product_po".equals(nKey) ) pVo.setProduct_po(nValue);

					else if( "order_num".equals(nKey) ) pVo.setOrder_num(nValue);
					else if( "item_code".equals(nKey) ) pVo.setItem_code(nValue);
					else if( "item_nm".equals(nKey) ) pVo.setItem_nm(nValue);
					else if( "delivery_date".equals(nKey) ) pVo.setDelivery_date(nValue);
					else if( "menge".equals(nKey) ) pVo.setOrder_menge(nValue);
					
					else if( "warehouse_delivery_menge".equals(nKey) ) pVo.setWarehouse_delivery_menge(nValue);
					else if( "product_menge".equals(nKey) ) pVo.setProduct_menge(nValue);
					}
				
				
				list.add(pVo);
				}
			}
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYProductService.saveProductProcess(list);
			
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
	
	// reSaveProductProcess
	@ResponseBody
	@RequestMapping(value = "/consumable/reSaveProductProcess", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String reSaveProductProcess(@ModelAttribute SYProductVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveProductProcess() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		try {
			
			String parent_product_po = request.getParameter("parent_product_po");
			String gridData = request.getParameter("gridData");
		
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			

			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYProductVO> list = new ArrayList<SYProductVO>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYProductVO pVo = new SYProductVO();
				pVo.setCreator(SessionUtil.getMemberId(request));
				pVo.setUpdater(SessionUtil.getMemberId(request));
//							String old_rcC = "";
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					if( "product_po".equals(nKey) ) pVo.setProduct_po(nValue);
					else if( "product_class".equals(nKey) ) pVo.setProduct_class(nValue);
					else if( "order_num".equals(nKey) ) pVo.setOrder_num(nValue);
					else if( "item_code".equals(nKey) ) pVo.setItem_code(nValue);
					else if( "item_nm".equals(nKey) ) pVo.setItem_nm(nValue);
					else if( "delivery_date".equals(nKey) ) pVo.setDelivery_date(nValue);
					else if( "menge".equals(nKey) ) pVo.setOrder_menge(nValue);
					else if( "product_req_date".equals(nKey) ) pVo.setProduct_req_date(nValue);
					else if( "warehouse_delivery_menge".equals(nKey) ) pVo.setWarehouse_delivery_menge(nValue);
					else if( "product_menge".equals(nKey) ) pVo.setProduct_menge(nValue);
					}
				
				
				list.add(pVo);
			}
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYProductService.reSaveProductProcess(list,parent_product_po);
			
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
	
	// selectProductPlanNow
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProductPlanNow", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductPlanNow(@ModelAttribute SYWarehouseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductPlanNow is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYWarehouseVo> dataList = sYProductService.selectProductPlanNow(vo);

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
	
	// selectProductOperation
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProductOperation", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductOperation(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductOperation is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductOperationVO> dataList = sYProductService.selectProductOperation(vo);

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
	
	//1222 공정관리분석
	// selectProductAnalysis
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProductAnalysis", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductAnalysis(@ModelAttribute SYProductAnalysisVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductAnalysis is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductAnalysisVO> dataList = sYProductService.selectProductAnalysis(vo);

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
	
	// selectProductOperation_V1
		@ResponseBody
		@RequestMapping(value = "/consumable/selectProductOperation_V1", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectProductOperation_V1(@ModelAttribute SYProductOperationVO vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectProductOperation is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {

				List<SYProductOperationVO> dataList = sYProductService.selectProductOperation_V1(vo);

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
	@RequestMapping(value = "/consumable/selectProductOperationStatus", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductOperationStatus(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductOperationStatus is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			SYProductOperationVO dataList = sYProductService.selectProductOperationStatus(vo);

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

	// updateProductDateProcess
	@ResponseBody
	@RequestMapping(value = "/consumable/updateProductDateProcess", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateProductDate(@ModelAttribute SYProductVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.updateProductDateProcess() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		try {
			
			String gridData = request.getParameter("gridData");
		
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			

			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYProductVO> list = new ArrayList<SYProductVO>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYProductVO pVo = new SYProductVO();
				pVo.setCreator(SessionUtil.getMemberId(request));
				pVo.setUpdater(SessionUtil.getMemberId(request));
//								String old_rcC = "";
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					if( "product_po".equals(nKey) ) pVo.setProduct_po(nValue);
					else if( "product_req_date".equals(nKey) ) pVo.setProduct_req_date(nValue);
				
					}
				
				
				list.add(pVo);
			}
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYProductService.updateProductDateProcess(list);
			
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
	
	
	
	// saveProductDirect
	@ResponseBody
	@RequestMapping(value = "/consumable/saveProductDirect", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveProduct(@ModelAttribute SYProductVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveProductDirect() is called.");

		JSONObject resultData = new JSONObject();
		try {

		
		
		
			
			String product_req_date = URLDecoder.decode(request.getParameter("product_req_date"), "UTF-8" );
		
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String item_nm = URLDecoder.decode(request.getParameter("item_nm"), "UTF-8" );
			
	

			String product_menge = URLDecoder.decode(request.getParameter("product_menge"), "UTF-8" );
			
		
	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setProduct_req_date(product_req_date);
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);
			vo.setProduct_menge(product_menge);
			
	
			int cnt = sYProductService.saveProductDirect(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	// saveProductDirect
	@ResponseBody
	@RequestMapping(value = "/consumable/updateProductOperationProcess", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateProductOperationProcess(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateProductOperationProcess() is called.");

		JSONObject resultData = new JSONObject();
		try {

		
		
		
			
			String product_po = URLDecoder.decode(request.getParameter("product_po"), "UTF-8" );	
			String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8" );
			String warehouse_gubun =  URLDecoder.decode(request.getParameter("warehouse_gubun"), "UTF-8" );
			String member_nm = URLDecoder.decode(request.getParameter("member_nm"), "UTF-8" );
				
			String status = URLDecoder.decode(request.getParameter("status"), "UTF-8" );
			
			
			String machine_code = URLDecoder.decode(request.getParameter("machine_code"), "UTF-8" );
	
			String unprod_comment = URLDecoder.decode(request.getParameter("unprod_comment"), "UTF-8" );
			
			try{
			String prod_menge = URLDecoder.decode(request.getParameter("prod_menge"), "UTF-8" );
			String prod_fail_menge = URLDecoder.decode(request.getParameter("prod_fail_menge"), "UTF-8" );
			vo.setProd_menge(prod_menge);
			vo.setProd_fail_menge(prod_fail_menge);
			}catch(Exception e)
			{
				e.getStackTrace();
			}
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			vo.setProduct_po(product_po);
			vo.setRouting_code(routing_code);
			vo.setWarehouse_gubun(warehouse_gubun);
			vo.setMember_nm(member_nm);
			vo.setStatus(status);
			vo.setMachine_code(machine_code);
	
			vo.setUnprod_comment(unprod_comment);
			
		
	
			
	
			int cnt = sYProductService.updateProductOperationProcess(vo);

			if(cnt == 999 || cnt == 888 )
			{
				resultData.put("status", 777);
				resultData.put("cnt", null);
			}else{
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("cnt", cnt);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProductUnOperation", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductUnOperation(@ModelAttribute SYProductUnOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductUnOperation is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductUnOperationVO> dataList = sYProductService.selectProductUnOperation(vo);

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
	@RequestMapping(value = "/consumable/selectProductUnOperation_V1", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductUnOperation_V1(@ModelAttribute SYProductUnOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductUnOperation is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductUnOperationVO> dataList = sYProductService.selectProductUnOperation_V1(vo);

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
	
	//----------------------------------------------
	//외주
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOutSourcing", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOutSourcing(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOutSourcing is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductOperationVO> dataList = sYProductService.selectOutSourcing(vo);

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
	@RequestMapping(value = "/consumable/selectOutSourcingAll", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOutSourcingAll(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOutSourcingAll is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductOperationVO> dataList = sYProductService.selectOutSourcingAll(vo);

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
	// updateProductOperationOS_END
	@ResponseBody
	@RequestMapping(value = "/consumable/updateProductOperationOS_END", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateProductOperationOS_END(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateProductOperationOS_END() is called.");

		JSONObject resultData = new JSONObject();
		try {
			String prod_menge = URLDecoder.decode(request.getParameter("prod_menge"), "UTF-8" );
			String prod_fail_menge = URLDecoder.decode(request.getParameter("prod_fail_menge"), "UTF-8" );
			String outsourcing_price = URLDecoder.decode(request.getParameter("outsourcing_price"), "UTF-8" );
			String product_po = URLDecoder.decode(request.getParameter("product_po"), "UTF-8" );
			String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8" );
			String warehouse_gubun = URLDecoder.decode(request.getParameter("warehouse_gubun"), "UTF-8" );
			String req_prod_menge = URLDecoder.decode(request.getParameter("req_prod_menge"), "UTF-8" );
			String member_nm = URLDecoder.decode(request.getParameter("member_nm"), "UTF-8" );
		
			vo.setProd_menge(prod_menge);
			vo.setProd_fail_menge(prod_fail_menge);
			vo.setOutsourcing_price(outsourcing_price);
			vo.setReq_prod_menge(req_prod_menge);
			vo.setProduct_po(product_po);
			vo.setRouting_code(routing_code);
			vo.setWarehouse_gubun(warehouse_gubun);
			vo.setMember_nm(member_nm);
			
			vo.setDate_updated(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int cnt = sYProductService.updateProductOperationOS_END(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	// updateProductOperationOS_REQ
	@ResponseBody
	@RequestMapping(value = "/consumable/updateProductOperationOS_REQ", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateProductOperationOS_REQ(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateProductOperationOS_REQ() is called.");

		JSONObject resultData = new JSONObject();
		try {
			String account_code = URLDecoder.decode(request.getParameter("account_code"), "UTF-8" );
			String product_po = URLDecoder.decode(request.getParameter("product_po"), "UTF-8" );
			String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8" );
			String delivery_request_date = URLDecoder.decode(request.getParameter("delivery_request_date"), "UTF-8" );

			vo.setProduct_po(product_po);
			vo.setRouting_code(routing_code);
			vo.setAccount_code(account_code);
			vo.setDelivery_request_date(delivery_request_date);
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			int cnt = sYProductService.updateProductOperationOS_REQ(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
		
	
	
	
	
	
	///////////////////1103아이템별 공정현황//////////////////////////////////
	
	// selectItemFair
	@ResponseBody
	@RequestMapping(value = "/consumable/selectItemFair", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemFair(@ModelAttribute SYItem_fairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectItemFair is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYItem_fairVo> dataList = sYProductService.selectItemFair(vo);

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
	
	// selectItemFair_graph
	@ResponseBody
	@RequestMapping(value = "/consumable/selectItemFair_graph", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectItemFair_graph(@ModelAttribute SYItem_fairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectItemFair_graph is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYItem_fairVo> dataList = sYProductService.selectItemFair_graph(vo);

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
	
		
	//--------------------------------------------------------------------------------
	// product
	// selectProductMonitoring
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProductMonitoring", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductMonitoring(@ModelAttribute SYProductVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductMonitoring is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductVO> dataList = sYProductService.selectProductMonitoring(vo);

			
			
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
	// selectProductMonitoring2
	@ResponseBody
	@RequestMapping(value = "/consumable/selectProductMonitoring2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductMonitoring2(@ModelAttribute SYProductVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductMonitoring2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductVO> dataList = sYProductService.selectProductMonitoring2(vo);

			
			
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
	//--------------------------------------------------------------------------------	
	// selectWarehouseRaw
	@ResponseBody
	@RequestMapping(value = "/consumable/selectWarehouseRaw", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouseRaw(@ModelAttribute SYWareHouseRawVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouseRaw is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYWareHouseRawVo> dataList = sYWarehousingService.selectWarehouseRaw(vo);

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
	
	// selectWarehouseRawPartition
	@ResponseBody
	@RequestMapping(value = "/consumable/selectWarehouseRawPartition", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouseRawPartition(@ModelAttribute SYWareHouseRawVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouseRawPartition is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYWareHouseRawVo> dataList = sYWarehousingService.selectWarehouseRawPartition(vo);

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
	
	
	// rivisionWarehouseRawProcess
	@ResponseBody
	@RequestMapping(value = "/consumable/rivisionWarehouseRawProcess", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String rivisionWarehouseRawProcess(@ModelAttribute SYWareHouseRawVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.rivisionWarehouseRawProcess() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
		
		JSONObject jGridDataSelect = new JSONObject();
		
		try {

			
			String gridData = request.getParameter("gridData");
			String gridData_select = request.getParameter("gridDataSelect");
			
			String product_po = URLDecoder.decode(request.getParameter("product_po"), "UTF-8" );
			String serial_no = URLDecoder.decode(request.getParameter("serial_no"), "UTF-8" );
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String division_seq = URLDecoder.decode(request.getParameter("division_seq"), "UTF-8" );
			
			
		
			vo.setProduct_po(product_po);
			vo.setSerial_no(serial_no);
			vo.setItem_code(item_code);
			vo.setDivision_seq(division_seq);
			String p_item_code = "";
			try{
				 p_item_code = URLDecoder.decode(request.getParameter("p_item_code"), "UTF-8" );
				vo.setP_item_code(p_item_code);
			}catch(Exception e)
			{
				e.getStackTrace();
			}
			
		
	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			


			jsonArray = (JSONArray) parser.parse(gridData); 
			
			jGridDataSelect = (JSONObject) parser.parse(gridData_select);
			
			
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYWareHouseRawVo> list = new ArrayList<SYWareHouseRawVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYWareHouseRawVo dVo = new SYWareHouseRawVo();
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
					
			/*		if( "business_code".equals(nKey) ) dVo.setBusiness_code(nValue);
					else if( "business_nm".equals(nKey) ) dVo.setBusiness_nm(nValue);
					else if( "warehouse_code".equals(nKey) ) dVo.setWarehouse_code(nValue);
					else if( "warehouse_nm".equals(nKey) ) dVo.setWarehouse_nm(nValue);
					else if( "out_warehousing_status".equals(nKey) ) dVo.setOut_warehousing_status(nValue);
					else if( "item_code".equals(nKey) ) dVo.setItem_code(nValue);
					else if( "item_nm".equals(nKey) ) dVo.setItem_nm(nValue);
					else if( "item_spec".equals(nKey) ) dVo.setItem_spec(nValue);
					else if( "item_type_code".equals(nKey) ) dVo.setItem_type_code(nValue);
					else if( "item_type_nm".equals(nKey) ) dVo.setItem_type_nm(nValue);
					else if( "serial_no".equals(nKey) ) dVo.setSerial_no(nValue);
					//else if( "division_seq".equals(nKey) ) dVo.setDivision_seq(nValue);
					else if( "meins".equals(nKey) ) dVo.setMeins(nValue);
					else if( "warehouse_raw_price".equals(nKey) ) dVo.setWarehouse_raw_price(nValue);
					else if( "warehouse_raw_qty".equals(nKey) ) dVo.setWarehouse_raw_qty(nValue);
					else if( "warehouse_raw_change_qty".equals(nKey) ) dVo.setWarehouse_raw_change_qty(nValue);
					else if( "product_po".equals(nKey) ) dVo.setProduct_po(nValue);*/
	
					dVo.setBusiness_code(jGridDataSelect.get("business_code").toString());
					dVo.setBusiness_nm(jGridDataSelect.get("business_nm").toString());
					dVo.setWarehouse_code(jGridDataSelect.get("warehouse_code").toString());
					dVo.setWarehouse_nm(jGridDataSelect.get("warehouse_nm").toString());
					dVo.setOut_warehousing_status(jGridDataSelect.get("out_warehousing_status").toString());
					
					dVo.setItem_code(jGridDataSelect.get("item_code").toString());
					dVo.setItem_nm(jGridDataSelect.get("item_nm").toString());
					dVo.setItem_spec(jGridDataSelect.get("item_spec").toString());
					dVo.setItem_type_code(jGridDataSelect.get("item_type_code").toString());
					dVo.setItem_type_nm(jGridDataSelect.get("item_type_nm").toString());
					dVo.setSerial_no(jGridDataSelect.get("serial_no").toString());
					dVo.setMeins(jGridDataSelect.get("meins").toString());

					//dVo.setWarehouse_raw_change_qty(jGridDataSelect.get("warehouse_raw_change_qty").toString());
					dVo.setProduct_po(product_po);
					dVo.setWarehouse_raw_price(jGridDataSelect.get("warehouse_raw_price").toString());
					
				
					dVo.setP_item_code(p_item_code);
					
					if( "warehouse_raw_qty".equals(nKey)) 
						dVo.setWarehouse_raw_qty(nValue);

					if( "warehouse_raw_qty_1".equals(nKey)) 
						dVo.setWarehouse_raw_change_qty(nValue);
					
					
					}
				
				
				
				list.add(dVo);
			}
	
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYWarehousingService.rivisionWarehouseRawProcess(vo, list);
			
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
	
	// outWarehouseRawProcess
	@ResponseBody
	@RequestMapping(value = "/consumable/outWarehouseRawProcess", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String outWarehouseRawProcess(@ModelAttribute SYWareHouseRawVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.outWarehouseRawProcess() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
	
		try {

			
			String gridData = request.getParameter("gridData");
			logger.debug("FrontendController.records() is called. : " + gridData);
			String product_po = URLDecoder.decode(request.getParameter("product_po"), "UTF-8" );
			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			
			
			vo.setProduct_po(product_po);
			vo.setItem_code(item_code);

	
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			


			jsonArray = (JSONArray) parser.parse(gridData); 
			
			
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYWareHouseRawVo> list = new ArrayList<SYWareHouseRawVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				SYWareHouseRawVo dVo = new SYWareHouseRawVo();
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
//							String old_rcC = "";
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else {
						nValue = jObj.get(nKey).toString();
					logger.debug("nKey : " + nValue);
					logger.debug("nValue : " + nValue);
					}
					
					

	
					if( "item_code".equals(nKey) ) dVo.setItem_code(nValue);
					else if( "serial_no".equals(nKey) ) dVo.setSerial_no(nValue);
					
					else if( "division_seq".equals(nKey) ) dVo.setDivision_seq(nValue);

					else if( "warehouse_raw_qty".equals(nKey) ) dVo.setWarehouse_raw_qty(nValue);

					else if( "product_po".equals(nKey) ) dVo.setProduct_po(nValue);
	
					
				
				
					list.add(dVo);
				}
			}
			vo.setUpdater(SessionUtil.getMemberId(request));
			int dCnt = sYWarehousingService.outWarehouseRawProcess(product_po,item_code, list);
			
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
	
	
	// selectRepairAnalysis
	@ResponseBody
	@RequestMapping(value = "/repair/selectRepairAnalysis", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRepairAnalysis(@ModelAttribute SYRepairAnalysisVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectRepairAnalysis is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYRepairAnalysisVo> dataList = sYOverhaulService.selectRepairAnalysis(vo);

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
	
	
	// deleteInstrument
	@ResponseBody
	@RequestMapping(value = "/quality/deleteInstrument", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteItem(@ModelAttribute SYInstrumentVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteInstrument() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYInstrumentService.deleteInstrument(vo);

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
	
	//계측기 파일 업로드
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/quality/insInstrument", produces="text/html;charset=UTF-8")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String insInstrument(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("FrontendController.insInstrument() is called. ");
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
	    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
	    		
	    String correct_num = request.getParameter("correct_num");
	    String instrument_nm = request.getParameter("instrument_nm");
	    String maker = request.getParameter("maker");
	    String instrument_num = request.getParameter("instrument_num");
	    String device_num = request.getParameter("device_num");
	    String standard = request.getParameter("standard");
	    String use_team = request.getParameter("use_team");
	    String manager_nm = request.getParameter("manager_nm");
	    String register_date = request.getParameter("register_date");
	    String correct_yn = request.getParameter("correct_yn");
	    String correct_date = request.getParameter("correct_date");
	    String correct_cycle = request.getParameter("correct_cycle");
	    String correct_next_date = request.getParameter("correct_next_date");
	    String correct_institutions = request.getParameter("correct_institutions");

	    String file_ext = "";
	    String file_size = "";
	    String file_cate = "itm";
	    
	   
	    
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
				
						SYInstrumentVo fVo = new SYInstrumentVo();
						    
						/*String correct_num = request.getParameter("correct_num");
					    String instrument_nm = request.getParameter("instrument_nm");
					    String maker = request.getParameter("maker");
					    String standard = request.getParameter("standard");
					    String correct_yn = request.getParameter("correct_yn");
					    String correct_date = request.getParameter("correct_date");
					    String correct_cycle = request.getParameter("correct_cycle");
					    String correct_next_date = request.getParameter("correct_next_date");
					    String correct_institutions = request.getParameter("correct_institutions");
					    
					    String file_group = "";
					    String file_no = "";
					    
					    String file_path = "";
					    String file_name = "";
					    String file_ext = "";
					    String file_size = "";
					    String file_cate = "raw_doc";*/
						
						
						fVo.setDate_created(SessionUtil.getMemberId(request));
						fVo.setDate_updated(SessionUtil.getMemberId(request));
						fVo.setCreator(SessionUtil.getMemberId(request));
						fVo.setUpdater(SessionUtil.getMemberId(request));

						fVo.setCorrect_num(correct_num);
						fVo.setInstrument_nm(instrument_nm);
						
						fVo.setMaker(maker);
						fVo.setInstrument_num(instrument_num);
						fVo.setDevice_num(device_num);
						fVo.setStandard(standard);
						fVo.setUse_team(use_team);
						fVo.setManager_nm(manager_nm);
						fVo.setRegister_date(register_date);
						fVo.setCorrect_yn(correct_yn);
						fVo.setCorrect_date(correct_date);
						fVo.setCorrect_institutions(correct_institutions);
						fVo.setCorrect_cycle(correct_cycle);
						fVo.setCorrect_next_date(correct_next_date);
						
						fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
						fVo.setFile_name(filename);
						fVo.setFile_ext(fileExt);
						
						fVo.setDel_yn("N");
						fVo.setFile_size((localFile.length() / 1024));
						
						sYInstrumentService.saveInstrument(fVo);
					
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
	

	// saveInstrument
	@ResponseBody
	@RequestMapping(value = "/quality/saveInstrument", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveInstrument(@ModelAttribute SYInstrumentVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveInstrument() is called.");

		JSONObject resultData = new JSONObject();
		try {
			
		
			
			
			vo.setDate_created(SessionUtil.getMemberId(request));
			vo.setDate_updated(SessionUtil.getMemberId(request));
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));

	
			int cnt = sYInstrumentService.saveInstrument(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	
	
	
	//claim
	
	// selectClaim
	@ResponseBody
	@RequestMapping(value = "/quality/selectClaim", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectClaim(@ModelAttribute SYClaimVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectClaim is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYClaimVo> dataList = sYClaimService.selectClaim(vo);

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


	// deleteClaim
	@ResponseBody
	@RequestMapping(value = "/quality/deleteClaim", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteClaim(@ModelAttribute SYClaimVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.deleteClaim() is called.");

		JSONObject resultData = new JSONObject();
		try {


			int result = 0;

			result = sYClaimService.deleteClaim(vo);

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

	// saveClaim
	@ResponseBody
	@RequestMapping(value = "/quality/saveClaim", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveClaim(@ModelAttribute SYClaimVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveClaim() is called.");

		JSONObject resultData = new JSONObject();
		try {
			
		
			String claim_num = URLDecoder.decode(request.getParameter("claim_num"), "UTF-8" );
			String customer_nm = URLDecoder.decode(request.getParameter("customer_nm"), "UTF-8" );
			String customer_code = URLDecoder.decode(request.getParameter("customer_code"), "UTF-8" );

			String item_code = URLDecoder.decode(request.getParameter("item_code"), "UTF-8" );
			String item_nm = URLDecoder.decode(request.getParameter("item_nm"), "UTF-8" );
			String serial_no = URLDecoder.decode(request.getParameter("serial_no"), "UTF-8" );
			String reason = URLDecoder.decode(request.getParameter("reason"), "UTF-8" );
			String comment1 = URLDecoder.decode(request.getParameter("comment1"), "UTF-8" );
			String comment2 = URLDecoder.decode(request.getParameter("comment2"), "UTF-8" );
			String comment3 = URLDecoder.decode(request.getParameter("comment3"), "UTF-8" );
			
			String out_date = URLDecoder.decode(request.getParameter("out_date"), "UTF-8" );
			String mounting_date = URLDecoder.decode(request.getParameter("mounting_date"), "UTF-8" );
			String desorption_date = URLDecoder.decode(request.getParameter("desorption_date"), "UTF-8" );
			String apply = URLDecoder.decode(request.getParameter("apply"), "UTF-8" );
			String result = URLDecoder.decode(request.getParameter("result"), "UTF-8" );
			String type = URLDecoder.decode(request.getParameter("type"), "UTF-8" );
			String comment_etc = URLDecoder.decode(request.getParameter("comment_etc"), "UTF-8" );
			String claim_type = URLDecoder.decode(request.getParameter("claim_type"), "UTF-8" );
	
			
			vo.setDate_created(SessionUtil.getMemberId(request));
			vo.setDate_updated(SessionUtil.getMemberId(request));
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			vo.setCustomer_code(customer_code);

			vo.setClaim_num(claim_num);
			vo.setCustomer_nm(customer_nm);
			
			vo.setItem_code(item_code);
			vo.setItem_nm(item_nm);
			
			vo.setSerial_no(serial_no);
			vo.setReason(reason);
			vo.setComment1(comment1);
			vo.setComment2(comment2);
			vo.setComment3(comment3);
			
			vo.setOut_date(out_date);
			vo.setMounting_date(mounting_date);
			vo.setDesorption_date(desorption_date);
			vo.setApply(apply);
			vo.setResult(result);
			vo.setType(type);
			vo.setComment_etc(comment_etc);
			vo.setClaim_type(claim_type);
			
	
			int cnt = sYClaimService.saveClaim(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	//updFileInstrument
	@ResponseBody
	@RequestMapping(value="/quality/updFileInstrument", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
	public String updFileInstrument(@ModelAttribute SYInstrumentVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("Filecontroller.updFileInstrument() is called");
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = sYInstrumentService.updFileInstrument(vo);
			resultData.put("status", HttpStatus.OK);
			resultData.put("data", result);
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return resultData.toJSONString();
	}
	
	
	
	
	//updateClaim
			@ResponseBody
			@RequestMapping(method = RequestMethod.POST, value = "/quality/updateClaim", produces="text/html;charset=UTF-8")
			@SuppressWarnings({ "rawtypes", "unchecked" })
			public String updateClaim(HttpServletRequest request, HttpServletResponse response) throws Exception {
				logger.info("FrontendController.updateClaim() is called. ");
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
		    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();

		    
		    String claim_num = request.getParameter("claim_num");
		    
		    String file_path = request.getParameter("file_path");
		    String file_name = request.getParameter("file_name");
		    String file_ext = request.getParameter("file_ext");
		    String file_size = request.getParameter("file_size");
		    
		    String t_file_path = request.getParameter("t_file_path");
		    String t_file_name = request.getParameter("t_file_name");
		    String t_file_ext = request.getParameter("t_file_ext");
		    String t_file_size = request.getParameter("t_file_size");
		    
		    String file_cate = "clm";	    
		    String t_file_cate = "clm";

		    String typeString = request.getParameter("typeString");

		    
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
					List<SYClaimVo> returnList = new ArrayList<SYClaimVo>();

					SYClaimVo fVo = new SYClaimVo();
					
					fVo.setClaim_num(claim_num);
				
					if("".equals(file_size) || file_size == null)
					{
						file_size = "0";
					}
					if("".equals(t_file_size) || t_file_size == null)
					{
						t_file_size = "0";
					}
					if(!"".equals(file_path))
					{
						fVo.setFile_cate(file_cate);
						fVo.setFile_path(file_path);
						fVo.setFile_name(file_name);
						fVo.setFile_ext(file_ext);
						fVo.setFile_size(Long.parseLong(file_size));
					}
					if(!"".equals(t_file_path))
					{
						fVo.setT_file_cate(t_file_cate);
						fVo.setT_file_path(t_file_path);
						fVo.setT_file_name(t_file_name);
						fVo.setT_file_ext(t_file_ext);
						fVo.setT_file_size(Long.parseLong(t_file_size));
					}
					int count = 0;
			
					fVo.setDate_created(SessionUtil.getMemberId(request));
					fVo.setDate_updated(SessionUtil.getMemberId(request));
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));

					fVo.setClaim_num(claim_num);

					for(MultipartFile mpf : fileList) {
					try {	
							String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());		
							String currentType = "";
							try{
								if(typeString.contains("#")){
									String type[] = typeString.split("#");
									currentType = type[count];
								}else
								{
									currentType = typeString;
								}
							}catch(Exception e9)
							{
								e9.getMessage();
							}
							
							
							
							
							String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
							File localFile = new File(strDir + "_"+uid+"."+fileExt);
							OutputStream out = new FileOutputStream(localFile);
							out.write(mpf.getBytes());
							out.close();
							
						
							if("one".equals(currentType)){
								fVo.setFile_cate(file_cate);
								fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
								fVo.setFile_name(filename);
								fVo.setFile_ext(fileExt);
								fVo.setFile_size((localFile.length() / 1024));
							}else if("two".equals(currentType))
							{
								fVo.setT_file_cate(t_file_cate);
								fVo.setT_file_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
								fVo.setT_file_name(filename);
								fVo.setT_file_ext(fileExt);
								fVo.setT_file_size((localFile.length() / 1024));
							}
							
							count++;
							
						
			 			} catch(Exception e) {
				 			e.printStackTrace();
				 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				 			resultData.put("rows", null);
			 			} finally {
			 			}
					sYClaimService.updateClaim(fVo);
					}
				}
			}
			return resultData.toJSONString();
		}
		
	
	
	

	//saveClaimFile 파일 업로드
		@ResponseBody
		@RequestMapping(method = RequestMethod.POST, value = "/quality/saveClaimFile", produces="text/html;charset=UTF-8")
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public String saveClaimFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
			logger.info("FrontendController.saveClaimFile() is called. ");
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
		    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
		    		
		    String claim_num = request.getParameter("claim_num");
		    
		    String claim_date = request.getParameter("claim_date");
		    String customer_nm = request.getParameter("customer_nm");
		    String customer_code = request.getParameter("customer_code");
		    
		    String item_code = request.getParameter("item_code");
		    String item_nm = request.getParameter("item_nm");
		    String serial_no = request.getParameter("serial_no");
		    
		    String reason = request.getParameter("reason");
		    String comment1 = request.getParameter("comment1");
		    String comment2 = request.getParameter("comment2");
		    
		    String out_date = request.getParameter("out_date");
			String mounting_date = request.getParameter("mounting_date");
			String desorption_date = request.getParameter("desorption_date");
			String apply = request.getParameter("apply");
			String result = request.getParameter("result");
			String type = request.getParameter("type");
			String comment_etc = request.getParameter("comment_etc");
			String claim_type = request.getParameter("claim_type");
	

		    String file_path = request.getParameter("file_path");
		    String file_name = request.getParameter("file_name");
		    String file_ext = request.getParameter("file_ext");
		    String file_size = request.getParameter("file_size");
		    
		    String t_file_path = request.getParameter("t_file_path");
		    String t_file_name = request.getParameter("t_file_name");
		    String t_file_ext = request.getParameter("t_file_ext");
		    String t_file_size = request.getParameter("t_file_size");
		    
		    String file_cate = "clm";	    
		    String t_file_cate = "clm";

		    String typeString = request.getParameter("typeString");
		    
		   
		    
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
					List<SYClaimVo> returnList = new ArrayList<SYClaimVo>();

					SYClaimVo fVo = new SYClaimVo();
					
					fVo.setClaim_num(claim_num);
				
					if("".equals(file_size) || file_size == null)
					{
						file_size = "0";
					}
					if("".equals(t_file_size) || t_file_size == null)
					{
						t_file_size = "0";
					}
					if(!"".equals(file_path))
					{
						fVo.setFile_cate(file_cate);
						fVo.setFile_path(file_path);
						fVo.setFile_name(file_name);
						fVo.setFile_ext(file_ext);
						fVo.setFile_size(Long.parseLong(file_size));
					}
					if(!"".equals(t_file_path))
					{
						fVo.setT_file_cate(t_file_cate);
						fVo.setT_file_path(t_file_path);
						fVo.setT_file_name(t_file_name);
						fVo.setT_file_ext(t_file_ext);
						fVo.setT_file_size(Long.parseLong(t_file_size));
					}
					int count = 0;

					fVo.setDate_created(SessionUtil.getMemberId(request));
					fVo.setDate_updated(SessionUtil.getMemberId(request));
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));

					fVo.setClaim_num(claim_num);

					fVo.setClaim_date(claim_date);
					fVo.setCustomer_nm(customer_nm);
					fVo.setCustomer_code(customer_code);
					
					fVo.setItem_code(item_code);
					fVo.setItem_nm(item_nm);
					fVo.setSerial_no(serial_no);
					
					fVo.setOut_date(out_date);
					fVo.setMounting_date(mounting_date);
					fVo.setDesorption_date(desorption_date);
					fVo.setApply(apply);
					fVo.setResult(result);
					fVo.setType(type);
					fVo.setComment_etc(comment_etc);
					fVo.setClaim_type(claim_type);
					
					fVo.setReason(reason);
					fVo.setComment1(comment1);
					fVo.setComment2(comment2);
					
			
					
					for(MultipartFile mpf : fileList) {
					try {	
							String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());		
							String currentType = "";
							try{
								if(typeString.contains("#")){
									String type1[] = typeString.split("#");
									currentType = type1[count];
								}else
								{
									currentType = typeString;
								}
							}catch(Exception e9)
							{
								e9.getMessage();
							}
							
						
							
							
							String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
							File localFile = new File(strDir + "_"+uid+"."+fileExt);
							OutputStream out = new FileOutputStream(localFile);
							out.write(mpf.getBytes());
							out.close();
							
						
							if("one".equals(currentType)){
								fVo.setFile_cate(file_cate);
								fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
								fVo.setFile_name(filename);
								fVo.setFile_ext(fileExt);
								fVo.setFile_size((localFile.length() / 1024));
							}else if("two".equals(currentType))
							{
								fVo.setT_file_cate(t_file_cate);
								fVo.setT_file_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
								fVo.setT_file_name(filename);
								fVo.setT_file_ext(fileExt);
								fVo.setT_file_size((localFile.length() / 1024));
							}
							
							count++;
							
						
			 			} catch(Exception e) {
				 			e.printStackTrace();
				 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				 			resultData.put("rows", null);
			 			} finally {
			 			}
					sYClaimService.saveClaimFile(fVo);
					}
				}
			}
			return resultData.toJSONString();
		}
	
		
		
		
	// selectSelfInspFail
	@ResponseBody
	@RequestMapping(value = "/quality/selectSelfInspFail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSelfInspFail(@ModelAttribute SYSelf_InspFailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSelfInspFail is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYSelf_InspFailVo> dataList = sYSelfInspFailService.selectSelfInspFail(vo);

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

//saveSelfInspFail 파일 업로드
@ResponseBody
@RequestMapping(method = RequestMethod.POST, value = "/quality/saveSelfInspFail", produces="text/html;charset=UTF-8")
@SuppressWarnings({ "rawtypes", "unchecked" })
public String saveSelfInspFail(HttpServletRequest request, HttpServletResponse response) throws Exception {
	logger.info("FrontendController.saveSelfInspFail() is called. ");
	
	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;	
    MultiValueMap<String, MultipartFile> map = multipartRequest.getMultiFileMap();
    		
    String fail_num = request.getParameter("fail_num");
    
    String fail_type_code = request.getParameter("fail_type_code");
    String reason = request.getParameter("reason");
    String cause = request.getParameter("cause");
    String comment1 = request.getParameter("comment1");
    String comment2 = request.getParameter("comment2");
    
    String complete_date = request.getParameter("complete_date");
    String comment_date = request.getParameter("comment_date");
    
    String product_po = request.getParameter("product_po");
    String routing_code = request.getParameter("routing_code");
    

    String file_path = request.getParameter("file_path");
    String file_name = request.getParameter("file_name");
    String file_ext = request.getParameter("file_ext");
    String file_size = request.getParameter("file_size");
    
    String t_file_path = request.getParameter("t_file_path");
    String t_file_name = request.getParameter("t_file_name");
    String t_file_ext = request.getParameter("t_file_ext");
    String t_file_size = request.getParameter("t_file_size");
    
    String file_cate = "clm";	    
    String t_file_cate = "clm";

    String typeString = request.getParameter("typeString");
    
   
    
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
			List<SYClaimVo> returnList = new ArrayList<SYClaimVo>();

			SYSelf_InspFailVo fVo = new SYSelf_InspFailVo();
			
			fVo.setFail_num(fail_num);
		
			if("".equals(file_size) || file_size == null)
			{
				file_size = "0";
			}
			if("".equals(t_file_size) || t_file_size == null)
			{
				t_file_size = "0";
			}
			if(!"".equals(file_path))
			{
				fVo.setFile_cate(file_cate);
				fVo.setFile_path(file_path);
				fVo.setFile_name(file_name);
				fVo.setFile_ext(file_ext);
				fVo.setFile_size(Long.parseLong(file_size));
			}
			if(!"".equals(t_file_path))
			{
				fVo.setT_file_cate(t_file_cate);
				fVo.setT_file_path(t_file_path);
				fVo.setT_file_name(t_file_name);
				fVo.setT_file_ext(t_file_ext);
				fVo.setT_file_size(Long.parseLong(t_file_size));
			}
			int count = 0;

			fVo.setDate_created(SessionUtil.getMemberId(request));
			fVo.setDate_updated(SessionUtil.getMemberId(request));
			fVo.setCreator(SessionUtil.getMemberId(request));
			fVo.setUpdater(SessionUtil.getMemberId(request));

			fVo.setFail_num(fail_num);

			fVo.setFail_type_code(fail_type_code);
			fVo.setReason(reason);
			fVo.setCause(cause);
			
			fVo.setComment1(comment1);
			fVo.setComment2(comment2);
			
			fVo.setComplete_date(complete_date);
			fVo.setComment_date(comment_date);
			
			fVo.setProduct_po(product_po);
			fVo.setRouting_code(routing_code);
	
			
			for(MultipartFile mpf : fileList) {
			try {	
					String filename = StringUtils.trimAllWhitespace(mpf.getOriginalFilename());		
					String currentType = "";
					try{
						if(typeString.contains("#")){
							String type1[] = typeString.split("#");
							currentType = type1[count];
						}else
						{
							currentType = typeString;
						}
					}catch(Exception e9)
					{
						e9.getMessage();
					}
					
					
					
					
					String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length()).toLowerCase();
					File localFile = new File(strDir + "_"+uid+"."+fileExt);
					OutputStream out = new FileOutputStream(localFile);
					out.write(mpf.getBytes());
					out.close();
					
				
					if("one".equals(currentType)){
						fVo.setFile_cate(file_cate);
						fVo.setFile_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
						fVo.setFile_name(filename);
						fVo.setFile_ext(fileExt);
						fVo.setFile_size((localFile.length() / 1024));
					}else if("two".equals(currentType))
					{
						fVo.setT_file_cate(t_file_cate);
						fVo.setT_file_path(file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt);
						fVo.setT_file_name(filename);
						fVo.setT_file_ext(fileExt);
						fVo.setT_file_size((localFile.length() / 1024));
					}
					
					count++;
					
				
	 			} catch(Exception e) {
		 			e.printStackTrace();
		 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		 			resultData.put("rows", null);
	 			} finally {
	 			}
			sYSelfInspFailService.saveSelfInspFail(fVo);
			}
		}
	}
	return resultData.toJSONString();
	}

	//saveSelfInspFail2
	@ResponseBody
	@RequestMapping(value = "/quality/saveSelfInspFail2", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveSelfInspFail2(@ModelAttribute SYSelf_InspFailVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.saveSelfInspFail2() is called.");

		JSONObject resultData = new JSONObject();
		try {
			
		
			String fail_num = URLDecoder.decode(request.getParameter("fail_num"), "UTF-8" );
			String fail_type_code = URLDecoder.decode(request.getParameter("fail_type_code"), "UTF-8" );
			String reason = URLDecoder.decode(request.getParameter("reason"), "UTF-8" );

			String cause = URLDecoder.decode(request.getParameter("cause"), "UTF-8" );
			String comment1 = URLDecoder.decode(request.getParameter("comment1"), "UTF-8" );
			String comment2 = URLDecoder.decode(request.getParameter("comment2"), "UTF-8" );
			String complete_date = URLDecoder.decode(request.getParameter("complete_date"), "UTF-8" );
			String comment_date = URLDecoder.decode(request.getParameter("comment_date"), "UTF-8" );
			String product_po = URLDecoder.decode(request.getParameter("product_po"), "UTF-8" );
			String routing_code = URLDecoder.decode(request.getParameter("routing_code"), "UTF-8" );
			
			vo.setDate_created(SessionUtil.getMemberId(request));
			vo.setDate_updated(SessionUtil.getMemberId(request));
			vo.setCreator(SessionUtil.getMemberId(request));
			vo.setUpdater(SessionUtil.getMemberId(request));
			
			vo.setFail_num(fail_num);

			vo.setFail_type_code(fail_type_code);
			vo.setReason(reason);
			
			vo.setCause(cause);
			vo.setComment1(comment1);
			
			vo.setComment2(comment2);
			vo.setComplete_date(complete_date);
			vo.setComment_date(comment_date);
			vo.setProduct_po(product_po);
			vo.setRouting_code(routing_code);
			
	
			int cnt = sYSelfInspFailService.saveSelfInspFail(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}
	
	
	// selectInstrument
	@ResponseBody
	@RequestMapping(value = "/quality/selectInstrument", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectInstrument(@ModelAttribute SYInstrumentVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectInstrument is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYInstrumentVo> dataList = sYInstrumentService.selectInstrument(vo);

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
	
	// selectInstrumentHis
	@ResponseBody
	@RequestMapping(value = "/quality/selectInstrumentHis", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectInstrumentHis(@ModelAttribute SYInstrumentVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectInstrumentHis is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYInstrumentVo> dataList = sYInstrumentService.selectInstrumentHis(vo);

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
	
	// saveInstrument2
		@ResponseBody
		@RequestMapping(value = "/quality/saveInstrument2", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String saveInstrument2(@ModelAttribute SYInstrumentVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.saveInstrument2() is called.");

			JSONObject resultData = new JSONObject();
			try {
				
			
				String correct_num = URLDecoder.decode(request.getParameter("correct_num"), "UTF-8" );
				String instrument_nm = URLDecoder.decode(request.getParameter("instrument_nm"), "UTF-8" );
				String maker = URLDecoder.decode(request.getParameter("maker"), "UTF-8" );

				String instrument_num = URLDecoder.decode(request.getParameter("instrument_num"), "UTF-8" );
				String device_num = URLDecoder.decode(request.getParameter("device_num"), "UTF-8" );
				String standard = URLDecoder.decode(request.getParameter("standard"), "UTF-8" );
				String use_team = URLDecoder.decode(request.getParameter("use_team"), "UTF-8" );
				String register_date = URLDecoder.decode(request.getParameter("register_date"), "UTF-8" );
				String correct_date = URLDecoder.decode(request.getParameter("correct_date"), "UTF-8" );
				String correct_institutions = URLDecoder.decode(request.getParameter("correct_institutions"), "UTF-8" );
				
				String correct_cycle = URLDecoder.decode(request.getParameter("correct_cycle"), "UTF-8" );
				String correct_next_date = URLDecoder.decode(request.getParameter("correct_next_date"), "UTF-8" );
				String correct_yn = URLDecoder.decode(request.getParameter("correct_yn"), "UTF-8" );
		
				
				vo.setDate_created(SessionUtil.getMemberId(request));
				vo.setDate_updated(SessionUtil.getMemberId(request));
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				
				vo.setCorrect_num(correct_num);
				vo.setInstrument_nm(instrument_nm);
				vo.setMaker(maker);
				
				vo.setInstrument_num(instrument_num);
				vo.setDevice_num(device_num);
				vo.setStandard(standard);
				vo.setUse_team(use_team);
				vo.setRegister_date(register_date);
				vo.setCorrect_date(correct_date);
				vo.setCorrect_institutions(correct_institutions);
				
				vo.setCorrect_cycle(correct_cycle);
				vo.setCorrect_next_date(correct_next_date);
				vo.setCorrect_yn(correct_yn);
		
				int cnt = sYInstrumentService.saveInstrument(vo);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("cnt", cnt);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("cnt", null);
			}
			return resultData.toJSONString();
		}
		
	// LOT 추적 
	
	@ResponseBody
	@RequestMapping(value = "/consumable/selectLot", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectLot(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectLot is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductOperationVO> dataList = sYProductService.selectLot(vo);

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
	@RequestMapping(value = "/consumable/selectLot2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectLot(@ModelAttribute SYWareHouseRawVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectLot2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYWareHouseRawVo> dataList = sYProductService.selectLot2(vo);

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
	@RequestMapping(value = "/consumable/selectLot3", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectLot3(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectLot3 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYProductOperationVO> dataList = sYProductService.selectLot3(vo);

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
	// selectRepair
	@ResponseBody
	@RequestMapping(value = "/repair/selectRepair", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRepair(@ModelAttribute SYKPI_RepairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectRepair is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_RepairVo> dataList = sYKPIService.selectRepair(vo);

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
	// selectProductItem
	@ResponseBody
	@RequestMapping(value = "/product/selectProductItem", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProductItem(@ModelAttribute SYProductVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProductItem is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYProductVO> dataList = sYProductService.selectProductItem(vo);

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
	// selectRepairItem
	@ResponseBody
	@RequestMapping(value = "/repair/selectRepairItem", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRepairItem(@ModelAttribute SYKPI_RepairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectRepairItem is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYKPI_RepairVo> dataList = sYKPIService.selectRepairItem(vo);

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
	
	// selectRepair2
	@ResponseBody
	@RequestMapping(value = "/repair/selectRepair2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRepair2(@ModelAttribute SYKPI_RepairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectRepair2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_RepairVo> dataList = sYKPIService.selectRepair2(vo);

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

	// selectRepair3
	@ResponseBody
	@RequestMapping(value = "/repair/selectRepair3", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectRepair3(@ModelAttribute SYKPI_RepairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectRepair3 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
		
			
			List<SYKPI_RepairVo> dataList = sYKPIService.selectRepair3(vo);

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
	
		
		
	// selectrepairUsingDay
	@ResponseBody
	@RequestMapping(value = "/repair/selectrepairUsingDay", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectrepairUsingDay(@ModelAttribute SYRepairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectrepairUsingDay is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYRepairVo> dataList = sYOverhaulService.selectrepairUsingDay(vo);

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
	
	// selectrepairItem
	@ResponseBody
	@RequestMapping(value = "/repair/selectrepairItem", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectrepairItem(@ModelAttribute SYRepairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectrepairItem is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
	
			List<SYRepairVo> dataList = sYOverhaulService.selectrepairItem(vo);

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
	
	// selectProduct
	@ResponseBody
	@RequestMapping(value = "/repair/selectProduct", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProduct(@ModelAttribute SYKPI_ProductVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProduct is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_ProductVo> dataList = sYKPIService.selectProduct(vo);

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
	
	// selectProduct2
	@ResponseBody
	@RequestMapping(value = "/repair/selectProduct2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProduct2(@ModelAttribute SYKPI_ProductVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProduct2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_ProductVo> dataList = sYKPIService.selectProduct2(vo);

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
	
	// selectProduct3
	@ResponseBody
	@RequestMapping(value = "/repair/selectProduct3", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectProduct3(@ModelAttribute SYKPI_ProductVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectProduct3 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_ProductVo> dataList = sYKPIService.selectProduct3(vo);

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

	// selectPurchaseList
	@ResponseBody
	@RequestMapping(value = "/repair/selectPurchaseList", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseList(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseList is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseList(vo);

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
	@RequestMapping(value = "/repair/selectPurchaseList_total", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseList_total(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseList_total is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseList_total(vo);

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
	@RequestMapping(value = "/repair/selectPurchaseList_in", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseList_in(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseList_in is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseList_in(vo);

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
	@RequestMapping(value = "/repair/selectPurchaseList_no", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseList_no(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseList_no is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseList_no(vo);

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
	
	
	// selectPurchaseGraph
	@ResponseBody
	@RequestMapping(value = "/repair/selectPurchaseGraph", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseGraph(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseGraph is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseGraph(vo);

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
	@RequestMapping(value = "/repair/selectPurchaseGraph_total", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseGraph_total(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseGraph_total is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseGraph_total(vo);

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
	@RequestMapping(value = "/repair/selectPurchaseGraph_in", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseGraph_in(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseGraph_in is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseGraph_in(vo);

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
	@RequestMapping(value = "/repair/selectPurchaseGraph_no", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPurchaseGraph_no(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPurchaseGraph_no is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.selectPurchaseGraph_no(vo);

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
	
	// selectMonitorAccount
	@ResponseBody
	@RequestMapping(value = "/consumable/selectMonitorAccount", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMonitorAccount(@ModelAttribute SYProductOperationVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectMonitorAccount is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYProductOperationVO> dataList = sYProductService.selectMonitorAccount(vo);

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
	
	// selectPurchaseList
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesSearch", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesSearch(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesSearch is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesSearch(vo);

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
	
	// selectSalesGrid
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesGrid", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesGrid(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesGrid is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesGrid(vo);

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
	
	// selectSalesGrid
		@ResponseBody
		@RequestMapping(value = "/repair/selectCustomerIntergration", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectCustomerIntergration(@ModelAttribute SYCustomerVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectCustomerIntergration is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {
				
				List<SYCustomerVo> dataList = sYKPIService.selectCustomerIntergration(vo);

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
	
	// selectSalesGraph
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesGraph", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesGraph(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesGraph is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesGraph(vo);

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
	
	// selectSalesGraph_no
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesGraph_no", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesGraph_no(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesGraph_no is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesGraph_no(vo);

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
	// selectSalesGraph_ju
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesGraph_ju", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesGraph_ju(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesGraph_ju is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesGraph_ju(vo);

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
	
	// selectPurchaseSearch
	@ResponseBody
	@RequestMapping(value = "/repair/purchaseGrid", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String purchaseGrid(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.purchaseGrid is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.purchaseGrid(vo);

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
	
	
	
	// selectPurchaseSearch
	@ResponseBody
	@RequestMapping(value = "/repair/purchaseGrid_in", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String purchaseGrid_in(@ModelAttribute SYKPI_PurchaseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.purchaseGrid_in is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_PurchaseVo> dataList = sYKPIService.purchaseGrid_in(vo);

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
	
	// selectSalesGrid2
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesGrid2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesGrid2(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesGrid2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesGrid2(vo);

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
	// selectSalesGrid2_no
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesGrid2_no", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesGrid2_no(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesGrid2_no is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesGrid2_no(vo);

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
	
	// selectSalesGrid2_ju
	@ResponseBody
	@RequestMapping(value = "/repair/selectSalesGrid2_ju", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSalesGrid2_ju(@ModelAttribute SYKPI_SalesVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectSalesGrid2_ju is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_SalesVo> dataList = sYKPIService.selectSalesGrid2_ju(vo);

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
	
	
	// selectOperation
	@ResponseBody
	@RequestMapping(value = "/repair/selectOperation", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOperation(@ModelAttribute SYKPI_OperationVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOperation is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYKPI_OperationVo> dataList = sYKPIService.selectOperation(vo);

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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// cw
	
	
	
	
	
	
	
	
	
	
	
	
	// selectWarehouse_master_header
	@ResponseBody
	@RequestMapping(value = "/warehouse/selectWarehouse_master_header", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouse_master_header(@ModelAttribute SYWarehouse_MasterHVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouse_master_header is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYWarehouse_MasterHVo> dataList = sYWarehouseService.selectWarehouse_master_header(vo);

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
	
	// insertWarehouse_master_header

	@ResponseBody
	@RequestMapping(value = "/warehouse/insertWarehouse_master_header", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String insertWarehouse_master_header(@ModelAttribute SYWarehouse_MasterHVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.insertWarehouse_master_header is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			int cnt = 0;

//				String flag = request.getParameter("flag");

//				if (flag.equals("I")) {
				cnt = sYWarehouseService.insertWarehouse_master_header(vo);
//				} 
				
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value = "/warehouse/updateWarehouse_master_header", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateWarehouse_master_header(@ModelAttribute SYWarehouse_MasterHVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateWarehouse_master_header is called.");

		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));

		JSONObject resultData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();

		try {
			int cnt = 0;

//				String flag = request.getParameter("flag");

//				if (flag.equals("I")) {
				cnt = sYWarehouseService.updateWarehouse_master_header(vo);
//				} 
				
			System.out.println("cnt = " + cnt);

			resultData.put("status", HttpStatus.OK.value());

		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}

		return resultData.toJSONString();
	}

	// deleteWarehouse_master_header
	@ResponseBody
	@RequestMapping(value = "/warehouse/deleteWarehouse_master_header", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String deleteWarehouse_master_header(@ModelAttribute SYWarehouse_MasterHVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.deleteWarehouse_master_header() is called.");

		JSONObject resultData = new JSONObject();
		try {
			int result = 0;

			result = sYWarehouseService.deleteWarehouse_master_header(vo);

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
	
	// deleteWarehouse_master_detail
		@ResponseBody
		@RequestMapping(value = "/warehouse/deleteWarehouse_master_detail", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String deleteWarehouse_master_detail(@ModelAttribute SYWarehouse_MasterHVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.deleteWarehouse_master_detail() is called.");

			JSONObject resultData = new JSONObject();
			try {
				int result = 0;

				result = sYWarehouseService.deleteWarehouse_master_detail(vo);

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
	
	
	// selectWarehouse_master_detail
	@ResponseBody
	@RequestMapping(value = "/warehouse/selectWarehouse_master_detail", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouse_master_detail(@ModelAttribute SYWarehouse_MasterDVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouse_master_detail is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYWarehouse_MasterDVo> dataList = sYWarehouseService.selectWarehouse_master_detail(vo);

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
	@RequestMapping(value = "/warehouse/saveWarehouse_master_detail", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveWarehouse_master_detail(@ModelAttribute SYWarehouse_MasterDVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.saveWarehouse_master_detail() is called.");

		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		JSONObject resultData = new JSONObject();
		
//			vo.setCreator(SessionUtil.getMemberId(request));
//			vo.setUpdater(SessionUtil.getMemberId(request));
		
		try {
			String gridData = request.getParameter("gridData");
			String warehouse_code = request.getParameter("warehouse_code");
			String warehouse_nm = request.getParameter("warehouse_nm");
			
			vo.setWarehouse_code(warehouse_code);
			
			jsonArray = (JSONArray) parser.parse(gridData); 
			Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
			List<SYWarehouse_MasterDVo> list = new ArrayList<SYWarehouse_MasterDVo>(); 

			for(int i=0; i<jsonArray.size(); i++) {
				JSONObject jObj = (JSONObject)jsonArray.get(i);
				
				SYWarehouse_MasterDVo dVo = new SYWarehouse_MasterDVo();
				
				dVo.setCreator(SessionUtil.getMemberId(request));
				dVo.setUpdater(SessionUtil.getMemberId(request));
				dVo.setWarehouse_code(warehouse_code);
				dVo.setWarehouse_nm(warehouse_nm);
				
				for(Object key : keyArr) { 
					String nKey = key.toString();
					String nValue = "";
					
					if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
						continue;
					else 
						nValue = jObj.get(nKey).toString();
					
					if( "item_type_code".equals(nKey) ) dVo.setItem_type_code(nValue);
					else if( "item_type_nm".equals(nKey) ) dVo.setItem_type_nm(nValue);
				
				}
				
				list.add(dVo);
			}
			
			int result = sYWarehouseService.allDeleteWarehouse_master_detail(vo);
			
			int dCnt = sYWarehouseService.saveWarehouse_master_detail(list, vo);
			
			
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


	// selectWarehouse
	@ResponseBody
	@RequestMapping(value = "/warehouse/selectWarehouse", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouse(@ModelAttribute SYWarehouseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouse is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYWarehouseVo> dataList = sYWarehouseService.selectWarehouse(vo);

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
	// selectWarehouse2
	@ResponseBody
	@RequestMapping(value = "/warehouse/selectWarehouse2", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouse2(@ModelAttribute SYWarehouseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouse2 is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYWarehouseVo> dataList = sYWarehouseService.selectWarehouse2(vo);

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
		
	// selectMaterialBan
	@ResponseBody	
	@RequestMapping(value = "/warehouse/selectMaterialBan", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectMaterialBan(@ModelAttribute SYWarehouseVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectMaterialBan is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYWarehouseVo> dataList = sYWarehouseService.selectMaterialBan(vo);

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

	// selectWarehouseOut
	@ResponseBody
	@RequestMapping(value = "/warehouse/selectWarehouseOut", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWarehouseOut(@ModelAttribute SYWarehouseOutVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWarehouseOut is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYWarehouseOutVo> dataList = sYWarehousingService.selectWarehouseOut(vo);

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
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//// jsjsjsjsjsjjsjsjsjjsjsjsj End
	
	//jyp
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//jyp
	
	
	
	
	
	
	
	
	
	
	
	//yb
	@ResponseBody
	@RequestMapping(value="/repair/selectrepairReqT" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String selectrepairReqT (@ModelAttribute SYRepairVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.repair/selectrepairReqT() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYRepairVo> dataList = sYOverhaulService.selectrepairReqT(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response,dataList);
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
	@RequestMapping(value="/repair/findinout" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String findinout (@ModelAttribute SYCustomerVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.repair/findinout() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYCustomerVo> dataList = sYOverhaulService.findinout(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response,dataList);
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
	@RequestMapping(value="/repair/insRepair" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String insRepair (@ModelAttribute SYRepairVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.repair/insRepair() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int inrenum = sYOverhaulService.selectrepairReqTcnt(vo.getRepair_num());
			if(inrenum != 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("msg", "fall");
			}else {
				int cnt = sYOverhaulService.insRepair(vo);
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
	@RequestMapping(value="/repair/modRepair" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String modRepair (@ModelAttribute SYRepairVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.repair/insRepair() is called.");
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYOverhaulService.modRepair(vo);
			if(cnt == 1) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("msg", "success");
			}else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("msg", "whatfall");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/repair/cancelCompleteReport" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String cancelCompleteReport(@ModelAttribute SYRepairVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("FrontedContller.repair/cancelCompleteReport() is called.");
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYOverhaulService.cancelCompleteReport(vo);
			if(cnt == 1) {
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("msg", "success");
			}else {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("msg", "whatfall");
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("msg", "fall");
		}
		return resultData.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/repair/delRepair" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String delRepair (@ModelAttribute SYRepairVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.repair/delRepair() is called.");
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try {
			int cnt = sYOverhaulService.delRepair(vo);
			if(cnt > 0) {
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
	@ResponseBody
	@RequestMapping(value="/repair/getItemnm" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String getItemnm (@ModelAttribute SYMaterialVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.repair/getItemnm() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYMaterialVo> dataList = sYOverhaulService.getItemnm(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response,dataList);
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
	
/*	@ResponseBody
	@RequestMapping(value="/repair/updateOutDate", method = {RequestMethod.GET, RequestMethod.POST}, produces ="application/json;charset=UTF-8")
	public String updateOutDate(@ModelAttribute SYRepairVo vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("Filecontroller.updateOutDate() is called");
		JSONObject resultData = new JSONObject();
		try {
			int result = 0;
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = sYOverhaulService.updateOutDate(vo);
			resultData.put("status", HttpStatus.OK);
			resultData.put("data", result);
			
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return resultData.toJSONString();
	}*/
	@ResponseBody
	@RequestMapping(value = "/repair/updateOutDate", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateOutDate(@ModelAttribute SYRepairVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.updateOutDate() is called.");

		JSONObject resultData = new JSONObject();
		try {

			String out_date = URLDecoder.decode(request.getParameter("out_date"), "UTF-8" );	
	
			vo.setUpdater(SessionUtil.getMemberId(request));

			vo.setOut_date(out_date);
	
			int cnt = sYOverhaulService.updateOutDate(vo);

			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("cnt", null);
		}
		return resultData.toJSONString();
	}   
		
	@ResponseBody
	@RequestMapping(value="/repair/selectrepairReqR" , method = { RequestMethod.GET, RequestMethod.POST}, produces = "applicattion/json;charset=UTF-8")
	@SuppressWarnings({ "unchecked"})
	public String selectrepairReqR (@ModelAttribute SYRepairVo vo, HttpServletRequest request, HttpServletResponse response , HttpSession session) {
		logger.debug("InfoController.repair/selectrepairReqR() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYRepairVo> dataList = sYOverhaulService.selectrepairReqR(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response,dataList);
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
	
	
	// 모니터링
	

	
	// selectOperation
	@ResponseBody
	@RequestMapping(value = "/consumable/selectOperation", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectOperation(@ModelAttribute SYMachineMonitorVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectOperation is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYMachineMonitorVO> dataList = sYMachineMonitorService.selectOperation(vo);

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

	// selectWaiting
	@ResponseBody
	@RequestMapping(value = "/consumable/selectWaiting", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectWaiting(@ModelAttribute SYMachineMonitorVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectWaiting is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			
			List<SYMachineMonitorVO> dataList = sYMachineMonitorService.selectWaiting(vo);

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
	
	// selectInfo
		@ResponseBody
		@RequestMapping(value = "/consumable/selectInfo", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectInfo(@ModelAttribute SYMachineMonitorInfoVO vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectWaiting is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {

				
				List<SYMachineMonitorInfoVO> dataList = sYMachineMonitorService.selectInfo(vo);

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
		@RequestMapping(value = "/repair/selectrepairOther", method = {
				RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectrepairOther(@ModelAttribute SYRepairVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.selectrepairOther is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			try {

				List<SYRepairVo> dataList = sYOverhaulService.selectrepairOther(vo);

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
	
		// updateRepairOrder
		@ResponseBody
		@RequestMapping(value = "/repair/updateRepairOrder", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String updateRepairOrder(@ModelAttribute SYRepairVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.updateRepairOrder() is called.");

			JSONObject resultData = new JSONObject();
			try {
				String proc2_account_code = URLDecoder.decode(request.getParameter("proc2_account_code"), "UTF-8" );
				String proc2_account_nm = URLDecoder.decode(request.getParameter("proc2_account_nm"), "UTF-8" );
				String proc2_request_date = URLDecoder.decode(request.getParameter("proc2_request_date"), "UTF-8" );

				vo.setProc2_account_code(proc2_account_code);
				vo.setProc2_account_nm(proc2_account_nm);
				vo.setProc2_request_date(proc2_request_date);
				vo.setUpdater(SessionUtil.getMemberId(request));
				
				int cnt = sYOverhaulService.updateRepairOrder(vo);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("cnt", cnt);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("cnt", null);
			}
			return resultData.toJSONString();
		}
		

		// updateRepairOrder2
		@ResponseBody
		@RequestMapping(value = "/repair/updateRepairOrder2", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String updateRepairOrder2(@ModelAttribute SYRepairVo vo,
				HttpServletRequest request, HttpServletResponse response,
				HttpSession session) {
			logger.debug("FrontendController.updateRepairOrder2() is called.");

			JSONObject resultData = new JSONObject();
			try {
				String proc2_account_code = URLDecoder.decode(request.getParameter("proc2_account_code"), "UTF-8" );
				String proc2_account_nm = URLDecoder.decode(request.getParameter("proc2_account_nm"), "UTF-8" );
				String repair_num = URLDecoder.decode(request.getParameter("repair_num"), "UTF-8" );

				vo.setProc2_account_code(proc2_account_code);
				vo.setProc2_account_nm(proc2_account_nm);
				vo.setRepair_num(repair_num);
				vo.setUpdater(SessionUtil.getMemberId(request));
				
				int cnt = sYOverhaulService.updateRepairOrder(vo);

				resultData.put("status", HttpStatus.OK.value());
				resultData.put("cnt", cnt);
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				resultData.put("cnt", null);
			}
			return resultData.toJSONString();
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//yb
	 
	
	
	
	
	
	
	
	
	
	
	
		 @ResponseBody
		   @RequestMapping(value = "/insp/selcInspMain", method = {
		         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		   @SuppressWarnings("unchecked")
		   public String selcInspMain(@ModelAttribute SYProductVO vo,
		         HttpServletRequest request, HttpServletResponse response,
		         HttpSession session) {
		      logger.debug("FrontendController.selcInspMain is called.");

		      JSONObject resultData = new JSONObject();
		      JSONArray listDataJArray = new JSONArray();
		      JSONParser jsonParser = new JSONParser();
		      try {
		    	  String param_routing_nm = new String ( request.getParameter("routing_nm"));
		          System.out.println("param_routing_nm:"+param_routing_nm);
		          
		          ArrayList<String> list = new ArrayList<String>();
		          String[] routing_nm = param_routing_nm.split(",");
//		          Map<String, Object> mapper = new HashMap<String, Object>();
//		          mapper.put ( "routing_nm", routing_nm );
		          for(int i=0;i<routing_nm.length;i++) {
		              list.add(routing_nm[i].trim());
		           }
		           
//		          SYProductVO spVo = new SYProductVO();
		          vo.setList(list);

		         List<SYProductVO> dataList = sYInspService.selcInspMain(vo);
		         
		         
		         
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
   @RequestMapping(value = "/insp/selcInspMain_final", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String selcInspMain_final(@ModelAttribute SYProductVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.selcInspMain_final is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYProductVO> dataList = sYInspService.selcInspMain_final(vo);

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
   @RequestMapping(value = "/insp/selcInspChkSht", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String selcInspChkSht(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.selcInspChkSht is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.selcInspChkSht(vo);

         if(dataList.size() == 0)
         {
        	 vo.setCreator(SessionUtil.getMemberId(request));
        	 vo.setUpdater(SessionUtil.getMemberId(request));
        	 int rst = sYInspService.saveFirstChkSht(vo);
        	 dataList = sYInspService.selcInspChkSht(vo);
         }
         
         
         
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
   @RequestMapping(value = "/insp/selcInspVal", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String selcInspVal(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.selcInspVal is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.selcInspVal(vo);

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
   @RequestMapping(value = "/insp/saveInspVal", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String saveInspVal(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.saveInspVal is called.");
      JSONObject resultData = new JSONObject();
      
      try {

         JSONArray jsonArray = new JSONArray();
         JSONParser parser = new JSONParser();
         String gridData = request.getParameter("param");
         String sample_type = request.getParameter("sample_type");
         String insp_case = request.getParameter("insp_case");
         int dfct_cnt = 0; //불량수량
         jsonArray = (JSONArray) parser.parse(gridData); 
         Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
         List<SYInspVO> list = new ArrayList<SYInspVO>(); 

         for(int i=0; i<jsonArray.size(); i++) {
            JSONObject jObj = (JSONObject)jsonArray.get(i);
            SYInspVO dVo = new SYInspVO();

            dVo.setCreator(SessionUtil.getMemberId(request));
            dVo.setUpdater(SessionUtil.getMemberId(request));
            dVo.setSample_type(sample_type);
            dVo.setInsp_case(insp_case);
            dVo.setProduct_menge(vo.getProduct_menge());
            dVo.setStart_flag(vo.getStart_flag());
            
            for(Object key : keyArr) { 
               String nKey = key.toString();
               String nValue = "";
               
               if( jObj.get(nKey)==null ) 
                  continue;
               else 
                  nValue = jObj.get(nKey).toString();
               
               if( "product_po".equals(nKey) ) dVo.setProduct_po(nValue);
               else if( "item_code".equals(nKey) ) dVo.setItem_code(nValue);
               else if( "routing_code".equals(nKey) ) dVo.setRouting_code(nValue);
               else if( "inspection_seq".equals(nKey) ) dVo.setInspection_seq(nValue);
               else if( "val_seq".equals(nKey) ) dVo.setVal_seq(nValue);
               else if( "insp_val".equals(nKey) ) dVo.setInsp_val(nValue);
               else if( "min_spec".equals(nKey) ) dVo.setMin_spec(nValue);
               else if( "a_insp_ng_cnt".equals(nKey) ) dVo.setA_insp_ng_cnt(nValue);
               else if( "b_insp_ng_cnt".equals(nKey) ) dVo.setB_insp_ng_cnt(nValue);
               else if( "c_insp_ng_cnt".equals(nKey) ) dVo.setC_insp_ng_cnt(nValue);
               else if( "insp_rst".equals(nKey) ) dVo.setInsp_rst(nValue);
               
//		                  else if( "insp_rst".equals(nKey) ) {
//		                     dVo.setInsp_rst(nValue);
//		                     if(nValue.equals("NG"))
//		                        dfct_cnt++;
//		                  }
            }
            list.add(dVo);            
         }
         
         
         int dCnt = sYInspService.saveNewInspVal(list);
         
         resultData.put("status", HttpStatus.OK.value());

      } catch (Exception e) {
         e.printStackTrace();
         resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
      }
      return resultData.toJSONString();
   }
   
   @ResponseBody
   @RequestMapping(value = "/insp/saveChkSht", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String saveChkSht(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.saveChkSht is called.");

      JSONObject resultData = new JSONObject();
      
      try {

         JSONArray jsonArray = new JSONArray();
         JSONParser parser = new JSONParser();
         String gridData = request.getParameter("param");
         
         jsonArray = (JSONArray) parser.parse(gridData); 
         Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
         List<SYInspVO> list = new ArrayList<SYInspVO>(); 

         for(int i=0; i<jsonArray.size(); i++) {
            JSONObject jObj = (JSONObject)jsonArray.get(i);
            SYInspVO dVo = new SYInspVO();

            dVo.setCreator(SessionUtil.getMemberId(request));
            dVo.setUpdater(SessionUtil.getMemberId(request));
            
            for(Object key : keyArr) { 
               String nKey = key.toString();
               String nValue = "";
               
               if( jObj.get(nKey)==null ) 
                  continue;
               else 
                  nValue = jObj.get(nKey).toString();
               
               if( "product_po".equals(nKey) ) dVo.setProduct_po(nValue);
               else if( "item_code".equals(nKey) ) dVo.setItem_code(nValue);
               else if( "routing_code".equals(nKey) ) dVo.setRouting_code(nValue);
               else if( "inspection_seq".equals(nKey) ) dVo.setInspection_seq(nValue);
               else if( "worker".equals(nKey) ) dVo.setWorker(nValue);
               else if( "comment".equals(nKey) ) dVo.setComment(nValue);
            }
            list.add(dVo);            
         }
         int dCnt = sYInspService.saveChkSht(list);
         
         resultData.put("status", HttpStatus.OK.value());

      } catch (Exception e) {
         e.printStackTrace();
         resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
      }
      return resultData.toJSONString();
   }
   
   @ResponseBody
   @RequestMapping(value = "/insp/fnshChkShtData", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String fnshChkShtData(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.fnshChkShtData is called.");

      JSONObject resultData = new JSONObject();
      int flag = 0;
      int endChk = 0;
      try {
         
         List<SYInspVO> dataList = sYInspService.selcInspNgCnt(vo);
         if(dataList.size() == 0)
         {
            flag++;
         }
         
         if(flag == 0)
         {
            vo.setCreator(SessionUtil.getMemberId(request));
            vo.setUpdater(SessionUtil.getMemberId(request));
            vo.setMember_nm(SessionUtil.getMemberNm(request));
            endChk = sYInspService.fnshChkShtData(vo);
         }
         
         resultData.put("endChk", endChk);
         resultData.put("flag", flag);
         resultData.put("status", HttpStatus.OK.value());

      } catch (Exception e) {
         e.printStackTrace();
         resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
      }
      return resultData.toJSONString();
   }
   
   @ResponseBody
   @RequestMapping(value = "/insp/selcInspNgCnt", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String selcInspNgCnt(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.selcInspNgCnt is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.selcInspNgCnt(vo);

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
   @RequestMapping(value = "/insp/selcInspRstVal", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String selcInspRstVal(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.selcInspRstVal is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.selcInspRstVal(vo);

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
   @RequestMapping(value = "/insp/selcInspMain_his", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String selcInspMain_his(@ModelAttribute SYProductVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.selcInspMain_his is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYProductVO> dataList = sYInspService.selcInspMain_his(vo);

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
   @RequestMapping(value = "/insp/selcInspMain_final_his", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String selcInspMain_final_his(@ModelAttribute SYProductVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.selcInspMain_final_his is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYProductVO> dataList = sYInspService.selcInspMain_final_his(vo);

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
   @RequestMapping(value = "/insp/qLoadItemCode", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String qLoadItemCode(@ModelAttribute SYMaterialVo vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.qLoadItemCode is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYMaterialVo> dataList = sYInspService.qLoadItemCode(vo);

         
         JSONArray jsonArr1 = new JSONArray();
         
         for(int i=0 ; i<dataList.size(); i++)
         {
            JSONObject obj = new JSONObject();
            String item_code = dataList.get(i).getItem_code();
            String item_nm = dataList.get(i).getItem_nm();
            
            obj.put("id", item_code);
            obj.put("text", item_nm);
            
            jsonArr1.add(obj);
         }
         
         String listDataJsonString = ResponseUtils.getJsonResponse(response, jsonArr1);
         listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
         resultData.put("status", HttpStatus.OK.value());
         resultData.put("rows", listDataJArray);
         resultData.put("", listDataJArray);
      } catch (Exception e) {
         e.printStackTrace();
         resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
         resultData.put("rows", null);
      }
      return resultData.toJSONString();
   }
   
   @ResponseBody
   @RequestMapping(value = "/insp/getRtngInfo", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String getRtngInfo(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.getRtngInfo is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.getRtngInfo(vo);

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
   @RequestMapping(value = "/insp/getInspInfo", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String getInspInfo(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.getInspInfo is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.getInspInfo(vo);

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
   @RequestMapping(value = "/insp/getQAnalData_1", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String getQAnalData_1(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.getQAnalData_1 is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.getQAnalData_1(vo);

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
   @RequestMapping(value = "/insp/getQAnalData_2", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String getQAnalData_2(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.getQAnalData_2 is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.getQAnalData_2(vo);

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
   @RequestMapping(value = "/insp/getPnImg", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String getPnImg(@ModelAttribute SYQualityFileVo vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.getPnImg is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYQualityFileVo> dataList = sYInspService.getPnImg(vo);

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
   
   
   @SuppressWarnings("unchecked")
  	@ResponseBody
  	@RequestMapping(value="/machine/selectProductOperStatus_2", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
  	public String selectProductOperStatus_2(@ModelAttribute SYProductOperStatusVO vo, HttpServletRequest request, HttpServletResponse response) {
  		logger.debug("FrontendController.selectProductOperStatus_2() is called.");
  		
  		int work_time_sec_sum = 0;
  		int today_time_sec_sum = 0;
  		int prod_menge_sum = 0;
  		int prod_fail_menge_sum =0;
  		
  		JSONObject resultData = new JSONObject();
  		JSONArray listDataJArray = new JSONArray();
  		JSONParser jsonParser = new JSONParser();
  		try {

  			List<SYProductOperStatusVO> dataList = sYProductService.selectProductOperStatus_2(vo);

  	/*		System.out.println(dataList.get(0).getWork_str_time().substring(0,10));*/
  			
  			String prev_today_str_time = "";
  			
  			if(dataList.size() > 0 ){
  				
  			for(int j = dataList.size()-1; j>= 0; j--){

  				
  		  		
  		  			
  					SYProductOperStatusVO originData = dataList.get(j);
  					
  					
  				 	String date1 = originData.getWork_str_time().substring(0,10);
  				 	//System.out.println("date1:"+date1);
  				    String date2 = originData.getOrigin_end_time().substring(0,10);
  				    //System.out.println("date2:"+date2);
  				    try{ 
  				        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");

  				        Date FirstDate = format.parse(date1);
  				        Date SecondDate = format.parse(date2);

  				        long calDate = FirstDate.getTime() - SecondDate.getTime(); 
  				        
  				        long calDateDays = calDate / ( 24*60*60*1000); 
  				 
  				        calDateDays = Math.abs(calDateDays);
  				        
  				       // System.out.println("두 날짜의 날짜 차이: "+calDateDays);
     	
  				       

  						if(calDateDays != 0 )//날짜 차이가 있을때
  						{
  							
  						
  							String st_date = originData.getWork_str_time();
  							String end_date = originData.getWork_end_time();
  						//	String end_date = st_date.replace(dataList.get(j).getWork_str_time().substring(11,18), "24:00:00");
  						

  							for(int k= Integer.parseInt(calDateDays+"")-1; k >= 0; k--)
  							{
  									
  								SYProductOperStatusVO fakeData = new SYProductOperStatusVO();

  								fakeData.setGb(originData.getGb());
  								fakeData.setProduct_po(originData.getProduct_po());
  								fakeData.setItem_code(originData.getItem_code());
  								fakeData.setItem_nm(originData.getItem_nm());
  								fakeData.setMachine_code(originData.getMachine_code());

  				
  								fakeData.setWork_time_sec(originData.getWork_time_sec());
  								fakeData.setWork_time_hour(originData.getWork_time_hour());
  								
  								
  								fakeData.setToday_str_time(originData.getToday_str_time());
  								fakeData.setToday_end_time(originData.getToday_end_time());
  								
  								
  								fakeData.setToday_time_sec(originData.getToday_time_sec());
  								fakeData.setToday_time_hour(originData.getToday_time_hour());
  								
  								fakeData.setPer(originData.getPer());
  								
  								
  								
  							    Calendar cal = Calendar.getInstance();
  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  						        Date date = null;
  						        try {
  						            date = df.parse(st_date);
  						        } catch (Exception e) {
  						            e.printStackTrace();
  						        }
  						        
  						        cal.setTime(date);
  						        
  						       // System.out.println("변경전: " + df.format(cal.getTime()));

  						        cal.add(Calendar.DATE, k+1);
  						        
  						        //System.out.println("변경후: " + df.format(cal.getTime()));

  								String tom_str_date = df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "00:00:00");

  								fakeData.setWork_str_time(tom_str_date);
  								//System.out.println("tom_str_date :"+tom_str_date);
  								 
  								if(k == calDateDays-1)//마지막일떄
  								{
  								
  									//dataList.get(j+(k+1)).setWork_end_time(dataList.get(j).getWork_end_time());
  									
  									fakeData.setWork_str_time(tom_str_date);
  									fakeData.setWork_end_time(originData.getOrigin_end_time());
  									
  									
  									fakeData.setToday_str_time(fakeData.getWork_str_time());
  									fakeData.setToday_end_time(originData.getOrigin_end_time());
  									
  									
  									
  									fakeData.setProd_menge(originData.getProd_menge());
  									fakeData.setProd_fail_menge(originData.getProd_fail_menge());
  									
  								    int prod_menge2 = 0;
  		  				        
	  		  				        try
	  		  				        {
	  		  				        	prod_menge2 = Integer.parseInt(originData.getProd_menge());
	  		  				        }catch(Exception e7)
	  		  				        {
	  		  				        	e7.getStackTrace();
	  		  				        }
	  		  				        
	  		  				        prod_menge_sum = prod_menge_sum + prod_menge2;
	  		  				        
	  		  				        int prod_fail_menge2 = 0;
	  						        
	  						        try
	  						        {
	  						        	prod_fail_menge2 = Integer.parseInt(originData.getProd_fail_menge());
	  						        }catch(Exception e7)
	  						        {
	  						        	e7.getStackTrace();
	  						        }
  						        
	  						        prod_fail_menge_sum = prod_fail_menge_sum + prod_fail_menge2;
	  						        
	  						        
  							
  									
  								}else//마지막이 아닐떄
  								{
  									//dataList.get(j+(k+1)).setWork_str_time(st_date.replace(st_date.substring(11,19), "23:59:59"));

  									fakeData.setWork_str_time(tom_str_date);
  									fakeData.setWork_end_time(tom_str_date.replace(tom_str_date.substring(11,19), "23:59:59"));
  									
  									fakeData.setToday_str_time(fakeData.getWork_str_time());
  									fakeData.setToday_end_time(fakeData.getWork_end_time());
  									
  									
  			
  									fakeData.setProd_menge("0");
  									fakeData.setProd_fail_menge("0");
  							
  								}//else끝
  				
  								
  								try
  						        {
  		  							SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  		  							Date wet = simpleDateFormat.parse(fakeData.getWork_end_time());
  		  							Date wst = simpleDateFormat.parse(fakeData.getWork_str_time());	
			
  		  							long wet_= wet.getTime();
  		  							long wst_= wst.getTime();
  		  							long time_sec = (wet_ - wst_) / 1000;
			
  	  								work_time_sec_sum = (int) (work_time_sec_sum + time_sec);
  						        }catch(Exception e8)
  						        {
  						        	e8.getStackTrace();
  						        }
  							  
  	  					        if(!prev_today_str_time.equals(fakeData.getWork_str_time())){
  	  					        	
  	  					        	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  							Date wet = simpleDateFormat.parse(fakeData.getToday_end_time());
		  							Date wst = simpleDateFormat.parse(fakeData.getToday_str_time());	
		
		  							long wet_= wet.getTime();
		  							long wst_= wst.getTime();
		  							long time_sec = (wet_ - wst_) / 1000;
		  							fakeData.setToday_time_sec(time_sec+"");
  	  					        }else
  	  					        {
  	  					        	fakeData.setToday_time_sec("0");
  	  					        }
  	  					        prev_today_str_time = fakeData.getWork_str_time();
  	  					        
  	  					       today_time_sec_sum = today_time_sec_sum + Integer.parseInt(fakeData.getToday_time_sec());
  								
  								dataList.add(j+1,fakeData);
  								
  							}//for문끝
  							
  							originData.setWork_end_time(end_date);
  							originData.setProd_menge("0");
  							originData.setProd_fail_menge("0");
  							
  							
  						}else//날짜가 같을때
  						{
  							
  							int prod_menge = 0;
  	  				        
  	  				        try
  	  				        {
  	  				        	prod_menge = Integer.parseInt(originData.getProd_menge());
  	  				        }catch(Exception e7)
  	  				        {
  	  				        	e7.getStackTrace();
  	  				        }
  	  				        
  	  				        prod_menge_sum = prod_menge_sum + prod_menge;
  	  				        //------------------------------------------
  	  				        int prod_fail_menge = 0;
  					        
  					        try
  					        {
  					        	prod_fail_menge = Integer.parseInt(originData.getProd_fail_menge());
  					        }catch(Exception e7)
  					        {
  					        	e7.getStackTrace();
  					        }
  					        
  					        prod_fail_menge_sum = prod_fail_menge_sum + prod_fail_menge;
  					        //-------------------------------------------
  					        
  					        work_time_sec_sum = work_time_sec_sum + Integer.parseInt(originData.getWork_time_sec());
  					        
  					
  					        
  					        if(!prev_today_str_time.equals(originData.getToday_str_time())){
  					        	
  					        }else
  					        {
  					        	originData.setToday_time_sec("0");
  					        }
  					        prev_today_str_time = originData.getToday_str_time();
  					        
  					        
  					        today_time_sec_sum = today_time_sec_sum + Integer.parseInt(originData.getToday_time_sec());

  						}
  					
  			        
  			        }
  			        catch(Exception e)
  			        {
  			            // 예외 처리
  			        }

  				}
  			

		        System.out.println("work_time_sec_sum : " + work_time_sec_sum);

	  			dataList.get(0).setWork_time_sec_sum(work_time_sec_sum);
	  			dataList.get(0).setToday_time_sec_sum(today_time_sec_sum);
	  			dataList.get(0).setProd_menge_sum(prod_menge_sum);
	  			dataList.get(0).setProd_fail_menge_sum(prod_fail_menge_sum);
	  			
	  			// 자릿수 13.44시간
	  			float work_time_hour_l = (float) (work_time_sec_sum/3600f);
	  		 
	  			String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
	 
	  			dataList.get(0).setWork_time_hour(work_time_hour);
	  			
	  			float today_time_hour_l = (float) (today_time_sec_sum/3600f);
	  			
	  			String today_time_hour =  String.format("%.2f", today_time_hour_l) + "시간";
	  			
	  			dataList.get(0).setToday_time_hour(today_time_hour);
  			}
  			
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
   
   
   
   public int getTimeSec(String end_time , String str_time)
   {

	   int result = 0;
	   try{
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
			Date str_d =  f.parse(str_time); // 체크
			Date end_d = f.parse(end_time); // 체크
			
			long diff = end_d.getTime() - str_d.getTime();
		 
		
			long sec = diff / 1000;

		   
			result = Integer.parseInt(sec+"");
			
			
	   }catch(Exception e)
	   {
		    System.out.println("e: " + e.getMessage());
		   e.getStackTrace();
	   }
		
		return result;
   }
   
   public long getTimeMiliSec(String str_time , String end_time)
   {
	
	   long result = 0;
	   try{
			SimpleDateFormat f = new SimpleDateFormat("HH:mm:ss", Locale.KOREA);
			Date str_d =  f.parse(str_time); // 체크
			Date end_d = f.parse(end_time); // 체크
			
			long diff =  str_d.getTime() - end_d.getTime();
		
			result = diff;
	   }catch(Exception e)
	   {
		   e.getStackTrace();
	   }
		
		return result;
   }
   
   public List<SYProductOperStatusVO> settingFinal(List<SYProductOperStatusVO> resultList)
   {
	   
	   List<SYProductOperStatusVO> realList = new ArrayList<SYProductOperStatusVO>();
	   
	   int prod_menge = 0;
	   int prod_fail_menge = 0;
		
	   for(int i = 0 ; i< resultList.size(); i++)
	   {
	
		
		   try{
			   SYProductOperStatusVO currentVo = resultList.get(i);
			   
			   if("HOLD".equals(currentVo.getGb()))
		       {  	
					continue;
		       }
			   
			   SYProductOperStatusVO nextVo = resultList.get(i+1);
			   if(!currentVo.getWork_end_time().substring(0,10).equals(currentVo.getWork_str_time().substring(0,10)))
			   {
				   
				   if(!currentVo.getWork_end_time().equals(nextVo.getWork_str_time()))
				   {
					 
					   
					   	currentVo.setWork_end_time(nextVo.getWork_str_time());
					   
					   	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
				
						float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
						String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
			
					    currentVo.setWork_time(work_time_hour);
				   }
			   }else
			   {
				   if(currentVo.getWork_end_time().substring(0,10).equals(nextVo.getWork_str_time().substring(0,10)))
				   {
					   if(!currentVo.getWork_end_time().equals(nextVo.getWork_str_time()))
					   {
						   currentVo.setWork_end_time(nextVo.getWork_str_time());
						   
						   	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
					
							float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
							String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
				
						    currentVo.setWork_time(work_time_hour);
					   }
				   }
				  /* if(!currentVo.getWork_end_time().equals(nextVo.getWork_str_time()))
				   {
					   currentVo.setWork_end_time(nextVo.getWork_str_time());
					   
					   	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
				
						float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
						String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
			
					    currentVo.setWork_time(work_time_hour);
				   }else */
				   {
		
					    long diff = getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time());

					    if(diff < 0 )
					    {
					    	currentVo.setWork_end_time(nextVo.getWork_str_time());
						 	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
							
							float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
							String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
				
						    currentVo.setWork_time(work_time_hour);
					    }
				   }
			
			   }
			   
			   if(!"PROCESS".equals(currentVo.getGb()) && "08:30:00".equals(currentVo.getWork_str_time().substring(11,19)))
	   			{
				   if(!"HOLD".equals(currentVo.getGb())){
				   currentVo.setGb("WAITING");
				   }
	   			}
			   
			   
				
		   }catch(Exception e)
		   {
			   e.getStackTrace();
		   }
		   
	   }
	   
	
	 
	   for(int i = 0 ; i < resultList.size(); i++)
	   {
		    SYProductOperStatusVO data = resultList.get(i);
	   
			String currentGb = data.getGb();
			

			   
			   
			String currentItemCode = data.getItem_code();
			String currentItemNm= data.getItem_nm();
	
		
		
			SYProductOperStatusVO nextVo = null;
			SYProductOperStatusVO prevVo = null;
			SYProductOperStatusVO currentVo = resultList.get(i);
			
			if(!"PROCESS".equals(data.getGb()) && currentVo.getWork_str_time().equals(currentVo.getWork_end_time())){
				
				continue;
			}

			if("WAITING".equals(data.getGb()) && getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time()) < 0){
				
				continue;
	      	}
			try{
			    	prevVo = resultList.get(i-1);
		    }catch(Exception e)
		    {
		    	e.getStackTrace();
		    }
			if(prevVo != null && prevVo.getWork_str_time().equals(currentVo.getWork_str_time())
					&& prevVo.getWork_end_time().equals(currentVo.getWork_end_time())){
				
				continue;
			}
		  
			
			try{
				nextVo = resultList.get(i+1);
				
				if("WAITING".equals(currentVo.getGb())&& nextVo != null 
						&& getTimeMiliSec(currentVo.getWork_str_time().substring(11,19), "17:30:00") > 0
						&& !nextVo.getWork_str_time().substring(0,10).equals(currentVo.getWork_str_time().substring(0,10))){
					
					continue;
				}
				
				if("WAITING".equals(currentVo.getGb()) && currentVo.getWork_str_time().equals(nextVo.getWork_str_time())){
					
					continue;
		      	}
		    }catch(Exception e)
		    {
		    	e.getStackTrace();
		    }
			
			/*if("WAITING".equals(prevVo.getGb()) && prevVo != null && getTimeSec(prevVo.getWork_str_time(),currentVo.getWork_str_time()) > 0){
				
				continue;
			}*/
			
		
			if(getValidDate(param_str_time,param_end_time , data.getWork_end_time()))
			{
			realList.add(data);
			
			if(i == 0 )
			{
				String time_hour = String.format("%.2f", (float) (0f)) + "시간";
				realList.get(0).setProcess_time_s(0);
				realList.get(0).setProcess_time_hour(time_hour);
				
				realList.get(0).setUnprocess_time_s(0);
				realList.get(0).setUnprocess_time_hour(time_hour);
				
				realList.get(0).setWaiting_time_s(0);
				realList.get(0).setWaiting_time_hour(time_hour);
			}
			if("PROCESS".equals(data.getGb()))
			{
				long current_time_sec = realList.get(0).getProcess_time_s() + Long.parseLong(data.getWork_time_sec());
				realList.get(0).setProcess_time_s(Integer.parseInt(current_time_sec+""));
				
				String process_time_hour = String.format("%.2f", (float) (current_time_sec/3600f)) + "시간";
				
				realList.get(0).setProcess_time_hour(process_time_hour);
			}else if("UNPROCESS".equals(data.getGb()))
			{
				long current_time_sec = realList.get(0).getUnprocess_time_s() + Long.parseLong(data.getWork_time_sec());
				realList.get(0).setUnprocess_time_s(Integer.parseInt(current_time_sec+""));
				
				String unprocess_time_hour = String.format("%.2f", (float) (current_time_sec/3600f)) + "시간";
				realList.get(0).setUnprocess_time_hour(unprocess_time_hour);
			}else if("WAITING".equals(data.getGb()))
			{
				long current_time_sec = realList.get(0).getWaiting_time_s() + Long.parseLong(data.getWork_time_sec());
				realList.get(0).setWaiting_time_s(Integer.parseInt(current_time_sec+""));
				
				String waiting_time_hour = String.format("%.2f", (float) (current_time_sec/3600f)) + "시간";
				realList.get(0).setWaiting_time_hour(waiting_time_hour);
				
				
			}
			long today_time_sec = realList.get(0).getProcess_time_s() + realList.get(0).getUnprocess_time_s() + realList.get(0).getWaiting_time_s();
			realList.get(0).setToday_time_s(Integer.parseInt(today_time_sec+""));
			String today_time_hour = String.format("%.2f", (float) (today_time_sec/3600f)) + "시간";
			realList.get(0).setToday_time_hour(today_time_hour);
			
			prod_menge = prod_menge + Integer.parseInt(data.getProd_menge());
			prod_fail_menge = prod_fail_menge + Integer.parseInt(data.getProd_fail_menge());
		
			realList.get(0).setProd_menge_sum(prod_menge);
			realList.get(0).setProd_fail_menge_sum(prod_fail_menge);
			}
		}
				
	   
	   float today_total = 0;
	   for(int i = 0 ; i< realList.size(); i++)
	   {
		
		
		   try{
			   SYProductOperStatusVO currentVo = realList.get(i);
			   if(i == 0)
				{
					str_date = currentVo.getWork_end_time();
				}
				if(i == realList.size()-1)
				{
					end_date = currentVo.getWork_end_time();
				}
			   if("HOLD".equals(currentVo.getGb()))
		       {  	
					continue;
		       }
			   
			   SYProductOperStatusVO prevVo = null;
			   try{
				   prevVo = realList.get(i-1);
			   }catch(Exception e7)
			   {
				   e7.getStackTrace();
			   }
			   
			   SYProductOperStatusVO nextVo = null;
			   try{
				   nextVo = realList.get(i+1);
			   }catch(Exception e7)
			   {
				   e7.getStackTrace();
			   }
			   if(!currentVo.getWork_end_time().substring(0,10).equals(currentVo.getWork_str_time().substring(0,10)))
			   {
				   
				   if(!currentVo.getWork_end_time().equals(nextVo.getWork_str_time()))
				   {
					 
					   
					   	currentVo.setWork_end_time(nextVo.getWork_str_time());
					   
					   	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
				
						float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
						String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
			
					    currentVo.setWork_time(work_time_hour);
				   }
			   }else
			   {

				    long diff = getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time());
	
				    
				    if(diff < 0 )
				    {
				   
				    	currentVo.setWork_end_time(nextVo.getWork_str_time());
					 	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
						
						float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
						String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
			
					    currentVo.setWork_time(work_time_hour);
				    }
			
			   }
			   
			   if(!"PROCESS".equals(currentVo.getGb())   && !currentVo.getWork_str_time().substring(0,10).equals(nextVo.getWork_str_time().substring(0,10)))
			   {
				   if(!"HOLD".equals(currentVo.getGb())){
					   currentVo.setGb("WAITING");
				   }
			   }
			   try{
				
				   if("WAITING".equals(currentVo.getGb())
							&& !prevVo.getWork_end_time().substring(0,10).equals(currentVo.getWork_str_time().substring(0,10)) )
					{
				        String default_str_time = currentVo.getWork_str_time().replace(currentVo.getWork_str_time().substring(11,19), "08:30:00");
						currentVo.setWork_str_time(default_str_time);	
					}
			   }catch(Exception e1)
			   {
				   e1.getStackTrace();
			   }
			   try{
			
				   if("WAITING".equals(currentVo.getGb())
							&& !nextVo.getWork_str_time().substring(0,10).equals(currentVo.getWork_end_time().substring(0,10)) )
					{
					   if(getTimeMiliSec(currentVo.getWork_end_time().substring(11,19), "17:30:00") > 0){
				        String default_end_time = currentVo.getWork_str_time().replace(currentVo.getWork_str_time().substring(11,19), "17:30:00");
						
				        currentVo.setWork_end_time(default_end_time);	
					   }
					}
			   }catch(Exception e1)
			   {
				   e1.getStackTrace();
			   }
			
			   today_total = today_total + Float.parseFloat(currentVo.getWork_time().replace("시간", ""));
			   if(nextVo == null){
	
				   currentVo.setToday_total(today_total);
				   today_total = 0;
			   }
			   else if(!currentVo.getWork_str_time().substring(0,10).equals(nextVo.getWork_str_time().substring(0,10)))
			   {

				   currentVo.setToday_total(today_total);
				   today_total = 0;
			   }else{
				   
			   }
			   
			  /* if(prevVo !=null && getTimeSec(prevVo.getWork_str_time(),currentVo.getWork_str_time()) > 0){
					
				   realList.remove(i);
		       }*/
		   }catch(Exception e)
		   {
			   e.getStackTrace();
		   }
		   
	   }
		
	   long total_today_time_sec = 0;
	   long total_process_time_sec = 0;
	   
	   long machine_day_time_sec = 0;
	   long machine_process_time_sec = 0;
	   
	   settingMachineProcessPerList();
	   settingProcessPerList();
	   List<SYProductOperStatusVO> newList = new ArrayList<SYProductOperStatusVO>();
		
	   for(int i = 0 ; i < realList.size(); i++)
	   {
		    SYProductOperStatusVO data = realList.get(i);
	   
			String currentGb = data.getGb();
			
			
			String currentItemCode = data.getItem_code();
			String currentItemNm= data.getItem_nm();
			if("".equals(origin_gb))
			{
				currentGb = "";
			}
			
			if("".equals(origin_item_code))
			{
				currentItemCode = "";
			}
			
			if("".equals(origin_item_nm))
			{
				currentItemNm = "";
			}
	
		
			if("HOLD".equals(data.getGb())){
				data.setWork_time_sec(0+"");
				data.setWork_time(0.00+"시간");
			}
			String month = data.getWork_end_time().substring(5,7);
			data.setMonth(month);
			
			String machineCode = data.getMachine_code();
			
			
			long current_work_time_sec = 0 ;
			
			
			try{
				current_work_time_sec = Long.parseLong(data.getWork_time_sec());
			}catch(Exception e)
			{
				e.getStackTrace();
			}
		
			System.out.println("month : " + month );
			System.out.println("start_month : " + start_month );
			if(Integer.parseInt(month) < Integer.parseInt(start_month))
			{
				total_process_time_sec = 0;
				machine_process_time_sec = 0;
				
				total_today_time_sec= 0;
				machine_day_time_sec= 0;
			

			}
			if("HOLD".equals(data.getGb())){
				
				current_work_time_sec = 0;
				
				
			}
			if(getTimeSec(str_date,data.getEnd_date())<=0  &&  getTimeSec(end_date,data.getEnd_date())>=0 ){
				if("PROCESS".equals(data.getGb()))
				{
					System.out.println("$$$ PROCESS getWork_end_time : " + data.getWork_end_time());
					System.out.println("$$$ PROCESS current_work_time_sec : " + current_work_time_sec);
					total_process_time_sec = total_process_time_sec + current_work_time_sec;
					
					machine_process_time_sec = machine_process_time_sec + current_work_time_sec;
				}
				if(!"HOLD".equals(data.getGb())){
				total_today_time_sec = total_today_time_sec + current_work_time_sec;
				System.out.println("$$$  data.getGb() : " + data.getGb());
				System.out.println("$$$  total_today_time_sec : " + total_today_time_sec);
				System.out.println("$$$ machine_day_time_sec : " + machine_day_time_sec);
				machine_day_time_sec = machine_day_time_sec + current_work_time_sec;
				}
			}
			try{
				SYProductOperStatusVO nextData = realList.get(i+1);
				String next_month = nextData.getWork_end_time().substring(5,7);

				
				
				if(!month.equals(next_month))
				{
					System.out.println("$$$ machine_code : " + data.getMachine_code());
					System.out.println("$$$ data.getWork_end_time() : " + data.getWork_end_time());
					System.out.println("$$$ month : " + month);
					System.out.println("$$$ total_process_time_sec : " + total_process_time_sec);
					System.out.println("$$$ total_today_time_sec : " + total_today_time_sec);
					float currentPer = (((float)total_process_time_sec/total_today_time_sec) * 100);
					if(total_process_time_sec == 0)
					{
						currentPer = 0.0f;
					}
					if(Integer.parseInt(month) < Integer.parseInt(start_month))
					{
						currentPer = 0.0f;
					
					}
			
					 KPI_Per_Vo pVo = monthProcessPerList.get(Integer.parseInt(month)-1);
				
					 if("NaN".equals(currentPer))
					 {
						 currentPer = 0;
					 }
					  float realPer = pVo.getPer() + currentPer;
					  int realCnt =  pVo.getCnt() +1;
					  System.out.println("^^^^ pVo.getPer() : " + pVo.getPer());
					  System.out.println("^^^^ currentPer : " + currentPer);
					  System.out.println("^^^^ realPer : " + realPer);
					
					  pVo.setPer(realPer);
					  pVo.setCnt(realCnt);
					  
					
					monthProcessPerList.set(Integer.parseInt(month)-1, pVo);
					total_process_time_sec = 0;
					data.setToday_time_sec(total_today_time_sec+"");
					total_today_time_sec = 0;
				}//월 if문 끝
			}catch(Exception e)
			{
				e.getStackTrace();
				
				float currentPer = (((float)total_process_time_sec/total_today_time_sec) * 100);
				
				if(total_process_time_sec == 0)
				{
					currentPer = 0.0f;
				}
	
				if(Integer.parseInt(month) < Integer.parseInt(start_month))
				{
					currentPer = 0.0f;
				
				}

				 KPI_Per_Vo pVo = monthProcessPerList.get(Integer.parseInt(month)-1);

				  float realPer = pVo.getPer() + currentPer;
				  int realCnt =  pVo.getCnt() +1;
				  pVo.setPer(realPer);
				  pVo.setCnt(realCnt);
				  System.out.println("^^^^ 111  realPer : " + realPer);
				monthProcessPerList.set(Integer.parseInt(month)-1, pVo);
				total_process_time_sec = 0;
				data.setToday_time_sec(total_today_time_sec+"");
				total_today_time_sec = 0;
			}
			try{
				SYProductOperStatusVO nextData = realList.get(i+1);
				String next_machineCode = nextData.getMachine_code();
			
				if(!machineCode.equals(next_machineCode))
				{	System.out.println("머신코드바뀜");
					System.out.println("$$$ machine_code : " + data.getMachine_code());
					System.out.println("$$$ data.getWork_end_time() : " + data.getWork_end_time());
					System.out.println("$$$ month : " + month);
					System.out.println("$$$ machine_process_time_sec : " + machine_process_time_sec);
					System.out.println("$$$ machine_day_time_sec : " + machine_day_time_sec);
					
					float currentPer = (((float)machine_process_time_sec/machine_day_time_sec) * 100);
					if(Integer.parseInt(month) < Integer.parseInt(start_month))
					{
						currentPer = 0.0f;
					
					}
		
					 String per = String.format("%.1f", currentPer);
					
					SYKPI_OperationVo opVo = new SYKPI_OperationVo();
					opVo.setMachine_code(machineCode);
					opVo.setPer(per);
					
					machineProcessPerList.add(opVo);
					machine_process_time_sec = 0;
				
					machine_day_time_sec = 0;
				}//머신이름 if문 끝
			}
			catch(Exception e)
			{
				float currentPer = (((float)machine_process_time_sec/machine_day_time_sec) * 100);
				if(Integer.parseInt(month) < Integer.parseInt(start_month))
				{
					currentPer = 0.0f;
				
				}
				 String per = String.format("%.1f", currentPer);
				
				SYKPI_OperationVo opVo = new SYKPI_OperationVo();
				opVo.setMachine_code(machineCode);
				opVo.setPer(per);
				
				machineProcessPerList.add(opVo);
				machine_process_time_sec = 0;
			
				machine_day_time_sec = 0;
			}
		
			
			
			newList.add(data);
			
	   }
	   
	   
	   
	 
	   return newList;
   }

   public ArrayList<SYKPI_OperationVo> machineProcessPerList = new ArrayList<SYKPI_OperationVo>();
   
   public void settingMachineProcessPerList()
   {
	   machineProcessPerList = new ArrayList<SYKPI_OperationVo>();
	   
   }
   
   public ArrayList<KPI_Per_Vo> monthProcessPerList = new ArrayList<KPI_Per_Vo>();
   
   public void settingProcessPerList()
   {
	   monthProcessPerList = new ArrayList<KPI_Per_Vo>();
	   for(int i = 0; i<12; i++)
	   {
		   KPI_Per_Vo pVo = new KPI_Per_Vo();
		   pVo.setMonth((i+1)+"");
		   pVo.setPer(0.0f);
		   
		   monthProcessPerList.add(pVo);
	   }
   }
   
   public void addData(SYProductOperStatusVO data,List<SYProductOperStatusVO> resultList)
   {
	   try{
		   SYProductOperStatusVO prevVo  = resultList.get(resultList.size()-1);
		    if("WAITING".equals(data.getGb()) && "HOLD".equals(prevVo.getGb()))
		    {
		    	 if(!data.getWork_str_time().equals(prevVo.getWork_end_time()))
		    	 {
		    		 return;
		    	 }
		    	
		    }
	   }catch(Exception e)
	   {
		   e.getStackTrace();
	   }
	   if(data.getWork_str_time().equals(data.getWork_end_time()))
		{
			return;
		}
	    System.out.println("addData.get getWork_str_time" + data.getWork_str_time());
	    System.out.println("addData.get getWork_end_time" + data.getWork_end_time());
	    data.setWork_time_sec(getTimeSec(data.getWork_end_time(),data.getWork_str_time())+"");		

		float work_time_hour_l = (float) (Long.parseLong(data.getWork_time_sec())/3600f);
		String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";

		
		data.setWork_time(work_time_hour);
		if("HOLD".equals(data.getGb())){
			data.setWork_time_sec(0+"");
			data.setWork_time(0.00+"시간");
		}
		
		resultList.add(data);
	

   }
   private Boolean getValidDate(String strStart, String strEnd, String strValue) {


	   strStart = strStart + " 00:00:00";
	   strEnd = strEnd + " 23:59:59";
	   Calendar calStart = getDateTime(strStart);
	   Calendar calEnd = getDateTime(strEnd);
	   Calendar calValue = getDateTime(strValue);	     
	   Boolean bValid = false;

	   if (calStart.before (calValue) && calEnd.after(calValue)) {
	      bValid = true;
	   }

	   return bValid;

   }

   private Calendar getDateTime(String strDatetime) {

	   Calendar cal = Calendar.getInstance();

	   String[] strSplitDateTime = strDatetime.split(" ");

	   String[] strSplitDate = strSplitDateTime[0].split("-");

	   String[] strSplitTime = strSplitDateTime[1].split(":");

	   cal.set(Integer.parseInt(strSplitDate[0]), Integer.parseInt(strSplitDate[1]) - 1,

       Integer.parseInt(strSplitDate[2]), Integer.parseInt(strSplitTime[0]), Integer.parseInt(strSplitTime[1]),

       Integer.parseInt(strSplitTime[2]));

	   return cal;

   } 
   
   
   public long getDateDiff(String str_time, String end_time)
   {
	   long diff = 0;
	    try {
	        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	       
		    Date strDate = format.parse(str_time);
		
	        Date endDate = format.parse(end_time);
	
	        
	        long cDate = strDate.getTime() - endDate.getTime(); 
	        
	         diff = cDate / ( 24*60*60*1000); 
	    
	        diff = Math.abs(diff);
	        
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        return diff;
   }
   
   public String param_str_time;
   public String param_end_time;
   public String origin_gb = "";
   public String origin_item_code = "";
   public String origin_item_nm= "";
  
   
   
   @SuppressWarnings("unchecked")
  	@ResponseBody
  	@RequestMapping(value="/machine/selectProductOperStatus", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
  	public String selectProductOperStatus(@ModelAttribute SYProductOperStatusVO vo, HttpServletRequest request, HttpServletResponse response) {
  		logger.debug("FrontendController.selectProductOperStatus() is called.");
  		
  		JSONObject resultData = new JSONObject();
  		JSONArray listDataJArray = new JSONArray();
  		JSONParser jsonParser = new JSONParser();
  		try {

  			
  			origin_gb = vo.getGb();
  			origin_item_code = vo.getItem_code();
  			origin_item_nm = vo.getItem_nm();
  			
  			param_str_time = vo.getWork_str_time().split(" - ")[0];
  			param_end_time = vo.getWork_str_time().split(" - ")[1];
  			vo.setGb("");
  			vo.setItem_code("");
  			vo.setItem_nm("");
  			
  			boolean dateChageFlag = false;
  			List<SYProductOperStatusVO> dataList = sYProductService.selectProductOperStatus(vo);
  			
  			for(int i = 0 ; i< dataList.size(); i++)
  			   {				
  				   try{
  					
  					   SYProductOperStatusVO currentVo = dataList.get(i);
  					   
  					   if(i == 0 )
  					   {
  						 start_month = currentVo.getWork_end_time().substring(5,7);
  					   }
  					   if("HOLD".equals(currentVo.getGb()))
  				       {  		   
  							continue;
  				       }
  					   
  					   SYProductOperStatusVO prevVo = dataList.get(i-1);
  					   
  					   if(prevVo.getWork_end_time().equals(currentVo.getWork_end_time()))
  					   {
  						   System.out.println("최초다 getWork_str_time " + currentVo.getWork_str_time());
  							System.out.println("최초다 getWork_end_time" + currentVo.getWork_end_time());
  						   dataList.remove(i);
  						   
  					   }
  					   
  				   }catch(Exception e)
  				   {
  					   e.getStackTrace();
  				   }
  				   
  			}
  			
  			for(int i = 0 ; i< dataList.size(); i++)
  			   {
  				
  				
  				   try{
  					   SYProductOperStatusVO currentVo = dataList.get(i);
  					   
  					   if("HOLD".equals(currentVo.getGb()))
  				       {  	
  				        	continue;
  				       }
  					   
  					   System.out.println("최초 getWork_str_time" + currentVo.getWork_str_time());
  					   System.out.println("최초 getWork_end_time" + currentVo.getWork_end_time());
  					   SYProductOperStatusVO nextVo = dataList.get(i+1);
  			
  					   if(!currentVo.getWork_end_time().substring(0,10).equals(currentVo.getWork_str_time().substring(0,10)))
  					   {
  						   if(!currentVo.getWork_end_time().equals(nextVo.getWork_str_time()))
  						   {				
  							   	currentVo.setWork_end_time(nextVo.getWork_str_time());
  							    System.out.println("1차 변경 getWork_str_time" + currentVo.getWork_str_time());
  								System.out.println("1차 변경 getWork_end_time" + currentVo.getWork_end_time());
  							   	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
  							   
  								float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
  								String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
  			
  							    currentVo.setWork_time(work_time_hour);
  							    dataList.set(i,currentVo);
  						   }
  					   }
  					   
  					  
  					   
  				   }catch(Exception e)
  				   {
  					   e.getStackTrace();
  				   }
  				   
  			}
  			
  			
  			List<SYProductOperStatusVO> resultList = new ArrayList<SYProductOperStatusVO>();
  			System.out.println("--------------------------------------------------------");
  			int minusCount = 0;
  			if(dataList.size() > 0){
  				
  				for(int j = 0; j< dataList.size(); j++){
  					SYProductOperStatusVO originData = dataList.get(j);
  				
  					System.out.println("2차 getWork_str_time" + originData.getWork_str_time());
  					System.out.println("2차 getWork_end_time" + originData.getWork_end_time());
    				 	String date1 = originData.getWork_str_time().substring(0,10);
    				    String date2 = originData.getWork_end_time().substring(0,10);

  			        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

  			        Date FirstDate = format.parse(date1);
  			        Date SecondDate = format.parse(date2);

  			        long calDate = FirstDate.getTime() - SecondDate.getTime(); 
  			        
  			        long calDateDays = calDate / ( 24*60*60*1000); 
  			    
  			        calDateDays = Math.abs(calDateDays);
  			        
  			        String work_str_time = originData.getWork_str_time();
  			        String work_end_time = originData.getWork_end_time();
  			        String gb = originData.getGb();
  			        
  			        String default_str_time = work_end_time.replace(work_end_time.substring(11,19), "08:30:00");
  			        String default_end_time = work_str_time.replace(work_str_time.substring(11,19), "17:30:00");
  			    
  			        
  			        System.out.println("calDateDays : " + calDateDays);
  			        
  			        if("HOLD".equals(originData.getGb()))
  			        {
  			        	
  			        	addData(originData, resultList);
  			        	continue;
  			        }
  			        if(calDateDays != 0 ){
  			        				        	
  			        		if( j == 0)
  			        		{
  			        			if(dataList.size() == 1 )
  			        			{
  			        				if("WAITING".equals(originData.getGb()))
  			        				{
  			        					
  			        				}else
  			        				{
  			        					
  			       
  		        					  
  		        				        Date strDate = format.parse(param_str_time);
  		        				        Date endDate = format.parse(work_end_time);

  		        				        long cDate = strDate.getTime() - endDate.getTime(); 
  		        				        
  		        				        long diff = cDate / ( 24*60*60*1000); 
  		        				    
  		        				        diff = Math.abs(diff);
  		        				        
  		        				        if(diff == 0)
  		        				        {  
  		        				        	
  		        				        	originData.setWork_str_time(default_str_time);
  		        						    addData(originData,resultList);
  		        				        }else{
  			        				        
  		        				        for(int k = 0; k < diff; k++)
  		        				        {
  		        				        	Calendar cal = Calendar.getInstance();
  			  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  			  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  			  						        Date date = null;
  			  						        try {
  			  						            date = df.parse(param_str_time);
  			  						        } catch (Exception e) {
  			  						            e.printStackTrace();
  			  						        }
  			  						        
  			  						        cal.setTime(date);
  				  						    cal.add(Calendar.DATE, k);
  				  				
  				  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  				  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  					  					
  				  						    
  				  							SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  				        					fakeData.setGb(gb);
  											fakeData.setProduct_po(originData.getProduct_po());
  											fakeData.setItem_code(originData.getItem_code());
  											fakeData.setItem_nm(originData.getItem_nm());
  											fakeData.setMachine_code(originData.getMachine_code());
  											fakeData.setRouting_nm(originData.getRouting_nm());
  											
  											fakeData.setProd_menge("0");
  											fakeData.setProd_fail_menge("0");
  											fakeData.setWork_str_time(first_str_time);
  											fakeData.setWork_end_time(first_end_time);
  				  						    addData(fakeData,resultList);
  		        				        }
  		        				        }
  			        				
  			        					
  			        				}	
  			        				
  			        			}else{
  				        			if(getTimeMiliSec(work_end_time.substring(11,19), "08:30:00") < 0)
  					        		{
  				        				originData.setWork_str_time(work_end_time);
  				        				originData.setWork_end_time(work_end_time);
  				        		
  					        		}else
  					        		{
  					        			/*if(!"PROCESS".equals(originData.getGb()))
  					        			{
  					        				originData.setGb("WAITING");
  					        			}*/
  					        			originData.setWork_str_time(default_str_time);
  				        				originData.setWork_end_time(work_end_time);
  				        				
  				        				 Date strDate = format.parse(param_str_time);
  			        				        Date endDate = format.parse(work_end_time);

  			        				        long cDate = strDate.getTime() - endDate.getTime(); 
  			        				        
  			        				        long diff = cDate / ( 24*60*60*1000); 
  			        				    
  			        				        diff = Math.abs(diff);
  			        		
  			        				        for(int k = 0; k < diff; k++)
  			        				        {
  			        				        	Calendar cal = Calendar.getInstance();
  				  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  				  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  				  						        Date date = null;
  				  						        try {
  				  						            date = df.parse(param_str_time);
  				  						        } catch (Exception e) {
  				  						            e.printStackTrace();
  				  						        }
  				  						        
  				  						        cal.setTime(date);
  					  						    cal.add(Calendar.DATE, k);
  					  			
  					  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  					  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  						  					
  					  						    
  					  							SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  					        					fakeData.setGb(gb);
  												fakeData.setProduct_po(originData.getProduct_po());
  												fakeData.setItem_code(originData.getItem_code());
  												fakeData.setItem_nm(originData.getItem_nm());
  												fakeData.setMachine_code(originData.getMachine_code());
  												fakeData.setRouting_nm(originData.getRouting_nm());
  												
  												fakeData.setProd_menge("0");
  												fakeData.setProd_fail_menge("0");
  												fakeData.setWork_str_time(first_str_time);
  												fakeData.setWork_end_time(first_end_time);
  					  						    addData(fakeData,resultList);
  			        				        }
  					        			
  					        		}
  				        			
  				        			addData(originData,resultList);
  			        			}
  			        			
  			  
  			        			
  			        		}else if(j == dataList.size()-1)
  			        		{
  			        			if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") > 0)
  				        		{
  			        						
  			        				String prod_menge = originData.getProd_menge();
  			        				String prod_fail_menge = originData.getProd_fail_menge();
  			        				
  			        				originData.setProd_menge("0");
  			        				originData.setProd_fail_menge("0");
  			        				originData.setWork_str_time(work_str_time);
  			        				originData.setWork_end_time(work_str_time);
  			        				addData(originData,resultList);
  			        				
  			        				SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  		        					fakeData.setGb(gb);
  									fakeData.setProduct_po(originData.getProduct_po());
  									fakeData.setItem_code(originData.getItem_code());
  									fakeData.setItem_nm(originData.getItem_nm());
  									fakeData.setMachine_code(originData.getMachine_code());
  									fakeData.setRouting_nm(originData.getRouting_nm());
  			        				fakeData.setProd_menge(prod_menge);
  									fakeData.setProd_fail_menge(prod_fail_menge);
  									
  									fakeData.setWork_str_time(default_str_time);
  									fakeData.setWork_end_time(work_end_time);
  									addData(fakeData,resultList);
  				        		}else
  				        		{
  				        			originData.setWork_str_time(work_str_time);
  			        				originData.setWork_end_time(default_end_time);
  			        				originData.setProd_menge("0");
  			        				originData.setProd_fail_menge("0");
  			        				addData(originData,resultList);
  			        	
  			        				 Date strDate = format.parse(work_str_time);
  		        				        Date endDate = format.parse(work_end_time);

  		        				        long cDate = strDate.getTime() - endDate.getTime(); 
  		        				        
  		        				        long diff = cDate / ( 24*60*60*1000); 
  		        				    
  		        				        diff = Math.abs(diff);
  			        				        
  		        				        for(int k = 0; k < diff; k++)
  		        				        {
  		        				        	Calendar cal = Calendar.getInstance();
  			  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  			  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  			  						        Date date = null;
  			  						        try {
  			  						            date = df.parse(work_str_time);
  			  						        } catch (Exception e) {
  			  						            e.printStackTrace();
  			  						        }
  			  						        
  			  						        cal.setTime(date);
  				  						    cal.add(Calendar.DATE, k+1);
  				  				
  				  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  				  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  					  					
  				  						    
  				  							SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  				        					fakeData.setGb(gb);
  											fakeData.setProduct_po(originData.getProduct_po());
  											fakeData.setItem_code(originData.getItem_code());
  											fakeData.setItem_nm(originData.getItem_nm());
  											fakeData.setMachine_code(originData.getMachine_code());
  											fakeData.setRouting_nm(originData.getRouting_nm());
  											
  											fakeData.setProd_menge("0");
  											fakeData.setProd_fail_menge("0");
  											fakeData.setWork_str_time(first_str_time);
  											fakeData.setWork_end_time(first_end_time);
  											
  											if(k == diff-1)
  											{
  												fakeData.setWork_end_time(work_end_time);
  											}
  				  						    addData(fakeData,resultList);
  		        				        }
  			        				
  			        	
  				        		}
  			        			
  						
  			        		}else
  			        		{
  			        			if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") > 0)
  				        		{
  			        				
  			        				 /*if("WAITING".equals(gb)){
  			        					 
  			        					
  						          
  			        					 originData.setWork_str_time(default_str_time);
  				        				 originData.setWork_end_time(work_end_time);
  				        					 
  				        				 addData(originData,resultList);
  			        				 }else*/
  			        				 {
  			        					String origin_str_time =originData.getWork_str_time();
  		        				     	String prod_menge = originData.getProd_menge();
  					                 	String prod_fail_menge = originData.getProd_fail_menge();
  					        			originData.setProd_menge("0");
  					        			originData.setProd_fail_menge("0");
  			        					 originData.setWork_str_time(work_str_time);
  			        					 originData.setWork_end_time(work_str_time);
  			        					 
  			        					 addData(originData,resultList);
  			        					 
  			        					// if(!"WAITING".equals(gb))
  					        				{

  					        				    dateChageFlag = true;
  					        				    
  					        				    long size = calDateDays;
  					        					/*System.out.println("CCC work_str_time : " + work_str_time);
  					        					System.out.println("CCC param_str_time: " + param_str_time);
  					        					if(getTimeSec( param_str_time + " 00:00:00", work_str_time) > 0)
  					        					{       						
  					        						
  					        						size = getDateDiff(param_str_time, work_end_time) + 1;
  					        						System.out.println("CCC size: " + size);
  					        					}*/
  					        					
  					        				    for(int k = 0; k<size; k++)
  					        				    {
  					        				    	
  					        				    	SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  						        					fakeData.setGb(gb);
  													fakeData.setProduct_po(originData.getProduct_po());
  													fakeData.setItem_code(originData.getItem_code());
  													fakeData.setItem_nm(originData.getItem_nm());
  													fakeData.setMachine_code(originData.getMachine_code());
  													fakeData.setRouting_nm(originData.getRouting_nm());
  													
  													
  													fakeData.setProd_menge(prod_menge);
  													fakeData.setProd_fail_menge(prod_fail_menge);
  													System.out.println("바로 여기인가 44444");
  													fakeData.setWork_str_time(default_str_time);	      	
  													fakeData.setWork_end_time(work_end_time);
  													Calendar cal = Calendar.getInstance();
  					  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  					  						        Date date = null;
  					  						        try {
  					  						            date = df.parse(origin_str_time);
  					  						        } catch (Exception e) {
  					  						            e.printStackTrace();
  					  						        }
  					  						        
  					  						        cal.setTime(date);
  						  						    cal.add(Calendar.DATE, k+1);
  						  						    String first_str_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "08:30:00");
  						  						    String first_end_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "17:30:00");
  							  						
  						  						  
  													if(k == size -1){
  														fakeData.setProd_menge(prod_menge);
  														fakeData.setProd_fail_menge(prod_fail_menge);
  														System.out.println("바로 여기인가 33333");
  														fakeData.setWork_str_time(default_str_time);	      	
  														fakeData.setWork_end_time(work_end_time);
  													}else
  													{
  														fakeData.setProd_menge("0");
  														fakeData.setProd_fail_menge("0");
  														
  														fakeData.setWork_str_time(first_str_time);	      	
  														fakeData.setWork_end_time(first_end_time);
  													}
  													
  													addData(fakeData,resultList);
  					        				    }
  					        					
  					        				}
  			        				 }
  					        		
  				        		}else
  				        		{
  				        		
  				        			String origin_str_time =originData.getWork_str_time();
  				                 	String prod_menge = originData.getProd_menge();
  				                 	String prod_fail_menge = originData.getProd_fail_menge();
  				        			originData.setProd_menge("0");
  				        			originData.setProd_fail_menge("0");
  				        			originData.setWork_str_time(work_str_time);
  			        				originData.setWork_end_time(default_end_time);
  			        				System.out.println("날짜가 다른거 체크 gb : " + gb);
  			        				System.out.println("날짜가 다른거 체크 STR: " + work_str_time);
  			        				
  			        				
  			        	
  			        				if(getValidDate(param_str_time, param_end_time, originData.getWork_end_time())){
  			        					addData(originData,resultList);
  			        				}
  			        				//if(!"WAITING".equals(gb))
  			        				{
  			        			
  			        					
  			        				    dateChageFlag = true;
  			        				    long size = calDateDays;
  			        				/*	System.out.println("CCC work_str_time : " + work_str_time);
  			        					System.out.println("CCC param_str_time: " + param_str_time);
  			        					if(getTimeSec( param_str_time + " 00:00:00", work_str_time) > 0)
  			        					{       						
  			        						
  			        						size = getDateDiff(param_str_time, work_end_time) + 1;
  			        						System.out.println("CCC size: " + size);
  			        					}*/
  			        					
  			        				    for(int k = 0; k<size; k++)
  			        				    {
  			        				    	
  				        					SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  				        					fakeData.setGb(gb);
  											fakeData.setProduct_po(originData.getProduct_po());
  											fakeData.setItem_code(originData.getItem_code());
  											fakeData.setItem_nm(originData.getItem_nm());
  											fakeData.setMachine_code(originData.getMachine_code());
  											fakeData.setRouting_nm(originData.getRouting_nm());
  											fakeData.setProd_menge(prod_menge);
  											fakeData.setProd_fail_menge(prod_fail_menge);
  											System.out.println("바로 여기인가 ");
  											fakeData.setWork_str_time(default_str_time);	      	
  											fakeData.setWork_end_time(work_end_time);
  											
  											Calendar cal = Calendar.getInstance();
  			  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  			  						        Date date = null;
  			  						        try {
  			  						            date = df.parse(origin_str_time);
  			  						        } catch (Exception e) {
  			  						            e.printStackTrace();
  			  						        }
  			  						        
  			  						        cal.setTime(date);
  				  						    cal.add(Calendar.DATE, k+1);
  				  						    String first_str_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "08:30:00");
  				  						    String first_end_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "17:30:00");
  				  						
  				  						  
  											if(k == size -1){
  												fakeData.setProd_menge(prod_menge);
  												fakeData.setProd_fail_menge(prod_fail_menge);
  												System.out.println("바로 여기인가 2222");
  												fakeData.setWork_str_time(default_str_time);	      	
  												fakeData.setWork_end_time(work_end_time);
  											}else
  											{
  												fakeData.setProd_menge("0");
  												fakeData.setProd_fail_menge("0");
  												
  												fakeData.setWork_str_time(first_str_time);	      	
  												fakeData.setWork_end_time(first_end_time);
  											}
  											addData(fakeData,resultList);
  			        				    }
  			        				}
  			        		
  			        				
  				        		}
  			        		}
  				        
  	
  			        	
  			        }else
  			        {
  			        	
  				        	SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  	
  							fakeData.setGb("WAITING");
  							fakeData.setProduct_po(originData.getProduct_po());
  							fakeData.setItem_code(originData.getItem_code());
  							fakeData.setItem_nm(originData.getItem_nm());
  							fakeData.setMachine_code(originData.getMachine_code());
  							fakeData.setRouting_nm(originData.getRouting_nm());
  							fakeData.setProd_menge("0");
  							fakeData.setProd_fail_menge("0");
  							
  			        		if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") < 0 
  			        				&& getTimeMiliSec(work_end_time.substring(11,19), "17:30:00") < 0)
  			        		{
  			        		
  			        			if(getTimeMiliSec(work_str_time.substring(11,19), "08:30:00") <= 0 )
  			        			{
  			        				addData(originData,resultList);
  			        			}else{
  			        				System.out.println("CCC dateChageFlag: " + dateChageFlag);
  			        				if(!dateChageFlag){
  			        		
  				        				try{
  				        					if(!dataList.get(j-1).getWork_str_time().substring(0,10).equals(work_str_time.substring(0,10)))
  				        					{
  				        						System.out.println("바로 여기인가5555");
  				        						fakeData.setWork_str_time(default_str_time);	      	
  												fakeData.setWork_end_time(work_str_time);	
  												addData(fakeData,resultList);
  												addData(originData,resultList);
  				        					}else
  				        					{
  				        						if("WAITING".equals(gb))
  				        						{
  				        							if(!dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  				        							{
  				        								originData.setWork_end_time(default_end_time);	
  				        							}else
  				        							{
  				        								
  				        							}
  				        						}
  				        						addData(originData,resultList);
  				        					}
  				        				}catch(Exception ex1)
  				        				{
  				        					ex1.getStackTrace();
  				        					if(j == 0)
  				        					{
  					        					 Date strDate = format.parse(param_str_time);
  					        				        Date endDate = format.parse(work_end_time);
  	
  					        				        long cDate = strDate.getTime() - endDate.getTime(); 
  					        				        
  					        				        long diff = cDate / ( 24*60*60*1000); 
  					        				    
  					        				        diff = Math.abs(diff);
  					        				        System.out.println("여기닷  diff: " + diff);
  					        				        System.out.println("여기닷  : " + param_str_time);
  					        				        System.out.println("여기닷  : " + work_end_time);
  					        				        for(int k = 0; k < diff; k++)
  					        				        {
  					        				        	Calendar cal = Calendar.getInstance();
  						  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  						  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  						  						        Date date = null;
  						  						        try {
  						  						            date = df.parse(param_str_time);
  						  						        } catch (Exception e) {
  						  						            e.printStackTrace();
  						  						        }
  						  						        
  						  						        cal.setTime(date);
  							  						    cal.add(Calendar.DATE, k);
  				
  							  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  							  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  								  					
  							  						  SYProductOperStatusVO fakeData2 = new SYProductOperStatusVO();
  							  						
  							  						fakeData2.setGb("WAITING");
  							  						fakeData2.setProduct_po(originData.getProduct_po());
  							  						fakeData2.setItem_code(originData.getItem_code());
  							  						fakeData2.setItem_nm(originData.getItem_nm());
  							  						fakeData2.setMachine_code(originData.getMachine_code());
  														fakeData2.setRouting_nm(originData.getRouting_nm());
  														fakeData2.setProd_menge("0");
  														fakeData2.setProd_fail_menge("0");
  													
  														fakeData2.setWork_str_time(first_str_time);
  														fakeData2.setWork_end_time(first_end_time);
  							  						    addData(fakeData2,resultList);
  					        				        }
  					        						System.out.println("바로 여기인가 7777");
  					        				        fakeData.setWork_str_time(default_str_time);	      	
  													fakeData.setWork_end_time(work_str_time);	
  													addData(fakeData,resultList);
  					        				}
  				        					addData(originData,resultList);
  				        				}

  			        				}else
  			        				{
  			        					
  			        		
  			        					System.out.println("바로 여기인가 10101010");
  		        						if("WAITING".equals(gb))
  		        						{
  		        							try{
  			        							if(!dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  			        							{
  			        								originData.setWork_end_time(default_end_time);	
  			        							}else{
  			        								System.out.println("바로 여기인가 10101010 : " + dataList.get(j-1).getWork_str_time());
  			        								System.out.println("바로 여기인가 10101010 : " + dataList.get(j-1).getWork_end_time());
  			        								System.out.println("바로 여기인가 10101010 : " + work_str_time.substring(0,10));
  				        				
  			        							}
  		        							}catch(Exception e)
  		        							{
  		        								e.getStackTrace();
  		        							}
  		        						}
  		        						if("PROCESS".equals(gb))
  		        						{
  		        							
  		        							try{
  			        							if(!dataList.get(j-1).getWork_str_time().substring(0,10).equals(work_str_time.substring(0,10)))
  			        							{
  			        								if(!dateChageFlag){
  			        								fakeData.setWork_str_time(default_str_time);	      	
  													fakeData.setWork_end_time(work_str_time);	
  													addData(fakeData,resultList);
  			        								}
  			        							}else{
  			        								
  				        				
  			        							}
  		        							}catch(Exception e)
  		        							{
  		        								e.getStackTrace();
  		        							}
  			        				
  		        						}
  		        						dateChageFlag = false;
  			        					addData(originData,resultList);
  			        				}
  									
  			        			}
  								
  								
  			        		}else if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") < 0 
  			        				&& getTimeMiliSec(work_end_time.substring(11,19), "17:30:00") > 0)
  			        		{
  			        			if(j > 0 && j < dataList.size()){
  			        		
  			        				 
  			        				try{
  				        				if(dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  				        				{
  				        					/*if(!"WAITING".equals(gb)){
  					        					fakeData.setWork_str_time(default_str_time);	      	
  					        				  	fakeData.setWork_end_time(work_str_time);	
  												addData(fakeData,resultList);
  				        					}*/
  				        					addData(originData,resultList);
  				        				}else{
  				        					originData.setWork_end_time(default_end_time);
  				        					System.out.println("바로 여기인가 88888");
  				        					System.out.println("work_str_time : " + work_str_time);
  				        					System.out.println("work_end_time : " + work_end_time);
  				        				  /*	fakeData.setWork_str_time(default_str_time);	      	
  				        				  	fakeData.setWork_end_time(work_end_time);	
  											addData(fakeData,resultList);*/
  											addData(originData,resultList);
  				        				}
  			        				}catch(Exception e1)
  			        				{
  			        					 originData.setWork_end_time(default_end_time);
  			        					 addData(originData,resultList);
  			        				}
  			        				 
  			        			}else
  			        			{
  			        				 originData.setWork_end_time(default_end_time);
  			        				 addData(originData,resultList);
  			        				 
  			        				
  			        				 
  			        				 
  			        				 
  			        				 
  			        			}
  			        			
  			        
  			        		}
  			        		else if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") > 0 
  			        				&& getTimeMiliSec(work_end_time.substring(11,19), "17:30:00") > 0)
  			        		{
  			        				
  			        			if( j == dataList.size()-1 && "WAITING".equals(gb))
  			        			{
  			        			
  			        			}else
  			        			{
  			        		
  			        				
  			        				try{
  				        				if(dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  				        				{
  				        					addData(originData,resultList);
  				        				}else{
  				        					//originData.setWork_end_time(work_str_time);
  				        					/*System.out.println("바로 여기인가 99999");
  				        				    fakeData.setWork_str_time(default_str_time);	      	
  											fakeData.setWork_end_time(work_end_time);	
  											
  											addData(fakeData,resultList);
  											*/
  											addData(originData,resultList);
  				        				}
  			        				}catch(Exception e1)
  			        				{
  			        					
  			        					addData(originData,resultList);
  			        					
  			        				}
  			        				 
  			        			}
  			        		}
  			        		
    	
  			        }
  					
  				}
  			}
  			
  			String listDataJsonString = ResponseUtils.getJsonResponse(response,settingFinal(resultList));
  			 
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
   
 
   @SuppressWarnings("unchecked")
 	@ResponseBody
 	@RequestMapping(value="/machine/selectProductOperStatus_real", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
 	public String selectProductOperStatus_V2(@ModelAttribute SYProductOperStatusVO vo, HttpServletRequest request, HttpServletResponse response) {
 		logger.debug("FrontendController.selectProductOperStatus_real() is called.");
 		
 		JSONObject resultData = new JSONObject();
 		JSONArray listDataJArray = new JSONArray();
 		JSONParser jsonParser = new JSONParser();
 		 try {
 			 
 			List<SYProductOperStatusVO> dataList = sYProductService.selectProductOperStatus_real(vo);
 			
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
   
   //설비목표를 불러오기위한 변수
   public String param_machine_class_code = "";
   public String param_machine_code="";
   public String param_year="";
   
   String str_date = "";
   String end_date = "";
   String start_month = "";
   @SuppressWarnings("unchecked")
  	@ResponseBody
  	@RequestMapping(value="/kpi/selectOperation_real", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
  	public String selectOperation_real(@ModelAttribute SYProductOperStatusVO vo, HttpServletRequest request, HttpServletResponse response) {
  		logger.debug("FrontendController.selectOperation_real() is called.");
  		start_month = "";
  		JSONObject resultData = new JSONObject();
  		JSONArray listDataJArray = new JSONArray();
  		JSONParser jsonParser = new JSONParser();
  		try {

  		
  			param_machine_class_code = vo.getMachine_class_code();
  			param_machine_code = vo.getMachine_code();
  			param_year= vo.getYear();
  			System.out.println("###### param_machine_class_code : " + param_machine_class_code); 
  		    System.out.println("###### param_machine_code : " + param_machine_code); 
  		  
  		  
  			origin_gb = vo.getGb();
  			origin_item_code = vo.getItem_code();
  			origin_item_nm = vo.getItem_nm();
  		
  			param_str_time = vo.getYear()+"-01-01";
  			param_end_time = vo.getYear()+"-12-31";
  			vo.setGb("");
  			vo.setItem_code("");
  			vo.setItem_nm("");
  			
  			boolean dateChageFlag = false;
  		
  			List<SYProductOperStatusVO> dataList = sYKPIService.selectOperation_real(vo);
  			for(int i = 0 ; i< dataList.size(); i++)
  			   {				
  				   try{
  					   
  					
  					   SYProductOperStatusVO currentVo = dataList.get(i);
  					   if(i == 0){
  						   start_month = currentVo.getWork_end_time().substring(5,7);
  					   }
  					   if("HOLD".equals(currentVo.getGb()))
  				       {  		   
  							continue;
  				       }
  					   
  					   SYProductOperStatusVO prevVo = dataList.get(i-1);
  					   
  					   if(prevVo.getWork_end_time().equals(currentVo.getWork_end_time()))
  					   {
  						   System.out.println("최초다 getWork_str_time " + currentVo.getWork_str_time());
  							System.out.println("최초다 getWork_end_time" + currentVo.getWork_end_time());
  						   dataList.remove(i);
  						   
  					   }
  					   
  				   }catch(Exception e)
  				   {
  					   e.getStackTrace();
  				   }
  				   
  			}
  			
  			for(int i = 0 ; i< dataList.size(); i++)
  			   {
  				
  				   try{
  					   SYProductOperStatusVO currentVo = dataList.get(i);
  					   
  					   if("HOLD".equals(currentVo.getGb()))
  				       {  	
  				        	continue;
  				       }
  					   
  					   System.out.println("최초 getWork_str_time" + currentVo.getWork_str_time());
  					   System.out.println("최초 getWork_end_time" + currentVo.getWork_end_time());
  					   SYProductOperStatusVO nextVo = dataList.get(i+1);
  			
  					    if(!currentVo.getMachine_code().equals(nextVo.getMachine_code()))
  					    {
  					    	continue;
  					    }
  					   if(!currentVo.getWork_end_time().substring(0,10).equals(currentVo.getWork_str_time().substring(0,10)))
  					   {
  						   if(!currentVo.getWork_end_time().equals(nextVo.getWork_str_time()))
  						   {				
  							   	currentVo.setWork_end_time(nextVo.getWork_str_time());
  							    System.out.println("1차 변경 getWork_str_time" + currentVo.getWork_str_time());
  								System.out.println("1차 변경 getWork_end_time" + currentVo.getWork_end_time());
  							   	currentVo.setWork_time_sec(getTimeSec(currentVo.getWork_end_time(),currentVo.getWork_str_time())+"");		
  							   
  								float work_time_hour_l = (float) (Long.parseLong(currentVo.getWork_time_sec())/3600f);
  								String work_time_hour = String.format("%.2f", work_time_hour_l) + "시간";
  			
  							    currentVo.setWork_time(work_time_hour);
  							    dataList.set(i,currentVo);
  						   }
  					   }
  					   
  					  
  					   
  				   }catch(Exception e)
  				   {
  					   e.getStackTrace();
  				   }
  				   
  			}
  			
  			
  			List<SYProductOperStatusVO> resultList = new ArrayList<SYProductOperStatusVO>();
  			System.out.println("--------------------------------------------------------");
  			int minusCount = 0;
  			if(dataList.size() > 0){
  				
  				for(int j = 0; j< dataList.size(); j++){
  					SYProductOperStatusVO originData = dataList.get(j);
  				
  					System.out.println("2차 getWork_str_time" + originData.getWork_str_time());
  					System.out.println("2차 getWork_end_time" + originData.getWork_end_time());
    				 	String date1 = originData.getWork_str_time().substring(0,10);
    				    String date2 = originData.getWork_end_time().substring(0,10);

  			        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

  			        Date FirstDate = format.parse(date1);
  			        Date SecondDate = format.parse(date2);

  			        long calDate = FirstDate.getTime() - SecondDate.getTime(); 
  			        
  			        long calDateDays = calDate / ( 24*60*60*1000); 
  			    
  			        calDateDays = Math.abs(calDateDays);
  			        
  			        String work_str_time = originData.getWork_str_time();
  			        String work_end_time = originData.getWork_end_time();
  			        String gb = originData.getGb();
  			        
  			        String default_str_time = work_end_time.replace(work_end_time.substring(11,19), "08:30:00");
  			        String default_end_time = work_str_time.replace(work_str_time.substring(11,19), "17:30:00");
  			    
  			        
  			        System.out.println("calDateDays : " + calDateDays);
  			        
  			        if("HOLD".equals(originData.getGb()))
  			        {
  			        	
  			        	addData(originData, resultList);
  			        	continue;
  			        }
  			        if(calDateDays != 0 ){
  			        				        	
  			        		if( j == 0)
  			        		{
  			        			if(dataList.size() == 1 )
  			        			{
  			        				if("WAITING".equals(originData.getGb()))
  			        				{
  			        					
  			        				}else
  			        				{
  			        					
  			       
  		        					  
  		        				        Date strDate = format.parse(param_str_time);
  		        				        Date endDate = format.parse(work_end_time);

  		        				        long cDate = strDate.getTime() - endDate.getTime(); 
  		        				        
  		        				        long diff = cDate / ( 24*60*60*1000); 
  		        				    
  		        				        diff = Math.abs(diff);
  		        				        
  		        				        if(diff == 0)
  		        				        {  
  		        				        	
  		        				        	originData.setWork_str_time(default_str_time);
  		        						    addData(originData,resultList);
  		        				        }else{
  			        				        
  		        				        for(int k = 0; k < diff; k++)
  		        				        {
  		        				        	Calendar cal = Calendar.getInstance();
  			  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  			  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  			  						        Date date = null;
  			  						        try {
  			  						            date = df.parse(param_str_time);
  			  						        } catch (Exception e) {
  			  						            e.printStackTrace();
  			  						        }
  			  						        
  			  						        cal.setTime(date);
  				  						    cal.add(Calendar.DATE, k);
  				  				
  				  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  				  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  					  					
  				  						    
  				  							SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  				        					fakeData.setGb(gb);
  											fakeData.setProduct_po(originData.getProduct_po());
  											fakeData.setItem_code(originData.getItem_code());
  											fakeData.setItem_nm(originData.getItem_nm());
  											fakeData.setMachine_code(originData.getMachine_code());
  											fakeData.setRouting_nm(originData.getRouting_nm());
  											
  											fakeData.setProd_menge("0");
  											fakeData.setProd_fail_menge("0");
  											fakeData.setWork_str_time(first_str_time);
  											fakeData.setWork_end_time(first_end_time);
  				  						    addData(fakeData,resultList);
  		        				        }
  		        				        }
  			        				
  			        					
  			        				}	
  			        				
  			        			}else{
  				        			if(getTimeMiliSec(work_end_time.substring(11,19), "08:30:00") < 0)
  					        		{
  				        				originData.setWork_str_time(work_end_time);
  				        				originData.setWork_end_time(work_end_time);
  				        		
  					        		}else
  					        		{
  					        			/*if(!"PROCESS".equals(originData.getGb()))
  					        			{
  					        				originData.setGb("WAITING");
  					        			}*/
  					        			originData.setWork_str_time(default_str_time);
  				        				originData.setWork_end_time(work_end_time);
  				        				
  				        				 Date strDate = format.parse(param_str_time);
  			        				        Date endDate = format.parse(work_end_time);

  			        				        long cDate = strDate.getTime() - endDate.getTime(); 
  			        				        
  			        				        long diff = cDate / ( 24*60*60*1000); 
  			        				    
  			        				        diff = Math.abs(diff);
  			        		
  			        				        for(int k = 0; k < diff; k++)
  			        				        {
  			        				        	Calendar cal = Calendar.getInstance();
  				  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  				  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  				  						        Date date = null;
  				  						        try {
  				  						            date = df.parse(param_str_time);
  				  						        } catch (Exception e) {
  				  						            e.printStackTrace();
  				  						        }
  				  						        
  				  						        cal.setTime(date);
  					  						    cal.add(Calendar.DATE, k);
  					  			
  					  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  					  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  						  					
  					  						    
  					  							SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  					        					fakeData.setGb(gb);
  												fakeData.setProduct_po(originData.getProduct_po());
  												fakeData.setItem_code(originData.getItem_code());
  												fakeData.setItem_nm(originData.getItem_nm());
  												fakeData.setMachine_code(originData.getMachine_code());
  												fakeData.setRouting_nm(originData.getRouting_nm());
  												
  												fakeData.setProd_menge("0");
  												fakeData.setProd_fail_menge("0");
  												fakeData.setWork_str_time(first_str_time);
  												fakeData.setWork_end_time(first_end_time);
  					  						    addData(fakeData,resultList);
  			        				        }
  					        			
  					        		}
  				        			
  				        			addData(originData,resultList);
  			        			}
  			        			
  			  
  			        			
  			        		}else if(j == dataList.size()-1)
  			        		{
  			        			if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") > 0)
  				        		{
  			        						
  			        				String prod_menge = originData.getProd_menge();
  			        				String prod_fail_menge = originData.getProd_fail_menge();
  			        				
  			        				originData.setProd_menge("0");
  			        				originData.setProd_fail_menge("0");
  			        				originData.setWork_str_time(work_str_time);
  			        				originData.setWork_end_time(work_str_time);
  			        				addData(originData,resultList);
  			        				
  			        				SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  		        					fakeData.setGb(gb);
  									fakeData.setProduct_po(originData.getProduct_po());
  									fakeData.setItem_code(originData.getItem_code());
  									fakeData.setItem_nm(originData.getItem_nm());
  									fakeData.setMachine_code(originData.getMachine_code());
  									fakeData.setRouting_nm(originData.getRouting_nm());
  			        				fakeData.setProd_menge(prod_menge);
  									fakeData.setProd_fail_menge(prod_fail_menge);
  									
  									fakeData.setWork_str_time(default_str_time);
  									fakeData.setWork_end_time(work_end_time);
  									addData(fakeData,resultList);
  				        		}else
  				        		{
  				        			originData.setWork_str_time(work_str_time);
  			        				originData.setWork_end_time(default_end_time);
  			        				originData.setProd_menge("0");
  			        				originData.setProd_fail_menge("0");
  			        				addData(originData,resultList);
  			        	
  			        				 Date strDate = format.parse(work_str_time);
  		        				        Date endDate = format.parse(work_end_time);

  		        				        long cDate = strDate.getTime() - endDate.getTime(); 
  		        				        
  		        				        long diff = cDate / ( 24*60*60*1000); 
  		        				    
  		        				        diff = Math.abs(diff);
  			        				        
  		        				        for(int k = 0; k < diff; k++)
  		        				        {
  		        				        	Calendar cal = Calendar.getInstance();
  			  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  			  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  			  						        Date date = null;
  			  						        try {
  			  						            date = df.parse(work_str_time);
  			  						        } catch (Exception e) {
  			  						            e.printStackTrace();
  			  						        }
  			  						        
  			  						        cal.setTime(date);
  				  						    cal.add(Calendar.DATE, k+1);
  				  				
  				  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  				  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  					  					
  				  						    
  				  							SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  				        					fakeData.setGb(gb);
  											fakeData.setProduct_po(originData.getProduct_po());
  											fakeData.setItem_code(originData.getItem_code());
  											fakeData.setItem_nm(originData.getItem_nm());
  											fakeData.setMachine_code(originData.getMachine_code());
  											fakeData.setRouting_nm(originData.getRouting_nm());
  											
  											fakeData.setProd_menge("0");
  											fakeData.setProd_fail_menge("0");
  											fakeData.setWork_str_time(first_str_time);
  											fakeData.setWork_end_time(first_end_time);
  											
  											if(k == diff-1)
  											{
  												fakeData.setWork_end_time(work_end_time);
  											}
  				  						    addData(fakeData,resultList);
  		        				        }
  			        				
  			        	
  				        		}
  			        			
  						
  			        		}else
  			        		{
  			        			if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") > 0)
  				        		{
  			        				
  			        				 /*if("WAITING".equals(gb)){
  			        					 
  			        					
  						          
  			        					 originData.setWork_str_time(default_str_time);
  				        				 originData.setWork_end_time(work_end_time);
  				        					 
  				        				 addData(originData,resultList);
  			        				 }else*/
  			        				 {
  			        					String origin_str_time =originData.getWork_str_time();
  		        				     	String prod_menge = originData.getProd_menge();
  					                 	String prod_fail_menge = originData.getProd_fail_menge();
  					        			originData.setProd_menge("0");
  					        			originData.setProd_fail_menge("0");
  			        					 originData.setWork_str_time(work_str_time);
  			        					 originData.setWork_end_time(work_str_time);
  			        					 
  			        					 addData(originData,resultList);
  			        					 
  			        					// if(!"WAITING".equals(gb))
  					        				{

  					        				    dateChageFlag = true;
  					        				    
  					        				    long size = calDateDays;
  					        					/*System.out.println("CCC work_str_time : " + work_str_time);
  					        					System.out.println("CCC param_str_time: " + param_str_time);
  					        					if(getTimeSec( param_str_time + " 00:00:00", work_str_time) > 0)
  					        					{       						
  					        						
  					        						size = getDateDiff(param_str_time, work_end_time) + 1;
  					        						System.out.println("CCC size: " + size);
  					        					}*/
  					        					
  					        				    for(int k = 0; k<size; k++)
  					        				    {
  					        				    	
  					        				    	SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  						        					fakeData.setGb(gb);
  													fakeData.setProduct_po(originData.getProduct_po());
  													fakeData.setItem_code(originData.getItem_code());
  													fakeData.setItem_nm(originData.getItem_nm());
  													fakeData.setMachine_code(originData.getMachine_code());
  													fakeData.setRouting_nm(originData.getRouting_nm());
  													
  													
  													fakeData.setProd_menge(prod_menge);
  													fakeData.setProd_fail_menge(prod_fail_menge);
  													System.out.println("바로 여기인가 44444");
  													fakeData.setWork_str_time(default_str_time);	      	
  													fakeData.setWork_end_time(work_end_time);
  													Calendar cal = Calendar.getInstance();
  					  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  					  						        Date date = null;
  					  						        try {
  					  						            date = df.parse(origin_str_time);
  					  						        } catch (Exception e) {
  					  						            e.printStackTrace();
  					  						        }
  					  						        
  					  						        cal.setTime(date);
  						  						    cal.add(Calendar.DATE, k+1);
  						  						    String first_str_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "08:30:00");
  						  						    String first_end_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "17:30:00");
  							  						
  						  						  
  													if(k == size -1){
  														fakeData.setProd_menge(prod_menge);
  														fakeData.setProd_fail_menge(prod_fail_menge);
  														System.out.println("바로 여기인가 33333");
  														fakeData.setWork_str_time(default_str_time);	      	
  														fakeData.setWork_end_time(work_end_time);
  													}else
  													{
  														fakeData.setProd_menge("0");
  														fakeData.setProd_fail_menge("0");
  														
  														fakeData.setWork_str_time(first_str_time);	      	
  														fakeData.setWork_end_time(first_end_time);
  													}
  													
  													addData(fakeData,resultList);
  					        				    }
  					        					
  					        				}
  			        				 }
  					        		
  				        		}else
  				        		{
  				        		
  				        			String origin_str_time =originData.getWork_str_time();
  				                 	String prod_menge = originData.getProd_menge();
  				                 	String prod_fail_menge = originData.getProd_fail_menge();
  				        			originData.setProd_menge("0");
  				        			originData.setProd_fail_menge("0");
  				        			originData.setWork_str_time(work_str_time);
  			        				originData.setWork_end_time(default_end_time);
  			        				System.out.println("날짜가 다른거 체크 gb : " + gb);
  			        				System.out.println("날짜가 다른거 체크 STR: " + work_str_time);
  			        				
  			        				
  			        	
  			        				if(getValidDate(param_str_time, param_end_time, originData.getWork_end_time())){
  			        					addData(originData,resultList);
  			        				}
  			        				//if(!"WAITING".equals(gb))
  			        				{
  			        			
  			        					
  			        				    dateChageFlag = true;
  			        				    long size = calDateDays;
  			        				/*	System.out.println("CCC work_str_time : " + work_str_time);
  			        					System.out.println("CCC param_str_time: " + param_str_time);
  			        					if(getTimeSec( param_str_time + " 00:00:00", work_str_time) > 0)
  			        					{       						
  			        						
  			        						size = getDateDiff(param_str_time, work_end_time) + 1;
  			        						System.out.println("CCC size: " + size);
  			        					}*/
  			        					
  			        				    for(int k = 0; k<size; k++)
  			        				    {
  			        				    	
  				        					SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  				        					fakeData.setGb(gb);
  											fakeData.setProduct_po(originData.getProduct_po());
  											fakeData.setItem_code(originData.getItem_code());
  											fakeData.setItem_nm(originData.getItem_nm());
  											fakeData.setMachine_code(originData.getMachine_code());
  											fakeData.setRouting_nm(originData.getRouting_nm());
  											fakeData.setProd_menge(prod_menge);
  											fakeData.setProd_fail_menge(prod_fail_menge);
  											System.out.println("바로 여기인가 ");
  											fakeData.setWork_str_time(default_str_time);	      	
  											fakeData.setWork_end_time(work_end_time);
  											
  											Calendar cal = Calendar.getInstance();
  			  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  			  						        Date date = null;
  			  						        try {
  			  						            date = df.parse(origin_str_time);
  			  						        } catch (Exception e) {
  			  						            e.printStackTrace();
  			  						        }
  			  						        
  			  						        cal.setTime(date);
  				  						    cal.add(Calendar.DATE, k+1);
  				  						    String first_str_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "08:30:00");
  				  						    String first_end_time =  df.format(cal.getTime()).replace(df.format(cal.getTime()).substring(11,19), "17:30:00");
  				  						
  				  						  
  											if(k == size -1){
  												fakeData.setProd_menge(prod_menge);
  												fakeData.setProd_fail_menge(prod_fail_menge);
  												System.out.println("바로 여기인가 2222");
  												fakeData.setWork_str_time(default_str_time);	      	
  												fakeData.setWork_end_time(work_end_time);
  											}else
  											{
  												fakeData.setProd_menge("0");
  												fakeData.setProd_fail_menge("0");
  												
  												fakeData.setWork_str_time(first_str_time);	      	
  												fakeData.setWork_end_time(first_end_time);
  											}
  											addData(fakeData,resultList);
  			        				    }
  			        				}
  			        		
  			        				
  				        		}
  			        		}
  				        
  	
  			        	
  			        }else
  			        {
  			        	
  				        	SYProductOperStatusVO fakeData = new SYProductOperStatusVO();
  	
  							fakeData.setGb("WAITING");
  							fakeData.setProduct_po(originData.getProduct_po());
  							fakeData.setItem_code(originData.getItem_code());
  							fakeData.setItem_nm(originData.getItem_nm());
  							fakeData.setMachine_code(originData.getMachine_code());
  							fakeData.setRouting_nm(originData.getRouting_nm());
  							fakeData.setProd_menge("0");
  							fakeData.setProd_fail_menge("0");
  							
  			        		if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") < 0 
  			        				&& getTimeMiliSec(work_end_time.substring(11,19), "17:30:00") < 0)
  			        		{
  			        		
  			        			if(getTimeMiliSec(work_str_time.substring(11,19), "08:30:00") <= 0 )
  			        			{
  			        				addData(originData,resultList);
  			        			}else{
  			        				System.out.println("CCC dateChageFlag: " + dateChageFlag);
  			        				if(!dateChageFlag){
  			        		
  				        				try{
  				        					if(!dataList.get(j-1).getWork_str_time().substring(0,10).equals(work_str_time.substring(0,10)))
  				        					{
  				        						System.out.println("바로 여기인가5555");
  				        						fakeData.setWork_str_time(default_str_time);	      	
  												fakeData.setWork_end_time(work_str_time);	
  												addData(fakeData,resultList);
  												addData(originData,resultList);
  				        					}else
  				        					{
  				        						if("WAITING".equals(gb))
  				        						{
  				        							if(!dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  				        							{
  				        								originData.setWork_end_time(default_end_time);	
  				        							}else
  				        							{
  				        								
  				        							}
  				        						}
  				        						addData(originData,resultList);
  				        					}
  				        				}catch(Exception ex1)
  				        				{
  				        					ex1.getStackTrace();
  				        					if(j == 0)
  				        					{
  					        					 Date strDate = format.parse(param_str_time);
  					        				        Date endDate = format.parse(work_end_time);
  	
  					        				        long cDate = strDate.getTime() - endDate.getTime(); 
  					        				        
  					        				        long diff = cDate / ( 24*60*60*1000); 
  					        				    
  					        				        diff = Math.abs(diff);
  					        				        System.out.println("여기닷  diff: " + diff);
  					        				        System.out.println("여기닷  : " + param_str_time);
  					        				        System.out.println("여기닷  : " + work_end_time);
  					        				        for(int k = 0; k < diff; k++)
  					        				        {
  					        				        	Calendar cal = Calendar.getInstance();
  						  						        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  						  						        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
  						  						        Date date = null;
  						  						        try {
  						  						            date = df.parse(param_str_time);
  						  						        } catch (Exception e) {
  						  						            e.printStackTrace();
  						  						        }
  						  						        
  						  						        cal.setTime(date);
  							  						    cal.add(Calendar.DATE, k);
  				
  							  						    String first_str_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "08:30:00");
  							  						    String first_end_time =  df2.format(cal.getTime()).replace(df2.format(cal.getTime()).substring(11,19), "17:30:00");
  								  					
  							  						  SYProductOperStatusVO fakeData2 = new SYProductOperStatusVO();
  							  						
  							  						fakeData2.setGb("WAITING");
  							  						fakeData2.setProduct_po(originData.getProduct_po());
  							  						fakeData2.setItem_code(originData.getItem_code());
  							  						fakeData2.setItem_nm(originData.getItem_nm());
  							  						fakeData2.setMachine_code(originData.getMachine_code());
  														fakeData2.setRouting_nm(originData.getRouting_nm());
  														fakeData2.setProd_menge("0");
  														fakeData2.setProd_fail_menge("0");
  													
  														fakeData2.setWork_str_time(first_str_time);
  														fakeData2.setWork_end_time(first_end_time);
  							  						    addData(fakeData2,resultList);
  					        				        }
  					        						System.out.println("바로 여기인가 7777");
  					        				        fakeData.setWork_str_time(default_str_time);	      	
  													fakeData.setWork_end_time(work_str_time);	
  													addData(fakeData,resultList);
  					        				}
  				        					addData(originData,resultList);
  				        				}

  			        				}else
  			        				{
  			        					
  			        		
  			        					System.out.println("바로 여기인가 10101010");
  		        						if("WAITING".equals(gb))
  		        						{
  		        							try{
  			        							if(!dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  			        							{
  			        								originData.setWork_end_time(default_end_time);	
  			        							}else{
  			        								System.out.println("바로 여기인가 10101010 : " + dataList.get(j-1).getWork_str_time());
  			        								System.out.println("바로 여기인가 10101010 : " + dataList.get(j-1).getWork_end_time());
  			        								System.out.println("바로 여기인가 10101010 : " + work_str_time.substring(0,10));
  				        				
  			        							}
  		        							}catch(Exception e)
  		        							{
  		        								e.getStackTrace();
  		        							}
  		        						}
  		        						if("PROCESS".equals(gb))
  		        						{
  		        							
  		        							try{
  			        							if(!dataList.get(j-1).getWork_str_time().substring(0,10).equals(work_str_time.substring(0,10)))
  			        							{
  			        								if(!dateChageFlag){
  			        								fakeData.setWork_str_time(default_str_time);	      	
  													fakeData.setWork_end_time(work_str_time);	
  													addData(fakeData,resultList);
  			        								}
  			        							}else{
  			        								
  				        				
  			        							}
  		        							}catch(Exception e)
  		        							{
  		        								e.getStackTrace();
  		        							}
  			        				
  		        						}
  		        						dateChageFlag = false;
  			        					addData(originData,resultList);
  			        				}
  									
  			        			}
  								
  								
  			        		}else if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") < 0 
  			        				&& getTimeMiliSec(work_end_time.substring(11,19), "17:30:00") > 0)
  			        		{
  			        			if(j > 0 && j < dataList.size()){
  			        		
  			        				 
  			        				try{
  				        				if(dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  				        				{
  				        					/*if(!"WAITING".equals(gb)){
  					        					fakeData.setWork_str_time(default_str_time);	      	
  					        				  	fakeData.setWork_end_time(work_str_time);	
  												addData(fakeData,resultList);
  				        					}*/
  				        					addData(originData,resultList);
  				        				}else{
  				        					originData.setWork_end_time(default_end_time);
  				        					System.out.println("바로 여기인가 88888");
  				        					System.out.println("work_str_time : " + work_str_time);
  				        					System.out.println("work_end_time : " + work_end_time);
  				        				  /*	fakeData.setWork_str_time(default_str_time);	      	
  				        				  	fakeData.setWork_end_time(work_end_time);	
  											addData(fakeData,resultList);*/
  											addData(originData,resultList);
  				        				}
  			        				}catch(Exception e1)
  			        				{
  			        					 originData.setWork_end_time(default_end_time);
  			        					 addData(originData,resultList);
  			        				}
  			        				 
  			        			}else
  			        			{
  			        				 originData.setWork_end_time(default_end_time);
  			        				 addData(originData,resultList);
  			        				 
  			        				
  			        				 
  			        				 
  			        				 
  			        				 
  			        			}
  			        			
  			        
  			        		}
  			        		else if(getTimeMiliSec(work_str_time.substring(11,19), "17:30:00") > 0 
  			        				&& getTimeMiliSec(work_end_time.substring(11,19), "17:30:00") > 0)
  			        		{
  			        				
  			        			if( j == dataList.size()-1 && "WAITING".equals(gb))
  			        			{
  			        			
  			        			}else
  			        			{
  			        		
  			        				
  			        				try{
  				        				if(dataList.get(j+1).getWork_str_time().substring(0,10).equals(work_end_time.substring(0,10)))
  				        				{
  				        					addData(originData,resultList);
  				        				}else{
  				        					//originData.setWork_end_time(work_str_time);
  				        					/*System.out.println("바로 여기인가 99999");
  				        				    fakeData.setWork_str_time(default_str_time);	      	
  											fakeData.setWork_end_time(work_end_time);	
  											
  											addData(fakeData,resultList);
  											*/
  											addData(originData,resultList);
  				        				}
  			        				}catch(Exception e1)
  			        				{
  			        					
  			        					addData(originData,resultList);
  			        					
  			        				}
  			        				 
  			        			}
  			        		}
  			        		
    	
  			        }
  					
  				}
  			}
  			List<SYProductOperStatusVO> real_result = settingFinal(resultList);
  			
  	
  			if("ONE".equals(vo.getGrapType())){
  				String listDataJsonString = ResponseUtils.getJsonResponse(response,settingKPIOperData(real_result));
  				listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
  			}else if("TWO".equals(vo.getGrapType())){
  				String listDataJsonString = ResponseUtils.getJsonResponse(response,settingKPIOperDataMachine(real_result));
  	  			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
  			}
  			 
  			
  			resultData.put("status", HttpStatus.OK.value());
  			resultData.put("rows", listDataJArray);
  		} catch (Exception e) {
  			e.printStackTrace();
  			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
  			resultData.put("rows", null);
  		}
  		return resultData.toJSONString();
  	}
     
   



//성민
   public List<SYKPI_OperationVo> settingKPIOperData(List<SYProductOperStatusVO> real_result ){
	   
	   List<SYKPI_OperationVo> result = new ArrayList<SYKPI_OperationVo>();			
	   
	   List<SYGoalVo> goal_list = new ArrayList<SYGoalVo>();
			   
	   SYProductOperStatusVO vo = new SYProductOperStatusVO();
	   
	  
	   vo.setMachine_class_code(param_machine_class_code);
	   vo.setMachine_code(param_machine_code);
	   vo.setYear(param_year);
	   goal_list = sYKPIService.selectOperation_second(vo);

	   System.out.println("param_machine_code : " + param_machine_code); 
	  
	   System.out.println("param_machine_class_code : " + param_machine_class_code); 
	   
	   System.out.println("param_year : " + param_year); 
	   
	   for(int i =0; i < monthProcessPerList.size(); i++)
	   {

		   System.out.println("########## ["+i+"] getPer : " + monthProcessPerList.get(i).getPer());
		   System.out.println("########## ["+i+"] getCnt : " + monthProcessPerList.get(i).getCnt());
		   String current_month = (i+1)+"";
		   String per = String.format("%.1f", monthProcessPerList.get(i).getPer()/monthProcessPerList.get(i).getCnt());
		   		 		  
		   SYKPI_OperationVo opVo = new SYKPI_OperationVo();
		   
		   opVo.setMonth(current_month);
		   System.out.println("current_month:::::"+current_month);
		   
		   opVo.setPer(per);
		   System.out.println("per:::::"+per);
		   
		   opVo.setGoal(goal_list.get(i).getGoal());
		   System.out.println("goalyear:::::"+goal_list.get(i).getYear());
		   System.out.println("goalmonth:::::"+goal_list.get(i).getMonth());
		   System.out.println("goal:::::"+goal_list.get(i).getGoal());
//		   if(goal_list.get(i).getMonth()==current_month){
//			
//			   opVo.setGoal(goal_list.get(i).getGoal());
//			   System.out.println("Goal:::::");
//		   }
		   
		   result.add(opVo);
	   }
	   
	
	   
	   return result;
   }
   
public List<SYKPI_OperationVo> settingKPIOperDataMachine(List<SYProductOperStatusVO> real_result){
	   
	   List<SYKPI_OperationVo> result = machineProcessPerList;
	
	   return result;
   }


//selectPurchaseSearch
@ResponseBody
@RequestMapping(value = "/repair/selectPurchaseSearch", method = {
		RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
@SuppressWarnings("unchecked")
public String selectPurchaseSearch(@ModelAttribute SYPurchaseOrderDetailVo vo,
		HttpServletRequest request, HttpServletResponse response,
		HttpSession session) {
	logger.debug("FrontendController.selectPurchaseSearch is called.");

	JSONObject resultData = new JSONObject();
	JSONArray listDataJArray = new JSONArray();
	JSONParser jsonParser = new JSONParser();
	try {

		
		List<SYPurchaseOrderDetailVo> dataList = sYKPIService.selectPurchaseSearch(vo);

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


//1228
//selectMonitoringList
@ResponseBody
@RequestMapping(value = "/consumable/selectMonitoringList", method = {
		RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
@SuppressWarnings("unchecked")
public String selectMonitoringList(@ModelAttribute SYProductMonitoringVO vo,
		HttpServletRequest request, HttpServletResponse response,
		HttpSession session) {
	logger.debug("FrontendController.selectMonitoringList is called.");

	JSONObject resultData = new JSONObject();
	JSONArray listDataJArray = new JSONArray();
	JSONParser jsonParser = new JSONParser();
	try {

		
		List<SYProductMonitoringVO> dataList = sYProductService.selectMonitoringList(vo);

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

//selectMonitoringGraph
@ResponseBody
@RequestMapping(value = "/consumable/selectMonitoringGraph", method = {
		RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
@SuppressWarnings("unchecked")
public String selectMonitoringGraph(@ModelAttribute SYProductMonitoringVO vo,
		HttpServletRequest request, HttpServletResponse response,
		HttpSession session) {
	logger.debug("FrontendController.selectMonitoringList is called.");

	JSONObject resultData = new JSONObject();
	JSONArray listDataJArray = new JSONArray();
	JSONParser jsonParser = new JSONParser();
	try {

		
		List<SYProductMonitoringVO> dataList = sYProductService.selectMonitoringGraph(vo);

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

//selectMonitoringListDown
@ResponseBody
@RequestMapping(value = "/consumable/selectMonitoringListDown", method = {
		RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
@SuppressWarnings("unchecked")
public String selectMonitoringListDown(@ModelAttribute SYProductMonitoringVO vo,
		HttpServletRequest request, HttpServletResponse response,
		HttpSession session) {
	logger.debug("FrontendController.selectMonitoringListDown is called.");

	JSONObject resultData = new JSONObject();
	JSONArray listDataJArray = new JSONArray();
	JSONParser jsonParser = new JSONParser();
	try {

		
		List<SYProductMonitoringVO> dataList = sYProductService.selectMonitoringListDown(vo);

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




//210122
@ResponseBody
@RequestMapping(value = "/consumable/updateOutsourcing", method = { 
		RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
@SuppressWarnings("unchecked")
public String updateOutsourcing(@ModelAttribute SYProductOperationVO vo,
		HttpServletRequest request, HttpServletResponse response,
		HttpSession session) {
	logger.debug("FrontendController.updateOutsourcing() is called.");

	JSONObject resultData = new JSONObject();
	try {

		String outsourcing_gubun = URLDecoder.decode(request.getParameter("outsourcing_gubun"), "UTF-8" );	

		vo.setUpdater(SessionUtil.getMemberId(request));

		vo.setOutsourcing_gubun(outsourcing_gubun);

		int cnt = sYProductService.updateOutsourcing(vo);

		resultData.put("status", HttpStatus.OK.value());
		resultData.put("cnt", cnt);
	} catch (Exception e) {
		e.printStackTrace();
		resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		resultData.put("cnt", null);
	}
	return resultData.toJSONString();
}   


//updateReportDate
@ResponseBody
@RequestMapping(value = "/ovehaul/updateReportDate", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
@SuppressWarnings("unchecked")
public String updateReportDate(@ModelAttribute SYRepairVo vo,
		HttpServletRequest request, HttpServletResponse response,
		HttpSession session) {
	logger.debug("FrontendController.updateReportDate() is called.");
	
	String repair_num = request.getParameter("repair_num");
	String procDate = request.getParameter("procDate");
	String insDate = request.getParameter("insDate");
	
	logger.debug("procDate :::::::: "  + procDate);
	logger.debug("insDate :::::::: "  + insDate);

	JSONObject resultData = new JSONObject();
	try {
		
		vo.setDate_updated(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		vo.setRepair_num(repair_num);
		
		switch (procDate) {
		case "proc1_date":
			vo.setProc1_date(insDate);
			break;
		case "proc2_date":
			vo.setProc2_date(insDate);
			break;
		case "proc3_date":
			vo.setProc3_date(insDate);
			break;
		case "proc4_date":
			vo.setProc4_date(insDate);
			break;
		case "proc5_date":
			vo.setProc5_date(insDate);
			break;
		case "proc6_date":
			vo.setProc6_date(insDate);
			break;
			
		default :
			throw new Exception("no parameter....");
		
		}

		int cnt = sYOverhaulService.updateReportDate(vo);

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