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
		<jsp:param name="selected_menu_cd" value="1024" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			공정 관리 <small> 기준정보관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>기준정보관리 </a></li>
			<li class="active">공정 관리</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box" style="margin-bottom:0px; border: none;">
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
									<div class="col-sm-6">
										<div class="row">
											<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border" style=" background-color: #DB8EB5;">
													<h3 class="box-title">대상제품</h3>
													<div class="box-tools pull-right">
<!-- 														<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-primary btn-sm" onclick="">그룹추가</button> -->
														<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
														<button type="button" id="btn_search" class="btn btn-info btn-sm" onclick="excelFileDownload();">전품목 엑셀다운로드</button> 
													</div>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-12">
																<div class="col-sm-2">
																	<label>Business</label> 
																</div>
																<div class="col-sm-3">
																	<select id="business" name="business" class="form-control" style="height: 30px;" ></select>
																</div>
																
																 <div class="col-sm-2">
													                  <label for="rdo_routing_yn" class="control-label">라우팅여부</label>
													             </div>
													             
													             <div class="col-sm-4">    
												                  	 <label>
														               <input type="radio" name="rdo_routing_yn" class="flat-red form-control" value="ALL" checked> 전체 
														             </label>
														             
														             <label>
														               <input type="radio" name="rdo_routing_yn" class="flat-red form-control" value="N" > 구성전
														             </label>
														             
														             <label>
														               <input type="radio" name="rdo_routing_yn" class="flat-red form-control" value="Y" > 구성후
														             </label>
																</div>
																
															</div>
															
															<div class="col-sm-12">
																<div class="col-sm-5">
																	<div class="form-group">
																		 <label>품명</label> 
																		 <input type="combo" id="item_nm" name="item_nm" class="form-control input-sm" placeholder="품명" 
																					onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
																	</div>
																</div>
																
																<div class="col-sm-5">
																	<div class="form-group">
																		<label>P/N</label> 
																		 <input type="combo" id="item_code" name="item_code" class="form-control input-sm" placeholder="P/N" 
																					onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
																	</div>
																</div>
															</div>
															
														</div>
													</div>
													<div id="grid_list" style="margin-top: 10px; height: 490px;"></div>
												</div>
											</div>
										</div>
										
									</div>
									
									<div class="col-sm-6">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">공정별자재정보</h3>
												<div class="box-tools pull-right">
<!-- 													<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-primary btn-sm" onclick="">Main</button> -->
<!-- 													<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-primary btn-sm" onclick="">Sub</button> -->
													<button type="button" id="btn_del_csr" class="btn btn-info btn-sm" onclick="insertRouting();">Route 편집</button>	 
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
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">Route 편집</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
				
					<div class="row">
						<div class="form-group">
							<div class="col-sm-3 text-right" >
								<button type="button" id="" class="btn btn-primary btn-sm" onclick="processPoint();">공정창고포인트</button>
							</div>
							<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px;" >
								<button type="button" id="" class="btn btn-primary btn-sm" onclick="itemPoint();">제품창고포인트</button>
							</div>
							
							<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px;" >
								<button type="button" id="" class="btn btn-warning btn-sm" onclick="outsourcing();">외주처리</button>
							</div>
							
							<div class="col-md-5 text-center">
								<div class="box-tools">
									<span onclick="plus();" class="btn btn-success btn-sm" style="margin-right: 20px; width: 60px;"> 
										<i class="glyphicon glyphicon-plus"></i> 
									</span>
									<span onclick="minus();" class="btn btn-danger btn-sm" style="width: 60px;"> 
										<i class="glyphicon glyphicon-minus"></i> 
									</span>
					       	   	 </div>
							</div>
						</div>
					</div>
				
					<div class="row">
						<div class="col-md-12">
							<div id="modalGrid" style="width: 100%; height: 500px;" ></div>
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveProcess();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
var startValue_combo = "";
var comboValue_nm = new Array;
var comboValue_cd = new Array;
var routingGubun = [];

var processPointVl="";
var itemPointVl="";

