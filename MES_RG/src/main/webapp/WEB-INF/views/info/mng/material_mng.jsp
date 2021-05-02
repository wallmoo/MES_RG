<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "RealGain"; //SessionUtil.getProperties("mes.company");
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
		<jsp:param name="selected_menu_cd" value="1021" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        고객사 관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">자재 관리</li>
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
									 <label>제조사</label> 
									  <input type="combo" id="S_MTL_MKR_CD" name="S_MTL_MKR_CD" class="form-control input-sm" placeholder="제조사" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									 <label>자재분류</label> 
									  <input type="combo" id="S_MTL_CATE" name="S_MTL_CATE" class="form-control input-sm" placeholder="자재분류" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
								</div>
							</div>	
							<div class="col-sm-2">
								<div class="form-group">
									 <label>품목</label> 
									  <input type="combo" id="S_MTL_NM" name="S_MTL_NM" class="form-control input-sm" placeholder="품목" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
								</div>
							</div>	
							<div class="col-sm-2">
								<div class="form-group">
									 <label>제조사 품번</label> 
									  <input type="combo" id="S_MTL_MKR_NO" name="S_MTL_MKR_NO" class="form-control input-sm" placeholder="제조사 품번" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
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
					<input type="hidden" id="upload_mode"/>
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">자재코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_IDX" maxlength="100" readonly="readonly">
							</div>
						</div>
					</div>
									
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">자재분류</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_CATE" maxlength="30">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">품목</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_NM" maxlength="20">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">제조사</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_MKR_CD" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">제조사 품번</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_MKR_NO" maxlength="10">
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">규격</label><!-- 공통코드 ea/kg 중 선택 -->
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_STD" value="" maxlength="60">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">단가</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_PRICE" maxlength="14">
							</div>
						</div>
					</div>
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">재고단위</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_UNT" maxlength="14">
							</div>
						</div>
					</div>				
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">Datasheet URL</label>
							<div class="col-sm-7">
								<textarea type="text" class="form-control input-sm pull-right" id="MTL_DS_URL" ></textarea>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">비고</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_BG" maxlength="60">
							</div>
						</div>
					</div>					
					
					<div class="row">
						<label class="col-sm-3 control-label">이미지 파일</label>
						<div class="col-sm-7" style="padding-right: 0px;">
							<input type="text" id="mod_file_name" name="mod_file_name" class="form-control input-sm clear_field" readonly>
						</div>	
						<div class="col-sm-1" style="padding-left: 7px;">
							<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
								<input id="file_group" type="file" class="fileupload file_info" name="file[]">
							</span>
						</div>
					</div>					
					
					
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
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
	        	{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'mtl_CATE', caption:'자재 분류', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'cmm_FLE_IDX', caption:'제품자료', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_DS_URL', caption:'참조링크', size:'7%', style:'text-align:center', sortable: true},
				{ field:'mtl_BG', caption:'비고', size:'7%', style:'text-align:center', sortable: true}
				], 
			sortData: [{field: 'mtl_IDX', direction: 'DESC'}],
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
		
		var page_url = "/info/account/selectMaterial";
		var postData = "MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					  + "&MTL_CATE=" + encodeURIComponent($("#S_MTL_CATE").val())
					  + "&MTL_NM="   + encodeURIComponent($("#S_MTL_NM").val())
					  + "&MTL_MKR_NO="+ encodeURIComponent($("#S_MTL_MKR_NO").val());

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
							comboValue_nm.push(row.MTL_NM ? row.MTL_NM+'' : '');
							comboValue_cd.push(row.MTL_IDX ? row.MTL_IDX+'' : '');
						}
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#MTL_NM').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#MTL_IDX').w2field('combo', { items: comboValue_cd, match : 'contains' });
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
		$("#modal_code_title").text('자재 등록');
 		
		$("#MTL_IDX").val('');
		$("#MTL_CATE").val('');
		$("#MTL_NM").val('');
		$("#MTL_MKR_CD").val('');
		$("#MTL_MKR_NO").val('');
		$("#MTL_STD").val('');
		$("#MTL_PRICE").val('');
		$("#MTL_UNT").val('');
		$("#MTL_DS_URL").val('');
		$("#MTL_BG").val('');

		$("#modal_info").modal('show');
	}
	
	function updateAccount() {
		console.log('updateAccount()');
			
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('자재 수정');
			
			var data = w2ui.grid_list.get(key[0]);			
			
			$("#MTL_IDX").val(data.mtl_IDX);
			$("#MTL_CATE").val(data.mtl_CATE);
			$("#MTL_NM").val(data.mtl_NM);
			$("#MTL_MKR_CD").val(data.mtl_MKR_CD);
			$("#MTL_MKR_NO").val(data.mtl_MKR_NO);
			$("#MTL_STD").val(data.mtl_STD);
			$("#MTL_PRICE").val(data.mtl_PRICE);
			$("#MTL_UNT").val(data.mtl_UNT);
			$("#MTL_DS_URL").val(data.mtl_DS_URL);
			$("#MTL_BG").val(data.mtl_BG);

			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveAccount() {
		console.log('saveAccount()');
		
		var MTL_IDX = $("#MTL_IDX").val();
		var MTL_CATE = $("#MTL_CATE").val();
		var MTL_NM = $("#MTL_NM").val();
		var MTL_MKR_CD = $("#MTL_MKR_CD").val();
		var MTL_MKR_NO = $("#MTL_MKR_NO").val();
		var MTL_STD = $("#MTL_STD").val();
		var MTL_PRICE = $("#MTL_PRICE").val();
		var MTL_UNT = $("#MTL_UNT").val();
		var MTL_DS_URL = $("#MTL_DS_URL").val();
		var MTL_BG = $("#MTL_BG").val();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
			MTL_IDX = 0;
		} else if (key.length == 1){
			flag = "U";
		}

		//if(flag=="I" && !chkSubmit($("#m_account_code"), "고객사코드를")) return;
		if(flag=="I" && !chkSubmit($("#MTL_NM"), "품목을")) return;
// 		if(flag=="I" && !chkSubmit($("#MTL_CEO_NM"), "대표자 이름을")) return; 			
// 		if(flag=="I" && !chkSubmit($("#MTL_ADD"), "주소를")) return; 	
// 		if(flag=="I" && !chkSubmit($("#MTL_TEL"), "전화번호를")) return;
// 		if(flag=="I" && !chkSubmit($("#MTL_FAX"), "팩스를")) return;
// 		if(flag=="I" && !chkSubmit($("#MTL_ML1"), "이메일을")) return;
// 		if(flag=="I" && !chkSubmit($("#MTL_NO"), "사업자번호를")) return;
		
// 		var flag = nullToBlank(account_code)==''?"I":"U";
		console.log("flag = " + flag);
		
// 		console.log( "MTL_IDX = " + $("#MTL_IDX").val() );
// 		console.log( "MTL_NM = " +$("#MTL_NM").val() );
// 		console.log( "MTL_CEO_NM = " +$("#MTL_CEO_NM").val() );
// 		console.log( "MTL_ADD = " +$("#MTL_ADD").val() );
// 		console.log( "MTL_TEL = " +$("#MTL_TEL").val() );
// 		console.log( "MTL_FAX = " +$("#MTL_FAX").val() );
// 		console.log( "MTL_ML1 = " +$("#MTL_ML1").val() );
// 		console.log( "MTL_NO = " +$("#MTL_NO").val() );
		
		$("#modal_info").modal('hide');

		var strUrl = "/info/account/saveMaterial";
		var postData = "flag=" + flag
				+ "&MTL_IDX=" + encodeURIComponent(MTL_IDX)
				+ "&MTL_CATE=" + encodeURIComponent(MTL_CATE)
				+ "&MTL_NM=" + encodeURIComponent(MTL_NM)
				+ "&MTL_MKR_CD=" + encodeURIComponent(MTL_MKR_CD)
				+ "&MTL_MKR_NO=" + encodeURIComponent(MTL_MKR_NO)
				+ "&MTL_STD=" + encodeURIComponent(MTL_STD)
				+ "&MTL_PRICE=" + encodeURIComponent(MTL_PRICE)
				+ "&MTL_UNT=" + encodeURIComponent(MTL_UNT)
				+ "&MTL_DS_URL=" + encodeURIComponent(MTL_DS_URL)
				+ "&MTL_BG=" + encodeURIComponent(MTL_BG);
				 
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
			var code = data.mtl_IDX;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/account/deleteMaterial";
					var postData = "MTL_IDX=" + code;
					
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

		var fileName = '자재 관리.xlsx';
		var sheetTitle = '자재 관리';
		var sheetName = '자재 관리';
		
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