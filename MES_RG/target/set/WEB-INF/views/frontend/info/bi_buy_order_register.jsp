<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
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
		<jsp:param name="selected_menu_p_cd" value="1041" />
		<jsp:param name="selected_menu_cd" value="1049" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      구매발주등록
        <small>구매/자재관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 구매/자재관리</a></li><li class="active">구매발주등록</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						 	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
					     	<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertItem();">등록</button>
					     	<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="updateItem();">수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteItem();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
								<label>납품요청일</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="delivery_date" placeholder="yyyymmdd~yyyymmdd" onChange="loadList();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-1">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>진행상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
									<select id="purchase_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
											<option value="">전체</option>
											<option value="R">발주요청</option>
											<option value="P">부분입고</option>
											<option value="Y">입고완료</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-1">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>자재유형</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="item_type_code" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList()">
											
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>구매문서번호</label> <input type="text" id="purchase_order_num" name="purchase_order_num" placeholder="ex) 구매문서번호"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>거래처명</label> <input type="text" id="account_nm" name="account_nm" placeholder="ex) 거래처명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<!-- <div class="col-sm-2">
								<div class="form-group">
									<label>프로젝트명</label> <input type="text" id="project_nm" name="project_nm" placeholder="ex) 프로젝트명"
									 class="form-control input-sm" maxlength="10" />
								</div>
							</div> -->
							

						</div>
						<div id="grid_list" style="width: 100%; height: 600px;"></div>
						
						
					</div>
				</div>
					
				
				
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  
  
  
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:50%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_info_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">거래처명</label>
								<div class="col-sm-8">	
									 <input type="combo" id="m_account_nm" name="m_account_nm" class="form-control input-sm" placeholder="거래처명" 
												onkeypress="if(event.keyCode==13) {requestAccount(); return false;}" >
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="col-sm-12">
								<div class="form-group">
									<label class="col-sm-4 control-label">발주일자</label>
									<div class="input-group col-sm-8">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="m_purchase_date" onchange="" placeholder="yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="box-tools pull-right">
								<button type="button" id="btn_ins_csr" onclick="plusItem();" class="btn btn-primary btn-sm">품목등록</button>
								<button type="button" id="btn_ins_csr" onclick="minusItem();" class="btn btn-primary btn-sm">삭제</button>
													
							</div>			
						</div>
					</div>
				
					<div class="row">
						<div class="col-md-12">
							<div id="modalGrid" style="width: 100%; height: 300px;" ></div>
							<div id="tot_modalGrid" style="width: 100%; height: 70px;" ></div>
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
										 class="form-control input-sm" maxlength="30" onkeypress="if(event.keyCode==13) {loadList_requestMaterial(); return false;}"/>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group" style="margin-right:0;">
										<label>품명</label> <input type="text" id="m_item_nm" name="m_item_nm" placeholder="ex) 품명"
										 class="form-control input-sm" maxlength="50" onkeypress="if(event.keyCode==13) {loadList_requestMaterial(); return false;}"/>
									</div>
								</div>
								
								<div class="col-sm-4">
									<label></label>
									<div class="box-tools">
										<button type="button" id="btn_create" 
										class="btn btn-warning btn-sm" onclick="requestMaterial();">검색</button> 
										<button type="button" id="btn_create" 
										class="btn btn-primary btn-sm" onclick="add_buyList();">구매리스트추가</button>
										
										<!-- <button type="button" id="btn_create" 
										class="btn btn-info btn-sm" onclick="saveProcess();">저장</button> -->
									</div>
								</div>
							</div>
							<div class="col-sm-5">
								<label style="margin-top:30px; font-size:17px;">구매리스트 확인</label> 
								
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
/* comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;
comboValue_nm4 = new Array; */

