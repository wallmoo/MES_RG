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
		<jsp:param name="selected_menu_cd" value="1025" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			품질 검사 항목 관리 <small> 기준정보관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li>
			<li class="active">품질 검사 항목 관리</li>
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
													<h3 class="box-title">검사그룹</h3>
													<div class="box-tools pull-right">
														
														<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
													</div>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-12">
																<div class="col-sm-2">
																	<label>Business</label> 
																</div>
																<div class="col-sm-5">
																	<select id="business" name="business" class="form-control" style="height: 30px;" ></select>
																</div>
																
															</div>
															
															<div class="col-sm-12">
															
																<div class="col-sm-5">
																	<div class="form-group">
																		<label>P/N</label> 
																		 <input type="combo" id="item_code" name="item_code" class="form-control input-sm" placeholder="P/N" 
																					onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
																	</div>
																</div>
																<div class="col-sm-5">
																	<div class="form-group">
																		 <label>품명</label> 
																		 <input type="combo" id="item_nm" name="item_nm" class="form-control input-sm" placeholder="품명" 
																					onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
																	</div>
																</div>
																
															
															</div>
															
															<!-- <div class="col-sm-12">
																<div class="col-sm-5">
																	<div class="form-group">
																		 <label>P/N</label> 
																		 <input type="combo" id="r_item_code" name="item_code" class="form-control input-sm" placeholder="P/N" 
																					 disabled >
																	</div>
																</div>
																
																<div class="col-sm-5">
																	<div class="form-group">
																		<label>품명</label> 
																		 <input type="combo" id="r_item_nm" name="item_nm" class="form-control input-sm" placeholder="품명" 
																					disabled >
																	</div>
																</div>
															</div> -->
															
														</div>
													</div>
													<div id="grid_list" style="margin-top: 10px; height: 500px;"></div><!-- 430px -->
												</div>
											</div>
										</div>
										
									</div>
									
									<div class="col-sm-3">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">라우팅  그룹</h3>
												<div class="box-tools pull-right">
													<button type="button" id="btn_rt_search" onclick="" class="btn btn-primary btn-sm" onclick="">조회</button>
													
												</div>
											</div>
											<div class="box-body">
											
												<div class="row">
													<div class="form-group">
														<div class="col-sm-12 text-center">    
															<div class="col-sm-3">
												                  <label for="rdo_qc_yn" class="control-label">검사구성여부</label>
												             </div>
										                  	 <label>
												               <input type="radio" name="rdo_qc_yn" class="flat-red form-control" value="ALL" checked> 전체 
												             </label>
												             
												             <label>
												               <input type="radio" name="rdo_qc_yn" class="flat-red form-control" value="N" > 구성전
												             </label>
												             
												             <label>
												               <input type="radio" name="rdo_qc_yn" class="flat-red form-control" value="Y" > 구성후
												             </label>
														</div>
													</div>
												</div>
												
												<div id="grid_list1" class="w2g-h600" style="height: 584px;"></div>
											</div>
										</div>
									</div>
									
									<div class="col-sm-5">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">검사 항목 관리</h3>
												<div class="box-tools pull-right">
													<button type="button" id="btn_ins_csr" onclick="setGrid_po();" class="btn btn-info btn-sm btn_auto1" >자동세팅</button>
													<button type="button" id="btn_ins_csr" onclick="setGrid_ja();" class="btn btn-info btn-sm btn_auto2" >자동세팅</button>
													
													<button type="button" id="btn_ins_csr" onclick="setGrid_se1();" class="btn btn-info btn-sm btn_se1" >세정(조립전 세정)</button>
													<button type="button" id="btn_ins_csr" onclick="setGrid_se2();" class="btn btn-info btn-sm btn_se2" >세정(Q,C전 세정)</button>
													<button type="button" id="btn_ins_csr" onclick="setGrid_se3();" class="btn btn-info btn-sm btn_se3" >세정(샌딩 다음세정)</button>
													
													<button type="button" id="btn_ins_csr" onclick="inspectEdit();" class="btn btn-primary btn-sm" >검사항목 편집</button>
													
												</div>
											</div>
											<div class="box-body">
												<div id="grid_list2" class="w2g-h600" style="height: 600px;"></div>
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
	<div class="modal-dialog modal-md" style="width: 1200px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">검사항목 편집</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
				
		
						
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-3">
									 <label>P/N</label> 
									 <input type="combo" id="m_item_code" name="m_item_code" class="form-control input-sm" placeholder="P/N" disabled >
							</div>
							
							<div class="col-sm-3">
									<label>품명</label> 
									 <input type="combo" id="m_item_nm" name="m_item_nm" class="form-control input-sm" placeholder="제품명" disabled >
							</div>
							
							<div class="col-sm-3" >
									<label>라우팅명</label> 
									 <input type="combo" id="m_routing_nm" name="m_routing_nm" class="form-control input-sm" placeholder="제품명" disabled >
							</div>
						</div>
						
						<div class="col-sm-12" style="margin-top: 10px;">
							<div class="col-sm-4" >
									 <label>검사항목</label> 
									 <input type="combo" id="m_inspection_item" name="m_inspection_item" class="form-control input-sm" placeholder="검사항목" >
							</div>
							
							<div class="col-sm-4" >
									<label>검사Tool</label> 
									 <input type="combo" id="m_inspection_tool" name="m_inspection_tool" class="form-control input-sm" placeholder="검사Tool" >
							</div>
						</div>
						
						<div class="col-sm-12" style="margin-top: 10px;">
							<div class="col-sm-4" >
									 <label>검사방법</label> 
									 <select id="m_inspection_method" name="m_inspection_method" class="form-control" style="height: 30px;" ></select>
							</div>
							
							<div class="col-sm-4" >
									<label>검사구분</label> 
									<select id="m_inspection_gubun" name="m_inspection_gubun" class="form-control" style="height: 30px;" ></select>
							</div>
							<div class="col-sm-4" >
									<label>검사 Point</label> 
									<input type="text" id="m_point" name="m_point" class="form-control input-sm" placeholder="검사 Point" maxlength="100" >
							</div>
						</div>
						
						<div class="col-sm-12" style="margin-top: 10px;">
							<div class="col-sm-4" >
									 <label>Spec</label> 
									 <input type="text" id="m_spec" name="m_spec" class="form-control input-sm" placeholder="Spec" maxlength="100" >
							</div>
							
							<div class="col-sm-4" >
									<label>LCL</label> 
									<input type="text" id="m_min_spec" name="m_min_spec" class="form-control input-sm" placeholder="Spec" maxlength="100" >
							</div>
							
							<div class="col-sm-4" >
									<label>UCL</label> 
									<input type="text" id="m_max_spec" name="m_max_spec" class="form-control input-sm" placeholder="Spec" maxlength="100" >
							</div>
						</div>
						
						
						
					</div>
					
					<div class="row" style="margin-top: 10px;">
						<div class="form-group">
							<div class="col-md-11 text-right">
								<div class="box-tools pull-right">
