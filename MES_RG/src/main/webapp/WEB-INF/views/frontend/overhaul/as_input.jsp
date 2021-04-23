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
		<jsp:param name="selected_menu_p_cd" value="1017" />
		<jsp:param name="selected_menu_cd" value="1069" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			수리 접수 <small> Overhaul</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Overhaul </a></li>
			<li class="active">수리 접수</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box" style="margin-bottom:0px; border: none;">
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="row">
									<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
										<div class="box-header with-border" style=" background-color: #DB8EB5;">
											<h3 class="box-title">조회 조건</h3>
											<div class="box-tools pull-right">
												<button type="button" id="btn_search_csr" onclick="excelDown();" class="btn btn-info btn-sm" onclick="">엑셀다운로드</button>
												<button type="button" id="btn_search_csr" onclick="saveInfo('ins');" class="btn btn-primary btn-sm" onclick="">등록</button>
												<button type="button" id="btn_search_csr" onclick="saveInfo('upd');" class="btn btn-primary btn-sm" onclick="">수정</button>
												<button type="button" id="btn_search_csr" onclick="delInfo();" class="btn btn-danger btn-sm" onclick="">삭제</button>
												<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning  btn-sm" onclick="">조회</button>	 
											</div>
										</div>
										<div class="box-body">
											<div class="row">
												<div class="form-group">
													<div class="col-sm-2">
														<label>입고일자</label> 
														  <input type="checkbox" id="chk_eindt" name="chk_eindt" value="1" style="margin: 0px;" onchange="chgEindt();" ><!-- checked -->
														<div class="input-group">
															<input type="text" 
																class="form-control pull-right input-sm" style="" id="repair_date" placeholder="yyyymmdd~yyyymmdd">
															<div class="input-group-addon">
																<i class="fa fa-calendar"></i>
															</div>
														</div>
													</div>
													<div class="col-sm-1">
														<label>고객사명</label> <input type="text" id="customer_nm" class="form-control input-sm" placeholder="고객사명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>반입처 고객사명</label> <input type="text" id="in_customer_nm"  class="form-control input-sm" placeholder="고객사명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>반출처 고객사명</label> <input type="text" id="out_customer_nm"  class="form-control input-sm" placeholder="고객사명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>P/N</label> <input type="combo" id="req_item_code" name="req_item_code" class="form-control input-sm" placeholder="P/N"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>품명</label> <input type="combo" id="req_item_nm" name="req_item_nm" class="form-control input-sm" placeholder="품명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-1">
														<label>S/N</label> <input type="combo" id="req_sernr" name="req_sernr" class="form-control input-sm" placeholder="S/N"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
												</div>
											</div>
											<div id="grid_list" class="w2g-h600" style="margin-top: 10px;"></div>
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
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">접수번호</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_repair_num" maxlength="100">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">입고일자</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_repair_date" />	
							</div>
						</div>
					</div>
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사명</label>
							<div class="col-sm-8">
								<%-- <input type="text" class="form-control input-sm pull-right clear_val" id="m_customer_integration_nm" maxlength="10">
								<input type="hidden" class="form-control input-sm pull-right clear_val" id="m_customer_integration_code" maxlength="10"> --%>
								<select class="form-control input-sm" id="m_customer_integration_nm" name="m_customer_integration_nm" >
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">반입처</label>
							<div class="col-sm-4">
								<select class="form-control input-sm clear_val" id="m_carry_in_nm" name="m_carry_in_nm" >
								</select>
							</div>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_carry_in_land">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">반출처</label>
							<div class="col-sm-4">
								<select class="form-control input-sm clear_val" id="m_carry_out_nm" name="m_carry_out_nm" >
								</select>
							</div>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_carry_out_land">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">수리구분</label>
							<div class="col-sm-8">
								<select class="form-control input-sm clear_val" id="m_repair_class_nm" name="m_repair_class_nm" >
								</select>
							</div>
						</div>
					</div>
					
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">P/N</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_item_code">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">품명</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_item_nm">
							</div>
						</div>
					</div>
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">S/N</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_sernr">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사용일수</label>
							<div class="col-sm-5">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_using_day">
							</div>
							<div class="col-sm-3">
			                  	<button type="button" id="btn_cal" class="btn btn-primary btn-sm">자동계산</button>
			                </div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">비고</label>
							<div class="col-sm-8">
								<textarea type="text" class="form-control input-sm pull-right clear_val" id="m_repair_comment" ></textarea>
							</div>
						</div>
					</div>
				<!-- 	<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">반입요청일</label>
							 
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_carry_in_date" />	
							</div>
						</div>
					</div> -->
					
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveRepair();">저장</button>
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


comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;
comboValue_nm4 = new Array;
comboValue_nm5 = new Array;

comboValue_nm6 = new Array;

var InFindList = [];
var OutFindList = [];
var cFindList = [];


var startValue_combo = "";
var startValue_combo2 = "";

comboValue_nm_i = new Array;
comboValue_cd = new Array;

var materialArr = new Array;

$(function($) {
 	
	loadCommFn();
 	loadGrid();
 	
 	requestItem();
})
// //품명,품번 자동완성
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
 				console.log('m_item_code key_up : '+ value);
				
 				getItemInfo('cd',value);
 				return value
 			});
	
 },400));

// //품명,품번 자동완성
// $("#req_item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#req_item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('req_item_nm key_up : '+ value);
		
// 		getItemInfo2('nm',value);
// 		return value
// 	});
	
// },400));
// $("#req_item_code").change(
		
// 		_.debounce(function(event) 
// 		{
	
// 			var item_code = $("#req_item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('req_item_code key_up : '+ value);
				
// 				getItemInfo2('cd',value);
// 				return value
// 			});
	
// },400));





function loadCommFn(){
	$('#repair_date').daterangepicker({
		language: 'kr',
		opens: 'right',
		locale: {
			format : 'YYYYMMDD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
	    startDate : moment().subtract(30, 'days').format('YYYY-MM-DD'),
 	    endDate:  moment().format('YYYY-MM-DD')
	});
}

// loadLeftGrid
function loadGrid(){
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
			{ field:'repair_num', caption:'접수번호', style:'text-align:center', sortable: true},
			{ field:'repair_date', caption:'입고일자', style:'text-align:center', sortable: true},
			{ field:'customer_integration_nm', caption:'고객사명', style:'text-align:center', sortable: true},
			{ field:'customer_integration_code', caption:'고객사코드', hidden : true},
		
			{ field:'in_customer_nm', caption:'반입 고객사명', style:'text-align:center', sortable: true, hidden : true},
			{ field:'carry_in_land', caption:'반입처', style:'text-align:center', sortable: true},
			
			{ field:'out_customer_nm', caption:'반출 고객사명', style:'text-align:center', sortable: true, hidden : true},
			{ field:'carry_out_land', caption:'반출처', style:'text-align:center', sortable: true},
			{ field:'repair_class_nm', caption:'수리 구분', style:'text-align:center', sortable: true},
			{ field:'using_day', caption:'사용일', style:'text-align:center', sortable: true},
			{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},
			{ field:'sernr', caption:'S/N', style:'text-align:center', sortable: true},
			{ field:'carry_in_date', caption:'반입요청일', style:'text-align:center' , hidden : true},
			{ field:'repair_comment', caption:'비고', style:'text-align:center',sortable :true}
			
			], 
		 	sortData: [{field: 'repair_date', direction: 'desc'}],
		records: [
			], // rowArr
		onSelect: function (event) {
		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
		}
	});
	loadList();
}

