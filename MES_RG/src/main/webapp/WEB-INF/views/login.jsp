<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
 String sUserID = request.getParameter("sUserID")==null?"":request.getParameter("sUserID");  
  
 String logout_check = (String) request.getAttribute("logout");
 String member_emp_no = SessionUtil.getMemberEmpNo(request);
 
 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<title>[SET,INC] MES-SC</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-type" content="text/html; charset=utf-8">

<script src="/res/plugins/jQuery/jquery-3.1.1.min.js"></script>

<link href="/res/bootstrap/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="/res/set/css/login.css" type="text/css">

<script type="text/javascript">
</script>

</head>

<body>
	<div class="container">
		<div class="col-md-10 col-sm-offset-2 main">
			
			<!--col-sm-6-->
			<div class="col-sm-6 left-side">
			</div>
		
			<div class="col-sm-6 right-side">
  			<!-- 	<img src="/res/images/common/setlog.png"> -->
				<h6>Sign In</h6>
		
				<!--Form with header-->
				<div class="form">
					<div class="form-group">
						<label for="form2">User ID</label>
				        <input type="text" id="member_emp_no" name="member_emp_no" class="form-control-login" placeholder="ID" required="" autofocus/>
					</div>
					
					<div class="form-group">
						<label for="form4">Password</label>
				        <input type="password" id="member_pwd" name="member_pwd"  class="form-control-login"  placeholder="Password" required=""/>    
					</div>
				        
					<label class="anim">
						<input type="checkbox" id="cb_userid_save" name="cb_userid_save" class="chkbox" >
						<span> Remember me</span> 
					</label>   
				
				    <div class="text-xs-center">
				    	<input type="submit" id="btn_login" name="btn_login" class="btn btn-login float-center  " value="Login">  
					</div>
				</div>
				
				<!--/Form with header-->	
				<div class="contact">
					<table class="contact_item">
						<tr>
							<td>Contact</td>
						</tr>
					 
						<tr>
							<td>유지보수</td>
							<td>:&nbsp;</td>
							<td>최상현</td>
							<td>&nbsp;이사 (010-7444-4404)</td>
						 
						</tr>
					</table>
				</div>
			</div><!--col-sm-6-->
        </div><!--col-sm-8-->
	</div><!--container-->
	<p>Copyrightⓒ 2020 SET,Inc All right reserved.</p>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
	
	<!-- //main --> 
<script src="/res/plugins/iCheck/icheck.min.js"></script>


<!-- jQuery 3.1.1 -->
<script src="/res/plugins/jQuery/jquery-3.1.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/res/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="/res/plugins/iCheck/icheck.min.js"></script>

