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
		<jsp:param name="selected_menu_cd" value="1050" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	자재 입고
        <small>구매/자재관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 구매/자재관리</a></li><li class="active">자재 입고</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">자재 발주 List 조회</h3>
						<div class="box-tools pull-right">
					     	<!-- <button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="requestIU_modal();">등록/수정</button> -->
				     		<button type="button" id="btn_delete" class="btn btn-primary btn-sm" onclick="requestIU_modal();">입고</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
								<label>납품요청일</label>
								<button type="button" id="btn_today" onclick="todayLoadList();" 
											class="btn btn-warning btn-sm" style="margin-left:10px;">금일</button>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="order_day" placeholder="yyyymmdd~yyyymmdd" onChange="loadList();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>자재유형</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="item_type_code" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
											
										</select>
									</div>
								</div>
							</div>	
				
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>진행상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
									<select id="purchase_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
											<option value="">전체</option>
											<option value="R">발주요청</option>
											<option value="S">수입검사완료</option>
											<option value="P">부분입고</option>
											<option value="Y">입고완료</option>
										</select>
									</div>
								</div>
							</div>	
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>거래처명</label> <input type="text" id="account_nm" name="account_nm" placeholder="ex) 거래처명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<!-- <div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>자재유형</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="s_type" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
											<option value="drw">진행전</option>
											<option value="ex">진행</option>
											<option value="ord">완료</option>
										</select>
									</div>
								</div>
							</div> -->
							
							
							
							
								
						</div>
						<div id="grid_list" style="width: 100%; height: 400px;"></div>
					</div>
					
				</div>
				
						
				<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">자재 입고 처리</h3>
						<div class="box-tools pull-right">
					     	<!-- <button type="button" id="btn_create" class="btn btn-info btn-sm" onclick="insertRow();">행 추가</button> -->
				     		<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteRow();">입고취소</button>
							<!-- <button type="button" id="btn_search_csr" onclick="saveRow();" class="btn btn-success btn-sm">저장</button> --><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
						</div>
						<div id="grid_list2" style="width: 100%; height: 150px;"></div>
						</div>
				</div>
				
		
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>

<div class="modal fade" id="modal_stock" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title">원재료 입고처리</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<!-- <input type="hidden" id="upload_mode"/> -->
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">거래처명</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_account_nm">
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">P/N</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_item_code">
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">품명</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_item_nm">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-6">
							<label for="" class="col-sm-6 control-label ">발주수량</label>
							<div class="col-sm-6">
								<input class="form-control" 
								onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;"id="m_menge">
							</div>
						</div>
						<div class="col-sm-6">
							<label for="" class="col-sm-4 control-label ">잔량</label>
							<div class="col-sm-6">
								<input class="form-control" id="m_jan_menge"
								onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					<div class="form-group row h_pass_menge">
						<label for="" class="col-sm-3 control-label ">수입검사합격수량</label>
						<div class="col-sm-4">
							<input class="form-control" id="m_pass_menge" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">입고량</label>
						<div class="col-sm-5">
							<input type="int" maxlength="100"  class="form-control input-sm pull-right clear_field dp_component_d"
							 onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" id="m_in_menge"  >
						</div>
					</div>
				<!-- 	<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">Serial_NO</label>
						<div class="col-sm-5">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field dp_component_d" id="m_serial_no"  >
						</div>
					</div> -->
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">Mill Sheet No</label>
						<div class="col-sm-5">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field" id="m_mill_sheet_no"  >
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-sm-3 control-label">첨부파일</label>
						<div class="col-sm-7" style="padding-right: 0px;">
							<input type="text" id="mod_file_name" name="mod_file_name" class="form-control input-sm clear_field" readonly>
						</div>	
						<div class="col-sm-1" style="padding-left: 7px;">
							<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
								<input id="file_group" type="file" class="fileupload file_info" name="file[]">
							</span>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="saveFile" class="btn btn-success btn-sm" onclick="insFile()">입고</button>
					<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title">자재 입고처리</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<!-- <input type="hidden" id="upload_mode"/> -->
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">거래처명</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_account_nm2">
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">P/N</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_item_code2">
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">품명</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_item_nm2">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-6">
							<label for="" class="col-sm-6 control-label ">발주수량</label>
							<div class="col-sm-6">
								<input class="form-control" 
								onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;"id="m_menge2">
							</div>
						</div>
						<div class="col-sm-6">
							<label for="" class="col-sm-4 control-label ">잔량</label>
							<div class="col-sm-6">
								<input class="form-control" id="m_jan_menge2"
								onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					<div class="form-group row h_pass_menge">
						<label for="" class="col-sm-3 control-label ">수입검사합격수량</label>
						<div class="col-sm-4">
							<input class="form-control" id="m_pass_menge2"  onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">입고량</label>
						<div class="col-sm-5">
							<input type="text" id="m_in_menge2" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" maxlength="100"  class="form-control input-sm pull-right clear_field dp_component_d" >
						</div>
					</div>
					
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">창고</label>
						<div class="col-sm-5">
							<select class="form-control input-sm" id="m_in_ware_code"
											name="m_in_ware_code">
											
							</select>
						</div>
					</div>
					
					
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="saveFile" class="btn btn-success btn-sm" onclick="insFile()">입고</button>
					<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;

