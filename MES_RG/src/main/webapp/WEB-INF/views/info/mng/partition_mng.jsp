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
		<jsp:param name="selected_menu_cd" value="1022" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			원자재 분할 관리 <small> 기준정보관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>기준정보관리 </a></li>
			<li class="active">원자재 분할 관리</li>
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
													<h3 class="box-title">원자재 선택</h3>
													<div class="box-tools pull-right">
														<button type="button" id="btn_search_csr" class="btn btn-warning btn-sm" onclick="loadList1()">조회</button>	 
													</div>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-6">
																<label>P/N</label> <input type="combo" id="item_code" name="item_code" class="form-control input-sm" placeholder="자재코드" onkeypress="if(event.keyCode==13) {loadList1(); return false;}">
															</div>
															<div class="col-sm-6">
																<label>품명</label> <input type="combo" id="item_nm" name="item_nm" class="form-control input-sm" placeholder="품명" onkeypress="if(event.keyCode==13) {loadList1(); return false;}">
															</div>
													
														</div>
													</div>
													<div id="grid_list" class="w2g-h200" style="margin-top: 10px;"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border" style=" background-color: #DB8EB5;">
													<h3 class="box-title">원자재 분할</h3>
													<div class="box-tools pull-right">
														<button type="button" id="btn_ins_csr" onclick="addRecord();" class="btn btn-primary btn-sm" onclick="">추가</button>
														<button type="button" id="btn_del_csr" onclick="delRecord();" class="btn btn-danger btn-sm" onclick="">삭제</button>	 
													</div>
												</div>
												<div class="box-body">
													<div id="grid_list2" class="w2g-h250"></div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-sm-8">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">분할적용제품 list</h3>
												<div class="box-tools pull-right">
													<button type="button" id="btn_ins_csr" onclick="openMod();" class="btn btn-primary btn-sm" onclick="">추가</button>
													<button type="button" id="btn_del_csr" onclick="delItem();" class="btn btn-danger btn-sm" onclick="">삭제</button>	 
												</div>
											</div>
											<div class="box-body">
												<div id="grid_list3" class="w2g-h600"></div>
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

	<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none;"><!-- data-backdrop="static"> -->
		<div class="modal-dialog modal-lg" style="width: 80%">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modal_title">분할 자재 적용 LIST 등록</h4>
	        	</div>
				<div class="modal-body" id="">
							<!-- frm_info -->
					<form id="frm_insertInfo" name="frm_insertInfo" class="form-horizontal">							
						
						<div class="form-group row">
							<div class="col-sm-4">
								<label for="" class="col-sm-4 col-form-label">품명</label>
								<input type="text" class="col-sm-8 clear-field" id="mod_raw_item_nm" disabled/>	
							</div>
							<div class="col-sm-4">
								<label for="" class="col-sm-3 col-form-label">분할비율</label>
								<input type="text" class="col-sm-4 clear-field" id="mod_partition_rate" disabled/>	
							</div>
						</div>
						
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">대상 목록</label>
						</div>
						
						<div class="form-group row">
							<div class="col-sm-6">
								<div class="col-sm-4">
									<label for="" class="col-sm-4 col-form-label">P/N</label>
									<input type="combo" class="col-sm-8 clear-field" id="mod_pn" />
								</div>
								<div class="col-sm-4">
									<label for="" class="col-sm-4 col-form-label">품명</label>
									<input type="combo" class="col-sm-8 clear-field" id="mod_item_nm"/>
								</div>
								<div class="col-sm-4">
									<button type="button" id="mod_search" class="btn btn-white btn-sm" onclick="modSearch()">검색</button>
									<button type="button" id="mod_addList" class="btn btn-white btn-sm" onclick="modAdd()">추가</button>
								</div>
							</div>
							<div class="col-sm-6">
								<button type="button" id="btn_ins_csr" onclick="modDel();" class="btn btn-primary btn-sm" onclick="">삭제</button>
							</div>
						</div>
						
						<div class="form-group row">
							<div class="col-sm-6">
								<div id="mgrid_list1" class="w2g-h600"></div>
							</div>
							<div class="col-sm-6">
								<div id="mgrid_list2" class="w2g-h600"></div>
							</div>
						</div>
						
			
					</form>
					
				</div>
				
				<div class="modal-footer">
					<div class="col-md-12 text-center">
						<button type="button" id="btn_mod_save" class="btn btn-success btn-sm" onclick="modInsert();">저장</button>
						<button type="button" id="btn_mod_cancel" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
