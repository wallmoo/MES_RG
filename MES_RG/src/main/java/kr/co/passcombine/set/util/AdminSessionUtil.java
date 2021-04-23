package kr.co.passcombine.set.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AdminSessionUtil {
	
	public static String getAdminId(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("admin_id");
	}
	
	public static String getAdminNm(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("admin_nm");
	}
	
	public static String getAdminRole(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("admin_role");
	}
	
	public static boolean isLogIn(HttpServletRequest request) {
		String admin_id = getAdminId(request);
		if (admin_id == null || admin_id.equals("")) {
			return false;
		}
		return true;
	}
	
	public static boolean LogOut(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		session.invalidate();
		return true;
	}
}