$(function($) {

 	fnLoadCommonOption(); 	 
 	
 	fnCdD('item_type_code', 'MC1014');
 	
 	fnCdD_wh('m_in_ware_code', 'MD1243');
 	
 	init_grid_list();

 	init_grid_list2();
 	
 	fnLoadFileHandler();
 	
 	loadList();
 	
 	setTimeout(function(){
	      w2ui['grid_list'].refresh();
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
		$('#macc_chndate, #m_date_1, #m_date_2, #m_order_day').daterangepicker({
			opens: 'right', 
			singleDatePicker: true,
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
			startDate : moment(minDate)
		});
		
		 $('#order_day, #c_prod_day').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			    startDate: moment(minDate).add(-30, 'days'),
			    endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(30, 'days')
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
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [           
            { field:'purchase_order_num', caption:'구매문서번호', size:'15%',style:'text-align:center', hidden : true},
			{ field:'account_nm', caption:'거래처명', size:'15%', style:'text-align:center', sortable: true},
			{ field:'item_type_code', caption:'자재유형', size:'8%', style:'text-align:center',hidden:true},
			{ field:'item_type_nm', caption:'자재유형', size:'8%', style:'text-align:center', sortable: true},
			{ field:'in_ware_code', caption:'입고창고코드', size:'8%', style:'text-align:center',hidden: true},
			{ field:'in_ware_nm', caption:'입고창고', size:'8%', style:'text-align:center', sortable: true, hidden:true},// 200px
			{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center', sortable: true}, // 120px
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center', sortable: true},
			{ field:'purchase_status', caption:'진행상태', size:'10%', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'R')
	            	{
	                	var receiving_inspection_yn = w2ui.grid_list.records[index].receiving_inspection_yn; 
	                	if(receiving_inspection_yn == 'Y')
	                	{
	                		return '수입검사대기';
	                	}else
	                	{
	                		return '발주요청';
	                	}
	            	  
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
			{ field:'menge', caption:'발주수량', size:'10%', style:'text-align:center', sortable: true},
			{ field:'pass_menge', caption:'수입검사합격수량', size:'10%', style:'text-align:center',sortable :true
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	            
                	var receiving_inspection_yn = w2ui.grid_list.records[index].receiving_inspection_yn; 
                	console.log('html : ' + html);
                	if(receiving_inspection_yn == 'Y')
                	{
                		return html;
                	}else
                	{
                		return '대상아님';
                	}
	            	  
	            
	           } 	
			
			},
			{ field:'in_menge', caption:'입고량', size:'10%', style:'text-align:center', sortable: true}, // right // 120px
			{ field:'jan_menge', caption:'잔량', size:'10%', style:'text-align:center', sortable: true
				,

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
			}, // 120px
			{ field:'purchase_end_date', caption:'납품일자', size:'10%', style:'text-align:center', sortable: true}, // 120px
			{ field:'purchase_req_date', caption:'납품요청일자', size:'10%', style:'text-align:center', sortable: true},
			{ field:'item_type_code', caption:'자재유형코드', size:'10%', style:'text-align:center', hidden : true} ,
			
			{ field:'receiving_inspection_yn', caption:'수입검사대상', size:'10%', style:'text-align:center',sortable :true},
			
			{ field:'receiving_inspection_routing_yn', caption:'수입검사항목구성여부', size:'10%', style:'text-align:center', hidden : true} 
			], 
		records: [
	
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onSelect: function (event) {
 			event.onComplete = function () {
 				
 		
 				
 				
 				var recids = w2ui.grid_list.getSelection();
 				var pdata = w2ui.grid_list.get(recids[0]);
 				
 				if(pdata.item_type_code == 'MD1245')
 				{
 					w2ui['grid_list2'].showColumn(recids[0], 'mill_sheet_no');
 	 				w2ui['grid_list2'].showColumn(recids[0], 'down_file');			
 				}else
 				{
 					w2ui['grid_list2'].hideColumn(recids[0], 'mill_sheet_no');
 	 				w2ui['grid_list2'].hideColumn(recids[0], 'down_file');						
 				}
 				
 				loadList2(pdata.purchase_order_num, pdata.purchase_num);
				
 			}
		},
		onClick: function (event) {}
	});

}

function init_grid_list2(){
	var rowArr = [];
	
	$('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        multiSelect: true,
        columns: [       
            { field:'in_date_doc', caption:'P/N', size:'15%', style:'text-align:center', hidden : true}, 
            { field:'item_type_code', caption:'자재유형', size:'15%', style:'text-align:center', hidden : true},
      		{ field:'purchase_order_num', caption:'P/N', size:'15%', style:'text-align:center', hidden : true}, 
    		{ field:'purchase_num', caption:'P/N', size:'15%', style:'text-align:center', hidden : true}, 
			{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center',sortable :true}, 
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center',sortable :true},
			{ field:'serial_no', caption:'Serial No', size:'10%', style:'text-align:center',sortable :true},
		
			{ field:'menge', caption:'발주수량', size:'8%', style:'text-align:center',sortable :true}, 
			{ field:'in_menge', caption:'입고량', size:'8%', style:'text-align:center',sortable :true},
			{ field:'in_date', caption:'납품일자', size:'10%', style:'text-align:center',sortable :true}, 
			{ field:'mill_sheet_no', caption:'Mill Sheet No', size:'15%', style:'text-align:center',sortable :true}, 
			{ field:'down_file', caption:'Mill Sheet 파일첨부', size:'25%', style:'text-align:left',sortable :true}
			], 
		records: [
	
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
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

var gridDataArr;
var startValue_combo = "";

//조회
function loadList()
{
	try{
		w2ui['grid_list'].clear();
		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
	}catch(e){
		
	}
	
	//w2ui['grid_list'].clear();
	
	console.log("loadList()");
	
	var purchase_req_date = $("#order_day").val();
		purchase_req_date = purchase_req_date.replace(/-/gi, "");
		
	var account_nm = $("#account_nm").val();
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	var item_type_code = $("#item_type_code").val();
	var purchase_status =   $("#purchase_status").val();
	
	var page_url = "/frontend/consumable/selectPurchaseOrderMain";

	//w2ui['grid_list'].lock('loading...', false);
	var postData = "purchase_req_date=" + encodeURIComponent(purchase_req_date)
		+"&account_nm=" + encodeURIComponent(account_nm)
		+ "&item_nm=" + encodeURIComponent(item_nm)
		+ "&item_code=" + encodeURIComponent(item_code)
		+ "&item_type_code=" + encodeURIComponent(item_type_code)
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
				console.log("startValue_combo::::"+startValue_combo);		
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.account_nm);
					}
					
					row.menge = Number(row.menge);
					row.pass_menge = Number(row.pass_menge);
					row.in_menge = Number(row.in_menge);
					row.jan_menge = Number(row.jan_menge);
		
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
			
			try{
				changeGridUI(gridDataArr);
			}catch(e)
			{
				
			}
			
			
		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("account_nm").style.removeProperty("height");
		}
	});

}
//-------------------------------------------------------------------------------------------------------------------

//저장
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
var curFile = null;

function requestIU_modal()
{
	deleteItems = new Array;
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var item_type_code = data.item_type_code;
	
	
	if( item_type_code == 'MD1245' ) {
		inStock();
	}else {	
		inStockMaterial();	
	}

}

//입고
function inStock() {
	console.log('inStock()');

	var key = w2ui.grid_list.getSelection();
	
	
	curFile = null;
	isRev = false;
	
	$('#m_account_nm').attr('disabled', true);
	$('#m_item_code').attr('disabled', true);
	$('#m_item_nm').attr('disabled', true);
	$('#m_menge').attr('disabled', true);
	$('#m_pass_menge').attr('disabled', true);
	
	$('.clear_field').val('');
	
	var recids = w2ui.grid_list.getSelection();
	
	var pdata = w2ui.grid_list.get(recids[0]);
	
	// 이미 입고 완료
	if(pdata.purchase_status == 'Y')
	{
		fnMessageModalAlert("알림", "입고완료된 항목입니다."); // Notification
		return;
	}
	// 수입검사 대상인 경우에는 품질관리 - 수입검사 쪽에서 처리 되야 지 가능하다.
	if(pdata.receiving_inspection_yn == 'Y' && pdata.purchase_status == 'R')
	{
		fnMessageModalAlert("알림", "수입검사 진행 후 입고 가능 합니다."); // Notification
		return;
	}
	
	var receiving_inspection_yn = pdata.receiving_inspection_yn;
	
	
	
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "입고하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "입고하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {
		var keys = Object.keys(pdata);
		
		
		$("#m_account_nm").val(pdata.account_nm);
		$("#m_item_code").val(pdata.item_code);
		$("#m_item_nm").val(pdata.item_nm);
		$("#m_menge").val(pdata.menge);
	
		$("#m_in_ware_code").val(pdata.in_ware_code);
		if(receiving_inspection_yn == 'Y'){
			$(".h_pass_menge").show();
		}else{
			$(".h_pass_menge").hide();
		}
		
		var jan_menge = Number(pdata.menge) - Number(pdata.in_menge);
		if(pdata.receiving_inspection_yn == 'Y')
		{
			jan_menge = Number(pdata.pass_menge) - Number(pdata.in_menge);
			
		}
		
		$("#m_jan_menge").val(jan_menge);
		$("#m_in_menge").val(0);
		
		$("#m_pass_menge").val(pdata.pass_menge);
		
		$('#file_btn').attr('disabled', false);
		
		$('#m_account_nm').attr('disabled', true);
		$('#m_item_code').attr('disabled', true);
		$('#m_item_nm').attr('disabled', true);
		
		$('#m_menge').attr('disabled', true);
		$('#m_jan_menge').attr('disabled', true);
		$('#m_pass_menge').attr('disabled', true);
	} 

	
	//w2ui.grid_list.selectNone();
	$('#modal_stock').modal('show');
	
}

//자재입고
function inStockMaterial() {
	console.log('inStockMaterial()');

	var key = w2ui.grid_list.getSelection();
	
	
	curFile = null;
	isRev = false;
	
	$('#m_account_nm2').attr('disabled', true);
	$('#m_item_code2').attr('disabled', true);
	$('#m_item_nm2').attr('disabled', true);
	$('#m_menge2').attr('disabled', true);
	$('#m_pass_menge2').attr('disabled', true);
	
	$('.clear_field').val('');
	
	var recids = w2ui.grid_list.getSelection();
	
	var pdata = w2ui.grid_list.get(recids[0]);
	
	var receiving_inspection_yn = pdata.receiving_inspection_yn;
	
	
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "입고하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "입고하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {
		var keys = Object.keys(pdata);
		
		
		$("#m_account_nm2").val(pdata.account_nm);
		$("#m_item_code2").val(pdata.item_code);
		$("#m_item_nm2").val(pdata.item_nm);
		$("#m_menge2").val(pdata.menge);
		//$("#m_in_ware_code option:eq(0)").prop("selected", true);
		$("#m_in_ware_code").val(pdata.in_ware_code);
		if(receiving_inspection_yn == 'Y'){
			$(".h_pass_menge").show();
		}else{
			$(".h_pass_menge").hide();
		}
		
		var jan_menge = Number(pdata.menge) - Number(pdata.in_menge);
		if(pdata.receiving_inspection_yn == 'Y')
		{
			jan_menge = Number(pdata.pass_menge) - Number(pdata.in_menge);
		}
		$("#m_jan_menge2").val(jan_menge);
		$("#m_in_menge2").val(0);
		$("#m_pass_menge2").val(pdata.pass_menge);
		
		$('#m_account_nm2').attr('disabled', true);
		$('#m_item_code2').attr('disabled', true);
		$('#m_item_nm2').attr('disabled', true);
		
		$('#m_menge2').attr('disabled', true);
		$('#m_jan_menge2').attr('disabled', true);
		$('#m_pass_menge2').attr('disabled', true);
	} 
	
	//w2ui.grid_list.selectNone();
	$('#modal_info').modal('show');
	
}
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
		var code = data.customer_code;
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				console.log("code = " + code);
				
				var strUrl = "/frontend/info/delete";
				var postData = "customer_code=" + code;
				
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


//ins file info
function insFile() {
	
	
	
	/**
		모달을 그대로 사용해서 '입고' 버튼을 누를경우
		여기를 타게 됨.
		
		그러면, 원재료랑 원재료랑 아닌것을 구분을 해야 '입고' 처리를 분기 할 수 있는데
	
		item_type_code 로 구분 할 수 있음. ( MD1245 = 원재료 )
		
		그리드에 선택된 항목의 item_type_code 를 가져와서 구분 하면 됨.

		
		현재 insFile() 함수 안에 있는 처리는 
		원재료 입고 처리하는 것임.
		
		원재료가 아닌 것을 입고하는 것에 대한 처리를 분기 해야함.
		
		현재 코드는 원재료를 '입고' 할 때 사용하면 되고. 
		
		원재료가 아닌 것을 '입고' 할 때에 는 아래의 API 를 호출 하면 됨.
		
		파라미터는 동일하게 던지면 됨.
		consumable/insertWarehouing <- FrontedController 에 만들어 놓았음.

		/consumable/warehousing_file_upload
	*/
	var pageUrl = "";
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]); 
	
	var item_type_code = data.item_type_code;
	
	/* if(item_type_code == 'MD1245') pageUrl = "frontend/consumable/selectWarehousing";
	else if (item_type_code != 'MD1245') pageUrl = 'frontend/consumable/insertWarehouing'; */
	
	if(item_type_code == 'MD1245')
	{
		//원재료
		var account_nm = $('#m_account_nm').val();
		var item_code = $('#m_item_code').val();
		var item_nm = $('#m_item_nm').val();
		var in_menge = $('#m_in_menge').val();
		
		var in_ware_code = $("#m_in_ware_code").val();
		
		 in_menge = in_menge.replace(/(^0+)/, "");

		var jan_menge = $('#m_jan_menge').val();
		
		//var serial_no = $('#m_serial_no').val();
		var mill_sheet_no = $('#m_mill_sheet_no').val();
		
		
	
		if(!chkSubmit($("#m_in_menge"), "입고량을")) return false;
		if(Number(in_menge) == 0 ){
			fnMessageModalAlert("알림", "입고량을 입력해주세요.");	
			return false;
		}
		if(Number(in_menge) > Number(jan_menge) ){
			fnMessageModalAlert("알림", "입고량을 다시 입력해주세요.");	
			return false;
		}
		if(in_ware_code = ''){
			fnMessageModalAlert("알림", "창고를 선택해주세요.");	
			return false;
		}
		
		// 여기부터는 원재료 입고 처리 할때만 타야 하는 처리임
		// 원재료가 아닌것을 입고할 떄는 serail_no, mill_sheet_no, file을 등록할 필요가 없음.
		/////////// 여기 부터 
		//if(!chkSubmit($("#m_serial_no"), "Serial_No를")) return false;
		if(!chkSubmit($("#m_mill_sheet_no"), "mill_sheet_no를")) return false;
		
		fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
			if(chk){
				
				if(curFile){
					curFile.submit();
				} else {
					if(fileGroup && fileNo && !isRev){
						var pageUrl = '/frontend/consumable/warehousing_file_upload';
						var postData = {
								purchase_order_num : purchase_order_num,
								purchase_num : purchase_num,
								in_date : in_date,
								delivery_date : delivery_date,
								item_code : item_code,
								item_nm : item_nm,
								item_spec : item_spec,
								item_type_code : item_type_code,
								item_type_nm : item_type_nm,
								in_menge : in_menge,
								serial_no : serial_no,
								in_ware_code : 'wm19',
								mill_sheet_no : mill_sheet_no
							
						}
						FunLoadingBarStart();
						$.ajax({
							url : pageUrl,
							type : 'POST',
							data : postData,
							dataType : 'json',
							success : function(data){
								if(data.status = 200){
									fnMessageModalAlert("결과", "입고처리를 완료 하였습니다.");	// Notification(MES)
									$('#modal_stock').modal('hide');
								}
							},
							error : function(jqXHR, textStatus, errorThrown){
								fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
							}, complete : function(){
								loadList();
								FunLoadingBarEnd();
							}
						})
					} else {
						fnMessageModalAlert("알림", "등록된 파일 정보가 없습니다.");	// Notification(MES)
					}
				}
				
				
			}
		})
		/////////// 여기까지는 원재료 '입고' 할 때 사용 하는 것임
		
	}else
	{
		//자재
		var account_nm = $('#m_account_nm2').val();
		var item_code = $('#m_item_code2').val();
		var item_nm = $('#m_item_nm2').val();
		var in_menge = $('#m_in_menge2').val();
		in_menge = in_menge.replace(/(^0+)/, "");
		var jan_menge = $('#m_jan_menge2').val();
		var in_ware_code = $("#m_in_ware_code").val();
		
		var purchase_order_num = data.purchase_order_num;
		var purchase_num = data.purchase_num;
		var warehousing_status = data.warehousing_status;
		var in_date = getFormatDate(new Date()).replace(/-/gi,'');
		//var in_date ='';
		var item_spec = data.item_spec;
		var item_type_code = data.item_type_code;
		var item_type_nm = data.item_type_nm;
		
		var serial_no = data.serial_no;
		var meins = data.meins;

		if(!chkSubmit($("#m_in_menge2"), "입고량을")) return false;
		
		if(Number(in_menge) == 0 ){
			fnMessageModalAlert("알림", "입고량을 입력해주세요.");	
			return false;
		}
		if(Number(in_menge) > Number(jan_menge) ){
			fnMessageModalAlert("알림", "입고량을 다시 입력해주세요.");	
			return false;
		}
		
		if(in_ware_code == '' || in_ware_code == null || in_ware_code == 'null'){
			fnMessageModalAlert("알림", "창고를 선택해주세요.");	
			return false;
		}
		
		console.log("in_ware_code??" + in_ware_code);
		
		
		var strUrl = "/frontend/consumable/insertWarehouing";

		var postData = {
				purchase_order_num : purchase_order_num,
				purchase_num : purchase_num,
				warehousing_status : warehousing_status,
				in_date : in_date,
		
				item_code : item_code,
				item_nm : item_nm,
				item_spec : item_spec,
				item_type_code : item_type_code,
				item_type_nm : item_type_nm,
				serial_no : serial_no,
				meins : meins,
				in_ware_code : in_ware_code,
				in_menge : in_menge
			}
		FunLoadingBarStart(); 
		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
			async : false,	
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	loadList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
		    		console.log(data);
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
				$("#modal_info").modal('hide');
				FunLoadingBarEnd();
		    }
		});
		
	}


}