$(function($) {

 	fnLoadCommonOption(); 	 
 	fnLoadCommonOption2();
 	
	fnCdD('item_type_code', 'MC1014');
 	init_grid_list();
 	
 	loadList();
 	
 	modalGrid();
 	modalGrid2();
 	modalGrid3();
 	tot_modal_grid();
 	
 	requestAccount();
 	
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

// init component
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
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		    startDate: moment(minDate).add(-30, 'days'),
          	endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(30, 'days')
		}); 
 		 
}
function fnLoadCommonOption2() {
 	console.log('fnLoadCommonOption2()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
 		 $('#m_purchase_date').daterangepicker({
				opens: 'right',
				singleDatePicker: true,
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			    startDate : moment(minDate)
			    
			}); 
 		 
}

//회사명 변경시 1개 이상 조회시 select box로 1개일시 input창
$("#projectBox").change(function(){
	
	var val = $("#projectBox option:selected").val(); // text();
	
	console.log("val = " + val);
	
	if(val=="") {
		return;
	}
	
});



function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
        	selectColumn: false,
			lineNumbers : false,
            footer: true
        },
        multiSelect: false,
        columns: [      
          	{ field:'purchase_order_num', caption:'구매문서번호', size:'12%',style:'text-align:center',sortable :true},
			{ field:'account_nm', caption:'거래처명', size:'15%',style:'text-align:center',sortable :true}, 
			{ field:'purchase_num', caption:'거래처명', size:'15%',style:'text-align:center',hidden:true}, 
			{ field:'item_type_nm', caption:'자재유형', size:'8%', style:'text-align:center',sortable :true}, 
			{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center',sortable :true}, 
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center',sortable :true},
			{ field:'purchase_status_main', caption:'진행상태_메인', size:'15%',style:'text-align:center',hidden:true}, 
			{ field:'purchase_status', caption:'진행상태', size:'10%', style:'text-align:center',sortable :true
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'R')
	            	{
	            	   return '발주요청';
	            	}else if(html == 'S')
	            	{
	            		 return '수입검사완료';
	            	}
	                else if(html == 'P')
	            	{
	            		 return '부분입고';
	            	}else if(html == 'Y')
	            	{
	            		 return '입고완료';
	            	}
	               return html;
	           } 	
			},
			{ field:'menge', caption:'요청수량', size:'8%', style:'text-align:center',sortable :true}, 
			{ field:'in_menge', caption:'입하/입고 잔량', size:'12%', style:'text-align:center',sortable :true},
			{ field:'jan_menge', caption:'잔량', size:'8%', style:'text-align:center',sortable :true,

				render: function (record, index, col_index) {
				var html = this.getCellValue(index, col_index);
	               try{
	            	   var menge = w2ui.grid_list.records[index].menge; 
	            	   var in_menge = w2ui.grid_list.records[index].in_menge; 
	            	   
	            	   console.log('in_menge :' + in_menge);
	            	   console.log('menge :' + menge);
	            	   
	             	  html = Number(menge) - Number(in_menge);
	               }catch(e)
	               {
	            	   
	               }
	               return html;
	           } 			
			},
			{ field:'unit_price', caption:'단가', size:'12%', style:'text-align:center',sortable :true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }	
			},
			{ field:'purchase_end_date', caption:'납품일자', size:'10%', style:'text-align:center',sortable :true}, 
			{ field:'purchase_req_date', caption:'납품요청일자', size:'10%', style:'text-align:center',sortable :true},
			{ field:'item_type_code', caption:'자재유형코드', size:'10%', style:'text-align:center', hidden : true} 
			], 
		records: [

		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		
		onClick: function (event) {}
	});

}

//-------------------------------------------------------------------------------------------------------------------


//등록/수정 모달 생성
function requestIU_modal()
{
	deleteItems = new Array;
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		insertItem();
	}else  if( key.length==1 ) {	
		updateItem();	
	}

}