<!-- 									<button type="button" id="btn_ins_csr" onclick="plus();" class="btn btn-primary btn-sm" onclick="">행추가</button> -->
<!-- 									<button type="button" id="btn_ins_csr" onclick="minus();" class="btn btn-primary btn-sm" onclick="">행삭제</button> -->
									<button type="button" id="" class="btn btn-primary btn-sm" onclick="saveInspection();">저장</button>	
									<button type="button" id="" class="btn btn-danger btn-sm" onclick="delInspection();">삭제</button>
														
								</div>			
							</div>
						</div>
					</div>
					
							
		
			
					<div class="row">
						<div class="col-md-12">
							<div id="modalGrid" style="width: 100%; height: 480px;" ></div>
						</div>
					</div>
						
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<!-- <div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button>
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveProcess();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div> -->
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
comboValue_nm = new Array;
comboValue_cd = new Array;
var inspectGubun = [];

var processPointVl="";
var itemPointVl="";

var gridDataArr = new Array;

var ok = "";

var okGrid = "";


$(function($) {
	
	fnCdD('business', 'MC1012');
	fnCdD('inspectGubun', 'MC1016');
	fnLoadCommonOption(); 
 	loadLeftGrid();
 	loadLeftGrid1();
 	loadList();
 	loadRightGrid();
 	
 	modalGrid();
})

$(".btn_auto1").hide();
$(".btn_auto2").hide();
 	
$(".btn_se1").hide();
$(".btn_se2").hide();
$(".btn_se3").hide(); 

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
}

$("#btn_rt_search").click(function() {
	 var key = w2ui.grid_list.getSelection();
	 if( key.length==0 ) {
			fnMessageModalAlert("알림", "라우팅  그룹에서 검색하고자 하는 검사그룹 항목을 1개 선택하여야 합니다."); 
			return;	
	 }
	 var data = w2ui.grid_list.get(key[0]);
	 loadList1(data.item_code);
});


	// gird_list1의 이벤트
	$(":radio[name='rdo_qc_yn']").on('ifChecked', function(event){
		 var ssss = $(":radio[name='rdo_qc_yn']:checked").val();
		  console.log("ssss = " + ssss );
		  var key = w2ui.grid_list.getSelection();

		  if( key.length==0 ) {
				fnMessageModalAlert("알림", "라우팅  그룹에서 검색하고자 하는 검사그룹 항목을 1개 선택하여야 합니다."); // Notification
// 				$(':radio[name="rdo_qc_yn"][value="'+ssss+'"]').iCheck('uncheck');
// 				$(':radio[name="rdo_qc_yn"]').iCheck('update');
// 				 $(':radio[name="rdo_qc_yn"][value="ALL"]').iCheck('check');
// 				$(':radio[name="rdo_qc_yn"]').iCheck('update'); 
				return;	
		  }
		  
		  var data = w2ui.grid_list.get(key[0]);
		
		  loadList1(data.item_code);
		  
	});
	

