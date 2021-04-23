package kr.co.passcombine.set.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.passcombine.set.svc.SYOrganService;
import kr.co.passcombine.set.util.ResponseUtils;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.vo.SYMemberVo;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Resource(name = "setOrganService")
	SYOrganService syOrganService; 
	
	@RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.index() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("frontend/dashboard/imsi");
//		modelAndView.setViewName("frontend/dashboard/dashboard_monthly");
		return modelAndView;
	}
	
	@RequestMapping(value = "/login", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.login() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login");
		return modelAndView;
	}
	
	@RequestMapping(value = "/login_process", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings("unchecked")
	public String loginProcess(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.loginProcess() is called.");
		JSONObject resultData = new JSONObject();  
    JSONObject dataObj = new JSONObject();
    JSONParser jsonParser = new JSONParser();
    try {
			SYMemberVo detailMember = syOrganService.selectMemberLoginInfo(memberVo);
			String dataJsonString = ResponseUtils.getJsonResponse(response, detailMember);
			dataObj = (JSONObject) jsonParser.parse(dataJsonString);
			
			if(detailMember != null && detailMember.getMember_id() != null) {
				resultData.put("result", HttpStatus.OK.value());
	      resultData.put("message", "로그인 되었습니다.");
	      resultData.put("data", dataObj);
	      
	      session = request.getSession(false);
	      session.setAttribute("member_id", ""+detailMember.getMember_id()+"");
	      session.setAttribute("member_emp_no", ""+detailMember.getMember_emp_no()+"");
	      session.setAttribute("member_nm", ""+detailMember.getMember_nm()+"");
	      session.setAttribute("member_email", detailMember.getMember_email());
	      session.setAttribute("company_cd", ""+detailMember.getCompany_cd()+"");
				session.setAttribute("company_nm", ""+detailMember.getCompany_nm()+"");
				session.setAttribute("dept_cd", ""+detailMember.getDept_cd()+"");
				session.setAttribute("dept_nm", ""+detailMember.getDept_nm()+"");
				session.setAttribute("role_cd", detailMember.getRole_cd());
				session.setAttribute("role_nm", detailMember.getRole_cd());
				session.setAttribute("position_cd", detailMember.getPosition_cd());
				session.setAttribute("position_nm", detailMember.getPosition_nm());
				
			} else {
				resultData.put("result", HttpStatus.NO_CONTENT.value());
	      resultData.put("message", "로그인 정보가 올바르지 않습니다.\n다시 확인하시고 로그인해 주세요.");
	      resultData.put("data", dataObj);
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("result", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "로그인 프로세스의 에러가 발생했습니다. \n" + e.toString());
      resultData.put("data", null);
		}
		return resultData.toJSONString();
	}
	
	
	@RequestMapping(value = "/login_process_auto", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings("unchecked")
	public String loginProcessAuto(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.loginProcessAuto() is called.");
		JSONObject resultData = new JSONObject();  
    JSONObject dataObj = new JSONObject();
    JSONParser jsonParser = new JSONParser();
    try {
    	SYMemberVo detailMember = syOrganService.selectMemberLoginInfoAuto(memberVo);
			String dataJsonString = ResponseUtils.getJsonResponse(response, detailMember);
			dataObj = (JSONObject) jsonParser.parse(dataJsonString);
			
			if(detailMember != null && detailMember.getMember_id() != null) {
				
				if(detailMember.getRole_cd() == null || detailMember.getRole_cd().equals("")){
					resultData.put("result", HttpStatus.NO_CONTENT.value());
					resultData.put("message", "로그인에 문제가 있습니다.");
					resultData.put("data", null);
				} else {
					resultData.put("result", HttpStatus.OK.value());
					 resultData.put("message", "로그인 되었습니다.");
		      resultData.put("data", dataObj);
				}
				
			    session = request.getSession(false);
			    session.setAttribute("member_id", ""+detailMember.getMember_id()+"");
			    session.setAttribute("member_emp_no", ""+detailMember.getMember_emp_no()+"");
			    session.setAttribute("member_nm", ""+detailMember.getMember_nm()+"");
			    session.setAttribute("member_nm_en", ""+detailMember.getMember_nm_en()+"");
			    session.setAttribute("member_email", detailMember.getMember_email());
			    session.setAttribute("company_cd", ""+detailMember.getCompany_cd()+"");
				session.setAttribute("company_nm", ""+detailMember.getCompany_nm()+"");
				session.setAttribute("dept_cd", ""+detailMember.getDept_cd()+"");
				session.setAttribute("dept_nm", ""+detailMember.getDept_nm()+"");
				session.setAttribute("role_cd", detailMember.getRole_cd());
				session.setAttribute("role_nm", detailMember.getRole_nm());
				session.setAttribute("position_cd", detailMember.getPosition_cd());
				session.setAttribute("position_nm", detailMember.getPosition_nm());
				session.setAttribute("extension", detailMember.getExtension());
				
				
			} else {
				resultData.put("result", HttpStatus.NO_CONTENT.value());
				  resultData.put("message", "로그인 정보가 올바르지 않습니다.\n다시 확인하시고 로그인해 주세요.");
			      resultData.put("data", dataObj);
			}
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("result", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("message", "로그인 프로세스의 에러가 발생했습니다. \n" + e.toString());
      resultData.put("data", null);
		}
		return resultData.toJSONString();
	}
	
	
	@RequestMapping(value = "/logout", method = {RequestMethod.GET, RequestMethod.POST})
	@SuppressWarnings("unused")
	public ModelAndView logoutMain(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.logoutMain() is called.");
/*		boolean result = SessionUtil.LogOut(request);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login");
		return modelAndView;
		*/
		logger.debug("MainController.logoutMain() is called.");
		boolean result = SessionUtil.LogOut(request);
		request.setAttribute("logout", "Logout");            // <------여기 이한줄 추가
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login");
		//modelAndView.setViewName("https://login.vieworks.com/s/?spid=sap.vcs&authurl=http://10.16.0.145:9090/auth_check&backurl=http://10.16.0.145:9090/login");
		return modelAndView;
		
	}
	
	@RequestMapping(value = "/auth_check", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView auth_check(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.auth_check() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("auth_check");
		return modelAndView;
	}
	
	@RequestMapping(value = "/api/session_logout", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView session_logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.session_logout() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("api/session_logout");
		return modelAndView;
		
	}
	
	@RequestMapping(value = "/api/session_status", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView session_status(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.session_status() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("api/session_status");
		return modelAndView;
		
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/pwd_change", method = {RequestMethod.GET, RequestMethod.POST})
	public JSONObject pwdChanged(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.pwdChange() is called.");
		JSONObject resultData = new JSONObject();
		try {
			SYMemberVo memberInfo = syOrganService.selectMemberLoginInfo(memberVo);
			if(memberInfo != null && !memberInfo.getMember_id().equals("")){
				
				memberInfo.setUpdater(SessionUtil.getMemberId(request));
				memberInfo.setMember_pwd(memberVo.getMember_new_pwd());
				memberInfo.setInit_yn("N");

				int result = syOrganService.updateMemberPwd(memberInfo);
				if(result > 0){
					resultData.put("result", HttpStatus.OK.value());
				}
				 
			} else {
				resultData.put("result", HttpStatus.NO_CONTENT.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("result", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/personal_info", method = {RequestMethod.GET, RequestMethod.POST})
	public JSONObject checkInitPwd(@ModelAttribute SYMemberVo memberVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("MainController.checkInitPwd() is called.");
		JSONObject resultData = new JSONObject();
		try {
			SYMemberVo memberInfo = null;
			 
			memberInfo = syOrganService.selectMemberInfo(memberVo);
			 
			resultData.put("result", HttpStatus.OK.value());
			resultData.put("info", memberInfo);
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("result", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData;
	}
}