// 등록
function insertItem() {
	console.log('insertItem()');

	w2ui.grid_list.selectNone();
	$("#m_account_nm").attr('disabled',false);
	$("#modal_info_title").text('등록');
	$("#ct_codeView").css('display', 'none');
	$("#m_account_nm").val('');
	
	try{
		console.log("그리드클린");
		
		w2ui['modalGrid'].clear();
		w2ui['modalGrid'].refresh();
		
		w2ui['tot_modalGrid'].clear();
		w2ui['tot_modalGrid'].add([
				          			 { recid:'g2', tot_price : '' }
				          	     ]);
		
		setTimeout(function(){
		      w2ui['modalGrid'].resize();
		      w2ui['modalGrid'].refresh();
		   }, 200);
		
		setTimeout(function(){
	 	      w2ui['tot_modalGrid'].resize();
	 	      w2ui['tot_modalGrid'].refresh();

	 	   }, 200);
		
		
	}catch(e){
		
	}
	
	
	
	w2ui.modalGrid.clear();
	w2ui.modalGrid2.clear();
	w2ui.modalGrid3.clear();
	$("#modal_info").modal('show');

}
// 수정
function updateItem() {
	console.log('updateItem()');
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var status = data.purchase_status;
	
	 if( key.length==1 ) {
		 if(status == 'R'){
			// update
			$("#modal_info_title").text('수정');
			var data = w2ui.grid_list.get(key[0]);
			$("#m_account_nm").attr('disabled',true);
			$("#ct_codeView").css('display', '');
			$("#m_account_nm").val(data.account_nm);
			
		
			setTimeout(function(){
			      w2ui['modalGrid'].resize();
			      w2ui['modalGrid'].refresh();
			   }, 200);
			
			w2ui.modalGrid.clear();
			w2ui.modalGrid2.clear();
			w2ui.modalGrid3.clear();
			loadList_modal();
			
			$("#modal_info").modal('show');
		 }else{
			 fnMessageModalAlert("알림", "발주요청인 리스트만 수정 가능합니다."); // Notification
		 }
	} else {
		fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
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
		fnMessageModalAlert('알림', '삭제할 항목을 선택해야 합니다.');		
	}  else {
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				for(var i=0; i<chkLen; i++){
				 	var row = w2ui.modalGrid.get(selIdxArr[i]);
				 	
				 	// 삭제 어레이에 추가 한다.
				 	objt = new Object();
				 	objt.purchase_order_num = row.purchase_order_num;
				 	objt.purchase_num = row.purchase_num;
				 	objt.item_code = row.item_code;
			
				 	if(objt.purchase_order_num != '')
					{
						console.log('deleteItems에 추가');
				 		deleteItems.push(objt);
					}
				 	w2ui['modalGrid'].remove(row.recid);
				
				}
			}
		});
	 } 
	w2ui.modalGrid.selectNone();	
	w2ui['modalGrid'].refresh();

	
}
// E17381400 E17381390
function saveProcess()
{
	console.log('saveProcess()');
	
	if(!chkSubmit($("#m_account_nm"), "거래처명을")) return;
	
	
	var account_nm = $("#m_account_nm").val();
	var purchase_date = $("#m_purchase_date").val();
	purchase_date = purchase_date.replace(/-/gi, "");
	
	var purchase_order_num = "";
	var purchase_status_main  = 'R';
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		purchase_order_num = requestPurchaseOrderNum();
	}else  if( key.length==1 ) {	
		purchase_order_num = getPurchaseOrderNum();
		var main_row = w2ui.grid_list.get(key[0]);
	    purchase_status_main = main_row.purchase_status_main;
	}
	
	console.log('account_nm : ' + account_nm);
	console.log('purchase_date : ' + purchase_date);


 	
 
	var records = w2ui.modalGrid.records;
	
	if(records.length == 0 )
	{
		return;
	}
	
	var flag = false;
	var flag2 = false;
	$.each(records, function(idx, row){
		
		console.log('row.menge : ' + row.menge);
		if(row.menge == '' || row.menge == 'null' || row.menge == undefined || row.menge == 'undefined')
		{
			flag = true;
			return;
		}
		
		if(row.unit_price == '' || row.unit_price == 'null' || row.unit_price == undefined || row.unit_price == 'undefined')
		{
			flag2 = true;
			return;
		}
	
	});  
	
	if(flag)
	{
		fnMessageModalAlert("결과", "요청 수량을 입력해주세요.");
		return;
	}
	
	if(flag2)
	{
		fnMessageModalAlert("결과", "단가를 입력해주세요.");
		return;
	}
	
	$.each(deleteItems, function(idx, row){
		
		if(row.purchase_order_num != '' )
		{
			deleteItem_modal(row.purchase_order_num, row.purchase_num);
		}
	
	}); ;
	
	
	
	
	var strUrl = "/frontend/consumable/savePurchaseOrderDetail";
	var postData = "gridData=" + encodeURIComponent(JSON.stringify(records))
	+ "&purchase_order_num=" +  encodeURIComponent(purchase_order_num)
	+ "&purchase_date=" +  encodeURIComponent(purchase_date)
	+ "&purchase_status=" +  encodeURIComponent('R')
	+ "&purchase_status_main=" +  encodeURIComponent(purchase_status_main)
	+ "&account_nm=" +  encodeURIComponent(account_nm);
	
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
function getPurchaseOrderNum()
{
	var key = w2ui.grid_list.getSelection();

	var purchase_order_num = "";
	if( key.length==1 ) {	
		var data = w2ui.grid_list.get(key[0]);
		purchase_order_num = data.purchase_order_num;
	}
	
	return purchase_order_num;
}


