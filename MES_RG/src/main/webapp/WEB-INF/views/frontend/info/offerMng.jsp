<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
//jsp properties
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

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1016" />
		<jsp:param name="selected_menu_cd" value="1044" />
	</jsp:include>

	<div class="content-wrapper">
			<section class="content-header">
				<h1>
					주문등록/취소 <small>주문/출하관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 주문등록/취소</a></li>
					<li class="active">주문/출하관리</li>
				</ol>
			</section>
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">조회조건</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search" class="btn btn-info btn-sm" 
								onclick="excelFileDownload();">엑셀다운로드</button>
								<button type="button" id="btn_search" class="btn btn-primary btn-sm" 
								onclick="insertItem();">등록</button>
								<button type="button" id="btn_search" class="btn btn-primary  btn-sm" 
								onclick="updateItem();">수정</button>
								<button type="button" id="btn_search" class="btn btn-danger btn-sm" 
								onclick="deleteItem();">삭제</button>	
								<button type="button" id="btn_search"
									class="btn btn-warning  btn-sm" onclick="loadList();">조회</button>
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-2">
									<div class="form-group">
									<label>| 주문일자</label>
										<div class="input-group">
											<input type="text" 
												class="form-control pull-right input-sm" style="" id="delivery_date" onchange="loadList();" placeholder="yyyymmdd~yyyymmdd">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>생산상태</label>
										<div class="form-group" style="margin-bottom: 0px;">
										<select id="process_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
												<option value="B">작업전</option>
												<option value="I">작업중</option>
												<option value="A">작업후</option>
											
											</select>
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 발주번호</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<input type="text" id="request_num" name="request_num" class="form-control input-sm" placeholder="발주번호" 
											 onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 고객사명</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<input type="text" id="customer_nm" name="customer_code" class="form-control input-sm" placeholder="고객사명" 
											 onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| P/N</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<input type="text" id="item_code" name="item_code" class="form-control input-sm" placeholder="P/N"
											onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
								</div>	
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 품명</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<input type="text" id="item_nm" name="item_nm" class="form-control input-sm" placeholder="품명"
											onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
								</div>					
							</div>
							<div id="grid_list" style="width: 100%; height: 600px;"></div>
							<div id="grid_list2" style="width: 100%; height: 60px;"></div>
							
						</div>
					</div>
					
				</div>
			</div>
		</section>
	</div>
</div>


<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:70%;">
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
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">고객사..</label>
								<div class="col-sm-5">
									<input type="combo" id="m_customer_nm" name="m_customer_nm" class="form-control input-sm" placeholder="고객사명" 
												onkeypress="if(event.keyCode==13) {requestCustomer_code(); return false;}" >
								</div>
								<!-- <div class="col-md-4text-right">
									<div class="box-tools">
										<button type="button" id="btn_ins_csr" onclick="plus();" class="btn btn-primary btn-sm" onclick="">행추가</button>
										<button type="button" id="btn_ins_csr" onclick="minus();" class="btn btn-primary btn-sm" onclick="">행삭제</button>
															
									</div>			
								</div> -->
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">담당자</label>
								<div class="col-sm-5">
									<input type="text" id="m_manager_nm" name="m_manager_nm" class="form-control input-sm" placeholder="담당자명">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">발주번호</label>
								<div class="col-sm-5">
									<input type="text" id="m_request_num" name="m_request_num	" class="form-control input-sm" placeholder="발주번호">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="col-sm-8" style="margin-left:26px;">
								<div class="form-group">
									<label class="col-sm-4 control-label">주문일자</label>
									<div class="input-group col-sm-7" style="padding-left:15px;">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="m_delivery_date" onchange="" placeholder="yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-3" style="padding:0;">
								<div class="box-tools pull-left">
									<button type="button" id="btn_ins_csr" onclick="plusItem();" class="btn btn-primary btn-sm">품목등록</button>
									<button type="button" id="btn_ins_csr" onclick="minusItem();" class="btn btn-primary btn-sm">삭제</button>
								</div>	
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12">
							<div id="modalGrid" style="width: 100%; height: 400px;" ></div>
							<div id="tot_modalGrid" style="width: 100%; height: 60px;" ></div>
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


<div class="modal fade" id="modal_item" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:70%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_item_title">품목등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="col-md-12">
						<div class="row">
							<div class="col-sm-6">
								<div class="col-sm-4">
									<div class="form-group" style="margin-right:0;">
										<label>P/N</label> <input type="text" id="m_item_code" name="m_item_code" placeholder="ex) P/N"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {requestMaterial(); return false;}"/>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group" style="margin-right:0;">
										<label>품명</label> <input type="text" id="m_item_nm" name="m_item_nm" placeholder="ex) 품명"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {requestMaterial(); return false;}"/>
									</div>
								</div>
								
								<div class="col-sm-4">
									<label></label>
									<div class="box-tools">
										<button type="button" id="btn_create" 
										class="btn btn-warning btn-sm" onclick="requestMaterial();">검색</button> 
										<button type="button" id="btn_create" 
										class="btn btn-primary btn-sm" onclick="add_buyList();">품목 추가</button>
										
										<!-- <button type="button" id="btn_create" 
										class="btn btn-info btn-sm" onclick="saveProcess();">저장</button> -->
									</div>
								</div>
							</div>
							<div class="col-sm-5">
								<label style="margin-top:30px; font-size:17px;">품목 확인</label> 
								
							</div>
							<div class="col-sm-1" style="margin-top:30px;">
								<div class="box-tools pull-right">
									<button type="button" id="btn_minus" onclick="minus();" class="btn btn-primary btn-sm">삭제</button>
								</div>			
							</div>
						</div>
						</div>
					<div class="row">
						<div class="col-md-6">
							<div id="modalGrid2" style="width: 100%; height: 400px;" ></div>
						</div>
						<div class="col-md-6">
						
							<div id="modalGrid3" style="width: 100%; height: 400px;" ></div>
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveModal();">확인</button>
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

<script type="text/javascript">

var customerArr = [];
var itemArr = [];
var itemArr_PN = [];
var gridDataArr = new Array;

comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;
comboValue_nm4 = new Array;

$(function($) {
	
	init_grid_list();
	
	init_grid_list2();
	
 	modalGrid2();
 	modalGrid3();
 	
 	tot_modal_grid();
 	
	fnLoadCommonOption();
	requestCustomer();
	requestItem();
	
	
	loadList();
 	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {

 		gridReDrw(); 

 		}, 100));
	
	
	
	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {

			console.log('DOMSubtreeModified');
			changeGridUI(w2ui.grid_list.records);
	   }, 100));
	
	setTimeout(function(){
		
		console.log("그리드사이즈조정2");
		
	      w2ui['modalGrid'].resize();
	      w2ui['modalGrid'].refresh();
	      w2ui['grid_list'].unlock();

	   }, 200);
})


function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
	
		 $('#delivery_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYY-MM-DD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			    startDate: moment(minDate).add(-30, 'days'),
             endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(7, 'days')
			});
		 
		 $('#m_delivery_date').daterangepicker({
				opens: 'right',
				singleDatePicker: true,
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			    startDate : moment(minDate)
			    
			}); 
		 
		 
		 $("#m_order_price").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
}
 
function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			//lineNumbers : true,
            footer: true,
            selectColumn: false
        },
        multiSelect: false,
        
        columns: [                
			{ field:'order_num', caption:'주문번호', size:'10%', style:'text-align:center',sortable :true},
			{ field:'request_num', caption:'발주번호', size:'10%', style:'text-align:center',sortable :true},// 200px
			{ field:'customer_nm', caption:'고객사명', size:'10%', style:'text-align:center',sortable :true},
			{ field:'manager_nm', caption:'담당자명', size:'7%', style:'text-align:center',sortable :true},// 120px
			{ field:'land', caption:'사업장', size:'10%', style:'text-align:center',sortable :true}, 
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center',sortable :true},// 120px
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center',sortable :true},
			{ field:'sap_code', caption:'SAP코드', size:'10%', style:'text-align:center' ,  sortable: true},
			{ field:'serial_no', caption:'S/N', size:'10%', style:'text-align:center' ,sortable :true},
			{ field:'unit_price', caption:'출고단가', size:'10%', style:'text-align:center',sortable :true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }	
			}, // right // 120px
			{ field:'menge', caption:'주문수량', size:'8%', style:'text-align:center',sortable :true},
			{ field:'total_price', caption:'전체금액(원)', size:'10%', style:'text-align:center',sortable :true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }	
			},
			{ field:'delivery_date', caption:'주문일자', size:'10%', style:'text-align:center',sortable :true},
			{ field:'comment', caption:'특이사항', size:'20%', style:'text-align:center',sortable :true}
			
			], 
			
		records: [
		      	/* {recid : 1, order_num:'1111', customer_nm:'CW컴퍼니', land: '경기도',
			 		item_nm:'테스트1', item_code:'1', unit_price:'500',
			 		menge:'2', total_price:'1000', delivery_date:'2020-07-29​', w2ui: { colspan: { field: 2 } }
				} ,
		     	{recid : 2, order_num:'2222', customer_nm:'CW컴퍼니', land: '경기도',
			 		item_nm:'테스트1', item_code:'1', unit_price:'500',
			 		menge:'2', total_price:'1000', delivery_date:'2020-07-29​', w2ui: { colspan: { field: 2 } }
				}  */
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	
	
	modalGrid();
	

}


