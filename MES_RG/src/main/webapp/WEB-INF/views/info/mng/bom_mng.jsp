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
</head>


<body class="hold-transition skin-<%= thema %> sidebar-mini"><!-- <.%=thema%.> -->
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1012" />
		<jsp:param name="selected_menu_cd" value="1023" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			BOM 관리 <small> 기준정보관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>기준정보관리 </a></li>
			<li class="active">BOM 관리</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box" style="margin-bottom:0px; border: none;">
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
									<div class="col-sm-4">
										<div class="row">
											<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border" style=" background-color: #DB8EB5;">
													<h3 class="box-title">품목 정보</h3>
													<div class="box-tools pull-right">
														<button type="button" id="btn_search_csr" onclick="requestLeftGrid();" class="btn btn-primary btn-sm" onclick="">조회</button>	 
													</div>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-6">
																<label>품명</label> <input type="combo" id="Business" name="Business" class="form-control input-sm" placeholder="품명" onkeypress="if(event.keyCode==13) {requestLeftGrid(); return false;}">
															</div>
														</div>
													</div>
													<div id="grid_list" class="w2g-h600" style="margin-top: 10px;"></div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-sm-8">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">BOM 리스트</h3>
												<div class="box-tools pull-right">
													<button type="button" id="btn_ins_csr" onclick="excelFileDownload();" class="btn btn-info btn-sm" onclick="">엑셀다운로드</button>
													<button type="button" id="btn_search_csr" onclick="requestRightGrid('grid_list2');" class="btn btn-primary btn-sm" onclick="">조회</button>
													<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-primary btn-sm" onclick="">등록/수정</button>
													<%-- <button type="button" id="btn_del_csr" onclick="delItem();" class="btn btn-primary btn-sm" onclick="">수정</button> --%>
												</div>
											</div>
											<div class="box-body">
												<div class="row">
													<div class="form-group">
														<div class="col-sm-6">
															<label>자재검색</label> <input type="combo" id="r_mt_name" name="r_mt_name" class="form-control input-sm" placeholder="자재검색" 
															 onkeypress="if(event.keyCode==13) {requestRightGrid(); return false;}" style="padding : 5px 10px;">
															
														</div>
													</div>
												</div>
												<div id="grid_list2" class="w2g-h600" style="margin-top: 10px;"></div>
											</div>
										</div>
									</div>
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

