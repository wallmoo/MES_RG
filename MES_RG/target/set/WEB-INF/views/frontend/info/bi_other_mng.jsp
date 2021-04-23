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
		<jsp:param name="selected_menu_cd" value="1054" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	 외주 발주 대상
        <small>구매/자재관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 구매/자재관리</a></li><li class="active">외주 발주대상</li>
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
	                        <button type="button" id="btn_search_csr" onclick="registerOrder();" class="btn btn-info btn-sm">발주등록</button><!-- loadList(); -->    
	                        <button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->    
	                    </div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-3">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-3">
								<div class="form-group">
									<label>작업지시 번호</label> <input type="text" id="product_po" name="product_po" placeholder="ex) 작업지시 번호"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-3">
								<div class="form-group">
									<label>의뢰 공정</label> <input type="text" id="routing_nm" name="routing_nm" placeholder="ex) 의뢰공정"
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
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">외주입고단가</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_outsourcing_price" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">발주수량</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_req_prod_menge" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">총 금액</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_total_price" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">납품요청일자</label>
							<div class="col-sm-5">
								<div class="input-group">
								  <input type="text" class="form-control input-sm" id="m_delivery_request_date">
									  <div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
							 	</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveOrder();">저장</button>
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

var startValue_combo = "";

$(function($) {

 	fnLoadCommonOption(); 	 

 	init_grid_list();
 	
 	loadList();
 	
 	requestAccount();

 
})

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
		
		$('#m_delivery_request_date').daterangepicker({
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
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [                
				 { field:'product_po', caption:'작업지시 번호', size:'10%', style:'text-align:center',sortable :true}, // 80px
		         { field:'routing_nm', caption:'의뢰 공정', size:'10%', style:'text-align:center',sortable :true},
		         { field:'routing_code', caption:'의뢰 공정', size:'10%', style:'text-align:center',hidden:true},
		         { field:'item_code', caption:'P/N', size:'15%', style:'text-align:center',sortable :true},// 200px
		         { field:'item_nm', caption:'품명', size:'25%', style:'text-align:center',sortable :true}, // 120px
		         { field:'outsourcing_price', caption:'외주입고단가', size:'10%', style:'text-align:center',sortable :true}, 
		         { field:'prev_prod_menge', caption:'요청수량', size:'10%', style:'text-align:center',sortable :true},
		         { field:'account_nm', caption:'거래처명', size:'10%', style:'text-align:center',sortable :true},
		         { field:'account_code', caption:'거래처명', size:'10%', style:'text-align:center', hidden:true},
		         { field:'req_prod_menge', caption:'발주수량', size:'10%', style:'text-align:center',sortable :true},
		         { field:'prod_menge', caption:'입고수량', size:'10%', style:'text-align:center' ,  hidden:true},
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


//등록/수정 모달 생성
function requestIU_modal()
{
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		insertItem();
	}else  if( key.length==1 ) {	
		updateItem();	
	}
}



function registerOrder(){
	console.log('registerOrder()');
	
	var key = w2ui.grid_list.getSelection();
	
	if( key.length==1 ) {
			// update
			var data = w2ui.grid_list.get(key[0]);
			
			/* if(data.account_nm != '')
			{
				fnMessageModalAlert("알림", "발주요청이 된 항목 입니다."); // Notification
				return;
			} */
			$("#m_account_nm").val('');
			$("#m_account_code").val('');
			$("#ct_codeView").css('display', '');
			$("#m_req_prod_menge").attr('disabled', true);
			
			
			$("#m_req_prod_menge").val(data.prev_prod_menge);
			
			$("#m_outsourcing_price").attr('disabled', true);
			$("#m_outsourcing_price").val(data.outsourcing_price);
			
			$("#m_total_price").attr('disabled', true);
			
			var out_price = $("#m_outsourcing_price").val();
			var p_menge = $("#m_req_prod_menge").val();
			var total = Number(out_price) * Number(p_menge);
			
			console.log("out_price : " + out_price);
			console.log("p_menge : " + p_menge);
			console.log("total : " + total);
			
			$("#m_total_price").val(total);
			
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "등록하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
}
//저장
function saveOrder() {
	console.log('saveOrder()');
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var account_nm = $("#m_account_nm").val();
	var req_prod_menge = $("#m_req_prod_menge").val();
	var delivery_request_date = $("#m_delivery_request_date").val();
	var product_po = data.product_po;
	var routing_code = data.routing_code;
	var account_code = $("#m_account_code").val();
	var outsourcing_price = $("#m_outsourcing_price").val();
	
	console.log('account_code:' +account_code);
	
	if(!chkSubmit($("#m_account_nm"), "거래처명을")) return;
	
	
	console.log('delivery_request_date:' + delivery_request_date);
	
	$("#modal_info").modal('hide');
	
	var strUrl = "/frontend/consumable/updateProductOperationOS_REQ";
	
	var postData = "account_code=" + encodeURIComponent(account_code)
			+ "&product_po=" + encodeURIComponent(product_po)
			+ "&routing_code=" + encodeURIComponent(routing_code)
			+ "&outsourcing_price=" + encodeURIComponent(outsourcing_price)
			+ "&delivery_request_date=" + encodeURIComponent(delivery_request_date);
			 
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

//조회
function loadList()
{
	console.log('loadList()');
	
	var product_po = $('#product_po').val();
	var item_code = $('#item_code').val();
	var item_nm = $('#item_nm').val();
	var routing_nm = $('#routing_nm').val();
	
	var page_url = "/frontend/consumable/selectOutSourcing";
	
	console.log('%%% product_po : ' + product_po);
	if(product_po == null || product_po == 'null' || product_po == undefined)
	{
		product_po = '';
	}
	
	var postData = "product_po=" + encodeURIComponent(product_po)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&item_nm=" + encodeURIComponent(item_nm)
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
						comboValue_nm3.push(row.product_po);
						comboValue_nm4.push(row.routing_nm);
					}
					
					row.outsourcing_price = Number(row.outsourcing_price);
					row.prev_prod_menge = Number(row.prev_prod_menge);
					row.req_prod_menge = Number(row.req_prod_menge);
					row.prod_menge = Number(row.prod_menge);
					
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
			$('#product_po').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#routing_nm').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			
			
			

		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("product_po").style.removeProperty("height");
			document.getElementById("routing_nm").style.removeProperty("height");
		}
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
</script>

</body>
</html>