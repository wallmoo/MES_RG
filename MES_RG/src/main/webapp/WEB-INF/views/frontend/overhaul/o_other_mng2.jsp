<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
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
		<jsp:param name="selected_menu_p_cd" value="1017" />
		<jsp:param name="selected_menu_cd" value="1082" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	 외주 발주 현황
        <small>Overhaul</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Overhaul</a></li><li class="active">외주 발주 현황</li>
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
							<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							<button type="button" id="btn_search_csr" onclick="accountModal();" class="btn btn-info btn-sm btn_in">거래처명 수정</button>
	                        <button type="button" id="btn_search_csr_in" onclick="registerIn();" class="btn btn-info btn-sm btn_in">입고</button><!-- loadList(); -->    
	                        <button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->    
	                    </div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div id="date_parent" class="col-sm-2">
								<div class="form-group">
								<label>발주일자</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="delivery_request_date" placeholder="yyyymmdd~yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-sm-1">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>진행상태</label>
									<select id="current_status" name="current_status" class="form-control" style="height: 30px;" onchange="checkStatus();">
									 	<option value="B">진행</option>
									 	<option value="A">완료</option>
									</select>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>거래처코드</label> <input type="text" id="proc2_account_code" name="proc2_account_code" placeholder="ex) 거래처코드"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>거래처명</label> <input type="text" id="proc2_account_nm" name=proc2_account_nm placeholder="ex) 거래처명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
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
						</div>
						<div id="grid_list" style="width: 100%; height: 600px;"></div>
					</div>
				</div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  
  <div class="modal fade" id="modal_info2" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:30%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">거래처명 수정</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
			
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">접수번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_repair_num" >
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_account_nm" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_account_code" >
							</div>
						</div>
					</div>
					
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAccount();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


  
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-12" style="padding: 0px;">
					<h4 class="modal-title" >입고</h4>
				</div>
				<div class="col-md-12" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<input type="hidden" class="clear_field" id="mod_repair_num"/>
					<div class="form-group row">
						<div class="col-sm-12">
							<div class="row">
								<label for="" class="col-sm-11 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">2. 세정</label>
							</div>
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label ">상태</label>
									<div class="col-sm-7">
										<input class="form-control clear_field" id="mod_status2" disabled="disabled"/>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label ">처리일자</label>
									<div class="col-sm-7">
								
											<input type="text" class="form-control clear_field dp_component_d"
													id="mod_proc2_date">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label ">외주입고단가</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right" id="m_outsourcing_price" onKeypress="onlyNumber();" style="IME-MODE:disabled;">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label ">담당자</label>
									<div class="col-sm-7">
										<input class="form-control clear_field" id="mod_proc2_manager_nm"/>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label ">첨부파일</label>
									<div class="col-sm-6">
										<input type="text" id="mod_proc2_file_name" name="mod_proc2_file_name" class="form-control input-sm clear_field" readonly>
										<input type="hidden" id="mod_proc2_file_group" name="mod_proc2_file_group" class="form-control input-sm clear_field">
									</div>
									<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
										<span class="btn btn-success btn-sm fileinput-button " style="" id="file_btn2"> <i class="fa fa-plus"></i>
											<input id="file_group2" type="file" class="fileupload clear_field" data-cd = 'MD1272' data-num = 'proc2' name="file2">
										</span>
									</div>
									<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
										<span class="btn btn-danger btn-sm filedelete-button " style=" " id="file_dbtn2" data-cd = 'MD1272' data-num = 'proc2'> <i class="fa fa-minus"></i>
										</span>
									</div>
								</div>
							</div>
							
						</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="close_mod" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>





<!--  -->
  
</div>
<!-- ./wrapper -->

<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>

<script type="text/javascript">

var memberId =  "<%=memberId%>";
var memberNm =  "<%=memberNm%>";

var startValue_combo = "";
comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;
comboValue_nm4 = new Array;

var gProcNm = {
		'MD1271' : '입고검사',
		'MD1272' : '세정',
		'MD1273' : '반조립',
		'MD1274' : '중간검사',
		'MD1275' : '최종검사',
		'MD1276' : '수리완료보고서'
}

$(function($) {
	
 	fnLoadCommonOption(); 	 

 	init_grid_list();
 	
 	loadList();
 	
 	fnLoadFileHandler();
 	
 	requestAccount();
 
})

$("#delivery_request_date").change(function(){
		loadList();
	});
	


//품명,품번 자동완성
// $("#item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('item_nm key_up : '+ value);
		
// 		getItemInfo('nm',value);
// 		return value
// 	});
	