function init_grid_list2(){
	var rowArr = [];
	
	$('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
			//lineNumbers : true,
            footer: false,
            selectColumn: false
        },
        multiSelect: false,
        
        columns: [                
			{ field:'', caption:'', size:'10%', style:'text-align:center'},
			{ field:'', caption:'', size:'10%', style:'text-align:center'},// 200px
			{ field:'', caption:'', size:'10%', style:'text-align:center'},
			{ field:'', caption:'', size:'7%', style:'text-align:center'},// 120px
			{ field:'', caption:'', size:'10%', style:'text-align:center'}, 
			{ field:'', caption:'', size:'10%', style:'text-align:center'},// 120px
			{ field:'', caption:'', size:'20%', style:'text-align:center'},
			{ field:'', caption:'', size:'10%', style:'text-align:center' ,  sortable: true},
			{ field:'', caption:'', size:'10%', style:'text-align:center' },
			{ field:'tot_unit', caption:'합계', size:'10%', style:'text-align:center'}, // right // 120px
			{ field:'tot_menge', caption:'', size:'8%', style:'text-align:center'},
			{ field:'tot_price', caption:'', size:'10%', style:'text-align:center'},
			{ field:'', caption:'', size:'10%', style:'text-align:center'},
			{ field:'', caption:'', size:'20%', style:'text-align:center'}
			
			], 
			
		records: [
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	
		w2ui['grid_list2'].add([
	          			 { recid:'g1', tot_unit : '' , tot_menge : '' , tot_price : ''}
	          	     ]);

}





function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
}