function setUploadFileParma(pInfo, pName){
	curFile = pInfo;
}

function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/frontend/consumable/warehousing_file_upload",
		dataType : 'json',
		autoUpload : false,
		enctype : "multipart/form-data",
 		//acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 30720000, 
		add: function(e, data){
			
			if(data.files[0].size > 30720000)
			{
				fnMessageModalAlert("알림", "파일 용량이 너무 큽니다.");
				return;
			}
			$('#mod_file_name').val(data.files[0].name);
			if(!$('#mod_input_file_name').val()) $('#mod_input_file_name').val(data.files[0].name);
			setUploadFileParma(data, data.files[0].name);
		},
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Error", file.error);
		} else {
			setUploadFileParma(data, file.name);
		}
	}).on('fileuploadprogressall', function(e, data) {
		 
		$('#progress').show();
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
    	
    	/* $('#t_' + e.target.id).val(data.files[0].name);
    	$('#a_' + e.target.id).val(data.result.file_group); */
    	
    	$('#modal_stock').modal('hide');
 
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		loadList2(pdata.purchase_order_num, pdata.purchase_num);
    	loadList();
 
    	
    	
	}).on('fileuploadfail', function(e, data) {
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).on('fileuploadsubmit', function(e, data){
		var $this = $(this);
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		var purchase_order_num = pdata.purchase_order_num;
		var purchase_num = pdata.purchase_num;
		var in_date = getFormatDate(new Date()).replace(/-/gi,'');
		var delivery_date = in_date;
		var account_nm = $('#m_account_nm').val();
		var item_code = $('#m_item_code').val();
		var item_nm = $('#m_item_nm').val();
		var item_spec = pdata.item_spec;
		var item_type_code = pdata.item_type_code;
		var item_type_nm = pdata.item_type_nm;
		
		var in_menge = $('#m_in_menge').val();
		in_menge = in_menge.replace(/(^0+)/, "");
		//var serial_no = $('#m_serial_no').val();
		var mill_sheet_no = $('#m_mill_sheet_no').val();
		data.formData = {
				
			purchase_order_num : purchase_order_num,
			purchase_num : purchase_num,
			in_date : in_date,
			delivery_date : delivery_date,
			item_code : item_code,
			item_nm : item_nm,
			item_spec : item_spec,
			item_type_code : item_type_code,
			item_type_nm : item_type_nm,
			in_menge : in_menge,
			//serial_no : serial_no,
			in_ware_code: 'wm19',
			mill_sheet_no : mill_sheet_no,

		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

//-------------------------------------------------------------------------------------------------------------------


var currentCount = 0;
function deleteRow() {
	console.log('deleteRow()');
	currentCount = 0;
	var key = w2ui.grid_list2.getSelection();
	
	if( key.length ==0 ) {
		fnMessageModalAlert("알림", "취소하고자 하는 항목을 1개 이상 선택하여야 합니다."); // Notification
		return;
	} else {
			
		fnMessageModalConfirm("알림", "입고취소 하시겠습니까?", function(result) {
	         if(result) {
				
				var strUrl = "/frontend/consumable/deleteWarehousing";
				FunLoadingBarStart();
				for(var i=0; i < key.length; i++){
					
					var data = w2ui.grid_list2.get(key[i]);
					var in_date_doc = data.in_date_doc;
					var purchase_order_num = data.purchase_order_num;
					var purchase_num = data.purchase_num;
					var serial_no = data.serial_no;
					var item_code = data.item_code;
					var in_menge = data.in_menge;
					var item_type_code = data.item_type_code;
					
					console.log("item_type_code" + item_type_code);
				
					var postData = "in_date_doc=" + encodeURIComponent(in_date_doc)
					+"&purchase_order_num=" + encodeURIComponent(purchase_order_num)
					+"&purchase_num=" + encodeURIComponent(purchase_num)
					+"&item_code=" + encodeURIComponent(item_code)
					+"&serial_no=" + encodeURIComponent(serial_no)
					+"&in_menge=" + encodeURIComponent(in_menge)
					+"&item_type_code=" + encodeURIComponent(item_type_code);
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : true,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		console.log(data);
						 		
						 		
						    	//fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
						 	}
						 },
						 error: function(jqXHR, textStatus, errorThrown){
						    	//fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
						 },
						 complete: function() {
								
								currentCount = currentCount + 1;
								var Csize = key.length;
								console.log("size는?" + Csize);
								console.log("currentCount는?" + currentCount);
								
								if(Number(currentCount) == Number(Csize)){
									console.log("탓다---------------------");
									FunLoadingBarEnd();
									var recids = w2ui.grid_list.getSelection();
							 		var pdata = w2ui.grid_list.get(recids[0]);
							 		
							 		try{
										loadList2(pdata.purchase_order_num, pdata.purchase_num);
										loadList();
							 		}catch(e)
							 		{
							 			FunLoadingBarEnd();
							 		}
									
									fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
								}
						
								
						 }
					}); 
					
			
				
				}
				
				
			}
		});
			
	}
	//loadList();
	
}


