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
		<jsp:param name="selected_menu_cd" value="1046" />
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
						<h3 class="box-title">출하지시  조회</h3>
						<div class="box-tools pull-right">
							<!-- <button type="button" id="btn_search" class="btn btn-danger btn-sm" 
								onclick="deleteItem();">삭제</button>	 -->
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
											class="btn btn-warning btn-sm">금일</button>
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
						<div id="grid_list" style="width: 100%; height: 300px;"></div>
						<div id="grid_list_tot" style="width: 100%; height: 60px;"></div>
					</div>
				</div>
				
						
				<div class="row" style="padding:15px;">		
					<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">출하 실적 등록</h3>
							<div class="box-tools pull-right">
						     	<button type="button" id="btn_create" 
									class="btn btn-success btn-sm" onclick="plus();">추가</button>
								<button type="button" id="btn_create" 
									class="btn btn-danger btn-sm" onclick="minus();">삭제</button>
							</div>
						</div>
						<div id="grid_list2" style="height: 200px; margin:10px;"></div>
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
				<h4 class="modal-title" id="modal_code_title">출하 </h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
			
					
					<input type="hidden" class="form-control input-sm pull-right clear_val" id="m_recid" maxlength="100"/>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">담당자</label>
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

 	init_grid_list2();
	fnLoadCommonOption(); 
	
	w2ui['grid_list'].clear();
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
	
})

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
            footer: true
        },
        multiSelect: false,
        columns: [                
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
			{ field:'request_num', caption:'발주번호', size:'12%' , sortable: true, style:'text-align:center'}, // 120px
			{ field:'delivery_order_date', caption:'주문일자', size:'10%' , sortable: true, style:'text-align:center'}, // 120px
			{ field:'customer_nm', caption:'고객사', size:'20%' , sortable: true, style:'text-align:center'},
			{ field:'land', caption:'사업장', size:'10%' , sortable: true, style:'text-align:center'},
			{ field:'item_code', caption:'P/N', size:'12%' , sortable: true, style:'text-align:center'}, // right // 120px
			{ field:'item_nm', caption:'품명', size:'22%' , sortable: true, style:'text-align:center'},
			{ field:'unit_price', caption:'단가', size:'10%' , sortable: true, style:'text-align:center'
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }    	
			},

			{ field:'menge', caption:'주문요청수량', size:'13%' , sortable: true, style:'text-align:center'},
			{ field:'stock_menge', caption:'재고수량', size:'13%' , sortable: true, style:'text-align:center', hidden : true},
			{ field:'delivery_order_menge', caption:'출하지시수량', size:'13%' , sortable: true, style:'text-align:center'},
			{ field:'delivery_menge', caption:'출하실적수량', size:'13%' , sortable: true, style:'text-align:center'
				
				,render: function (record, index, col_index) {
		               var html = this.getCellValue(index, col_index);
		         
		               if(html == null || html == '')
		           		{
		            	   html = 0;
		            	 }
		               return html;
		           } 	
			
			},
			{ field:'total_price', caption:'총금액', size:'10%' , sortable: true, style:'text-align:center'
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }    	
			},
			
			{ field:'creator_nm', caption:'등록자', size:'10%', style:'text-align:center'}

			], 
		records: [
	
		          
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onSelect: function (event) {
			
		},
		onClick: function (event) {
			event.onComplete = function () {
				
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list2'].refresh();
				// 오른쪽 그리드
				loadList2(data.delivery_num, data.item_code);
			}
		}
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
      		{ field:'delivery_num', caption:'주문번호', size:'12%', style:'text-align:center', hidden : true},
			{ field:'item_code', caption:'P/N', size:'14%', style:'text-align:center',sortable :true},
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center',sortable :true}, // right // 120px
			{ field:'stock_menge', caption:'재고수량', size:'10%', style:'text-align:center',sortable :true
				
				,render: function (record, index, col_index) {
		               var html = this.getCellValue(index, col_index);
		    
		               
		               if(html == null || html == '')
		           		{
		            	   html = 0;
		            	 }
		               return html;
		           } 	 
			},
			{ field:'delivery_menge', caption:'출하수량', size:'10%', style:'text-align:center', editable: { type: 'int' },sortable :true},
			{ field:'delivery_date', caption:'출하일자', size:'15%', style:'text-align:center' , editable: { type: 'date'},sortable :true},
			{ field:'save_yn', caption:'저장', size:'15%', style:'text-align:center',sortable :true},// 120px
			{ field:'creator_nm', caption:'등록자', size:'10%', style:'text-align:center',sortable :true}
			], 
		/* sortData: [{field: 'vendor_code', direction: 'ASC'}], */
		records: [
		
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {
			
		},
		onChange: function(event) {
			
			event.onComplete = function () {
				
				var eventColumn = event.column;
				console.log(event);
				w2ui.grid_list2.save();
				
			}
	
		}	
	});

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
			{ field:'', caption:'', size:'15%' , sortable: true, style:'text-align:center'}, // 80px
			{ field:'', caption:'', size:'10%' , sortable: true , style:'text-align:center'}, // 200px
			{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'}, // 120px
			{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'}, // 120px
			{ field:'', caption:'', size:'10%' , sortable: true, style:'text-align:center'}, // 120px
			{ field:'', caption:'', size:'20%' , sortable: true, style:'text-align:center'},
			{ field:'', caption:'', size:'10%' , sortable: true, style:'text-align:center'},
			{ field:'', caption:'', size:'12%' , sortable: true, style:'text-align:center'}, // right // 120px
			{ field:'', caption:'', size:'22%' , sortable: true, style:'text-align:center'},
			{ field:'', caption:'', size:'13%' , sortable: true, style:'text-align:center'},
			{ field:'', caption:'', size:'13%' , sortable: true, style:'text-align:center'},
			{ field:'unit_price_tot', caption:'', size:'10%' , sortable: true, style:'text-align:center'},
			{ field:'delivery_menge_tot', caption:'출하실적수량', size:'13%' , sortable: true, style:'text-align:center'},
			{ field:'total_price_tot', caption:'총금액', size:'25%' , sortable: true, style:'text-align:center'},
			
			

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
		          			 { recid:'g1',unit_price_tot : "합계",  total_price_tot : '' , menge_tot : '', delivery_order_menge_tot : '', delivery_menge_tot : ''}
		          	     ]);

}

