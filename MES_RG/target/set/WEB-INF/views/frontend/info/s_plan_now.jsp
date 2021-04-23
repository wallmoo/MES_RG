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
		<jsp:param name="selected_menu_p_cd" value="1042" />
		<jsp:param name="selected_menu_cd" value="1056" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
       	생산계획 현황
        <small>생산관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 생산계획 현황</a></li><li class="active">생산관리</li>
      </ol>
    </section>

  	<section class="content col-sm-12"  style="height:600px;">
		<div class="row">
			<div class="row col-sm-6" style="width: 49.5%; height:600px; margin:0;">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">생산계획 현황조회</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="requestIU_modal();">선행생산추가</button>
								<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>
								
								<!-- loadList(); -->	 
								
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-4">    
									<div class="form-group" style="margin-top:0px;">
									<div class="col-sm-10" style="padding-left: 0px;">
						                  <label for="" class="control-label">안전재고 대상</label>
						             </div>
						                      
						             <label>
						               <input type="radio" id="rdo_safety_yn" name="rdo_safety_yn" class="flat-red form-control" value="N" checked> 미포함
						             </label>
						             
						             <label>
						               <input type="radio" id="rdo_safety_yn" name="rdo_safety_yn" class="flat-red form-control" value="" > 포함
						             </label>
						             </div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
										<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
										<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
									</div>
								</div>
							</div>
							<div id="row" style="position: relative; height:600px;">
								<div id="grid_list" style="width: 100%; height: 600px;"></div>
								
							</div>
						</div>
					</div>
			</div>
			
			
			 <div class="row col-sm-6" style="width: 49.8%; height:600px; margin:0;">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">생산계획 현황조회</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search_csr" onclick="loadList2();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
								
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-4">
									<div class="form-group">
									<label>생산요청일자</label>
										<div class="input-group">
											<input type="text" 
												class="form-control pull-right input-sm" style="" id="product_req_date" placeholder="yyyymmdd~yyyymmdd" onChange="loadList2();">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>공정유형</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="s_type" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange="loadList2();">
												<option value="drw">진행전</option>
												<option value="ex">진행</option>
												<option value="ord">완료</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>생산유형</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="product_class" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange="loadList2();">
												<option value="">전체</option>
												<option value="o">주문생산</option>
												<option value="f">선행생산</option>
											</select>
										</div>
									</div>
								</div>
								
							</div>
							<div id="row" style="position: relative; height:600px;">
								<div id="grid_list2" style="width: 100%; height: 600px;"></div>
							</div>
						</div>
					</div>
			</div>
			
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
				<h4 class="modal-title" id="modal_code_title">선행생산추가</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">P/N</label>
								<div class="col-sm-8">	
									 <input type="text" id="m_item_code" name="m_item_code" class="form-control input-sm">
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">품명</label>
								<div class="col-sm-8">	
									 <input type="text" id="m_item_nm" name="m_item_nm" class="form-control input-sm">
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
					
						<div class="col-sm-6">
							<div class="form-group">
								<label for="" class="col-sm-5 control-label">남은주문수량</label>
								<div class="col-sm-7">	
									 <input type="text" id="m_menge" name="m_menge" class="form-control input-sm">
								</div>
							</div>
						</div>
						
						
					</div>
					<div class="row">
					
						<div class="col-sm-6">
							<div class="form-group">
								<label for="" class="col-sm-5 control-label">안전재고수량</label>
								<div class="col-sm-7">	
									 <input type="text" id="m_safety_stock_qty" name="m_safety_stock_qty" class="form-control input-sm">
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">현재수량</label>
								<div class="col-sm-8">	
									 <input type="text" id="m_warehouse_raw_qty" name="m_warehouse_raw_qty" class="form-control input-sm">
								</div>
							</div>
						</div>
					</div>
				
					
					<div class="row">
					
						<div class="col-sm-6">
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">생산수량</label>
								<div class="col-sm-8">	
									 <input type="text" id="m_product_menge" name="m_product_menge" class="form-control input-sm" onKeypress="onlyNumber();" style="IME-MODE:disabled;">
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label class="col-sm-5 control-label">생산요청일자</label>
								<div class="input-group col-sm-6">
									<input type="text" 
										class="form-control pull-right input-sm" style="" id="m_product_req_date" onchange="" placeholder="yyyymmdd">
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveDirect();">선행생산추가</button>
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