function chgEindt()
{
	console.log('chgEindt()');
	
	loadList();
}
// connect server
function loadList(){

	try{
		w2ui['grid_list'].clear();
		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
	}catch(e){
		
	}
	
	var pageUrl = "/frontend/repair/selectrepairReqT";
	
	var spdate = $('#repair_date').val().split(' - ');
	var req_repair_date_start = spdate[0];
	var req_carry_date_end = spdate[1];
	var chk_eindt = $("input:checkbox[id='chk_eindt']").is(":checked")
	
	
	console.log("chk_eindt 상태는?" + chk_eindt);
	
	var inCustomerCode = $('#in_customer_nm').val();
	if($('#in_customer_nm').val() != "" && $('#in_customer_nm').val() != null){
		inCustomerCode = InFindList[inCustomerCode];
		if(inCustomerCode == 'undefined'){
			inCustomerCode = ''
		}
	}
	var outCustomerCode = $('#out_customer_nm').val();
	if($('#out_customer_nm').val() != "" && $('#out_customer_nm').val() != null){
		outCustomerCode = OutFindList[outCustomerCode];
		if(outCustomerCode == 'undefined'){
			outCustomerCode = ''
		}
	}
	var cCustomerCode = $('#customer_nm').val();
	if($('#customer_nm').val() != "" && $('#customer_nm').val() != null){
		cCustomerCode = cFindList[cCustomerCode];
		if(cCustomerCode == 'undefined'){
			cCustomerCode = ''
		}
	}
	
	var req_item_code = $('#req_item_code').val();
	var req_item_nm = $('#req_item_nm').val();
	var req_sernr = $('#req_sernr').val();
	
	var postData = "";
	
	if(chk_eindt == 'false' || chk_eindt == false)
	{
		postData = {
				//	carry_in_date_st : req_carry_date_start,
				//	carry_in_date_ed : req_carry_date_end,
					carry_in_customer_code : inCustomerCode || '',
					carry_out_customer_code : outCustomerCode || '',
					item_code : req_item_code,
					item_nm : req_item_nm,
					customer_integration_code : cCustomerCode,
					sernr : req_sernr
				}
	}else{
		postData = {
					carry_in_date_st : req_repair_date_start,
					carry_in_date_ed : req_carry_date_end,
					carry_in_customer_code : inCustomerCode || '',
					carry_out_customer_code : outCustomerCode || '',
					item_code : req_item_code,
					item_nm : req_item_nm,
					customer_integration_code : cCustomerCode,
					sernr : req_sernr
				}
	}
	
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : pageUrl,
		type : "GET",
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					row.using_day = Number(row.using_day);
					
					comboValue_nm1.push(row.in_customer_nm);
					comboValue_nm2.push(row.item_code);
					comboValue_nm3.push(row.item_nm);
					comboValue_nm4.push(row.sernr);
					comboValue_nm5.push(row.out_customer_nm);
					comboValue_nm6.push(row.customer_integration_nm);

					InFindList[row.in_customer_nm] = row.carry_in_customer_code;
					OutFindList[row.out_customer_nm] = row.carry_out_customer_code;
					cFindList[row.customer_integration_nm] = row.customer_integration_code;
				});
				w2ui.grid_list.records = rowArr;
				if (startValue_combo == "") {
					$('#in_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					$('#req_item_code').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
					$('#req_item_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
					$('#req_sernr').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
					$('#out_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm5,false) ,match : 'contains' });
					$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm6,false) ,match : 'contains' });
				}
			} else {
				w2ui.grid_list.clear();
			}
			w2ui.grid_list.refresh();
			w2ui.grid_list.unlock();
			
			
		}, complete : function(){
			startValue_combo = ":)";
			document.getElementById("in_customer_nm").style.removeProperty("height");
			document.getElementById("req_item_code").style.removeProperty("height");
			document.getElementById("req_item_nm").style.removeProperty("height");
			document.getElementById("req_sernr").style.removeProperty("height");
			document.getElementById("out_customer_nm").style.removeProperty("height");
			document.getElementById("customer_nm").style.removeProperty("height");
		}
		
	})
}

function delInfo(){
	if(w2ui.grid_list.getSelection().length == 0){
		fnMessageModalAlert("에러", "삭제하실 정보를 선택해주세요!");
		return;
	}
	fnMessageModalConfirm("알림", "접수번호 "+w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).repair_num+"를 정말로 삭제하시겠습니까?", function(result) {
		if(result){
			var postData = "repair_num="+encodeURIComponent(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).repair_num);
			$.ajax({
				url : "/frontend/repair/delRepair",
				type : 'POST',
				data : postData,
				dataType : 'json',
				success : function(data){
					if(data.status == 200){
						fnMessageModalAlert("결과", "접수건을 삭제 완료 하였습니다.");
					}else{
						fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");
					}
				},
				error : function(jqXHR, textStatus, errorThrown){
					fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다. / " + textStatus);
				}, complete : function(){
					loadList();
				}
			})
		}
	});
}

