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
		<jsp:param name="selected_menu_p_cd" value="1043" />
		<jsp:param name="selected_menu_cd" value="1068" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	고객불만 이력관리
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>품질관리</a></li><li class="active">고객불만 이력관리</li>
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
						 	<!-- <button type="button" id="btn_create" class="btn btn-success btn-sm" onclick="fileComment();">완료</button> -->
					     	<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="requestIU_modal();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteItem();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
						
							<div class="col-sm-2">
								<div class="form-group">
								<label>최초발생일</label>
								 <input type="checkbox" id="chk_eindt" name="chk_eindt" value="1" style="margin: 0px;" onchange="chgEindt();" ><!-- checked -->
								
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="claim_date" placeholder="yyyymmdd~yyyymmdd" onchange="loadList();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>	
										</div>
									</div>
								</div>
							</div>
							<!-- <div class="col-sm-2">
								<div class="form-group">
									<label>상태</label>
									<select id="status" name="status" class="form-control" style="height: 30px;" onchange="loadList();">
									 	<option value="">전체</option> 
									 	<option value="N">접수</option>
									 	<option value="Y">완료</option>
									</select>
								</div>
							</div> -->
							<div class="col-sm-2">
								<div class="form-group">
									<label>접수번호</label> <input type="text" id="claim_num" name="claim_num" placeholder="ex) 접수번호"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
								
									
							<div class="col-sm-2">
								<div class="form-group">
									<label>타입</label> 
									<select id="claim_type" class="form-control input-sm" name="claim_type" onChange = "loadList();">
										<option value="">전체</option>
										<option value="MD1243">Consumable Parts</option>
										<option value="MD1244">Overhaul</option>
									</select>
								</div>
							</div>		
									
							<div class="col-sm-2">
								<div class="form-group">
									<label>고객사명</label> <input type="text" id="customer_nm" name="customer_nm" placeholder="ex) 고객사명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>S/N</label> <input type="text" id="serial_no" name="serial_no" placeholder="ex) S/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<!-- <div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
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
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row" id="">
						<div class="form-group col-sm-12">
							<div  class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label pull-left">접수번호</label>
								<div class="col-sm-7" style="padding:0;">
									<input type="text" class="form-control input-sm pull-left" id="m_claim_num" >
								</div>
							</div>	
							<div  class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label pull-left">타입</label>
								<div class="col-sm-7" style="padding:0;">
									<select id="m_claim_type" class="form-control input-sm" name="m_claim_type" >
										<option value="MD1243">Consumable Parts</option>
										<option value="MD1244">Overhaul</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group col-sm-12">
							<div class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label pull-left">최초발생일</label>
								<div class="col-sm-7" style="padding:0;">
									<div class="input-group">
									  <input type="text" class="form-control input-sm pull-left" id="m_claim_date">
										  <div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
								 	</div>
								</div>
							</div>
							<div  class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label pull-left">출고일자</label>
								<div class="col-sm-7" style="padding:0;">
									<div class="input-group">
									  <input type="text" class="form-control input-sm pull-left" id="m_out_date">
										  <div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
								 	</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group col-sm-12">
							<div class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label pull-left">고객사명</label>
								<div class="col-sm-7" style="padding:0;">
									<input type="text" class="form-control input-sm pull-left" id="m_customer_nm" onkeypress="if(event.keyCode==13) {requestCustomer(); return false;}"  >
								</div>
							</div>	
							<div class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label pull-left">장착일</label>
								<div class="col-sm-7" style="padding:0;">
									<div class="input-group">
									  <input type="text" class="form-control input-sm pull-left" id="m_mounting_date">
										  <div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
								 	</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group col-sm-12">
							<div class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">고객사 코드</label>
								<div class="col-sm-7" style="padding:0;">
									<input type="text" class="form-control input-sm pull-right" id="m_customer_code" >
								</div>
							</div>	
							<div  class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">탈착일</label>
								<div class="col-sm-7" style="padding:0;">
									<div class="input-group">
									  <input type="text" class="form-control input-sm" id="m_desorption_date">
										  <div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
								 	</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group col-sm-12">
							<div class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">P/N</label>
								<div class="col-sm-7" style="padding:0;">
									<input type="text" class="form-control input-sm pull-right" id="m_item_code" >
								</div>
							</div>	
							<div  class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">적용</label>
								<div class="col-sm-7" style="padding:0;">
									<div class="input-group">
									  <input type="text" class="form-control input-sm" id="m_apply">
										  <div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
								 	</div>
								</div>
							</div>
					 		
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group col-sm-12">
							<div class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">품명</label>
								<div class="col-sm-7" style="padding:0;">
									<input type="text" class="form-control input-sm pull-right" id="m_item_nm" >
								</div>
							</div>	
							<div  class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">결과</label>
								<div class="col-sm-5"  style="padding-top: 5px;">
									<!-- <input type="text" class="form-control input-sm pull-right" id="m_result" > -->
									
									<label>
						               <input type="radio" id="rdo_result_yn" name="rdo_result_yn" class="flat-red form-control" value="OK" checked> OK 
						             </label>
						             
						             <label>
						               <input type="radio" id="rdo_result_yn"  name="rdo_result_yn" class="flat-red form-control" value="NG" > NG
						             </label>
								</div>
							</div> 
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-12">
							<div class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">S/N</label>
								<div class="col-sm-7" style="padding:0;">
									<input type="text" class="form-control input-sm pull-right" id="m_serial_no" >
								</div>
							</div>	
							<div  class="col-sm-6 control-label" style="padding:0;">
								<label for="" class="col-sm-5 control-label">발생유형</label>
								<div class="col-sm-7" style="padding:0;">
									<input type="text" class="form-control input-sm pull-right" id="m_type" >
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객불만(현상)</label>
							<div class="col-sm-8">
								<textarea type="text" class="form-control input-sm pull-right" id="m_reason" ></textarea>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">원인파악</label>
							<div class="col-sm-8">
								<textarea type="text" class="form-control input-sm pull-right" id="m_comment1" ></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">대책</label>
							<div class="col-sm-8">
								<textarea type="text" class="form-control input-sm pull-right" id="m_comment2" ></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">비고</label>
							<div class="col-sm-8">
								<textarea type="text" class="form-control input-sm pull-right" id="m_comment_etc" ></textarea>
							</div>
						</div>
					</div>
					<div class="row" id="m_file_upload_r">
						<div class="form-group">
							<label class="col-sm-3 control-label">고객불만 보고서1</label>
							<div class="col-sm-7">
								<input type="text" id="m_down_one_file_name" name="m_down_one_file_name" class="form-control input-sm clear_field pull-right" readonly>
							</div>	
							<div class="col-sm-1" style="padding-left: 7px;">
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn" onclick="type('one');"> <i class="fa fa-plus"></i>
									<input id="file_group" type="file" class="fileupload file_info" name="file[]">
								</span>
							</div>
						</div>
					</div>
					<div class="row" id="m_file_upload_r2">
						<div class="form-group">
							<label class="col-sm-3 control-label">고객불만 보고서2</label>
							<div class="col-sm-7">
								<input type="text" id="m_down_two_file_name" name="m_down_two_file_name" class="form-control input-sm clear_field pull-right" readonly>
							</div>	
							<div class="col-sm-1" style="padding-left: 7px;">
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn" onclick="type('two');"> <i class="fa fa-plus"></i>
									<input id="file_group" type="file" class="fileupload file_info" name="file[]">
								</span>
							</div>
						</div>
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
<div class="modal fade" id="modal_info2" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">고객불만보고서</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row" id="m_file_upload_r">
						<div class="form-group">
							<label class="col-sm-3 control-label">고객불만 보고서1</label>
							<div class="col-sm-6">
								<input type="text" id="m_down_one_file_name2" name="m_down_one_file_name2" class="form-control input-sm clear_field pull-right" readonly>
							</div>	
							<div class="col-sm-1" style="padding-left: 7px;">
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn" onclick="type('one');"> <i class="fa fa-plus"></i>
									<input id="file_group" type="file" class="fileupload2 file_info" name="file[]">
								</span>
							</div>
						</div>
					</div>
					<div class="row" id="m_file_upload_r">
						<div class="form-group">
							<label class="col-sm-3 control-label">고객불만 보고서2</label>
							<div class="col-sm-6">
								<input type="text" id="m_down_two_file_name2" name="m_down_two_file_name2" class="form-control input-sm clear_field pull-right" readonly>
							</div>	
							<div class="col-sm-1" style="padding-left: 7px;">
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"  onclick="type('two');"> <i class="fa fa-plus"></i>
									<input id="file_group" type="file" class="fileupload2 file_info" name="file[]">
								</span>
							</div>
						</div>
					</div>
				</form>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveFile();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
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

comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;
comboValue_nm4 = new Array;

$(function($) {

 	fnLoadCommonOption(); 	 

 	init_grid_list();
 	
 	fnLoadFileHandler();
 	fnLoadFileHandler2();
 	
 	loadList();
 	
 	requestCustomer();
 	
 	requestItem();
 
})

//품명,품번 자동완성
$("#m_item_nm").change(_.debounce(function(event) {
	
	var item_nm = $("#m_item_nm").val();
	$(this).val(function(index, value) {
		console.log('m_item_nm key_up : '+ value);
		
		getItemInfo('nm',value);
		return value
	});
	
},400));
$("#m_item_code").change(
		
		_.debounce(function(event) 
		{
	
			var item_code = $("#m_item_code").val();
			$(this).val(function(index, value) {
				console.log('item_code key_up : '+ value);
				
				getItemInfo('cd',value);
				return value
			});
	
},400));

/* $(window).on('resize', _.debounce(function() { 
    display_info($right_panel); 
  }, 400));  */

//고객사명,코드 자동완성

$("#m_customer_code").change(
		
		_.debounce(function(event) 
		{
	
			var customer_code = $("#m_customer_code").val();
			$(this).val(function(index, value) {
				console.log('m_customer_code key_up : '+ value);
				
				getcustomerInfo('cd',value);
				return value
			});
	
},400));
  
$("#m_customer_nm").change(
			
			_.debounce(function(event) 
			{
		
				var customer_nm = $("#m_customer_nm").val();
				$(this).val(function(index, value) {
					console.log('m_customer_nm key_up : '+ value);
					
					getcustomerInfo('nm',value);
					return value
				});
		
	},400));  


// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
		$('#m_claim_date, #m_out_date, #m_mounting_date, #m_desorption_date, #m_apply').daterangepicker({
			opens: 'right', 
			singleDatePicker: true,
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear: true,
				yearSuffix: '년',
			
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
		 	     endDate: '2020-08-31' 
			}); 
		 
		 
		 $("#m_order_price").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
		 
		 $('#claim_date').daterangepicker({
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
    endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(7, 'days')

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
		                  
			{ field:'file_path', caption:'파일path', style:'text-align:center', hidden : true},
			{ field:'file_name', caption:'파일name', style:'text-align:center', hidden : true},
			{ field:'file_ext', caption:'파일ext', style:'text-align:center', hidden : true},
			{ field:'file_size', caption:'파일size', style:'text-align:center', hidden : true},
			
			{ field:'t_file_path', caption:'파일path', style:'text-align:center', hidden : true},
			{ field:'t_file_name', caption:'파일name', style:'text-align:center', hidden : true},
			{ field:'t_file_ext', caption:'파일ext', style:'text-align:center', hidden : true},
			{ field:'t_file_size', caption:'파일size', style:'text-align:center', hidden : true},     
               
			{ field:'claim_num', caption:'접수번호', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'claim_type', caption:'타입', size:'10%', style:'text-align:center', hidden : false
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'MD1243')
	            	{
	            	   return 'Consumable Parts';
	            	}else if(html == 'MD1244')
	            	{
	            		 return 'Overhaul';
	            	}
	               return html;
		           } 		
			 ,sortable: true},
			{ field:'status', caption:'상태', size:'5%', style:'text-align:center' , hidden : true
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'N')
	            	{
	            	   return '접수';
	            	}else if(html == 'Y')
	            	{
	            		 return '완료';
	            	}
	               return html;
		           } 	
			 ,sortable: true},
			{ field:'customer_nm', caption:'고객사명', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'customer_code', caption:'고객사코드', size:'10%',  style:'text-align:center',hidden:true},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'serial_no', caption:'S/N', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'out_date', caption:'출고일자', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'mounting_date', caption:'장착일', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'desorption_date', caption:'탈착일', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'claim_date', caption:'최초발생일', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'reason', caption:'고객불만(현상)', size:'25%', style:'text-align:center' ,sortable: true},
			{ field:'comment1', caption:'원인파악', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'comment2', caption:'대책', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'complete_date', caption:'완료일자', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'apply', caption:'적용', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'result', caption:'결과', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'type', caption:'발생유형', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'down_file_name', caption:'고객불만보고서1', size:'20%', style:'text-align:left' ,sortable: true},
			{ field:'down_file_name2', caption:'고객불만보고서2', size:'20%', style:'text-align:left' ,sortable: true},
			{ field:'comment_etc', caption:'비고', size:'20%', style:'text-align:left' ,sortable: true}
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
	
	file_upload_yn = 'N';
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		insertItem();
	}else  if( key.length==1 ) {	
		updateItem();	
	}
}
var isRev = false;
//등록
function insertItem() {
	console.log('insertItem()');

	w2ui.grid_list.selectNone();
	
	var minDate = getFormatDate(new Date());

	$("#modal_code_title").text('등록');
	
	$("#m_file_upload_r").hide();
	$("#m_file_upload_r2").hide();
	
	$("#m_claim_num").val('');
	$("#m_customer_nm").val('');
	$("#m_customer_code").val('');
	$("#m_item_code").val('');
	$("#m_item_nm").val('');
	$("#m_serial_no").val('');
	$("#m_reason").val('');
	$("#m_comment1").val('');
	$("#m_comment2").val('');
	$("#m_comment3").val('');
	$("#m_claim_type option:eq(0)").prop("selected", true);	 
	
	$("#m_out_date").val(minDate);
	$("#m_claim_date").val(minDate);
	$("#m_mounting_date").val(minDate);
	$("#m_desorption_date").val(minDate);
	$("#m_apply").val(minDate);
	
	


	$(':radio[name="rdo_result_yn"][value="OK"]').iCheck('check');
	//$("#m_result").val('');

	$("#m_type").val('');
	$("#m_comment_etc").val('');
	
	var claim_num = $("#m_claim_num").attr('disabled', true);

	 			
	$("#modal_info").modal('show');

}
//수정
function updateItem() {
	console.log('updateItem()');
	
	curFile = null;
	isRev = true;
	 var key = w2ui.grid_list.getSelection();
	 if( key.length==1 ) {
		// update
		$("#modal_code_title").text('수정');
		var key = w2ui.grid_list.getSelection();
		var data = w2ui.grid_list.get(key[0]);
		
		$("#m_file_upload_r").show();
		$("#m_file_upload_r2").show();
		
		$("#m_claim_num").val(data.claim_num);
		$("#m_customer_nm").val(data.customer_nm);
		$("#m_customer_code").val(data.customer_code);
		$("#m_item_code").val(data.item_code);
		$("#m_item_nm").val(data.item_nm);
		$("#m_serial_no").val(data.serial_no);
		$("#m_reason").val(data.reason);
		$("#m_comment1").val(data.comment1);
		$("#m_comment2").val(data.comment2);
		
		$("#m_out_date").val(data.out_date);
		$("#m_claim_date").val(data.claim_date);
		$("#m_mounting_date").val(data.mounting_date);
		$("#m_desorption_date").val(data.desorption_date);
		$("#m_apply").val(data.apply);
		
		$("#m_claim_type").val(data.claim_type);

		
		console.log('claim_type?' + data.claim_type);
		

		$("#m_result").val(data.result);
		//$("input:radio[name='rdo_result_yn']:radio[value='"+data.result+"']").attr("checked",true);
		$(':radio[name="rdo_result_yn"][value="'+data.result+'"]').iCheck('check');
		$("#m_type").val(data.type);
		$("#m_comment_etc").val(data.comment_etc);
		
		if(data.file_name == null || data.file_name == 'null')
		{
			$("#m_down_one_file_name").val('');
		}else{
			$("#m_down_one_file_name").val(data.file_name);
		}
		if(data.t_file_name == null || data.t_file_name == 'null')
		{
			$("#m_down_two_file_name").val('');
		}else{
			$("#m_down_two_file_name").val(data.t_file_name);
		}
		$("#m_claim_num").attr('disabled', true);
		
		$("#modal_info").modal('show');
	} 
	
}

