<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title> <%=pageTitle %> </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true"> 
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	</style>
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1012" />
		<jsp:param name="selected_menu_cd" value="1020" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        거래처 관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">거래처 관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
				<!-- Progress Bar 
				 	<div id="hiddenDivLoading" style="visibility:hidden">
					다중 코드 입력 창 iframe 
					    <iframe id="iframeLoading" frameborder="0" style="z-index:-1; position:absolute; visibility:hidden"></iframe>
 					        <div id='load_List'><img src='/img/loading.gif' /></div>
						
 					</div> -->
					<!-- Progress Bar -->

					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						   	<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertAccount();">등록</button>
					     	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="updateAccount();">수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteAccount();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>Business</label>
									 <select id="business" name="business" class="form-control" style="height: 30px;" >
									 	<!-- <option value="ALL" selected="selected">전체</option> 
									 	<option value="business1">business1</option>
									 	<option value="business2">business2</option>
									 	<option value="business3">business3</option> -->
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>거래처명</label> 
									  <input type="combo" id="account_nm" name="account_nm" class="form-control input-sm" placeholder="거래처명" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="account_nm" name="account_nm" class="form-control input-sm" placeholder="거래처명" -->
<!-- 										maxlength="15" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>거래처코드</label> 
									  <input type="combo" id="account_code" name="account_code" class="form-control input-sm" placeholder="거래처코드" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									<input type="text" id="account_code" name="account_code" class="form-control input-sm" placeholder="거래처코드" -->
<!-- 										maxlength="10" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
								</div>
							</div>
							
							
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 620px;"></div> 
							</div>
							
						</div>
					</div>
				</div>
				<!-- <div id="grid_list" style="width: 100%; height: 620px;"></div> -->
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<input type="hidden" id="fg_check_yn" name="fg_check_yn" value="N">
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">Business</label>
							<div class="col-sm-7">
								<select class="form-control input-sm" id="m_business" name="m_business" >
								 	<!-- <option value="business1">business1</option>
								 	<option value="business2">business2</option>
								 	<option value="business3">business3</option> -->
								</select>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처코드</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right" id="m_account_code" maxlength="100">
							</div>
							<div class="col-sm-3">
		                  		<button type="button" id="btn_check" class="btn btn-primary btn-sm">거래처코드 중복체크</button>
		                   </div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_account_nm" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_address" value="" maxlength="100">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telf" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telfx" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_email_address" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_business_reg_num" maxlength="100">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAccount();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->

<script type="text/javascript">
var startValue_combo = "";