$(function($) {
	fnCdD('business', 'MC1012');
	
	fnCdD('routingGubun', 'MC1015');
	
 	fnLoadCommonOption(); 
 	loadLeftGrid();
 	loadRightGrid();
 	
 	modalGrid();
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
	    		
	    		if(val != "routingGubun") {
		    		var sub = val.substr(0,2);
		    		
		    		//  if(valsub != "m_")
		    		if(sub.indexOf("m_") == -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						if( val == "business" && row.detail_code == "MD1282" ) {
							
						} else {
							$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						}
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		 			if( val == "business" ) {
		 				$("#"+val+" option:eq(1)").prop("selected", true);	
		 			}
	    		} else {
	    			var objt = new Object();
	    			$.each(rowArr, function(idx, row){
	    				objt = new Object();
	    				objt.filter1_val = row.filter1_val;
	    				objt.filter2_val = row.filter2_val;
	    				objt.text = row.code_nm;
	    				objt.id = row.detail_code;
	    				
	    				routingGubun.push(objt);
	    			});
// 	    			console.log("routingGubun");
// 	    			console.log(routingGubun);
	    		}	
	 			
	    	} else if(data.status == "200" && (data.rows).length==0 && val != "routingGubun" ) {
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
			{ field:'item_code', caption:'P/N',size:'15%', style:'text-align:center', sortable: true}, 
			{ field:'item_nm', caption:'품명', size:'25%',style:'text-align:center', sortable: true},
			{ field:'item_spec', caption:'Spec', size:'25%',style:'text-align:center', sortable: true},
			{ field:'routing_yn', caption:'라우팅여부',size:'10%', style:'text-align:center', sortable: true ,
				render : function(record, index, col_index){
					var val = this.getCellValue(index, col_index);
					if(val == "N")
						return '구성전';
					else if(val == "Y")
						return '구성후';
					else return val;
				}
			}
			], 
		sortData: [{field: 'item_code', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				//w2ui.grid_list2.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list2'].refresh();
				
				// 오른쪽 그리드
				requestItemName(data.item_code);
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
		}
		
	});
	loadList();	
}
	
	function loadList() {
		//// 조회 합시당
		console.log("loadList()");
		
		var page_url = "/info/material/selectMaterial";
		var postData = "item_code=" + encodeURIComponent($("#item_code").val())
		 + "&item_nm=" + encodeURIComponent($("#item_nm").val());
	
		// Business
		if( $("#business option:selected").val() != "ALL") {
			postData += "&business_code=" + encodeURIComponent($("#business option:selected").val());
			postData += "&business_codeT=" + "";
			if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
				postData +=  encodeURIComponent("MD1282");	
			} 
		} else {
			postData += "&business_code=" + encodeURIComponent("");
		}
		var routing_yn = $(':radio[name="rdo_routing_yn"]:checked').val();
		if( routing_yn != "ALL") {
			postData += "&routing_yn=" + encodeURIComponent( routing_yn );
		} else {
			postData += "&routing_yn=" + encodeURIComponent("");
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
						if(row.item_code)comboValue_cd.push(row.item_code);
						if(row.item_nm)comboValue_nm.push(row.item_nm);
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						
						$('#item_nm').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#item_code').w2field('combo', { items: comboValue_cd, match : 'contains' });
						
					}
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {
				startValue_combo = ":)";
		
				document.getElementById("item_code").style.removeProperty("height");
				document.getElementById("item_nm").style.removeProperty("height");
			}
		});
		
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
        
        columns: [
        			{ field:'routing_nm', caption:'공정명', style:'text-align:center', sortable: true},
        			{ field:'routing_code', caption:'코드', style:'text-align:center', sortable: true},
        			{ field:'warehouse_gubun', caption:'창고포인트', sortable: true, style:'text-align:center' ,
        				render : function(record, index, col_index){
        					var val = this.getCellValue(index, col_index);
        					if(val == "a")
        						return '공정창고포인트';
        					else if(val == "b")
        						return '제품창고포인트';
        					else return val;
        				}
        			},
        			
        			{ field:'outsourcing_gubun', caption:'외주처리', sortable: true, style:'text-align:center' /* ,
        				render : function(record, index, col_index){
        					var val = this.getCellValue(index, col_index);
        					if(val == "Y")
        						return '외주';
        					else if(val == "N")
        						return 'N';
        					else return val;
        				} */
        			},
        			
        			{ field:'machine_gubun', caption:'설비라우팅', sortable: true, style:'text-align:center', hidden: false},
        			
        			
        			{ field:'updater', caption:'수정자', style:'text-align:center', sortable: true},
        			{ field:'date_created', caption:'생성일자', sortable: true, style:'text-align:center' ,
        				render : function(record, index, col_index){
        					var val = this.getCellValue(index, col_index);
        					return val.substr(0, 16);
        				}
        			}
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
			event.onComplete = function() {
				console.log("onChange onComplete");
				// 이벤트 전체
// 				console.log(event);
				
				// 오브젝트
// 			    console.log(event.value_new);		
// 				console.log("event.column : " + event.column);	     
// 			    console.log(event.value_new.text);
			    
				   	//var rowData = w2ui.grid_list2.records[recid];	
				 	// console.log("rowData.item_name : " + rowData.item_name); 
					//w2ui['grid_list'].refresh();
			}
		}, 
		
		
    }); 
	
}