$("#business").change(function(){
	loadList();
});
// loadLeftGrid
function loadLeftGrid(){
// 	 console.log('fnSetLoadWorkerGrid()');
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : false,
            footer: true,
            selectColumn : true
        },
        multiSelect: false,
        columns: [         
                  
            	{ field:'item_code', caption:'P/N', size:'15%',style:'text-align:center', sortable: true},
            	{ field:'item_nm', caption:'품명', size:'26%',style:'text-align:center', sortable: true},
            	{ field:'qc_yn', caption:'검사항목구성', size:'35%', style:'text-align:center', hidden: true, 
					render : function(record, index, col_index){
						var val = this.getCellValue(index, col_index);
						if(val == "N")
							return '구성전';
						else if(val == "Y")
							return '구성후';
						else val;
					}
				}
			/* 
			{ field:'routing_nm', caption:'라우팅명', style:'text-align:center'},
			{ field:'item_code', caption:'제품코드', style:'text-align:center' , hidden : true},
			{ field:'routing_code', caption:'라우팅코드', style:'text-align:center' , hidden : true},
			{ field:'routing_gubun', caption:'라우팅구분', style:'text-align:center' , hidden : true}		 */
			], 
		sortData: [{field: 'mt_name', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				//w2ui.grid_list2.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list1'].refresh();
				w2ui['grid_list2'].refresh();
				
				
				// 오른쪽 그리드 XX 
				loadList1(data.item_code);
// 				requestItemName(data.item_code, data.routing_code);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list1'].clear();		
				w2ui['grid_list1'].refresh();
				w2ui['grid_list2'].clear();		
				w2ui['grid_list2'].refresh();
			}
		},
		onClick: function (event) {
// 		 	grid_list2(); // 클릭 이벤트
		}
	});
}

//loadLeftGrid1
function loadLeftGrid1(){
// 	 console.log('fnSetLoadWorkerGrid()');
	var rowArr = [];
	
	$('#grid_list1').w2grid({ 
        name: 'grid_list1',
        show: {
			lineNumbers : false,
            footer: true,
            selectColumn : true
        },
        multiSelect: false,
        columns: [                
			{ field:'qc_yn', caption:'검사항목구성', size:'35%', sortable: true, style:'text-align:center',
				render : function(record, index, col_index){
					var val = this.getCellValue(index, col_index);
					if(val == "N")
						return '구성전';
					else if(val == "Y")
						return '구성후';
					else val;
				}
			}, 
			{ field:'routing_nm', caption:'라우팅명', sortable: true, size:'50%',style:'text-align:center'},
			{ field:'item_code', caption:'제품코드', style:'text-align:center' , hidden : true},
			{ field:'routing_code', caption:'라우팅코드', style:'text-align:center' , hidden : true},
			{ field:'routing_gubun', caption:'라우팅구분', style:'text-align:center' , hidden : true}		
			], 
		sortData: [{field: 'mt_name', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				//w2ui.grid_list2.recordHeight = 40;
				var key = w2ui.grid_list1.getSelection();

				var data = w2ui.grid_list1.get(key[0]);
				
				w2ui['grid_list2'].refresh();
				
				// 오른쪽 그리드
				requestItemName(data.item_code, data.routing_code);
				
				btnSet();
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
}




function loadList1(item_code, flag) {
	console.log("loadList1('" + item_code + "', '" + flag + "')");
			
	var kes = [];
	
	if ( flag == "ins" || flag == "del" ) {
		kes = w2ui.grid_list1.getSelection();	
	}
	
	var page_url = "/info/process/selectRou_mstG";
	var postData = "item_code=" + encodeURIComponent(item_code)
	
	// qc_yn
	if( $(":radio[name='rdo_qc_yn']:checked").val() != "ALL") {
		postData += "&qc_yn=" + encodeURIComponent($(":radio[name='rdo_qc_yn']:checked").val());
	} else {
		postData += "&qc_yn=" + encodeURIComponent("");
	}
	
	
	w2ui['grid_list1'].lock('loading...', true);
	w2ui['grid_list1'].clear();	
	w2ui['grid_list1'].refresh();
	
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
				});
				w2ui['grid_list1'].records = rowArr;
			} else {
				w2ui.grid_list1.clear();
			}
			w2ui['grid_list1'].refresh();
			w2ui['grid_list1'].unlock();
			
		}, complete : function() {
			w2ui.grid_list1.refresh();
		    $('#grid_list1').w2render('grid_list1');
		    
		    if ( flag == "ins" || flag == "del" ) {
		    	 w2ui.grid_list1.select(kes[0]);
			}
		}
	});
	
}

function requestItemName(item_code, routing_code){
	var page_url = "/info/process/selectInspection_master2";
	var postData = "item_code=" + encodeURIComponent(item_code)
	 + "&routing_code=" + encodeURIComponent(routing_code);
	
	w2ui['grid_list2'].lock('loading...', true);
	/* w2ui['grid_list2'].clear();	
	w2ui['grid_list2'].refresh(); */
	
	//w2ui['modalGrid'].clear();
	w2ui['modalGrid'].refresh();
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
				});
				w2ui['grid_list2'].records = rowArr;
				w2ui['modalGrid'].records = rowArr;
			} else {
				w2ui.grid_list2.clear();
				w2ui.modalGrid.clear();
			}
			
		}, complete : function() {
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
			w2ui['modalGrid'].refresh();
			w2ui['modalGrid'].unlock();
		}
	});
}