var currentEventColumn = '';
function modalGrid() {
	console.log("modalGrid()");
	
	var rowArr = [];
	
	$('#modalGrid').w2grid({ 
        name: 'modalGrid',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: false
           
        },
        multiSelect: false,
        summary: false,
        columns: [              
		 	{field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'
				/* ,
				editable: { type: 'list', items: itemArr_PN, showAll: true } */
			},
			{field: 'item_nm', caption: '품명', size:'40%', style:'text-align:center'
				
				/* ,
				editable: { type: 'list', items: itemArr, showAll: true } */
				
               
			}, 
			/* {field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'
				, editable: { type: 'text' }
			},
			{field: 'item_nm', caption: '품명', size:'40%', style:'text-align:center'	
				, editable: { type: 'text' }
			}, */
			{ field:'sap_code', caption:'SAP코드', size:'15%',  style:'text-align:center' , editable: { type: 'text' } , sortable: true},
			{ field:'serial_no', caption:'S/N', size:'15%', style:'text-align:center' , editable: { type: 'text' }  },
			{ field:'menge', caption:'주문수량', size:'15%', style:'text-align:center' , editable: { type: 'int' }
		
			},
			{ field:'unit_price', caption:'단가', size:'15%',  style:'text-align:center' , editable: { type: 'int' }
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }    
				 //,render: 'number'
			},
			{ field:'total_price', caption:'전체금액', size:'15%',  style:'text-align:center'
			 ,render: function (record, index, col_index) {
	               var html = this.getCellValue(index, col_index);

	               html = w2utils.formatters['number'](html);
	               html = setComma(html);
	                  return html;
	              }    
				// ,render: 'number'
			},
		
			{ field:'comment', caption:'특이사항', size:'15%',  style:'text-align:center' , editable: { type: 'text' }}
			/* { field:'delivery_date', caption:'납품요청일', size:'15%',  style:'text-align:center', 
				editable: { type: 'date', format: 'yyyy-mm-dd'}  
			}*/
			
			], 

		records: [

			],
		/*  summary: [
		              { recid:'s_1', menge: 0, unit_price: 0, total_price: 0}
		         ], */
		onSelect: function (event) {
 			event.onComplete = function () {
 				console.log("#### onSelect");
 		     
 		        
 		       currentEventColumn = event.column;
 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				console.log("#### onUnselect");
	
		        
		        currentEventColumn = '';
			}
		},
		onClick: function (event) {
 			event.onComplete = function () {
 				console.log("#### onClick");
					
 				w2ui.modalGrid.editField(event.recid, event.column);
 			}
 	
		}, onChange: function(event) {
			event.onComplete = function () {
				console.log("onChange");
				
				// # 20200922 콤보에 떠도 , 다 입력하고 엔터쳤을 때 문제 생김
				
				var eventColumn = event.column;
				console.log(event);
				console.log('event.value : ' + event.value);
				w2ui.modalGrid.save();
				
							
			/* 	if(eventColumn == 0 || eventColumn == 1) {
					
					w2ui.modalGrid.save();
					
					var key = event.recid; 
					var rowData = w2ui['modalGrid'].get(key);
					
					if(eventColumn == 0)
					{
						var item_nm = getItemName(rowData.item_code);
						if(rowData.item_code == '')
						{
							w2ui['modalGrid'].set( key , {item_nm : '' }); 
							w2ui['modalGrid'].set( key , {item_code : '' }); 
						}else{
				
							w2ui['modalGrid'].set( key , {item_nm : item_nm }); 
						}
						
					}	else if(eventColumn == 1)
					{
						var item_code = getItemCode(rowData.item_nm);
						
						if(rowData.item_nm == '')
						{
							w2ui['modalGrid'].set( key , {item_nm : '' }); 
							w2ui['modalGrid'].set( key , {item_code : '' }); 
						}else{
				
						w2ui['modalGrid'].set( key , {item_code : item_code }); 
						}
						
					}
		 				
					
					var caption = w2ui.modalGrid.columns[event.column].caption; // 컬럼명 나오게 하기
					
					var menge = "";
					var release_price = "";
					var rdss  = w2ui.modalGrid.records;
					$.each(rdss, function(idx, row){
			 			
						if(key == row.recid) {
							console.log('key : ' + key);
							console.log(' row.recid : ' +  row.recid);
							menge =  w2ui.modalGrid.records[idx].menge; 
							release_price = w2ui.modalGrid.records[idx].item_nm; //w2ui['modalGrid'].get(key).routing_gubun;
						
						}
					});
					
					 $.each(itemArr, function(idx, row){
 					
						if(release_price == row.text) {
							release_price = row.release_price; //w2ui['modalGrid'].get(key).routing_gubun;
				
						}
					}); 
					
					
					var total_price = Number(menge) * Number(release_price);
					
					w2ui['modalGrid'].set( key , {unit_price : release_price }); 
					w2ui['modalGrid'].set( key , {total_price : total_price }); 
					
					setTimeout(function(){ 
						w2ui.modalGrid.editField(event.recid, 2); 
					}, 10);
					
				}else  */
				if(eventColumn == 4 || eventColumn == 5) {
					w2ui.modalGrid.save();
					var key = event.recid; 
					var menge = "";
					var release_price = "";
					var rdss  = w2ui.modalGrid.records;
					$.each(rdss, function(idx, row){
			 			
						if(key == row.recid) {
				
							menge = w2ui.modalGrid.records[idx].menge;
							release_price = w2ui.modalGrid.records[idx].unit_price; //w2ui['modalGrid'].get(key).routing_gubun;

						}
					});
					var total_price = Number(menge) * Number(release_price);
					
				
					w2ui['modalGrid'].set( key , {total_price : total_price }); 
					
					setTimeout(function(){ 
						if(eventColumn == 4){
							w2ui.modalGrid.editField(event.recid, 5);	
						}else if(eventColumn == 5){
							w2ui.modalGrid.editField(event.recid, 7);	
						}
					}, 10);
					
					changeSummary();
					changeSummary2();
					
				}
			}
		}, editField: function (recid, column, value, event) {
            var obj = this;
            
            if (this.last.inEditMode === true) { // already editing
            	
           	 	var $input = $(this.box).find('div.w2ui-edit-box .w2ui-input');
                if ($input.length > 0 && $input[0].tagName == 'DIV') {
                    $input.text($input.text() + value);
                    w2utils.setCursorPosition($input[0], $input.text().length);
                }
            	
                
                return;
            }
            var index  = obj.get(recid, true);
            var edit   = obj.getCellEditable(index, column);
            if (!edit) return;
            var rec    = obj.records[index];
            var col    = obj.columns[column];
            var prefix = (col.frozen === true ? '_f' : '_');
            if (['enum', 'file'].indexOf(edit.type) != -1) {
                console.log('ERROR: input types "enum" and "file" are not supported in inline editing.');
                return;
            }
            // event before
            var edata = obj.trigger({ phase: 'before', type: 'editField', target: obj.name, recid: recid, column: column, value: value,
                index: index, originalEvent: event });
            if (edata.isCancelled === true) return;
            value = edata.value;
            // default behaviour
            this.last.inEditMode = true;
            this.last._edit = { value: value, index: index, column: column, recid: recid };
            this.selectNone();
            this.select({ recid: recid, column: column });
            if (['checkbox', 'check'].indexOf(edit.type) != -1) return;
            // create input element
            var tr = $('#grid_'+ obj.name + prefix +'rec_' + w2utils.escapeId(recid));
            var el = tr.find('[col='+ column +'] > div');
            // clear previous if any
            $(this.box).find('div.w2ui-edit-box').remove();
            // for spreadsheet - insert into selection
            if (this.selectType != 'row') {
                $('#grid_'+ this.name + prefix + 'selection')
                    .attr('id', 'grid_'+ this.name + '_editable')
                    .removeClass('w2ui-selection')
                    .addClass('w2ui-edit-box')
                    .prepend('<div style="position: absolute; top: 0px; bottom: 0px; left: 0px; right: 0px;"></div>')
                    .find('.w2ui-selection-resizer')
                    .remove();
                el = $('#grid_'+ this.name + '_editable >div:first-child');
            }
            if (edit.inTag   == null) edit.inTag   = '';
            if (edit.outTag  == null) edit.outTag  = '';
            if (edit.style   == null) edit.style   = '';
            if (edit.items   == null) edit.items   = [];
            var val = (rec.w2ui && rec.w2ui.changes && rec.w2ui.changes[col.field] != null ? w2utils.stripTags(rec.w2ui.changes[col.field]) : w2utils.stripTags(rec[col.field]));
            if (val == null) val = '';
            var old_value = (typeof val != 'object' ? val : '');
            if (edata.old_value != null) old_value = edata.old_value;
            if (value != null) val = value;
            var addStyle = (col.style != null ? col.style + ';' : '');
            if (typeof col.render == 'string' && ['number', 'int', 'float', 'money', 'percent', 'size'].indexOf(col.render.split(':')[0]) != -1) {
                addStyle += 'text-align: right;';
            }
            // normalize items
            if (edit.items.length > 0 && !$.isPlainObject(edit.items[0])) {
                edit.items = w2obj.field.prototype.normMenu(edit.items);
            }
            switch (edit.type) {

                case 'select':
                    var html = '';
                    for (var i = 0; i < edit.items.length; i++) {
                        html += '<option value="'+ edit.items[i].id +'"'+ (edit.items[i].id == val ? ' selected="selected"' : '') +'>'+ edit.items[i].text +'</option>';
                    }
                    el.addClass('w2ui-editable')
                        .html('<select id="grid_'+ obj.name +'_edit_'+ recid +'_'+ column +'" column="'+ column +'" class="w2ui-input"'+
                            '    style="width: 100%; pointer-events: auto; padding: 0 0 0 3px; margin: 0px; border-left: 0; border-right: 0; border-radius: 0px; '+
                            '           outline: none; font-family: inherit;'+ addStyle + edit.style +'" '+
                            '    field="'+ col.field +'" recid="'+ recid +'" '+
                            '    '+ edit.inTag +
                            '>'+ html +'</select>' + edit.outTag);
                    setTimeout(function () {
                        el.find('select')
                            .on('change', function (event) {
                                delete obj.last.move;
                            })
                            .on('blur', function (event) {
                                if ($(this).data('keep-open') == true) return;
                                obj.editChange.call(obj, this, index, column, event);
                            });
                    }, 10);
                    break;

                case 'div':
                    var $tmp = tr.find('[col='+ column +'] > div');
                    var font = 'font-family: '+ $tmp.css('font-family') + '; font-size: '+ $tmp.css('font-size') + ';';
                    el.addClass('w2ui-editable')
                        .html('<div id="grid_'+ obj.name +'_edit_'+ recid +'_'+ column +'" class="w2ui-input"'+
                            '    contenteditable style="'+ font + addStyle + edit.style +'" autocorrect="off" autocomplete="off" spellcheck="false" '+
                            '    field="'+ col.field +'" recid="'+ recid +'" column="'+ column +'" '+ edit.inTag +
                            '></div>' + edit.outTag);
                    if (value == null) el.find('div.w2ui-input').text(typeof val != 'object' ? val : '');
                    // add blur listener
                    var input = el.find('div.w2ui-input').get(0);
                    setTimeout(function () {
                        var tmp = input;
                        $(tmp).on('blur', function (event) {
                            if ($(this).data('keep-open') == true) return;
                            obj.editChange.call(obj, tmp, index, column, event);
                        });
                    }, 10);
                    if (value != null) $(input).text(typeof val != 'object' ? val : '');
                    break;

                default:
                    var $tmp = tr.find('[col='+ column +'] > div');
                    var font = 'font-family: '+ $tmp.css('font-family') + '; font-size: '+ $tmp.css('font-size');
                    el.addClass('w2ui-editable')
                        .html('<input id="grid_'+ obj.name +'_edit_'+ recid +'_'+ column +'" autocorrect="off" autocomplete="off" spellcheck="false" type="text" '+
                            '    style="'+ font +'; width: 100%; height: 100%; padding: 3px; border-color: transparent; outline: none; border-radius: 0; '+
                            '       pointer-events: auto; '+ addStyle + edit.style +'" '+
                            '    field="'+ col.field +'" recid="'+ recid +'" column="'+ column +'" class="w2ui-input"'+ edit.inTag +
                            '/>' + edit.outTag);
                    // issue #499
                    if (edit.type == 'number') {
                        val = w2utils.formatNumber(val);
                    }
                    if (edit.type == 'date') {
                        val = w2utils.formatDate(w2utils.isDate(val, edit.format, true) || new Date(), edit.format);
                    }
                    if (value == null) el.find('input').val(typeof val != 'object' ? val : '');
                    // init w2field
                    var input = el.find('input').get(0);
                    $(input).w2field(edit.type, $.extend(edit, { selected: val }));
                    // add blur listener
                    setTimeout(function () {
                        var tmp = input;
                        if (edit.type == 'list') {
                            tmp = $($(input).data('w2field').helpers.focus).find('input');
                            if (typeof val != 'object' && val != '') tmp.val(val).css({ opacity: 1 }).prev().css({ opacity: 1 });
                            el.find('input').on('change', function (event) {
                                obj.editChange.call(obj, input, index, column, event);
                            });
                        }
                        $(tmp).on('blur', function (event) {
                            if ($(this).data('keep-open') == true) return;
                            obj.editChange.call(obj, input, index, column, event);
                        });
                    }, 10);
                    if (value != null) $(input).val(typeof val != 'object' ? val : '');
            }

            setTimeout(function () {
                if (!obj.last.inEditMode) return;
                el.find('input, select, div.w2ui-input')
                    .data('old_value', old_value)
                    .on('mousedown', function (event) {
                        event.stopPropagation();
                    })
                    .on('click', function (event) {
                        if (edit.type == 'div') {
                            expand.call(el.find('div.w2ui-input')[0], null);
                        } else {
                            expand.call(el.find('input, select')[0], null);
                        }
                    })
                    .on('paste', function (event) {
                        // clean paste to be plain text
                        var e = event.originalEvent;
                        event.preventDefault();
                        var text = e.clipboardData.getData("text/plain");
                        document.execCommand("insertHTML", false, text);
                    })
                    .on('keydown', function (event) {
                    	
                        var el  = this;
                        var val = (el.tagName.toUpperCase() == 'DIV' ? $(el).text() : $(el).val());
                        switch (event.keyCode) {
                            case 8: // backspace;
                                if (edit.type == 'list' && !$(input).data('w2field')) { // cancel backspace when deleting element
                                    event.preventDefault();
                                }
                                break;
                            case 9:
                            case 13:
                                event.preventDefault();
                                break;
                            case 37:
                                if (w2utils.getCursorPosition(el) === 0) {
                                    event.preventDefault();
                                }
                                break;
                            case 39:
                                if (w2utils.getCursorPosition(el) == val.length) {
                                    w2utils.setCursorPosition(el, val.length);
                                    event.preventDefault();
                                }
                                break;
                        }
                        // need timeout so, this handler is executed last
                        setTimeout(function () {
                            switch (event.keyCode) {
                                case 13:  // tab -> enter
                                    var next_rec = recid;
                                    var next_col = event.shiftKey ? obj.prevCell(index, column, true) : obj.nextCell(index, column, true);
                                    // next or prev row
                                    if (next_col == null) {
                                        var tmp = event.shiftKey ? obj.prevRow(index, column) : obj.nextRow(index, column);
                                        if (tmp != null && tmp != index) {
                                            next_rec = obj.records[tmp].recid;
                                            // find first editable row
                                            for (var c = 0; c < obj.columns.length; c++) {
                                                var edit = obj.getCellEditable(index, c);
                                                if (edit != null && ['checkbox', 'check'].indexOf(edit.type) == -1) {
                                                    next_col = parseInt(c);
                                                    if (!event.shiftKey) break;
                                                }
                                            }
                                        }

                                    }
                                    if (next_rec === false) next_rec = recid;
                                    if (next_col == null) next_col = column;
                                    // init new or same record
                                    el.blur();
                       
                      
                                    setTimeout(function () {
                                        if (obj.selectType != 'row') {
                                      
                                            obj.selectNone();
                                            obj.select({ recid: next_rec, column: next_col });
                                        } else {
                                  
                                        	if(currentEventColumn == 4){

                    			         	 	obj.editField(next_rec, 5, null, event);
                    						}else if(currentEventColumn  == 5){
                    						
                    							obj.editField(next_rec, 7, null, event);
                    						}else {
                    			
                                           	 	obj.editField(next_rec, next_col, null, event);
                    						}
                                        }
                                    }, 1);
                                    if (event.preventDefault) event.preventDefault();
                                    break;

                                case 9: // enter -> tab
                                    el.blur();
                                    var next = event.shiftKey ? obj.prevRow(index, column) : obj.nextRow(index, column);
                                    if (next != null && next != index) {
                                        setTimeout(function () {
                                            if (obj.selectType != 'row') {
                                                obj.selectNone();
                                                obj.select({ recid: obj.records[next].recid, column: column });
                                            } else {
                                                obj.editField(obj.records[next].recid, column, null, event);
                                            }
                                        }, 1);
                                    }
                                    if (el.tagName.toUpperCase() == 'DIV') {
                                        event.preventDefault();
                                    }
                                    break;

                                case 27: // escape
                                    var old = obj.parseField(rec, col.field);
                                    if (rec.w2ui && rec.w2ui.changes && rec.w2ui.changes[col.field] != null) old = rec.w2ui.changes[col.field];
                                    if ($(el).data('old_value') != null) old = $(el).data('old_value');
                                    if (el.tagName.toUpperCase() == 'DIV') {
                                        $(el).text(old != null ? old : '');
                                    } else {
                                        el.value = old != null ? old : '';
                                    }
                                    el.blur();
                                    setTimeout(function () { obj.select({ recid: recid, column: column }); }, 1);
                                    break;
                            }
                            // if input too small - expand
                            expand.call(el, event);
                        }, 1);
                    })
                    .on('keyup', function (event) {
                        expand.call(this, event);
                    });
                // focus and select
                setTimeout(function () {
                    if (!obj.last.inEditMode) return;
                    var tmp = el.find('.w2ui-input');
                    var len = ($(tmp).val() != null ? $(tmp).val().length : 0);
                    if (edit.type == 'div') len = $(tmp).text().length;
                    if (tmp.length > 0) {
                        tmp.focus();
                        clearTimeout(obj.last.kbd_timer); // keep focus
                        if (tmp[0].tagName.toUpperCase() != 'SELECT') w2utils.setCursorPosition(tmp[0], len);
                        tmp[0].resize = expand;
                        expand.call(tmp[0], null);
                    }
                }, 50);
                // event after
                obj.trigger($.extend(edata, { phase: 'after', input: el.find('input, select, div.w2ui-input') }));
            }, 5); // needs to be 5-10
            return;

            function expand(event) {
                try {
                    var val   = (this.tagName.toUpperCase() == 'DIV' ? $(this).text() : this.value);
                    var $sel  = $('#grid_'+ obj.name + '_editable');
                    var style = 'font-family: '+ $(this).css('font-family') + '; font-size: '+ $(this).css('font-size') + '; white-space: pre;';
                    var width = w2utils.getStrWidth(val, style);
                    if (width + 20 > $sel.width()) {
                        $sel.width(width + 20);
                    }
                } catch (e) {
                }
            }
        }		
	});
	
	w2ui['modalGrid'].records = gridDataArr;
	w2ui.modalGrid.on('keyboard', function(event) {
	});
	
}