//모달에서 저장시 삭제
function deleteItem_modal(purchase_order_num, purchase_num) {
	console.log('deleteItem_modal()');
		
	var strUrl = "/frontend/consumable/deletePurchaseOrderDetail";

	var postData = "purchase_order_num=" + encodeURIComponent(purchase_order_num);
	+ "&purchase_num=" +  encodeURIComponent(purchase_num)
	$.ajax({
		 url: strUrl,
		 type: "POST",
		 dataType : 'json', 
		 data : postData, 
		 async : false,
		 success:function(data, textStatus, jqXHR){
		 	if(data.status == "200") {
		 		console.log(data);
		 		//loadList();
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

// ----------------------------------------------------------------------------------------------


//주문번호 가져오기
function requestPurchaseOrderNum() {
	console.log("requestPurchaseOrderNum()");

	
	var page_url = "/frontend/consumable/selectPurchaseOrderNum";
	
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



// 저장
function saveItem() {
	console.log('saveItem()');
	
	var customer_code = $("#m_customer_code").val();

	var key = w2ui.grid_list.getSelection();
	
	if( key.length==0 ) {
		flag = "I";	
	} else if (key.length == 1){
		flag = "U";
	}
	
	if(flag=="I" && !chkSubmit($("#m_customer_code"), "고객사명을")) return;

	
	console.log("flag = " + flag);
	
	$("#modal_info").modal('hide');
	
	var strUrl = "/frontend/info/save";
	var postData = "flag=" + flag
			if(flag=="U") {
				postData += "&customer_code=" + encodeURIComponent(customer_code);
			}
		postData += "&customer_nm=" + encodeURIComponent(customer_nm)
			+ "&business=" + encodeURIComponent(business)
			+ "&business_address=" + encodeURIComponent(business_address)
			+ "&address=" + encodeURIComponent(address)
			+ "&telf1=" + encodeURIComponent(telf1)
			+ "&telfx=" + encodeURIComponent(telfx)
			+ "&email_address=" + encodeURIComponent(email_address)
			+ "&business_reg_num=" + encodeURIComponent(business_reg_num);
			 
	// escape(
	
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
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
	    }
	});
}

// 삭제
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
		var purchase_order_num = data.purchase_order_num;
		var purchase_num = data.purchase_num;
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				w2ui.grid_list.selectNone();
				
				var strUrl = "/frontend/consumable/deletePurchaseOrderDetail";
				var postData = "purchase_order_num=" + encodeURIComponent(purchase_order_num)
				+ "&purchase_num=" +  encodeURIComponent(purchase_num);
				
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
	
	
	
// 	function getItemInfo(type, value)
// 	{
		
// 		console.log('getItemInfo() : ' + value);
// 		var result = "";
// 		if(type == 'cd')
// 		{
// 			$.each(gridDataArr, function(idx, row){
				
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
			
// 			$.each(gridDataArr, function(idx, row){
				
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


// 	function loadList_All(){
// 		var page_url = "/frontend/consumable/selectPurchaseOrderMain";
		
// 	/* 	var postData = "item_code=" + encodeURIComponent(item_code)
// 			+ "&item_nm=" + encodeURIComponent(item_nm); */

// 		$.ajax({
// 			url : page_url,
// 			type : 'POST',
// 			//data : postData,
// 			data_type : 'json',
// 			success : function(data){
// 				if(data.status == 200 && (data.rows).length > 0){
// 					rowArr = data.rows;
// 					materialArr = rowArr;
// 					$.each(rowArr, function(idx, row){
// 						row.recid = idx + 1;
						
// 						if (startValue_combo == "") {
// 							comboValue_nm1.push(row.item_code);
// 							comboValue_nm2.push(row.item_nm);
// 							comboValue_nm3.push(row.account_nm);
// 							comboValue_nm4.push(row.purchase_order_num);
// 						}
// 					});
				
					
// 					if (startValue_combo == "") {
						
						
// 						$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
// 						$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
// 						$('#account_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
// 						$('#purchase_order_num').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
// 					}
// 				} else {
					
// 				}

// 			}, complete : function() {
// 				startValue_combo = ":)";
// 			}
// 		});
// 	}	
	
	
var gridDataArr;
var materialArr = new Array;
// 조회
function loadList()
{
	console.log("loadList()");
	
	var startValue_combo = "";
	
	comboValue_nm1 = new Array;
	comboValue_nm2 = new Array;
	comboValue_nm3 = new Array;
	comboValue_nm4 = new Array;
   
	var purchase_req_date = $("#delivery_date").val();
		purchase_req_date = purchase_req_date.replace(/-/gi, "");
		
	var purchase_order_num = $("#purchase_order_num").val();
	var account_nm = $("#account_nm").val();
	var item_type_code =  $("#item_type_code").val();
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	var purchase_status =   $("#purchase_status").val();
	
	var page_url = "/frontend/consumable/selectPurchaseOrderMain";

	//w2ui['grid_list'].lock('loading...', true);
	var postData = "purchase_req_date=" + encodeURIComponent(purchase_req_date)
		+"&account_nm=" + encodeURIComponent(account_nm)
	 	+ "&item_type_code=" + encodeURIComponent(item_type_code)
		+ "&item_nm=" + encodeURIComponent(item_nm)
		+ "&item_code=" + encodeURIComponent(item_code)
	 	+ "&purchase_status=" + encodeURIComponent(purchase_status);
	
	

	try{
		
		w2ui.grid_list.selectNone();
		w2ui['grid_list'].lock('loading...', true);
	}catch(e)
	{
		
	}
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		async : false,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;

				
				
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
					if (startValue_combo == "") {						
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.account_nm);
						comboValue_nm4.push(row.purchase_order_num);
					}
					
					row.menge = Number(row.menge);
					row.in_menge = Number(row.in_menge);
					row.jan_menge = Number(row.jan_menge);
					row.unit_price = Number(row.unit_price);
					
				});				
				
				w2ui['grid_list'].records = rowArr;
			
			
			}else
			{
  				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#account_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#purchase_order_num').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			
// 			try{
// 				changeGridUI(gridDataArr);
// 			}catch(e)
// 			{
				
// 			}
			
			
		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("account_nm").style.removeProperty("height");
			document.getElementById("purchase_order_num").style.removeProperty("height");
		}
	});
}