function loadRightGrid(){
	var rowArr = [];
	
	$('#grid_list2').w2grid({
		name : 'grid_list2',
		 show: {
				lineNumbers : false,
	            footer: true,
	            selectColumn : false
	        },
	    multiSelect: true,
        
        columns: [
                  
        			{ field:'inspection_item', caption:'검사항목', size:'25%', style:'text-align:center', sortable: true},
        			{ field:'inspection_tool', caption:'검사툴', size:'25%', style:'text-align:center', hidden:true },
        			
        			{ field:'inspection_gubun', caption:'검사구분', size:'25%', style:'text-align:center', hidden:true },
					{ field:'inspection_gubun_nm', caption:'검사기준', size:'25%', style:'text-align:center' , hidden:true },
        			
        			{ field:'inspection_method', caption:'검사방법', size:'25%', style:'text-align:center' , hidden:true},
        			{ field:'inspection_method_nm', caption:'검사방법', size:'25%', style:'text-align:center' , hidden:true },
        			{ field:'spec', caption:'Spec', size:'50%', style:'text-align:center', sortable: true}, 
        			{ field:'min_spec', caption:'LCL', size:'25%', style:'text-align:center', sortable: true},
        			{ field:'max_spec', caption:'UCL', size:'25%', style:'text-align:center', sortable: true}, 
        			
        			
        			{ field:'item_code', caption:'item_code', size:'50%', style:'text-align:center', hidden:true}, 
        			{ field:'routing_code', caption:'routing_code', size:'25%', style:'text-align:center', hidden:true},
        			{ field:'inspection_seq', caption:'inspection_seq', size:'25%', style:'text-align:center', hidden:true},
        			{ field:'inspection_point', caption:'inspection_point', size:'25%', style:'text-align:center', hidden:true}
        			
        			/* item_code, routing_code, inspection_seq, routing_nm, 
        			inspection_item, inspection_gubun, inspection_tool, 
        			inspection_method, spec, min_spec, max_spec, use_yn, creator, updater, date_created, date_updated */
        			
        		
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
				console.log(event);
				
				// 오브젝트
			    console.log(event.value_new);		
				console.log("event.column : " + event.column);	     
			    console.log(event.value_new.text);
			    
			   	//var rowData = w2ui.grid_list2.records[recid];	
			 	// console.log("rowData.item_name : " + rowData.item_name); 
				//w2ui['grid_list'].refresh();
			}
		}, 
		
		
    }); 
	
}



function loadList() {
	console.log("loadList()");
	
   try{
	   w2ui['grid_list'].selectNone();
	   w2ui['grid_list1'].clear();
	   w2ui['grid_list2'].clear();
   }catch (e) 
   {
      
   }
	var item_code = $("#item_code").val();
	var item_nm = $("#item_nm").val();
	
	var page_url = "/info/material/selectItemCode"; // selectCsPr1 X
	var postData = "item_code=" + encodeURIComponent(item_code)
	 + "&item_nm=" + encodeURIComponent(item_nm);

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
	
	/* var kkk = w2ui.grid_list.getSelection();
	
	var qc_yn = $(':radio[name="rdo_qc_yn"]:checked').val();
	if( kkk.length > 0 && qc_yn != "ALL") {
		postData += "&qc_yn=" + encodeURIComponent( qc_yn );
	} else {
		postData += "&qc_yn=" + encodeURIComponent("");
	} */
	
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				
				comboValue_nm = new Array;
				comboValue_cd = new Array;
				
				rowArr = data.rows;
				gridDataArr = rowArr;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					comboValue_nm.push(row.item_nm);
					comboValue_cd.push(row.item_code);
				});
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false), match : 'contains' });
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
			/* 
				
			w2ui.grid_list.refresh();
		    $('#grid_list').w2render('grid_list'); */
		    
		   
		}
	});
	
}

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
	    		
	    		if(val != "inspectGubun") {
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
	    				objt.id = row.detail_code;
	    				objt.text = row.code_nm;
	    				objt.detail_code = row.detail_code;
	    				
	    				inspectGubun.push(objt);
	    			});

	    		}	
	 			
	    	} else if(data.status == "200" && (data.rows).length==0 && val != "inspectGubun" ) {
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

function resetIns() {
	$("#m_inspection_item").val('');
	$("#m_inspection_tool").val('');
	
	$("#m_inspection_method option:eq(0)").prop("selected", true);	
	$("#m_inspection_gubun option:eq(0)").prop("selected", true);
	
	$("#m_spec").val('');
	$("#m_min_spec").val('');
	$("#m_max_spec").val('');
	
	$("#m_point").val('');
}

function fnTool() {
	
	var page_url = "/info/instrument/selectInstrumentTool"; // selectCsPr1 X
	
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;	
				var instrument_nm = new Array;
				
				$.each(rowArr, function(idx, row){
					instrument_nm.push(row.instrument_nm);
				});
				$('#m_inspection_tool').w2field('combo', { items: instrument_nm, match : 'contains' });
				
			}
		},complete: function () {
		}
	});
}

function inspectEdit_init()
{

	var key = w2ui.grid_list1.getSelection();

	var data = w2ui.grid_list1.get(key[0]);
	
	w2ui['grid_list2'].refresh();
	
	// 오른쪽 그리드
	requestItemName(data.item_code, data.routing_code);
	
}


function inspectEdit() {

	console.log("inspectEdit()");
	
	var key = w2ui.grid_list1.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "편집하고자 하는 라우팅 그룹 항목을 1개 선택하여야 합니다."); // Notification
		return;
	}
	
	if( ok == ""){
		inspectEdit_init();
	}
	
	w2ui['modalGrid'].clear();
	w2ui['modalGrid'].refresh();
	
