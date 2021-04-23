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
    		
    		#request_num{
    		height: 30px !important;
    		margin-top: 5px;
    		}
    		#customer_nm{
    		height: 30px !important;
    		margin-top: 5px;
    		}
    		#item_code{
    		height: 30px !important;
    		margin-top: 5px;
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
		<jsp:param name="selected_menu_p_cd" value="1016" />
		<jsp:param name="selected_menu_cd" value="1090" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
     	 출하실적관리
        <small>주문/출하관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 출하실적관리</a></li><li class="active">주문/출하관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">출하지시 조회</h3>
						<div class="box-tools pull-right">
							<!-- <button type="button" id="btn_search" class="btn btn-danger btn-sm" 
								onclick="deleteItem();">삭제</button>	 -->
							<button type="button" id="btn_search" class="btn btn-info btn-sm" 
							onclick="excelFileDownload();">엑셀다운로드</button>
							<button type="button" id="btn_create" 
								class="btn btn-success btn-sm" onclick="shipSave();">출하완료</button>
							<!-- <button type="button" id="btn_create" 
								class="btn btn-danger btn-sm btn_del" onclick="deleteItem();">삭제</button> -->
							<button type="button" id="btn_search_csr" onclick="loadList();" 
							class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
								 <label>
					               <input type="radio" id="rdo_status_date" name="rdo_status_date" class="flat-red form-control" value="delivery_req_date" checked> 주문일자 
					             </label>
					             <label>
					               <input type="radio" id="rdo_status_date" name="rdo_status_date" class="flat-red form-control" value="delivery_order_date" > 출하일자
					             </label><button type="button" id="btn_today" onclick="todayLoadList();" 
											class="btn btn-warning btn-sm" style="margin-left:10px;">금일</button>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="delivery_date"  onchange = "loadList();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
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
								<div class="form-group">
									<label>고객사명</label> <input type="text" id="customer_nm" name="customer_nm" placeholder="ex) 고객사명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>								</div>
							</div>
							
							<div class="col-sm-4">
								<div class="form-group" style="margin-top:20px;">
									<label style="margin-right:10px;">출하여부</label> 
									<label>
						               <input type="radio" id="rdo_status_type" name="rdo_status_type" class="flat-red form-control" value="" checked> 전체 
						             </label>
						             <label>
						               <input type="radio" id="rdo_status_type" name="rdo_status_type" class="flat-red form-control" value="N"> 미출하
						             </label>
						             <label>
						               <input type="radio" id="rdo_status_type" name="rdo_status_type" class="flat-red form-control" value="I" > 부분출하완료
						             </label>
						             <label>
						               <input type="radio" id="rdo_status_type" name="rdo_status_type" class="flat-red form-control" value="Y" > 출하완료
						             </label>
								</div>
							</div>
						</div>
						<div id="grid_list" style="width: 100%; height: 570px;"></div>
						<div id="grid_list_tot" style="width: 100%; height: 60px;"></div>
					</div>
				</div>
				
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>

 
<!-- 모달 커팅 -->
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">출하완료 </h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
			
					
					<input type="hidden" class="form-control input-sm pull-right clear_val" id="m_recid" maxlength="100"/>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">출하일자</label>
							<div class="col-sm-4">
								<div class="input-group">
								  <input type="text" class="form-control input-sm" id="m_delivery_date">
									  <div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
							 	</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">출하 담당자</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_out_user"  maxlength="100" />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">출하사유</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_out_comment"  maxlength="100"/>
							</div>
						</div>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveOut();">저장</button>
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
					
				</button>
				<h4 class="modal-title" id="modal_code_title">알림</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
			
					
					<input type="hidden" class="form-control input-sm pull-right clear_val" id="m_recid" maxlength="100"/>
				
					<h4 class="modal-title" id="modal_code_title">처리가 끝났습니다.</h4>
		
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-default btn-sm" onclick="loadList();" data-dismiss="modal">닫기</button>
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
/* var startValue_combo = "";

comboValue_nm1 = new Array;
comboValue_nm2 = new Array; */

$(function($) {

 	init_grid_list();
 	init_grid_list_tot();
 	
	fnLoadCommonOption();
	
})
$(".btn_del").hide();

