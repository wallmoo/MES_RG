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
		<jsp:param name="selected_menu_cd" value="1055" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	생산계획 수립
        <small>생산관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>생산계획 수립</a></li><li class="active">생산관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row" style="position: relative; height:600px;">
			<div class="row" style="position: absolute; width: 49%; height:600px; margin:0;">
				<section class="col-lg-12">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">주문현황</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							</div>
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="row">
								<div class="col-sm-12">
									<div class="col-sm-6">
										<div class="form-group">
										<label>주문일자</label>
											<div class="input-group">
												<input type="text" 
													class="form-control pull-right input-sm" style="" id="delivery_date" placeholder="yyyymmdd~yyyymmdd" onChange="loadList();">
												<div class="input-group-addon">
													<i class="fa fa-calendar"></i>
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>고객사명</label> <input type="text" id="customer_nm" name="customer_nm" placeholder="ex) 고객사명"
											 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
										</div>
									</div>
								</div>	
							</div>
							<div class="row" >
								<div class="col-sm-12">
									<div class="col-sm-4">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
											 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
										</div>
									</div>	
									<div class="col-sm-4">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
											 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
										</div>
									</div>
									
									<div class="col-sm-4">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>작업지시서 생성 상태</label>
											<div class="form-group" style="margin-bottom: 0px;">
												<select id="plan_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "direct_loadList();">
													<option value="B">생성전</option>
													<option value="A">생성후</option>
						
												</select>
											</div>
										</div>
									</div>
									
								</div>			
							</div>
							
						
						</div>
						<div id="grid_list" style="height: 520px; margin: 15px"></div>
					</div>
					
				</div>	
				
				<div class="row" style="position: absolute; right: 45px; width: 48%; height:600px;">
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">재고출하량 확인</h3>
								<div class="box-tools pull-right">
						     		<button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="requestWorkMake_modal();">작업지시편성</button>
								</div>
							</div>
							<div id="grid_list2" style="height: 300px; margin: 15px""></div>
						</div>
					</div>
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">주문기반 작업지시 생성</h3>
								<div class="box-tools pull-right">
									<button type="button" id="btn_search_csr" onclick="requestWorkDiv_modal();" class="btn btn-info btn-sm">작업지시분할</button><!-- loadList(); -->	 
									<button type="button" id="btn_delete" class="btn btn-success btn-sm" onclick="saveWork();">저장</button>
								</div>
							</div>
							<div id="grid_list3" style="height: 250px; margin: 15px""></div>
						</div>
					</div>
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
				<h4 class="modal-title" id="modal_code_title">작업지시분할</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">작업지시번호</label>
								<div class="col-sm-3">	
									 <input type="text" id="m_product_po" name="m_product_po" class="form-control input-sm">
								</div>
							</div>
						</div>
					</div>
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
								<label for="" class="col-sm-4 control-label">품명</label>
								<div class="col-sm-8">	
									 <input type="text" id="m_item_nm" name="m_item_nm" class="form-control input-sm">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="" class="col-sm-4 control-label">생산수량</label>
								<div class="col-sm-8">	
									 <input type="text" id="m_product_menge" name="m_product_menge" class="form-control input-sm">
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
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">지시분할수량</label>
								<div class="col-sm-3">
									<input type="text" id="m_menge" name="m_menge" class="form-control input-sm" onKeypress="onlyNumber();" style="IME-MODE:disabled;">
								</div>
								<div class="col-md-1 text-right">
									<div class="box-tools">
										<button type="button" id="btn_ins_csr" onclick="makeNum();" class="btn btn-primary btn-sm" >적용</button>
									</div>			
								</div>
								<div class="col-md-5">
									<div class="box-tools pull-right">
										<button type="button" id="btn_ins_csr" onclick="minus();" class="btn btn-danger btn-sm" >삭제</button>
									</div>			
								</div>
							</div>
						</div>
					</div>
				
					<div class="row">
						<div class="col-md-12">
							<div id="modalGrid" style="width: 100%; height: 300px;" ></div>
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveWorkDiv();">저장</button>
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
comboValue_nm3 = new Array;