function requestItemName(requestItemName){
	var page_url = "/info/process/selectRouting_master";
	var postData = "item_code=" + encodeURIComponent(requestItemName);
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
					row.old_routing_code = row.routing_code;
					
					// itemPointVl, processPointVl
					if(row.warehouse_gubun == "a") {
						processPointVl = row.recid; // row.routing_seq;
					} else if(row.warehouse_gubun == "b") {
						itemPointVl = row.recid; // row.routing_seq;
					}
					
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

function insertRouting() {
	console.log("insertRouting()");
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "편집하고자 하는 공정 관리 항목을 1개 선택하여야 합니다."); // Notification
		return;
	}
	
	w2ui.modalGrid.clear();
	
// 	var soso = [];
// 	soso = w2ui['grid_list2'].records; // 얉은 복사 XXX

	// 깊은 복사 
	// string으로 변환하였다가 다시 object로 변환하기 때문에 이전 객체에 대한 참조가 없어지지만 JSON 메소드 자체가 성능면에서 다른 방법에 비해 굉장히 느리기 때문에 주의해야한다.
	var soso = JSON.parse(JSON.stringify(w2ui['grid_list2'].records)); 
	
	// 이거 쓰면 Array라선가.. 값을 보내면 [][][]][] 이렇게 뜸 >> 수정완료 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	// var soso = cloneObject(w2ui['grid_list2'].records); >> 0727 - 다음부터는 이 방법으로 쓰자..!!!!! recrods 잘 복사됩니다
	
	var soso2 = [];
	
	 $.each(soso, function(idx, row){
		 
		 
		 row.routing_gubun_cd =  row.routing_gubun;
// 		row.recid = row.routing_seq;
		if( row.warehouse_gubun == "a" ) {
			row.warehouse_gubun = "공정창고포인트";
		} else if( row.warehouse_gubun == "b" ) {
			row.warehouse_gubun = "제품창고포인트";
		}
		
// javascript each에서 array 삭제하기
// javascript array 배열 객체 삭제
//  value.replace(/\-/g,''); 
		if(row.routing_code.search( "-" ) != "-1" ) { // -1 이 있다면
// 			console.log("값이 -1이야");
// 			console.log("row.routing_code = " + row.routing_code);

// 			soso.remove(i);
// 			delete soso[i];
		} else {
			soso2.push(row);
		}
	});  
	
	// javascript array 배열 객체 삭제 remove
 
	
	w2ui['modalGrid'].records = soso2;
	
	setTimeout(function(){
	      w2ui['modalGrid'].resize();
	      w2ui['modalGrid'].refresh();
	   }, 200);
	
	$("#modal_info").modal('show');
}

//성민

var update_routingArr = new Array();

function selectUpdate_routing(check_routing_gubun){
	console.log("selectUpdate_routing() ");

	var page_url = "/info/selectUpdate_routing";
	var postData = "detail_code=" + encodeURIComponent(check_routing_gubun);
	


	$.ajax({
		url : page_url,
		type : 'POST',
        data: postData, 
		dataType : 'json',
		async : false,
		success : function(data) {
			
			if(data.status == 200 && (data.rows).length>=0 ) {
				rowArr = data.rows;
				
				update_routingArr = [];
				
				$.each(rowArr, function(idx, row){
				
					var update_routingObj = new Object();

					update_routingObj.id = row.update_routing;
					update_routingObj.code = row.update_routing;//셀렉박스 선택값
					//update_routingObj.routing_gubun = row.detail_code;
					update_routingObj.text = row.update_routing;//셀렉박스 내용
					update_routingObj.update_routing = row.update_routing;
					update_routingObj.update_routing_code = row.update_routing_code;
					update_routingObj.detail_code = row.detail_code;
					update_routingArr.push(update_routingObj);

					
				});
				console.log(update_routingArr);
				console.log("1.update_routingArr.length:::"+update_routingArr.length)
				
			} else {
			
			}

		},complete: function () {
			
			console.log("1.update_routingArr.length:::"+update_routingArr.length)
		}
	});
	
}