$(":radio[name='rdo_status_type']").on('ifChecked', function(event){
		startValue_combo="";
	
		  loadList();
	});
	
	
$(":radio[name='rdo_status_date']").on('ifChecked', function(event){
		startValue_combo="";
	
	  loadList();
});

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
					format: 'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
					monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear: true,
					yearSuffix: '년',
					orientation: "top left"
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

function btn_set(){
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var success_status = data.success_status;
	
	$("#success_status").hide();
	
	if(success_status == 'Y'){
		$("#success_status").show();
	}else{
		$("#success_status").hide();
	}
}



function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
        	selectColumn: true,
            footer: true
          
        },
        multiSelect: true,
        columns: [      
			{ field:'recid', caption:'번호', size:'4%' , sortable: true, style:'text-align:center'}, // 80px
			{ field:'delivery_num', caption:'출하지시번호', size:'15%' , sortable: true, style:'text-align:center'}, // 80px
		
			{ field:'success_status', caption:'출하상태', size:'10%' , sortable: true , style:'text-align:center'
					
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);

		                if(html == 'N')
		            	{
		            	   return '미출하';
		            	}else if(html == 'I')
		            	{
		            		 return '부분출하완료';
		            	}else if(html == 'Y')
		            	{
		            		 return '출하완료';
		            	}
		               return html;
		           } 	
			}, // 200px
			{ field:'order_num', caption:'주문번호', size:'12%' , sortable: true, style:'text-align:center'}, // 120px
			{ field:'request_num', caption:'발주번호', size:'12%' , sortable: true, style:'text-align:center'}, 
			{ field:'delivery_order_date', caption:'주문일자', size:'10%' , sortable: true, style:'text-align:center'}, // 120px
			{ field:'customer_nm', caption:'고객사', size:'15%' , sortable: true, style:'text-align:center'},
			{ field:'land', caption:'사업장', size:'10%' , sortable: true, style:'text-align:center'},
			{ field:'location', caption:'위치', size:'5%' , sortable: true, style:'text-align:center'},
			{ field:'item_code', caption:'P/N', size:'12%' , sortable: true, style:'text-align:center'}, // right // 120px
			{ field:'item_nm', caption:'품명', size:'20%' , sortable: true, style:'text-align:center'},
			{ field:'unit_price', caption:'단가', size:'8%' , sortable: true, style:'text-align:center'
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              } 	
			},

			{ field:'stock_menge', caption:'재고수량', size:'6%' , sortable: true, style:'text-align:center'
				,render : function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

					var delivery_order_menge = w2ui.grid_list.records[index].delivery_order_menge; //지시수량
					var success_status = w2ui.grid_list.records[index].success_status; //출하상태
	           	   	var stock_menge = w2ui.grid_list.records[index].stock_menge; //재고수량
		           	   	
		           	var val = this.getCellValue(index, col_index);
		           	
		           	//출하상태가 미출하이고
		           	if(success_status == 'N'){
		           		if(Number(delivery_order_menge) > Number(stock_menge)){
		           			val =  '<div style="background-color:#fb6763; color:#ffffff;">'+ val  +'</div>';
		           		}
		           	}
	         		return val;
	        	} 	},
	        	{ field:'menge', caption:'주문수량', size:'6%' , sortable: true, style:'text-align:center'},
			{ field:'delivery_order_menge', caption:'지시수량', size:'6%' , sortable: true, style:'text-align:center'},
			
			{ field:'delivery_menge', caption:'실적수량', size:'6%' , sortable: true, style:'text-align:center'
				
// 				,render: function (record, index, col_index) {
// 		               var html = this.getCellValue(index, col_index);
		         
// 		               if(html == null || html == '')
// 		           		{
// 		            	   html = 0;
// 		            	 }
// 		               return html;
// 		           } 	
			
			},
			{ field:'total_price', caption:'총금액', size:'10%' , sortable: true, style:'text-align:center'
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              } 
			},
			{ field:'send_delivery_menge', caption:'미출하수량', size:'8%', style:'text-align:center', editable: { type: 'int' },sortable :true
// 				,render: function (record, index, col_index) {
// 				var send_delivery_menge = w2ui.grid_list.records[index].send_delivery_menge;
// 				var html = this.getCellValue(index, col_index);			
// 				if(html < 0)
// 	            	{	console.log("iu send_delivery_menge:::"+send_delivery_menge);
// 	            		send_delivery_menge = 0;
// 	            		console.log("iu send_delivery_menge:::"+send_delivery_menge);
// 	            		return '';	            		
// 	            	}else{
// 	                return html;
// 	            	}
				
//             	} 	
			},
			{ field:'delivery_date', caption:'출하일자', size:'10%', style:'text-align:center', sortable :true},
			{ field:'creator_nm', caption:'등록자', size:'5%', style:'text-align:center',sortable :true},
			{ field:'creator_nm', caption:'출하등록자', size:'5%', style:'text-align:center',sortable :true}

			], 
		records: [
	
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onSelect: function (event) {
		
		},
		onClick: function (event) {
			event.onComplete = function(){					
				
			}
			
		},
		onChange : function(event){
			event.onComplete = function(){
				w2ui.grid_list.save();
				
				var keys = w2ui.grid_list.getSelection();

					var row = w2ui.grid_list.get(keys[0]);					
					var send_delivery_menge = row.send_delivery_menge;
					
					if(send_delivery_menge < 0){

						console.log("음수막기send_delivery_menge:::"+send_delivery_menge)
						w2ui.grid_list.set(keys[0] , {send_delivery_menge : 0});
						
					}
				 
				 console.log("음수막기")
	
			}
		},
		onClick : function(event){
			 event.onComplete = function () {
				var eventColumn = event.column;
				var key = w2ui.grid_list.getSelection();

				var current_recid = key[0];
				
				var last_recid = w2ui.grid_list.records.length;
			
				var data = w2ui.grid_list.get(current_recid);
				
				if(data.success_status == 'Y'){
					$(".btn_del").show();
				}else{
					$(".btn_del").hide();
				}
			 }
		}
		
	});
	

}

