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
		<jsp:param name="selected_menu_cd" value="1021" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>자재관리 <small>기준정보관리</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">자재 관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						   	<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload('grid_list','자재 관리');">엑셀다운로드</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="showIU_modal();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteMaterial();">삭제</button>
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
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal" method="POST" enctype="multipart/form-data">	
					<input type="hidden" id="upload_mode"/>
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">자재코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_IDX" name ="MTL_IDX" maxlength="100" readonly="readonly">
							</div>
						</div>
					</div>
									
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">자재분류</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_CATE" name ="MTL_CATE" maxlength="30">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">품목</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_NM" name ="MTL_NM" maxlength="20">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">제조사</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_MKR_CD" name ="MTL_MKR_CD" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">제조사 품번</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_MKR_NO" name ="MTL_MKR_NO" maxlength="10">
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">규격</label><!-- 공통코드 ea/kg 중 선택 -->
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_STD" name ="MTL_STD" value="" maxlength="60">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">단가</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_PRICE" name ="MTL_PRICE" maxlength="14">
							</div>
						</div>
					</div>
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">재고단위</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_UNT" name ="MTL_UNT" maxlength="14">
							</div>
						</div>
					</div>				
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">Datasheet URL</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="MTL_DS_URL" name ="MTL_DS_URL" maxlength="60">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">비고</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="MTL_BG" name ="MTL_BG" maxlength="60">
							</div>
						</div>
					</div>					
					
					<div class="row">
						<label class="col-sm-3 control-label">이미지 파일</label>
						<div class="col-sm-7" style="padding-right: 0px;">
							<input type="text" id="mod_file_name" name="mod_file_name" class="form-control input-sm clear_field" readonly>
						</div>	
						<div class="col-sm-1" style="padding-left: 7px;">
							<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> 
								<i class="fa fa-plus"></i>
								<input id="file_group" type="file" class="fileupload file_info" name="file[]" onchange="$('#mod_file_name').val(this.value)">
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveMaterial();">저장</button>
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
		fnLoadMaterialGrid();
	})

	function fnLoadMaterialGrid(){
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
				{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} 						
				},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'cmm_FLE_IDX', caption:'제품자료', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_DS_URL', caption:'참조링크', size:'7%', style:'text-align:center', sortable: true},
				{ field:'mtl_BG', caption:'비고', size:'7%', style:'text-align:center', sortable: true}
				], 
			sortData: [{field: 'mtl_IDX', direction: 'DESC'}],
			records: [],	//
			onReload: function(event) {
				
			},
			onClick: function (event) {
				
			}
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

			}
		});
	}

	//등록/수정 모달 생성
	function showIU_modal() {
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			insertMaterial();
		} else  if( key.length==1 ) {	
			updateMaterial();	
		}
	}	
	// modal 띄우기 
	function insertMaterial() {
		console.log('insertMaterial()');
	
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
	
	function updateMaterial() {
		console.log('updateMaterial()');
			
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
	
	function saveMaterial() {
		console.log('saveMaterial()');
		
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

		console.log("flag = " + flag);

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

		var form = $("#frm_routingItnbr")[0];
		
		var data = new FormData(form);
		data.append('flag',flag)
	
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: strUrl,
			data: data,
			processData: false,
			contentType: false,
			cache: false,
			timeout: 600000,
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	startValue_combo = "";
			    	loadList();
					form.reset();
					$("#modal_info").modal('hide');
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
		    }
		});
		
	}
	
	function deleteMaterial() {
		console.log('deleteMaterial()');
	
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