<script src="/res/set/setCS.js?v=<%=System.currentTimeMillis()%>"></script>

 
<script>
$(function () {
	 
	/* 	$('input').iCheck({
			checkboxClass: 'icheckbox_square-grey',
			radioClass: 'iradio_square-grey',
			increaseArea: '20%' // optional
		}); */
		
		$("#cb_userid_save").iCheck('check');
		
		var sUserID = "<%=sUserID%>";
		$("#member_emp_no").val(sUserID);
		if( nullToBlank(sUserID)!='' )
			fnLoginProcessAuto();
	 	  
		var cookie_user_id = getLoginInfo(); 
		if(cookie_user_id != "") {
			//$("#member_email").val(cookie_user_id);
			$("#member_emp_no").val(cookie_user_id);
//	 		$("#cb_userid_save").attr("checked", true);
		}
	});

	//you don't need this, just used for changing background
	jQuery(function($) {
		$("#member_emp_no, #member_pwd").pressEnter(function(e) {
			e.preventDefault();
			fnLoginProcess();
		});
		
		$('#btn_login').on('click', function(e) {
			e.preventDefault();
			fnLoginProcess();
		});
	});

	function fnLoginProcess() {
//	 	console.log('fnLoginProcess()');
		if($.trim($("#member_emp_no").val()).length == 0) {
			fnMessageModalAlert("로그인 알림", "사번정보를 입력하세요.");
			return;
		}
		
		if($.trim($("#member_pwd").val()).length == 0) {
			fnMessageModalAlert("로그인 알림", "패스워드를 입력하세요.");
			return;
		}
		
		if($("#cb_userid_save").is(":checked")){ // 저장 체크시
			saveLoginInfo($("#member_emp_no").val());
		} else { // 체크 해제시는 공백
			saveLoginInfo("");
		}
		
		var formURL = "/login_process";
		var postData = "member_emp_no=" + encodeURIComponent($.trim($("#member_emp_no").val()))
					 + "&member_pwd=" + encodeURIComponent($.trim($("#member_pwd").val()))
					 + "&use_yn=" + encodeURIComponent("Y");
		
		$.ajax({
		  	url : formURL,
		    type : "POST",
		    data : postData,
		    async : false,
		    success:function(data, textStatus, jqXHR){
		    	if(data.result == "200") {
		    		var url = "/";
	 
		    		$(location).attr('href',url);
		    	} else {
		    		fnMessageModalAlert("Notification(Login)", data.message);
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(Login)", "로그인처리에 에러가 발생했습니다.");
		    },
		    complete: function() {}
		});
	}
	/* 
	function fnChkUser(memberId) {
//	 	console.log('fnChkUser()');
		var page_url = "/frontend/scm/checkVenderMember";
		var params = "member_emp_no="+encodeURIComponent(memberId);
		var returnVal = '';
		$.ajax({
			url : page_url,
			data : params,
			type : 'POST',
			async : false,
			dataType : 'json',
			success: function( data ) {
				if(data.status == 200) {
					returnVal = data.result;
//	 				var dept_cd = data.result;
//	 				if( data.result=='1063') lifnr = memberId;
//	 				else lifnr = '';
				}
			},
			complete: function () {}
		});
		return returnVal;
	}
	 */
	function saveLoginInfo(id) {
		if(id != "") {
			// userid 쿠키에 id 값을 30일간 저장
			setSaveInfo("userid", id, 30);
			// setSaveInfo("lang", id, 30);
		} else {
			// userid 쿠키 삭제
			setSaveInfo("userid", id, -1);
			// setSaveInfo("lang", id, -1);
		}
	}

	function setSaveInfo(name, value, expiredays) {
		var today = new Date();
		today.setDate( today.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";"
	}

	function getLoginInfo(){
//	 	console.log('getLoginInfo()');
		var cook = document.cookie + ";";
		var idx = cook.indexOf("userid", 0);
		var val = "";
		
		if(idx != -1) {
			cook = cook.substring(idx, cook.length);
			begin = cook.indexOf("=", 0) + 1;
			end = cook.indexOf(";", begin);
			val = unescape(cook.substring(begin, end));
		} else {
			fnMessageModalAlert("Notification(Login)", "no Session info.");
		}
		return val;
	}


	function fnLoginProcessAuto(){
	 
		if($.trim($("#member_emp_no").val()).length == 0) {
			fnMessageModalAlert("Alert", "사원정보를 입력하세요.");
			return;
		}
		
		var formURL = "/login_process_auto";
	 
		var postData = "member_emp_no=" + encodeURIComponent($.trim($("#member_emp_no").val()))
					 + "&member_pwd=" + encodeURIComponent($.trim($("#member_pwd").val()))
					 + "&use_yn=" + encodeURIComponent("Y");
		
		$.ajax({
		  	url : formURL,
		    type : "POST",
		    data : postData,
		    async : false,
		    success:function(data, textStatus, jqXHR){
		    	if(data.result == "200") {
		    		var url = "/";    
		    		$(location).attr('href',url);
		    	} else {
				 fnMessageModalAlert("Notification(Login)", data.message);
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("Notification(Login)", "로그인처리에 에러가 발생했습니다.");
		    },
		    complete: function() {}
	  });
	}

	</script>
	</body>
	</html>
