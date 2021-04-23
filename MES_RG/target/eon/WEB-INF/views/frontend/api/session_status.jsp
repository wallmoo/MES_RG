<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>

<%
String se_check = "";
System.out.println(!SessionUtil.isLogIn(request));
if(!SessionUtil.isLogIn(request)){
	se_check = "false";    // 세션이 살아있는 경우
}else
{
	se_check = "true";     // 세션이 없는 경우
}
%><%=se_check %>