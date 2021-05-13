<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.SessionUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
String fb_div = (String) request.getAttribute("fb_div");
String lang = SessionUtil.getMemberLang(request);
String role_cd = SessionUtil.getRoleCd(request);
String role_nm = SessionUtil.getRoleNm(request);
String member_id = SessionUtil.getMemberId(request);
if(member_id!=null && !member_id.equals("")){
String member_nm = SessionUtil.getMemberNm(request);
String member_vdr_idx = SessionUtil.getMemberVdrIdx(request);

String company_cd = SessionUtil.getCompanyCd(request);
String member_division = SessionUtil.getMemberDivision(request);
%>

<header class="main-header">

<%if(fb_div != null && fb_div.equals("F")) {%>
 
   <a href="/" class="logo" style="padding-left: 0px; padding-right: 0px;">
 <!--     <span class="logo-lg"><img src="/res/images/common/setlog.png"  align-items: center; justify-content: center; width="200" height="100"></span> 
 -->  
  <!-- <span class="logo-lg"><img src="/res/images/common/setlog.png" 
  style=" overflow: hidden; display: flex;  width: 100%; height: 80%;" ></span> --> 
  <span class="logo-lg"><img src="/res/images/common/setlog2.png" 
  style=" overflow: hidden; width: 70%; height: 80%;" ></span> 
<!-- 	    <span class="logo-mini"><b>S</b> MES</span>
	    <span class="logo-lg"><b>SET</b> MES</span> -->
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
                    <i class="fa fa-male"></i>  개인정보변경 
                  </a>
                </li>
                <%if(role_cd.equals("A") ) {%>
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
      </ul>
    </div>
  </nav>
<%} else {%>
	<a href="/backend/" class="logo">
    <span class="logo-mini"><b>SET</b>BD</span>
    <span class="logo-lg"><b>Semiconductor Equipment Technology</b>Backend</span>
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
  
  <div class="modal fade" id="modal_profile" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_profile_title">개인정보</h4>
        </div>
        <div class="modal-body" id="modal_profile_body">
          <div class="row">
        		<div class="col-md-12">
        			<div class="box">
        				<div class="box-header with-border">
        					비밀번호 변경 update
	        				<div class="box-tools pull-right" style="min-height: 40px;">
				  					<button type="submit" id="btn_modal_profile_pwd_change" class="btn btn-danger btn-sm">Update</button> 
				  					<button type="button" id="btn_modal_profile_close" class="btn btn-sm btn-default" data-dismiss="modal">Cancel</button>
				          </div>
        				</div>
        				<div class="box-body">
		            	<form id="frm_member_pwd" name="frm_member_pwd">
		            		<input type="hidden" id="p_member_no"	name="member_emp_no" value="" />
		            		<div class="row">
		            			<div class="col-sm-6">
							   				<div class="form-group">
					                <label>부서</label>
					                <input type="hidden" id="p_member_division" name="member_division" value="<%=SessionUtil.getMemberDivision(request)%>" />
					                <input type="input" id="p_dept_nm" name="dept_nm" class="form-control" value="<%=SessionUtil.getDeptNm(request)%>" placeholder="소속" maxlength="10" readonly="readonly">
					              </div>
			                </div>
			                <div class="col-sm-6">
							   				<div class="form-group">
					                <label>계정</label>
					                <input type="input" id="p_member_id" name="member_id" class="form-control" value="<%=SessionUtil.getMemberId(request)%>" placeholder="Account ID" maxlength="10" readonly="readonly">
					              </div>
			                </div>
			              </div>
			              <div class="row">
				            	<div class="col-sm-6">
							   				<div class="form-group">
					                <label>이메일</label>
					                <input type="input" id="p_member_email" name="member_email" class="form-control" value="<%=SessionUtil.getMemberEmail(request)%>" placeholder="Account Email" maxlength="10" readonly="readonly">
					              </div>
			                </div>
			                <div class="col-sm-6">
							   				<div class="form-group">
					                <label>사용자명</label>
					                <input type="input" id="p_member_nm" name="member_nm" class="form-control" value="<%=SessionUtil.getMemberNm(request)%>" placeholder="Account Name" maxlength="10" readonly="readonly">
					              </div>
			                </div>
			              </div>
			              <hr/>
			              <div class="row">
			                <div class="col-sm-12">
							   				<div class="form-group">
					                <label>현재 비밀번호</label>
					                <input type="password" id="p_member_pwd" name="p_member_pwd" class="form-control" placeholder="Current Password" maxlength="30" required>
					              </div>
			                </div>
			              </div>
			              <div class="row">
			                <div class="col-sm-12">
							   				<div class="form-group">
					                <label>신규 비밀번호 (6 자리이상)</label>
					                <input type="password" id="p_member_new_pwd" name="p_member_new_pwd" class="form-control" placeholder="New Password" minlength="6" maxlength="30" required>
					              </div>
			                </div>
			              </div>
			              <div class="row">
			                <div class="col-sm-12">
							   				<div class="form-group">
					                <label>신규 비밀번호 re-check (6 자리이상)</label>
					                <input type="password" id="p_member_new_pwd_check" name="p_member_new_pwd_check" class="form-control" placeholder="New Password re-check" minlength="6"  maxlength="30" required>
					              </div>
			                </div>
			              </div>
			            </form>
			          </div>
        			</div>
        		</div>
        	</div>
        </div>
      </div>
      
    </div>
  </div>
</header>
<script>
var s_member_id = "<%=member_id%>";
var role_cd = "<%=role_cd%>";

var company_cd = "<%=company_cd%>";
var member_division = "<%=member_division%>";

$(function($) {
	fnLoadCheckInitPassword();
 
	
	$("#btn_modal_profile_pwd_change").on("click", function(e){
		e.preventDefault();
		fnPwdChange();
	});
	
 
})

function fnLoadCheckInitPassword(){
	  // console.log("flow log : getPersonalInfo() : " + getPersonalInfo());
	if(getPersonalInfo() != "1") {
		var page_url = "/personal_info";
		var postData = "member_id=" + encodeURIComponent(s_member_id);
		
		$.ajax({
	  	url: page_url,
	    type: "POST",
	    data: postData,
	    async: false,
	    success:function(data, textStatus, jqXHR){
	    	if(data.result == "200") {
	    		if(data.info != null){
	    			if(data.info.init_yn == "Y") {
		    			fnLoadProfile(data.info.member_emp_no);	
		    		}
	    		}else{
	    			// console.log("Now UserInfo is NULL :: Check > fnLoadCheckInitPassword() / Search xml file > selectMemberInfo");
	    		}
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    	fnMessageModalAlert("Notification", "사용자 정보로딩 실패");
	    },
	    complete: function() {
	    	setSavePersonalInfo("personal_init_" + s_member_id, "1", 1);
	    }
	  });
	}
}

 

function setSavePersonalInfo(name, value, expiredays) {
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";"
}

function getPersonalInfo(){
	var cook = document.cookie + ";";
	var idx = cook.indexOf("personal_init_" + s_member_id, 0);
	var val = "";

	if(idx != -1) {
		cook = cook.substring(idx, cook.length);
		begin = cook.indexOf("=", 0) + 1;
		end = cook.indexOf(";", begin);
		val = unescape(cook.substring(begin, end));
	}
	return val;
}

function fnPwdChange() {
	if($.trim($("#p_member_pwd").val()).length == 0) {
		fnMessageModalAlert("알림", "비밀번호를 입력하세요.");
		return;
	}
	if($.trim($("#p_member_new_pwd").val()).length == 0) {
		fnMessageModalAlert("알림", "새 비밀번호를 입력하세요.");
		return;
	}
	if($.trim($("#p_member_new_pwd").val()) != $.trim($("#p_member_new_pwd_check").val())) {
		fnMessageModalAlert("알림", "새 비밀번호와 새 비밀번호 확인의 비밀번호가 다릅니다.");
		return;
	}
	if($.trim($("#p_member_pwd").val()) == $.trim($("#p_member_new_pwd").val())) {
		fnMessageModalAlert("알림", "현재비밀번호와 새비밀번호는 다르게 설정해야 합니다.");
		return;
	}
	if($.trim($("#p_member_new_pwd").val()).length < 6) {
		fnMessageModalAlert("알림", "비밀번호는 6자리 이상으로 설정하세요.");
		return;
	}
	
	var page_url = "/pwd_change";
	var postData = "member_email=" + encodeURIComponent($.trim($("#p_member_email").val()));
	postData += "&member_pwd=" + encodeURIComponent($.trim($("#p_member_pwd").val()));
	postData += "&member_new_pwd=" + encodeURIComponent($.trim($("#p_member_new_pwd").val()));
	
	$.ajax({
  	url: page_url,
    type: "POST",
    data: postData,
    async: false,
    success:function(data, textStatus, jqXHR){
    	if(data.result == "200") {
    		fnMessageModalAlert("Notification", "비밀번호를 변경했습니다.");
    		$('#modal_profile').modal('hide');
    	} else if(data.result == "204") {
    		fnMessageModalAlert("Notification", "현재 비밀번호를 다시 설정해주세요.");
    	} else {
    		fnMessageModalAlert("Notification", "비밀번호 변경처리에 에러가 발생했습니다.");
    	}
    },
    error: function(jqXHR, textStatus, errorThrown){
    	fnMessageModalAlert("Notification", "비밀번호 변경처리에 에러가 발생했습니다.");
    },
    complete: function() {
    }
  });
}
</script>

<%}else{%>
<script>
alert("로그인 세션이 만료되었습니다. 다시 로그인하여 주십시오");
window.self.location = "/";
</script>
<%}%>