function tot_modal_grid(){
	var rowArr = [];
	
	$('#tot_modalGrid').w2grid({ 
        name: 'tot_modalGrid',
        show: {
			lineNumbers : true,
            footer: false,
            selectColumn: false
        },
        multiSelect: false,
        
        columns: [            
				{field: '', caption: '', size:'30%', style:'text-align:center'},
				{field: '', caption: '', size:'40%', style:'text-align:center'}, 
				{ field:'', caption:'', size:'15%',  style:'text-align:center' ,sortable: true},
				{ field:'', caption:'', size:'15%', style:'text-align:center'},
				{ field:'tot_menge', caption:'합계', size:'15%', style:'text-align:center'},
				{ field:'tot_unit', caption:'', size:'15%',  style:'text-align:center'},
				{ field:'tot_price', caption:'', size:'15%',  style:'text-align:center'},
				
				{ field:'', caption:'', size:'15%',  style:'text-align:center'}      
                  
			], 
			
		records: [
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	
		w2ui['tot_modalGrid'].add([
		          			 { recid:'g2', tot_unit : '' , tot_menge : '' , tot_price : ''}
		          	     ]);

}


/* w2ui.modalGrid.on('editField', function(event) {
    console.log('value', event.value);
}); */
 /*  (function(){
	  document.addEventListener('keydown', function(e){
	    const keyCode = e.keyCode;
	    console.log('pushed key ' + e.key);
	    
	 	 if(currentEventColumn == '0')
    	{
	 		//editable: { type: 'list', items: itemArr_PN, showAll: true }
       	 	w2ui['modalGrid'].columns[0].editable = { type: 'list', items: itemArr_PN, showAll: true };
    	}else
    	{
    		w2ui['modalGrid'].columns[0].editable = false;
    	}
	 	
	 	if(currentEventColumn == '1')
    	{
	 		//editable: { type: 'list', items: itemArr_PN, showAll: true }
       	 	w2ui['modalGrid'].columns[1].editable = { type: 'list', items: itemArr, showAll: true };
    	}else
    	{
    		w2ui['modalGrid'].columns[1].editable = false;
    	} 
       
	     if(keyCode == 13){ // Enter key
	    	  event = new dom.window.KeyboardEvent('keydown', { keyCode: 9 }); // Tab key
	    	 dom.window.dispatchEvent(event); 
	    } 
	  })
	})();   */
	
	
var startValue_combo = "";
var comboValue_nm = new Array;
// 고객사 가져오기
function requestCustomer(){
	console.log("requestCustomer");
	
	//initOptions($('#'+val)); // select 박스 초기화
	///customer/selectCustomer
	var strUrl = "/info/customer/selectCustomer";
	
	var postData = "business_code=" + 'MD1243';
	postData += "&business_codeT=" + 'MD1282';
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    async : false, // 다 끝나고 다음 처리 해!
	    dataType: 'json', 
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		
    			var objt = new Object();
    			$.each(rowArr, function(idx, row){
    				objt = new Object();
    				objt.customer_integration_code = row.customer_integration_code;
    				objt.customer_code = row.customer_code;
    				objt.customer_integration_nm = row.customer_integration_nm;
    				objt.customer_nm = row.customer_nm;
    				objt.land = row.land;
    				
    				customerArr.push(objt);
    				
    				if (startValue_combo == "") {
						comboValue_nm.push(row.customer_nm);
				
					}
    			});
    			
    			if (startValue_combo == "") {

					$('#m_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
				}
	    			
	 			
	    	} else if(data.status == "200" && (data.rows).length==0) {
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
function getOrderNum()
{
	var key = w2ui.grid_list.getSelection();

	var order_num = "";
	if( key.length==1 ) {	
		var data = w2ui.grid_list.get(key[0]);
		order_num = data.order_num;
	}
	
	return order_num;
}

function requestCustomer_data(flag)
{
	var customer_nm = $("#m_customer_nm").val();
	var result = '';
	$.each(customerArr, function(idx, row){
		

		if(flag == 'customer_code')
		{
			if( row.customer_nm == customer_nm ) 
			{
				result = row.customer_code;
			}
		}else if(flag == 'land')
		{
			if( row.customer_nm == customer_nm ) 
			{
				result = row.land;
			}
		}
	});
	
	return result;
}
//제품
function requestItem(){
	console.log("requestItem");
	
	//initOptions($('#'+val)); // select 박스 초기화
	///customer/selectCustomer
	var strUrl = "/info/material/selectMaterial3";
	//var postData = "item_type_code=" + 'MD1248';
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	   // data: postData, 
	    dataType: 'json', 
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		
    			var objt = new Object();
    			var objt_PN = new Object();
    			$.each(rowArr, function(idx, row){
    				objt = new Object();
    				objt.item_code = row.item_code;
    				objt.item_nm = row.item_nm;
    				objt.text = row.item_nm;
    				objt.release_price = row.release_price;
    				
    				itemArr.push(objt);
    				
    				
    				objt_PN = new Object();
    				objt_PN.item_code = row.item_code;
    				objt_PN.item_nm = row.item_nm;
    				objt_PN.text = row.item_code;
    				objt_PN.release_price = row.release_price;
    				
    				itemArr_PN.push(objt_PN);
    			});
    			

    			console.log('item_code : ' + itemArr[0].item_code);
			//	console.log('item_nm : ' + row.item_nm);
	 			
	    	} else if(data.status == "200" && (data.rows).length==0) {
	    		initOptions($('#'+val)); // select 박스 초기화
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {

	    	//modalGrid();
	    }
	});
	
}
//-------------------------------------------------------------------------------------------------------------------

function setting_plus()
{

	/* for(var i = 0; i< 22; i ++){
		currentRecid = Number(i) + 1;
		w2ui['modalGrid'].add([
		               		{ recid:  currentRecid, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''}
		               	]);
	} */
	
	
	w2ui['modalGrid'].add([
		           { recid:  1, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  2, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  3, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  4, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  5, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  6, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  7, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  8, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  9, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  10, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  11, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  12, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  13, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  14, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  15, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  16, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  17, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  18, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  19, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  20, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  21, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''},
		           { recid:  22, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : ''}
		               	]);
}
function plus() {
	console.log("plus()");

	w2ui.modalGrid.selectNone();
	w2ui['modalGrid'].refresh();
	var rowArr = w2ui['modalGrid'].records; 

	var currentRecid = Number(deleteItems.length) + Number(rowArr.length) + 1;
	
	var delivery_date ='';
	if(Number(rowArr.length) > 0){
		
	
		delivery_date = rowArr[0].delivery_date;
	}
	

	
	w2ui['modalGrid'].add([
		{ recid:  currentRecid, item_code: '' , item_nm: '', menge: '1', unit_price : '', total_price : '', delivery_date : delivery_date }
	]);
	


}
var deleteItems = new Array;
//오른쪽 그리드에 값 삭제시
function minus() {
	var selIdxArr = w2ui.modalGrid.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
	}  else {
		for(var i=0; i<chkLen; i++){
		 	var row = w2ui.modalGrid.get(selIdxArr[i]);
		 	
		 	// 삭제 어레이에 추가 한다.
		 	objt = new Object();
			objt.item_code = row.item_code;
			objt.order_num = getOrderNum();
			console.log('row.item_code : ' + row.item_code);
			
			if(objt.item_code != '' && objt.item_code != undefined && objt.item_code != null)
			{
				console.log('deleteItems에 추가');
		 		deleteItems.push(objt);
			}
		 	
		 	w2ui['modalGrid'].remove(row.recid);
		 	
			
		}
	 } 
	w2ui.modalGrid.selectNone();	
	w2ui['modalGrid'].refresh();

	
}

//등록/수정 모달 생성
function requestIU_modal()
{
	// 삭제 어레이 초기화 
	deleteItems = new Array;
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		insertItem();
	}else  if( key.length==1 ) {	
		updateItem();	
	}
}

//등록
function insertItem() {
	console.log('insertItem()');

	w2ui.grid_list.selectNone();
	
	try{
		console.log("그리드클린");
		
		
		w2ui['modalGrid'].clear();
		w2ui['tot_modalGrid'].clear();
		w2ui['tot_modalGrid'].add([
				          			 { recid:'g2', tot_unit : '' , tot_menge : '' , tot_price : ''}
				          	     ]);
		
		setTimeout(function(){
			
			console.log("그리드사이즈조정2");
			
		      w2ui['modalGrid'].resize();
		      w2ui['modalGrid'].refresh();
		      w2ui['grid_list'].unlock();

		   }, 200);
	}catch(e)
	{
	
	}

	$("#modal_code_title").text('등록');
	$("#ct_codeView").css('display', 'none');
	$("#m_customer_code").val('');
	$("#m_manager_nm").val('');
	$("#m_customer_nm").val('');
	$("#m_request_num").val('');
	
	
	
	//setting_plus();
	
/* 	w2ui['modalGrid'].add([
		          			 { w2ui: { summary: true }, recid:'s_1', menge : 0, unit_price : '' , total_price : 0}
		          	     ]); */
   		setTimeout(function(){
   	      w2ui['tot_modalGrid'].resize();
   	      w2ui['tot_modalGrid'].refresh();

   	   }, 200);
	$("#modal_info").modal('show');

}
//수정
function updateItem() {
	console.log('updateItem()');
	w2ui['modalGrid'].clear();
	w2ui['modalGrid'].refresh();
	
	/* w2ui['tot_modalGrid'].clear();
	w2ui['tot_modalGrid'].refresh(); */
	var key = w2ui.grid_list.getSelection();
	setTimeout(function(){
	      w2ui['modalGrid'].resize();
	      w2ui['modalGrid'].refresh();
	   }, 200);
	
	/* setTimeout(function(){
	      w2ui['tot_modalGrid'].resize();
	      w2ui['tot_modalGrid'].refresh();

	   }, 200); */
	 if( key.length==1 ) {
		// update
		$("#modal_code_title").text('수정');
		var data = w2ui.grid_list.get(key[0]);
		$("#m_customer_nm").attr('disabled',false);
		
		$("#m_customer_nm").val(data.customer_nm);
		$("#m_manager_nm").val(data.manager_nm);
		$("#m_request_num").val(data.request_num);
		//$("#m_sap_code").val(data.sap_code);
		//$("#m_comment").val(data.comment);

		$("#ct_codeView").css('display', '');

		loadList_modal();
	/* 	w2ui['modalGrid'].add([
			          			 { w2ui: { summary: true }, recid:'s_1', menge : 0, unit_price : '' , total_price : 0}
			          	     ]); */
		$("#modal_info").modal('show');
	} else {
		fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
	}
	
}

function saveProcess()
{
	console.log("saveProcess()");
	w2ui.modalGrid.save();
	
	
	if(!chkSubmit($("#m_customer_nm"), "고객사명을")) return;
	
	if(!chkSubmit($("#m_manager_nm"), "담당자명을")) return;
	
	if(!chkSubmit($("#m_request_num"), "발주번호를")) return;
	
	//if(!chkSubmit($("#m_comment"), "메모를")) return;
	
	//if(!chkSubmit($("#m_sap_code"), "SAP코드를")) return;
	
	$.each(deleteItems, function(idx, row){
		
		if(row.order_num != '' )
		{
			deleteItem_modal(row.order_num, row.item_code);
		}
	
	}); 
	
	var records = w2ui.modalGrid.records;
	var status = "OK";

	
	/* 
	$.each(records, function(idx, row){
		if(row.item_code != '' && row.item_code != 'null' && row.item_code != null){
			if(row.delivery_date == "") {
				status = "ERROR";
			}
		}
	});
	if(status != "OK" ) {
		fnMessageModalAlert("알림", "납품요청일은 비워둘 수 없습니다. 다시 입력해 주세요.");
		return;
	}	 */
	
	
	
	var order_num = "";
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		order_num = requestOrderNum();
	}else  if( key.length==1 ) {	
		order_num = getOrderNum();
	}
	console.log("order_num : " + order_num);
	
	$.each(records, function(idx, row){
		
		if(row.item_code != '' && row.item_code != 'null' && row.item_code != null){
			
			console.log('recid : ' + row.recid);
	
			saveItem(row,order_num, row.recid);
		}

	});
}