//



function modalGrid() {
	console.log("modalGrid()");
	
	var rowArr = [];
	
	$('#modalGrid').w2grid({ 
        name: 'modalGrid',
        show: {
			lineNumbers : true,
            footer: true, 
            selectColumn: true
        },
        multiSelect: true,
        
        
        columns: [
			{ field : 'routing_seq', caption : '순번', style : 'text-align:center', editable : { type : 'int', min : 1, max : 99999 } }, 

	
			{field: 'routing_gubun', caption: '공정구분', 
													// routingGubun
                editable: { type: 'select', items: [ {  id: '', text: ''  } ].concat(routingGubun) } , 
                render: function (record, index, col_index) {
                    var html = '';
                    for (var p in routingGubun) {
                        if (routingGubun[p].id == this.getCellValue(index, col_index)) html = routingGubun[p].text;
                        
//                         if(w2ui.modalGrid.getSelection() != '' && w2ui.modalGrid.getSelection() != undefined && w2ui.modalGrid.getSelection() != null){
                        	
// 	        				var keys = w2ui.modalGrid.getSelection();
// 	    					var row = w2ui.modalGrid.get(keys[0]);					
// 	    					var routing_nm = row.routing_nm;
// 	    					if(routing_nm != '' && routing_nm != undefined && routing_nm != null){
// 	    					w2ui.modalGrid.set(keys[0] , {routing_nm : ''});
// 	    					console.log("아이유")
// 	    					}
//                         }

                    }
                    return html;
                } 
            }, 
            { field:'old_routing_code', caption:'기존 공정코드', style:'text-align:center', hidden: true},          
			{ field:'routing_code', caption:'공정코드', style:'text-align:center'},
			{ field:'routing_nm', caption:'공정명', style:'text-align:center'}, 
			{ field:'warehouse_gubun', caption:'포인트', style:'text-align:center'}, 
			{ field:'outsourcing_gubun', caption:'외주처리', style:'text-align:center' /* ,
				render : function(record, index, col_index){
					var val = this.getCellValue(index, col_index);
					if(val == "Y")
						return '외주';
					else if(val == "N")
						return 'N';
					else return val;
				} */
			}, 
			{ field:'machine_gubun', caption:'설비라우팅', style:'text-align:center', hidden: false}
			
			], 
// 		sortData: [{field: 'routing_seq', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) { 
			
			event.onComplete = function () {
				
				var eventColumn = event.column;
				
				var key = w2ui.modalGrid.getSelection();

				var current_recid = key[0];
				
				var last_recid = w2ui.modalGrid.records.length;
			
				var data = w2ui.modalGrid.get(current_recid);
				
				var routing_gubun = data.routing_gubun;
				

 				if(routing_gubun != '' && routing_gubun != undefined && routing_gubun != null){
 	
				console.log('eventColumn : ' + eventColumn);
				console.log('routing_gubun : ' + routing_gubun);	
				
				console.log("update_routingArr.length:::"+update_routingArr.length)
				
		
	               selectUpdate_routing(routing_gubun);
	              	 	
	            	   	
	               			var re_update_routingArr = [];
	               			console.log("update_routingArr.length:::"+update_routingArr.length)
	               			console.log("re_update_routingArr.length:::"+re_update_routingArr.length)
	  					
	               		 	for(var i = 0; i< update_routingArr.length; i++){
               			
		               			var row = update_routingArr[i];
			               		var update_routingObj = new Object();
			               		
			               		update_routingObj.id = row.code;
			               		update_routingObj.code = row.detail_code;
								update_routingObj.text = row.update_routing;
								update_routingObj.update_routing_code = row.update_routing_code;
								re_update_routingArr.push(update_routingObj);
								
	               				
               			} 
	               		 	
	               			console.log("update_routingArr.length:::"+update_routingArr.length)
	               			console.log("re_update_routingArr.length:::"+re_update_routingArr.length)
	               		if(re_update_routingArr.length>0){
							w2ui['modalGrid'].columns[4].editable = { type: 'select', items: [ {  id: '', text: ''  } ].concat(re_update_routingArr) };
	  					}else
		            	{
	  						w2ui['modalGrid'].columns[4].editable = false;
		            	}
                }else{
                	w2ui['modalGrid'].columns[4].editable = false;
                	}
				
			
			}

			
		},
		onUnselect: function (event) {
			event.onComplete = function () {
			}
		},
		onClick: function (event) { 
			
		},
		onChange: function(event) {
			event.onComplete = function () {
				console.log("onChange");
				
				var selekey = w2ui.modalGrid.getSelection();
		    	var selekeynum = Number(selekey);

				
				
				var eventColumn = event.column;
				if(eventColumn == 1) {
					w2ui.modalGrid.save();
					var key = event.recid; // w2ui.modalGrid.getSelection();
														// row, index
					var lenMark = "컬럼Text 가져오기 해야햄";//w2ui['modalGrid'].getCellValue(key -1, event.column);
					var get = w2ui['modalGrid'].get(key);
					var caption = w2ui.modalGrid.columns[event.column].caption; // 컬럼명 나오게 하기										
					var getrouting_gubun = "";
					var rdss  = w2ui.modalGrid.records;
					$.each(rdss, function(idx, row){
						if(key == row.recid) {
							getrouting_gubun = w2ui.modalGrid.records[idx].routing_gubun; //w2ui['modalGrid'].get(key).routing_gubun;
						}
					});

					var machine_gubun = "N";
					
					$.each(routingGubun, function(idx, row){
						if(getrouting_gubun == row.id) {
							//getrouting_gubun = row.filter1_val; //w2ui['modalGrid'].get(key).routing_gubun;
							
							console.log("row.filter2_val = " + row.filter2_val);
							// 여기서 filter2_val이 매칭이면 'Y'로 저장해서 보내기
							if(row.filter2_val == "MACHINE") {
								machine_gubun = "Y";
							} else {
								machine_gubun = "N";
							}
						}
					});
					
					w2ui['modalGrid'].set( key , { routing_code: '', routing_nm: '', warehouse_gubun: '' });
					
					w2ui['modalGrid'].set( key , { machine_gubun: machine_gubun });
					
					var eventColumn = event.column;
					
					var key = w2ui.modalGrid.getSelection();

					var current_recid = key[0];
					
					var last_recid = w2ui.modalGrid.records.length;
				
					var data = w2ui.modalGrid.get(current_recid);
					
					var routing_gubun = data.routing_gubun;
					
					
					
					console.log('eventColumn:::'+eventColumn);
					console.log('routing_gubun:::'+routing_gubun);	
					console.log("update_routingArr.length:::"+update_routingArr.length);
					
			
		               selectUpdate_routing(routing_gubun);
		              	 	
		            	   	
		               			var re_update_routingArr = [];
		               			console.log("update_routingArr.length:::"+update_routingArr.length)
		               			console.log("re_update_routingArr.length:::"+re_update_routingArr.length)
		  					
		               		 	for(var i = 0; i< update_routingArr.length; i++){
	               			
			               			var row = update_routingArr[i];
				               		var update_routingObj = new Object();
				               		
				               		update_routingObj.id = row.code;
				               		update_routingObj.code = row.detail_code;
									update_routingObj.text = row.update_routing;
									
									update_routingObj.update_routing_code = row.update_routing_code;
									update_routingObj.detail_code = row.detail_code;
									
									re_update_routingArr.push(update_routingObj);
									
		               				
	               			} 
		               		 	
		               			console.log("update_routingArr.length:::"+update_routingArr.length)
		               			console.log("re_update_routingArr.length:::"+re_update_routingArr.length)
		               		if(re_update_routingArr.length>0){
								w2ui['modalGrid'].columns[4].editable = { type: 'select', items: [ {  id: '', text: ''  } ].concat(re_update_routingArr) };
		  					}else
			            	{
		  						w2ui['modalGrid'].columns[4].editable = false;
			            	}
		               	 	
				   
				}else if(eventColumn == 4) {
					console.log("onChange 4번");
					
					w2ui.modalGrid.save();
					var key2 = event.recid;
					var get = w2ui['modalGrid'].get(key2);
					
					var key = w2ui.modalGrid.getSelection();

					var current_recid = key[0];
					
					var last_recid = w2ui.modalGrid.records.length;
				
					var data = w2ui.modalGrid.get(current_recid);
					
					var routing_gubun = data.routing_gubun;
					
					var getRouting_code = "";
					
					var rdss  = w2ui.modalGrid.records;
					
					selectUpdate_routing(routing_gubun);
					
					$.each(rdss, function(idx, row){
						if(key2 == row.recid) {
							console.log("탓당11111111");
							getRouting_code = w2ui.modalGrid.records[idx].routing_nm; //w2ui['modalGrid'].get(key).routing_gubun;
							
						}
					});
					console.log("getRouting_code???1111111" + getRouting_code);
					
					console.log("update_routingArr---------:");
					console.log(update_routingArr);
					
					$.each(update_routingArr, function(idx, row){
						
						if(getRouting_code == row.update_routing) {
							console.log("탓당2222222");
							getRouting_code = row.update_routing_code; //w2ui['modalGrid'].get(key).routing_gubun;
						}
					});
					
					console.log("getRouting_code???2222222" + getRouting_code);
					w2ui['modalGrid'].set( key2 , { routing_code : getRouting_code });
				}

				
			}
		}	
	});
}