//조회
function loadList2(purchase_order_num, purchase_num)
{
	console.log("loadList2()");
	

	var page_url = "/frontend/consumable/selectWarehousing";
	
	var postData = "purchase_order_num=" + encodeURIComponent(purchase_order_num)
	+"&purchase_num=" + encodeURIComponent(purchase_num);

	try{
		
		w2ui.grid_list2.selectNone();
		w2ui['grid_list2'].lock('loading...', true);
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
					row.recid = idx+1;
					row.down_file = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'

				});
				
				w2ui['grid_list2'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list2'].clear();
				
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			

		},complete: function () {
			
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

function fnCdD_wh(val, val2) {
	console.log("fnCdD_wh(" + val + ")");

	//initOptions($("#customer_integration_code")); // select 박스 초기화
	
	var strUrl = "/info/select_wh_mng";
	var postData = "business_code=" + encodeURIComponent(val2);

	$.ajax({
				url : strUrl,
				type : "POST",
				//data : postData,
				dataType : 'json',
				async : false, // 다 끝나고 다음 처리 해!
				success : function(data, textStatus, jqXHR) {
					//	 	    	console.log("(data.rows).length = " + (data.rows).length);
					if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
						rowArr = data.rows;

						var sub = val.substr(0, 2); 
						//  if(valsub != "m_")
						//$("#m_in_ware_code").append("<option value="+''+">" + "전체"+ "</option>");
						
						$.each(rowArr, function(idx, row) {
							
							$("#m_in_ware_code").append("<option value=" + row.warehouse_code + ">"+ row.warehouse_nm + "</option>");});

							$("#m_in_ware_code option:eq(0)").prop("selected",true);

					}

				},
				error : function(jqXHR, textStatus, errorThrown) {
					//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
				},

				complete : function() {
						loadList();

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
function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}	

function todayLoadList()
{
	
	var minDate = getFormatDate(new Date());
	 $('#order_day').daterangepicker({
			opens: 'right',
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		    startDate: moment(minDate),
          endDate:  moment(minDate)
		}); 
	 
	
	loadList();
}




</script>

</body>
</html>