function saveInfo(value){
	$(".clear_val").val('');
	/* $('#m_carry_in_date').datepicker({
		language: 'kr',
		autoclose:true,
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		format:'yyyymmdd'
	}).on('show', function(e) {
		$('.datepicker').css('z-index', '9999');
	}); */
	$('#m_repair_date').datepicker({
		language: 'kr',
		autoclose:true,
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		format:'yyyymmdd'
	}).on('show', function(e) {
		$('.datepicker').css('z-index', '9999');
	});
	fnCdD('m_customer_integration_nm', 'MC1017');
	fnCdD('m_repair_class_nm', 'MC1018');

	if(value =='ins'){
		$('#modal_code_title').text('등록');
		$("#m_repair_num").attr('disabled',true);
		$("#btn_cal").show();
//		$('#m_carry_in_date').datepicker('setDate', moment().format('YYYY-MM-DD'));
		$('#m_repair_date').datepicker('setDate', moment().format('YYYY-MM-DD'));
		fnCusin('m_carry_out_nm', $('#m_customer_integration_nm').eq(0).val());
		fnCusin('m_carry_in_nm', $('#m_customer_integration_nm').eq(0).val());
		$('#m_carry_out_nm').val();
		$('#m_carry_in_nm').val();
		
		var m_repair_class_nm = $("#m_repair_class_nm").val();
		console.log("m_repair_class_nm------------------" +m_repair_class_nm);

	}else{
		if(w2ui.grid_list.getSelection().length == 0){
			fnMessageModalAlert("에러", "수정하실 정보를 선택해주세요!");
			return;
		}
		$('#modal_code_title').text('수정');
		$("#m_repair_num").attr('disabled',true);
		$("#btn_cal").hide();
		$("#m_repair_num").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).repair_num);
		$("#m_using_day").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).using_day);
		$("#m_item_code").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).item_code);
		$("#m_sernr").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).sernr);
//		$('#m_carry_in_date').datepicker('setDate', changeDate(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).carry_in_date));
		$('#m_repair_date').datepicker('setDate', changeDate(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).repair_date));
		$("#m_item_nm").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).item_nm);
		
		value2 = w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).customer_integration_code;
		fnCusin('m_carry_out_nm', value2);
		fnCusin('m_carry_in_nm', value2);
		/* fnCusin2('m_carry_out_land', w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).carry_out_customer_code);
		fnCusin2('m_carry_in_land', w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).carry_in_customer_code);
		 */
		$("#m_carry_out_land").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).carry_out_land);
		$("#m_carry_in_land").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).carry_in_land);
		$("#m_customer_integration_nm option[value='"+w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).customer_integration_code+"']").attr("selected", true);	
		$("#m_carry_out_nm option[value='"+w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).carry_out_customer_code+"']").attr("selected", true);	
		$("#m_carry_in_nm option[value='"+w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).carry_in_customer_code+"']").attr("selected", true);	
		$("#m_repair_class_nm option[value='"+w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).repair_class_code+"']").attr("selected", true);	
		$("#m_repair_comment").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).repair_comment);
	
	}
	$("#modal_info").modal('show');
}

$( "#btn_cal" ).on('click', function(e) {
	
	fnCalculation();
});

function fnCalculation(){
	console.log('fnCalculation()');
	
	var sernr = $('#m_sernr').val();
	var repair_date = $('#m_repair_date').val();
	
	if(!chkSubmit($("#m_sernr"), "S/N 을")) return;
	
	if(!chkSubmit($("#m_repair_date"), "입고일자를")) return;
	
	
  	var pageUrl = "/frontend/repair/selectrepairUsingDay";
  	var postData = "sernr=" + encodeURIComponent(sernr)
  				+ "&repair_date=" + encodeURIComponent(repair_date);
  	
  
  $.ajax({
      url : pageUrl,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
//	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					$("#m_using_day").val(row.using_day);
				});
				
	    	} 
	    	
	    },
      error: function(jqXHR, textStatus, errorThrown){
    	  
      }
	    
  });
}