$(function($) {
	
 	loadLeftGrid();
 	loadRightGrid();
 	
 	loadList1();
 	loadModGrid();
 	
})
var startValue_combo = "";
var curItemCD = "";
var curItemNm = "";
var curPartitionRate = "";
var curPartitionCD = "";
comboValue_nm = new Array;
comboValue_cd = new Array;
comboValue_pn = new Array;
comboValue_nm2 = new Array;
//var curitemSpec = "";

// modalGrid
function loadModGrid(){
	var rowArr= [];
	var tmpArr= [];
	 $('#mgrid_list1').w2grid({
		name:  'mgrid_list1',
		show:{
			selectColumn: true
		},
		multiSelect: true,
		columns:[
			{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},
			{ field:'item_spec', caption:'SPEC', style:'text-align:center', sortable: true}
		],
		sortData: [{field: 'item_nm', direction: 'ASC'}],
		records:[],
		onSelect : function(event){
		},
		onUnSelect: function(evnet){
		},
		onClick : function(event){
		}
	}); 
	
	 $('#mgrid_list2').w2grid({
		name:  'mgrid_list2',
		show: {
			selectColumn: true
	 	},
		multiSelect: true,
		columns:[
			{ field:'raw_item_code', caption:'원자재 코드', style:'text-align:center', hidden : true},
			{ field:'partition_code', caption:'원자재 분할코드', style:'text-align:center', hidden : true},
			
			{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},
			{ field:'item_spec', caption:'SPEC', style:'text-align:center', sortable: true}
		],
		sortData: [{field: 'item_nm', direction: 'ASC'}],
		records:[],
		onSelect : function(event){
		},
		onUnSelect: function(evnet){
		},
		onClick : function(event){
		}
	}) 
}

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
      		{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true}

			//{ field:'item_spec', caption:'item_spec', hidden : true, style:'text-align:center'},
		
			], 
		sortData: [{field: 'item_nm', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				//w2ui.grid_list3.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				curItemCD = data.item_code;
				curItemNm = data.item_nm;
				
				loadList2(curItemCD);
				
			}
		},
		onUnselect: function (event) {
			w2ui['grid_list2'].clear();
			w2ui['grid_list3'].clear();
			
			curItemCD = "";
			curItemNm = "";
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
	

	$('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
        multiSelect: true,
        columns: [                
        	{ field:'partition_code', caption:'분할자재코드', style:'text-align:center', hidden: true},
			{ field:'partition_rate', caption:'분할비율',  sortable: true,style:'text-align:center',
				editable:{
					type:'text'
				}
			},
			{ field:'raw_item_code', caption:'원자재코드', style:'text-align:center', hidden: true},
			{ field:'raw_item_nm', caption:'원품명', style:'text-align:center', hidden: true},
		
			], 
		sortData: [{field: 'partition_rate', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete= function(){
				var key = w2ui.grid_list2.getSelection();
	
				var data = w2ui.grid_list2.get(key[0]);
				curPartitionRate = data.partition_rate;
				curPartitionCD = data.partition_code;
				
				loadList3(curItemCD, curPartitionCD);
			}
			
		},
		onUnselect: function (event) {
			curPartitionRate = "";
			w2ui.grid_list3.clear();
		},
		onChange : function(event){
			event.onComplete= function(){
				var rdata = w2ui['grid_list2'].getChanges();
				var partitionCD ="";
				$.each(rdata, function(idx, nRId){
					if(nRId.partition_rate){
						
						nRId.partition_code = w2ui['grid_list2'].get(nRId.recid).partition_code;
						nRId.raw_item_code = curItemCD;
						nRId.raw_item_nm = curItemNm;
						
						if(nRId.partition_code ){
							 updPartitionDiv(nRId);
						}else {
							insPartitionDiv(nRId);	
						}
					}
				});
			}
		},
		onEditField: function(event) {
		   if (event.originalEvent.keyCode == 13 )
		   {
		      event.preventDefault();
		   }
		}, 
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
}



function loadRightGrid(){
	var rowArr = [];
	
	$('#grid_list3').w2grid({
		name : 'grid_list3',
		 show: {
				lineNumbers : true,
	            footer: true,
	            selectColumn : true
	        },
	    multiSelect: true,
        
        columns: [
		        	{ field:'raw_item_code', caption:'원자재 코드', style:'text-align:center', hidden : true},
					{ field:'partition_code', caption:'원자재 분할코드', style:'text-align:center', hidden : true},
        			{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
        			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},
        			{ field:'item_spec', caption:'SPEC', style:'text-align:center', sortable: true},
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
		}
		
		
    }); 
	
}

// 원자재 선택 그리드 select
function loadList1(){
	var page_url="/info/material/selectMaterial";
	var postData = "item_code=" + encodeURIComponent($("#item_code").val()) + "&item_nm=" + encodeURIComponent($("#item_nm").val()) + "&item_type_code=MD1245";
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					comboValue_nm.push(row.item_nm);
					comboValue_cd.push(row.item_code);
				});
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
				}
			} else {
				w2ui.grid_list.clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		},complete: function () {
			startValue_combo = ":)";
	
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("item_code").style.removeProperty("height");
		}
	});
}1