function init_grid_list_tot(){
	var rowArr = [];
	
	$('#grid_list_tot').w2grid({ 
        name: 'grid_list_tot',
        show: {
        	selectColumn: true,
            footer: false
        },
        multiSelect: false,
        columns: [                
					{ field:'', caption:'', size:'4%' , sortable: true, style:'text-align:center'}, // 80px
					{ field:'', caption:'', size:'15%' , sortable: true, style:'text-align:center'}, // 80px
					
					{ field:'', caption:'', size:'10%' , sortable: true , style:'text-align:center'}, // 200px
					{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'}, // 120px
					{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'}, 
					{ field:'', caption:'', size:'10%' , sortable: true, style:'text-align:center'}, // 120px
					{ field:'', caption:'', size:'15%' , sortable: true, style:'text-align:center'},
					{ field:'', caption:'', size:'10%' , sortable: true, style:'text-align:center'},
					{ field:'', caption:'', size:'5%' , sortable: true, style:'text-align:center'},
					{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'}, // right // 120px
					{ field:'', caption:'', size:'20%' , sortable: true, style:'text-align:center'},
					
					{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'},
					{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'},
					
					{ field:'unit_price_tot', caption:'', size:'8%' , sortable: true, style:'text-align:center'},
					{ field:'delivery_menge_tot', caption:'출하실적수량', size:'12%' , sortable: true, style:'text-align:center'},
					{ field:'total_price_tot', caption:'총금액', size:'25%' , sortable: true, style:'text-align:center'},
					{ field:'', caption:'', size:'10%', style:'text-align:center', sortable :true},
					{ field:'', caption:'', size:'5%', style:'text-align:center',sortable :true},
					{ field:'', caption:'', size:'5%', style:'text-align:center',sortable :true}


			], 
		records: [
	
		          
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onSelect: function (event) {
			
		},
		onClick: function (event) {}
	});
	
	w2ui['grid_list_tot'].add([
		          			 { recid:'g1',unit_price_tot : "합계", total_price_tot : '' , menge_tot : '', delivery_order_menge_tot : '', delivery_menge_tot : ''}
		          	     ]);

}


//-------------------------------------------------------------------------------------------------------------------




//-------------------------------------------------------------------------------------------------------------------

function todayLoadList()
{
	
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
		    startDate: moment(minDate),
          endDate:  moment(minDate)
		}); 
	 
	
	loadList();
}

//상단 리스트 조회
var gridDataArr;
function loadList()
{
	
	var startValue_combo = "";
	comboValue_nm1 = new Array;
	comboValue_nm2 = new Array;
	comboValue_nm3 = new Array;
	
	console.log("loadList()");
	   
	var delivery_date = $("#delivery_date").val();
		delivery_date = delivery_date.replace()
	var customer_nm = $("#customer_nm").val();
	var item_code = $("#item_code").val();
	var request_num = $("#request_num").val();
		
	var rdo_status_date = $(':radio[name="rdo_status_date"]:checked').val();
	
	var success_status = $(':radio[name="rdo_status_type"]:checked').val();
	
	var page_url = "/frontend/consumable/selectDeliveryOrder";

	//w2ui['grid_list'].lock('loading...', true);
	var postData = "customer_nm=" + encodeURIComponent(customer_nm)
	 			 +"&success_status=" + encodeURIComponent(success_status)
	 			 +"&item_code=" + encodeURIComponent(item_code)
	             +"&request_num=" + encodeURIComponent(request_num)
	             +"&"+rdo_status_date+"=" + encodeURIComponent(delivery_date);
	
	w2ui['grid_list'].lock('loading...', true);
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
						
						comboValue_nm1.push(row.customer_nm);
						comboValue_nm2.push(row.request_num);
						comboValue_nm3.push(row.item_code);
 					}
					
					row.menge = Number(row.menge);
					//console.log("row.menge:::"+row.menge)
					row.stock_menge = Number(row.stock_menge);
					row.delivery_order_menge = Number(row.delivery_order_menge);
					//console.log("row.delivery_order_menge:::"+row.delivery_order_menge)
					row.total_price = Number(row.unit_price)* Number(row.delivery_menge);
					row.delivery_menge = Number(row.delivery_menge);
					//console.log("row.delivery_menge:::"+row.delivery_menge)
					
					//if(row.customer_nm)comboValue_nm1.push(row.customer_nm);
					//if(row.request_num)comboValue_nm2.push(row.request_num);
					//console.log("row.delivery_order_menge:::"+row.delivery_order_menge)
					//console.log("row.delivery_menge:::"+row.delivery_menge)
					
					row.send_delivery_menge = Number(row.delivery_order_menge) - Number(row.delivery_menge);
// 					row.delivery_menge = Number(row.delivery_menge) + Number(row.send_delivery_menge);
					console.log("row.send_delivery_menge:::"+row.send_delivery_menge)
					

				});
				
				w2ui['grid_list'].records = rowArr;
				
				var keys = w2ui.grid_list.getSelection();
				console.log("keys.length:::"+keys.length);
				
				 for(var i = 0 ; i< keys.length; i ++ )
				 {
					 var row = w2ui.grid_list.get(keys[i]);
					 console.log("row.menge:::"+row.menge)
					 console.log("row.delivery_menge:::"+row.delivery_menge)
					 console.log("row.send_delivery_menge:::"+row.send_delivery_menge)
					 
				     checkSuccessStatus(row.delivery_num, row.delivery_order_menge, row.delivery_menge, row.menge,row.send_delivery_menge);
				 }
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			if (startValue_combo == "") {
				$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
				$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
				$('#request_num').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
				
				
			}
			try{
				//w2ui['grid_list2'].clear();
			}catch(e)
			{
				
			}
			
		},complete: function () {
			
			startValue_combo=":)";
			document.getElementById("customer_nm").style.removeProperty("height");
			document.getElementById("request_num").style.removeProperty("height");
			
		}
	});
	
	grid_list_tot();
}