function getItemCode(item_nm)
{
	console.log('getItemCode item_nm : ' + item_nm);
	var reuslt = '';
	$.each(itemArr, function(idx, row){
		
		if(row.item_nm == item_nm)
		{
			result = row.item_code;		
		}
	});
	console.log('getItemCode reuslt : ' + reuslt);
	return result;
}

function getItemName(item_code)
{
	console.log('getItemName item_code : ' + item_code);
	var reuslt = '';
	$.each(itemArr, function(idx, row){
		
		if(row.item_code == item_code)
		{
			result = row.item_nm;		
		}
	});
	console.log('getItemName reuslt : ' + reuslt);
	return result;
}

//저장
function saveItem(row,order_num, recid) {
	console.log('saveItem()');
	
	var order_num = order_num;
	var item_rec_id = recid;
	var item_code = row.item_code;
	var item_nm = row.item_nm;
	var delivery_date = $("#m_delivery_date").val();
	delivery_date = delivery_date.replace(/-/gi, "");
	
	var customer_code = requestCustomer_data('customer_code');
	var customer_nm =  $("#m_customer_nm").val();
	var sap_code =  row.sap_code;
 	var serial_no = row.serial_no;

	
	var comment =  row.comment;
	var request_num =  $("#m_request_num").val();
	var manager_nm =  $("#m_manager_nm").val();
	var land  = requestCustomer_data('land');
	var unit_price = row.unit_price;
	var menge = row.menge;
	var total_price = Number(unit_price) * Number(menge);
	var success_status = 'N';
	
	console.log('sap_code : ' + sap_code );
	console.log('comment : ' + comment );

	
	if(sap_code == 'undefined')
	{
		sap_code = '';
	}
	
	if(serial_no == 'undefined')
	{
		serial_no = '';
	}
	
	if(comment == 'undefined')
	{
		comment = '';
	}
	
	$("#modal_info").modal('hide');
	
	var strUrl = "/frontend/consumable/saveOrder";

	var postData = {
			order_num : order_num ,
			item_code : item_code ,
			item_nm : item_nm ,
			delivery_date : delivery_date ,
			customer_code : customer_code ,
			request_num : request_num,
			customer_nm : customer_nm,
			sap_code : sap_code,
			serial_no : serial_no,
			comment : comment,
			manager_nm : manager_nm,
			land : land ,
			unit_price : unit_price ,
			menge : menge ,
			total_price : total_price ,
			success_status : success_status ,
			item_rec_id : item_rec_id
		}
	FunLoadingBarStart();	 
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
		//async : false,	
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
		    	loadList();
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
			$("#modal_info").modal('hide');
			FunLoadingBarEnd();
	    }
	});
}



