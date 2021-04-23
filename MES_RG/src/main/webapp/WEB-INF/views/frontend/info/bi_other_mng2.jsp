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
    		
    	#account_nm{
    	    height: 30px !important;
    	}
    	#item_code{
    	    height: 30px !important;
    	}
    	#item_nm{
    	    height: 30px !important;
    	}
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
		<jsp:param name="selected_menu_cd" value="1073" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	 외주 발주 현황
        <small>구매/자재관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 구매/자재관리</a></li><li class="active">외주 발주 현황</li>
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
	                        <button type="button" id="btn_search_csr" onclick="registerIn();" class="btn btn-info btn-sm btn_in">입고</button><!-- loadList(); -->    
	                        <button type="button" id="btn_update" onclick="update_bom();" class="btn btn-info btn-sm btn_in">수정</button>
	                        <button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->    
	                  
	                    </div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div id="date_parent" class="col-sm-2">
								<div class="form-group">
								<label>납품요청일</label>
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
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="s_type" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onchange=" checkStatus();">
											<option value="n">진행전</option>
											<option value="p">진행</option>
											<option value="e">완료</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>거래처명</label> <input type="text" id="account_nm" name="account_nm" placeholder="ex) 거래처명"
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
							
	<!-- 						<div class="col-sm-1">
								<div class="form-group">
									<label>작업지시 번호</label> <input type="text" id="product_po" name="product_po" placeholder="ex) 작업지시 번호"
									 class="form-control input-sm" />
								</div>
							</div> -->
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>의뢰 공정</label> <input type="text" id="routing_nm" name="routing_nm" placeholder="ex) 의뢰공정"
									 class="form-control input-sm" maxlength="100" />
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


 
  
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">발주등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">입고수량</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_prod_menge" onKeypress="onlyNumber();" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveIn();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 입고처리 모달 -->
<div class="modal fade" id="modal_out" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title" >입고</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label ">외주입고단가</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_outsourcing_price" onKeyUp="totalCount();"  onKeypress="onlyNumber();" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label ">발주수량</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_req_prod_menge"  onKeypress="onlyNumber();" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label ">총금액</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_total_price"  onKeypress="onlyNumber();" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="savePw" class="btn btn-success btn-sm" onclick="saveIn();">저장</button>
					<button type="button"  class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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

var memberId =  "<%=memberId%>";
var memberNm =  "<%=memberNm%>";

// var startValue_combo = "";
// comboValue_nm1 = new Array;
// comboValue_nm2 = new Array;
// comboValue_nm3 = new Array;
// comboValue_nm4 = new Array;

$(function($) {
	$("#btn_update").attr('disabled', true);
	$("#s_type").val("p").prop("selected", true);
 	fnLoadCommonOption(); 	 

 	init_grid_list();
 	
 	loadList();
 
})

function update_bom() {
		console.log('updateWarehouse()');
		
		/* $("#modal_info > .input-sm").val(''); */
		
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			var data = w2ui.grid_list.get(key[0]);
			
			$("#m_outsourcing_price").val(data.outsourcing_price);
			$("#m_req_prod_menge").val(data.req_prod_menge);
			$("#m_req_prod_menge").attr('disabled', true);
			$("#m_total_price").val((data.outsourcing_price)*(data.req_prod_menge));
			totalCount();
			$("#m_total_price").attr('disabled', true);
			
			
			$("#btn_check").hide();
			$("#fg_check_yn").val("Y");
			
			

			
		
			
			$("#modal_out").modal('show'); 
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	

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
		    startDate: moment(minDate).add(-30, 'days'),
   			endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(7, 'days') 

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
				{ field:'product_po', caption:'작업지시 번호', size:'10%', style:'text-align:center',sortable :true}, // 80px
		         { field:'routing_nm', caption:'의뢰 공정', size:'10%', style:'text-align:center',sortable :true},
		         { field:'routing_code', caption:'의뢰 공정', size:'10%', style:'text-align:center', hidden:true},
		         { field:'warehouse_gubun', caption:'구분', size:'10%', style:'text-align:center', hidden:true},
		         { field:'item_code', caption:'P/N', size:'15%', style:'text-align:center',sortable :true},// 200px
		         { field:'item_nm', caption:'품명', size:'25%', style:'text-align:center',sortable :true}, // 120px
		         { field:'outsourcing_price', caption:'외주입고단가', size:'10%', style:'text-align:center',sortable :true}, 
		         { field:'prev_prod_menge', caption:'요청수량', size:'10%', style:'text-align:center',sortable :true},
		         { field:'account_nm', caption:'거래처명', size:'10%', style:'text-align:center',sortable :true},
		         { field:'account_code', caption:'거래처명', size:'10%', style:'text-align:center', hidden:true},
		         { field:'req_prod_menge', caption:'발주수량', size:'10%', style:'text-align:center',sortable :true},
		         { field:'prod_menge', caption:'입고수량', size:'10%', style:'text-align:center', hidden:true},
		         { field:'prev_prod_fail_menge', caption:'요청실패수량', size:'10%', style:'text-align:center', hidden:true},
		         { field:'end_date', caption:'납품일자', size:'10%', style:'text-align:center',sortable :true}
		], 
	
		records: [
		/* 	{recid : 1, customer_code:'Berlin-SS054', customer_nm:'Alfreds Futterkiste​', ceo_nm: 'Maria Anders',
				business_reg_num:'Berlin', address:'1', manager_nm:'A',
				telf1:'2', email_address:'@', telf2:'030-0074321​'
			} ,
			{recid : 2, customer_code:'Moreno-SQ074', customer_nm:'Antonio Moreno Taquería​', ceo_nm: 'Antonio Moreno​',
				business_reg_num: 'México D.F', address:'1', manager_nm: 'B',
				telf1:'3', email_address:'@', telf2:'(5) 555-3932'
			},
			{recid : 3, customer_code:'Daerim-00001', customer_nm:'Around the Horn​', ceo_nm:'Thomas Hardy​',
				business_reg_num: 'London​', address:'1', manager_nm:'C',
				telf1:'4', email_address:'@', telf2:'(171) 555-7788'
			},
			{recid : 4, customer_code:'Daerim-00001', customer_nm:'Berglunds snabbköp​', ceo_nm:'Christina Berglund​​',
				business_reg_num: 'Luleå​​', address:'1', manager_nm:'D',
				telf1:'5', email_address:'@', telf2:'0921-12 34 65​'
			} */
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}