function grid_list_tot()
{
	
	setTimeout(function(){
	      w2ui['grid_list_tot'].resize();
	      w2ui['grid_list_tot'].refresh();

	   }, 200);
	
	var rowArr_tot = w2ui['grid_list'].records; 
	
	var unit_price_tot = 0;	
	var total_price_tot = 0;
	
	var menge_tot = 0;
	var delivery_order_menge_tot = 0;
	var delivery_menge_tot = 0;
	
	currentRecid = Number(i) + 1;
	
	console.log("lenght?????" + rowArr_tot.length);

	for(var i = 0; i < rowArr_tot.length; i ++)
	{
		var data = rowArr_tot[i];
		
		total_price_tot = total_price_tot + parseInt(data.total_price);
		
		menge_tot = menge_tot + parseInt(data.menge); 
		delivery_order_menge_tot = delivery_order_menge_tot + parseInt(data.delivery_order_menge); 
		delivery_menge_tot = delivery_menge_tot + parseInt(data.delivery_menge); 

	}
	
	
	unit_price_tot = w2utils.formatters['number'](unit_price_tot);
	total_price_tot = w2utils.formatters['number'](total_price_tot); 

		               	
	w2ui['grid_list_tot'].set('g1',{unit_price_tot : "합계", total_price_tot : total_price_tot 
							, menge_tot : menge_tot, delivery_order_menge_tot : delivery_order_menge_tot, delivery_menge_tot : delivery_menge_tot});
	
}