comboValue_nm1 = new Array;
comboValue_nm2 = new Array;

$(function($) {

 	fnLoadCommonOption(); 
 	fnLoadCommonOption2();

 	init_grid_list();
 	init_grid_list2();
 	
 	loadList();
 	loadList2();
})

// //품명,품번 자동완성
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

// function getItemInfo(type, value)
// {
// 	console.log('getItemInfo() : ' + value);
// 	var result = "";
// 	if(type == 'cd')
// 	{
// 		$.each(materialArr, function(idx, row){
			
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
		
// 		$.each(materialArr, function(idx, row){
			
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

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
		$('#macc_chndate, #m_delivery_day, #m_order_day, #m_product_req_date').daterangepicker({
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
		
}

function fnLoadCommonOption2() {
 	console.log('fnLoadCommonOption2()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
 		 $('#product_req_date').daterangepicker({
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
          endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(30, 'days')
			}); 
 		$(":radio[name='rdo_safety_yn']").on('ifChecked', function(event){
 			  loadList();
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
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'item_type_code', caption:'자재유형코드', size:'10%', style:'text-align:center', hidden : true},
			{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center',sortable :true}, 
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center',sortable :true},
			{ field:'menge', caption:'남은 주문수량', size:'10%', style:'text-align:center',sortable :true},
			{ field:'safety_stock_qty', caption:'안전재고수량', size:'10%', style:'text-align:center',sortable :true},
			{ field:'safety_stock_yn', caption:'안전재고YN', size:'10%', style:'text-align:center', hidden : true},
			{ field:'warehousing_qty', caption:'현재수량', size:'10%', style:'text-align:center',sortable :true
				,render : function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

					var safety_stock_qty = w2ui.grid_list.records[index].safety_stock_qty; 
					var safety_stock_yn = w2ui.grid_list.records[index].safety_stock_yn; 
	           	   	var warehousing_qty = w2ui.grid_list.records[index].warehousing_qty; 
	           	   	
	           	 	var radioV = $(":radio[name='rdo_safety_yn']:checked").val();
		           	   	
		           	var val = this.getCellValue(index, col_index);
	           	 
	           	 	if( radioV == ""){ // 라디오버튼에서 안전재고대상이 '포함' 이고 
	           	 		if(safety_stock_yn == 'Y'){ // 그 리스트들 중에서 안전재고YN이 'Y' 이고 
			           	 	if(Number(safety_stock_qty) > Number(warehousing_qty)){ // 현재수량이 안전재고수량보다 작을때
		           	 			val =  '<div style="background-color:#fb6763; color:#ffffff;">'+ val  +'</div>';
		           	 		}else{
		           	 			
		           	 		}
	           	 		}
	           	 	}
	           	   	
	         		return val;
	        }  
			
			}, // 120px
			], 
	
		records: [
		
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onSelect: function (event) {
 			event.onComplete = function () {
 				console.log("onSelect");
				loadList2();
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
        	selectColumn: false,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'product_po', caption:'LOT작업지시번호', size:'12%', style:'text-align:center',sortable :true}, // 80px
			{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center',sortable :true},
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center',sortable :true},
			{ field:'product_menge', caption:'수량', size:'8%', style:'text-align:center',sortable :true}, // right // 120px
			{ field:'product_req_date', caption:'생산요청일자', size:'10%', style:'text-align:center',sortable :true}, // 120px
			{ field:'product_class', caption:'생산유형', size:'10%', style:'text-align:center',sortable :true
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'n')
	            	{
	            	   return '';
	            	}else if(html == 'o')
	            	{
	            		 return '주문 생산';
	            	}else if(html == 'f')
	            	{
	            		 return '선행 생산';
	            	}
	               return html;
	           } 	
			},
			{ field:'product_status', caption:'생산진행', size:'15%', style:'text-align:center'
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'n')
	            	{
	            	   return '생산전';
	            	}else if(html == 'i')
	            	{
	            		 return '진행중';
	            	}else if(html == 'y')
	            	{
	            		 return '생산완료';
	            	}
	               return html;
	           } 	, hidden : true
			}
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




// 선행 생산추가 모달 생성
function requestIU_modal()
{
	console.log('requestIU_modal()');

	var key = w2ui.grid_list.getSelection();
	
	curFile = null;
	isRev = false;
	
	var recids = w2ui.grid_list.getSelection();
	
	var pdata = w2ui.grid_list.get(recids[0]);
	
	
	$('#m_item_code').attr('disabled', true);
	$('#m_item_nm').attr('disabled', true);
	$('#m_now_menge').attr('disabled', true);
	$('#m_safe_menge').attr('disabled', true);
	
	
	var menge = Number(pdata.menge);
	var safety_stock_qty = Number(pdata.safety_stock_qty);
	var warehousing_qty = Number(pdata.warehousing_qty);
	
	var safety_stock_yn = pdata.safety_stock_yn;
	
	
	var product_menge = menge;
	if(safety_stock_yn == 'Y')
	{
		if(Number(safety_stock_qty) > Number(warehousing_qty))
		{
			product_menge = Number(safety_stock_qty) - Number(warehousing_qty) + Number(menge);
		}else
		{
			if(Number(menge) > Number(warehousing_qty))
			{
				product_menge = Number(menge) - Number(warehousing_qty) + Number(safety_stock_qty);
			}else
			{
				product_menge = '';
			}
		}
	}else 
	{	
		
		if(Number(menge) > Number(warehousing_qty))
		{
			product_menge = Number(menge) - Number(warehousing_qty);
		}else
		{
			product_menge = '';
		}
	}
	
	
	$("#m_product_menge").val(product_menge);
	
	$('.clear_field').val('');
	

	
	
	
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "생산추가하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "생산추가하고자 하는항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {
		var keys = Object.keys(pdata);
		
		
		$("#m_item_code").val(pdata.item_code);
		$("#m_item_nm").val(pdata.item_nm);
		$("#m_warehouse_raw_qty").val(pdata.warehousing_qty);
		$("#m_safety_stock_qty").val(pdata.safety_stock_qty);
		$("#m_menge").val(pdata.menge);
		/* 
		var jan_menge = Number(pdata.menge) - Number(pdata.in_menge);
		$("#m_jan_menge").val(jan_menge);
		$("#m_in_menge").val(0); */
		

		$('#m_item_code').attr('disabled', true);
		$('#m_item_nm').attr('disabled', true);
		$('#m_menge').attr('disabled', true);
		$('#m_warehouse_raw_qty').attr('disabled', true);
		$('#m_safety_stock_qty').attr('disabled', true);
		
	} 

	
	//w2ui.grid_list.selectNone();
	$('#modal_info').modal('show');
}

// 선행 생산추가
function insertItem() {
	console.log('insertItem()');

	w2ui.grid_list.selectNone();

	$("#modal_code_title").text('등록');
	$("#ct_codeView").css('display', 'none');
	$("#m_customer_code").val('');
	 			
	$("#modal_info").modal('show');

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

comboValue_nm1 = new Array();
comboValue_nm2 = new Array();
startValue_combo = "";
// var materialArr = new Array;

//왼쪽 리스트 조회
function loadList()
{
	console.log("loadList()");

	/* var purchase_req_date = $("#product_req_date").val();
	purchase_req_date = purchase_req_date.replace(/-/gi, ""); */
	
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	var safety_stock_yn = $(":radio[name='rdo_safety_yn']:checked").val();
	var page_url = "/frontend/consumable/selectProductPlanNow";
	
	//w2ui['grid_list'].lock('loading...', false);
	var postData = "item_nm=" + encodeURIComponent(item_nm)
		+ "&item_code=" + encodeURIComponent(item_code)
		+ "&safety_stock_yn=" + encodeURIComponent(safety_stock_yn)
		+ "&business_code=" + encodeURIComponent('MD1282');
		+ "&business_codeT=" + encodeURIComponent('MD1243');
	
	try{
		w2ui['grid_list'].clear();
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
					row.recid = idx+1;
					if (startValue_combo == "") {
// 						materialArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
					}
					
					row.menge = Number(row.menge);
					row.safety_stock_qty = Number(row.safety_stock_qty);
					row.warehousing_qty = Number(row.warehousing_qty);
		
				});
// 				w2ui['grid_list'].clear();
				w2ui['grid_list'].records = rowArr;
				

			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
	
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			
			
			try{
				//changeGridUI(gridDataArr);
			}catch(e)
			{
				
			}
			
			
		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
		}
	});
}