// 	var soso = w2ui['grid_list2'].records;
	var soso = cloneObject(w2ui['grid_list2'].records); 
	
	w2ui['modalGrid'].records = soso;
	
	var row = w2ui.grid_list1.get(key[0]);
	
	var gl_key = w2ui.grid_list.getSelection();
	var gl_row = w2ui.grid_list.get(gl_key[0]);
	
	
	$("#m_item_nm").val(gl_row.item_nm);
	$("#m_item_code").val(row.item_code);
	$("#m_routing_nm").val(row.routing_nm);
	fnCdD('m_inspection_method', 'MC1022');
	fnCdD('m_inspection_gubun', 'MC1023');
	fnTool();
	$("#m_inspection_item").val('');
	$("#m_inspection_tool").val('');
	
	$("#m_inspection_method option:eq(0)").prop("selected", true);	
	$("#m_inspection_gubun option:eq(0)").prop("selected", true);
	
	$("#m_spec").val('');
	$("#m_min_spec").val('');
	$("#m_max_spec").val('');
	
	$("#m_point").val('');
	
	setTimeout(function(){
	      w2ui['modalGrid'].resize();
	      w2ui['modalGrid'].refresh();
	   }, 200);
	
	// 삭제 어레이 초기화 
// 	deleteItems = new Array;
	
	$("#modal_info").modal('show');
	
}


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
        multiSelect: false,
        columns: [        
                  
			{ field:'inspection_item', caption:'검사항목', size:'25%', style:'text-align:center'},
			
			{ field:'inspection_gubun', caption:'검사구분', size:'25%', style:'text-align:center', hidden: true },
			{ field:'inspection_gubun_nm', caption:'검사구분', size:'25%', style:'text-align:center' },
			
			{ field:'inspection_tool', caption:'검사툴', size:'25%', style:'text-align:center'},
			{ field:'inspection_method', caption:'검사방법', size:'25%', style:'text-align:center', hidden: true},
			{ field:'inspection_method_nm', caption:'검사방법', size:'25%', style:'text-align:center' },
			
			{ field:'inspection_point', caption:'검사Point', size:'25%', style:'text-align:center'},
			
			{ field:'spec', caption:'Spec', size:'50%', style:'text-align:center'}, 
			{ field:'min_spec', caption:'LCL', size:'25%', style:'text-align:center'},
			{ field:'max_spec', caption:'UCL', size:'25%', style:'text-align:center'}, 
			
			
			{ field:'item_code', caption:'item_code', size:'50%', style:'text-align:center', hidden:true}, 
			{ field:'routing_code', caption:'routing_code', size:'25%', style:'text-align:center', hidden:true},
			{ field:'inspection_seq', caption:'inspection_seq', size:'25%', style:'text-align:center', hidden:true}
			    
                  
			/* {field: 'inspect_nm', caption: '검사항목', size:'25%', style:'text-align:center'
				,editable: { type: 'list',  items :inspectGubun , showAll: true }
			    ,                
                	  render: function (record, index, col_index) {
                         var html = this.getCellValue(index, col_index);
              
                         for (var p in inspectGubun) {
                        	 
//                         	    console.log('p : ' + p);
//                                 console.log(this.getCellValue(index, col_index));
                             if (inspectGubun[p].id == this.getCellValue(index, col_index)) 
                            	 html = inspectGubun[p].text;
                      
                         }
                         return html;
                     } 	     
            }, 
			
			{ field:'inspect_code', caption:'검사코드', size:'25%', style:'text-align:center'},
			{ field:'inspect_spec', caption:'SPEC', size:'50%',  style:'text-align:center', editable: { type: 'text' } } */
			
			], 

		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				var key = w2ui.modalGrid.getSelection();
				var data = w2ui.modalGrid.get(key[0]);
				
				// m_inspection_item 검사항목
				$("#m_inspection_item").val(data.inspection_item);
				$("#m_inspection_tool").val(data.inspection_tool);
				
				$("#m_inspection_method").val(data.inspection_method).prop("selected", true);
				$("#m_inspection_gubun").val(data.inspection_gubun).prop("selected", true);
				
				$("#m_spec").val(data.spec);
				$("#m_min_spec").val(data.min_spec);
				$("#m_max_spec").val(data.max_spec);
				$("#m_point").val(data.inspection_point);
				
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				$("#m_inspection_item").val('');
				$("#m_inspection_tool").val('');
				
				$("#m_inspection_method option:eq(0)").prop("selected", true);	
				$("#m_inspection_gubun option:eq(0)").prop("selected", true);
				
				$("#m_spec").val('');
				$("#m_min_spec").val('');
				$("#m_max_spec").val('');
				$("#m_point").val('');
			}
		},
		onClick: function (event) {
// 			event.onComplete = function () {
// 				console.log("onClick");
// 			}
		}, onChange: function(event) {
			event.onComplete = function () {
			
			}
		}	
	});
	

}