//하단 리스트 조회
function loadList2(p_delivery_num, p_item_code)
{
	w2ui['grid_list2'].selectNone();
	console.log("loadList2()");
	   
	var delivery_num = p_delivery_num;
	var item_code = p_item_code;

	
	var page_url = "/frontend/consumable/selectDelivery";

	
	var postData = "delivery_num=" + encodeURIComponent(delivery_num)
	 +"&item_code=" + encodeURIComponent(item_code);
	
	w2ui['grid_list2'].lock('loading...', true);
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
					row.save_yn = '<input type="button" name="btn_save" value=" 저장 " onClick="requestOut('+row.recid+');">';
				});
				
				w2ui['grid_list2'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list2'].clear();
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
			
		},complete: function () {
			w2ui['grid_list'].unlock();
		}
	});
}

function shipSave() {
	console.log('shipSave()');
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
// 	if(data.success_status == "I" || data.success_status == "Y" ) {
// 		fnMessageModalAlert("알림", "이미 완료된 출하입니다");
// 		return;
// 	}else 
		
		if( key.length >= 1 ) {
		// update
		var data = w2ui.grid_list.get(key[0]);
		$("#m_out_user").val('');
		$("#m_out_comment").val('');

		$("#modal_info").modal('show');
	} else {
		fnMessageModalAlert("알림", "완료하고자 하는 항목을 1개이상 선택해야 합니다."); // Notification
	}
	
}

function checkValue(type)
{
	
	w2ui.grid_list.save();
	var result = false;
	var selIdxArr = w2ui.grid_list.getSelection();
	var gridData = w2ui.grid_list.get(selIdxArr[0]);
	
	
	// 주문수량
	var menge = gridData.menge;
	// 출하수량
	var delivery_order_menge = gridData.delivery_order_menge;
	
	var delivery_menge = gridData.delivery_menge;
	
	var records = w2ui.grid_list.records;
	
	/* var delivery_menge_tot = 0;
	$.each(records, function(idx, row){
			
		delivery_menge_tot = Number(delivery_menge_tot) + Number(row.delivery_menge);
	});
	 */
	
	
	if(type == 'save')
	{
	
		if(delivery_order_menge < delivery_menge)
		{
			result = true;	
		}
	}
	
	return result;
}

//-------------------------------------------------------------------------------------------------------------------

var successTitle = '* 정상 처리 건 '; 
var errorTitle = '* 오류 <br>'
var errorCate1 = ' &nbsp;기출하완료건 <br>'; // 출하수량 오류 ( 출하지시보다 실적수량을 크게 입력했을때)
var errorCate2 = ' &nbsp;출하수량 오류<br>'; // 출하수량 오류 ( 출하지시보다 실적수량을 크게 입력했을때)
var errorCate3 = ' &nbsp;재고수량 부족<br>'; //재고수량 부족

var success = '';
var error1 = '';
var error2 = '';
var error3 = '';

