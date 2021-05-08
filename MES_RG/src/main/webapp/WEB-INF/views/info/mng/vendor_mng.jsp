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
		<jsp:param name="selected_menu_cd" value="1111" />
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
									 <label>거래처명</label> 
									  <input type="combo" id="S_VDR_NM" name="S_VDR_NM" class="form-control input-sm" placeholder="거래처명" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="VDR_NM" name="VDR_NM" class="form-control input-sm" placeholder="거래처명" -->
<!-- 										maxlength="15" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
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
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="VDR_IDX" maxlength="100" readonly="readonly">
							</div>
						</div>
					</div>
									
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="VDR_NM" maxlength="30">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="VDR_NO" maxlength="20">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">대표자</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="VDR_CEO_NM" maxlength="10">
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="VDR_ADD" value="" maxlength="60">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="VDR_TEL" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="VDR_FAX" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일#1</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="VDR_ML1" maxlength="60">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일#2</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="VDR_ML2" maxlength="60">
							</div>
						</div>
					</div>
										
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일#3</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="VDR_ML3" maxlength="60">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">URL</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="VDR_HP" maxlength="50">
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
	fnLoadCompanyGrid();
})

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
	        	{ field:'vdr_IDX', caption:'거래처코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'vdr_NM', caption:'거래처명', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'vdr_CEO_NM', caption:'대표자', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'vdr_ADD', caption:'주소', size:'17%', style:'text-align:center', sortable: true},
				{ field:'vdr_TEL', caption:'전화번호', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'vdr_FAX', caption:'팩스', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'vdr_ML1', caption:'이메일#1', size:'8%', style:'text-align:center', sortable: true},
				{ field:'vdr_ML2', caption:'이메일#2', size:'8%', style:'text-align:center', sortable: true},
				{ field:'vdr_ML3', caption:'이메일#3', size:'8%', style:'text-align:center', sortable: true},
				{ field:'vdr_NO', caption:'사업자번호', size:'7%', style:'text-align:center', sortable: true}
				], 
			sortData: [{field: 'vdr_IDX', direction: 'DESC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	
	function loadList() {
		console.log("loadList()");
		
		var page_url = "/info/account/selectVendor";
		var postData = "VDR_NM=" + encodeURIComponent($("#S_VDR_NM").val());

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
							comboValue_nm.push(row.VDR_NM ? row.VDR_NM+'' : '');
							comboValue_cd.push(row.VDR_IDX ? row.VDR_IDX+'' : '');
						}
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#VDR_NM').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#VDR_IDX').w2field('combo', { items: comboValue_cd, match : 'contains' });
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
		
	// modal 띄우기 
	function insertAccount() {
		console.log('insertAccount()');
	
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('등록');
 		
 		$("#VDR_NM").val('');
		$("#VDR_CEO_NM").val('');
		$("#VDR_ADD").val('');
		$("#VDR_TEL").val('');
		$("#VDR_FAX").val('');
		$("#VDR_ML1").val('');
		$("#VDR_ML2").val('');
		$("#VDR_ML3").val('');
		$("#VDR_HP").val('');
		$("#VDR_NO").val('');

		$("#modal_info").modal('show');
	}
	
	function updateAccount() {
		console.log('updateAccount()');
			
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			
			var data = w2ui.grid_list.get(key[0]);			
			
			$("#VDR_IDX").val(data.vdr_IDX);
			$("#VDR_NM").val(data.vdr_NM);
			$("#VDR_CEO_NM").val(data.vdr_CEO_NM);
			$("#VDR_ADD").val(data.vdr_ADD);
			$("#VDR_TEL").val(data.vdr_TEL);
			$("#VDR_FAX").val(data.vdr_FAX);
			$("#VDR_ML1").val(data.vdr_ML1);
			$("#VDR_ML2").val(data.vdr_ML2);
			$("#VDR_ML3").val(data.vdr_ML3);
			$("#VDR_HP").val(data.vdr_HP);
			$("#VDR_NO").val(data.vdr_NO);
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveAccount() {
		console.log('saveAccount()');
		
		var VDR_IDX = $("#VDR_IDX").val();
		var VDR_NM = $("#VDR_NM").val();
		var VDR_CEO_NM = $("#VDR_CEO_NM").val();
		var VDR_ADD = $("#VDR_ADD").val();
		var VDR_TEL = $("#VDR_TEL").val();
		var VDR_FAX = $("#VDR_FAX").val();
		var VDR_ML1 = $("#VDR_ML1").val();
		var VDR_ML2 = $("#VDR_ML2").val();
		var VDR_ML3 = $("#VDR_ML3").val();
		var VDR_HP = $("#VDR_HP").val();
		var VDR_NO = $("#VDR_NO").val();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
			VDR_IDX = 0;
		} else if (key.length == 1){
			flag = "U";
		}

		//if(flag=="I" && !chkSubmit($("#m_account_code"), "거래처코드를")) return;
		if(flag=="I" && !chkSubmit($("#VDR_NM"), "거래처명을")) return;
// 		if(flag=="I" && !chkSubmit($("#VDR_CEO_NM"), "대표자 이름을")) return; 			
// 		if(flag=="I" && !chkSubmit($("#VDR_ADD"), "주소를")) return; 	
// 		if(flag=="I" && !chkSubmit($("#VDR_TEL"), "전화번호를")) return;
// 		if(flag=="I" && !chkSubmit($("#VDR_FAX"), "팩스를")) return;
// 		if(flag=="I" && !chkSubmit($("#VDR_ML1"), "이메일을")) return;
// 		if(flag=="I" && !chkSubmit($("#VDR_NO"), "사업자번호를")) return;
		
		// var flag = nullToBlank(account_code)==''?"I":"U";
		console.log("flag = " + flag);
		
// 		console.log( "VDR_IDX = " + $("#VDR_IDX").val() );
// 		console.log( "VDR_NM = " +$("#VDR_NM").val() );
// 		console.log( "VDR_CEO_NM = " +$("#VDR_CEO_NM").val() );
// 		console.log( "VDR_ADD = " +$("#VDR_ADD").val() );
// 		console.log( "VDR_TEL = " +$("#VDR_TEL").val() );
// 		console.log( "VDR_FAX = " +$("#VDR_FAX").val() );
// 		console.log( "VDR_ML1 = " +$("#VDR_ML1").val() );
// 		console.log( "VDR_NO = " +$("#VDR_NO").val() );
		
		$("#modal_info").modal('hide');
		
		var strUrl = "/info/account/saveVendor";
		var postData = "flag=" + flag
				+ "&VDR_IDX=" + encodeURIComponent(VDR_IDX)
				+ "&VDR_NM=" + encodeURIComponent(VDR_NM)
				+ "&VDR_CEO_NM=" + encodeURIComponent(VDR_CEO_NM)
				+ "&VDR_ADD=" + encodeURIComponent(VDR_ADD)
				+ "&VDR_TEL=" + encodeURIComponent(VDR_TEL)
				+ "&VDR_FAX=" + encodeURIComponent(VDR_FAX)
				+ "&VDR_ML1=" + encodeURIComponent(VDR_ML1)
				+ "&VDR_ML2=" + encodeURIComponent(VDR_ML2)
				+ "&VDR_ML3=" + encodeURIComponent(VDR_ML3)
				+ "&VDR_HP=" + encodeURIComponent(VDR_HP)
				+ "&VDR_NO=" + encodeURIComponent(VDR_NO);
				 
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
			var code = data.vdr_IDX;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/account/deleteVendor";
					var postData = "VDR_IDX=" + code;
					
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