<!-- 모달 커팅 -->
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width: 800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등록/수정</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="bom_lvl0" name="bom_lvl0" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<div class="col-sm-2" style="padding-left: 30px;padding-right: 0px">
								<input type="text" class="form-control input-sm pull-right" value="제품(0LEV)" disabled="disabled">
							</div>
							<label for="" class="col-sm-1 control-label" style="padding-left: 0px">품명</label>
							<div class="col-sm-2" style="padding-left: 0px;padding-right: 0px">
								<input type="combo" class="form-control input-sm pull-right clear_val" id="g3_item_nm" maxlength="100">
							</div>
							<label for="" class="col-sm-2 control-label">P/N</label>
							<div class="col-sm-2" style="padding-left: 0px;padding-right: 0px">
								<input type="combo" class="form-control input-sm pull-right clear_val" id="g3_item_type_code" maxlength="100">
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-default btn-sm" onclick="requestGrid3()">조회</button>
							</div>
						</div>
						<div class="col-sm-12">
							<div id="grid_list3" class="w2g-h200" style="margin-top: 10px;"></div>
						</div>
					</div>
				</form>
				<form id="bom_lvl1" name="bom_lvl1" class="form-horizontal" style="margin-top: 10px">
					<div class="row">
						<div class="form-group">
							<div class="col-sm-2" style="padding-left: 30px;padding-right: 0px">
								<input type="text" class="form-control input-sm pull-right" value="원자재(1LEV)" disabled="disabled">
							</div>
							<label for="" class="col-sm-1 control-label" style="padding-left: 0px">반제품명</label>
							<div class="col-sm-2" style="padding-left: 0px;padding-right: 0px">
								<input type="combo" class="form-control input-sm pull-right clear_val" id="g4_item_nm" maxlength="100">
							</div>
							<label for="" class="col-sm-2 control-label">반제품코드</label>
							<div class="col-sm-2" style="padding-left: 0px;padding-right: 0px">
								<input type="combo" class="form-control input-sm pull-right clear_val" id="g4_item_type_code" maxlength="100">
							</div>
							<div class="col-sm-3">
								<button type="button" class="btn btn-default btn-sm" onclick="requestGrid4()">조회</button>
								<button type="button" class="btn btn-success btn-sm" onclick="addlev1()">등록</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="dellev1()">삭제</button>
							</div>
						</div>
						<div class="col-sm-12">
							<div id="grid_list4" class="w2g-h200" style="margin-top: 10px;"></div>
						</div>
					</div>
				</form>
				<form id="bom_lvl2" name="bom_lvl2" class="form-horizontal" style="margin-top: 10px">
					<div class="row">
						<div class="form-group">
							<div class="col-sm-2" style="padding-left: 30px;padding-right: 0px">
								<input type="text" class="form-control input-sm pull-right" value="부자재(2LEV)" disabled="disabled">
							</div>
							<label for="" class="col-sm-1 control-label" style="padding-left: 0px">품명</label>
							<div class="col-sm-2" style="padding-left: 0px;padding-right: 0px">
								<input type="combo" class="form-control input-sm pull-right clear_val" id="g5_item_nm" maxlength="100">
							</div>
							<label for="" class="col-sm-2 control-label">P/N</label>
							<div class="col-sm-2" style="padding-left: 0px;padding-right: 0px">
								<input type="combo" class="form-control input-sm pull-right clear_val" id="g5_item_type_code" maxlength="100">
							</div>
							<div class="col-sm-3">
								<button type="button" class="btn btn-default btn-sm" onclick="requestGrid5()">조회</button>
								<button type="button" class="btn btn-success btn-sm" onclick="addlev2()">등록</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="dellev2()">삭제</button>
							</div>
						</div>
						<div class="col-sm-12">
							<div id="grid_list5" class="w2g-h200" style="margin-top: 10px;"></div>
						</div>
					</div>
				</form>
			<input type="hidden" id="hiddenProduct_code">
			<input type="hidden" id="hiddenM_item_code">
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_add" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_add_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="col-sm-9">
						<div class="row">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">품명</label>
								<div class="col-sm-7">
									<input type="combo" class="form-control input-sm pull-right clear_val2" id="add_nm" maxlength="100">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">P/N</label>
								<div class="col-sm-7">
									<input type="combo" class="form-control input-sm pull-right clear_val2" id="add_code" maxlength="100">
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<button type="button" id="" class="btn btn-default btn-sm" onclick="selmaterial()">검색</button>
					</div>
					<div class="col-sm-12">
						<div id="grid_list6" class="w2g-h200" style="margin-top: 10px;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer" style="border-top-color:transparent !important;">
				<div class="col-md-12 text-center" style="margin-top: 10px">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAddModal()">등록</button>
					<button type="button" id="" class="btn btn-danger btn-sm" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!--  -->
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->


<script type="text/javascript">
var grid_material_data;
var grid_add_data;
var grid_lev1_data;
var grid_lev2_data;
var startValue_combo = "";
comboValue_nm = new Array;
comboValue_cd = new Array;
comboValue_nm3 = new Array;
comboValue_cd3 = new Array;
comboValue_nm4 = new Array;
comboValue_cd4 = new Array;
comboValue_nm5 = new Array;
comboValue_cd5 = new Array;
comboValue_nm6 = new Array;
comboValue_cd6 = new Array;
$(function($) {
	
 	loadLeftGrid();
 	loadRightGrid();
 	loadGrid3();
 	loadGrid4();
 	loadGrid5();
 	loadGrid6();
})

// loadLeftGrid
function loadLeftGrid(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [
			{ field:'business_nm', caption:'구분', style:'text-align:center', sortable: true},
			{ field:'item_type_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},
			{ field:'meins', caption:'단위', style:'text-align:center', sortable: true},
			{ field:'item_code', caption:'아이템 코드', size:'10%', style:'text-align:center', hidden:true},
			], 
		sortData: [{field: 'bom_code', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list2'].refresh();
				// 오른쪽 그리드
				requestItemName(this.get(event.recid).item_code);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list2'].clear();		
				w2ui['grid_list2'].refresh();
				comboValue_cd = new Array;
			}
		},
		onClick: function (event) {
// 		 	grid_list2(); // 클릭 이벤트
		}
	});
	
	requestLeftGrid();
}

function requestLeftGrid(){
	var page_url = "/info/material/selectMaterial";
	var postData = 'item_type_code=MD1248&business_nm=consumableparts&item_nm='+$('#Business').val();
	
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					comboValue_nm.push(row.item_nm);
				});
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#Business').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
				}
			} else {
				w2ui.grid_list.clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
		}, complete : function() {
			startValue_combo = ":)";
			
			document.getElementById("Business").style.removeProperty("height");
		}
	});
}