//삭제
function deleteItem() {
	console.log('deleteItem()');

	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui.grid_list.get(key[0]);
		var order_num = data.order_num;
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				console.log("order_num = " + order_num);
				
				var strUrl = "/frontend/consumable/deleteOrder";
			
				
				var postData = "order_num=" + encodeURIComponent(order_num);
				
				$.ajax({
					 url: strUrl,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
					 		console.log(data);
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


// 모달에서 저장시 삭제
function deleteItem_modal(order_num, item_code) {
	console.log('deleteItem_modal()');
		
	var strUrl = "/frontend/consumable/deleteOrder";

	var postData = "order_num=" + encodeURIComponent(order_num)
	+ "&item_code=" + encodeURIComponent(item_code);
	
	$.ajax({
		 url: strUrl,
		 type: "POST",
		 dataType : 'json', 
		 data : postData, 
		 async : false,
		 success:function(data, textStatus, jqXHR){
		 	if(data.status == "200") {
		 		console.log(data);
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

// $("#item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('item_nm key_up : '+ value);
		
// 		getItemInfo('nm',value);
// 		return value
// 	});
	
// 	},400));
	
// 	$("#item_code").change(
			
// 			_.debounce(function(event) 
// 			{
		
// 				var item_code = $("#item_code").val();
// 				$(this).val(function(index, value) {
// 					console.log('item_code key_up : '+ value);
					
// 					getItemInfo('cd',value);
// 					return value
// 				});
		
// 	},400));
	
// 	var materialArr = new Array;
	
// 	function getItemInfo(type, value)
// 	{
		
// 		console.log('getItemInfo() : ' + value);
// 		var result = "";
// 		if(type == 'cd')
// 		{
// 			$.each(materialArr, function(idx, row){
				
// 				if(value == row.item_code)
// 				{
// 					console.log('row.item_nm : ' + row.item_nm);
// 					result = row.item_nm;		
// 					$("#item_nm").val(result);
// 				}
// 			});

// 			if(result == ''){
// 				$("#item_nm").val('');
// 			}
			
// 		}else if(type == 'nm')
// 		{
			
// 			$.each(materialArr, function(idx, row){
				
// 				if(value == row.item_nm)
// 				{
// 					console.log('row.item_code : ' + row.item_code);
// 					result = row.item_code;
// 					$("#item_code").val(result);
// 				}
// 			});
// 			if(result == ''){
// 				$("#item_code").val('');
// 			}
			
// 		}

		
		
// 	}

//조회
function loadList() {
	console.log("loadList()");
	
	
	
	w2ui.grid_list.clear();
	
	var page_url = "/frontend/consumable/selectOrder";

	
	var postData = {
			
			customer_nm : $('#customer_nm').val() || "",
			request_num : $('#request_num').val() || "",
			item_nm : $('#item_nm').val() || "",
			item_code : $('#item_code').val() || "",
			delivery_date : $('#delivery_date').val() || "",
			process_status : $('#process_status').val() || ""
	}
		
	/* var postData = {
			delivery_date : encodeURIComponent(delivery_date) ,
			customer_nm :  encodeURIComponent(customer_nm) ,
			item_code :  encodeURIComponent(item_code) ,
			item_nm :  encodeURIComponent(item_nm)
		} */

	//w2ui['grid_list'].lock('loading...', true);
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
					
					if (startValue_combo == "") {
						materialArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.customer_nm);
						comboValue_nm4.push(row.request_num);
					}
					
					row.unit_price = Number(row.unit_price);
					row.menge = Number(row.menge);
					row.total_price = Number(row.total_price);
				});
				
				gridDataArr = rowArr;

				w2ui['grid_list'].records = rowArr;
				
					
					
				
			
			}
			else
			{
				w2ui['grid_list'].clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#request_num').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			
			
			
// 			changeGridUI(gridDataArr);
			
		},complete: function () {
			startValue_combo = ":)";
	
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("customer_nm").style.removeProperty("height");
			document.getElementById("request_num").style.removeProperty("height");
			
			grid_list_tot();
		}
		
	});
}


function grid_list_tot()
{
	
	setTimeout(function(){
	      w2ui['grid_list2'].resize();
	      w2ui['grid_list2'].refresh();

	   }, 200);
	
	var rowArr3 = w2ui['grid_list'].records; 
	
	var tot_unit = 0;	
	var tot_menge = 0;
	var tot_price = 0;
	
	currentRecid = Number(i) + 1;
	
	console.log("lenght?????" + rowArr3.length);

	for(var i = 0; i < rowArr3.length; i ++)
	{
		var data = rowArr3[i];
		
		console.log("00000000000000000000");
 		
		tot_unit = tot_unit + parseInt(data.unit_price);
		tot_menge = tot_menge + parseInt(data.menge);
		tot_price = tot_price + parseInt(data.total_price); 
		

	}
	
	console.log('tot_unit :  ' + tot_unit);
	console.log('tot_menge :  ' + tot_menge);
	console.log('tot_price :  ' + tot_price);
	
	tot_unit = w2utils.formatters['number'](tot_unit);
	tot_price = w2utils.formatters['number'](tot_price); 

	/* w2ui['grid_list2'].add([
		               		{ recid:  currentRecid, tot_unit: tot_unit , tot_menge: tot_menge, tot_price: tot_price}
		               	]); */
		               	
		               	
	w2ui['grid_list2'].set('g1',{ tot_unit : tot_unit, tot_menge : tot_menge , tot_price : tot_price});
	
}


//모달조회
function loadList_modal() {
	console.log("loadList_modal()");
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);

	var customer_nm = data.customer_nm;
	var order_num = data.order_num;

	
	var page_url = "/frontend/consumable/selectOrder";
	
	var postData = "order_num=" + encodeURIComponent(order_num)
	 +"&customer_nm=" + encodeURIComponent(customer_nm);

	w2ui['modalGrid'].lock('loading...', true);
	

	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				var menge = 0;	
				var unit_price = 0;
				var total_price = 0;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					menge = menge + parseInt(row.menge);
					unit_price = unit_price + parseInt(row.unit_price);

					total_price = total_price + parseInt(row.total_price);
				
					
				});



				w2ui['modalGrid'].records = rowArr;
			
				unit_price = w2utils.formatters['number'](unit_price);
				total_price = w2utils.formatters['number'](total_price);
				
				console.log('menge :  ' + menge);
				console.log('unit_price :  ' + unit_price);
				console.log('total_price :  ' + total_price);
				
			//	w2ui['modalGrid'].set('s_1',{ menge : menge, unit_price : '' , total_price : total_price});
				          		
			} else
			{
				w2ui['modalGrid'].clear();
			}
			w2ui['modalGrid'].refresh();
			w2ui['modalGrid'].unlock();
		},complete: function () {
			modal_list_tot();
		}
	});
	
}