//-------------------------------------------------------------------------------------------------------------------


function registerIn(){
	console.log('registerIn()');
	
	var key = w2ui.grid_list.getSelection();
	
	if( key.length==1 ) {
		 	var data = w2ui.grid_list.get(key[0]);
			$("#m_req_prod_menge").val(data.req_prod_menge);
			$("#m_req_prod_menge").attr('disabled', true);
			totalCount();
			$("#m_total_price").attr('disabled', true);
			
			$("#m_outsourcing_price").val(data.outsourcing_price);
			
			
			
			$("#modal_out").modal('show'); 
		} else {
			fnMessageModalAlert("알림", "입고 하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
}

function totalCount(){
	
	var out_price = $("#m_outsourcing_price").val();
	var p_menge = $("#m_req_prod_menge").val();
	
	var total = Number(out_price) * Number(p_menge);
	
	$("#m_total_price").val(total);
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
	var outsourcing_price = $("#m_outsourcing_price").val();
	
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
	
	console.log('outsourcing_price:' + outsourcing_price);
	
	$("#modal_out").modal('hide');
	var member_nm = memberNm;
	var strUrl = "/frontend/consumable/updateProductOperationOS_END";
	var postData = "routing_code=" + encodeURIComponent(routing_code)
	+ "&product_po=" + encodeURIComponent(product_po)
				+ "&warehouse_gubun=" + encodeURIComponent(warehouse_gubun)
			+ "&prod_menge=" + encodeURIComponent(prod_menge)
			+ "&req_prod_menge=" + encodeURIComponent(req_prod_menge)
			+ "&prod_fail_menge=" + encodeURIComponent(prod_fail_menge)
			+ "&outsourcing_price=" + encodeURIComponent(outsourcing_price)
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
//조회
function loadList()
{
	console.log('loadList()');
	w2ui['grid_list'].clear();
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
	
	var delivery_request_date = $("#delivery_request_date").val();
	var status =   $("#s_type").val();
	var account_nm =   $("#account_nm").val();
	var product_po = $('#product_po').val();
	var item_code = $('#item_code').val();
	var item_nm = $('#item_nm').val();
	var routing_nm = $('#routing_nm').val();
	
	var startValue_combo = "";
	comboValue_nm1 = new Array;
	comboValue_nm2 = new Array;
	comboValue_nm3 = new Array;
	comboValue_nm4 = new Array;

	
	console.log('%%% delivery_request_date : ' + delivery_request_date);
	console.log('%%% status : ' + status);
	console.log('%%% product_po : ' + product_po);
	console.log('%%% item_code : ' + item_code);
	console.log('%%% item_nm : ' + item_nm);
	console.log('%%% routing_nm : ' + routing_nm);
	
	if(product_po == null || product_po == 'null' || product_po == undefined)
	{
		product_po = '';
	}
	if(routing_nm == null || routing_nm == 'null' || routing_nm == undefined)
	{
		routing_nm = '';
	}
	if(status == 'n')
	{
		delivery_request_date = '';
	}
	var page_url = "/frontend/consumable/selectOutSourcingAll";
	
	var postData = "product_po=" + encodeURIComponent(product_po)
			+" &delivery_request_date=" + encodeURIComponent(delivery_request_date)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&account_nm=" + encodeURIComponent(account_nm)
			+ "&item_nm=" + encodeURIComponent(item_nm)
			+ "&status=" + encodeURIComponent(status)
			+ "&routing_nm=" + encodeURIComponent(routing_nm);
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
					
 					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.account_nm);
						comboValue_nm4.push(row.routing_nm);
 					}
 					
 					row.outsourcing_price = Number(row.outsourcing_price);
 					row.prev_prod_menge = Number(row.prev_prod_menge);
 					row.req_prod_menge = Number(row.req_prod_menge);
 					row.prod_menge = Number(row.prod_menge);
 					row.prev_prod_fail_menge = Number(row.prev_prod_fail_menge);

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
			$('#routing_nm').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			
			
			

		},complete: function () {
 			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("account_nm").style.removeProperty("height");
			document.getElementById("routing_nm").style.removeProperty("height"); 
		}
	});


}


function checkStatus(){
	

	var status =   $("#s_type").val();
	console.log('checkStatus() : ' + status);
	//진행전
	if(status == 'n'){
		$("#date_parent").hide();
		$("#btn_update").attr('disabled', true);
		w2ui['grid_list'].hideColumn(recids[0], 'delivery_request_date');
	}else
	{
		$("#date_parent").show();
		
	}
	
	if(status == 'e'){
		$(".btn_in").attr('disabled', true);
		$("#btn_update").attr('disabled', false);
	}else{
		$(".btn_in").attr('disabled', false);
		$("#btn_update").attr('disabled', true);
	}
	
	loadList();
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

//key 누를때 숫자만 가능하도록.
function onlyNumber(){

     if((event.keyCode<48)||(event.keyCode>57))

        event.returnValue=false;

}
</script>

</body>
</html>