function requestItemName(requestItemName){
	var page_url = "/info/selectBomlist";
	var postData = "product_item_code=" + encodeURIComponent(requestItemName);
	w2ui['grid_list2'].lock('loading...', true);
	w2ui['grid_list2'].clear();	
	w2ui['grid_list2'].refresh();
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					comboValue_cd.push(row.c_item_nm);
				});
				w2ui['grid_list2'].records = rowArr;
				
				if (startValue_combo == "") {
					$('#r_mt_name').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
				}
			} else {
				//w2ui.grid_list.clear();
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
			requestRightGrid('grid_list2');
		}, complete : function() {
			startValue_combo = ":)";
			document.getElementById("r_mt_name").style.removeProperty("height");
		}
	});
}

function requestRightGrid(gridname){
	var cnm = $('#r_mt_name').val();
	if(cnm == '' || cnm == null){
		return;
	}
	var list = w2ui[gridname].records;
	for(i = 0 ; list.length > i ; i++){
		var num = i+1;
		if(list[i].c_item_nm.indexOf(cnm) !== -1){
			$('#grid_'+gridname+'_rec_'+num+' > td').css({"color" : "red"});
		}else{
			$('#grid_'+gridname+'_rec_'+num+' > td').css({"color" : "black"});
		}
	} 
}

function loadRightGrid(){
	var rowArr = [];
	
	$('#grid_list2').w2grid({
		name : 'grid_list2',
		 show: {
				lineNumbers : true,
	            footer: true,
	            selectColumn : true
	        },
	    multiSelect: false,
        
        columns: [
        			{ field:'stufe', caption:'레벨', style:'text-align:center' , size : 20, sortable: true},
        			{ field:'c_item_nm', caption:'품명', sortable: true, style:'text-align:left' , 
        			render : function(record, index, col_index){
						var selstufe = record.stufe;
						var selcnm = record.c_item_nm;
						if(selstufe == 1){
							selcnm = '&emsp;&emsp;' + selcnm;
						}else if(selstufe == 2){
							selcnm = '&emsp;&emsp;&emsp;&emsp;' + selcnm;
						}
						return selcnm;
					}},
        			{ field:'c_item_code', caption:'P/N', style:'text-align:center', sortable: true},
        			{ field:'item_type_nm', caption:'자재유형', style:'text-align:center', sortable: true},
        			{ field:'meins', caption:'단위', style:'text-align:center', size : 30, sortable: true}
        			
                 ],
		records: [ 
		   ],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},

		onClick: function (event) {
		
		}, 
		onDblClick: function(event) {
			
		},onChange: function(event){
		}, 
		
		
    }); 
}