$(function($) {

 	fnLoadCommonOption(); 	 

 	init_grid_list();

 	init_grid_list2();
 	
 	init_grid_list3();
 	
 	loadList();
 	modalGrid();
 	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {

 		gridReDrw(); 

 		}, 100));
 	
	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {

		console.log('DOMSubtreeModified');
		changeGridUI(w2ui.grid_list.records);
   }, 100));
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
          endDate: moment(minDate)
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
        	selectColumn: false,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'order_num', caption:'주문번호', size:'10%', style:'text-align:center',sortable :true}, // 80px
			{ field:'customer_nm', caption:'고객사명', size:'10%', style:'text-align:center',sortable :true}, // 200px
			{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center',sortable :true}, // 120px
			{ field:'item_nm', caption:'품명', size:'18%', style:'text-align:center',sortable :true}, // 120px
			{ field:'menge', caption:'주문수량', size:'8%', style:'text-align:center',sortable :true}, // 120px
			{ field:'delivery_date', caption:'주문일자', size:'8%', style:'text-align:center',sortable :true},
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
		onSelect: function (event) {
 			event.onComplete = function () {
 				console.log("onSelect");
				w2ui.grid_list2.selectNone();
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
              	{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center',sortable :true},
    			{ field:'item_nm', caption:'품명', size:'22%', style:'text-align:center',sortable :true},
    			{ field:'menge', caption:'주문수량', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'stock_menge', caption:'재고수량', size:'10%', style:'text-align:center',sortable :true}, 
    			{ field:'warehouse_delivery_menge', caption:'재고출하수량', size:'14%', style:'text-align:center', editable: { type: 'int' },sortable :true},
    			{ field:'product_menge', caption:'생산지시수량', size:'14%', style:'text-align:center', editable: { type: 'int' },sortable :true},
    			{ field:'delivery_date', caption:'주문일자', size:'15%', style:'text-align:center', hidden : true}, 
    			{ field:'product_po', caption:'생산지시번호', size:'15%', style:'text-align:center', hidden : true}, 
    			{ field:'product_po_origin', caption:'생산지시번호', size:'15%', style:'text-align:center', hidden : true}, 
    			{ field:'order_num', caption:'주문번호', size:'15%', style:'text-align:center', hidden : true}, 
    	
			], 
			
	
		records: [

		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onSelect: function (event) {
 			event.onComplete = function () {
 				console.log("onSelect");
			
 				loadList3();
 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui.grid_list3.clear();
				w2ui.grid_list3.refresh();
			}
		},
		
		onChange: function (event) {
 			event.onComplete = function () {
 				console.log("onChange");
 				w2ui.grid_list2.save();
 				
 			}
		},
		onClick: function (event) {}
	});

}
function init_grid_list3(){
	var rowArr = [];
	
	$('#grid_list3').w2grid({ 
        name: 'grid_list3',
        show: {
        	selectColumn: false,
			lineNumbers : true,
            footer: true
        },
        multiSelect: true,
        columns: [                

			{ field:'product_po', caption:'LOT작업지시 번호', size:'20%', style:'text-align:center',sortable :true}, 
			{ field:'item_code', caption:'P/N', size:'25%', style:'text-align:center',sortable :true}, 
			{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center',sortable :true},
			{ field:'product_menge', caption:'생산수량', size:'10%', style:'text-align:center',sortable :true},
			{ field:'product_req_date', caption:'생산요청일자', size:'15%', style:'text-align:center',sortable :true
				,editable: { type: 'date', format: 'yyyy-mm-dd'} 
			}, 
			{ field:'product_class', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'product_status', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'product_date', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'order_num', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'delivery_date', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'order_menge', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'warehouse_delivery_menge', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'raw_out_yn', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			
			], 
	
		records: [

		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onChange: function (event) {
 			event.onComplete = function () {
 				console.log("onChange");
 				w2ui.grid_list3.save();
 			}
		},
		onClick: function (event) {}
	});

}



//-------------------------------------------------------------------------------------------------------------------


function direct_loadList()
{
	startValue_combo = '';
	loadList();
	
}

var gridDataArr;
var gridDataArr3;
comboValue_nm1 = new Array();
comboValue_nm2 = new Array();
comboValue_nm3 = new Array();
startValue_combo = "";
// 왼쪽 리스트 조회
function loadList() {

	console.log("loadList()");
		   
	var delivery_date = $("#delivery_date").val();
	var customer_nm = $("#customer_nm").val();
	var item_code = $("#item_code").val();
	var item_nm = $("#item_nm").val();
	var plan_status = $("#plan_status").val();
	var page_url = "/frontend/consumable/selectOrderPlan";

	
	var postData = "customer_nm=" + encodeURIComponent(customer_nm)
	 +"&delivery_date=" + encodeURIComponent(delivery_date)
	 +"&item_code=" + encodeURIComponent(item_code)
	 +"&item_nm=" + encodeURIComponent(item_nm)
	 +"&plan_status=" + encodeURIComponent(plan_status);
	/* var postData = {
			delivery_date : encodeURIComponent(delivery_date) ,
			customer_nm :  encodeURIComponent(customer_nm) ,
			item_code :  encodeURIComponent(item_code) ,
			item_nm :  encodeURIComponent(item_nm)
		} */

	try{
	w2ui['grid_list'].lock('loading...', true);
	}catch(e)
	{
		
	}
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
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.customer_nm);
					}
					
					row.menge = Number(row.menge);
				});
				
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
			
// 			try{
// 				changeGridUI(gridDataArr);
// 				}catch(e)
// 				{
// 				}
// 			changeGridUI(gridDataArr);
			w2ui['grid_list2'].clear();
			w2ui['grid_list3'].clear();
			
		},complete: function () {
	
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("customer_nm").style.removeProperty("height");
		}
	});
	
}