function saveOut()
{

	success = '';
	error1 = '';
	error2 = '';
	error3 = '';
	
	
	
	var delivery_date = $("#m_delivery_date").val();
	var out_user = $("#m_out_user").val();
	var out_comment = $("#m_out_comment").val();
	
	
	var currentRecid = $('#m_recid').val();
	w2ui.grid_list.save();
	console.log('currentRecid : ' + currentRecid);	

	
	if(!chkSubmit($("#delivery_date"), "출하일자를")) return;
	
	if(!chkSubmit($("#m_out_user"), "담당자명을")) return;
	
	if(!chkSubmit($("#m_out_comment"), "출하사유를")) return;
	
	
	var keys = w2ui.grid_list.getSelection();
	

	 for(var i = 0 ; i< keys.length; i ++ )
	 {
		 var row = w2ui.grid_list.get(keys[i]);
		
		var possible_menge = row.delivery_order_menge - row.delivery_menge 
		var stock_menge = row.stock_menge;
		var send_delivery_menge = row.send_delivery_menge;
		

		
		/**
			팝업이 마지막꺼만 뜸
			에러 기억했다가 어딘지 보여주는 팝업으로 변경 ajax success 후에 처리 
		*/  
		if(row.success_status == 'Y' && row.success_status == 'I')
		{
			//fnMessageModalAlert('알림', '출하완료건 입니다.');	
			error1 = error1 + row.recid;
			
			if(i < Number(keys.length) - 1)
			{
				error1 = error1 + ', ';
			}	
			outResult();
			
		}else{ 

			if( (possible_menge < send_delivery_menge)|| send_delivery_menge <= 0)
			{
				fnMessageModalAlert('알림', '출하수량을 다시 확인해주세요.');	
				console.log(' 출하수량 잘못됨');
					    
				error2 = error2 + row.recid;
			
				if(i < Number(keys.length) - 1)
				{
					error2 = error2 + ', ';		
				}	
				
				outResult();
			
			}else{
					
					success = success + row.recid;
					if(i < Number(keys.length) - 1)
					{
						success = success + ', ';			
					}	
			        saveItem(row);

			}
		}
	 } 
	 setTimeout(loadList(), 2000);
	 setTimeout($("#modal_info2").modal('show'), 3000);

}

function outResult()
{
	var message = '';
	
	if(success.length > 0)
	{
		message = successTitle + '<br>' + ' &nbsp;' + success;
		message = message + '<br>';
	}
	
	if(error1.length > 0 || error2.length > 0  || error3.length > 0 )
	{	
		message = message + '<br>'+ errorTitle;
	}
	if(error1.length > 0)
	{
		message = message + '<br>' + errorCate1 + ' &nbsp;' + error1 ;
	}
	
	if(error2.length > 0)
	{
		message = message + '<br>' + errorCate2 + ' &nbsp;' + error2 ;
	}
	
	if(error3.length > 0)
	{
		message = message + '<br>' + errorCate3 + ' &nbsp;' + error3 ;
	}

	fnMessageModalAlert("결과", message);// Notification(MES)
	
}

var zerocheck;