function insItem() {
	$(".clear_val").val('');

	$("#modal_info").modal('show');
	 setTimeout(function(){
		w2ui['grid_list3'].resize();
		w2ui['grid_list3'].refresh();
		w2ui['grid_list4'].resize();
		w2ui['grid_list4'].refresh();
		w2ui['grid_list5'].resize();
		w2ui['grid_list5'].refresh();
	}, 200);
	requestGrid3();
	w2ui["grid_list4"].clear()
	w2ui["grid_list5"].clear()
	$('#hiddenProduct_code').val('');
	$('#hiddenM_item_code').val('');
};
function loadGrid3(){
	var rowArr = [];
	
	$('#grid_list3').w2grid({
		name : 'grid_list3',
		 show: {
				lineNumbers : true,
	            selectColumn : true
	        },
	    multiSelect: false,
		
        columns: [
        			{ field:'recid', caption:'recid', style:'text-align:center', hidden:true},
        			{ field:'item_nm', caption:'품명', style:'text-align:center'},
        			{ field:'item_code', caption:'P/N', style:'text-align:center'}
                 ],
		records: [ 
		   ],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},

		onSelect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list4'].refresh();
				w2ui['grid_list5'].refresh();
				var item_code = this.get(event.recid).item_code;
				// 오른쪽 그리드
				$('#hiddenProduct_code').val(item_code);
				requestGrid4();
				requestGrid5();
				grid_material_data = this.get(event.recid);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				comboValue_nm4 = new Array;
				comboValue_cd4 = new Array;
				comboValue_nm5 = new Array;
				comboValue_cd5 = new Array;
				$('#hiddenProduct_code').val('');
				w2ui['grid_list4'].clear();		
				w2ui['grid_list4'].refresh();
				w2ui['grid_list5'].clear();		
				w2ui['grid_list5'].refresh();
			}
		}
    }); 
}
function requestGrid3(){
	var page_url = "/info/material/selectMaterial";
	var postData = 'item_type_code=MD1248';
	postData = postData + '&item_nm='+$('#g3_item_nm').val();
	postData = postData + '&item_code='+$('#g3_item_type_code').val();
	
	w2ui['grid_list3'].lock('loading...', true);
	w2ui['grid_list3'].clear();	
	w2ui['grid_list3'].refresh();
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					comboValue_nm3.push(row.item_nm);
					comboValue_cd3.push(row.item_code);
				});
				w2ui['grid_list3'].records = rowArr;
				$('#g3_item_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
				$('#g3_item_type_code').w2field('combo', { items: _.uniq(comboValue_cd3,false) ,match : 'contains' });
			} else {
				//w2ui.grid_list.clear();
			}
			w2ui['grid_list3'].refresh();
			w2ui['grid_list3'].unlock();
		}, complete : function() {
			document.getElementById("g3_item_nm").style.removeProperty("height");
			document.getElementById("g3_item_type_code").style.removeProperty("height");
		}
	});
}
function loadGrid4(){
	var rowArr = [];
	
	$('#grid_list4').w2grid({
		name : 'grid_list4',
		 show: {
				lineNumbers : true,
	            selectColumn : true
	        },
	    multiSelect: false,
		
        columns: [
        			{ field:'c_item_nm', caption:'반제품명', style:'text-align:center'},
        			{ field:'c_item_code', caption:'반제품코드', style:'text-align:center'}
                 ],
		records: [ 
		   ],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onSelect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list5'].refresh();
				var item_code = this.get(event.recid).c_item_code;
				$('#hiddenM_item_code').val(item_code);
				comboValue_nm5 = new Array;
				comboValue_cd5 = new Array;
				requestGrid5();
				grid_lev1_data = this.get(event.recid);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				comboValue_nm5 = new Array;
				comboValue_cd5 = new Array;
				$('#hiddenM_item_code').val('');
				w2ui['grid_list5'].clear();		
				w2ui['grid_list5'].refresh();
			}
		}
    }); 
}
function requestGrid4(){
	var page_url = "/info/selectBomlist";
	var postData = "stufe=1&item_type_code=MD1245&product_item_code=" + encodeURIComponent($('#hiddenProduct_code').val()) +"&c_item_code="+ encodeURIComponent($('#g4_item_type_code').val()) +"&c_item_nm="+ encodeURIComponent($('#g4_item_nm').val());
	w2ui['grid_list4'].lock('loading...', true);
	w2ui['grid_list4'].clear();	
	w2ui['grid_list4'].refresh();
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					comboValue_nm4.push(row.c_item_nm);
					comboValue_cd4.push(row.c_item_code);
				});
				w2ui['grid_list4'].records = rowArr;
			} else {
				//w2ui.grid_list.clear();
			}
			w2ui['grid_list4'].refresh();
			w2ui['grid_list4'].unlock();
			$('#g4_item_nm').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			$('#g4_item_type_code').w2field('combo', { items: _.uniq(comboValue_cd4,false) ,match : 'contains' });
		}, complete : function() {
			document.getElementById("g4_item_nm").style.removeProperty("height");
			document.getElementById("g4_item_type_code").style.removeProperty("height");
		}
	});
}
function loadGrid5(){
	var rowArr = [];
	
	$('#grid_list5').w2grid({
		name : 'grid_list5',
		 show: {
				lineNumbers : true,
	            selectColumn : true
	        },
	    multiSelect: false,
		
        columns: [
        			{ field:'m_item_nm', caption:'반제품명', style:'text-align:center'},
        			{ field:'m_item_code', caption:'반제품코드', style:'text-align:center'},
        			{ field:'c_item_nm', caption:'품명', style:'text-align:center'},
        			{ field:'c_item_code', caption:'P/N', style:'text-align:center'}
                 ],
		records: [ 
		   ],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onSelect: function (event) {
			event.onComplete = function () {
				grid_lev2_data = this.get(event.recid);
			}
		},
    }); 
}
function requestGrid5(){
	var page_url = "/info/selectBomlist";
	var postData = "stufe=2&item_type_code=MD1246&product_item_code=" + encodeURIComponent($('#hiddenProduct_code').val()) +"&c_item_code="+ encodeURIComponent($('#g5_item_type_code').val()) +"&c_item_nm="+ encodeURIComponent($('#g5_item_nm').val()) +"&m_item_code="+ encodeURIComponent($('#hiddenM_item_code').val());
	w2ui['grid_list5'].lock('loading...', true);
	w2ui['grid_list5'].clear();
	w2ui['grid_list5'].refresh();
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					comboValue_nm5.push(row.c_item_nm);
					comboValue_cd5.push(row.c_item_code);
				});
				w2ui['grid_list5'].records = rowArr;
				$('#g5_item_nm').w2field('combo', { items: _.uniq(comboValue_nm5,false) ,match : 'contains' });
				$('#g5_item_type_code').w2field('combo', { items: _.uniq(comboValue_cd5,false) ,match : 'contains' });
			} else {
				//w2ui.grid_list.clear();
			}
			w2ui['grid_list5'].refresh();
			w2ui['grid_list5'].unlock();
		}, complete : function() {
			document.getElementById("g5_item_nm").style.removeProperty("height");
			document.getElementById("g5_item_type_code").style.removeProperty("height");
		}
	});
}
function loadGrid6(){
	var rowArr = [];
	
	$('#grid_list6').w2grid({
		name : 'grid_list6',
		 show: {
	            selectColumn : true
	        },
	    multiSelect: false,
		
        columns: [
        			{ field:'item_type_code', caption:'유형', style:'text-align:center', hidden:true},
        			{ field:'item_code', caption:'코드', style:'text-align:center'},
        			{ field:'item_nm', caption:'제품명', style:'text-align:center'},
        			{ field:'item_type_nm', caption:'유형', style:'text-align:center'},
        			{ field:'item_spec', caption:'규격', style:'text-align:center'},
        			{ field:'meins', caption:'단위', style:'text-align:center'}
                 ],
		records: [ 
		   ],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},

		onClick: function (event) {
			grid_add_data = this.get(event.recid);
		}, 
    }); 
}
function addlev1(){
	if($('#hiddenProduct_code').val() == '' || $('#hiddenProduct_code').val() == null){
		fnMessageModalAlert("알림", "제품(0LEV)을 1개 선택하셔야 합니다.");
	}else{
		$("#modal_add_title").text('Bom 1lev 등록');
		$(".clear_val2").val('');
		$("#modal_add").modal('show');
		$("#modal_info").modal('show');
		 setTimeout(function(){
			w2ui['grid_list6'].resize();
			w2ui['grid_list6'].refresh();
		}, 200);
		selmaterial();
	}
}
function addlev2(){
	if($('#hiddenProduct_code').val() == '' || $('#hiddenProduct_code').val() == null){
		fnMessageModalAlert("알림", "제품(0LEV)을 1개 선택하셔야 합니다.");
	}else{
		if($('#hiddenM_item_code').val() == '' || $('#hiddenM_item_code').val() == null){
			fnMessageModalAlert("알림", "원자재(1LEV)를 1개 선택하셔야 합니다.");
		}else{
			$("#modal_add_title").text('Bom 2lev 등록');
			$(".clear_val2").val('');
			$("#modal_add").modal('show');
		 	setTimeout(function(){
				w2ui['grid_list6'].resize();
				w2ui['grid_list6'].refresh();
			}, 200);
			selmaterial();
		}
	}
}
function selmaterial(){
	grid_add_data = '';
	var lvl = 'MD1246';
	if($("#modal_add_title").text() == 'Bom 1lev 등록'){
		lvl = 'MD1245';
	}
	var page_url = "/info/material/selectMaterial";
	var postData = 'item_type_code=' + lvl;
	postData = postData + '&item_nm='+$('#add_nm').val();
	postData = postData + '&item_code='+$('#add_code').val();
	
	w2ui['grid_list6'].lock('loading...', true);
	w2ui['grid_list6'].clear();	
	w2ui['grid_list6'].refresh();
	comboValue_nm6 = new Array;
	comboValue_cd6 = new Array;
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					comboValue_nm6.push(row.item_nm);
					comboValue_cd6.push(row.item_code);
				});
				w2ui['grid_list6'].records = rowArr;
				$('#add_nm').w2field('combo', { items: _.uniq(comboValue_nm6,false) ,match : 'contains' });
				$('#add_code').w2field('combo', { items: _.uniq(comboValue_cd6,false) ,match : 'contains' });
			} else {
				//w2ui.grid_list.clear();
			}
			w2ui['grid_list6'].refresh();
			w2ui['grid_list6'].unlock();
		}, complete : function() {
			document.getElementById("add_nm").style.removeProperty("height");
			document.getElementById("add_code").style.removeProperty("height");
		}
	});
}