//-------------------------------------------------------------------------------------------------------------------

function requestWorkMake_modal()
{
	var key = w2ui.grid_list2.getSelection();


	if( key.length==0 ) {
		fnMessageModalAlert("알림", "작업지시편성을 할  항목을 1개 선택하여야 합니다."); // Notification
		return;
	}
	
	var data = w2ui.grid_list2.get(key[0]);
	
	if(Number(data.product_menge) == 0)
	{
		fnMessageModalAlert("알림", "생산지시수량을 입력해주세요.");
		
		return;
	}

	console.log('product_po_origin : ' + data.product_po_origin);
	if(data.product_po_origin != '' && data.product_po_origin != null){
		fnMessageModalAlert("알림", "이미 편성된 항목 입니다.");
		return;
	}
	requestWorkMake();
}

// 작업지시편성
function requestWorkMake()
{
	w2ui.grid_list2.save();
	var records = w2ui['grid_list2'].records;
	
	var key = w2ui.grid_list2.getSelection();
	var data = w2ui.grid_list2.get(key[0]);
	
	var idx = Number(key[0]) - 1 ;
	var strUrl = "/frontend/consumable/saveProductProcess";
	var postData = "gridData=" + encodeURIComponent(JSON.stringify(records))
	+"&idx=" + encodeURIComponent(idx);
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
		    	
		    	
		    	loadList2();
		    	loadList3();
		
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

// 오른쪽 상단 리스트 조회
function loadList2()
{
	console.log("loadList2()");
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	var order_num = data.order_num;
	var item_code = data.item_code;
	var item_nm = data.item_nm;

	var page_url = "/frontend/consumable/selectOrderProduct";
	
	var postData = "order_num=" + encodeURIComponent(order_num)
 	 +"&item_code=" + encodeURIComponent(item_code);
	/* +"&item_nm=" + encodeURIComponent(item_nm); */
	
	w2ui['grid_list2'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		async : false,
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					

					console.log('warehouse_delivery_menge : ' + row.warehouse_delivery_menge);
					console.log('product_menge : ' + row.product_menge);
					
					row.menge = Number(row.menge);
					row.stock_menge = Number(row.stock_menge);
					row.warehouse_delivery_menge = Number(row.warehouse_delivery_menge);
					row.product_menge = Number(row.product_menge);
					
				});
				
	
				w2ui['grid_list2'].records = rowArr;
			
			
			}
			else
			{
				w2ui['grid_list2'].clear();
			}
			
		
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			try{
			w2ui['grid_list3'].clear();
			w2ui['grid_list3'].refresh();
			}catch(e)
			{
			
			}
			
		},complete: function () {
		
		}
	});

}


//-------------------------------------------------------------------------------------------------------------------