function fileComment() {
	
	curFile = null;
	isRev = false;
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	if( key.length==1 ) {
		// update
		$("#m_down_one_file_name2").val('');
		$("#m_down_two_file_name2").val('');
		
		$("#m_down_one_file_name2").val(data.file_name);
		$("#m_down_two_file_name2").val(data.t_file_name);
		
		$("#modal_info2").modal('show');
	} else {
		fnMessageModalAlert("알림", "완료하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
	}
}

function getClaimNum()
{
	var key = w2ui.grid_list.getSelection();

	var claim_num = '';
	if( key.length==1 ) {	
		var data = w2ui.grid_list.get(key[0]);
		claim_num = data.claim_num;
	}
	
	return claim_num;
}

//저장전 관리번호 가져오는부분
function saveProcess()
{
	console.log("saveProcess()");
	
	var key = w2ui.grid_list.getSelection();

	var claim_num = '';
	var receipt_date = '';
	if( key.length==1 ) {	
		var data = w2ui.grid_list.get(key[0]);
		claim_num = data.claim_num;
		receipt_date = data.receipt_date;
	}
	
	
	saveItem(claim_num,receipt_date);
	//saveFile(claim_num);


}

//저장
function saveItem(claim_num, receipt_date) {
	console.log('saveItem()');
	console.log('claim_num : ' + claim_num);
	console.log('receipt_date : ' + receipt_date);


	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	
	if( key.length==1 ){
		if(!chkSubmit($("#m_customer_nm"), "고객사명을")) return;
		if(!chkSubmit($("#m_customer_code"), "고객사 코드를")) return;
		if(!chkSubmit($("#m_serial_no"), "S/N을")) return;
		if(!chkSubmit($("#m_item_code"), "P/N을")) return;
		if(!chkSubmit($("#m_item_nm"), "품명을")) return;
		if(!chkSubmit($("#m_reason"), "고객불만 현상을")) return;
		if(!chkSubmit($("#m_comment1"), "원인파악을")) return;
		if(!chkSubmit($("#m_comment2"), "대책을")) return;
		
		
		var down_file_name = $("#m_down_one_file_name").val();
		var down_file_name2 = $("#m_down_two_file_name").val();
		
		if (file_upload_yn == 'N'){
			
			var customer_nm = $("#m_customer_nm").val();
			var customer_code = $("#m_customer_code").val();
			var item_code = $("#m_item_code").val();
			var item_nm = $("#m_item_nm").val();
			var serial_no = $("#m_serial_no").val();
			var reason = $("#m_reason").val();
			var comment1 = $("#m_comment1").val();
			var comment2 = $("#m_comment2").val();
			var comment3 = '';
			
			var out_date = $("#m_out_date").val();
			var mounting_date = $("#m_mounting_date").val();
			var desorption_date = $("#m_desorption_date").val();
			var apply = $("#m_apply").val();
			//var result = $("#m_result").val();
			
			var result = $(":radio[name='rdo_result_yn']:checked").val();
			var type = $("#m_type").val();
			var comment_etc = $("#m_comment_etc").val();

			var claim_date = $('#m_claim_date').val();
			
			var claim_type = $("#m_claim_type option:selected").val();
			
			if(!chkSubmit($("#m_customer_nm"), "고객사명을")) return;
			
			$("#modal_info").modal('hide');
			
			
			var strUrl = "/frontend/quality/saveClaim";
			var postData = "customer_nm=" + encodeURIComponent(customer_nm)
					+ "&customer_code=" + encodeURIComponent(customer_code)
					+ "&claim_num=" + encodeURIComponent(claim_num)
					+ "&receipt_date=" + encodeURIComponent(receipt_date)
					+ "&claim_date=" + encodeURIComponent(claim_date)
					+ "&item_code=" + encodeURIComponent(item_code)
					+ "&item_nm=" + encodeURIComponent(item_nm)
					+ "&serial_no=" + encodeURIComponent(serial_no)
					+ "&reason=" + encodeURIComponent(reason)
					+ "&comment1=" + encodeURIComponent(comment1)
					+ "&comment2=" + encodeURIComponent(comment2)
					+ "&comment3=" + encodeURIComponent(comment3)
					+ "&out_date=" + encodeURIComponent(out_date)
					+ "&mounting_date=" + encodeURIComponent(mounting_date)
					+ "&desorption_date=" + encodeURIComponent(desorption_date)
					+ "&apply=" + encodeURIComponent(apply)
					+ "&result=" + encodeURIComponent(result)
					+ "&type=" + encodeURIComponent(type)
					+ "&claim_type=" + encodeURIComponent(claim_type)
					+ "&comment_etc=" + encodeURIComponent(comment_etc)
					;
			FunLoadingBarStart();
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
			    	FunLoadingBarEnd();
			    }
			});
			
		}else {
			
			
			if(curFile){
				fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
					if(chk){
						
						curFile.submit();
					}
				});
			}else{
				var customer_nm = $("#m_customer_nm").val();
				var customer_code = $("#m_customer_code").val();
				var item_code = $("#m_item_code").val();
				var item_nm = $("#m_item_nm").val();
				var serial_no = $("#m_serial_no").val();
				var reason = $("#m_reason").val();
				var comment1 = $("#m_comment1").val();
				var comment2 = $("#m_comment2").val();
				
				var out_date = $("#m_out_date").val();
				var mounting_date = $("#m_mounting_date").val();
				var desorption_date = $("#m_desorption_date").val();
				var apply = $("#m_apply").val();
				//var result = $("#m_result").val();
				var result = $(":radio[name='rdo_result_yn']:checked").val();
				var type = $("#m_type").val();
				var comment_etc = $("#m_comment_etc").val();
		
				var claim_date = $('#m_claim_date').val();
				
				var claim_type = $("#m_claim_type option:selected").val();
				
				//var down_file_name = $("#m_down_file_name").val(data.down_file_name);
				
				if(!chkSubmit($("#m_customer_nm"), "고객사명을")) return;
				
				fnMessageModalConfirm('알림', '수정사항을 저장하시겠습니까?',function(chk){
					if(chk){
							if((down_file_name != '' || down_file_name2 != '') && isRev){
								var pageUrl = '/frontend/quality/saveClaimFile';
								var postData = {
										claim_num : claim_num,
										customer_nm : customer_nm,
										customer_code : customer_code,
										item_code : item_code,
										item_nm : item_nm,
										serial_no : serial_no,
										reason : reason,
										comment1 : comment1,
										comment2 : comment2,
										claim_date : claim_date,
										
										out_date : out_date,
										mounting_date : mounting_date,
										desorption_date : desorption_date,
										apply : apply,
										result : result,
										type : type,
										comment_etc : comment_etc,
										claim_type : claim_type,
										
										down_file_name : down_file_name,
										down_file_name2 : down_file_name2
										
										
								}
								FunLoadingBarStart();
								$.ajax({
									url : pageUrl,
									type : 'POST',
									data : postData,
									dataType : 'json',
									success : function(data){
										if(data.status = 200){
											fnMessageModalAlert("결과", "파일정보 수정을 완료 하였습니다.");	// Notification(MES)
											$("#modal_info").modal('hide');
										}
									},
									error : function(jqXHR, textStatus, errorThrown){
										fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");
										$("#modal_info").modal('hide');// Notification(MES)
									}, complete : function(){
										FunLoadingBarEnd();
										loadList();
									}
								})
							} else {
								fnMessageModalAlert("알림", "등록된 파일 정보가 없습니다.");	// Notification(MES)
							}
						
						
					}
				})
			}
		}
		
	}else{
		if(!chkSubmit($("#m_customer_nm"), "고객사명을")) return;
		if(!chkSubmit($("#m_customer_code"), "고객사 코드를")) return;
		if(!chkSubmit($("#m_serial_no"), "S/N을")) return;
		if(!chkSubmit($("#m_item_code"), "P/N을")) return;
		if(!chkSubmit($("#m_item_nm"), "품명을")) return;
		if(!chkSubmit($("#m_reason"), "고객불만 현상을")) return;
		if(!chkSubmit($("#m_comment1"), "원인파악을")) return;
		if(!chkSubmit($("#m_comment2"), "대책을ㄴ")) return;

		var customer_nm = $("#m_customer_nm").val();
		var customer_code = $("#m_customer_code").val();
		var item_code = $("#m_item_code").val();
		var item_nm = $("#m_item_nm").val();
		var serial_no = $("#m_serial_no").val();
		var reason = $("#m_reason").val();
		var comment1 = $("#m_comment1").val();
		var comment2 = $("#m_comment2").val();
		var comment3 = '';
		
		var out_date = $("#m_out_date").val();
		var mounting_date = $("#m_mounting_date").val();
		var desorption_date = $("#m_desorption_date").val();
		var apply = $("#m_apply").val();
		//var result = $("#m_result").val();
		var result = $(":radio[name='rdo_result_yn']:checked").val();
		var type = $("#m_type").val();
		var comment_etc = $("#m_comment_etc").val();
		
		var claim_type = $("#m_claim_type option:selected").val();

		var claim_date = $('#m_claim_date').val();
		
		if(!chkSubmit($("#m_customer_nm"), "고객사명을")) return;
		
		$("#modal_info").modal('hide');
		
		
		var strUrl = "/frontend/quality/saveClaim";
		var postData = "customer_nm=" + encodeURIComponent(customer_nm)
				+ "&customer_code=" + encodeURIComponent(customer_code)
				+ "&claim_num=" + encodeURIComponent(claim_num)
				+ "&receipt_date=" + encodeURIComponent(receipt_date)
				+ "&claim_date=" + encodeURIComponent(claim_date)
				+ "&item_code=" + encodeURIComponent(item_code)
				+ "&item_nm=" + encodeURIComponent(item_nm)
				+ "&serial_no=" + encodeURIComponent(serial_no)
				+ "&reason=" + encodeURIComponent(reason)
				+ "&comment1=" + encodeURIComponent(comment1)
				+ "&comment2=" + encodeURIComponent(comment2)
				+ "&comment3=" + encodeURIComponent(comment3)
				+ "&out_date=" + encodeURIComponent(out_date)
				+ "&mounting_date=" + encodeURIComponent(mounting_date)
				+ "&desorption_date=" + encodeURIComponent(desorption_date)
				+ "&apply=" + encodeURIComponent(apply)
				+ "&result=" + encodeURIComponent(result)
				+ "&type=" + encodeURIComponent(type)
				+ "&claim_type=" + encodeURIComponent(claim_type)
				+ "&comment_etc=" + encodeURIComponent(comment_etc);
		FunLoadingBarStart();
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
		    	FunLoadingBarEnd();
		    }
		});
	}

	
}