function saveAddModal(){
	var lvl = 'MD1246';
	if($("#modal_add_title").text() == 'Bom 1lev 등록'){
		lvl = 'MD1245';
	}
	var selectdata = w2ui.grid_list6.getSelection();
	if(selectdata != ''){
		var msg = '등록을 완료 하였습니다.';
		var page_url = "/info/insertBomlist";
		var postData = "product_item_code="+grid_material_data.item_code+"&business_code="+grid_material_data.business_code
						+"&product_item_nm="+grid_material_data.item_nm+"&c_item_code="+grid_add_data.item_code
						+"&c_item_nm="+grid_add_data.item_nm
						+"&item_type_code="+grid_add_data.item_type_code
						+"&item_type_nm="+grid_add_data.item_type_nm
						+"&spec="+grid_add_data.item_spec
						+"&meins="+grid_add_data.meins;
		
		if(lvl=='MD1245'){//원자재등록
			postData = postData+"&stufe="+1
			+"&m_item_code="+grid_material_data.item_code
			+"&m_item_nm="+grid_material_data.item_nm;
			msg = '원자재(1LEV)의' + msg;
		}else{//부자재등록
			postData = postData+"&stufe="+2
			+"&m_item_code="+ grid_lev1_data.c_item_code
			+"&m_item_nm="+ grid_lev1_data.c_item_nm;
			msg = '부자재(2LEV)의' + msg;
		}
		
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData,
			data_type : 'json',
			success : function(data){
				if(data.status == 200){
					fnMessageModalAlert("결과", msg);	// Notification(MES)
				}else if (data.status == 500 && data.msg == 'fall'){
					fnMessageModalAlert("결과", "이미 존재하는 값은 등록이 불가능합니다.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
			}, complete : function(){
				$("#modal_add").modal('hide');
				requestGrid4();
				requestGrid5();
			}
		});
		
	}else{
		fnMessageModalAlert("알림", "등록할 제품을 1개 선택해주세요.");
	}
	$('#hiddenM_item_code').val('');
}

