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
			<jsp:param name="selected_menu_p_cd" value="1122" />
			<jsp:param name="selected_menu_cd" value="1124" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					자재재고관리 <small>재고관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 재고관리</a></li>
					<li class="active">자재재고관리</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<section class="col-lg-12">
						<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">

							<div class="box-header with-border" style="background-color: #DB8EB5;">
								<h3 class="box-title">조회조건</h3>
								<div class="box-tools pull-right">
									<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
									<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertAccount();">등록</button>
									<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="inAccount();">입고등록</button>
									<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="outAccount();">출고등록</button>
<!-- 									<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="updateAccount();">수정</button> -->
<!-- 									<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteAccount();">삭제</button> -->
									<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>
								</div>
							</div>
							<div id="" class="box-body">
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<label>제조사</label> 
											<input type="combo" id="S_MTL_MKR_CD" name="S_MTL_MKR_CD" class="form-control input-sm" placeholder="제조사"
												 onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>자재분류</label> 
											<input type="combo" id="S_MTL_CATE" name="S_MTL_CATE" class="form-control input-sm" placeholder="자재분류"
												 onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>품목</label> 
											<input type="combo" id="S_MTL_NM" name="S_MTL_NM" class="form-control input-sm" placeholder="품목"
												 onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>제조사 품번</label> 
											<input type="combo" id="S_MTL_MKR_NO" name="S_MTL_MKR_NO" class="form-control input-sm" placeholder="제조사 품번"
												 onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
								</div>
								<div id="tabs" style="width: 100%;"></div>
								<div id="selected-tab" style="padding: 20px 10px">
									<div id="grid_list" style="width: 100%; height: 620px;"></div>
									<div id="grid_list2" style="width: 100%; height: 60px;"></div>
								</div>								
							</div>
						</div>
					</section>
				</div>
			</section>
			<!-- //content -->
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
					<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal"
					method="POST" enctype="multipart/form-data">	
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
									<input type="text" class="form-control input-sm pull-right" id="MTL_MKR_NO" name ="MTL_MKR_CD" maxlength="10">
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
									<textarea type="text" class="form-control input-sm pull-right" id="MTL_DS_URL" name ="MTL_DS_URL"></textarea>
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
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
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
						<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAccount();">저장</button>
						<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 2차 모달(출고/입고) -->
	
	<div class="modal fade" id="modal_inOut" data-backdrop="static">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modal_inOut_title">등록</h4>
	        	</div>
				<div class="modal-body" id="modal_code_body">
					<form id="frm_inOut" name="frm_inOut" class="form-horizontal"
					method="POST" enctype="multipart/form-data">	
						<input type="hidden" id="flag" name="flag"/>
						<input type="hidden" id="hidden_MTLIDX" name="hidden_MTLIDX" />
						<input type="hidden" class="clear_field" id="mod_file_group"/>
						<input type="hidden" class="clear_field" id="mod_file_no"/>				
						<div class="row">
							<div class="form-group">
								<label for="COUNTT" class="col-sm-3 control-label">수량</label>
								<div class="col-sm-7">
									<input type="number" class="form-control input-sm pull-right" id="COUNTT" name ="COUNTT" maxlength="30">
								</div>
							</div>
						</div>
										
						<div class="row">
							<div class="form-group">
								<label for="TEXT_BG" class="col-sm-3 control-label">비고</label>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm pull-right" id="TEXT_BG" name ="TEXT_BG" maxlength="100">
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
						<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAccount2();">저장</button>
						<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 2차모달끝 -->

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
	var HIS_GB =[
		{ id : null, text : '입출고상태' },
		{ id : 'IN', text : '입고상태' },
		{ id : 'OUT', text : '출고상태' },
		
	];
	
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	$(function($) {
		tab_grid();
		fnLoadList1Grid();
	})

	function fnLoadList1Grid(){
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
	        	{ field:'whs_HIS_IDX', caption:'재고번호', size:'4%', style:'text-align:center', hidden: true },
	        	{ field:'ord_IDX', caption:'재고번호', size:'5%', style:'text-align:center', hidden: true },
	        	{ field:'mtl_IDX', caption:'자재코드', size:'5%', style:'text-align:center' , sortable: true },
	        	{ field:'mtl_CATE', caption:'자재 분류', size:'5%', style:'text-align:center', sortable: true} ,
	        	{ field:'mtl_NM', caption:'품목', size:'13%', style:'text-align:center' , sortable: true },
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'13%', style:'text-align:center', sortable: true },
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true }, 
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true }, 
				{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true },
				{ field:'mtl_UNT', caption:'재고단위', size:'5%', style:'text-align:center', sortable: true },
				{ field:'cmm_FLE_IDX', caption:'제품자료', size:'8%', style:'text-align:center', sortable: true },
				{ field:'mtl_DS_URL', caption:'참조링크', size:'7%', style:'text-align:center', sortable: true },
				{ field:'mtl_BG', caption:'비고', size:'7%', style:'text-align:center', sortable: true},
				{ field:'whs_HIS_GB', caption:'입출고상태', size:'7%', style:'text-align:center', sortable: true,
					render: function (record, index, col_index) {
	                    var html = '';
	                    for (var p in HIS_GB) {
	                        if (HIS_GB[p].id == this.getCellValue(index, col_index)) html = HIS_GB[p].text;
	                    }
	                    return html;
	                }	
				
				},
				{ field:'whs_HIS_QTY', caption:'재고', size:'6%', style:'text-align:center', sortable: true },
				],
			sortData: [{field: 'mtl_IDX', direction: 'DESC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {},
			onChange : function(event) {//갯수 수정
				/*
				event.onComplete = function() {//onSave
					console.log("onChange");

					//alert("수정된 값:" + w2ui['grid1'].getChanges());//바뀐것만 json형태.

					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
					
					w2ui.grid_list.save();
					
					
					var updateContent = JSON.stringify(w2ui['grid_list'].getChanges());//stringify(배열을 문자열json으로 바꿔줌.)!!
					
					var Bom_MTL_IDX = this.get(event.recid).mtl_IDX;//자재번호
					var Bom_MTL_BG = this.get(event.recid).mtl_BG;//자재 수량
					var Bom_whs_HIS_GB = this.get(event.recid).whs_HIS_GB;//재고 구분
					var whs_HIS_IDX = this.get(event.recid).whs_HIS_IDX;//재고 IDX
					var ord_IDX = this.get(event.recid).ord_IDX;//재고 IDX
					var WHS_HIS_QTY = this.get(event.recid).whs_HIS_QTY;//재고 IDX
					
					var page_url = "/materials/materials/updateBomQuantity";		
					var postData =  "MTL_IDX="+ Bom_MTL_IDX
								+ "&MTL_BG="+ Bom_MTL_BG
								+ "&WHS_HIS_GB="+ Bom_whs_HIS_GB
								+ "&WHS_HIS_IDX="+whs_HIS_IDX
								+ "&ORD_IDX="+ord_IDX
								+ "&WHS_HIS_QTY="+WHS_HIS_QTY
								;
					$.ajax({
						url : page_url,
						type : "POST",
						data : postData,
						data_type : 'json',
						cache : false,
						success : function(response) {
							alert('수정되었습니다.');
							loadList();
						},
						error : function() {
							alert('Error while request...'); 
						}
					})					
				}
			*/
			
			}	
			
		});
		loadList1()
	}
	function loadList(){
		setTimeout(function(){
			if(currentTab=='tab1'){
				loadList1();
			}else if(currentTab=='tab2'){
				loadList2();
			}else{
				loadList3();
			}
		},200);
	}
	function loadList1() {
		console.log("loadList1()");
		
		var page_url = "/materials/materials/selectMaterial";
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
	function loadList2() {
		console.log("loadList2()");
		
		var page_url = "/materials/materials/selectMaterial";
		var postData = "MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					  + "&MTL_CATE=" + encodeURIComponent($("#S_MTL_CATE").val())
					  + "&MTL_NM="   + encodeURIComponent($("#S_MTL_NM").val())
					  + "&MTL_MKR_NO="+ encodeURIComponent($("#S_MTL_MKR_NO").val())
					  + "&WHS_HIS_GB=IN";

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
	function loadList3() {
		console.log("loadList3()");
		
		var page_url = "/materials/materials/selectMaterial";
		var postData = "MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					  + "&MTL_CATE=" + encodeURIComponent($("#S_MTL_CATE").val())
					  + "&MTL_NM="   + encodeURIComponent($("#S_MTL_NM").val())
					  + "&MTL_MKR_NO="+ encodeURIComponent($("#S_MTL_MKR_NO").val())
					  + "&WHS_HIS_GB=OUT";

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
		
		//$("#modal_info").modal('hide');

		var strUrl = "/info/account/saveMaterial";
		//strUrl = "/info/account/test";
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
						 		loadList1();
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
	

	var currentTab = 'tab1';
	//tab설정
	function tab_grid(){
		
		$('#date_parent').hide();
			
			
		$('#tabs').w2tabs({
	        name: 'tabs',
	        active: 'tab1',
	        tabs: [
	            { id: 'tab1', text: '재고조정', style: "background-color: #8bcb77;"  },
	            { id: 'tab2', text: '입고내역' },
	            { id: 'tab3', text: '출고내역' },
	        ],
	        onClick: function (event) {
	        	w2ui['tabs'].set('tab1' ,  { style: "background-color:;"  });
	 			w2ui['tabs'].set('tab2' ,  { style: "background-color:;"  });
				w2ui['tabs'].set('tab3' ,  { style: "background-color:;"  });
				
	  			$('#btn_in').attr('disabled', true);
				$('#btn_out').attr('disabled', true);

				currentTab = event.target;
				var recids = w2ui.grid_list.getSelection();
	            if(event.target == 'tab1')
	        	{
	            	/*
	       			console.log(' 재고조정');
	       			w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });
	      			$('#btn_in').attr('disabled', false);
	       			$('#btn_out').attr('disabled', false);
	       			
	       			w2ui['grid_list'].hideColumn(recids[0], 'in_date');
	   				w2ui['grid_list'].hideColumn(recids[0], 'out_date');
	   				w2ui['grid_list'].hideColumn(recids[0], 'comment');
	   				
	   				w2ui['grid_list2'].hideColumn(recids[0], 'in_date');
	   				w2ui['grid_list2'].hideColumn(recids[0], 'out_date');
	   				w2ui['grid_list2'].hideColumn(recids[0], 'comment');
	   				
	     			$('#date_parent').hide();
	    			document.getElementById('date_nm').innerHTML = '입고일자';
	    			*/
	  				
	            	w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });
	    			loadList1();
	   
	        	}else if(event.target == 'tab2')
	        	{
	      			console.log(' 입고내역');
	      			/*
	      			w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });
	       			w2ui['grid_list'].showColumn(recids[0], 'in_date');
	   				w2ui['grid_list'].hideColumn(recids[0], 'out_date');
	   				
	   				w2ui['grid_list'].showColumn(recids[0], 'comment');
	   				
	   				
	   				w2ui['grid_list2'].showColumn(recids[0], 'in_date');
	   				w2ui['grid_list2'].hideColumn(recids[0], 'out_date');
	   				
	   				w2ui['grid_list2'].showColumn(recids[0], 'comment');
	    			$('#date_parent').show();
	    			document.getElementById('date_nm').innerHTML = '입고일자';
	    			*/
	            	w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });
	    			loadList2();
	    
	       		}else if(event.target == 'tab3')
	        	{
	     			console.log(' 출고내역');
	     			/*
	     			w2ui['tabs'].set('tab3' ,  { style: "background-color: #8bcb77;"  });
	     			w2ui['grid_list'].hideColumn(recids[0], 'in_date');
	   				w2ui['grid_list'].showColumn(recids[0], 'out_date');
	   				
					w2ui['grid_list'].showColumn(recids[0], 'comment');
					
					w2ui['grid_list2'].hideColumn(recids[0], 'in_date');
	   				w2ui['grid_list2'].showColumn(recids[0], 'out_date');
	   				
					w2ui['grid_list2'].showColumn(recids[0], 'comment');
	    			$('#date_parent').show();
	     			document.getElementById('date_nm').innerHTML = '출고일자';
	     			*/
	            	w2ui['tabs'].set('tab3' ,  { style: "background-color: #8bcb77;"  });
	    			loadList3();
	      		}
				
	   			w2ui['tabs'].refresh();
	        }
	    });
	}

		//엑셀 1024
		function excelFileDownload() {
			console.log("excelFileDownload()");
			var gridCols = w2ui['grid_list'].columns;
			var gridData = w2ui['grid_list'].records;

			var fileName = '자재 관리.xlsx';
			var sheetTitle = '자재 관리';
			var sheetName = '자재 관리';

			var param_col_name = "", param_col_id = "", param_col_align = "", param_col_width = "";
			var is_rownum = true;

			if (gridCols != null && gridCols.length > 0) {
				for (var i = 0; i < gridCols.length; i++) {
					if (!gridCols[i].hidden) {
						param_col_name += gridCols[i].caption + ",";
						param_col_id += gridCols[i].field + ",";
						param_col_align += "center" + ",";
						param_col_width += (gridCols[i].width == undefined ? "10"
								: (gridCols[i].width).replace('px', ''))
								+ ",";
					}
				}
				param_col_name = param_col_name.substr(0,
						param_col_name.length - 1);
				param_col_id = param_col_id.substr(0, param_col_id.length - 1);
				param_col_align = param_col_align.substr(0,
						param_col_align.length - 1);
				param_col_width = param_col_width.substr(0,
						param_col_width.length - 1);
			}

			var export_url = "/export/export_client_jqgrid";
			var export_data = "file_name=" + encodeURIComponent(fileName);
			export_data += "&sheet_title=" + encodeURIComponent(sheetTitle);
			export_data += "&sheet_name=" + encodeURIComponent(sheetName);
			export_data += "&header_col_names="
					+ encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="
					+ encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="
					+ encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="
					+ encodeURIComponent(param_col_width);
			export_data += "&cmd=" + encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="
					+ encodeURIComponent(JSON.stringify(gridData));

			$.ajax({
				url : export_url,
				data : export_data,
				type : 'POST',
				dataType : 'json',
				success : function(data) {
					if (data.status == 200) {
						var file_path = data.file_path;
						var file_name = data.file_name;
						var protocol = jQuery(location).attr('protocol');
						var host = jQuery(location).attr('host');
						var link_url = "/file/attach_download";
						link_url += "?file_path="
								+ encodeURIComponent(file_path);
						link_url += "&file_name="
								+ encodeURIComponent(file_name);

						$(location).attr('href', link_url);
					}
				},
				complete : function() {
				}
			});
		}

		// 미 입력시
		function chkSubmit(item, msg) {
			if (item.val().replace(/\s/g, "") == "") {
				fnMessageModalAlert("알림", msg + " 입력해 주세요.");
				item.val("");
				item.focus();
				return false;
			} else {
				return true;
			}
		}

		function initOptions(obj) {
			$(obj).find('option').remove().end()
			//		    .append('<option value="All">-----</option>')
			.val();
		}
		
		//팝업 관련(입고,출고처리)
		function inAccount(){
			var key = w2ui.grid_list.getSelection();
			if(key.length==0){
				fnMessageModalAlert("알림", "추가하실 자재코드를 선택해 주세요.");
				return false;
			}else{
				var idxs = w2ui.grid_list.get(key[0]).mtl_IDX;
				$("#flag").val("I");
				$("#hidden_MTLIDX").val(idxs);
				$("#modal_inOut").modal('show');
				$("#modal_inOut_title").html("입고등록");
			}
		}
		function outAccount(){
			var key = w2ui.grid_list.getSelection();
			if(key.length==0){
				fnMessageModalAlert("알림", "추가하실 자재코드를 선택해 주세요.");
				return false;
			}else{
				var idxs = w2ui.grid_list.get(key[0]).mtl_IDX;
				$("#flag").val("O");
				$("#hidden_MTLIDX").val(idxs);
				$("#modal_inOut").modal('show');
				$("#modal_inOut_title").html("출고등록");
			}
		}
		function saveAccount2(){
			if(confirm("저장하시겠습니까?")){
				var page_url = "/materials/materials/updateBomQuantity";
				var form = $("#frm_inOut")[0];
				
				var data = new FormData(form);
							;
				$.ajax({
					type: "POST",
					enctype: 'multipart/form-data',
					url: page_url,
					data: data,
					processData: false,
					contentType: false,
					cache: false,
					timeout: 600000,
					success : function(response) {
						alert('수정되었습니다.');
						$("#modal_inOut").modal('hide');
						$("#frm_inOut")[0].reset();
						loadList();
					},
					error : function() {
						alert('Error while request...'); 
					}
				})	
				
			}
		}
	</script>

</body>
</html>