comboValue_nm = new Array;
comboValue_cd = new Array;

	$(function($) {
	 	
		fnBusiness('');
	 	fnBusiness('m_');
	 	
		fnLoadCommonOption(); 	 
	 	fnLoadCompanyGrid();
	 	
	 	
	})
	
	function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		
		$('#request_date_range').daterangepicker({
			opens: 'right', 
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
		});
	}
	
	function fnLoadCompanyGrid(){
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
				{ field:'business_code', caption:'Business Code', size:'10%', style:'text-align:center', hidden: true}, 
				{ field:'business_nm', caption:'Business', size:'10%', style:'text-align:center' , sortable: true}, 
				{ field:'account_code', caption:'거래처코드', size:'7%', style:'text-align:center' , sortable: true}, 
				{ field:'account_nm', caption:'거래처명', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'address', caption:'주소', size:'17%', style:'text-align:center', sortable: true},
				{ field:'telf', caption:'전화번호', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'telfx', caption:'팩스', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'email_address', caption:'이메일', size:'8%', style:'text-align:center', sortable: true},
				{ field:'business_reg_num', caption:'사업자번호', size:'7%', style:'text-align:center', sortable: true},
				{ field:'creator_nm', caption:'등록자', size:'5%', style:'text-align:center', sortable: true},
				{ field:'updater_nm', caption:'수정자', size:'5%', style:'text-align:center', sortable: true},
				{ field:'creator', caption:'등록자', size:'5%', style:'text-align:center', sortable: true, hidden:true},
				{ field:'updater', caption:'수정자', size:'5%', style:'text-align:center', sortable: true, hidden:true}
				], 
			sortData: [{field: 'account_code', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	
	$("#m_account_code").change(function(){
		$("#fg_check_yn").val("N");
	});
	
	$("#business").change(function(){
		loadList();
	});
	
	$( "#btn_check" ).on('click', function(e) {
		e.preventDefault();
		if($.trim($("#m_account_code").val()).length == 0) {
			fnMessageModalAlert("알림", "거래처코드를 입력하세요.");
			return;
		}
		
		/* if($.trim($("#m_member_id").val()).length < 3) {
			fnMessageModalAlert("Notification(Organ)", "거래처코드는 3자리이상을 입력하세요.");
			return;
		} */
		fnCheckAccount();
	});
	
	function fnCheckAccount(){
		var account_code = $("#m_account_code").val();
		var postData = "account_code="+encodeURIComponent(account_code);
	  var formURL = "/info/account/checkAccount";
	  
	  $.ajax({
	      url : formURL,
	      type: "POST",
	      data : postData,
	      success:function(data, textStatus, jqXHR){
	      	if(data.status == "200") {
	      		if(data.cnt > 0) {
	      			$("#fg_check_yn").val("N");
	      			fnMessageModalAlert("알림", "입력하신 거래처 코드는 사용할 수 없습니다.(이미 사용중)");
	      		} else {
	      			$("#fg_check_yn").val("Y");
	      			fnMessageModalAlert("알림", "입력하신 거래처 코드는 사용할 수 있습니다.");
	      		}
	      	} else {
	      		fnMessageModalAlert("알림", "입력하신 거래처 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
	      	}
	      },
	      error: function(jqXHR, textStatus, errorThrown){
	        fnMessageModalAlert("알림", "입력하신 거래처 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
	      }
	  });
	}
	
	function loadList() {
		console.log("loadList()");
		
		var page_url = "/info/account/selectAccount";
		var postData = "account_code=" + encodeURIComponent($("#account_code").val())
			 + "&account_nm=" + encodeURIComponent($("#account_nm").val());
		
		if( $("#business option:selected").val() != "ALL") {
			postData += "&business_code=" + encodeURIComponent($("#business option:selected").val());
			postData += "&business_codeT=" + "";
			if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
				postData +=  encodeURIComponent("MD1282");	
			} 
		} else {
			postData += "&business_code=" + encodeURIComponent("");
		}
		
		w2ui['grid_list'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				comboValue_cd = new Array;
				comboValue_nm = new Array;
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						if (startValue_combo == "") {
							comboValue_nm.push(row.account_nm ? row.account_nm+'' : '');
							comboValue_cd.push(row.account_code ? row.account_code+'' : '');
						}
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#account_nm').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#account_code').w2field('combo', { items: comboValue_cd, match : 'contains' });
					}
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {
				startValue_combo = ":)";
			}
		});
		
	}
	
	function fnBusiness(val){
		console.log("fnBusiness("+val+")");
		
		initOptions($('#'+val+'business')); // select 박스 초기화
		
		var strUrl = "/info/codeDetail/selectCdD";
		var postData = "master_code=" + encodeURIComponent("MC1012");
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    dataType: 'json', 
		    async : false, // 다 끝나고 다음 처리 해!
		    success:function(data, textStatus, jqXHR){
		    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
		    		rowArr = data.rows;
		    		
		    		if(val != "m_")
		    			$("#"+val+"business" ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						if( val == "" && row.detail_code == "MD1282" ) {
							
						} else {
							$("#"+val+"business" ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						}
					});
					
		 			$("#"+val+"business option:eq(0)").prop("selected", true);	 			
			 		
		 			/* } else {
		 				$("#companyBox").val("All").prop("selected", true);
		 			} */
			 		
		 		/* 	vavaa = $("#business option:selected").val();
		 			console.log("selectBox = " +  vavaa );
		 			console.log("selectBox2 = " +  $("#business option:selected").text() );
		 		 */	
		 			//$("#companyBox").val(""+company_code).prop("selected", true);
		 			
		    	} else if(data.status == "200" && (data.rows).length==0 ) {
		    		initOptions($('#'+val+'business')); // select 박스 초기화
		    		
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    }
		});
		
	}
	
	
	// modal 띄우기 
	function insertAccount() {
		console.log('insertAccount()');
	
		/* $("#modal_info > .input-sm").val(''); */
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('등록');
 		$("#m_account_code").attr('disabled',false);
 		$("#btn_check").show();
 		$("#fg_check_yn").val("N");
 		
 		$("#m_account_code").val('');
		$("#m_account_nm").val('');
		$("#m_address").val('');
		$("#m_telf").val('');
		$("#m_telfx").val('');
		$("#m_email_address").val('');
		$("#m_business_reg_num").val('');

		$("#m_business option:eq(0)").prop("selected", true);	 			
	
		$("#modal_info").modal('show');
	
	}
	
	function updateAccount() {
		console.log('updateAccount()');
		
		/* $("#modal_info > .input-sm").val(''); */
		
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			var data = w2ui.grid_list.get(key[0]);
			$("#m_account_code").attr('disabled',true);
			
			$("#btn_check").hide();
			$("#fg_check_yn").val("Y");
			
			$("#m_account_code").val(data.account_code);
			$("#m_account_nm").val(data.account_nm);
			$("#m_address").val(data.address);
			$("#m_telf").val(data.telf);
			$("#m_telfx").val(data.telfx);
			$("#m_email_address").val(data.email_address);
			$("#m_business_reg_num").val(data.business_reg_num);
			$("#m_business").val(data.business_code).prop("selected", true);
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveAccount() {
		console.log('saveAccount()');
		
		var account_code = $("#m_account_code").val();
		var account_nm = $("#m_account_nm").val();
		var address = $("#m_address").val();
		var telf = $("#m_telf").val();
		var telfx = $("#m_telfx").val();
		var email_address = $("#m_email_address").val();
		var business_reg_num = $("#m_business_reg_num").val();
		var business_code = $("#m_business option:selected").val();
		var business_nm = $("#m_business option:selected").text();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
		} else if (key.length == 1){
			flag = "U";
		}
		
// 		if(flag=="I" && !chkSubmit($("#m_account_code"), "거래처코드를")) return;
		if($("#fg_check_yn").val() == "N") {
			fnMessageModalAlert("알림", "거래처코드 중복체크를 확인하세요.");
			return;
		} else if(flag=="I" && !chkSubmit($("#m_account_code"), "거래처코드를")) return;
		
		
		if(flag=="I" && !chkSubmit($("#m_account_nm"), "거래처명을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_address"), "주소를")) return; 
		