// 작업지시분할

function requestWorkDiv_modal()
{
	var key = w2ui.grid_list3.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "작업지시분할 항목을 1개 선택하여야 합니다."); // Notification
		return;
	
	} else {	
		
		/**
			현재 선택된 그리드 항목의 생산요청일자가 입력되어있는지 확인하고 팝업을 띄운다. 
		
		*/
		
		requestWorkDiv();
		
	}
	
}

// 작업지시분할
function requestWorkDiv()
{
	console.log('requestWorkDiv()');

	w2ui.modalGrid.clear();
	var key = w2ui.grid_list3.getSelection();
	
	var data = w2ui.grid_list3.get(key[0]);
	
	var product_po = data.product_po;
	var item_code = data.item_code;
	var item_nm = data.item_nm;
	var product_menge = data.product_menge;
	var product_req_date = data.product_req_date;
	
	
	if(product_po.indexOf('_') != -1) {

		fnMessageModalAlert("알림", "이미 분할된 항목입니다.");
		return;
	}
	
	$("#ct_codeView").css('display', 'none');
	$("#m_product_po").val(product_po);
	$("#m_item_code").val(item_code);
	$("#m_item_nm").val(item_nm);
	$('#m_product_menge').val(product_menge);
	$('#m_menge').val('');
	
	$('#m_product_po').attr('disabled', true);
	$('#m_item_code').attr('disabled', true);
	$('#m_item_nm').attr('disabled', true);
	
	$('#m_product_menge').attr('disabled', true);
	$('#m_product_req_date').attr('disabled', true);

	
	
	setTimeout(function(){
	      w2ui['modalGrid'].resize();
	      w2ui['modalGrid'].refresh();
	   }, 200);
	 			
	$("#modal_info").modal('show');
}


//주문 기반 작업지시 생성 저장 
function saveWork()
{
	console.log('saveWork');
	
	var dataArr = w2ui.grid_list3.records;
	
	
	w2ui.grid_list3.save();
	var records = w2ui['grid_list3'].records;
	
	var strUrl = "/frontend/consumable/updateProductDateProcess";
	var postData = "gridData=" + encodeURIComponent(JSON.stringify(records));
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
		    	
		    	loadList3();
		
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

//작업지시 분할 저장
function saveWorkDiv()
{
	console.log('saveWorkDiv');
	/**
		product_menge 가 grid의 menge의 합과 같아야 함 
	
	*/
	var dataArr = w2ui.modalGrid.records;
	
	var parent_product_po = $('#m_product_po').val();
	var product_menge = $('#m_product_menge').val();
	console.log('product_menge : '+ product_menge);
	var tot_menge = 0;
	for(var i = 0; i< dataArr.length; i++)
	{
		var menge = dataArr[i].product_menge;
		
		if(Number(menge) == 0)
		{
			fnMessageModalAlert("알림", "분할 전체 수량을 확인해주세요.");
			
			return;
		}
		tot_menge = Number(tot_menge) + Number(menge);
	}

	console.log('tot_menge : '+ tot_menge);
	console.log('product_menge : '+ product_menge);
	if(Number(tot_menge) != Number(product_menge))
	{
		fnMessageModalAlert("알림", "분할 전체 수량을 확인해주세요.");
		
		return;
	}
	
	
	
	
	
	
	w2ui.modalGrid.save();
	var records = w2ui['modalGrid'].records;
	
	var strUrl = "/frontend/consumable/reSaveProductProcess";
	var postData = "gridData=" + encodeURIComponent(JSON.stringify(records))
	+  "&parent_product_po=" + encodeURIComponent(parent_product_po);
			 
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
		    	
		    	
		    	loadList2();
		    	loadList3();
		
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



function makeNum(){
	
	console.log("makeNum()");

	w2ui.modalGrid.selectNone();
	w2ui['modalGrid'].clear();
	w2ui['modalGrid'].refresh();
	
	var rowArr = w2ui['modalGrid'].records; 

	var num_menge = $("#m_menge").val();

	
	console.log('num_menge : ' + num_menge);
	var parent_product_po = $("#m_product_po").val();
	
	var product_req_date = $("#m_product_req_date").val();

	var key = w2ui.grid_list3.getSelection();
	var grid3Arr = w2ui.grid_list3.get(key[0]);
	
	var item_nm = grid3Arr.item_nm;
	var item_code = grid3Arr.item_code;
	var product_class = grid3Arr.product_class;
	var product_status = grid3Arr.product_status;
	var product_date = grid3Arr.product_date;
	var order_num = grid3Arr.order_num;
	var delivery_date = grid3Arr.delivery_date;
	var order_menge = grid3Arr.order_menge;
	var warehouse_delivery_menge = grid3Arr.warehouse_delivery_menge;
	var raw_out_yn = grid3Arr.raw_out_yn;
	
		
	for(var i = 0; i< Number(num_menge); i++ )
	{
		
		var recid = Number(i) + 1;
		
		var product_po = parent_product_po + '_'+recid
		w2ui['modalGrid'].add([
		               		{ recid:  recid , 
		               			item_nm: item_nm, 
		               			item_code: item_code, 
		               			product_class: product_class, 
		               			product_status: product_status, 
		               			product_date: product_date, 
		               			
		               			order_num: order_num, 
		               			delivery_date: delivery_date, 
		               			order_menge: order_menge, 
		               			warehouse_delivery_menge: warehouse_delivery_menge, 
		               			raw_out_yn: raw_out_yn, 
		               			
		               			product_po: product_po, 
		               			product_menge : 0, 
		               			product_req_date : product_req_date }
		               	]);
	}

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
  
			
			{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center', hidden : true},
			{ field:'item_code', caption:'P/N', size:'25%', style:'text-align:center', hidden : true}, 
			{ field:'product_class', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'product_status', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'product_date', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'order_num', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'delivery_date', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'order_menge', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'warehouse_delivery_menge', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			{ field:'raw_out_yn', caption:'생산수량', size:'10%', style:'text-align:center', hidden : true},
			
			{ field: 'product_po', caption: '분할지시번호', size:'30%', style:'text-align:center'},
			{ field:'product_menge', caption:'생산수량', size:'25%', style:'text-align:center', editable:{ type: 'int'}},
			{ field:'product_req_date', caption:'생산요청일자', size:'30%',  style:'text-align:center' , editable: { type: 'date', format: 'yyyy-mm-dd' }}
			
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
	
				w2ui.modalGrid.save();
			
			}
		}	
	});
	
	
	//w2ui['modalGrid'].records = gridDataArr;
	
}

