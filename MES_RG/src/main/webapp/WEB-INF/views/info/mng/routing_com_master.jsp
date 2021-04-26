<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
String memberId = SessionUtil.getMemberId(request);
String memberNm = SessionUtil.getMemberNm(request);
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
		<jsp:param name="selected_menu_cd" value="1102" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			라우팅 공통 마스터 <small> 기준정보관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>기준정보관리 </a></li>
			<li class="active">라우팅</li>
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
													<h3 class="box-title">라우팅 공통 마스터</h3>
<!-- 													<div class="box-tools pull-right"> -->
<!-- 														<button type="button" id="btn_search_csr" onclick="requestLeftGrid();" class="btn btn-primary btn-sm" onclick="">조회</button>	  -->
<!-- 													</div> -->
												</div>
												<div class="box-body">
<!-- 													<div class="row"> -->
<!-- 														<div class="form-group"> -->
<!-- 															<div class="col-sm-6"> -->
<!-- 																<label>품명</label> <input type="combo" id="Business" name="Business" class="form-control input-sm" placeholder="품명" onkeypress="if(event.keyCode==13) {requestLeftGrid(); return false;}"> -->
<!-- 															</div> -->
<!-- 														</div> -->
<!-- 													</div> -->
													<div id="grid_list" style="width: 100%; height: 600px;"></div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-sm-8">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">공정명 관리</h3>
												<div class="box-tools pull-right">
												
													<button type="button" id="btn_ins_csr" onclick="plus();"  class="btn btn-info btn-sm">행추가</button>
<!-- 												<button type="button" id="btn_search_csr" onclick="minus();" class="btn btn-primary btn-sm" onclick="">행삭제</button> -->
													<button type="button" id="btn_ins_csr" onclick="deleteRoutingCom();" class="btn btn-primary btn-sm">삭제</button>
													<button type="button" id="btn_ins_csr" onclick="saveRouting();" class="btn btn-primary btn-sm">저장</button>
												</div>
											</div>
											<div class="box-body">
<!-- 												<div class="row"> -->
<!-- 													<div class="form-group"> -->
<!-- 														<div class="col-sm-6"> --> 
<!-- 														<label>자재검색</label> <input type="combo" id="r_mt_name" name="r_mt_name" class="form-control input-sm" placeholder="자재검색"  --> 
<!-- 															 onkeypress="if(event.keyCode==13) {requestRightGrid(); return false;}" style="padding : 5px 10px;"> --> 
														
<!--  														</div> --> 
<!-- 													</div> -->
<!-- 												</div> -->
												<div id="grid_list2" style="width: 100%; height: 600px;"></div>
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

var memberId =  "<%=memberId%>";
var memberNm =  "<%=memberNm%>";

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
			lineNumbers : false,
            footer: true,
            selectColumn: true
        },
        multiSelect: false,
        columns: [
			{ field:'detail_code', caption:'라우팅 구분(코드)', style:'text-align:center', sortable: true},
			{ field:'code_nm', caption:'라우팅명', style:'text-align:center', sortable: true}

			], 
		sortData: [{field: '', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list2'].refresh();
				
				requestItemName(data.detail_code);
// 				w2ui['grid_list2'].refresh();
// 				// 오른쪽 그리드
// 				requestItemName(this.get(event.recid).item_code);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
 				w2ui['grid_list2'].clear();		
 				w2ui['grid_list2'].refresh();
// 				comboValue_cd = new Array;
			}
		},
		onClick: function (event) {
// 		 	grid_list2(); // 클릭 이벤트
		}
	});
	
	requestLeftGrid();
}

var detail_code ="";
var code_nm ="";
function requestLeftGrid(){
	var page_url = "/info/selectRouting_com_master";
	
	console.log("detail_code::::"+detail_code);
	console.log("code_nm::::"+code_nm);
	console.log("memberIdmemberId:::::"+memberId);
	
 	var postData = "detail_code=" + encodeURIComponent(detail_code)
 	+ "&code_nm=" + encodeURIComponent(code_nm);
	
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
// 					comboValue_nm.push(row.item_nm);
				});
				w2ui['grid_list'].records = rowArr;
// 				if (startValue_combo == "") {
// 					$('#Business').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
// 				}
			} else {
				w2ui.grid_list.clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
		}, complete : function() {
// 			startValue_combo = ":)";
			
// 			document.getElementById("Business").style.removeProperty("height");
		}
	});
}