//-------------------------------------------------------------------------------------------------------------------


//엑셀 다운로드
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '구매발주등록.xlsx';
	var sheetTitle = '구매발주등록';
	var sheetName = '구매발주등록';
	
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


function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}	

function modalGrid() {
	console.log("modalGrid()");
	
	var rowArr = [];
	
	$('#modalGrid').w2grid({ 
        name: 'modalGrid',
        show: {
        	lineNumbers : false,
            footer: true, 
            selectColumn: true
        },
        multiSelect: true,
        summary: false,
        columns: [      
            { field: 'item_type_code', caption: '자재유형코드', size:'30%', style:'text-align:center' , hidden : true},
            { field: 'purchase_status', caption: '상태', size:'30%', style:'text-align:center' , hidden : true},
			{ field: 'purchase_num', caption: '구매문서 품목 번호', size:'30%', style:'text-align:center' , hidden : true},
			{ field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'},
			{ field: 'item_nm', caption: '품명', size:'30%', style:'text-align:center'},
			{ field:'item_type_nm', caption:'유형', size:'25%', style:'text-align:center'},
			{ field:'menge', caption:'요청수량', size:'30%',  style:'text-align:center' , editable: { type: 'int' }},
			{ field:'unit_price', caption:'단가', size:'30%',  style:'text-align:center', editable: { type: 'int' }
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);
	
	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }	
			},
			{ field:'total_price', caption:'총금액', size:'30%',  style:'text-align:center'
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);
	
	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }		
			},
			{ field:'purchase_req_date', caption:'납품요청일', size:'30%',  style:'text-align:center', 
				editable: { type: 'date', format: 'yyyy-mm-dd'} 
			},
			{ field:'warehousing_qty', caption:'창고재고', size:'30%',  style:'text-align:center'},
			{ field:'safety_menge', caption:'적정재고', size:'30%',  style:'text-align:center'},
			{ field:'minus_menge', caption:'부족수량', size:'30%',  style:'text-align:center'
				,render: function (record, index, col_index) {
		               var html = this.getCellValue(index, col_index);

		               var warehousing_qty = w2ui.modalGrid.records[index].warehousing_qty; 
		               var safety_menge = w2ui.modalGrid.records[index].safety_menge; 
		               
		               var result = Number(safety_menge) - Number(warehousing_qty);
		               
		               return result;
		           } 	 	
	
			}
			
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
				console.log("onChange");
				
				
				var eventColumn = event.column;
				console.log(event);
				w2ui.modalGrid.save();
				if(eventColumn == 6) {
					
					w2ui.modalGrid.save();
		 
					 var key = event.recid; 
					console.log('key : ' + key);
					var get = w2ui['modalGrid'].get(key);
					var caption = w2ui.modalGrid.columns[event.column].caption; // 컬럼명 나오게 하기
					
					var menge = "";
					var release_price = "";
					var unit_price = "";
					var rdss  = w2ui.modalGrid.records;
					
					$.each(rdss, function(idx, row){
			 			
						if(key == row.recid) {
							console.log('key : ' + key);
							console.log(' row.recid : ' +  row.recid);
							menge =  w2ui.modalGrid.records[idx].menge; 
							release_price = w2ui.modalGrid.records[idx].item_nm; //w2ui['modalGrid'].get(key).routing_gubun;
							unit_price = w2ui.modalGrid.records[idx].unit_price; 
						}
					}); 
					
					/*  $.each(itemArr, function(idx, row){
 					
						if(release_price == row.text) {
							release_price = row.release_price; 
				
							console.log('release_price : ' + release_price);
						}
					}); 
					 */
					
					var total_price = Number(menge) * Number(unit_price);
					
					w2ui['modalGrid'].set( key , {unit_price : unit_price }); 
					w2ui['modalGrid'].set( key , {total_price : total_price }); 
					
				}else if(eventColumn == 7) {
					w2ui.modalGrid.save();
					var key = event.recid; 
					var menge = "";
					var release_price = "";
					var rdss  = w2ui.modalGrid.records;
					$.each(rdss, function(idx, row){
			 			
						if(key == row.recid) {
				
							menge = w2ui.modalGrid.records[idx].menge;
							release_price = w2ui.modalGrid.records[idx].unit_price; //w2ui['modalGrid'].get(key).routing_gubun;
	
							console.log('menge : ' + menge);
							console.log('release_price : ' + release_price);
						}
					});
					var total_price = Number(menge) * Number(release_price);
					w2ui['modalGrid'].set( key , {total_price : total_price }); 
				}
				modal_list_tot();
				
			}
		}	
	});
	
	
	w2ui['modalGrid'].records = gridDataArr;
	
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
				{field: 'warehousing_qty', caption: '창고재고수량', size:'30%', style:'text-align:center', hidden: true },
				{field: 'safety_menge', caption: '안전재고수량', size:'30%', style:'text-align:center', hidden: true },

				{field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'},
				{field: 'item_nm', caption: '품명', size:'30%', style:'text-align:center'  },

				{field: 'machine_standard', caption: '규격', size:'30%', style:'text-align:center'}
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
				{field: 'warehousing_qty', caption: '창고재고수량', size:'30%', style:'text-align:center', hidden: true },
				{field: 'safety_menge', caption: '안전재고수량', size:'30%', style:'text-align:center', hidden: true },
			
				{field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'},
				{field: 'item_nm', caption: '품명', size:'30%', style:'text-align:center'  },

				{field: 'machine_standard', caption: '규격', size:'30%', style:'text-align:center'}
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
				w2ui.modalGrid3.save(); */
				
			}
		}	
	});
	
	
	//w2ui['modalGrid'].records = gridDataArr;
}

