<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.io.BufferedReader.*" %>
<%@ page import="java.io.InputStreamReader.*" %>
<%@ page import="java.io.InputStream.*" %>
<%@ page import="java.io.OutputStreamWriter.*" %>
<%@ page import="java.io.DataOutputStream.*" %>
<%@ page import="java.net.HttpURLConnection.*" %>
<%@ page import="java.net.URL.*" %>
<%@ page import="java.util.List.*" %>
<%@ page import="java.util.Map.Entry.*" %>
 
<%
			//String charSet = "UTF-8" ;
			//String backurl = request.getParameter("backurl")==null?"localhost:9090/login":request.getParameter("backurl");
			//String token = request.getParameter("token")==null?"AAAAAAAAA":request.getParameter("token");
			
			try
			{
				/*
					하기 SPID 문자열 중 택 1
					sap.mes
					sap.vcs
					sap.hrm
					intranet.vip
				*/
				//-----------------------------------------------------------------//
				String sSPID = "sap.mes";

				//String sToken = "form 'token=' 에서 추출";
				//String sBackURL = "form 'token=' 에서 추출";
				String sToken = request.getParameter("token")==null?"NULL":request.getParameter("token");
				
				System.out.println(request.getParameter("token"));
				String sBackURL = request.getParameter("backurl")==null?"10.16.0.204:8080/login":request.getParameter("backurl");
				System.out.println(request.getParameter("backurl"));
				String sURL_TokenCheck = "http://login.vieworks.com/api/token/check";
				String sURL_TokenError = "https://login.vieworks.com/s/error";
				String sURL_SSO_Check = "https://login.vieworks.com/s/";
				String sUserID = "";
				//-----------------------------------------------------------------//

				String stuff = null;
				String reqContent = "";
				String param = "token=" + sToken + "&spid=" + sSPID;
				System.out.println(param);
				java.net.URL url = new java.net.URL(sURL_TokenCheck);
				java.net.HttpURLConnection conn = (java.net.HttpURLConnection)url.openConnection();
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Content-Length", "" + Integer.toString(param.getBytes().length));
				conn.setRequestProperty("Content-Language", "en-US"); 
				conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
				conn.setDoInput(true); 
				conn.setDoOutput(true); 
				conn.setUseCaches(false); 
				conn.setAllowUserInteraction(true);
				//System.out.println("test");
				java.io.DataOutputStream printout = new java.io.DataOutputStream (conn.getOutputStream ());
				//System.out.println("test1");
				printout.writeBytes (param);
				printout.flush ();
				printout.close (); 
				java.io.BufferedReader in = new java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream())); 
				//System.out.println("test1");
				while ((stuff = in.readLine()) != null)
				{
					reqContent += stuff; 
				}
				in.close();
				System.out.println(reqContent);
				if(reqContent == "")
				{
					// token 인증 실패한 경우
					// 세션 없는 경우와 동일하게 redirection.
					// ex> https://login.vieworks.com/s/spid=sap.hrm
					//System.out.println('2');
					String sRedirection_URL = sURL_SSO_Check + "?spid=" + sSPID; 
				 
					response.sendRedirect("https://login.vieworks.com/s/error/?error=nouserid&spid=sap.mes&authurl=http://10.16.0.204:8080/auth_check&backurl=http://10.16.0.204:8080/login");
 
				}
				else
				{
					// token 인증 성공 한 경우
					sUserID = reqContent;
					response.sendRedirect("http://10.16.0.204:8080/login?sUserID=" + sUserID);
					
// 					request.setAttribute("sUserID", sUserID);
// 					RequestDispatcher dispatcher = request.getRequestDispatcher("http://localhost:9090/login");
// 					dispatcher.forward(request, response);

					//System.out.println(sUserID);
					// 전달 받은 sUserID 로 세션 발급

				}		  
			}
			catch (Exception e) 
			{
				// error
				System.out.println("Error");
			}
				
%>
