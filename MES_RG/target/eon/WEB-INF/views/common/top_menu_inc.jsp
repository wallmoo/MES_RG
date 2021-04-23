<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.SessionUtil"%>
<%
String fb_div = (String) request.getAttribute("fb_div");
%>
<header class="main-header">

<%if(fb_div != null && fb_div.equals("F")) {%>
  
 
  <a href="/" class="logo" style="padding-left: 0px; padding-right: 0px;">
  <!--  <span class="logo-lg"><img src="/res/images/mhe/logo_MHE_white.png" width="90" height="30"></span> -->
	    <span class="logo-mini"><b>S</b> LICENSE</span>
	    <span class="logo-lg"><b>Set</b> LICENSE</span>
  </a>
  
  <nav id="navbar_top" class="navbar navbar-static-top">
    <a href="#" id="menu_toggle" class="sidebar-toggle" data-toggle="push-menu" role="button">
      <span class="sr-only">Toggle navigation</span>
    </a>
		
    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav">
      	<li class="dropdown notifications-menu">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-user"></i>
          </a>
          <ul class="dropdown-menu">
          	<li>
              <ul class="menu">
                <li>
                  <a href="#">
                    <i class="fa fa-hand-paper-o text-red"></i> <b> [<%=SessionUtil.getDeptNm(request)%>] <%=SessionUtil.getMemberNm(request)%> </b>
                  </a>
                </li>
                <li>
                  <a href="javascript:fnLoadProfile('<%=SessionUtil.getMemberEmpNo(request)%>');">
                    <i class="fa fa-male"></i> 개인정보변경
                  </a>
                </li>
                <%if(SessionUtil.getRoleCd(request)!=null && SessionUtil.getRoleCd(request).equals("A")) {%>
                <li>
                  <a href="/backend">
                    <i class="fa fa-laptop"></i> Backend Office
                  </a>
                </li>
                <%}%>
                <li>
                  <a href="/logout">
                    <i class="fa fa-sign-out"></i> Log Out
                  </a>
                </li>
              </ul>
            </li>
          </ul>
        </li>
        <!-- Control Sidebar Toggle Button -->
<!--         <li> -->
<!--           <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a> -->
<!--         </li> -->
      </ul>
    </div>
  </nav>
<%} else {%>
  
	<a href="/backend/" class="logo">
    <span class="logo-mini"><b>S</b>BD</span>
    <span class="logo-lg"><b>Set</b>Backend</span>
  </a>
  
  <nav class="navbar navbar-static-top">
    <a href="#" id="menu_toggle" class="sidebar-toggle" data-toggle="push-menu" role="button">
      <span class="sr-only">Toggle navigation</span>
    </a>
    
    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav">
      	<li>
          <a href="/"><i class="fa fa-get-pocket"></i> Front End</a>
        </li>
      </ul>
    </div>
  </nav>
<%}%>
	
	<div class="modal fade" id="modal_message" tabindex="-1" role="dialog" data-backdrop="static">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_message_title">Title</h4>
        </div>
        <div class="modal-body" id="modal_message_body">
          <p>Body</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-sm btn-warning" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="modal_confirm" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_confirm_title">Title</h4>
        </div>
        <div class="modal-body" id="modal_confirm_body">
          <p>Body</p>
        </div>
        <div class="modal-footer">
          <button type="button" id="btn_modal_confirm_true" name="btn_confirm_ok" class="btn btn-sm btn-warning">OK</button>
          <button type="button" id="btn_modal_confirm_false" class="btn btn-sm btn-default" data-dismiss="modal">Cancel</button>
        </div>
      </div>
      <input type="hidden" id="modal_confirm_result" name="modal_confirm_result" />
    </div>
  </div>
</header>
<script>
function fnLoadProfile(p_member_no){
	alert("사원번호 : " + p_member_no);
}
</script>