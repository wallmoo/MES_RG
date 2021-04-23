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
		<jsp:param name="selected_menu_p_cd" value="1015" />
		<jsp:param name="selected_menu_cd" value="1074" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			창고 마스터 관리 <small> 창고관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>창고관리 </a></li>
			<li class="active">창고 마스터 관리</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box" style="margin-bottom:0px; border: none;">
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
									<div class="col-sm-5">
										<div class="row">
											<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border" style=" background-color: #DB8EB5;">
													<h3 class="box-title">창고 정보</h3>
													<div class="box-tools pull-right">
<!-- 														<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	  -->
															<button type="button" id="btn_search_master" onclick="addRecord('grid_list');" class="btn btn-primary btn-sm" onclick="">추가</button>	 
<!-- 															<button type="button" id="btn_search_master" onclick="masterUpdate();" class="btn btn-info btn-sm" onclick="">수정</button>	  -->
															<!-- <button type="button" id="btn_search_master" onclick="masterDelete();" class="btn btn-danger btn-sm" onclick="">삭제</button>	 -->
															<button type="button" id="btn_del_master" onclick="delMaster();" class="btn btn-danger btn-sm" onclick="">삭제</button>	 
													</div>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-6">
																<div class="form-group" style="margin-bottom: 0px;">
																	<label>Business</label>
																	<div class="form-group" style="margin-bottom: 0px;">
																		<select id="business" name="business" class="form-control" style="height: 30px;" ></select>
																	</div>
																</div>
															</div>		
															
														</div>
													</div>
													<div id="grid_list" style="margin-top: 10px; height: 560px;"></div>
												</div>
											</div>
										</div>
										
									</div>
									
									<div class="col-sm-7">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">창고 상세정보</h3>
												<div class="box-tools pull-right">
 													<button type="button" id="btn_search_master" onclick="plus();" class="btn btn-primary btn-sm" onclick="">추가</button>
													<button type="button" id="btn_search_master" onclick="detailUpdate();" class="btn btn-success btn-sm" onclick="">저장</button>	 
													<button type="button" id="btn_search_master" onclick="detailDelete();" class="btn btn-danger btn-sm" onclick="">삭제</button>	 
												</div>
											</div>
											<div class="box-body">
												<div id="grid_list2" class="w2g-h600"></div>
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
var listValue = [];

var processPointVl="";
var itemPointVl="";
// var getChangeValue = [];
$(function($) {
	fnCdD('business', 'MC1012');
	
	fnCdD('listValue', 'MC1014');
	
 	fnLoadCommonOption(); 
 	loadLeftGrid();
 	loadRightGrid();
 	
})

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
}


	$(":radio[name='rdo_routing_yn']").on('ifChecked', function(event){
		  console.log("ssss = " + $(":radio[name='rdo_routing_yn']:checked").val());
		  loadList();
	});

$("#business").change(function(){
	loadList();
	w2ui['grid_list'].selectNone();
});

function fnCdD(val, val2){
	console.log("fnCdD("+val+")");
	
	initOptions($('#'+val)); // select 박스 초기화
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent(val2);
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
// 	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		if(val != "listValue") {
		    		var sub = val.substr(0,2);
		    		
		    		//  if(valsub != "m_")
// 		    		if(sub.indexOf("m_") == -1) // val
// 		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						if( val == "business" && row.detail_code == "MD1282" || row.detail_code == "MD1526" ) {
							
						} else {
							$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						}
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		 			/* if( val == "business" ) {
		 				$("#"+val+" option:eq(1)").prop("selected", true);	
		 			} */
	    		} else {
	    			var objt = new Object();
	    			$.each(rowArr, function(idx, row){
	    				objt = new Object();
	    				objt.code = row.detail_code;
	    				objt.text = row.code_nm;
	    				objt.id = row.code_nm;
	    				
	    				listValue.push(objt);
	    			});
// 	    			console.log("listValue");
// 	    			console.log(listValue);
	    		}	
	 			
	    	} else if(data.status == "200" && (data.rows).length==0 && val != "listValue" ) {
	    		initOptions($('#'+val)); // select 박스 초기화
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
	
}