// },400));

// $("#item_code").change(
		
// 		_.debounce(function(event) 
// 		{
	
// 			var item_code = $("#item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('item_code key_up : '+ value);
				
// 				getItemInfo('cd',value);
// 				return value
// 			});
	
// },400));

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
 		
 		
 		
 		$('#delivery_request_date').daterangepicker({
			opens: 'right',
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		     startDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(-7, 'days') ,
   endDate: moment(minDate) 

		}); 
 		
 		var currentDate = getTimeStamp();
		
 		$('.dp_component_d').daterangepicker(
				{
					opens : 'right',
					singleDatePicker : true,
				     timePicker: true,
				      timePicker24Hour:true,
					locale : {
						format : 'YYYY-MM-DD HH:mm:ss', //'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
						showMonthAfterYear : true,
						yearSuffix : '년',
						orientation : "top left"
					},
						startDate : moment(currentDate).format('YYYY-MM-DD HH:mm:ss')
					
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

$('#close_mod').on('click',function(){
	//location.reload();
	
	loadList();
})

function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : true,
            footer: true,
            selectColumn: true
        },
        multiSelect: false,
        columnGroups : [
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 26, caption: '중간검사' },
         
        ],
        
        
        columns: [                
			{ field:'repair_num', caption:'접수번호', style:'text-align:center', sortable: true},
			{ field:'repair_date', caption:'입고일자', style:'text-align:center', sortable: true, hidden : true},
		
			{ field:'proc2_request_date', caption:'발주일자 (외주)', style:'text-align:center', sortable: true},
			{ field:'proc2_date_ymd', caption:'입고일자 (외주)', style:'text-align:center', sortable: true},
			{ field:'diff_time', caption:'TAT', style:'text-align:center', sortable: true},
			{ field:'proc2_account_nm', caption:'거래처명', style:'text-align:center', sortable: true},
			{ field:'proc2_account_code', caption:'거래처명', style:'text-align:center', sortable: true, hidden:true},
			{ field:'customer_integration_nm', style:'text-align:center', caption:'고객사명' , sortable: true},
			
			{ field:'carry_in_customer_code', caption:'반입처 코드', hidden : true},
			{ field:'in_customer_nm', caption:'반입 고객사명', style:'text-align:center', hidden : true},
			{ field:'carry_in_land', caption:'반입처', style:'text-align:center', sortable: true},
			{ field:'carry_out_customer_code', caption:'반출처 코드', hidden : true},
			{ field:'out_customer_nm', caption:'반출 고객사명', style:'text-align:center', hidden : true},
			{ field:'carry_out_land', caption:'반출처', style:'text-align:center', sortable: true},
			
			
			
			{ field:'repair_class_nm', caption:'수리 구분', style:'text-align:center', sortable: true},
			{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},
			{ field:'sernr', caption:'S/N', style:'text-align:center', sortable: true},
			{ field:'proc2_outsourcing_price', caption:'외주입고단가', style:'text-align:center', sortable: true},
			//중간검사 6개
			{ field:'proc1_file_down', caption:'입고검사', style:'text-align:center', sortable: true},
			{ field:'proc1_file_name', hidden: true, style:'text-align:center'},
			{ field:'proc1_file_group', hidden : true, style:'text-align:center'},
			{ field:'status1', caption:'등록1', hidden : true},
			{ field:'proc1_manager_nm', caption:'담당자1', hidden : true},
			
			{ field:'proc2_file_down', caption:'세정', style:'text-align:center', sortable: true},
			{ field:'proc2_file_name', hidden : true, style:'text-align:center'},
			{ field:'proc2_file_group', hidden : true, style:'text-align:center'},
			{ field:'status2', caption:'등록2',  hidden : true},
			{ field:'proc2_manager_nm', caption:'담당자2', hidden : true},
			
			
			
			
			{ field:'success_status', caption:'finish', hidden : true}
			], 
	
		records: [
			], // rowArr
		onSelect: function (event) {
			 event.onComplete = function () {
				console.log("onSelect");
				
				
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				if(data.proc6_file_name != '')
				{
					$("#btn_cancel").show();
					$("#btn_out").show();
				}else
				{
					$("#btn_cancel").hide();
					$("#btn_out").hide();
				}
				
			}

		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});

}

//-------------------------------------------------------------------------------------------------------------------