//삭제

function deleteItem() {
	console.log('deleteItem()');

	
	/* 삭제하면 del_yn은 Y로 바뀌는데 그리드에서 삭제가 안대여 */
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui.grid_list.get(key[0]);
		var claim_num = data.claim_num;
		
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				
				var strUrl = "/frontend/quality/deleteClaim";
				var postData = "claim_num=" + encodeURIComponent(claim_num);
				
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

function chgEindt()
{
	console.log('chgEindt()');
	loadList();
}
//조회
function loadList()
{
	console.log('loadList()');
	
	try{
		w2ui['grid_list'].clear();
		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
	}catch(e){
		
	}

	var chk_eindt = $("input:checkbox[id='chk_eindt']").is(":checked")
	console.log('chk_eindt : ' + chk_eindt);
	
	var claim_date = $("#claim_date").val();
	var customer_nm = $('#customer_nm').val();
	var item_code = $('#item_code').val();
	var serial_no = $('#serial_no').val();
	var claim_num =   $("#claim_num").val();
	var claim_type = $("#claim_type option:selected").val();
	//var in_menge = w2ui["grid_list"].records.original_cnt;
	if(chk_eindt == 'false' || chk_eindt == false)
	{
		claim_date = '';
	}
	var page_url = "/frontend/quality/selectClaim";
	
	var postData = "customer_nm=" + encodeURIComponent(customer_nm)
				+ "&claim_date=" + encodeURIComponent(claim_date)
				+ "&item_code=" + encodeURIComponent(item_code)
				+ "&claim_num=" + encodeURIComponent(claim_num)
				+ "&claim_type=" + encodeURIComponent(claim_type)
				+ "&serial_no=" + encodeURIComponent(serial_no);
	try{
		
		w2ui.grid_list.selectNone();
		//w2ui['grid_list'].lock('loading...', true);
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
					
					if(row.customer_nm)comboValue_nm1.push(row.customer_nm);
					if(row.serial_no)comboValue_nm2.push(row.serial_no);
					if(row.item_code)comboValue_nm3.push(row.item_code);
					if(row.claim_num)comboValue_nm4.push(row.claim_num);
					
					if(row.file_name != null && row.file_name != '' && row.file_name != 'null'){
						row.down_file_name = '<a href="/file/attach_download?file_path=' + encodeURIComponent(row.file_path) +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.file_name+ '</i>';
					}
					else
					{
						row.down_file_name = '';
					}
					if(row.t_file_name != null && row.t_file_name != '' && row.t_file_name != 'null'){
						row.down_file_name2 = '<a href="/file/attach_download?file_path=' + encodeURIComponent(row.t_file_path) +'&file_name=' + encodeURIComponent(row.t_file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.t_file_name+ '</i>';
					}else{
						row.down_file_name2 = '';
						
					}
					
					
				});
				
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					$('#serial_no').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
					$('#claim_num').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
				}
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			
			

		},complete: function () {
			startValue_combo = ":)";
	
			document.getElementById("customer_nm").style.removeProperty("height");
			document.getElementById("serial_no").style.removeProperty("height");
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("claim_num").style.removeProperty("height");
		}
	});
}