function saveItem(row) {
	console.log('saveItem()');

	
	var send_delivery_menge = row.send_delivery_menge;
	var real_send_delivery_menge = row.send_delivery_menge;
	var delivery_num = row.delivery_num;
	var delivery_menge = row.delivery_menge;
	console.log("send_delivery_menge:::"+send_delivery_menge)
	zerocheck = 0;
	
	if(delivery_menge==0){
		
		var delivery_menge = row.send_delivery_menge;
		console.log("0일때delivery_menge::"+delivery_menge)
		zerocheck = 1;
		
	}
	
	var delivery_order_menge = row.delivery_order_menge;
	var delivery_date = $("#m_delivery_date").val();
	delivery_date = delivery_date.replace(/-/gi, "");
	
	var pre_delivery_date = row.delivery_date
	console.log("pre_delivery_date::::"+pre_delivery_date)
	//1999-12-11 - 없애기
	if(row.delivery_date != '' && row.delivery_date != undefined && row.delivery_date != null){
		
	pre_delivery_date = row.delivery_date.replace(/-/gi, "");
		
	}
	

	var item_code = row.item_code;
	var item_nm = row.item_nm;
	
	var out_user = $("#m_out_user").val();
	var out_comment = $("#m_out_comment").val();
	
	console.log('out_user : ' + out_user);
	console.log('out_comment : ' + out_comment);
	
	console.log("delivery_date:::"+delivery_date);
	console.log("pre_delivery_date:::"+pre_delivery_date);
	
	if(delivery_order_menge==(delivery_menge+send_delivery_menge) &&zerocheck!=1){
		console.log("부분적으로 넣은 후 다시 넣어 완료할때")
		
		if(delivery_date!=pre_delivery_date){
			console.log("날짜가 다를때")
			var delivery_menge = Number(send_delivery_menge);
			
		}else{
			console.log("날짜가 같을때")
// 			var delivery_menge = Number(delivery_order_menge);
			var delivery_menge = Number(send_delivery_menge);
			console.log("날짜가 같을때delivery_menge::"+delivery_menge)
			
		}

		var send_delivery_menge = 0;
		
		
		
	}else if(delivery_order_menge > (delivery_menge+send_delivery_menge)&&zerocheck!=1){
		console.log("부분적으로 넣은 후 다시 넣어도 완료가 아닐때")
		
		if(delivery_date!=pre_delivery_date){
			console.log("날짜가 다를때")
			var delivery_menge = Number(send_delivery_menge);
			
		}else{
			console.log("날짜가 같을때")
// 			var delivery_menge = Number(delivery_menge+send_delivery_menge);
			var delivery_menge = Number(send_delivery_menge);
			
		}	
		
		var send_delivery_menge = Number(delivery_order_menge-delivery_menge)
		
	}
	console.log("delivery_menge:::"+delivery_menge)
	console.log("send_delivery_menge:::"+send_delivery_menge)
	var strUrl = "/frontend/consumable/saveDeliveryMulti";
	FunLoadingBarStart();
	var postData = {
			 delivery_num : delivery_num,
			 delivery_menge : delivery_menge,
			 delivery_date : delivery_date,
			 send_delivery_menge : send_delivery_menge,
			 delivery_order_menge:delivery_order_menge,
			 item_code : item_code,
			 item_nm : item_nm,	
			 real_send_delivery_menge : real_send_delivery_menge,
			 
			 out_user : out_user,
			 out_comment : out_comment,
		}
			 
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
		async : false,	
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
	    		

	    		if(error1.length > 0 || error2.length > 0  || error3.length > 0 )

	    		{
	    			outResult();
	    		}else
	    		{
	    			console.log(' 정상');    			
//	    			fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
	    			
// 	    			w2ui['grid_list'].clear();
// 	    			loadList();
// 	    			w2ui['grid_list'].refresh();

	    		}

	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
 			$("#modal_info").modal('hide');
			FunLoadingBarEnd();
			//loadList();

// 			var data = w2ui.grid_list.get(row.recid);

// 			w2ui['grid_list'].refresh();
						
// 			console.log("data.delivery_num:::"+data.delivery_num)
// 	    	checkSuccessStatus(data.delivery_num, data.delivery_order_menge, data.delivery_menge, data.menge,data.send_delivery_menge);
	    	
// 			w2ui['grid_list'].refresh();
	    }
	});
}

function checkSuccessStatus(p_delivery_num, p_delivery_order_menge, p_delivery_menge,p_menge,p_send_delivery_menge)
{
	

// 	var keys = w2ui.grid_list.getSelection();
// 	 for(var i = 0 ; i< keys.length; i ++ )
// 	 {
// 		 var row = w2ui.grid_list.get(keys[i]);
// 		 if(row.success_status == "I" || row.success_status == "Y" ) {
// 				fnMessageModalAlert("알림", "이미 완료된 출하가 있습니다");
// 				//return;
// 			}
// 	 }
	
	console.log('지시수량 : ' + p_delivery_order_menge);
	console.log('실적수량 : ' + p_delivery_menge);
	console.log('주문수량 : ' + p_menge);
	console.log('미출하수량 : ' + p_send_delivery_menge);
	
	
	

	var delivery_num = p_delivery_num;
	var success_status = 'N';
	var delivery_order_menge = Number(p_delivery_order_menge);
	var delivery_menge = Number(p_delivery_menge);
	var send_delivery_menge = Number(p_send_delivery_menge);
	var menge = Number(p_menge);
	
// 	if(delivery_order_menge==(delivery_menge+send_delivery_menge)){
		
// 		delivery_menge = Number(p_delivery_order_menge);
// 		send_delivery_menge = 0;
		
// 	}
	
	console.log('delivery_order_menge : ' + delivery_order_menge);
	console.log('Number(p_delivery_menge) : ' + Number(p_delivery_menge));
	
	if(delivery_menge==menge){
		success_status = 'Y';
		console.log("출하완료")
		delivery_order_menge =  Number(p_delivery_menge);	
		
		
	}else if(delivery_order_menge < menge && delivery_order_menge == delivery_menge)
	{
		success_status = 'I';
		console.log("부분완료")
		delivery_order_menge;

			
	
	}else if(delivery_order_menge > p_delivery_menge)
	{

		success_status = 'N';
		console.log("미출하")

	}
	
	updateSuccessStatus(delivery_num, success_status, delivery_order_menge);

}



