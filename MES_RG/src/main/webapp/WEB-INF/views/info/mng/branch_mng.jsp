<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET 기업 정보  관리"; //SessionUtil.getProperties("mes.company");
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
		<jsp:param name="selected_menu_cd" value="1113" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        기업 정보 관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">기업 정보 관리</li>
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
									 <label>사업장</label> 
									  <input type="combo" id="S_BCO_PLC" name="S_BCO_PLC" class="form-control input-sm" placeholder="사업장" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="BCO_NM" name="BCO_NM" class="form-control input-sm" placeholder="기업 정보명" -->
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
							<label for="" class="col-sm-3 control-label">회사코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_IDX" maxlength="100" readonly="readonly">
							</div>
						</div>
					</div>
									
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">회사명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_NM" maxlength="30">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_NO" maxlength="20">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">대표자</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_CEO_NM" maxlength="10">
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업장</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_PLC" maxlength="20">
							</div>
						</div>
					</div>						
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_ADD" value="" maxlength="60">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_TEL" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_FAX" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_ML1" maxlength="60">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">URL</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_HP" maxlength="50">
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
	        	{ field:'bco_IDX', caption:'회사코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'bco_NM', caption:'회사명', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'bco_CEO_NM', caption:'대표자', size:'10%', style:'text-align:center' , sortable: true},
	        	{ field:'bco_PLC', caption:'사업장', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'bco_ADD', caption:'주소', size:'17%', style:'text-align:center', sortable: true},
				{ field:'bco_TEL', caption:'전화번호', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'bco_FAX', caption:'팩스', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'bco_ML1', caption:'이메일', size:'8%', style:'text-align:center', sortable: true},
				{ field:'bco_NO', caption:'사업자번호', size:'7%', style:'text-align:center', sortable: true}
				], 
			sortData: [{field: 'bco_IDX', direction: 'DESC'}],
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
		
		var page_url = "/info/account/selectBranch";
		var postData = "BCO_PLC=" + encodeURIComponent($("#S_BCO_PLC").val());

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
							comboValue_nm.push(row.BCO_NM ? row.BCO_NM+'' : '');
							comboValue_cd.push(row.BCO_IDX ? row.BCO_IDX+'' : '');
						}
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#BCO_NM').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#BCO_IDX').w2field('combo', { items: comboValue_cd, match : 'contains' });
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
 		
 		$("#BCO_NM").val('');
		$("#BCO_CEO_NM").val('');
		$("#BCO_PLC").val('');
		$("#BCO_ADD").val('');
		$("#BCO_TEL").val('');
		$("#BCO_FAX").val('');
		$("#BCO_ML1").val('');
		$("#BCO_HP").val('');
		$("#BCO_NO").val('');

		$("#modal_info").modal('show');
	}
	
	function updateAccount() {
		console.log('updateAccount()');
			
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			
			var data = w2ui.grid_list.get(key[0]);			
			
			$("#BCO_IDX").val(data.bco_IDX);
			$("#BCO_NM").val(data.bco_NM);
			$("#BCO_CEO_NM").val(data.bco_CEO_NM);
			$("#BCO_CEO_NM").val(data.bco_PLC);
			$("#BCO_ADD").val(data.bco_ADD);
			$("#BCO_TEL").val(data.bco_TEL);
			$("#BCO_FAX").val(data.bco_FAX);
			$("#BCO_ML1").val(data.bco_ML1);
			$("#BCO_HP").val(data.bco_HP);
			$("#BCO_NO").val(data.bco_NO);
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveAccount() {
		console.log('saveAccount()');
		
		var BCO_IDX = $("#BCO_IDX").val();
		var BCO_NM = $("#BCO_NM").val();
		var BCO_CEO_NM = $("#BCO_CEO_NM").val();
		var BCO_PLC = $("#BCO_PLC").val();
		var BCO_ADD = $("#BCO_ADD").val();
		var BCO_TEL = $("#BCO_TEL").val();
		var BCO_FAX = $("#BCO_FAX").val();
		var BCO_ML1 = $("#BCO_ML1").val();
		var BCO_HP = $("#BCO_HP").val();
		var BCO_NO = $("#BCO_NO").val();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
			BCO_IDX = 0;
		} else if (key.length == 1){
			flag = "U";
		}

		//if(flag=="I" && !chkSubmit($("#m_account_code"), "기업 정보코드를")) return;
		if(flag=="I" && !chkSubmit($("#BCO_NM"), "회사명을")) return;
// 		if(flag=="I" && !chkSubmit($("#BCO_CEO_NM"), "대표자 이름을")) return; 			
// 		if(flag=="I" && !chkSubmit($("#BCO_ADD"), "주소를")) return; 	
// 		if(flag=="I" && !chkSubmit($("#BCO_TEL"), "전화번호를")) return;
// 		if(flag=="I" && !chkSubmit($("#BCO_FAX"), "팩스를")) return;
// 		if(flag=="I" && !chkSubmit($("#BCO_ML1"), "이메일을")) return;
// 		if(flag=="I" && !chkSubmit($("#BCO_NO"), "사업자번호를")) return;
		
		// var flag = nullToBlank(account_code)==''?"I":"U";
		console.log("flag = " + flag);
		
// 		console.log( "BCO_IDX = " + $("#BCO_IDX").val() );
// 		console.log( "BCO_NM = " +$("#BCO_NM").val() );
// 		console.log( "BCO_CEO_NM = " +$("#BCO_CEO_NM").val() );
// 		console.log( "BCO_ADD = " +$("#BCO_ADD").val() );
// 		console.log( "BCO_TEL = " +$("#BCO_TEL").val() );
// 		console.log( "BCO_FAX = " +$("#BCO_FAX").val() );
// 		console.log( "BCO_ML1 = " +$("#BCO_ML1").val() );
// 		console.log( "BCO_NO = " +$("#BCO_NO").val() );
		
		$("#modal_info").modal('hide');
		
		var strUrl = "/info/account/saveBranch";
		var postData = "flag=" + flag
				+ "&BCO_IDX=" + encodeURIComponent(BCO_IDX)
				+ "&BCO_NM=" + encodeURIComponent(BCO_NM)
				+ "&BCO_CEO_NM=" + encodeURIComponent(BCO_CEO_NM)
				+ "&BCO_PLC=" + encodeURIComponent(BCO_PLC)
				+ "&BCO_ADD=" + encodeURIComponent(BCO_ADD)
				+ "&BCO_TEL=" + encodeURIComponent(BCO_TEL)
				+ "&BCO_FAX=" + encodeURIComponent(BCO_FAX)
				+ "&BCO_ML1=" + encodeURIComponent(BCO_ML1)
				+ "&BCO_HP=" + encodeURIComponent(BCO_HP)
				+ "&BCO_NO=" + encodeURIComponent(BCO_NO);
				 
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
			var code = data.BCO_IDX;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/account/deleteBranch";
					var postData = "BCO_IDX=" + code;
					
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

		var fileName = '기업 정보 관리.xlsx';
		var sheetTitle = '기업 정보 관리';
		var sheetName = '기업 정보 관리';
		
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
//		.append('<option value="All">-----</option>')
	    .val();
	}
</script>

</body>
</html>