//상단 리스트 조회
var gridDataArr;
function loadList()
{
	w2ui['grid_list'].clear();
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
	
	var startValue_combo = "";
	comboValue_nm1 = new Array;
	comboValue_nm2 = new Array;
	comboValue_nm3 = new Array;
	
	console.log("loadList()");
	   
	var delivery_date = $("#delivery_date").val();
		delivery_date = delivery_date.replace()
	var customer_nm = $("#customer_nm").val();
	var request_num = $("#request_num").val();
	var item_code = $("#item_code").val();
		
	var rdo_status_date = $(':radio[name="rdo_status_date"]:checked').val();
	var success_status = $(':radio[name="rdo_status_type"]:checked').val();
	
	var page_url = "/frontend/consumable/selectDeliveryOrder";

	//w2ui['grid_list'].lock('loading...', true);
	var postData = "customer_nm=" + encodeURIComponent(customer_nm)
	 +"&success_status=" + encodeURIComponent(success_status)
	 +"&request_num=" + encodeURIComponent(request_num)
	 +"&item_code=" + encodeURIComponent(item_code)
	 + "&"+rdo_status_date+"=" + encodeURIComponent(delivery_date);
	
	

	
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
					row.total_price = Number(row.unit_price)*Number(row.delivery_menge);
					row.stock_menge = Number(row.stock_menge);
					row.delivery_order_menge = Number(row.delivery_order_menge);
					row.delivery_menge = Number(row.delivery_menge);
					
					//if(row.customer_nm)comboValue_nm1.push(row.customer_nm);
					//if(row.request_num)comboValue_nm2.push(row.request_num);
					
					row.send_delivery_menge = Number(row.delivery_order_menge) - Number(row.delivery_menge);
				});
				
				w2ui['grid_list'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			if (startValue_combo == "") {
				console.table("comboValue_nm2:::"+comboValue_nm2);
				$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
				console.table("comboValue_nm3:::"+comboValue_nm3);
				$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm3,false) , match : 'contains' });
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
			document.getElementById("item_code").style.removeProperty("height");
			
			
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
		
		console.log("00000000000000000000");
 		
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