let today = new Date();   

let year = today.getFullYear(); // 년도
let month = today.getMonth() + 1;  // 월
month = month >= 10 ? month : '0' + month;
let date = today.getDate();  // 날짜
date = date >= 10 ? date : '0' + date;
let day = today.getDay();  // 요일


console.log("today?" + today);
console.log("year?" + year);
console.log("month?" + month);
console.log("date?" + date);
console.log("day?" + day);

//오른쪽 그리드에 값 추가시
function plus() {
	console.log("plus()");
	var key = w2ui.grid_list.getSelection();

	var data = w2ui.grid_list.get(key[0]);

	console.log("data.detail_code:::"+data.detail_code)
	var rowArr = w2ui['grid_list2'].records;
	var key = "";
	if(rowArr.length == 0 ){
// 		recidV = "10";
		key = 1;
	} else {
// 		var recidV = rowArr[rowArr.length-1].routing_seq;
// 		console.log("recidV = "+recidV);
		key = (rowArr[rowArr.length-1].recid + 1);
// 		if(typeof recidV === "undefined" || recidV == '' ) {
// 			recidV = "10";
// 		} else {
			
// 			if( ( Math.ceil(parseInt(recidV)/10)*10 - parseInt(recidV) ) != 0) {
// 				recidV = Math.ceil(parseInt(recidV)/10)*10; // parseInt(recidV) + 10;
// 			} else {
// 				recidV = (Math.ceil(parseInt(recidV)/10)*10)+10 ; 
// 			}
			
// 		}
	}
	
	w2ui['grid_list2'].add([	                      
		{ recid: key, detail_code: data.detail_code ,   code_nm: data.code_nm    ,update_routing: '', update_routing_code: '', update_date: year + '-' + month + '-' + date, updater: memberNm}
		]);
	 
}

// function minus() {
// 	var selIdxArr = w2ui.grid_list2.getSelection();
// 	var chkLen = selIdxArr.length;
// 	if( chkLen==0 ) {
// 		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
// 	}  else {
// 		for(var i=0; i<chkLen; i++){
// 		 	var row = w2ui.grid_list2.get(selIdxArr[i]);
// 		 	w2ui['grid_list2'].remove(row.recid);
// 		}
// 	 }
// }

function saveRouting() {
	console.log("save라우팅()");
	w2ui.grid_list2.save();
	
	var records = w2ui.grid_list2.records;
	
	var ale = "";
	
	var recordsLength = w2ui.grid_list2.records.length;
	console.log("recordsLength = " + recordsLength);
	
	
// 	var key = w2ui.grid_list2.getSelection();
// 	var data = w2ui.grid_list2.get(key[0]);
	
// 	var grid_list_key = w2ui.grid_list.getSelection();
// 	var grid_list_data = w2ui.grid_list.get(grid_list_key[0]);
	
// 	var detail_code = grid_list_data.detail_code;
// 	var update_routing = data.update_routing;
// 	var update_date = data.update_date;
	
	var page_url = "";
	var postData = "";
	
	
	
	page_url = "/info/saveRouting";
	postData = 
	//"routing_code=" + encodeURIComponent(routing_code)
 	//+ "&update_routing=" + encodeURIComponent(update_routing)
	//+ "&update_date=" + encodeURIComponent(update_date);
		"gridData=" + encodeURIComponent(JSON.stringify(records));
	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData,
		dataType : 'json',
		success: function(data, textStatus, jqXHR) {
	
			var recordsLength = w2ui.grid_list2.records.length;
			console.log("recordsLength = " + recordsLength);
			
			
			
			if (data.status == "200") {
				fnMessageModalAlert("알림", "저장을 완료 하였습니다.");
			} else {
				fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
		},	
		complete: function () {	
			
		}
	});
	
}

function minus() {
	var selIdxArr = w2ui.grid_list2.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
	}  else {
		for(var i=0; i<chkLen; i++){
		 	var row = w2ui.grid_list2.get(selIdxArr[i]);
		 	w2ui['grid_list2'].remove(row.recid);
		}
	 }
}