//오른쪽 그리드에 값 추가시
function plus() {
	console.log("plus()");
	
	var rowArr = w2ui['modalGrid'].records;
	var key = "";
	if(rowArr.length == 0 ){
		recidV = "10";
		key = 1;
	} else {
		var recidV = rowArr[rowArr.length-1].routing_seq;
		console.log("recidV = "+recidV);
		key = (rowArr[rowArr.length-1].recid + 1);
		if(typeof recidV === "undefined" || recidV == '' ) {
			recidV = "10";
		} else {
			
			if( ( Math.ceil(parseInt(recidV)/10)*10 - parseInt(recidV) ) != 0) {
				recidV = Math.ceil(parseInt(recidV)/10)*10; // parseInt(recidV) + 10;
			} else {
				recidV = (Math.ceil(parseInt(recidV)/10)*10)+10 ; 
			}
			
		}
	}
	
	w2ui['modalGrid'].add([
		{ recid: key, routing_seq: recidV, routing_gubun: '', routing_code: '', routing_nm: '', warehouse_gubun: '', outsourcing_gubun: 'N'  }
	]);
	 
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

function processPoint() { 
	console.log("processPoint()");
	
	var key = w2ui.modalGrid.getSelection();
	var chkLen = key.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '공정창고포인트를 부여할 항목을 1개 선택해야 합니다.');		
	} else if( chkLen>1 ) {
		fnMessageModalAlert('알림', '공정창고포인트를 부여할 항목을 1개 선택해야 합니다.');		
	} else {
		key = parseInt(key);
		if( processPointVl == "" ) {
			w2ui['modalGrid'].set( key, { 'warehouse_gubun': '공정창고포인트' });
		} else { // 공백이 아니면
			processPointVl = parseInt(processPointVl);
			w2ui['modalGrid'].set( processPointVl, { warehouse_gubun: '' } );
			w2ui['modalGrid'].set( key, { warehouse_gubun: '공정창고포인트' } );			
		}
		
		processPointVl = key;
		if(itemPointVl == key ){
			itemPointVl = "";
		}
	 }
}