function modal_list_tot()
{
	
	setTimeout(function(){
	      w2ui['tot_modalGrid'].resize();
	      w2ui['tot_modalGrid'].refresh();

	   }, 200);
	
	var rowArr4 = w2ui['modalGrid'].records; 
	
	var tot_unit = 0;	
	var tot_menge = 0;
	var tot_price = 0;
	
	currentRecid = Number(i) + 1;
	
	console.log("lenght?????" + rowArr4.length);

	for(var i = 0; i < rowArr4.length; i ++)
	{
		var data = rowArr4[i];
		
		console.log("00000000000000000000");
 		
		tot_unit = tot_unit + parseInt(data.unit_price);
		tot_menge = tot_menge + parseInt(data.menge);
		tot_price = tot_price + parseInt(data.total_price); 
		

	}
	
	console.log('tot_unit :  ' + tot_unit);
	console.log('tot_menge :  ' + tot_menge);
	console.log('tot_price :  ' + tot_price);
	
	tot_unit = w2utils.formatters['number'](tot_unit);
	tot_price = w2utils.formatters['number'](tot_price); 

	/* w2ui['grid_list2'].add([
		               		{ recid:  currentRecid, tot_unit: tot_unit , tot_menge: tot_menge, tot_price: tot_price}
		               	]); */
		               	
		               	
	w2ui['tot_modalGrid'].set('g2',{ tot_unit : tot_unit, tot_menge : tot_menge , tot_price : tot_price});
	
}

//주문번호 가져오기
function requestOrderNum() {
	console.log("requestOrderNum()");

	
	var page_url = "/frontend/consumable/selectOrderNum";
	
	var order_num = "";
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
	    async : false, 
		success : function( data ) {
			if(data.status == 200 && data.order_num != null ) {
				order_num = data.order_num;
		
			
			} else
			{
			
			}
		
		},complete: function () {
			
		}
	});
	
	return order_num;

	
}


//-------------------------------------------------------------------------------------------------------------------


//엑셀 다운로드
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '주문 등록 취소.xlsx';
	var sheetTitle = '주문 등록 취소';
	var sheetName = '주문 등록 취소';
	
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

//-------------------------------------------------------------------------------------------------------------------

var prev_order_num = '';
var savePoint = 0;
var start_idx= 0;


function changeGridUI(rowArr)
{
	
	if(rowArr.length == 0){
		return;
	}
	 prev_order_num = '';
	 presavePoint = 0;
	 start_idx= 0;

	 //console.log('changeGridUI() : '+ rowArr.length);
	 for(var i=rowArr.length - 1 ; i>=0; i--)
	 {
			var row = rowArr[i];
			if(prev_order_num == '')
			{
				savePoint = rowArr.length - 1 ; 
				prev_order_num = row.order_num;
			}
			//console.log('savePoint : ' + savePoint);
			//console.log('prev_order_num : ' + prev_order_num);
			if(prev_order_num != row.order_num)
			{
				start_idx = i + 1;	
				
				savePoint = savePoint - i; 
				//console.log('- - - - 변경  ');
				//console.log('start_idx : ' + start_idx);
				//console.log('savePoint : ' + savePoint);
				rowMerge('grid_list',start_idx,0,savePoint);
				
				rowMerge('grid_list',start_idx,1,savePoint);
				
				rowMerge('grid_list',start_idx,2,savePoint);
			

				prev_order_num = row.order_num;
				savePoint = i;
	
			}else {
				if(i == 0 ){
					start_idx = i;	
					
					savePoint = savePoint - i + 1; 
					//console.log('- - - - 변경  ');
					//console.log('start_idx : ' + start_idx);
					//console.log('savePoint : ' + savePoint);
					rowMerge('grid_list',start_idx,0,savePoint);
					
					rowMerge('grid_list',start_idx,1,savePoint);	
					
					rowMerge('grid_list',start_idx,2,savePoint);
				}
				
			}
	
	  }

	// 초기 셋팅 
	$('#grid_grid_list_records .w2ui-grid-data').css("border","solid");
	$('#grid_grid_list_records .w2ui-grid-data').css("border-width","1px");
	
	$("[id*=grid_grid_list_data_0_]").css("border-top","none");
	
	$("[id*=grid_grid_list_data_][id*=_0]").css("border-left","none");
	
	
	$("[id*=grid_grid_list_data_][col=0]").css("background-color","rgb(255, 232, 232)");
	$("[id*=grid_grid_list_data_][col=1]").css("background-color","rgb(234, 255, 240)");
	$("[id*=grid_grid_list_data_][col=2]").css("background-color","rgb(234, 255, 240)");
	
	
}

function gridReDrw()
{	
	var rowArr = w2ui['grid_list'].records;
	
	var prevVal = '';
	var mergeCnt = 0;
	
	$.each(rowArr, function(idx, row){
		if(idx == 0){
			prevVal = row['order_num'];
		}
		
		var val = row['order_num'];
		if(prevVal != val)
		{
			selcBoxMerge('grid_list',(idx-mergeCnt),mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt),0,mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt),1,mergeCnt);
			mergeCnt = 0;
		}
		mergeCnt++;
		prevVal = row['order_num'];
		
		if(idx+1 == rowArr.length)
		{
			selcBoxMerge('grid_list',(idx-mergeCnt+1),mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt+1),0,mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt+1),1,mergeCnt);
		}
	});		

	
	$('#grid_grid_list_frecords').css("padding-top","1px");
	
	$('#grid_grid_list_records .w2ui-grid-data').css("border","solid");
	$('#grid_grid_list_records .w2ui-grid-data').css("border-width","1px");
	
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-top","solid");
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-left","solid");
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-bottom","solid");
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-width","1px");
	
	/*
		$('.w2ui-grid-data.w2ui-col-select').css("border-top","solid");
		$('.w2ui-grid-data.w2ui-col-select').css("border-left","solid");
		$('.w2ui-grid-data.w2ui-col-select').css("border-bottom","solid");
		$('.w2ui-grid-data.w2ui-col-select').css("border-width","1px");
	*/
	
	$("[id*=grid_grid_list_data_][col=0]").css("background-color","rgb(255, 232, 232)");
	$("[id*=grid_grid_list_data_][col=1]").css("background-color","rgb(234, 255, 240)");
	//$("[id*=grid_grid_list_data_][col=2]").css("background-color","rgb(255, 255, 234)");
}



/*
* grid : 그리드 ID
* start_row : span을 시작할 row(0부터 시작)
* start_col : span을 시작할 start_col(0부터 시작)
* merge_cnt : span 할 셀 개수
*/
function rowMerge(grid, start_row, start_col, merge_cnt)
{
   $("#grid_"+grid+"_data_"+start_row+"_"+start_col).attr("rowspan", merge_cnt);
   for(var i=start_row+1 ; i<merge_cnt+start_row; i++)
   {
      $("#grid_"+grid+"_data_"+i+"_"+start_col).addClass('hide');
   }
}




function plusItem() {
	console.log('plusItem()');

	$("#m_item_code").val('');
	$("#m_item_nm").val('');
	
	$("#modal_item_title").text('품목등록');
	$("#ct_codeView").css('display', 'none');
	
	w2ui['modalGrid2'].clear();
	w2ui['modalGrid2'].refresh();
	
	w2ui['modalGrid3'].clear();
	w2ui['modalGrid3'].refresh();
	
	requestMaterial();

	setTimeout(function(){
	      w2ui['modalGrid2'].resize();
	      w2ui['modalGrid2'].refresh();
	      
	      w2ui['modalGrid3'].resize();
	      w2ui['modalGrid3'].refresh();
	   }, 200);
	
	$("#modal_item").modal('show');

}

var deleteItems = new Array;
// 첫번째 모달에서 삭제 시 
function minusItem() {
	var selIdxArr = w2ui.modalGrid.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
	}  else {
		for(var i=0; i<chkLen; i++){
		 	var row = w2ui.modalGrid.get(selIdxArr[i]);
		 	
		 	// 삭제 어레이에 추가 한다.
		 	objt = new Object();
		 	objt.purchase_order_num = row.purchase_order_num;
		 	objt.purchase_num = row.purchase_num;
		 	objt.item_code = row.item_code;
		 	objt.order_num = row.order_num;
	
		 	if(objt.purchase_order_num != '')
			{
				console.log('deleteItems에 추가');
		 		deleteItems.push(objt);
			}
		 	w2ui['modalGrid'].remove(row.recid);
		
		}
	 } 
	w2ui.modalGrid.selectNone();	
	w2ui['modalGrid'].refresh();
	
	changeSummary();
	changeSummary2();
	
}

//제품 조회 
function requestMaterial()
{
	console.log("requestMaterial()");
	   
	
	var item_code = $("#m_item_code").val();
	var item_nm = $("#m_item_nm").val();
	
	var page_url = "/info/material/selectMaterial3";
	var postData = "item_code=" + encodeURIComponent(item_code)
	+"&item_nm=" + encodeURIComponent(item_nm);
	
	w2ui['modalGrid2'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data : postData, 
		async : true,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					if(row.item_code)comboValue_nm1.push(row.item_code);
					if(row.item_nm)comboValue_nm2.push(row.item_nm);
	
				});
				
				w2ui['modalGrid2'].records = rowArr;
			
			
			}else
			{
				w2ui['modalGrid2'].clear();
				
			}
			w2ui['modalGrid2'].refresh();
			w2ui['modalGrid2'].unlock();
			
			$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			
			try{
				//w2ui['grid_list2'].clear();
			}catch(e)
			{
				
			}
			
		},complete: function () {
			document.getElementById("m_item_code").style.removeProperty("height");
			document.getElementById("m_item_nm").style.removeProperty("height");
			
		}
	});
}