// loadLeftGrid
function loadLeftGrid(){
// 	 console.log('fnSetLoadWorkerGrid()');
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : true,
            footer: true, 
            selectColumn: true
        },
        multiSelect: false,
        columns: [                
			{ field:'warehouse_code', caption:'마스터창고 코드', style:'text-align:center', hidden: true}, 
			{ field:'warehouse_nm', caption:'마스터창고', style:'text-align:center', editable:{ type:'text' } }
			], 
// 		sortData: [{field: 'warehouse_code', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				//w2ui.grid_list2.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();
				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list2'].refresh();
				
				// 오른쪽 그리드
				loadList2(data.warehouse_code);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list2'].clear();		
				w2ui['grid_list2'].refresh();
			}
		},
		onClick: function (event) {
// 		 	grid_list2(); // 클릭 이벤트
		},
		onChange : function(event){
			event.onComplete= function(){				
				console.log("등록한 값 = " + event.value_new);
				if(event.value_new.length > 40 ) {
					fnMessageModalAlert("알림", "마스터 창고의 글자수를 40이하로 입력해 주세요.");
					return;
				}
				
				var rdata = w2ui['grid_list'].getChanges();
// 				console.log('rdata changes');
// 				console.log(rdata);
				
				w2ui['grid_list'].save();
				
				// ★★★★ 내일에 하장
				$.each(rdata, function(idx, nRId){
					if(nRId.warehouse_nm){
						// 비지니스 조회하는 곳에서 전체가 사라지고 비지니시 selected된 값으로 저장 하게 함. nRid 이 변수가 저장할때로 감
						nRId.warehouse_nm = w2ui['grid_list'].get(nRId.recid).warehouse_nm;
						nRId.warehouse_code = w2ui['grid_list'].get(nRId.recid).warehouse_code; // warehouse_code 코드 구하기
						nRId.business_code = $("#business option:selected").val();
						nRId.business_nm = $("#business option:selected").text();
								
								
						if(nRId.warehouse_code ){ // 이거 있으면 수정임
							console.log("수정");
							 updWarehouseDiv(nRId);
						}else {
							console.log("등록");
							insWarehouseDiv(nRId); // 이거 없음 등록임
						}
						// ★★★★ 내일에 하장
					}
				});
			}
		},
		onEditField: function(event) {
		   if (event.originalEvent.keyCode == 13 )
		   {
		      event.preventDefault();
		   }
		}
		
	});
	loadList();	
}
	
	function loadList() {
		//// 조회 합시당
		console.log("loadList()");
		
		var page_url = "/frontend/warehouse/selectWarehouse_master_header";
		var postData = "";
	
		// Business
		if( $("#business option:selected").val() != "ALL") {
			postData += "business_code=" + encodeURIComponent($("#business option:selected").val());
			postData += "&business_codeT=" + "";
			if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
				postData +=  encodeURIComponent("MD1282");	
			} 
		} else {
			postData += "business_code=" + encodeURIComponent("");
		}
		
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
					});
					w2ui['grid_list'].records = rowArr;
					
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {
				w2ui['grid_list2'].clear();
			}
		});
		
	}
	
	// 왼쪽 Master 그리드(Header)
	function insWarehouseDiv(insData){
		var page_url = "/frontend/warehouse/insertWarehouse_master_header";
		var postData = insData;
		
		if(!insData.warehouse_nm){
			fnMessageModalAlert("알림", "마스터 창고를 입력해 주세요.");	// Notification(MES)
			return;
		}	
		
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData,
			dataType : 'json',
			success : function(data){
				if(data.msg == "success"){
					fnMessageModalAlert("결과", "창고 마스터 관리 등록을 완료 하였습니다.");	// Notification(MES)
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
			}, complete : function(){
				loadList();
			}
		});
		
	}

	// update div partition
	function updWarehouseDiv(updData ){
		var page_url = "/frontend/warehouse/updateWarehouse_master_header";
		var postData = updData;
		
		if(!updData.warehouse_nm){
			fnMessageModalAlert("알림", "마스터 창고를 입력해 주세요.");	// Notification(MES)
			return;
		}	
		
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData,
			dataType : 'json',
			success : function(data){
				if(data.msg == "success"){
					fnMessageModalAlert("결과", "창고 마스터 관리 수정을 완료 하였습니다.");	// Notification(MES)
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
			}, complete : function(){
				loadList();
			}
		})
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
// 					{ field:'old_item_type_code', caption:'기존 자재유형코드', style:'text-align:center'},
        			{ field:'item_type_code', caption:'자재유형코드', style:'text-align:center'},
        			{field: 'item_type_nm', caption: '자재유형',  // routing_gubun
						// listValue
						editable: { type: 'select', items: [ {  id: '', text: ''  } ].concat(listValue) } , 
						render: function (record, index, col_index) {
							var html = '';
							for (var p in listValue) {
								if (listValue[p].id == this.getCellValue(index, col_index)) html = listValue[p].text;
							}
							return html;
						} 
					}, 
                 ],
		records: [  
		   ],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},

		onClick: function (event) {
		
		}, 
		onDblClick: function(event) {
			
		}, 
		onChange: function(event) {
			event.onComplete = function () {
				console.log("onChange");
// 				console.log("event");
// 				console.log(event);
				console.log("등록한 값 = " + event.value_new);
				var eventColumn = event.column;
				if(eventColumn == 1) {
// 					w2ui.grid_list2.save();
					
					var key = event.recid; // w2ui.grid_list2.getSelection();
					
					var getrouting_gubun = event.value_new; //"";
					/* var rdss  = w2ui['grid_list2'].getChanges(); // records;
					console.log("rdss");
					console.log(rdss);
					$.each(rdss, function(idx, nRId){
						getrouting_gubun = w2ui['grid_list2'].get(nRId.recid).item_type_nm; // w2ui.grid_list2.records[idx]. 
					}); */
					
					$.each(listValue, function(idx, row){
// 						console.log("getrouting_gubun = " + getrouting_gubun );
// 						console.log("row.id = " + row.id );
						if(getrouting_gubun == row.id) {
							getrouting_gubun = row.code; //w2ui['grid_list2'].get(key).routing_gubun;
							
						}
					});
					
					w2ui['grid_list2'].set( key , { item_type_code : getrouting_gubun });
					
// 					getChangeValue.push(key);
					
				}
			}
		}
		
		
    }); 
	
}