//모달조회
function loadList_modal() {
	console.log("loadList_modal()");
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);

	var purchase_order_num = "";
	var purchase_num = data.purchase_num;
	
	if( key.length==0 ) {
		purchase_order_num = requestPurchaseOrderNum();
	}else  if( key.length==1 ) {	
		purchase_order_num = getPurchaseOrderNum();
	}
	
	var purchase_date = $("#m_purchase_date").val();
	purchase_date = purchase_date.replace(/-/gi, "");
	
	var account_nm = $("#m_account_nm").val();
	
	console.log('account_nm : ' + account_nm);
	console.log('purchase_date : ' + purchase_date);
	var page_url = "/frontend/consumable/selectPurchaseOrderDetail";
	
	var postData = "purchase_order_num=" + encodeURIComponent(purchase_order_num)
	 +"&purchase_date=" + encodeURIComponent(purchase_date)
	 +"&purchase_num=" + encodeURIComponent(purchase_num)
	 +"&account_nm=" + encodeURIComponent(account_nm);


	w2ui['modalGrid'].lock('loading...', true);
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
				

				w2ui['modalGrid'].records = rowArr;
			
			
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


function loadList_modal2()
{
	console.log('loadList_modal2()');	
	
}

//두번째 모달에서 삭제시
function minus() {
	var selIdxArr = w2ui.modalGrid3.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
	}  else {
		for(var i=0; i<chkLen; i++){
		 	var row = w2ui.modalGrid3.get(selIdxArr[i]);
	
		 	w2ui['modalGrid3'].remove(row.recid);
		
		}
	 } 
	w2ui.modalGrid3.selectNone();	
	w2ui['modalGrid3'].refresh();

	
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
		
		
		
		var current_purchase_num = 10;
		var purchase_num = numberPad(current_purchase_num,3);
		if(rowArr.length > 0)
		{
			purchase_num = rowArr[rowArr.length-1].purchase_num;
			current_purchase_num = Number(purchase_num);
		}
		//for(var i = 0; i < key.length; i ++)
		for(var i = 0; i < grid3Arr.length; i ++)
		{
			//var data = w2ui.modalGrid3.get(key[i]);
			var data = grid3Arr[i];
			var currentRecid =  Number(rowArr.length) + 1;
			
			var menge = 0;
			
			
			var unit_price = Number(data.warehousing_price) || 0;
			var total_price = Number(menge) * Number(unit_price);
	
			
			var purchase_req_date =  getFormatDate(new Date());
			
			var currentGridArr = w2ui['modalGrid'].records; 
			if(currentGridArr.length > 0 ){
				purchase_num = Number(purchase_num) + 10;
				purchase_num = numberPad(purchase_num,3);
			}
			
			
			console.log('purchase_num : ' + purchase_num);
			
			
			w2ui['modalGrid'].add([
		                		{ recid:  currentRecid , 
		                			purchase_status : 'R',
		                			purchase_num : purchase_num,
		                			item_type_code : data.item_type_code,
		                			item_type_nm : data.item_type_nm,
		                			item_code : data.item_code, item_nm : data.item_nm,
		                			item_type_nm : data.item_type_nm,
		                			menge : '' , unit_price : unit_price,
		                			total_price : total_price,
		                			purchase_req_date : purchase_req_date,
		                			warehousing_qty : data.warehousing_qty, safety_menge : data.safety_menge
		                			
		                		}
		                	]);
		                	
		    w2ui.modalGrid.save();
		}
		
		$("#modal_item").modal('hide');
	}else
	{
		fnMessageModalAlert("알림", "구매리스트에 추가해주세요."); // Notification
	}

}