//라우팅공통 삭제
function deleteRoutingCom() {
	console.log('deleteCustomer()');

	var key = w2ui.grid_list2.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui.grid_list2.get(key[0]);
		var code = data.update_routing;
		var chkLen = key.length;
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				console.log("code = " + code);
				
				var strUrl = "/info/deleteRoutingCom";
				var postData = "update_routing=" + code;
				
				for(var i=0; i<chkLen; i++){
				 	var row = w2ui.grid_list2.get(key[i]);
				 	w2ui['grid_list2'].remove(row.recid);
				}
				
				$.ajax({
					 url: strUrl,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
					 		console.log(data);
					 		///requestItemName(requestItemName);
					    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
					 	}
					 },
					 error: function(jqXHR, textStatus, errorThrown){
					    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
					 },
					 complete: function() {	
						 var key = w2ui.grid_list.getSelection();

							var data = w2ui.grid_list.get(key[0]);
							
 							//w2ui['grid_list2'].refresh();
							
 							//requestItemName(data.detail_code);
						
					 }
				});
				
			}
		});
	} 
}
	
	
function requestItemName(requestItemName){
	var page_url = "/info/selectRouting_com_master_2";
	var postData = "detail_code=" + encodeURIComponent(requestItemName);
	
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
					row.detail_code = row.detail_code;
					
				});
				w2ui['grid_list2'].records = rowArr;
			} else {
				//w2ui.grid_list.clear();
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
		}, complete : function() {}
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
	            selectColumn : false
	        },
	    multiSelect: false,
        
        columns: [	{ field:'detail_code', caption:'라우팅코드', style:'text-align:center' , sortable: true, hidden:true},
                  	{ field:'code_nm', caption:'code_nm', style:'text-align:center' , sortable: true, hidden:true},                 	
        			{ field:'update_routing', caption:'공정명', style:'text-align:center' , sortable: true, editable: { type: 'text' }},
        			{ field:'update_routing_code', caption:'공정코드', style:'text-align:center' , sortable: true, editable: { type: 'text' }, hidden:false},
        			{ field:'update_date', caption:'수정일자', style:'text-align:center', sortable: true},
        			{ field:'updater', caption:'수정자', style:'text-align:center', sortable: true}
        			
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
			
				console.log("onChange");
			event.onComplete = function () {
				
				console.log(event);
				
				var eventColumn = event.column;
				//w2ui.grid_list2.save();
				
				if(eventColumn == 3) {
					console.log("onChange222");
					w2ui.grid_list2.save();
					var key = event.recid;
					
					var get = w2ui['grid_list2'].get(key);
					var caption = w2ui.grid_list2.columns[event.column].caption; 
					var getrouting_gubun = "";
					var rdss  = w2ui.grid_list2.records;
					
					var checkUpdateCode = "";
					
					$.each(rdss, function(idx, row){
						if(key == row.recid) {
							checkUpdateCode = w2ui.grid_list2.records[idx].update_routing_code; 
						}
					});
					
					console.log("checkUpdateCode는???" + checkUpdateCode);
					
					selectUpdate_routing_code(checkUpdateCode);
					
				}
		}
		}, 
		
		
    }); 
}

function selectUpdate_routing_code(checkUpdateCode){
	console.log("selectUpdate_routing_code()");
	
	var page_url = "/info/selectUpdate_routing_code";
	var postData = "update_routing_code=" + encodeURIComponent(checkUpdateCode);
	//var key = w2ui.grid_list2.records.recid;
	
	$.ajax({
		url : page_url,
		type : 'POST',
        data: postData, 
		dataType : 'json',
		async : false,
		success : function(data) {
			
			if(data.status == 200 && (data.rows).length>=0 ) {
				rowArr = data.rows;
				
				update_routing_codeArr = [];
				
				$.each(rowArr, function(idx, row){
					
					
					console.log("row.update_routing_code???" + row.update_routing_code);
					if(row.update_routing_code == '-'){
						
						console.log("saveRouting탔다요");
						//saveRouting();
						
					}else{
						fnMessageModalAlert("알림", "이미 등록된 공정코드입니다.");	// Notification(MES)
						
						var selIdxArr = w2ui.grid_list2.getSelection();
						
						w2ui['grid_list2'].set( selIdxArr[0] , { update_routing_code : '' });
						return false;
					}
					
				});
				
				
			} else {
			
			}

		},complete: function () {
			//saveRouting(updateRoutingCode);
		}
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