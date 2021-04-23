package kr.co.passcombine.set.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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

import kr.co.passcombine.set.svc.SYDeliveryOrderService;
import kr.co.passcombine.set.svc.SYDeliveryService;
import kr.co.passcombine.set.svc.SYDrwFileService;
import kr.co.passcombine.set.svc.SYInfoService;
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
import kr.co.passcombine.set.vo.SYClaimVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYDeliveryOrderVo;
import kr.co.passcombine.set.vo.SYDeliveryVo;
import kr.co.passcombine.set.vo.SYDrwFileInfoVo;
import kr.co.passcombine.set.vo.SYFileVo;
import kr.co.passcombine.set.vo.SYIncome_resultVo;
import kr.co.passcombine.set.vo.SYInspVO;
import kr.co.passcombine.set.vo.SYInstrumentVo;
import kr.co.passcombine.set.vo.SYKPI_RepairVo;
import kr.co.passcombine.set.vo.SYMachineMonitorInfoVO;
import kr.co.passcombine.set.vo.SYMachineMonitorVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPrintVO;
import kr.co.passcombine.set.vo.SYProductOperationVO;
import kr.co.passcombine.set.vo.SYProductUnOperationVO;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYPurchaseOrderVo;
import kr.co.passcombine.set.vo.SYQualityFileVo;
import kr.co.passcombine.set.vo.SYRepairAnalysisVo;
import kr.co.passcombine.set.vo.SYRepairVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYSelf_InspFailVo;
import kr.co.passcombine.set.vo.SYWareHouseRawVo;
import kr.co.passcombine.set.vo.SYWareHousingVo;
import kr.co.passcombine.set.vo.SYWarehouseOutVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterDVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterHVo;
 

@Controller
@RequestMapping("/insp")
public class InspController {
	private static final Logger logger = LoggerFactory
			.getLogger(InspController.class);

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

	@Resource(name = "setInfoService")
	SYInfoService sYInfoService;

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

   @ResponseBody
   @RequestMapping(value = "/dfctKpiGraph", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String dfctKpiGraph(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.dfctKpiGraph is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      JSONArray listDataJArray_1 = new JSONArray();
      JSONArray listDataJArray_2 = new JSONArray();
      
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.dfctKpiGraph(vo);
         List<SYInspVO> dfctKpiLtGrid = sYInspService.dfctKpiLtGrid(vo);
         List<SYInspVO> dfctKpiRtGrid = sYInspService.dfctKpiRtGrid(vo);
         
         
         String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
         listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
         
         String listDataJsonString_1 = ResponseUtils.getJsonResponse(response, dfctKpiLtGrid);
         listDataJArray_1 = (JSONArray) jsonParser.parse(listDataJsonString_1);
         
         String listDataJsonString_2 = ResponseUtils.getJsonResponse(response, dfctKpiRtGrid);
         listDataJArray_2 = (JSONArray) jsonParser.parse(listDataJsonString_2);
         
         resultData.put("status", HttpStatus.OK.value());
         resultData.put("rows", listDataJArray);
         resultData.put("rows_lt", listDataJArray_1);
         resultData.put("rows_rt", listDataJArray_2);
         
      } catch (Exception e) {
         e.printStackTrace();
         resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
         resultData.put("rows", null);
      }
      return resultData.toJSONString();
   }
   