$('#m_customer_integration_nm').change(function(){
	var value = $(this).val();
	fnCusin('m_carry_out_nm', value);
	fnCusin('m_carry_in_nm', value);
/* 	fnCusin2('m_carry_out_land', $('#m_carry_out_nm').val());
	fnCusin2('m_carry_in_land', $('#m_carry_in_nm').val()); */
})
/* $('#m_carry_out_nm').change(function(){
	var value = $(this).val();
	fnCusin2('m_carry_out_land', value);
})
$('#m_carry_in_nm').change(function(){
	var value = $(this).val();
	fnCusin2('m_carry_in_land', value);
}) */

function fnCusin(val, val2){
	$('#m_carry_in_land').find('option').remove();
	$('#m_carry_out_land').find('option').remove();
	/* if(val2 == 'MD1525'){
		val2 = '';
	} */
	var strUrl = "/frontend/repair/findinout";
	var postData = "customer_integration_code="+encodeURIComponent(val2);
	initOptions($('#'+val));
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200" && (data.rows).length>0) {
	    		rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					$("#"+val ).append("<option value=" + row.customer_code + ">" + row.customer_nm + "</option>");
				});
				
	 			$("#"+val+" option:eq(0)").prop("selected", true);	
	    	} 
		},
		  error: function(jqXHR, textStatus, errorThrown){
	    },
	    complete: function() {
	    }
	})
}
function fnCusin2(val, val2){
	var strUrl = "/frontend/repair/findinout";
	var postData = "customer_code="+encodeURIComponent(val2);
	initOptions($('#'+val));
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200" && (data.rows).length>0) {
	    		rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					$("#"+val ).append("<option value=" + row.customer_code + ">" + row.land + "</option>");
				});
				
	 			$("#"+val+" option:eq(0)").prop("selected", true);	
	    	} 
		},error: function(jqXHR, textStatus, errorThrown){
		    //	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	})
}