function updateSuccessStatus(delivery_num, success_status, delivery_order_menge) {

	console.log("updateSuccessStatus in ")
	var strUrl = "/frontend/consumable/updateSuccessStatus";

	var postData = {
			 delivery_num : delivery_num,
			 success_status : success_status,
			 delivery_order_menge : delivery_order_menge
		}
			 
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
		async : false,	
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	//fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)

		    	//loadList();
		    	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
			$("#modal_info").modal('hide');
	    	FunLoadingBarEnd();
	    
	    	w2ui['grid_list'].refresh();
	    }
	});
	console.log("updateSuccessStatus out")
}




function getDeliveryOrderMenge()
{
	var result = 0;
	var key = w2ui.grid_list2.getSelection();

	if( key.length==1 ) {	
		var data = w2ui.grid_list2.get(key[0]);
		result = data.delivery_menge;
	}
	
	return result;
}


function getDeliveryOrderMengeTot()
{
	
	var result = 0;
	var records = w2ui.grid_list.records;
	$.each(records, function(idx, row){
		
		result = Number(result) + Number(row.delivery_order_menge);
		
	});	
	
	console.log('getDeliveryOrderMengeTot : ' + result);
	
	return result;
}


var deleteItems = new Array;
//값 삭제시
function minus() {
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개이상 선택해야 합니다.');		
	}  else {
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				
				for(var i=0; i<chkLen; i++){
				 	var row = w2ui.grid_list.get(selIdxArr[i]);
				 	
				 	// 삭제 어레이에 추가 한다.
				 	objt = new Object();
				 	objt.delivery_num = row.delivery_num;
				 	objt.item_code = row.item_code;
				 	
					objt.delivery_date = row.delivery_date;
					//objt.order_num = getOrderNum();
				 	
				 	w2ui['grid_list'].remove(row.recid);
				 	
					if(row.delivery_menge != '' && row.delivery_menge != undefined && row.delivery_date != null)
					{
					
						console.log('row.delivery_num : ' + row.delivery_num);
						deleteItem(row.delivery_num, row.item_code, row.delivery_date);
					}
					
				}
		
			}
		});
	 } 
	w2ui.grid_list.selectNone();	
	w2ui['grid_list'].refresh();
	
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
		var delivery_num = data.delivery_num;
		var item_code = data.item_code;
		var delivery_date = data.delivery_date;
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				
				var strUrl = "/frontend/consumable/deleteDelivery";
				
				console.log("delivery_date" + delivery_date);

				var postData = "delivery_num=" + encodeURIComponent(delivery_num)
				+ "&item_code=" + encodeURIComponent(item_code)
				+ "&delivery_date=" + encodeURIComponent(delivery_date);
				
				$.ajax({
					 url: strUrl,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
					 		console.log(data);
					 		
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


//-------------------------------------------------------------------------------------------------------------------


//엑셀 다운로드
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;
	console.log("gridData:::"+gridData)

	var fileName = '출하실적관리.xlsx';
	var sheetTitle = '출하실적관리';
	var sheetName = '출하실적관리';
	
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
		console.log("param_col_name:::"+param_col_name);
		console.log("param_col_id:::"+param_col_id);
		console.log("param_col_align:::"+param_col_align);
		console.log("param_col_width:::"+param_col_width);
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
		console.log("JSON.stringify(gridData):::"+JSON.stringify(gridData))
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

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
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