function delInspection() {
	
	var key = w2ui.modalGrid.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "편집하고자 하는 검사항목을 1개 선택하여야 합니다."); // Notification
		return;
	}
	
	fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
		if(result) {
			var data = w2ui.modalGrid.get(key[0]);
			
			var strUrl = "/info/instrument/deleteInspection";
			var postData = "item_code=" + data.item_code
					+ "&routing_code=" + data.routing_code
					+ "&inspection_seq=" + data.inspection_seq;
			
			$.ajax({
				 url: strUrl,
				 type: "POST",
				 dataType : 'json', 
				 data : postData, 
				 async : false,
				 success:function(data, textStatus, jqXHR){
				 	if(data.status == "200") {
				 		fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");
						
						var ks = w2ui.grid_list1.getSelection();
						var dts = w2ui.grid_list1.get(ks[0]);
						// 오른쪽 그리드
						requestItemName(dts.item_code, dts.routing_code);
						
						w2ui['modalGrid'].records = w2ui['grid_list2'].records;
						resetIns();
						w2ui['modalGrid'].selectNone();
						loadList1(dts.item_code, 'del');

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

function saveInspection()
{
	if(!chkSubmit($("#m_inspection_item"), "검사항목를")) return;
	
// 	if(!chkSubmit($("#m_inspection_tool"), "검사Tool을")) return;
	
//	if(!chkSubmit($("#m_spec"), "Spec을")) return; 
	
	var inspection_gubun = $("#m_inspection_gubun option:selected").val();	
	
	if( inspection_gubun == "MD1543" && !chkSubmit($("#m_min_spec"), "LCL을")) return; 
	if( inspection_gubun == "MD1543" && !chkSubmit($("#m_max_spec"), "UCL을")) return; 
	
	var inspection_item = $("#m_inspection_item").val();
	
	var inspection_tool = $("#m_inspection_tool").val();	
	
	var inspection_method = $("#m_inspection_method option:selected").val();
	
	var spec = $("#m_spec").val();
	var min_spec = $("#m_min_spec").val();
	var max_spec = $("#m_max_spec").val();
	
	var inspection_point = $("#m_point").val();
	
	var key = w2ui.modalGrid.getSelection();
	var page_url = "";
	
// 	var page_url = "/info/process/updateRouting_master_qc";
	
	var postData = "inspection_item=" + encodeURIComponent(inspection_item)
		+ "&inspection_tool=" +  encodeURIComponent(inspection_tool)
		+ "&inspection_method=" +  encodeURIComponent(inspection_method)	
		+ "&inspection_gubun=" +  encodeURIComponent(inspection_gubun)
		+ "&spec=" +  encodeURIComponent(spec)
		+ "&min_spec=" +  encodeURIComponent(min_spec)
		+ "&max_spec=" +  encodeURIComponent(max_spec)
		
		
		+ "&routing_nm=" +  encodeURIComponent($("#m_routing_nm").val())
		+ "&inspection_point=" +  encodeURIComponent(inspection_point);
	
	var gubun = "";
	
	if( key.length > 0) {
		var dats = w2ui.modalGrid.get(key[0]);
		gubun = "U";
		page_url = "/info/instrument/updateInspection";
		
		postData += "&item_code=" + encodeURIComponent(dats.item_code);
		postData += "&routing_code=" + encodeURIComponent(dats.routing_code);
		postData += "&inspection_seq=" + encodeURIComponent(dats.inspection_seq);
		
	} else {
		gubun = "I";
		page_url = "/info/instrument/insertInspection";
		
		var k1 = w2ui.grid_list1.getSelection();
		var dt1 = w2ui.grid_list1.get(k1[0]);
		
		postData += "&item_code=" + encodeURIComponent(dt1.item_code);
		postData += "&routing_code=" + encodeURIComponent(dt1.routing_code);
		
	}
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData,
		dataType : 'json',
		async : false,	
		success: function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("알림", "편집을 완료 하였습니다.");
				
				var ks = w2ui.grid_list1.getSelection();
				var dts = w2ui.grid_list1.get(ks[0]);
				// 오른쪽 그리드
				requestItemName(dts.item_code, dts.routing_code);
				
				w2ui['modalGrid'].records = w2ui['grid_list2'].records;
				
				if(gubun == "I") {
					resetIns();
					w2ui['modalGrid'].selectNone();
					loadList1(dts.item_code, 'ins');
				}
				
			} else {
				fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
		},	
		complete: function () {
			FunLoadingBarEnd();
		}
	});
	
}


function saveInspect(p_inspect_code, p_inspect_nm, p_inspect_spec ) {
	console.log("saveInspect()");
	
	var grid_key = w2ui.grid_list.getSelection();
	var grid_data = w2ui.grid_list.get(grid_key[0]);
	
	var records = w2ui.modalGrid.records;

	
	var item_code = grid_data.item_code;
	var routing_code = grid_data.routing_code;
	var inspect_code = p_inspect_code;
	var routing_nm = grid_data.routing_nm;
	var routing_gubun = grid_data.routing_gubun;
	var inspect_nm = p_inspect_nm;
	var inspect_spec = p_inspect_spec;
	
	$.each(inspectGubun, function(idx, row){
			
		if(inspect_code == row.detail_code) {
			inspect_nm = row.text; //w2ui['modalGrid'].get(key).routing_gubun;
		
		}
	});
	
	var page_url = "/info/process/saveInspect_master";
	
	var postData = "item_code=" + encodeURIComponent(item_code)
		+ "&routing_code=" +  encodeURIComponent(routing_code)
		+ "&inspect_code=" +  encodeURIComponent(inspect_code)
		+ "&routing_nm=" +  encodeURIComponent(routing_nm)
		+ "&routing_gubun=" +  encodeURIComponent(routing_gubun)
		+ "&inspect_nm=" +  encodeURIComponent(inspect_nm)
		+ "&inspect_spec=" +  encodeURIComponent(inspect_spec);
	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData,
		dataType : 'json',
		async : false,	
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
// 			var item_code = w2ui.grid_list.get(w2ui.grid_list.getSelection()).item_code;
			requestItemName(item_code, routing_code);
			
		}
	});
	
	
}