//-------------------------------------------------------------------------------------------------------------------


// 오른쪽 리스트 조회
function loadList2()
{
console.log("loadList2()");
	
	var product_req_date = $("#product_req_date").val();
	product_req_date = product_req_date.replace(/-/gi, ""); 
	
	
	var key;
	
	try
	{
		key = w2ui.grid_list.getSelection();
	}catch(e)
	{
		return;
	}

	var product_class =   $("#product_class").val();
	
	var page_url = "/frontend/consumable/selectProduct";
	var postData = '';
	if(key.length == 0)
	{
		 postData = "product_req_date=" + encodeURIComponent(product_req_date)
			+ "&product_class=" + encodeURIComponent(product_class)
			+ "&product_status=" + encodeURIComponent('n');
		
	}else
	{
		var data = w2ui.grid_list.get(key[0]);
		
		var item_code =  data.item_code;
		var item_nm =  data.item_nm;

		 postData = "item_nm=" + encodeURIComponent(item_nm)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&product_req_date=" + encodeURIComponent(product_req_date)
			+ "&product_class=" + encodeURIComponent(product_class)
			+ "&product_status=" + encodeURIComponent('n');
	}
	
	
	

	
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
				gridDataArr = rowArr;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					row.product_menge = Number(row.product_menge);
		
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


function saveDirect()
{
	w2ui.grid_list2.save();
	var records = w2ui['grid_list2'].records;
	
	var item_code = $('#m_item_code').val();
	var item_nm = $('#m_item_nm').val();
	var product_req_date = $('#m_product_req_date').val();
	var product_menge = $('#m_product_menge').val();
	var warehouse_raw_qty = $('#m_warehouse_raw_qty').val();
	
	
	/* if(Number(product_menge) > Number(warehouse_raw_qty))
	{
		fnMessageModalAlert("결과", "생산수량을 다시 입력해주세요.");// Notification(MES)
		return;	
	} */
	var strUrl = "/frontend/consumable/saveProductDirect";
	var postData = "product_req_date=" + encodeURIComponent(product_req_date)
	+"&item_code=" + encodeURIComponent(item_code)
	+"&item_nm=" + encodeURIComponent(item_nm)
	+"&product_menge=" + encodeURIComponent(product_menge);
	
			 
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
		//async : false,	
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
		    	
		    	
		    	loadList2();

		
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
			$("#modal_info").modal('hide');
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

//key 누를때 숫자만 가능하도록.
function onlyNumber(){

     if((event.keyCode<48)||(event.keyCode>57))

        event.returnValue=false;

}
</script>

</body>
</html>