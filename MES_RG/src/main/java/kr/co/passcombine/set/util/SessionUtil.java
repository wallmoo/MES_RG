package kr.co.passcombine.set.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.apache.ibatis.io.Resources;

public class SessionUtil {
	
	public static String getMemberEmpNo(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("member_emp_no");
	}
	public static String getMemberId(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("member_id");
	}
	public static String getMemberEmail(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("member_email");
	}
	public static String getMemberNm(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("member_nm");
	}
	public static String getCompanyCd(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("company_cd");
	}
	public static String getCompanyNm(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("company_nm");
	}
	public static String getDeptCd(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("dept_cd");
	}
	public static String getDeptNm(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("dept_nm");
	}
	public static String getPositionCd(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("position_cd");
	}
	public static String getPositionNm(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("position_nm");
	}
	public static String getMapOrd(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("map_ord");
	}
	public static String getRoleCd(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("role_cd");
	}
	public static String getRoleNm(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("role_nm");
	}
	public static String getMemberLang(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("member_lang");
	}
	public static String getMemberDivision(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("member_division");
	}
	public static String getMemberVdrIdx(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("member_vdr_idx");
	}
	
	public static boolean isLogIn(HttpServletRequest request) {
		String member_id = getMemberId(request);
		if (member_id == null || member_id.equals("")) {
			return false;
		}
		return true;
	}
	
	public static boolean LogOut(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		session.invalidate();
		return true;
	}
	
	public static String getProperties(String p) {
		String propStr = "";
		String resource = "app.properties";
        Properties properties = new Properties();
        
        try {
            Reader reader = Resources.getResourceAsReader(resource);
            properties.load(reader);
 
            propStr = properties.getProperty(p);
            if( propStr==null ) {
            	propStr = "None";
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
		return propStr;
	}
}