function add_buyList()
{
	console.log('add_buyList');	
	

	 
	var key = w2ui.modalGrid2.getSelection();
	
	if( key.length > 0  ) {	
	
		var rowArr = w2ui['modalGrid3'].records; 
	
		var lastRecid = 0;
		if(rowArr.length > 0)
		{
			lastRecid = rowArr[rowArr.length-1].recid;
		}

		for(var i = 0; i < key.length; i ++)
		{
			var data = w2ui.modalGrid2.get(key[i]);
			
			
			if(!checkSameItem(data.item_code))
			{
				continue;
			}
			if(!checkSameItem2(data.item_code))
			{
				continue;
			}
			var currentRecid =   Number(rowArr.length) + Number(lastRecid) + 1;
			
			
			w2ui['modalGrid3'].add([
		                		{ recid:  currentRecid , 
		                			item_type_code : data.item_type_code, item_type_nm : data.item_type_nm,
		                			warehousing_price : data.warehousing_price, release_price : data.release_price,
		                			warehousing_qty : data.warehousing_qty,
		                			safety_menge : data.safety_menge,
		                			
		                			item_nm : data.item_nm, item_code : data.item_code}
		                	]);
		                	
		    w2ui.modalGrid3.save();
		}
		
	
	}else
	{
		fnMessageModalAlert("알림", "품목을 선택해주세요."); // Notification
		
	}
	 w2ui.modalGrid2.selectNone();

}


function modalGrid2() {
	console.log("modalGrid2()");
	
	var rowArr = [];
	
	$('#modalGrid2').w2grid({ 
        name: 'modalGrid2',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: true
           
        },
        multiSelect: true,
        summary: true,
        columns: [     
                {field: 'item_type_code', caption: '자재유형코드', size:'30%', style:'text-align:center', hidden: true },
				{field: 'item_type_nm', caption: '자재유형명', size:'30%', style:'text-align:center', hidden: true },
				{field: 'warehousing_price', caption: '입고단가', size:'30%', style:'text-align:center', hidden: true },
				{field: 'release_price', caption: '출고단가', size:'30%', style:'text-align:center', hidden: true },
				{field: 'safety_menge', caption: '안전재고수량', size:'30%', style:'text-align:center', hidden: true },

				{field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'},
				{field: 'item_nm', caption: '품명', size:'30%', style:'text-align:center'  },
				{field: 'warehousing_qty', caption: '재고수량', size:'20%', style:'text-align:center'}

			], 

		records: [
		          
			],
		
		onSelect: function (event) {
// 			event.onComplete = function () {
// 				console.log("onSelect");
				
// 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
			}
		},
		onClick: function (event) {
// 			event.onComplete = function () {
// 				console.log("onClick");
// 			}
		}, onChange: function(event) {
			
			event.onComplete = function () {
				
				/* var eventColumn = event.column;
				console.log(event);
				w2ui.modalGrid2.save(); */
				
			}
		}	
	});
}

function modalGrid3() {
	console.log("modalGrid3()");
	
	var rowArr = [];
	
	$('#modalGrid3').w2grid({ 
        name: 'modalGrid3',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: true
           
        },
        multiSelect: true,
        summary: true,
       // recid   : 'recid',
        columns: [    
               // {field: 'recid', caption: 'ID', size: '50px', hidden: true },
              	{field: 'item_type_code', caption: '자재유형코드', size:'30%', style:'text-align:center', hidden: true },
				{field: 'item_type_nm', caption: '자재유형명', size:'30%', style:'text-align:center', hidden: true },
				{field: 'warehousing_price', caption: '입고단가', size:'30%', style:'text-align:center', hidden: true },
				{field: 'release_price', caption: '출고단가', size:'30%', style:'text-align:center', hidden: true },
				{field: 'safety_menge', caption: '안전재고수량', size:'30%', style:'text-align:center', hidden: true },
			
				{field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'},
				{field: 'item_nm', caption: '품명', size:'30%', style:'text-align:center'  }
			], 

		records: [
		          
			],
		
		onSelect: function (event) {
// 			event.onComplete = function () {
// 				console.log("onSelect");
				
// 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
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


function saveModal()
{
	console.log('saveModal');	
	
	 w2ui.modalGrid2.selectNone();
	 add_register();
	
}

function numberPad(n, width) {
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

function add_register()
{
	console.log('add_register');	
	
	var key = w2ui.modalGrid3.getSelection();
	var grid3Arr = w2ui['modalGrid3'].records; 
	if( grid3Arr.length > 0  ) {	
	
		var rowArr = w2ui['modalGrid'].records; 

		for(var i = 0; i < grid3Arr.length; i ++)
		{

			var data = grid3Arr[i];
			var currentRecid =  Number(rowArr.length) + 1;
			
			var menge = 1 ;
			var release_price = data.release_price
			var total_price = Number(menge) * Number(release_price);
			
			
			if(release_price == null || release_price == '')
			{
				release_price = 0;	
			}

			w2ui['modalGrid'].add([
				               		{ recid:  currentRecid, item_code: data.item_code , item_nm: data.item_nm, menge: menge, unit_price : release_price, total_price : total_price}
				               	]);


		                	
		    w2ui.modalGrid.save();
		}
		
		changeSummary();
		changeSummary2();
		
		$("#modal_item").modal('hide');
	}else
	{
		fnMessageModalAlert("알림", "품목 리스트에 추가해주세요."); // Notification
	}

}
function changeSummary()
{
	
	
	var rowArr2 = w2ui['modalGrid'].records; 
	
	var menge = 0;	
	var unit_price = 0;
	var total_price = 0;


	for(var i = 0; i < rowArr2.length; i ++)
	{
/* 		var menge2 = rowArr2[i].menge.replace(',','');
		var unit_price2 = rowArr2[i].unit_price.replace(',','');
		var total_price2 = rowArr2[i].total_price.replace(',',''); */
		menge = menge + parseInt(rowArr2[i].menge);
		unit_price = unit_price + parseInt(rowArr2[i].unit_price);
		total_price = total_price + parseInt(rowArr2[i].total_price);

	}
	
	
	console.log('menge :  ' + menge);
	console.log('unit_price :  ' + unit_price);
	console.log('total_price :  ' + total_price);
	
 	unit_price = w2utils.formatters['number'](unit_price);
	total_price = w2utils.formatters['number'](total_price); 

	//w2ui['modalGrid'].set('s_1', {menge : menge, unit_price : '' , total_price : Number(total_price)});	
	
	
}


function changeSummary2()
{
	
	
	var rowArr2 = w2ui['modalGrid'].records; 
	
	var menge = 0;	
	var unit_price = 0;
	var total_price = 0;


	for(var i = 0; i < rowArr2.length; i ++)
	{
/* 		var menge2 = rowArr2[i].menge.replace(',','');
		var unit_price2 = rowArr2[i].unit_price.replace(',','');
		var total_price2 = rowArr2[i].total_price.replace(',',''); */
		menge = menge + parseInt(rowArr2[i].menge);
		unit_price = unit_price + parseInt(rowArr2[i].unit_price);
		total_price = total_price + parseInt(rowArr2[i].total_price);

	}
	
	
	console.log('menge :  ' + menge);
	console.log('unit_price :  ' + unit_price);
	console.log('total_price :  ' + total_price);
	
 	unit_price = w2utils.formatters['number'](unit_price);
	total_price = w2utils.formatters['number'](total_price); 

	w2ui['tot_modalGrid'].set('g2', {tot_menge : menge, tot_unit : unit_price , tot_price : total_price});	
	
	
}


function checkSameItem(findString)
{
	var records = w2ui.modalGrid3.records;
	var arrString = JSON.stringify(records);	
	
	
	//if(arrString.indexOf(findString) != -1) {
	if(arrString == findString) {
		//fnMessageModalAlert('알림', '이미 구매리스트에 추가된 제품 입니다.');	
		
		return false;
	}
	return true;
	
}
function checkSameItem2(findString)
{
	var records = w2ui.modalGrid.records;
	var arrString = JSON.stringify(records);	
	
	
	//if(arrString.indexOf(findString) != -1) {
			if(arrString == findString) {

		//fnMessageModalAlert('알림', '이미 구매리스트에 추가된 제품 입니다.');	
		
		return false;
	}
	return true;
	
}

function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
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