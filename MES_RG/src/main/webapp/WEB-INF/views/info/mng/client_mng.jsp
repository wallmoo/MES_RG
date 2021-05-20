<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <title> <%=pageTitle %> </title>
  
	<jsp:include page="/common/header_inc" flush="true"> 
		<jsp:param name="page_title" value="0" />
	</jsp:include>
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
		<jsp:param name="selected_menu_cd" value="1112" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>고객사 관리 <small>기준정보관리</small></h1>
      <ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li>
		<li class="active">고객사 관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						   	<button type="button"  class="btn btn-primary btn-sm" onclick="excelFileDownload('grid_list','고객사 관리');">엑셀다운로드</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="showIU_modal();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteAccount();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div  class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									 <label>고객사명</label> 
									  <input type="combo" id="S_CST_NM" name="S_CST_NM" class="form-control input-sm" placeholder="고객사명" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
								</div>
							</div>
							
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 620px;"></div> 
							</div>
						</div>
					</div>
				</div>
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
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="CST_IDX" maxlength="100" readonly="readonly">
							</div>
						</div>
					</div>
									
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="CST_NM" maxlength="30">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="CST_NO" maxlength="20">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업장</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="CST_PLC" maxlength="10">
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="CST_ADD" value="" maxlength="60">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="CST_TEL" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="CST_FAX" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일#1</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="CST_ML1" maxlength="60">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일#2</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="CST_ML2" maxlength="60">
							</div>
						</div>
					</div>
										
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일#3</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="CST_ML3" maxlength="60">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">URL</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="CST_HP" maxlength="50">
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
					<button type="button"  class="btn btn-success btn-sm" onclick="saveAccount();">저장</button>
					<button type="button"  class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
	$(function($) {
		fnLoadCompanyGrid();
	})
	function fnLoadCompanyGrid(){
		console.log("fnLoadCompanyGrid()");
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
	        	{ field:'cst_IDX', caption:'고객사코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'cst_NM', caption:'고객사명', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'cst_PLC', caption:'사업장', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'cst_ADD', caption:'주소', size:'17%', style:'text-align:center', sortable: true},
				{ field:'cst_TEL', caption:'전화번호', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'cst_FAX', caption:'팩스', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'cst_ML1', caption:'이메일#1', size:'8%', style:'text-align:center', sortable: true},
				{ field:'cst_ML2', caption:'이메일#2', size:'8%', style:'text-align:center', sortable: true},
				{ field:'cst_ML3', caption:'이메일#3', size:'8%', style:'text-align:center', sortable: true},
				{ field:'cst_NO', caption:'사업자번호', size:'7%', style:'text-align:center', sortable: true}
				], 
			sortData: [{field: 'cst_IDX', direction: 'DESC'}],
			records: [],	//
			onReload: function(event) {},
			onClick: function (event) {}
		});
		loadList();
	}
	
	function loadList() {
		console.log("loadList()");
		
		var rowArr = [];
		var page_url = "/info/account/selectClient";
		var postData = "CST_NM=" + encodeURIComponent($("#S_CST_NM").val());

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
					});
					
					w2ui['grid_list'].records = rowArr;
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {

			}
		});
	}
	
	//등록/수정 모달 생성
	function showIU_modal() {
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			insertAccount();
		} else  if( key.length==1 ) {	
			updateAccount();	
		}
	}		
	// 등록 modal 띄우기 
	function insertAccount() {
		console.log('insertAccount()');
	
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('등록');
 		
		$("#CST_IDX").val('');
 		$("#CST_NM").val('');
		$("#CST_PLC").val('');
		$("#CST_ADD").val('');
		$("#CST_TEL").val('');
		$("#CST_FAX").val('');
		$("#CST_ML1").val('');
		$("#CST_ML2").val('');
		$("#CST_ML3").val('');
		$("#CST_HP").val('');
		$("#CST_NO").val('');

		$("#modal_info").modal('show');
	}
	//수정 modal 띄우기
	function updateAccount() {
		console.log('updateAccount()');
			
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			
			var data = w2ui.grid_list.get(key[0]);			
			
			$("#CST_IDX").val(data.cst_IDX);
			$("#CST_NM").val(data.cst_NM);
			$("#CST_PLC").val(data.cst_PLC);
			$("#CST_ADD").val(data.cst_ADD);
			$("#CST_TEL").val(data.cst_TEL);
			$("#CST_FAX").val(data.cst_FAX);
			$("#CST_ML1").val(data.cst_ML1);
			$("#CST_ML2").val(data.cst_ML2);
			$("#CST_ML3").val(data.cst_ML3);
			$("#CST_HP").val(data.cst_HP);
			$("#CST_NO").val(data.cst_NO);
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
	}
	//계정 저장
	function saveAccount() {
		console.log('saveAccount()');
		
		var CST_IDX = $("#CST_IDX").val();
		var CST_NM = $("#CST_NM").val();
		var CST_PLC = $("#CST_PLC").val();
		var CST_ADD = $("#CST_ADD").val();
		var CST_TEL = $("#CST_TEL").val();
		var CST_FAX = $("#CST_FAX").val();
		var CST_ML1 = $("#CST_ML1").val();
		var CST_ML2 = $("#CST_ML2").val();
		var CST_ML3 = $("#CST_ML3").val();
		var CST_HP = $("#CST_HP").val();
		var CST_NO = $("#CST_NO").val();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
			CST_IDX = 0;
		} else if (key.length == 1){
			flag = "U";
		}

		//if(flag=="I" && !chkSubmit($("#m_account_code"), "고객사코드를")) return;
		if(flag=="I" && !chkSubmit($("#CST_NM"), "고객사명을")) return;

		console.log("flag = " + flag);

		$("#modal_info").modal('hide');
		
		var strUrl = "/info/account/saveClient";
		var postData = "flag=" + flag
				+ "&CST_IDX=" + encodeURIComponent(CST_IDX)
				+ "&CST_NM=" + encodeURIComponent(CST_NM)
				+ "&CST_PLC=" + encodeURIComponent(CST_PLC)
				+ "&CST_ADD=" + encodeURIComponent(CST_ADD)
				+ "&CST_TEL=" + encodeURIComponent(CST_TEL)
				+ "&CST_FAX=" + encodeURIComponent(CST_FAX)
				+ "&CST_ML1=" + encodeURIComponent(CST_ML1)
				+ "&CST_ML2=" + encodeURIComponent(CST_ML2)
				+ "&CST_ML3=" + encodeURIComponent(CST_ML3)
				+ "&CST_HP=" + encodeURIComponent(CST_HP)
				+ "&CST_NO=" + encodeURIComponent(CST_NO);

		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)

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
	//계정 삭제
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
			var code = data.cst_IDX;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/account/deleteClient";
					var postData = "CST_IDX=" + code;
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		console.log(data);
						 		w2ui.grid_list.clear();
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

</script>

</body>
</html>