var startValue_combo = "";
var startValue_combo2 = "";
var startValue_combo3 = "";
comboValue_nm = new Array;
comboValue_ct = new Array;

comboValue_nm_i = new Array;
comboValue_cd = new Array;

var materialArr = new Array;

//모달 제품
function requestItem(){
	// 프론트콘ㅌ롤러, 서비스, Dao 만들어야함 
	var page_url = "/info/material/selectMaterial2";
	var postData = 'item_type_code=MD1248'
	+'&item_type_codeT=MD1247'
	+ '&item_nm='+$('#m_item_nm').val();
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				materialArr = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
					if (startValue_combo2 == "") {
						comboValue_nm_i.push(row.item_nm);
						comboValue_cd.push(row.item_code);
					}
				});
			
				
				if (startValue_combo2 == "") {
					
					
					$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm_i,false) ,match : 'contains' });				
					$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
				}
			} else {
				
			}

		}, complete : function() {
			startValue_combo2 = ":)";
		}
	});
}
function getItemInfo(type, value)
{
	
	console.log('getItemInfo() : ' + value);
	var result = "";
	if(type == 'cd')
	{
		$.each(materialArr, function(idx, row){
			
			if(value == row.item_code)
			{
				console.log('row.item_nm : ' + row.item_nm);
				result = row.item_nm;		
				$("#m_item_nm").val(result);
			}
		});

		if(result == ''){
			$("#m_item_nm").val('');
		}
		
	}else if(type == 'nm')
	{
		
		$.each(materialArr, function(idx, row){
			
			if(value == row.item_nm)
			{
				console.log('row.item_code : ' + row.item_code);
				result = row.item_code;
				$("#m_item_code").val(result);
			}
		});
		if(result == ''){
			$("#m_item_code").val('');
		}
		
	}

	
	
}