function loadList_requestMaterial()
{
	
	var item_nm =   $("#m_item_nm").val();
	var item_code =   $("#m_item_code").val();
	
	console.log('item_nm : ' + item_nm);
	console.log('item_code : ' + item_code);
	
	requestMaterial();
}
//제품 조회 
function requestMaterial()
{
	console.log("requestMaterial()");
	   
	
	var item_code = $("#m_item_code").val();
	var item_nm = $("#m_item_nm").val();
	
	var page_url = "/info/material/selectMaterial_menge";
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


//--------------------------------------------------------------------------------------------------------

var startValue_combo2 = "";

var comboValue_nm = new Array;

function requestAccount() {
	console.log("requestAccount()");
	
	var page_url = "/info/account/selectAccount";
	var postData = "account_code=" + encodeURIComponent($("#account_code").val())
		 + "&account_nm=" + encodeURIComponent($("#account_nm").val());
	
	/* if( $("#business option:selected").val() != "ALL") {
		postData += "&business_code=" + encodeURIComponent($("#business option:selected").val());
		postData += "&business_codeT=" + "";
		if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
			postData +=  encodeURIComponent("MD1282");	
		} 
	} else {
		postData += "&business_code=" + encodeURIComponent("");
	} */
	
	$.ajax({
		url : page_url,
		type : 'POST',
		//data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if (startValue_combo2 == "") {
						comboValue_nm.push(row.account_nm ? row.account_nm+'' : '');
					}
				});
				if (startValue_combo2 == "") {
					
					$('#m_account_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
				
				}
			} else {
	
			}

		},complete: function () {
			startValue_combo2 = ":)";
		}
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
				{ field: '', caption: '', size:'30%', style:'text-align:center' , hidden : true},
            { field: '', caption: '', size:'30%', style:'text-align:center' , hidden : true},
			{ field: '', caption: '', size:'30%', style:'text-align:center' , hidden : true},
			{ field: '', caption: '', size:'30%', style:'text-align:center'},
			{ field: '', caption: '', size:'30%', style:'text-align:center'},
			{ field:'', caption:'', size:'25%', style:'text-align:center'},
			{ field:'', caption:'', size:'30%',  style:'text-align:center'},
			{ field:'', caption:'', size:'30%',  style:'text-align:center'},
			{ field:'tot_price', caption:'합계', size:'30%',  style:'text-align:center'},
			{ field:'', caption:'', size:'30%',  style:'text-align:center'},
			{ field:'', caption:'', size:'30%',  style:'text-align:center'},
			{ field:'', caption:'', size:'30%',  style:'text-align:center'},
			{ field:'', caption:'', size:'30%',  style:'text-align:center'}
                  
			],  
			
		records: [
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	
		w2ui['tot_modalGrid'].add([
		          			 { recid:'g2', tot_price : ''}
		          	     ]);
}