function loadList2(requestItemName){
	console.log("loadList2('"+requestItemName+"')");
	var page_url = "/frontend/warehouse/selectWarehouse_master_detail";
	var postData = "warehouse_code=" + encodeURIComponent(requestItemName);
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
// 					row.old_item_type_code = row.item_type_code;
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

//insert div partition
/* var add_idx=0;
function addRecord(grid){
	console.log("addRecord('"+grid+"')");

	// chk pre event save
	var chkData = w2ui['grid_list'].records;
	var chk = false;
	$.each(chkData, function(idx, data){
		if(!data.warehouse_nm){
			fnMessageModalAlert("알림", "먼저 생성한 row를 추가 후 추가 해주세요.");	// Notification(MES)
			chk = true;
			return false;
		}
	});
	
	if(chk) return false;
	
	w2ui['grid_list'].add({recid:'n_'+add_idx, warehouse_nm: ""});
	add_idx++;
} */


//insert div partition
function addRecord(grid){
	console.log("addRecord('"+grid+"')");
	console.log("w2ui[''+grid].records.length = " + w2ui[''+grid].records.length);
	
	var indexV = 1;
	
	if(w2ui[''+grid].records.length != 0 ) {
		indexV = w2ui[''+grid].get(w2ui[''+grid].records.length).recid+1;	
	}
	
	// chk pre event save
	var chkData = w2ui[''+grid].records; // 'grid_list'].records;
	var chk = false;
	$.each(chkData, function(idx, data){
		console.log("data");
		console.log(data);
		if(!data.warehouse_nm){
			fnMessageModalAlert("알림", "먼저 생성한 row를 추가 후 추가 해주세요.");	// Notification(MES)
			chk = true;
			return false;
		}
	});
	
	if(chk) return false;
	
	w2ui[''+grid].add([{recid:indexV, warehouse_nm: ""}]);
	
}

 function delMaster() {
	console.log("delMaster()");
 
	var key = w2ui['grid_list'].getSelection();
	
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui['grid_list'].get(key[0]);
		var code = data.warehouse_code;
		var business = $("#business option:selected").val();
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
// 				console.log("code = " + code);
// 				console.log("business = " + business );
				var strUrl = "/frontend/warehouse/deleteWarehouse_master_header";
				var postData = "warehouse_code=" + code
				 + "&business_code=" + encodeURIComponent(business);
				
				$.ajax({
					 url: strUrl,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
// 					 		console.log(data);
					 		loadList();
					 		w2ui['grid_list2'].clear();
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
 
 function detailDelete() {
		console.log("detailDelete()");
	 
		var key = w2ui['grid_list'].getSelection();
		var key2 = w2ui['grid_list2'].getSelection();
		
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {

			var data = w2ui['grid_list'].get(key[0]);
			var data2 = w2ui['grid_list2'].get(key2[0]);
			
			
			var code = data.warehouse_code;
			
			var item_type_code = data2.item_type_code;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
//	 				console.log("code = " + code);
//	 				console.log("business = " + business );
					var strUrl = "/frontend/warehouse/deleteWarehouse_master_detail";
					var postData = "warehouse_code=" + code
					 + "&item_type_code=" + encodeURIComponent(item_type_code);
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
//	 					 		console.log(data);
						 		loadList2();
						 		w2ui['grid_list2'].clear();
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
 
 


//오른쪽 그리드에 값 추가시 >> process_mng 참고
function plus() {
	console.log("plus()");
	console.log("w2ui['grid_list2'].records.length = " + w2ui['grid_list2'].records.length);
	var indexV = 1;
	
	if(w2ui['grid_list2'].records.length != 0 ) {
		console.log(":>");
		indexV = w2ui['grid_list2'].get(w2ui['grid_list2'].records.length).recid+1;	
	}
	
	// chk pre event save
	var chkData = w2ui['grid_list2'].records; // 'grid_list'].records;
	var chk = false;
	$.each(chkData, function(idx, data){
		if(!data.warehouse_nm){
			fnMessageModalAlert("알림", "먼저 생성한 row를 추가 후 추가 해주세요.");	// Notification(MES)
			chk = true;
			return false;
		}
	});
	
	if(chk) return false;
	
	w2ui['grid_list2'].add([
		{ recid: indexV, old_item_type_code: '', item_type_code: '', item_type_nm : ''  }
	]);
}

// detailUpdate
// function detailUpdate() {
// 	console.log("detailUpdate()");
// 	console.log("getChangeValue = ");
// 	console.log(getChangeValue);
	
// 	/* 
// 	$.each(spec, function(idx, row){
// 		if ($.inArray(row, result) === -1) {
// 			result.push(row);
//  			$("#specBox_1").append("<option value=" + row+ ">" + row + "</option>");
// 	 	}
// 	});
// 	*/
	
// 	var recordsLength = w2ui.grid_list2.records.length;
// 	var opo = "";
// 	for(var i=0; i<getChangeValue.length; i++ ) {
// 		var data = w2ui.grid_list.get(getChangeValue[i]);
// 		if( data.item_type_nm == "" ) {
// 			opo = "O";
// 		}
// 	}
	
// 	if( recordsLength > 0 && opo != "" ) {
// 		fnMessageModalAlert("알림", "자재유형은 비워둘 수 없습니다. 다시 입력해 주세요.");
// 		return;	
// 	}
	
// 	for(var i=0; i<getChangeValue.length; i++ ) {
// 		if(data.old_item_type_code ){ // 기존 코드가 있으면 수정
// 			updateWarehouse_detail(getChangeValue[i]);
// 		}else {
// 			insertWarehouse_detail(getChangeValue[i]);
// 		}
// 	}
		 
// }


// saveUpdate
function detailUpdate() { // insertWarehouse_detail(key) {
	console.log("detailUpdate()"); // saveUpdate()");
		w2ui.grid_list2.save();
		
// 		var data = w2ui['grid_list2'].get(key);

		var records = w2ui['grid_list2'].records;
		
		var kkkk = w2ui.grid_list.getSelection();
		var warehouse_code = w2ui.grid_list.get(kkkk[0]).warehouse_code;
		var warehouse_nm = w2ui.grid_list.get(kkkk[0]).warehouse_nm;		
// 		var item_type_code = data.item_type_code;
// 		var item_type_nm = data.item_type_nm;

		// 값 체크
	 	var recordsLength = records.length;
	 	if( recordsLength == 0 ) {
			console.log("recordsLength == 0");
			fnMessageModalAlert("알림", "입력한 값이 없습니다. 다시 입력해 주세요.");
			return;	
		}
		
		var opo = "";
		for(var i=0; i<recordsLength; i++ ) {
			var data = records[i];
			if( data.item_type_nm == "" || data.item_type_code == "" ) {
				opo = "O";
			}			
		}
		console.log("opo = " + opo);
		if( opo != "" ) {
			console.log("없음");
			fnMessageModalAlert("알림", "자재유형은 비워둘 수 없습니다. 다시 입력해 주세요.");
			return;	
		}
		// 값 체크
		
		var page_url = "";
		var postData = "";
		
			page_url = "/frontend/warehouse/saveWarehouse_master_detail";
			postData = "warehouse_code=" +  encodeURIComponent(warehouse_code)
			 + "&warehouse_nm=" +  encodeURIComponent(warehouse_nm)
			 + "&gridData=" + encodeURIComponent(JSON.stringify(records));
// 			+ "&item_type_nm=" +  encodeURIComponent(item_type_nm)
// 			"item_type_code=" +  encodeURIComponent(item_type_code);
		
		
		fnMessageModalConfirm("알림", "현재 등록하고자 하는 자재유형은 다른 마스터창고에서는 삭제됩니다.", function(result) {
			
			if(result) {
				FunLoadingBarStart();
				$.ajax({
					url : page_url,
					type : 'POST',
					data: postData,
					dataType : 'json',
					success: function(data, textStatus, jqXHR) {
						if (data.status == "200") {
							fnMessageModalAlert("알림", "편집을 완료 하였습니다.");
						} else {
							fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
					},	
					complete: function () {	
						FunLoadingBarEnd();
						loadList();
						loadList2(warehouse_code);
					}
				});
			}
		});		
	}


// 오른쪽 그리드에 값 삭제시
function minus() {
	var selIdxArr = w2ui.modalGrid.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
	}  else {
		for(var i=0; i<chkLen; i++){
		 	var row = w2ui.modalGrid.get(selIdxArr[i]);
		 	w2ui['modalGrid'].remove(row.recid);
		}
	 }
}


//자바스크립트 재귀 사용
//오브젝트의 프로퍼티들을 순회하여 빈 오브젝트에 더한다. 그 과정에서 원본 오브젝트의 프로퍼티가 오브젝트일 경우 재귀적으로 함수를 실행한다.
//이 방법은 객체를 깊은 복사(Deep Copy)한다.
function cloneObject(obj) {
 var clone = [];
 for(var i in obj) {
     if(typeof(obj[i])=="object" && obj[i] != null) {
     	clone.push( obj[i] );
     	cloneObject(obj[i]);
     } else {
     }
 }
 return clone;
}

//  자바스크립트 재귀 사용
// 오브젝트의 프로퍼티들을 순회하여 빈 오브젝트에 더한다. 그 과정에서 원본 오브젝트의 프로퍼티가 오브젝트일 경우 재귀적으로 함수를 실행한다.
// 이 방법은 객체를 깊은 복사(Deep Copy)한다.
/* function cloneObject(obj) {
    var clone = [];
    for(var i in obj) {
        if(typeof(obj[i])=="object" && obj[i] != null)
            clone[i] = cloneObject(obj[i]);
        else
            clone[i] = obj[i];
    }
    return clone;
} */


function initOptions(obj) {
    $(obj)
    .find('option')
    .remove()
    .end()
//	    .append('<option value="All">-----</option>')
    .val();
}

</script>

</body>
</html>