//모달 고객사 리스트
var customerArr = new Array;
function requestCustomer() {
	console.log("requestCustomer()");
	
	var page_url = "/info/customer/selectCustomer";
 	var postData = "account_code=" + encodeURIComponent($("#account_code").val())
		 + "&account_nm=" + encodeURIComponent($("#account_nm").val());
	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				console.table(data);
				rowArr = data.rows;
				customerArr = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if (startValue_combo3 == "") {
						comboValue_nm.push(row.customer_nm);
						comboValue_ct.push(row.customer_code);
					}
				});
				console.log("comboValue_nm :" +comboValue_nm);
				
				if (startValue_combo3 == "") {
					
					$('#m_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });		
					$('#m_customer_code').w2field('combo', { items: _.uniq(comboValue_ct,false) ,match : 'contains' });		
				
				}
			} else {
	
			}

		},complete: function () {
			startValue_combo3 = ":)";
		}
	});
	
}


function getcustomerInfo(type, value)
{
	
	console.log('getcustomerInfo() : ' + value);
	var result = "";
	if(type == 'cd')
	{
		$.each(customerArr, function(idx, row){
			
			if(value == row.customer_code)
			{
				result = row.customer_nm;
				console.log('result: '+ result);
				$("#m_customer_nm").val(result);
			}
		});
		
		console.log('result--------------: '+ result);
		if(result == ''){
			$("#m_customer_nm").val('');
		}
	
		
	}else if(type == 'nm')
	{
		
		$.each(customerArr, function(idx, row){
			
			if(value == row.customer_nm)
			{
				result = row.customer_code;
				$("#m_customer_code").val(result);
			}
		});
		
		console.log('result22222--------------: '+ result);
		if(result == ''){
			$("#m_customer_code").val('');
		}
	}

}


var curFile = null;

//여기서부터 완료 첨부파일
var typeString = '';
function setUploadFileParma(pInfo, pName, pType){
	console.log(pName);
	if(curFile == null){

		curFile = pInfo;
		typeString = pType;
		console.log('typeString : ' + typeString);
	}else
	{
		if ( curFile.files[0].name != pName) {
			
			if(pType == 'one')
		      {
		         curFile.files[0] = pInfo.originalFiles[0];
		      }   
		      
		      if(pType == 'two')
		      {
		         curFile.files[1] = pInfo.originalFiles[0]; 
		      }   
		      
		      typeString = "one#two";
	
		}else
		{
			curFile = null;
		
			curFile = pInfo;	
			typeString = pType;
		}
	}

}


function saveFile(){
	console.log('saveFile()');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var file_path ='';
	var file_name ='';
	var file_ext ='';
	var file_size ='';
	
	var t_file_path ='';
	var t_file_name ='';
	var t_file_ext ='';
	var t_file_size ='';
	
	var claim_num = data.claim_num;
	
	fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
		if(chk){
			
			if(curFile){
				curFile.submit();
			} else {
				if(!isRev){
					var pageUrl = '/frontend/quality/updateClaim';
					var postData = {
							file_path : file_path,
					 		file_name : file_name,
					 		file_ext : file_ext,
					 		file_size : file_size,
					 		
					 		t_file_path : t_file_path,
					 		t_file_name : t_file_name, 
					 		t_file_ext : t_file_ext,
					 		t_file_size : t_file_size,
							
							claim_num : claim_num,
							typeString: typeString
					}
					FunLoadingBarStart();
					$.ajax({
						url : pageUrl,
						type : 'POST',
						data : postData,
						dataType : 'json',
						success : function(data){
							if(data.status = 200){
								fnMessageModalAlert("결과", "업로드를 완료 하였습니다.");	// Notification(MES)
								$('#modal_info2').modal('hide');
							}
						},
						error : function(jqXHR, textStatus, errorThrown){
							fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
						}, complete : function(){
							FunLoadingBarEnd();
							loadList();
						}
					})
				} else {
					fnMessageModalAlert("알림", "등록된 파일 정보가 없습니다.");	// Notification(MES)
				}
			}
			
		}
	})
}