// itemPoint
function itemPoint() { 
	console.log("itemPoint()");
	
	var key = w2ui.modalGrid.getSelection();
	var chkLen = key.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '제품창고포인트를 부여할 항목을 1개 선택해야 합니다.');		
	} else if( chkLen>1 ) {
		fnMessageModalAlert('알림', '제품창고포인트를 부여할 항목을 1개 선택해야 합니다.');		
	} else {
		key = parseInt(key);
		if( itemPointVl == "" ) {
			w2ui['modalGrid'].set( key, { 'warehouse_gubun': '제품창고포인트' });
		} else { // 공백이 아니면
			itemPointVl = parseInt(itemPointVl);
			w2ui['modalGrid'].set( itemPointVl, { warehouse_gubun: '' } );
			w2ui['modalGrid'].set( key, { warehouse_gubun: '제품창고포인트' } );			
		}
		
		itemPointVl = key;
		if(processPointVl == key ){
			processPointVl = "";
		}
	 }
}

function outsourcing() {
	var key = w2ui.modalGrid.getSelection();
	var chkLen = key.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '외주처리를 부여할 항목을 1개 선택해야 합니다.');		
	} else {		
		for ( var i=0; i<chkLen; i++ ) {
			var iKey = key[i];
			var getOut = w2ui.modalGrid.get(iKey).outsourcing_gubun;
			console.log(" getOut = " + getOut );
			
			if ( getOut == "N" ) {
				w2ui['modalGrid'].set( iKey, { outsourcing_gubun: 'Y' } );	
			} else if ( getOut == "Y" ) {
				w2ui['modalGrid'].set( iKey, { outsourcing_gubun: 'N' } );	
			} 
		}
	 }
}