   @ResponseBody
   @RequestMapping(value = "/rtngInspInfo", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String rtngInspInfo(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.rtngInspInfo is called.");

      JSONObject resultData = new JSONObject();
      JSONArray listDataJArray = new JSONArray();
      
      JSONParser jsonParser = new JSONParser();
      try {

         List<SYInspVO> dataList = sYInspService.rtngInspInfo(vo);
       
         
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
   @RequestMapping(value = "/saveInspValue", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
   @SuppressWarnings("unchecked")
   public String saveInspValue(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.saveInspValue is called.");
      JSONObject resultData = new JSONObject();
      JSONParser parser = new JSONParser();
      
      String gridData = request.getParameter("param");
      String sample_type = request.getParameter("sample_type");
      String insp_case = request.getParameter("insp_case");
      
      
      try {
    	  
    	  int cnt = sYInspService.chkProdStrt(vo);	//cnt가 0이면 시작 된 오더 
    	  
    	  if(cnt == 0) {
    		  JSONArray jsonArray = (JSONArray) parser.parse(gridData);

        	  List<List<SYInspVO>> t_list = new ArrayList<List<SYInspVO>>();

        	  for (int i = 0; i < jsonArray.size(); i++) {
        	  	JSONArray inspKindArray = (JSONArray) parser.parse(jsonArray.get(i).toString());

        	  	List < SYInspVO > list = new ArrayList < SYInspVO > ();

        	  	for (int j = 0; j < inspKindArray.size(); j++) {
        	  		JSONObject jObj = (JSONObject) parser.parse(inspKindArray.get(j).toString());

        	  		Object[] keyArr = jObj.keySet().toArray();

        	  		SYInspVO dVo = new SYInspVO();


        	  		dVo.setCreator(SessionUtil.getMemberId(request));
        	  		dVo.setUpdater(SessionUtil.getMemberId(request));
        	  		dVo.setSample_type(sample_type);
        	  		dVo.setInsp_case(insp_case);
        	  		dVo.setProduct_menge(vo.getProduct_menge());
        	  		
        	  		dVo.setWorker(vo.getWorker());
        	  		dVo.setComment(vo.getComment());

        	  		for (Object key: keyArr) {
        	  			String nKey = key.toString();
        	  			String nValue = "";

        	  			if (jObj.get(nKey) == null)
        	  				continue;
        	  			else
        	  				nValue = jObj.get(nKey).toString();

        	  			if ("product_po".equals(nKey)) dVo.setProduct_po(nValue);
        	  			else if ("item_code".equals(nKey)) dVo.setItem_code(nValue);
        	  			else if ("routing_code".equals(nKey)) dVo.setRouting_code(nValue);
        	  			else if ("inspection_seq".equals(nKey)) dVo.setInspection_seq(nValue);
        	  			else if ("val_seq".equals(nKey)) dVo.setVal_seq(nValue);
        	  			else if ("insp_val".equals(nKey)) dVo.setInsp_val(nValue);
        	  			else if ("min_spec".equals(nKey)) dVo.setMin_spec(nValue);
        	  			else if ("a_insp_ng_cnt".equals(nKey)) dVo.setA_insp_ng_cnt(nValue);
        	  			else if ("b_insp_ng_cnt".equals(nKey)) dVo.setB_insp_ng_cnt(nValue);
        	  			else if ("c_insp_ng_cnt".equals(nKey)) dVo.setC_insp_ng_cnt(nValue);
        	  			else if ("insp_rst".equals(nKey)) dVo.setInsp_rst(nValue);
        	  		}
        	  		list.add(dVo);
        	  	}
        	  	t_list.add(list);
        	  }
        	  
        	  int dCnt = sYInspService.saveTotInspVal(t_list);
    	  }    	  
    	  
    	  resultData.put("cnt", cnt);
    	  resultData.put("status", HttpStatus.OK.value());
    	  
		} catch (ParseException e) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		e.printStackTrace();
	} 
      	return resultData.toJSONString();
	}
   
	@ResponseBody
	@RequestMapping(value = "/selcInspValue", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selcInspValue(@ModelAttribute SYInspVO vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
	    logger.debug("FrontendController.selcInspValue is called.");
	
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYInspVO> dataList = sYInspService.selcInspVal(vo);

			if(dataList.size() == 0)
	        {
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				int rst = sYInspService.saveFirstInspData(vo);
				dataList = sYInspService.selcInspVal(vo);
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
	@RequestMapping(value = "/fnshInspData", method = {
	RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnshChkShtData(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.fnshChkShtData is called.");

      JSONObject resultData = new JSONObject();
  
      try {
   
    	  int strtChk = sYInspService.chkProdStrt(vo);	//cnt가 0이면 시작 된 오더 
    	  int rst = 1;
    	  
    	  if(strtChk == 0) {
    		  String ipt_cnt = request.getParameter("ipt_cnt");	//화면에서 입력된 값의 개수  
        	  int s_ipt_cnt = Integer.parseInt(ipt_cnt);
        	  
        	  int d_int_cnt = sYInspService.chkInspIptCnt(vo);		//DB에 저장된 값의 개수 
        	  
        	  int cnt = sYInspService.chkInspIng(vo);	//cnt가 0이면 insp_rst 컬럼에 빈값이 있음-> 검사종료 전 측정값 저장을 한번도 안함.. 
      
        	  System.out.println("#########################");
        	  System.out.println(cnt);
        	  System.out.println(s_ipt_cnt);
        	  System.out.println(d_int_cnt);
        	  
        	  
        	  if(cnt == 0 && (s_ipt_cnt == d_int_cnt)) {
        		  vo.setCreator(SessionUtil.getMemberId(request));
    			  vo.setUpdater(SessionUtil.getMemberId(request));
    			  vo.setMember_nm(SessionUtil.getMemberNm(request));
    			  int endChk = sYInspService.fnshInspData(vo);
    			  rst = 0;
        	  }
    	  }
	  
    	  resultData.put("strtChk", strtChk);
		  resultData.put("cnt", rst);
		  resultData.put("status", HttpStatus.OK.value());
	} catch (Exception e) {
		e.printStackTrace();
		resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	}
      return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/strtChkShtData", method = {
	RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String strtChkShtData(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.strtChkShtData is called.");

      JSONObject resultData = new JSONObject();
  
      try {
    	  
    	  vo.setUpdater(SessionUtil.getMemberId(request));
    	  int cnt = sYInspService.chkProdStrt(vo);	//cnt가 0이면 시작 된 오더 
    	  
    	  if(cnt != 0) {
			  int endChk = sYInspService.strtInspData(vo);
    	  }
	  
		  resultData.put("cnt", cnt);
		  resultData.put("status", HttpStatus.OK.value());
	} catch (Exception e) {
		e.printStackTrace();
		resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	}
      return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/selcSuipInspValue", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selcSuipInspValue(@ModelAttribute SYInspVO vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
	    logger.debug("FrontendController.selcSuipInspValue is called.");
	
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYInspVO> dataList = sYInspService.selcSuipInspVal(vo);

			if(dataList.size() == 0)
	        {
				vo.setCreator(SessionUtil.getMemberId(request));
				vo.setUpdater(SessionUtil.getMemberId(request));
				int rst = sYInspService.saveFirstSuipInspData(vo);
				dataList = sYInspService.selcSuipInspVal(vo);
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
	@RequestMapping(value = "/saveSuipInspValue", method = {
         RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
    @SuppressWarnings("unchecked")
    public String saveSuipInspValue(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
    logger.debug("FrontendController.saveSuipInspValue is called.");
    JSONObject resultData = new JSONObject();
    JSONParser parser = new JSONParser();
      
    String gridData = request.getParameter("param");
    String sample_type = request.getParameter("sample_type");
    String insp_case = request.getParameter("insp_case");
      
      
    try {
    	JSONArray jsonArray = (JSONArray) parser.parse(gridData);

    	List<List<SYInspVO>> t_list = new ArrayList<List<SYInspVO>>();

    	for (int i = 0; i < jsonArray.size(); i++) {
    		JSONArray inspKindArray = (JSONArray) parser.parse(jsonArray.get(i).toString());

    	  	List < SYInspVO > list = new ArrayList < SYInspVO > ();

    	  	for (int j = 0; j < inspKindArray.size(); j++) {
    	  		JSONObject jObj = (JSONObject) parser.parse(inspKindArray.get(j).toString());

    	  		Object[] keyArr = jObj.keySet().toArray();

    	  		SYInspVO dVo = new SYInspVO();


    	  		dVo.setCreator(SessionUtil.getMemberId(request));
    	  		dVo.setUpdater(SessionUtil.getMemberId(request));
    	  		dVo.setSample_type(sample_type);
    	  		dVo.setInsp_case(insp_case);
    	  		dVo.setProduct_menge(vo.getProduct_menge());
    	  		
    	  		dVo.setWorker(vo.getWorker());
    	  		dVo.setComment(vo.getComment());

    	  		for (Object key: keyArr) {
    	  			String nKey = key.toString();
    	  			String nValue = "";

    	  			if (jObj.get(nKey) == null)
    	  				continue;
    	  			else
    	  				nValue = jObj.get(nKey).toString();

    	  			if ("product_po".equals(nKey)) dVo.setProduct_po(nValue);
    	  			else if ("item_code".equals(nKey)) dVo.setItem_code(nValue);
    	  			else if ("routing_code".equals(nKey)) dVo.setRouting_code(nValue);
    	  			else if ("inspection_seq".equals(nKey)) dVo.setInspection_seq(nValue);
    	  			else if ("val_seq".equals(nKey)) dVo.setVal_seq(nValue);
    	  			else if ("insp_val".equals(nKey)) dVo.setInsp_val(nValue);
    	  			else if ("min_spec".equals(nKey)) dVo.setMin_spec(nValue);
    	  			else if ("a_insp_ng_cnt".equals(nKey)) dVo.setA_insp_ng_cnt(nValue);
    	  			else if ("b_insp_ng_cnt".equals(nKey)) dVo.setB_insp_ng_cnt(nValue);
    	  			else if ("c_insp_ng_cnt".equals(nKey)) dVo.setC_insp_ng_cnt(nValue);
    	  			else if ("insp_rst".equals(nKey)) dVo.setInsp_rst(nValue);
    	  		}
    	  		list.add(dVo);
    	  	}
    	  	t_list.add(list);
    	}
    	  
    	int dCnt = sYInspService.saveTotSuipInspVal(t_list);
    	resultData.put("status", HttpStatus.OK.value());
    	  
		} catch (ParseException e) {
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			e.printStackTrace();
		} 
      	return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/fnshSuipInspData", method = {
	RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String fnshSuipInspData(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.fnshSuipInspData is called.");

      JSONObject resultData = new JSONObject();
  
      try {
   
    	  String ipt_cnt = request.getParameter("ipt_cnt");	//화면에서 입력된 값의 개수  
    	  int s_ipt_cnt = Integer.parseInt(ipt_cnt);
    	  int rst = 1;
    	  int d_int_cnt = sYInspService.chkSuipInspIptCnt(vo);		//DB에 저장된 값의 개수 
    	  
    	  int cnt = sYInspService.chkInspIng(vo);
	  
    	  if(cnt == 0 && (s_ipt_cnt == d_int_cnt)) {
			  vo.setCreator(SessionUtil.getMemberId(request));
	          vo.setUpdater(SessionUtil.getMemberId(request));
	          vo.setMember_nm(SessionUtil.getMemberNm(request));
	          int endChk = sYInspService.fnshSuipInspData(vo);  
	          rst = 0;
		  }
		  
    	  resultData.put("cnt", rst);
		  resultData.put("status", HttpStatus.OK.value());
	} catch (Exception e) {
		e.printStackTrace();
		resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	}
      return resultData.toJSONString();
	}
	
	// 1118 ST
//		selectIncome_result_s
	@ResponseBody
	@RequestMapping(value = "/selectIncome_result_s", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result_s(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectIncome_result_s is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYIncome_resultVo> dataList = sYInspService.selectIncome_result_s(vo);

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
	@RequestMapping(value = "/selectIncome_result2_s", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result2_s(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectIncome_result2_s is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYIncome_resultVo> dataList = sYInspService.selectIncome_result2_s(vo);

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
	@RequestMapping(value = "/selectIncome_result3_s", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectIncome_result3_s(@ModelAttribute SYIncome_resultVo vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectIncome_result3_s is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			// String lifnr = URLDecoder.decode(request.getParameter("LIFNR"),
			// "UTF-8" );

			List<SYIncome_resultVo> dataList = sYInspService.selectIncome_result3_s(vo);

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
	
	// 1118 END
	
	@ResponseBody
	@RequestMapping(value = "/selectDfctGrph", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectDfctGrph(@ModelAttribute SYInspVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectDfctGrph is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYInspVO> dataList = sYInspService.selectDfctGrph(vo);

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
	@RequestMapping(value = "/selectDfctGrphLt", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectDfctGrphLt(@ModelAttribute SYInspVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectDfctGrphLt is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			
			List<SYInspVO> dataList = sYInspService.selectDfctGrphLt(vo);

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
	@RequestMapping(value = "/selectDfctGrphRt", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectDfctGrphRt(@ModelAttribute SYInspVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectDfctGrphRt is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYInspVO> dataList = sYInspService.selectDfctGrphRt(vo);
			
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
	@RequestMapping(value = "/selectPrtInfo", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPrtInfo(@ModelAttribute SYPrintVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectPrtInfo is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYPrintVO> dataList = sYInspService.selectPrtInfo(vo);

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
	@RequestMapping(value = "/selectDfctGrphMd", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectDfctGrphMd(@ModelAttribute SYInspVO vo,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		logger.debug("FrontendController.selectDfctGrphMd is called.");

		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			List<SYInspVO> dataList = sYInspService.selectDfctGrphMd(vo);
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
	@RequestMapping(value = "/initInspInfo", method = {
	RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String initInspInfo(@ModelAttribute SYInspVO vo,
         HttpServletRequest request, HttpServletResponse response,
         HttpSession session) {
      logger.debug("FrontendController.initInspInfo is called.");

      JSONObject resultData = new JSONObject();
  
      try {
    	  vo.setCreator(SessionUtil.getMemberId(request));
	  	  vo.setUpdater(SessionUtil.getMemberId(request));
    	  int result = sYInspService.initInspInfo(vo);
	  
		  resultData.put("status", HttpStatus.OK.value());
	} catch (Exception e) {
		e.printStackTrace();
		resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	}
      return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/selcSuipInspOrd", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selcSuipInspOrd(@ModelAttribute SYInspVO vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
	    logger.debug("FrontendController.selcSuipInspOrd is called.");
	
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {

			List<SYInspVO> dataList = sYInspService.selcSuipInspOrd(vo);
			
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
	@RequestMapping(value = "/confirmSuipInsp", method = {
			RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String confirmSuipInsp(@ModelAttribute SYInspVO vo,HttpServletRequest request, HttpServletResponse response, HttpSession session) {
	    logger.debug("FrontendController.confirmSuipInsp is called.");
	
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		JSONParser jsonParser = new JSONParser();
		try {
			
			int rtng_size = 0;
			
			SYRoutingMasterVo nVo = new SYRoutingMasterVo();
			nVo.setItem_code(vo.getItem_code());
			List<SYRoutingMasterVo> dataList = sYInfoService.selectRouting_master(nVo);
			
			rtng_size = dataList.size();
			
			if(rtng_size != 0)
			{
				vo.setCreator(SessionUtil.getMemberId(request));
    	  		vo.setUpdater(SessionUtil.getMemberId(request));
    	  		
				int result = sYInspService.confirmSuipInsp(vo);	
			}  
			
			resultData.put("rtng_size", rtng_size);
			resultData.put("status", HttpStatus.OK.value());
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
}