function saveRepair(){
	var repair_num = $('#m_repair_num').val();
	var using_day = $('#m_using_day').val();
	var item_nm = $('#m_item_nm').val();
	var item_code = $('#m_item_code').val();
	var sernr = $('#m_sernr').val();
	var repair_comment = $('#m_repair_comment').val();
	// var carry_in_date = $('#m_carry_in_date').val();
	var repair_date = $('#m_repair_date').val();
	var customer_integration_nm = $('#m_customer_integration_nm').val();
	var carry_out_customer_code = $('#m_carry_out_nm').val();
	var carry_in_customer_code = $('#m_carry_in_nm').val();
	var repair_class_code = $('#m_repair_class_nm').val();
	var repair_class_nm = $('#m_repair_class_nm').find("option[value='" +  $('#m_repair_class_nm').val() + "']").text();
	var carry_out_land = $('#m_carry_out_land').val();
	var carry_in_land = $('#m_carry_in_land').val();
	/* 
	if(repair_num == '' || repair_num == null){
		fnMessageModalAlert("알림", "접수번호를 입력해주세요.");
		return;
	} */
	
	if(repair_date == '' || repair_date == null){
		fnMessageModalAlert("알림", "입고일자를 입력해주세요.");
		return;
	}
	if(using_day == '' || using_day == null){
		fnMessageModalAlert("알림", "사용일수를 입력해주세요.");
		return;
	}
	if(item_nm == '' || item_nm == null){
		fnMessageModalAlert("알림", "품명을 입력해주세요.");
		return;
	}
	if(item_code == '' || item_code == null){
		fnMessageModalAlert("알림", "없는 제품입니다. 등록 후 이용해주세요");
		return;
	}
	if(sernr == '' || sernr == null){
		fnMessageModalAlert("알림", "S/N를 입력해주세요.");
		return;
	}
	if(carry_in_land == '' || carry_in_land == null){
		fnMessageModalAlert("알림", "반입처 위치를 입력해주세요.");
		return;
	}
	if(carry_out_land == '' || carry_out_land == null){
		fnMessageModalAlert("알림", "반출처 위치를 입력해주세요.");
		return;
	}
	/* if(carry_in_date == '' || carry_in_date == null){
		fnMessageModalAlert("알림", "반입요청일을 입력해주세요.");
		return;
	} */
	var strUrl;

	if($('#modal_code_title').text() == '등록'){
		strUrl = "/frontend/repair/insRepair";
	}else{
		strUrl = "/frontend/repair/modRepair";
	}
	var postData = "repair_num="+encodeURIComponent(repair_num)
				   +"&using_day="+encodeURIComponent(using_day)
				   +"&item_nm="+encodeURIComponent(item_nm)
				   +"&item_code="+encodeURIComponent(item_code)
				   +"&sernr="+encodeURIComponent(sernr)
				/*    +"&carry_in_date="+encodeURIComponent(carry_in_date) */
				   +"&repair_date="+encodeURIComponent(repair_date)
				   +"&customer_integration_nm="+encodeURIComponent(customer_integration_nm)
				   +"&carry_out_customer_code="+encodeURIComponent(carry_out_customer_code)
				   +"&carry_in_customer_code="+encodeURIComponent(carry_in_customer_code)
				   +"&repair_class_code="+encodeURIComponent(repair_class_code)
				   +"&repair_class_nm="+encodeURIComponent(repair_class_nm)
				   +"&carry_out_land="+encodeURIComponent(carry_out_land)
				   +"&carry_in_land="+encodeURIComponent(carry_in_land)
	 				 +"&repair_comment="+encodeURIComponent(repair_comment);
	
	FunLoadingBarStart();
	$.ajax({
		url : strUrl,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200){
				fnMessageModalAlert("결과", "등록에 성공하셨습니다.");
			}else if (data.status == 500 && data.msg == 'fall'){
				fnMessageModalAlert("결과", "이미 존재하는 값은 등록이 불가능합니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");
		}, complete : function(){
			loadList();
			$("#modal_info").modal('hide');
			
			FunLoadingBarEnd();
		}
	});

}


function fnCdD(val, val2){
	initOptions($('#'+val));
	
	console.log(val2);
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent(val2);
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, 
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0) {
	    		rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
				});
	 			$("#"+val+" option:eq(0)").prop("selected", true);	
	    	} 
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
}

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

// function getItemInfo2(type, value)
// {
// 	console.log('getItemInfo2() : ' + value);
// 	var result = "";
// 	if(type == 'cd')
// 	{
// 		$.each(materialArr, function(idx, row){
			
// 			if(value == row.item_code)
// 			{
// 				console.log('row.item_nm : ' + row.item_nm);
// 				result = row.item_nm;		
// 				$("#req_item_nm").val(result);
// 			}
// 		});

// 		if(result == ''){
// 			$("#req_item_nm").val('');
// 		}
		
// 	}else if(type == 'nm')
// 	{
		
// 		$.each(materialArr, function(idx, row){
			
// 			if(value == row.item_nm)
// 			{
// 				console.log('row.item_code : ' + row.item_code);
// 				result = row.item_code;
// 				$("#req_item_code").val(result);
// 			}
// 		});
// 		if(result == ''){
// 			$("#req_item_code").val('');
// 		}
		
// 	}

	
	
// }

function initOptions(obj) {
    $(obj)
    .find('option')
    .remove()
    .end()
    .val();
}

function excelDown(){
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '수리 접수.xlsx';
	var sheetTitle = '수리 접수';
	var sheetName = 'Overhaul';
	
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

function changeDate(someDate){
	var yyyy = someDate.substr(0,4);
    var mm = someDate.substr(4,2);
    var dd = someDate.substr(6,2);
	return yyyy+"-"+mm+"-"+dd;
}

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