function saveProcess() {
	console.log("saveProcess()");
	w2ui.modalGrid.save();
	var ale = "";
	var btnV = 0; // 숫자가 2야함.
	var records = w2ui.modalGrid.records;
	
	var recordsLength = w2ui.modalGrid.records.length;
	console.log("recordsLength = " + recordsLength);
	
	$.each(records, function(idx, row){
		if( row.warehouse_gubun != "" ){
			btnV = btnV + 1;
		}
		
		if( row.routing_nm == "" || row.routing_code == "" || row.routing_gubun == "" ) {
			ale = "O";
		}
	});
	
	if(recordsLength > 0 && btnV != 2 || ale == "O" ) {
		fnMessageModalAlert("알림", "공정명, 공정코드, 공정창고포인트, 제품창고포인트는 비워둘 수 없습니다. 다시 입력해 주세요.");
		return;
	}	
	
	FunLoadingBarStart();
	
	var kkkk = w2ui.grid_list.getSelection();
	var itCd = w2ui.grid_list.get(kkkk[0]).item_code;
	
	var page_url = "";
	var postData = "";
	
	if(recordsLength > 0 ) {
		page_url = "/info/process/saveRouting_master";
		
		postData = "gridData=" + encodeURIComponent(JSON.stringify(records))
		+ "&itCd=" +  encodeURIComponent(itCd);
		
	} else if (recordsLength == 0) {
		page_url = "/info/process/delRouting_master";
		postData = "itCd=" +  encodeURIComponent(itCd)
			+ "&recordsLength=" +  encodeURIComponent(recordsLength);
		// records length가 0이면 자재관리의 routing_yn이 다시 N으로 변경된다!
		// 이걸 값 하나를 보내서 서비스에서 하장.... >>이 값이 N이면 레코드 다 없앰 > Y이면 값 있음
		// 이거 해서 자재 관리에 use_yn을 y / n 유무 결정 ㄱㄱ
	}
	
	console.log("page_url="+ page_url);
	
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
			$("#modal_info").modal('hide');
			FunLoadingBarEnd();
			loadList();
			requestItemName(itCd);
		}
	});
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
var total = [];
var grid = [];
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = grid;
	console.log("gridCols:::"+gridCols)
	console.log("JSON.stringify(gridCols):::"+JSON.stringify(gridCols));
	var gridData = total;
	console.log("gridData:::"+gridData);

	var fileName = '공정관리.xlsx';
	var sheetTitle = '공정관리';
	var sheetName = '공정관리';
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = true;
	
	if(gridCols != null && gridCols.length > 0){
		for(var i=0; i<gridCols.length; i++){
			if(!gridCols[i].hidden){
				param_col_id = "item_code" + "," + "routing_nm1"+ "," + "routing_nm2" + "," + "routing_nm3"  ;
				param_col_name = "P/N" + "," + "공정명1" + "," + "공정명2" + "," + "공정명3" ;
				param_col_align = "center" + "," +"center" + ","+"center"+","+"center";
				param_col_width = "10" + "," +"10" + ","+"10"+","+"10";
			}
		}
	}


	var export_url = "/export/export_client_jqgrid_2";
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