function modal_list_tot()
{
	console.log("modal_list_tot()");
	
	
	setTimeout(function(){
	      w2ui['tot_modalGrid'].resize();
	      w2ui['tot_modalGrid'].refresh();

	   }, 200);
	
	var rowArr4 = w2ui['modalGrid'].records; 
	
	var tot_price = 0;	
		
	currentRecid = Number(i) + 1;
	
	console.log("lenght?????" + rowArr4.length);

	for(var i = 0; i < rowArr4.length; i ++)
	{
		var data = rowArr4[i];
		
		console.log("00000000000000000000");
 		
		tot_price = tot_price + parseInt(data.total_price);
		

	}
	
	console.log("tot_price?????" + tot_price);
	
	tot_price = w2utils.formatters['number'](tot_price);

		               	
		               	
	w2ui['tot_modalGrid'].set('g2',{ tot_price : tot_price});
	
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
				prev_order_num = row.purchase_order_num;
			}
			//console.log('savePoint : ' + savePoint);
			//console.log('prev_order_num : ' + prev_order_num);
			if(prev_order_num != row.purchase_order_num)
			{
				start_idx = i + 1;	
				
				savePoint = savePoint - i; 
				//console.log('- - - - 변경  ');
				//console.log('start_idx : ' + start_idx);
				//console.log('savePoint : ' + savePoint);
				rowMerge('grid_list',start_idx,0,savePoint);
				
				rowMerge('grid_list',start_idx,1,savePoint);
				
				rowMerge('grid_list',start_idx,2,savePoint);
				

			

				prev_order_num = row.purchase_order_num;;
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
			prevVal = row['purchase_order_num'];
		}
		
		var val = row['purchase_order_num'];
		if(prevVal != val)
		{
			selcBoxMerge('grid_list',(idx-mergeCnt),mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt),0,mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt),1,mergeCnt);
			mergeCnt = 0;
		}
		mergeCnt++;
		prevVal = row['purchase_order_num'];
		
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

function checkSameItem(findString)
{
	var records = w2ui.modalGrid3.records;
	var arrString = JSON.stringify(records);	
	
	
	if(arrString.indexOf(findString) != -1) {

		//fnMessageModalAlert('알림', '이미 구매리스트에 추가된 제품 입니다.');	
		
		return false;
	}
	return true;
	
}

function rowMerge(grid, start_row, start_col, merge_cnt)
{
   $("#grid_"+grid+"_data_"+start_row+"_"+start_col).attr("rowspan", merge_cnt);
   for(var i=start_row+1 ; i<merge_cnt+start_row; i++)
   {
      $("#grid_"+grid+"_data_"+i+"_"+start_col).addClass('hide');
   }
}

//-------------------------------------------------------------------------------------------------------------------

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
  //	 	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		var sub = val.substr(0,2);
	    		
	    		//  if(valsub != "m_")
	    		if(sub.indexOf("m_") == -1) // val
	    			$("#"+val ).append("<option value="+''+">" + "전체" + "</option>");
	    		
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
	 			
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
	
}
//-------------------------------------------------------------------------------------------------------------------
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

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
}
</script>

</body>
</html>