// 원자재 분할 그리드 select
function loadList2(itemCD){
	var page_url = "/info/partition/selectPartition";
	var postData = {
			raw_item_code : itemCD
	}
	w2ui['grid_list2'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			
			if(data.msg == "success" && data.data.length > 0){
				rowArr = data.data;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
				});
				
				w2ui['grid_list2'].records = rowArr;
			} else {
				w2ui['grid_list2'].clear();
			}
			
		}, complete : function() {
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
		}
	});
}

// 원자재 분할 적용 제품 그리드 selelct
function loadList3(itemCD, partitionCD){
	w2ui.grid_list3.clear();
	var pageUrl = "/info/partition/selectPartitionDetail";
	var postData = {
			raw_item_code : itemCD,
			partition_code : partitionCD,
			del_yn : 'N'
	};
	
	w2ui['grid_list3'].lock('loading...', true);
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : postData,
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
				})
				w2ui['grid_list3'].records = rowArr;
			} else {
				w2ui.grid_list3.clear();
			}
			w2ui['grid_list3'].refresh();
			w2ui['grid_list3'].unlock();
		},complete: function() {
		}
	});
}

// mod1 그리드 select
function modSearch(){
	
	w2ui['mgrid_list1'].clear();
	//w2ui['mgrid_list2'].clear();
	var key = w2ui.grid_list.getSelection();
	var current_recid = key[0];
	var data = w2ui.grid_list.get(current_recid);
	
	var raw_item_code =  data.item_code;
	var itemCode = $("#mod_pn").val();
	var itemNm = $('#mod_item_nm').val();
	var page_url = "/info/partition/selectPartitionList";
	var postData = {
		item_code : itemCode,
		item_nm : itemNm,
		raw_item_code : raw_item_code
	}
	
	var rec = [];
	var isPass = true;
	
	w2ui['mgrid_list1'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length>0 ){
				rowArr = data.rows
				tmpArr = w2ui['mgrid_list2'].records;
				
				$.each(rowArr, function(idx, row){
					$.each(tmpArr, function(idx, cData){
						if(cData.item_code == row.item_code){
							isPass = false;
							return;
						}
					})
					
					if(isPass){
						row.recid = idx + 1;
						rec.push(row);
					}
					isPass = true;
					comboValue_pn.push(row.item_code);
					comboValue_nm2.push(row.item_nm);
				});
				
				w2ui['mgrid_list1'].records = rec;
				$('#mod_pn').w2field('combo', { items: _.uniq(comboValue_pn,false) ,match : 'contains' });
				$('#mod_item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			} else {
				w2ui['mgrid_list1'].clear();
			}
			
		}, complete : function() {
			w2ui['mgrid_list1'].refresh();
			w2ui['mgrid_list1'].unlock();
		}
	});
	
}

// insert div partition
var add_idx=0;
function addRecord(){
	
	if(!curItemCD){
		fnMessageModalAlert("알림", "원자재를 선택 후 추가 해주세요.");	// Notification(MES)
		return false;
	}

	// chk pre event save
	var chkData = w2ui['grid_list2'].records;
	var chk = false;
	$.each(chkData, function(idx, data){
		if(!data.partition_code){
			fnMessageModalAlert("알림", "먼저 생성한 row를 추가 후 추가 해주세요.");	// Notification(MES)
			chk = true;
			return false;
		}
	});
	
	if(chk) return false;
	
	w2ui['grid_list2'].add({recid:'n_'+add_idx, partition_rate: ""});
	add_idx++;
}

function delRecord(){
	
	var delIdxs = w2ui['grid_list2'].getSelection();
	var rData;
	
	if( delIdxs.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( delIdxs.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else{
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
		
				$.each(delIdxs, function(idx, data){
					
					rData = w2ui['grid_list2'].get(data);
					if(rData.partition_code ){
						delPartitionDiv(rData);
					}
					w2ui['grid_list2'].remove(data);
				})

			}
		});
			
	}
	
	loadList2(curItemCD);
	w2ui['grid_list2'].refresh();
	w2ui['grid_list2'].selectNone();
	
}