function checkValue(type)
{
	
	w2ui.grid_list2.save();
	var result = false;
	var selIdxArr = w2ui.grid_list.getSelection();
	var gridData = w2ui.grid_list.get(selIdxArr[0]);
	
	
	// 주문요청수량
	var menge = gridData.menge;
	// 출하지시수량
	var delivery_order_menge = gridData.delivery_order_menge;
	
	var records = w2ui.grid_list2.records;
	
	// 2번쨰 그리드의 출하수량의 합 
	/**
		if 두번쨰 그리드의 출하수량의 합 = 첫번째그리드의 출하지시수량   -> 출하완료
		
	*/
	var delivery_menge_tot = 0;
	$.each(records, function(idx, row){
			
		delivery_menge_tot = Number(delivery_menge_tot) + Number(row.delivery_menge);
	});
	
	
	// 조금후
	
	
	
	console.log('delivery_order_menge : ' + delivery_order_menge);
	console.log('delivery_menge_tot : ' + delivery_menge_tot);
	
	if(type == 'save')
	{
	
		if(delivery_order_menge < delivery_menge_tot)
		{
			result = true;	
		}
	}else if(type == 'plus')
	{
		if(delivery_order_menge <= delivery_menge_tot)
		{
			result = true;	
		}
	}
	else if(type == 'minus')
	{
		
	}
	
	return result;
}

//-------------------------------------------------------------------------------------------------------------------


function plus() {
	console.log("plus()");
	
	
	
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '항목을 선택해주세요.');
		return;
	} 
	
	if( checkValue('plus')) {
		fnMessageModalAlert('알림', '출하수량의 합은 주문요청수량보다 클 수 없습니다.');
		
		return;
	}
	
	
	var gridData = w2ui.grid_list.get(selIdxArr[0]);
	
	
	w2ui.grid_list2.selectNone();
	w2ui['grid_list2'].refresh();
	var rowArr = w2ui['grid_list2'].records; 

	var currentRecid =  Number(rowArr.length) + 1;
	
	
	
	var delivery_menge  = Number(gridData.delivery_order_menge) -  Number(gridData.delivery_menge);
	
	
	if( Number(delivery_menge) <= 0)
	{
		delivery_menge = Number(gridData.menge) - Number(gridData.delivery_menge);
	}
	
	/* w2ui['grid_list2'].add([
		{ recid:  currentRecid , delivery_num : gridData.delivery_num, item_code : gridData.item_code, item_nm: gridData.item_nm, stock_menge: gridData.stock_menge,
			delivery_menge : delivery_menge, delivery_date : '',
			save_yn : '<input type="button" name="btn_save" value=" 미저장 " onClick="btnClick('+currentRecid+');">'
			}
	]); */
	
	w2ui['grid_list2'].add([
         		{ recid:  currentRecid , delivery_num : gridData.delivery_num, item_code : gridData.item_code, item_nm: gridData.item_nm, stock_menge: gridData.stock_menge,
         			delivery_menge : delivery_menge, delivery_date : '',
         			save_yn : '<input type="button" name="btn_save" value=" 미저장 " onClick="requestOut('+currentRecid+');">'
         			}
         	]);
	
	w2ui.grid_list2.save();

}