var gubun_po = 'MD1560';// MD1251은 개발
var gubun_ja = 'MD1579';  // MD1560은 개발
var gubun_se = 'MD1557';

function btnSet(){
	
	var key = w2ui.grid_list1.getSelection();
	var data = w2ui.grid_list1.get(key[0]);
	
	var routing_gubun = data.routing_gubun;
	
	console.log("routing_gubun ????" + routing_gubun);
	
	if( routing_gubun == gubun_po){
		ok = "s";
		
		$(".btn_auto1").show();
		
		$(".btn_auto2").hide();
		$(".btn_se1").hide();
		$(".btn_se2").hide();
		$(".btn_se3").hide();
		
		
	}else if( routing_gubun == gubun_ja){
		ok = "s";
		
		$(".btn_auto2").show();
		
		$(".btn_auto1").hide();
		$(".btn_se1").hide();
		$(".btn_se2").hide();
		$(".btn_se3").hide();
		
	}else if( routing_gubun == gubun_se ){
		ok = "s";
		
		$(".btn_se1").show();
		$(".btn_se2").show();
		$(".btn_se3").show();
		
		$(".btn_auto1").hide();
		$(".btn_auto2").hide();
	}
	else{
		okGrid = '';
		
		$(".btn_auto1").hide();
		$(".btn_auto2").hide();
		
		$(".btn_se1").hide();
		$(".btn_se2").hide();
		$(".btn_se3").hide();
	}
	
}


function setGrid_po(){
	
	okGrid = "po";
	
	fnSave();
	
}


function setGrid_ja(){
	
	okGrid = "ja";
	
	console.log("자재-------" + okGrid);
	
	fnSave();
	
}