function openMod(){
	
	if(!curItemCD || !curPartitionCD) {
		fnMessageModalAlert("알림", "원자재, 분할비율을 선택해 주세요.");	// Notification(MES)
		return false;
	}
	
	$(".clear-field").val('');
	w2ui['mgrid_list1'].clear();
	w2ui['mgrid_list2'].clear();
	
	$('#mod_raw_item_nm').val(curItemNm);
	$('#mod_partition_rate').val(curPartitionRate);
	
	 setTimeout(function(){
		 w2ui['mgrid_list1'].resize();
         w2ui['mgrid_list1'].refresh();
         w2ui['mgrid_list2'].resize();
         w2ui['mgrid_list2'].refresh();
	   }, 200);
	
	$("#modal_info").modal("show");
	
}


function modAdd(){
	var movData = w2ui['mgrid_list1'].getSelection();
	var rData;
	
	$.each(movData, function(idx, data){
		rData = w2ui['mgrid_list1'].get(data);
		rData.recid = rData.item_code;
		rData.raw_item_code = curItemCD;
		rData.partition_code = curPartitionCD;
		w2ui['mgrid_list2'].add(rData);
	})
	
	if(movData.length > 0) modSearch();
}
function modDel(){
	var delData = w2ui['mgrid_list2'].getSelection();
	$.each(delData , function(idx, num){
		w2ui['mgrid_list2'].remove(num);
	})
	if(delData.length > 0) modSearch();
	w2ui['mgrid_list2'].selectNone();
}

function delItem(){
	var delData = w2ui.grid_list3.getSelection();
	var rData;
	
	if( delData.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( delData.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else{
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
					
				$.each(delData, function(idx,num){
					rData = w2ui.grid_list3.get(num);
					delPartitionDetail(rData);
				})
		
			}
		});
	
	}
	
	loadList3(curItemCD, curPartitionCD);
	w2ui['grid_list3'].refresh();
	w2ui['grid_list3'].selectNone();
	
}
// connect server

function insPartitionDiv(insData){
	var page_url = "/info/partition/insPartition";
	var postData = insData;
	
	if(!insData.partition_rate){
		fnMessageModalAlert("알림", "비율 데이터 값이 정확하지 않습니다.");	// Notification(MES)
	}	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.msg == "success"){
				fnMessageModalAlert("결과", "원자재 분할 정보 등록을 완료 하였습니다.");	// Notification(MES)
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){
			loadList2(curItemCD);
		}
	});
	
}

// update div partition
function updPartitionDiv(updData ){
	var page_url = "/info/partition/updPartition";
	var postData = updData;
	
	if(!updData.partition_rate){
		fnMessageModalAlert("알림", "비율 데이터 값이 정확하지 않습니다.");	// Notification(MES)
	}	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.msg == "success"){
				fnMessageModalAlert("결과", "원자재 분할 정보 수정을 완료 하였습니다.");	// Notification(MES)
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){
			loadList2(curItemCD);
		}
	})
}

// delete div partition
function delPartitionDiv(delData){
	var page_url = "/info/partition/delPartitionAll";
	var postData = {
			partition_code : delData.partition_code,
			del_yn : 'Y'
	}
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.msg == "success"){
				
		
				
				fnMessageModalAlert("결과", "원자재 분할 정보 삭제를 완료 하였습니다.");	// Notification(MES)
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){
			
			var key = w2ui.grid_list.getSelection();

			var data = w2ui.grid_list.get(key[0]);
			
			curItemCD = data.item_code;
			curItemNm = data.item_nm;
			
			loadList2(curItemCD);
		}
	})
}

function modInsert(){
	var pageUrl = "/info/partition/insPartitionDetail";
	var postData = w2ui['mgrid_list2'].records;
	var p = "param=" + encodeURIComponent(JSON.stringify(postData));
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : p,
		dataType : 'json',
		success : function(data){
			if(data.status == 200){
				fnMessageModalAlert("결과", "원자재 분할 적용 제품을 등록 하였습니다.");	// Notification(MES)
				w2ui['mgrid_list2'].clear();
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){
			
			$("#modal_info").modal("hide");
			loadList3(curItemCD, curPartitionCD);
		}
		
	});
	
	
}

function delPartitionDetail(delData){
	var pageUrl = "/info/partition/delPartitionDetail"
	var postData = {
			partition_code : delData.partition_code,
			raw_item_code : delData.raw_item_code,
			item_code : delData.item_code,
			del_yn : 'Y'
	}
	
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			fnMessageModalAlert("결과", "원자재 분할 적용 제품 정보 삭제를 완료 하였습니다.");	// Notification(MES)
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){}
	})
}

</script>

</body>
</html>