function fnLoadFileHandler(){
	
	$('.fileupload2').fileupload({
		url : "/frontend/quality/updateClaim",
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
				
				console.log('######### fnLoadFileHandler fileupload');
			}
			var file_name = data.files[0].name;
			$('#m_down_'+currentType+'_file_name2').val(file_name);
		/* 	 if(!$('#mod_input_file_name').val()) $('#mod_input_file_name').val(data.files[0].name); */
			setUploadFileParma(data, data.files[0].name, currentType);
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
    	
    	$('#modal_info2').modal('hide');
 
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
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
		
		var claim_num = pdata.claim_num;
		
		
		var file_path ='';
		var file_name = $('#m_down_one_file_name2').val();
		var file_ext ='';
		var file_size ='';
		
		var t_file_path ='';
		var t_file_name = $('#m_down_two_file_name2').val();
		var t_file_ext ='';
		var t_file_size ='';
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		if( recids.length==1){
			
			
			file_path = pdata.file_path;
			file_name = pdata.file_name;
			file_ext = pdata.file_ext;
			file_size = pdata.file_size;
			
			t_file_path = pdata.t_file_path;
			t_file_name = pdata.t_file_name;
			t_file_ext = pdata.t_file_ext;
			t_file_size = pdata.t_file_size;
		}
		
		data.formData = {
				
				claim_num : claim_num,
				
				file_path : file_path,
		 		file_name : file_name,
		 		file_ext : file_ext,
		 		file_size : file_size,
		 		
		 		t_file_path : t_file_path,
		 		t_file_name : t_file_name, 
		 		t_file_ext : t_file_ext,
		 		t_file_size : t_file_size,
		 		typeString : typeString

		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

var file_upload_yn = 'N';
function fnLoadFileHandler2(){
	
	$('.fileupload').fileupload({
		url : "/frontend/quality/saveClaimFile",
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
			console.log('######### fileupload');
			
			file_upload_yn = 'Y';
			var file_name = data.files[0].name;
			$('#m_down_'+currentType+'_file_name').val(file_name);
		/* 	 if(!$('#mod_input_file_name').val()) $('#mod_input_file_name').val(data.files[0].name); */
			setUploadFileParma(data, data.files[0].name,currentType);
		},
	}).on('fileuploadadd', function(e, data) {
		console.log('######### fileuploadadd');
	}).on('fileuploadprocessalways', function(e, data) {
		
		console.log('######### fileuploadprocessalways');
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Error", file.error);
		} else {
			setUploadFileParma(data, file.name);
		}
	}).on('fileuploadprogressall', function(e, data) {
		console.log('######### fileuploadprogressall');
		$('#progress').show();
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		console.log('######### fileuploaddone');
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
    	
    	/* $('#t_' + e.target.id).val(data.files[0].name);
    	$('#a_' + e.target.id).val(data.result.file_group); */
    	
    	$('#modal_info').modal('hide');
 
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
    	loadList();
 
    	
    	
	}).on('fileuploadfail', function(e, data) {
		
		console.log('######### fileuploadfail');
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).on('fileuploadsubmit', function(e, data){
		
		console.log('######### fileuploadsubmit');
		var $this = $(this);
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		var claim_num = pdata.claim_num;
		var customer_nm = $("#m_customer_nm").val();
		var customer_code = $("#m_customer_code").val();
		var item_code = $("#m_item_code").val();
		var item_nm = $("#m_item_nm").val();
		var serial_no = $("#m_serial_no").val();
		var reason = $("#m_reason").val();
		var comment1 = $("#m_comment1").val();
		var comment2 = $("#m_comment2").val();

		var out_date = $("#m_out_date").val();
		var mounting_date = $("#m_mounting_date").val();
		var desorption_date = $("#m_desorption_date").val();
		var apply = $("#m_apply").val();
		//var result = $("#m_result").val();
		var result = $(":radio[name='rdo_result_yn']:checked").val();
		var type = $("#m_type").val();
		var comment_etc = $("#m_comment_etc").val();
		
		var claim_date = $('#m_claim_date').val();
		
		var claim_type = $("#m_claim_type option:selected").val();
		
		
		var file_path ='';
		var file_name = $('#m_down_one_file_name').val();
		var file_ext ='';
		var file_size ='';
		
		var t_file_path ='';
		var t_file_name = $('#m_down_two_file_name').val();
		var t_file_ext ='';
		var t_file_size ='';
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		if( recids.length==1){
			
			
			file_path = pdata.file_path;
			file_name = pdata.file_name;
			file_ext = pdata.file_ext;
			file_size = pdata.file_size;
			
			t_file_path = pdata.t_file_path;
			t_file_name = pdata.t_file_name;
			t_file_ext = pdata.t_file_ext;
			t_file_size = pdata.t_file_size;
		}
		
		data.formData = {
				
				claim_num : claim_num,
				customer_nm : customer_nm,
				customer_code : customer_code,
				item_code : item_code,
				item_nm : item_nm,
				serial_no : serial_no,
				reason : reason,
				comment1 : comment1,
				comment2 : comment2,
				claim_date : claim_date,
				file_path : file_path,
		 		file_name : file_name,
		 		file_ext : file_ext,
		 		file_size : file_size,
		 		
		 		out_date : out_date,
				mounting_date : mounting_date,
				desorption_date : desorption_date,
				apply : apply,
				result : result,
				type : type,
				comment_etc : comment_etc,
				claim_type : claim_type,
		 		
		 		t_file_path : t_file_path,
		 		t_file_name : t_file_name, 
		 		t_file_ext : t_file_ext,
		 		t_file_size : t_file_size,
		 		typeString : typeString

		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

var currentType = '';
function type(type)
{
	currentType = type;
	console.log('type : ' + type);
}
//-------------------------------------------------------------------------------------------------------------------


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