// 		if(flag=="I" && !chkSubmit($("#m_telf"), "전화번호를")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_telfx"), "팩스를")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_email_address"), "이메일을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_business_reg_num"), "사업자번호를")) return;
		
		// var flag = nullToBlank(account_code)==''?"I":"U";
		console.log("flag = " + flag);
		
// 		console.log( "account_code = " + $("#m_account_code").val() );
// 		console.log( "account_nm = " +$("#m_account_nm").val() );
// 		console.log( "address = " +$("#m_address").val() );
// 		console.log( "telf = " +$("#m_telf").val() );
// 		console.log( "telfx = " +$("#m_telfx").val() );
// 		console.log( "email_address = " +$("#m_email_address").val() );
// 		console.log( "business_reg_num = " +$("#m_business_reg_num").val() );
// 		console.log( "business code = " +$("#m_business option:selected").val() );
// 		console.log( "business name = " +$("#m_business option:selected").text() );
		
		$("#modal_info").modal('hide');
		
		var strUrl = "/info/account/saveAccount";
		var postData = "flag=" + flag
				+ "&account_code=" + encodeURIComponent(account_code)
				+ "&account_nm=" + encodeURIComponent(account_nm)
				+ "&business_code=" + encodeURIComponent(business_code)
				+ "&business_nm=" + encodeURIComponent(business_nm)
				+ "&address=" + encodeURIComponent(address)
				+ "&telf=" + encodeURIComponent(telf)
				+ "&telfx=" + encodeURIComponent(telfx)
				+ "&email_address=" + encodeURIComponent(email_address)
				+ "&business_reg_num=" + encodeURIComponent(business_reg_num);
				 
		// escape(
		
		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	startValue_combo = "";
			    	loadList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
		    }
		});
	}
	
	function deleteAccount() {
		console.log('deleteAccount()');
	
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {
 
			var data = w2ui.grid_list.get(key[0]);
			var code = data.account_code;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/account/deleteAccount";
					var postData = "account_code=" + code;
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		console.log(data);
						 		startValue_combo = "";
						 		loadList();
						    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
						 	}
						 },
						 error: function(jqXHR, textStatus, errorThrown){
						    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
						 },
						 complete: function() {
						 }
					});
					
				}
			});
		} 
	}
	
	//엑셀 1024
	function excelFileDownload()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;

		var fileName = '거래처 관리.xlsx';
		var sheetTitle = '거래처 관리';
		var sheetName = '거래처 관리';
		
		var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
		var is_rownum = true;
		
		if(gridCols != null && gridCols.length > 0){
			for(var i=0; i<gridCols.length; i++){
	 			if(!gridCols[i].hidden){
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width==undefined?"10":(gridCols[i].width).replace('px','')) + ",";
	 			}
			}
			param_col_name = param_col_name.substr(0, param_col_name.length -1);
			param_col_id = param_col_id.substr(0, param_col_id.length -1);
			param_col_align = param_col_align.substr(0, param_col_align.length -1);
			param_col_width = param_col_width.substr(0, param_col_width.length -1);
		}


		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name="+encodeURIComponent(fileName);
			export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
			export_data += "&sheet_name="+encodeURIComponent(sheetName);
			export_data += "&header_col_names="+encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
			export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));
		
		$.ajax({
		  url:export_url,
		  data:export_data,
		  type:'POST',
		  dataType: 'json',
		  success: function( data ) {
		  	if(data.status == 200) {
		  		var file_path = data.file_path;
		  		var file_name = data.file_name;
		  		var protocol = jQuery(location).attr('protocol');
	  			var host = jQuery(location).attr('host');
	  			var link_url = "/file/attach_download";
	  			link_url += "?file_path="+encodeURIComponent(file_path);
	  			link_url += "&file_name="+encodeURIComponent(file_name);
	  			
	  			$(location).attr('href', link_url);
		  	}
		  },
			complete: function () {}
		});
	}
	
	// 미 입력시
	function chkSubmit(item, msg){
		if(item.val().replace(/\s/g,"")==""){
			fnMessageModalAlert("알림", msg+ " 입력해 주세요.");
			item.val("");
			item.focus();
			return false;
		} else {
			return true;
		}
	}
	
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
//		    .append('<option value="All">-----</option>')
	    .val();
	}
</script>

</body>
</html>