function requestOut(recid)
{
	console.log('requestOut()');
	
	
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '출하지시항목을 선택해주세요.');
		return;
	} 
	
	
	
	$('#m_recid').val(recid);
	$('#m_out_user').val('');
	$('#m_out_comment').val('');
	
	$("#modal_info").modal('show');

}
function saveOut()
{
	var out_user = $("#m_out_user").val();
	var out_comment = $("#m_out_comment").val();
	
	console.log('out_user : ' + out_user);
	console.log('out_comment : ' + out_comment);
	
	
	var currentRecid = $('#m_recid').val();
	w2ui.grid_list2.save();
	console.log('currentRecid : ' + currentRecid);	

	var rowArr = w2ui['grid_list2'].records; 
	console.log("rowArr.length:::"+rowArr.length);
	console.log("rowArr[0].delivery_date:::"+rowArr[0].delivery_date);
	
// 	if(rowArr.length>0){
// 	for(var i=0; i<rowArr.length; i++){
// 		if(rowArr[i].delivery_date==rowArr[i+1].delivery_date){
// 			fnMessageModalAlert('알림', '출하일자는 중복되게 추가할 수 없습니다.');
// 			return;
// 		}
// 	}
// 	}

	var row = rowArr[currentRecid-1];
	console.log('item_code : ' + row.item_code);
	console.log('save_yn : ' + row.save_yn);
	if( row.delivery_menge == '' || row.delivery_date == '' || row.delivery_menge < 0) {
		fnMessageModalAlert('알림', '출하수량 또는 출하일자를 다시 확인해주세요.');
		return;
	}
	
// 	else if(){
		
// 	}
	
	console.log('saveOut() : ' + row.item_code);	
	
	if( checkValue('save')) {
		fnMessageModalAlert('알림', '출하수량의 합은, 주문요청수량보다 클 수 없다.');
		
		return;	
	}
	

	
	if(!chkSubmit($("#m_out_user"), "담당자명을")) return;
	
	if(!chkSubmit($("#m_out_comment"), "출하사유를")) return;
	
	saveItem(row);
}


function btnClick(currentRecid)
{
	w2ui.grid_list2.save();
	console.log('currentRecid : ' + currentRecid);	

	var rowArr = w2ui['grid_list2'].records; 
	var row = rowArr[currentRecid-1];
	console.log('item_code : ' + row.item_code);	
	console.log('save_yn : ' + row.save_yn);
	if( row.delivery_menge == '' || row.delivery_date == '' ) {
		fnMessageModalAlert('알림', '출하수량 또는 출하일자를 입력해주세요.');
		return;
	} 
	console.log('btnClick() : ' + row.item_code);	
	
	if( checkValue('save')) {
		fnMessageModalAlert('알림', '출하수량의 합은, 주문요청수량보다 클 수 없다.');
		
		return;	
	}
	
	saveItem(row);
}


