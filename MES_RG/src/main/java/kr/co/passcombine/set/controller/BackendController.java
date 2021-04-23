package kr.co.passcombine.set.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 


import kr.co.passcombine.set.svc.LogStatusService;
import kr.co.passcombine.set.svc.SYCodeService;
import kr.co.passcombine.set.svc.SYMenuService;
import kr.co.passcombine.set.svc.SYOrganService;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.util.StringUtil;
import kr.co.passcombine.set.vo.SYCodeVo;
import kr.co.passcombine.set.vo.SYMemberVo;
import kr.co.passcombine.set.vo.SYMenuVo;
import kr.co.passcombine.set.vo.SYOrganVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/backend")
public class BackendController {
	private static final Logger logger = LoggerFactory.getLogger(BackendController.class);
	
	@Resource(name = "setCodeService")
	SYCodeService syCodeService;
	
	@Resource(name = "setOrganService")
	SYOrganService syOrganService;
	
	@Resource(name = "setMenuService")
	SYMenuService syMenuService;
	
 
	@Resource(name = "setLogStatusService")
	LogStatusService logStatusService;
	
	@RequestMapping(value = "", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView backendMain(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.backendMain() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("backend/backend_main");
		return modelAndView;
	}
	
	/** #00. System Management : Menu Navigation Management : START =================================================================== */
	
	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView backendMenuNavigation(@PathVariable String menu_div, @PathVariable String menu_page, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.backendMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("backend/"+menu_div+"/"+menu_page);
		return modelAndView;
	}
	
	/** #00. System Management : Menu Navigation Management : END =================================================================== */
	
	/** #01. System Management : System Common Code Management : START =================================================================== */
	
	@ResponseBody
	@RequestMapping(value = "/code/data_codegrid", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String codeMain(@ModelAttribute SYCodeVo codeVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.codeMain() is called.");
		List<SYCodeVo> listCode = null;
		if(codeVo != null && codeVo.getMaster_code() != null) {
			listCode = syCodeService.selectDetailCode(codeVo);
		} else {
			listCode = syCodeService.selectMasterCode(codeVo);
		}
		
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCode);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		
		//logger.debug("\n\n\n\n\n" + resultData.toJSONString());
		
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/code/save_code", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String codeSaveData(@ModelAttribute SYCodeVo codeVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.codeSaveData() is called.");
		codeVo.setCreator(SessionUtil.getMemberId(request));
		codeVo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try{
			if(codeVo.getCmd() != null && codeVo.getCmd().equals("insert.master_code")){
				syCodeService.insertMasterCode(codeVo);
				resultData.put("division", "master");
			} else if(codeVo.getCmd() != null && codeVo.getCmd().equals("insert.detail_code")){
				syCodeService.insertDetailCode(codeVo);
				resultData.put("division", "detail");
			} else if(codeVo.getCmd() != null && codeVo.getCmd().equals("update.master_code")){
				syCodeService.updateMasterCode(codeVo);
				resultData.put("division", "master");
			} else if(codeVo.getCmd() != null && codeVo.getCmd().equals("update.detail_code")){
				syCodeService.updateDetailCode(codeVo);
				resultData.put("division", "detail");
			}
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/code/del_code", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String codeDelData(@ModelAttribute SYCodeVo codeVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.codeDelData() is called.");
		JSONObject resultData = new JSONObject();
		try{
			if(codeVo.getCmd() != null && codeVo.getCmd().equals("delete.master_code")){
				syCodeService.deleteMasterCode(codeVo);
				resultData.put("division", "master");
			} else if(codeVo.getCmd() != null && codeVo.getCmd().equals("delete.detail_code")){
				syCodeService.deleteDetailCode(codeVo);
				resultData.put("division", "detail");
			}
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	/** #01. System Management : System Common Code Management : END =================================================================== */
	
	/** #02. System Management : Organization & User Management : START =================================================================== */
	
	@ResponseBody
	@RequestMapping(value = "/mng_organ/data_organ_tree", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String dataOrganTree(@ModelAttribute SYOrganVo organVo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("BackendController.dataOrganTree() is called.");
		JSONArray treeDatas = new JSONArray();
		JSONArray listDataJArray = new JSONArray();
		try {
			listDataJArray = getOrganTreeData(treeDatas, organVo, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listDataJArray.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/data_ogran_info", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public JSONObject dataDeptInfo(@ModelAttribute SYOrganVo organVo, HttpServletRequest request) {
		logger.debug("BackendController.dataDeptInfo() is called.");
		JSONObject resultData = new JSONObject();
		try {
			SYOrganVo detailOrgan = syOrganService.selectOrganInfo(organVo);
			resultData.put("result", "success");
			resultData.put("data", detailOrgan);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return resultData;
	}
	
	@SuppressWarnings("unchecked")
	private JSONArray getOrganTreeData(JSONArray treeDatas, SYOrganVo organVo, HttpServletResponse response) throws Exception {
		JSONArray tempTreeDatas = new JSONArray();
		try {
			List<SYOrganVo> listDept = syOrganService.selectOrgan(organVo);
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listDept);
			tempTreeDatas = (JSONArray) jsonParser.parse(listDataJsonString);

			for (int i = 0; i < tempTreeDatas.size(); i++) {
				JSONObject attr = new JSONObject();
				JSONObject state = new JSONObject();
				JSONObject data = new JSONObject();
				JSONObject tempJo = (JSONObject) tempTreeDatas.get(i);

				data.put("id", tempJo.get("dept_cd").toString());
				data.put("text", tempJo.get("dept_nm").toString());

				attr.put("dept_cd", tempJo.get("dept_cd").toString());
				attr.put("dept_p_cd", tempJo.get("dept_p_cd").toString());
				attr.put("dept_nm", tempJo.get("dept_nm").toString());

				state.put("disabled", false);
				state.put("selected", false);

				if (tempJo.get("dept_p_cd").equals("0")) {
					state.put("opened", true);
				} else if (Integer.parseInt(tempJo.get("cnt_child").toString()) > 0) {
					state.put("opened", false);
				}

				JSONArray children = new JSONArray();
				data.put("a_attr", attr);
				data.put("state", state);
				data.put("children", children);

				if (Integer.parseInt(tempJo.get("cnt_child").toString()) > 0) {
					SYOrganVo childSYOrganVo = new SYOrganVo();
					childSYOrganVo.setCompany_cd(organVo.getCompany_cd());
					childSYOrganVo.setDept_p_cd(tempJo.get("dept_cd").toString());
					childSYOrganVo.setDept_use_yn(organVo.getDept_use_yn());
					getOrganTreeData(children, childSYOrganVo, response);
				}
				treeDatas.add(data);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception: ", e.toString());
		}
		return treeDatas;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/save_dept", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String saveDept(@ModelAttribute SYOrganVo organVo, HttpServletRequest request) {
		logger.debug("BackendController.saveDept() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			organVo.setCreator(SessionUtil.getMemberId(request));
			organVo.setUpdater(SessionUtil.getMemberId(request));
			
			if(organVo.getCmd().equals("I")) {
				result = syOrganService.insertDept(organVo);
			} else {
				result = syOrganService.updateDept(organVo);
			}
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mng_organ/del_dept", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String delDept(@ModelAttribute SYOrganVo organVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.delDept() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try{
			organVo.setCreator(SessionUtil.getMemberId(request));
			organVo.setUpdater(SessionUtil.getMemberId(request));
			organVo.setDept_use_yn("N");
			
			if(organVo.getCmd().equals("D")) {
				result = syOrganService.deleteDept(organVo);
			} 
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
	
	@ResponseBody
	@RequestMapping(value = "/mng_organ/data_member_grid", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String organMemberData(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.organMemberData() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYMemberVo> listMember = syOrganService.selectMemberList(memberVo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listMember);
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
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/data_member_info", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public JSONObject dataMemberInfo(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request) {
		logger.debug("BackendController.dataMemberInfo() is called.");
		JSONObject resultData = new JSONObject();
		try {
			SYMemberVo detailMember = syOrganService.selectMemberInfo(memberVo);
			resultData.put("result", "success");
			resultData.put("data", detailMember);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return resultData;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/save_member", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String saveMember(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request) {
		logger.debug("BackendController.saveMember() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			memberVo.setCreator(SessionUtil.getMemberId(request));
			memberVo.setUpdater(SessionUtil.getMemberId(request));
			memberVo.setStart_dt(StringUtil.replace2(memberVo.getStart_dt(), ".", ""));
			if(memberVo.getEnd_dt() != null && memberVo.getEnd_dt().length() == 10) {
				memberVo.setEnd_dt(StringUtil.replace2(memberVo.getEnd_dt(), ".", ""));
			}
			
			if(memberVo.getCmd().equals("I")) {
				memberVo.setMember_pwd("v1234");
				memberVo.setInit_yn("Y");
				result = syOrganService.insertMember(memberVo);
			} else {
				result = syOrganService.updateMember(memberVo);
			}
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/mng_organ/del_member", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String delMember(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.delMember() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try{
			memberVo.setUpdater(SessionUtil.getMemberId(request));
			memberVo.setUse_yn("N");
			
			if(memberVo.getCmd().equals("D")) {
				result = syOrganService.deleteMember(memberVo);
			} 
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
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/check_member_id", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String checkMemberId(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request) {
		logger.debug("BackendController.checkMemberId() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = syOrganService.selectMemberIdCheck(memberVo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/check_member_emp_no", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String check_member_emp_no(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request) {
		logger.debug("BackendController.check_member_emp_no() is called.");
		JSONObject resultData = new JSONObject();
		int exist_cnt = 0;
		try {
			exist_cnt = syOrganService.selectMemberEMPCheck(memberVo);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("cnt", exist_cnt + "");
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/init_member_pwd", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String initMemberPwd(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request) {
		logger.debug("BackendController.initMemberPwd() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			memberVo.setUpdater(SessionUtil.getMemberId(request));
			memberVo.setInit_yn("Y");
			memberVo.setMember_pwd("v1234");
			result = syOrganService.updateMemberPwd(memberVo);
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
		
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_organ/chnDeptSave", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String chnDeptSave(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request) {
		logger.debug("BackendController.chnDeptSave() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {

			String org_dept_cd = request.getParameter("org_dept_cd");
			String selc_dept_cd = request.getParameter("selc_dept_cd");
			String member_emp_no = request.getParameter("member_emp_no");
			
			memberVo.setDept_cd(org_dept_cd);
			memberVo.setChn_dept_cd(selc_dept_cd);
			memberVo.setMember_emp_no(member_emp_no);
			memberVo.setUpdater(SessionUtil.getMemberId(request));
			
			result = syOrganService.chnDeptSave(memberVo);
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	/** #02. System Management : Organization & User Management : END =================================================================== */
	
	/** #03. System Management : Menu Management : START =================================================================== */
	
	@ResponseBody
	@RequestMapping(value = "/mng_menu/data_menu_tree", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String dataMenuTree(@ModelAttribute SYMenuVo menuVo, HttpServletRequest request, HttpServletResponse response) {
		logger.debug("BackendController.dataMenuTree() is called.");
		JSONArray treeDatas = new JSONArray();
		JSONArray listDataJArray = new JSONArray();
		try {
			listDataJArray = getMenuTreeData(treeDatas, menuVo, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listDataJArray.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	private JSONArray getMenuTreeData(JSONArray treeDatas, SYMenuVo menuVo, HttpServletResponse response) throws Exception {
		JSONArray tempTreeDatas = new JSONArray();
		try {
			List<SYMenuVo> listMenu = syMenuService.selectMenu(menuVo);
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listMenu);
			tempTreeDatas = (JSONArray) jsonParser.parse(listDataJsonString);

			for (int i = 0; i < tempTreeDatas.size(); i++) {
				JSONObject attr = new JSONObject();
				JSONObject state = new JSONObject();
				JSONObject data = new JSONObject();
				JSONObject tempJo = (JSONObject) tempTreeDatas.get(i);

				data.put("id", tempJo.get("menu_cd").toString());
				data.put("text", tempJo.get("menu_nm").toString());

				attr.put("menu_cd", tempJo.get("menu_cd").toString());
				attr.put("menu_p_cd", tempJo.get("menu_p_cd").toString());
				attr.put("menu_nm", tempJo.get("menu_nm").toString());

				state.put("disabled", false);
				state.put("selected", false);

				if (tempJo.get("menu_p_cd").equals("-1")) {
					state.put("opened", true);
				} else if (Integer.parseInt(tempJo.get("cnt_child").toString()) > 0) {
					state.put("opened", false);
				}

				JSONArray children = new JSONArray();
				data.put("a_attr", attr);
				data.put("state", state);
				data.put("children", children);

				if (Integer.parseInt(tempJo.get("cnt_child").toString()) > 0) {
					SYMenuVo childMenuVo = new SYMenuVo();
					childMenuVo.setMenu_div(menuVo.getMenu_div());
					childMenuVo.setMenu_p_cd(tempJo.get("menu_cd").toString());
					getMenuTreeData(children, childMenuVo, response);
				}
				treeDatas.add(data);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception: ", e.toString());
		}
		return treeDatas;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/mng_menu/data_menu_info", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public JSONObject dataMenuInfo(@ModelAttribute SYMenuVo menuVo, HttpServletRequest request) {
		logger.debug("BackendController.dataMenuInfo() is called.");
		logger.debug("\n\n\n\n\n" + "/mng_menu/data_menu_info");
		JSONObject resultData = new JSONObject();
		try {
			SYMenuVo detailMenu = syMenuService.selectMenuInfo(menuVo);
			resultData.put("result", "success");
			resultData.put("data", detailMenu);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return resultData;
	}
	
	@ResponseBody
	@RequestMapping(value = "/menu/save_menu", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveMenuData(@ModelAttribute SYMenuVo menuVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.saveMenuData() is called.");
		menuVo.setCreator(SessionUtil.getMemberId(request));
		menuVo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try{
			if(menuVo.getCmd() != null && menuVo.getCmd().equals("I")){
				syMenuService.insertMenu(menuVo);
			} else if(menuVo.getCmd() != null && menuVo.getCmd().equals("U")){
				syMenuService.updateMenu(menuVo);
			} 
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/menu/del_menu", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String delMenuData(@ModelAttribute SYMenuVo menuVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.delMenuData() is called.");
		JSONObject resultData = new JSONObject();
		try{
			syMenuService.deleteMenu(menuVo);
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	/** #03. System Management : Menu Management : END =================================================================== */
	
	/** #04. System Management : Role Management : START =================================================================== */
	
	@ResponseBody
	@RequestMapping(value = "/role/data_role_member_grid", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String roleMemberData(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.roleMemberData() is called.");
		JSONObject resultData = new JSONObject();
		try {
			int currentPage = Integer.parseInt(request.getParameter("page")); 
	    int pageRows = Integer.parseInt(request.getParameter("rows")); 
	    int startIndex = currentPage * pageRows - pageRows; 
	    
	    memberVo.setPage(startIndex);
	    memberVo.setRows(pageRows);
	    
			int totalRows = syOrganService.selectRoleMemberCount(memberVo);
			List<SYMemberVo> listMember = syOrganService.selectRoleMemberList(memberVo);
			resultData = ResponseUtils.getJQGridJsonResponse(response, listMember, currentPage, pageRows, totalRows);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		// logger.debug("flow log : resultData.toJSONString() : \n\n" + resultData.toJSONString());
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/role/save_role", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String saveRoleMember(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.saveRoleMember() is called.");
		memberVo.setCreator(SessionUtil.getMemberId(request));
		memberVo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try{
			syOrganService.insertRoleMember(memberVo); 
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/role/data_role_menu_grid", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String roleMenuAclData(@ModelAttribute SYMenuVo menuVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.roleMenuAclData() is called.");
		JSONArray treeDatas = new JSONArray();
		JSONArray listDataJArray = new JSONArray();
		try {
			if(menuVo.getRole_cd() != null && !menuVo.getRole_cd().equals("N/A")){
				listDataJArray = getMenuTreeGridData(treeDatas, menuVo, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listDataJArray.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	private JSONArray getMenuTreeGridData(JSONArray treeDatas, SYMenuVo menuVo, HttpServletResponse response) throws Exception {
		JSONArray tempTreeDatas = new JSONArray();
		try {
			List<SYMenuVo> listMenu = syMenuService.selectMenuRole(menuVo);
			JSONParser jsonParser = new JSONParser();
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listMenu);
			tempTreeDatas = (JSONArray) jsonParser.parse(listDataJsonString);

			for (int i = 0; i < tempTreeDatas.size(); i++) {
				JSONObject data = new JSONObject();
				JSONObject tempJo = (JSONObject) tempTreeDatas.get(i);

				data.put("role_cd", tempJo.get("role_cd").toString());
				data.put("role_nm", tempJo.get("role_nm").toString());
				data.put("menu_cd", tempJo.get("menu_cd").toString());
				data.put("menu_nm", tempJo.get("menu_nm").toString());
				data.put("menu_p_cd", tempJo.get("menu_p_cd").toString());
				data.put("mng_yn", tempJo.get("mng_yn").toString());
				data.put("write_yn", tempJo.get("write_yn").toString());
				data.put("read_yn", tempJo.get("read_yn").toString());
				data.put("lvl", Integer.parseInt(tempJo.get("lvl").toString()) - 1);
				data.put("isLeaf", (Integer.parseInt(tempJo.get("cnt_child").toString()) > 0?false:true));
				data.put("expanded", (Integer.parseInt(tempJo.get("cnt_child").toString()) > 0?true:false));
				data.put("loaded", true);
				
				treeDatas.add(data);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception: ", e.toString());
		}
		return treeDatas;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/role/save_menu_acl", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	public String roleSaveMenuAcl(@ModelAttribute SYMenuVo menuVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("BackendController.roleSaveMenuAcl() is called.");
		JSONObject resultData = new JSONObject();
		try{
			menuVo.setCreator(SessionUtil.getMemberId(request));
			menuVo.setUpdater(SessionUtil.getMemberId(request));
			
			String menu_cds = request.getParameter("menu_cds");
			String mng_yns = request.getParameter("mng_yns");
			String write_yns = request.getParameter("write_yns");
			String read_yns = request.getParameter("read_yns");
			
			syMenuService.insertMenuRole(menuVo, menu_cds, mng_yns, write_yns, read_yns);
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	
	
	/** #04. System Management : Role Management : END =================================================================== */
	
	 
}