function minus() {
	var selIdxArr = w2ui.modalGrid.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
	}  else {
		for(var i=0; i<chkLen; i++){
		 	var row = w2ui.modalGrid.get(selIdxArr[i]);
		 	 	
		 	w2ui['modalGrid'].remove(row.recid);
		
		}
	 } 
	w2ui.modalGrid.selectNone();	
	w2ui['modalGrid'].refresh();

	
}

// 오른쪽 하단 리스트 조회
function loadList3()
{
	console.log("loadList3()");
	
	var key = w2ui.grid_list2.getSelection();
	var data = w2ui.grid_list2.get(key[0]);
	var order_num = data.order_num;
	var item_code = data.item_code;
	var item_nm = data.item_nm;

	var page_url = "/frontend/consumable/selectProduct";
	
	//w2ui['grid_list'].lock('loading...', false);
	var postData = "order_num=" + encodeURIComponent(order_num)
	+ "&item_code=" + encodeURIComponent(item_code);
	
	try{
		
		w2ui.grid_list3.selectNone();
		w2ui['grid_list3'].lock('loading...', true);
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
				gridDataArr3 = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if(row.product_req_date == '' || row.product_req_date == null)
					{
						row.product_req_date = getFormatDate(new Date());
					}
					
					row.product_menge = Number(row.product_menge);
				});
				
				w2ui['grid_list3'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list3'].clear();
				
			}
			w2ui['grid_list3'].refresh();
			w2ui['grid_list3'].unlock();
			
			
			
		},complete: function () {
			
		}
	});
}



//-------------------------------------------------------------------------------------------------------------------


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
	//$("[id*=grid_grid_list_data_][col=2]").css("background-color","rgb(234, 255, 240)");

	
	
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


//-------------------------------------------------------------------------------------------------------------------


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