function saveItem(row) {
	console.log('saveItem()');


	var delivery_num = row.delivery_num;
	var delivery_menge = row.delivery_menge;
	var delivery_date = row.delivery_date;
	delivery_date = delivery_date.replace(/-/gi, "");

	var item_code = row.item_code;
	var item_nm = row.item_nm;
	
	var out_user = $("#m_out_user").val();
	var out_comment = $("#m_out_comment").val();
	console.log('out_user : ' + out_user);
	console.log('out_comment : ' + out_comment);

	var strUrl = "/frontend/consumable/saveDelivery";
	FunLoadingBarStart();
	var postData = {
			 delivery_num : delivery_num,
			 delivery_menge : delivery_menge,
			 delivery_date : delivery_date,

			 item_code : item_code,
			 item_nm : item_nm,	
			 
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
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)

		    	w2ui['grid_list2'].set(row.recid,{save_yn : '<input type="button" name="btn_save" value=" 저장 " onClick="requestOut('+row.recid+');">'});
		    	
		    	var selekey = w2ui.grid_list.getSelection();
		    	var selekeynum = Number(selekey);
		    	console.log("selekey::"+selekey);
		    	w2ui['grid_list'].select(selekeynum);
		    	
		    	loadList();
		    	
		    	w2ui['grid_list'].select(selekeynum);

		    	var key = w2ui.grid_list.getSelection();
				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list2'].refresh();
		    	checkSuccessStatus(data.delivery_num, data.delivery_order_menge, data.menge, data.delivery_menge);
				loadList2(data.delivery_num, data.item_code);
	
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

function checkSuccessStatus(p_delivery_num, p_delivery_order_menge, p_menge, p_delivery_menge)
{
	
	console.log('주문요청수량 : ' + p_menge);
	console.log('출하지시수량 : ' + p_delivery_order_menge);
	console.log('출하실적수량 : ' + p_delivery_menge);
	
	var result = 0;
	var records = w2ui.grid_list2.records;
	
	console.log('records.length : ' + records.length);
	$.each(records, function(idx, row){
		
		console.log('Number(row.delivery_menge) : ' + Number(row.delivery_menge));
		result = Number(result) + Number(row.delivery_menge);
		
	});	
	

	var delivery_num = p_delivery_num;
	var success_status = 'N';
	var delivery_order_menge = Number(p_delivery_order_menge);
	var delivery_menge = Number(p_delivery_menge);
	var menge = Number(p_menge);
	
	console.log('delivery_order_menge : ' + delivery_order_menge);
	console.log('Number(result) : ' + Number(result));
	
	if(menge == delivery_menge && menge == delivery_order_menge){
		success_status = 'Y';
		console.log("출완")
		/* delivery_order_menge =  Number(result);	 */
	
	}else if(delivery_order_menge < menge && delivery_order_menge == delivery_menge){

		success_status = 'I';
		console.log("부완")

	}else
	{

		success_status = 'N';
		console.log("미출")

	}
	
	updateSuccessStatus(delivery_num, success_status, delivery_order_menge);

}



function updateSuccessStatus(delivery_num, success_status, delivery_order_menge) {


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
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)

		    	loadList();
		    	
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
			//$("#modal_info").modal('hide');
	    }
	});
}



var deleteItems = new Array;
//오른쪽 그리드에 값 삭제시
function minus() {
	
	var selIdxArr1 = w2ui.grid_list.getSelection();
	var chkLen1 = selIdxArr1.length;
	if( chkLen1==0 ) {
		fnMessageModalAlert('알림', '출하지시항목을 선택해주세요.');
		return;
	} 
	
	
	var selIdxArr = w2ui.grid_list2.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개이상 선택해야 합니다.');		
	}  else {
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				
				for(var i=0; i<chkLen; i++){
				 	var row = w2ui.grid_list2.get(selIdxArr[i]);
				 	
				 	// 삭제 어레이에 추가 한다.
				 	objt = new Object();
				 	objt.delivery_num = row.delivery_num;
				 	objt.item_code = row.item_code;
				 	
					objt.delivery_date = row.delivery_date;
					//objt.order_num = getOrderNum();
				 	
				 	w2ui['grid_list2'].remove(row.recid);
				 	
					if(row.delivery_menge != '' && row.delivery_menge != undefined && row.delivery_date != null)
					{
					
						console.log('row.delivery_num : ' + row.delivery_num);
						row.delivery_date = row.delivery_date.replace(/-/gi, "");
						deleteItem(row.delivery_num, row.item_code, row.delivery_date);
					}
					
				}
				
				w2ui.grid_list2.selectNone();	
				w2ui['grid_list2'].refresh();
		
			}
		});
	 } 


	
}



//삭제
function deleteItem(delivery_num, item_code, delivery_date) {
	console.log('deleteItem()');
		
	var strUrl = "/frontend/consumable/deleteDelivery";

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
		    
				
				var selekey = w2ui.grid_list.getSelection();
		    	var selekeynum = Number(selekey);
		    	console.log("selekey::"+selekey);
		    	w2ui['grid_list'].select(selekeynum);
		    	
		    	loadList();
		    	
		    	w2ui['grid_list'].select(selekeynum);
		    	var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
		
		    	
				w2ui['grid_list2'].refresh();
				loadList2(data.delivery_num, data.item_code);
		    	checkSuccessStatus(data.delivery_num, data.delivery_order_menge);
		 	}
		 },
		 error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
		 },
		 complete: function() {
		 }
	}); 
			

	
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

//-------------------------------------------------------------------------------------------------------------------

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