function dellev1(){
	if(w2ui.grid_list4.getSelection().length == 0){
		fnMessageModalAlert("에러", "삭제하실 정보를 선택해주세요!");
		return;
	}
	fnMessageModalConfirm("알림", "원자재(1LEV)의 선택한 내용을 삭제하시겠습니까?<br />원자재 삭제시 하위의 부자재도 모두 삭제됩니다.", function(result) {
		if(result) {
			var strUrl = "/info/deleteBomlist";
			var postData = 
				"c_item_code=" + grid_lev1_data.c_item_code
				+"&product_item_code=" + grid_lev1_data.product_item_code
				+"&business_code=" + grid_lev1_data.business_code
				+"&m_item_code=" + grid_lev1_data.m_item_code
				+"&stufe=" + 1
			;
			deletelev1_2(strUrl,postData);
		}
		
	});
}
function dellev2(){
	if(w2ui.grid_list5.getSelection().length == 0){
		fnMessageModalAlert("에러", "삭제하실 정보를 선택해주세요!");
		return;
	}
	fnMessageModalConfirm("알림", "부자재(2LEV)의 선택한 내용을 삭제하시겠습니까?", function(result) {
		if(result) {
			var strUrl = "/info/deleteBomlist";
			var postData = 
				"c_item_code=" + grid_lev2_data.c_item_code
				+"&product_item_code=" + grid_lev2_data.product_item_code
				+"&business_code=" + grid_lev2_data.business_code
				+"&m_item_code=" + grid_lev2_data.m_item_code
				+"&stufe=" + 2
			;
			deletelev1_2(strUrl,postData);
		}
		
	});
}

function deletelev1_2(strUrl,postData){
	$.ajax({
		 url: strUrl,
		 type: "POST",
		 dataType : 'json', 
		 data : postData, 
		 async : false,
		 success:function(data){
		 	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
		 	}
		 },
		 error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
		 }, complete : function(){
				$("#modal_add").modal('hide');
				requestGrid4();
				requestGrid5();
			}
	});
	$('#hiddenM_item_code').val('');
}

function excelFileDownload(){
	var gridCols = w2ui['grid_list2'].columns;
	var gridData = w2ui['grid_list2'].records;

	var fileName = 'Bom 관리.xlsx';
	var sheetTitle = 'Bom 관리';
	var sheetName = 'Bom 관리';
	
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
</script>

</body>
</html>