function setGrid_se1(){
	
	okGrid = "se1";
	
	fnSave();
	
}
function setGrid_se2(){
	okGrid = "se2";
	
	fnSave();
	
}
function setGrid_se3(){
	okGrid = "se3";
	
	fnSave();
	
}
function fnSave() {
	console.log("fnSave()");
	   var grid_key = w2ui.grid_list1.getSelection();
	   var grid_data = w2ui.grid_list1.get(grid_key[0]);
	   
	   var routing_code = grid_data.routing_code;
	   var item_code = grid_data.item_code;
	   
	   console.log("routing_code : " + routing_code);
	   console.log("item_code : " + item_code);
	   
	   var saveVal= [];
	   
	   
	  /*  { field:'inspection_item', caption:'검사항목', size:'25%', style:'text-align:center'},
		
		{ field:'inspection_gubun', caption:'검사구분', size:'25%', style:'text-align:center', hidden: true },
		{ field:'inspection_gubun_nm', caption:'검사구분', size:'25%', style:'text-align:center' },
		
		{ field:'inspection_tool', caption:'검사툴', size:'25%', style:'text-align:center'},
		{ field:'inspection_method', caption:'검사방법', size:'25%', style:'text-align:center', hidden: true},
		{ field:'inspection_method_nm', caption:'검사방법', size:'25%', style:'text-align:center' },
		{ field:'spec', caption:'Spec', size:'50%', style:'text-align:center'}, 
		{ field:'min_spec', caption:'LCL', size:'25%', style:'text-align:center'},
		{ field:'max_spec', caption:'UCL', size:'25%', style:'text-align:center'}, 
		
		
		{ field:'item_code', caption:'item_code', size:'50%', style:'text-align:center', hidden:true}, 
		{ field:'routing_code', caption:'routing_code', size:'25%', style:'text-align:center', hidden:true},
		{ field:'inspection_seq', caption:'inspection_seq', size:'25%', style:'text-align:center', hidden:true} */
		    
	   
	   
	   if ( okGrid == "po" ) {
	      saveVal =   [
		                   { recid:1, inspection_item :"외관", inspection_gubun:"MD1544", inspection_gubun_nm:"합불판정검사", inspection_tool:"합불판정검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:" ", min_spec:" ", max_spec:" "},
		                   { recid:2, inspection_item :"정전기봉투", inspection_gubun:"MD1544", inspection_gubun_nm:"합불판정검사", inspection_tool:"합불판정검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:" ", min_spec:" ", max_spec:" "},
		                   { recid:3, inspection_item :"실리카겔", inspection_gubun:"MD1577", inspection_gubun_nm:"유,무", inspection_tool:"유,무", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:" ", min_spec:" ", max_spec:" "},
		                   { recid:4, inspection_item :"진공압력포장", inspection_gubun:"MD1544", inspection_gubun_nm:"합불판정검사", inspection_tool:"", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:" ", min_spec:" ", max_spec:" "}
	                   
	                ];

	   } else if ( okGrid == "ja" ) {
	      saveVal =   [
							{ recid:1, inspection_item :"외관", inspection_gubun:"MD1544", inspection_gubun_nm:"합불판정검사", inspection_tool:"합불판정검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:" ", min_spec:" ", max_spec:" "},
							{ recid:2, inspection_item :"라벨부착", inspection_gubun:"MD1577", inspection_gubun_nm:"유,무", inspection_tool:"유,무", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:" ", min_spec:" ", max_spec:" "},
							{ recid:3, inspection_item :"자리위치보관", inspection_gubun:"MD1577", inspection_gubun_nm:"유,무", inspection_tool:"유,무", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:" ", min_spec:" ", max_spec:" "}

	               	  ];
	   }else if ( okGrid == "se1" ) {
		      saveVal =   [
							{ recid:1, inspection_item :"DI 저항(MΩ)", inspection_tool:"DI", inspection_gubun:"MD1543", inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"15", min_spec:"14", max_spec:"16"},
							{ recid:2, inspection_item :"초음파 시간(1차)", inspection_tool:"타이머", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"30", min_spec:"25", max_spec:"35"},
							{ recid:3, inspection_item :"초음파 강도(1차)", inspection_tool:"자체검사(W)", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"550", min_spec:"500", max_spec:"600"}

		                ];
	   }else if ( okGrid == "se2" ) {
		      saveVal =   [
							{ recid:1, inspection_item :"DI 저항(MΩ)", inspection_tool:"DI", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"15", min_spec:"14", max_spec:"16"},
							{ recid:2, inspection_item :"초음파 시간(1차)", inspection_tool:"타이머", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"30", min_spec:"25", max_spec:"35"},
							{ recid:3, inspection_item :"초음파 강도(1차)", inspection_tool:"자체검사(W)", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"550", min_spec:"500", max_spec:"600"},
							{ recid:4, inspection_item :"초음파 시간(2차)", inspection_tool:"타이머", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"40", min_spec:"35", max_spec:"45"},
							{ recid:5, inspection_item :"초음파 강도(2차)", inspection_tool:"자체검사(W)", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"600", min_spec:"550", max_spec:"650"}
						];
	   }else if ( okGrid == "se3" ) {
		      saveVal =   [
								{ recid:1, inspection_item :"DI 저항(MΩ)", inspection_tool:"DI", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"15", min_spec:"14", max_spec:"16"},
								{ recid:2, inspection_item :"건조 온도(℃)", inspection_tool:"자체검사(온도)", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사",spec:"130", min_spec:"120", max_spec:"140"},
								{ recid:3, inspection_item :"건조시간(분)", inspection_tool:"타이머", inspection_gubun:"MD1543",inspection_gubun_nm:"치수검사", inspection_method: "MD1541" , inspection_method_nm:"전수검사", spec:"100", min_spec:"90", max_spec:"110"}
							
							];
		   }
	   
	   
	   var page_url = "/info/instrument/insertInspection2";
	   
	   // 저장시 2번째 그리드에 필요한 값 + 위에 saveVal 담기
	   var postData = "item_code=" + encodeURIComponent(item_code)
	  			 + "&routing_code=" + encodeURIComponent(routing_code)
	            + "&gridData=" + encodeURIComponent( JSON.stringify( saveVal ) );
	   
	   
	   $.ajax({
	      url : page_url,
	      type : 'POST',
	      data: postData,
	      dataType : 'json',
	      async : false,   
	      success: function(data, textStatus, jqXHR) {
	         if (data.status == "200") {
//	             fnMessageModalAlert("알림", "편집을 완료 하였습니다.");
	            
	         } else {
//	             fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
	         }
	      },
	      error: function(jqXHR, textStatus, errorThrown) {
	         fnMessageModalAlert("알림", "처리 중 에러가 발생하였습니다.");
	      },   
	      complete: function () {   
	      }
	   });
	   
	   requestItemName(item_code, routing_code);
	}



function initOptions(obj) {
    $(obj)
    .find('option')
    .remove()
    .end()
//	    .append('<option value="All">-----</option>')
    .val();
}


function getCheckInspectArr()
{
	var rowArr =  w2ui.modalGrid.records;
	
	var returnArr = new Array;
	
	$.each(rowArr, function(idx, row){
		
		returnArr[idx] =  w2ui.modalGrid.records[idx].inspect_code; 

	});
	
	return returnArr;
}

function getInspectArr(){

	var rowArr =  inspectGubun;
	
	var returnArr = new Array;
	
	$.each(rowArr, function(idx, row){
			
		returnArr[idx] =  rowArr[idx].detail_code;

	});
	
	return returnArr;
}

function compareArray(arr1, arr2) {
	console.log('arr1 : ' + arr1.length);
	console.log('arr2 : ' + arr2.length);
    var rst = false;
 
    if (arr1.length != arr2.length) {
        return rst;
    }
 
    arr1.forEach(function (item) {
        var i = arr2.indexOf(item);
        if (i > -1) arr2.splice(i, 1);
    });
 
    rst = arr2.length == 0;
 
	console.log('compareArray : ' + rst);
    return rst;
}


function updateRounting_qc(qc_yn) {
	console.log("updateRounting_qc() : " + qc_yn);
	
	var grid_key = w2ui.grid_list.getSelection();
	var grid_data = w2ui.grid_list.get(grid_key[0]);
	
	var item_code = grid_data.item_code;
	var routing_code = grid_data.routing_code;
	
	
	var page_url = "/info/process/updateRouting_master_qc";
	
	var postData = "item_code=" + encodeURIComponent(item_code)
		+ "&routing_code=" +  encodeURIComponent(routing_code)
	+ "&qc_yn=" +  encodeURIComponent(qc_yn);
	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData,
		dataType : 'json',
		async : false,	
		success: function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("알림", "편집을 완료 하였습니다.");
				loadList();
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

//미 입력시
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

</script>

</body>
</html>