function registerIn(){
	console.log('registerIn()');
	
	var key = w2ui.grid_list.getSelection();
	
	if( key.length==1 ) {
			// update
		 	var data = w2ui.grid_list.get(key[0]);
			
			$("#mod_repair_num").val(data.repair_num);
			$("#m_outsourcing_price").val(data.proc2_outsourcing_price);
			$("#mod_status2").val('진행전');
			$("#mod_proc2_manager_nm").val('');
			
			$("#modal_info").modal('show'); 
		} else {
			fnMessageModalAlert("알림", "등록하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
}
//저장
function saveIn() {
	console.log('saveIn()');

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var product_po = data.product_po;
	var routing_code = data.routing_code;
	var prod_menge = 	data.req_prod_menge;
	var req_prod_menge = data.req_prod_menge;
	var prod_fail_menge = '';
	var warehouse_gubun = data.warehouse_gubun;
	
	//if(!chkSubmit($("#m_prod_menge"), "입고수량을")) return;
	
	/* if( Number(prod_menge) > Number(req_prod_menge) ){
		prod_fail_menge  = 0;
	}else {
		prod_fail_menge = Number(req_prod_menge) - Number(prod_menge);
	} */
	
	
	
	prod_fail_menge = data.prev_prod_fail_menge;
	
	if(prod_fail_menge == 'null' || prod_fail_menge == '' || prod_fail_menge == null)
	{
		prod_fail_menge = 0;
	}
	
	console.log('prod_menge:' +prod_menge);
	console.log('req_prod_menge:' +req_prod_menge);
	console.log('prod_fail_menge:' +prod_fail_menge);
	
	$("#modal_info").modal('hide');
	var member_nm = memberNm;
	var strUrl = "/frontend/consumable/updateProductOperationOS_END";
	var postData = "routing_code=" + encodeURIComponent(routing_code)
	+ "&product_po=" + encodeURIComponent(product_po)
				+ "&warehouse_gubun=" + encodeURIComponent(warehouse_gubun)
			+ "&prod_menge=" + encodeURIComponent(prod_menge)
			+ "&req_prod_menge=" + encodeURIComponent(req_prod_menge)
			+ "&prod_fail_menge=" + encodeURIComponent(prod_fail_menge)
				+ "&member_nm=" + encodeURIComponent(member_nm);
			 
	// escape(
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

var gridDataArr;
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
	
	
	
	var current_status  = $("#current_status option:selected").val();
	var item_code = $('#item_code').val();
	var item_nm = $('#item_nm').val();
	var proc2_account_nm = $("#proc2_account_nm").val();
	var proc2_account_code = $("#proc2_account_code").val();
	var proc2_request_date = $("#delivery_request_date").val();
	
	var page_url = "/frontend/repair/selectrepairOther";
	
	if(current_status == 'A'){
		$("#btn_search_csr_in").hide();
	}else{
		$("#btn_search_csr_in").show();
	}
	
	console.log("current_status? " + current_status);

	var postData = "item_code=" + encodeURIComponent(item_code)
			+ "&current_status=" + encodeURIComponent(current_status)
			+ "&proc2_account_nm=" + encodeURIComponent(proc2_account_nm)
			+ "&proc2_account_code=" + encodeURIComponent(proc2_account_code)
			+ "&proc2_request_date=" + encodeURIComponent(proc2_request_date)
			+ "&item_nm=" + encodeURIComponent(item_nm);
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
					row.proc1_file_down = '<a href="/file/attach_download?file_path=' + row.proc1_file_path +'&file_name=' + encodeURIComponent(row.proc1_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc1_file_name+ '</i>'
					if(!row.proc2_file_group) row.status2 = '등록전';
					else {
						row.proc2_file_down = '<a href="/file/attach_download?file_path=' + row.proc2_file_path +'&file_name=' + encodeURIComponent(row.proc2_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc2_file_name+ '</i>'
						row.status2 = "등록후";
					}
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.proc2_account_code);
						comboValue_nm4.push(row.proc2_account_nm);
					}
					
					row.proc2_outsourcing_price = Number(row.proc2_outsourcing_price);
					
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
			$('#proc2_account_code').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#proc2_account_nm').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			

		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("proc2_account_code").style.removeProperty("height");
			document.getElementById("proc2_account_nm").style.removeProperty("height");
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

	var fileName = '외주관리.xlsx';
	var sheetTitle = '외주관리';
	var sheetName = '외주관리';
	
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

function checkStatus(){
	
	
	var status =   $("#current_status").val();
	console.log('checkStatus() : ' + status);
	
	if(status == 'A'){
		$(".btn_in").hide();
	}else {
		$(".btn_in").show();
	}
	
	loadList();
}

//key 누를때 숫자만 가능하도록.
function onlyNumber(){

     if((event.keyCode<48)||(event.keyCode>57))

        event.returnValue=false;

}

function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/file/repairReport/"  + $(this).attr('data-num'),
		dataType : 'json',
		autoUpload : true,
		enctype : "multipart/form-data",
 		//acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 30720000, 
		add: function(e, data){
			console.log('fileupload');
			if(data.files[0].size > 30720000)
			{
				fnMessageModalAlert("알림", "파일 용량이 너무 큽니다.");
				return;
			}
			var procNum = $(this).attr('data-num');
			var strNum = procNum.slice(-1);
			var procCd = $(this).attr('data-cd');
			console.log('strNum :' + strNum);
			
			if(procNum == 'proc2'){
				fnMessageModalConfirm('알림', '파일 업로드를 진행하시겠습니까?',function(chk){
					if(chk){
						
				
						var repairNum = $('#mod_repair_num').val() || '';
						

						var outsourcing_price = $('#m_outsourcing_price').val();
				
						
						var insDate = $('#mod_proc2_date').val();
						var proManager = $('#mod_proc2_manager_nm').val();
						
						if(!insDate){
							fnMessageModalAlert("알림", "등록일자는 필수 입니다.");
							return false;
						}
						if(!repairNum){
							fnMessageModalAlert("알림", '수리 접수 번호가 없습니다. 등록창을 다시 띄워 주세요.');
							return false;
						}
						if(!proManager){
							fnMessageModalAlert("알림", "담당자를 입력해주세요.");
							return false;
						}
						
						if(!outsourcing_price){
							fnMessageModalAlert("알림", "외주입고단가를 입력해주세요.");
							return false;
						}
						$('#mod_proc2_file_name').val(data.files[0].name);
					
						data.url = '/file/repairReport/' + procCd;
						data.formData = {
							proc_date : insDate,
							file_repo : gProcNm[procCd],
							repair_num : repairNum,
							proc_manager_nm : proManager,
							proc2_outsourcing_price : outsourcing_price
						}
					
						data.submit();
					}
				})
			} else {
				var procCd = $(this).attr('data-cd');
				var repairNum = $('#mod_repair_num').val() || '';
				
		
				
				//var insDate = $('#mod_'+procNum+'_date').val().replace(/-/gi,'');
				var insDate = $('#mod_proc2_date').val();
				var proManager = $('#mod_proc2_manager_nm').val();
				
				if(!insDate){
					fnMessageModalAlert("알림", "등록일자는 필수 입니다.");
					
					return false;
				}
				if(!repairNum){
					fnMessageModalAlert("알림", '수리 접수 번호가 없습니다. 등록창을 다시 띄워 주세요.');
					$('#mod_proc2_file_name').val('');
					return false;
				}
				if(!proManager){
					fnMessageModalAlert("알림", "담당자를 입력해주세요.");
					return false;
				}
				
				if(!outsourcing_price){
					fnMessageModalAlert("알림", "외주입고단가를 입력해주세요.");
					return false;
				}
				
				$('#mod_proc2_file_name').val(data.files[0].name);
				
				data.url = '/file/repairReport/' + procCd;
				
				data.formData = {
					proc_date : insDate,
					file_repo : gProcNm[procCd],
					repair_num : repairNum,
					proc_manager_nm : proManager,
					proc2_outsourcing_price : outsourcing_price
				}
				
				data.submit();
			}
		},
	}).on('fileuploadadd', function(e, data) {
		
		
		console.log('fileuploadadd');
	}).on('fileuploadprocessalways', function(e, data) {
		console.log('always')
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Error", file.error);
		}
	}).on('fileuploadprogressall', function(e, data) {
		 
		$('#progress').show();
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		console.log('fileuploaddone');
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		var procNum = $(this).attr('data-num'); 
	
		$('#mod_' + procNum + 'file_name').val(data.files[0].name);
    	
    	if(procNum == 'proc6') location.reload();
    	
		$('#file_group'+ (eval(procNum.substring(4).concat( '+ 1')))).attr('disabled', false);
		$('#file_btn'+ (eval(procNum.substring(4).concat( '+ 1')))).attr('disabled', false);
    	
    	
	}).on('fileuploadfail', function(e, data) {
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}



////////////////////거래처변경부분//////////////////////////////

$("#m_account_nm").change(_.debounce(function(event) {
	
	var customer_nm = $("#m_account_nm").val();
	$(this).val(function(index, value) {
		console.log('m_account_nm key_up : '+ value);
		
		getaccountInfo('nm',value);
		return value
	});
	
	
	
},400));
$("#m_account_code").change(_.debounce(function(event) {
	
	var customer_code = $("#m_account_code").val();
	$(this).val(function(index, value) {
		console.log('customer_code key_up : '+ value);
		
		getaccountInfo('cd',value);
		return value
	});
	
},400));

var startValue_combo2 = "";
comboValue_nm = new Array;
comboValue_ct = new Array;

var accountArr = new Array;
function requestAccount() {
	console.log("requestAccount()");
	
	var page_url = "/info/account/selectAccount";
/* 	var postData = "account_code=" + encodeURIComponent($("#account_code").val())
		 + "&account_nm=" + encodeURIComponent($("#account_nm").val());
	 */
	
	$.ajax({
		url : page_url,
		type : 'POST',
		//data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				accountArr = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if (startValue_combo2 == "") {
						comboValue_nm.push(row.account_nm ? row.account_nm+'' : '');
						comboValue_ct.push(row.account_code);
					}
				});
				console.log("comboValue_nm :" +comboValue_nm);
				console.log("comboValue_ct :" +comboValue_nm);
				
				if (startValue_combo2 == "") {
					$('#m_account_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });	
					$('#m_account_code').w2field('combo', { items: _.uniq(comboValue_ct,false) ,match : 'contains' });		
				
				}
			} else {
	
			}

		},complete: function () {
			startValue_combo2 = ":)";
		}
	});
	
}



function getaccountInfo(type, value)
{
	console.log('getaccountInfo() : ' + value);
	var result = "";
	if(type == 'cd')
	{
		$.each(accountArr, function(idx, row){
			
			console.log('row.account_code: '+ row.account_code);
			if(value == row.account_code)
			{
				result = row.account_nm;
				console.log('result: '+ result);
				$("#m_account_nm").val(result);
			}
			
		});
		
		if(result == ''){
			$("#m_account_nm").val('');
		}
		
	}else if(type == 'nm')
	{
		
		$.each(accountArr, function(idx, row){
			
			if(value == row.account_nm)
			{
				result = row.account_code;
				$("#m_account_code").val(result);
			}
		});
		
		if(result == ''){
			$("#m_account_code").val('');
		}
	}

}


function accountModal(){
	console.log('accountModal()');
	
	var key = w2ui.grid_list.getSelection();
	
	if( key.length==1 ) {
			var data = w2ui.grid_list.get(key[0]);
			
			$("#m_account_nm").val(data.proc2_account_nm);
			$("#m_account_code").val(data.proc2_account_code);
			$("#m_repair_num").val(data.repair_num);
			
			$("#m_repair_num").attr('disabled', true);
			
			
			$("#modal_info2").modal('show');
		} else {
			fnMessageModalAlert("알림", "변경하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
}
function saveAccount() {
	console.log('saveAccount()');
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var repair_num = data.repair_num;
	
	var proc2_account_nm = $("#m_account_nm").val();
	var proc2_account_code = $("#m_account_code").val();
	
	if(!chkSubmit($("#m_account_nm"), "거래처명을")) return;
	
	
	$("#modal_info2").modal('hide');
	
	var strUrl = "/frontend/repair/updateRepairOrder2";
	
	var postData = "proc2_account_nm=" + encodeURIComponent(proc2_account_nm)
			+ "&proc2_account_code=" + encodeURIComponent(proc2_account_code)
			+ "&repair_num=" + encodeURIComponent(repair_num);
			 
	// escape(
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

// function getItemInfo(type, value)
// {
// 	console.log('getItemInfo() : ' + value);
// 	var result = "";
// 	if(type == 'cd')
// 	{
// 		$.each(gridDataArr, function(idx, row){
			
// 			if(value == row.item_code)
// 			{
// 				console.log('row.item_nm : ' + row.item_nm);
// 				result = row.item_nm;		
// 				$("#item_nm").val(result);
// 			}
// 		});

// 		if(result == ''){
// 			$("#item_nm").val('');
// 		}
		
// 	}else if(type == 'nm')
// 	{
		
// 		$.each(gridDataArr, function(idx, row){
			
// 			if(value == row.item_nm)
// 			{
// 				console.log('row.item_code : ' + row.item_code);
// 				result = row.item_code;
// 				$("#item_code").val(result);
// 			}
// 		});
// 		if(result == ''){
// 			$("#item_code").val('');
// 		}
		
// 	}

// }

//엑셀 1024
	function excelFileDownload()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;

		var fileName = '외주발주현황.xlsx';
		var sheetTitle = '외주발주현황';
		var sheetName = '외주발주현황';
		
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

function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}
	
function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
}

</script>

</body>
</html>