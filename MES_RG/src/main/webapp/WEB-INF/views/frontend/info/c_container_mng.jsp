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
	
	<style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	</style>
</head>

<style>
.tabs {
    color : #ffffff;
}
</style>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1015" />
		<jsp:param name="selected_menu_cd" value="1037" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      창고관리
        <small>창고관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>창고관리</a></li><li class="active">창고관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">재고현황</h3>
						<div class="box-tools pull-right">
						   	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>Business</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="business" name="business" class="form-control" style="height: 30px;" ></select>
									</div>
								</div>
							</div>							
							
							<!-- <div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>자재유형</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="item_type" name="item_type" class="form-control" style="height: 30px;" ></select>
									</div>
								</div>
							</div> -->		
							
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>창고</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="warehouse" name="warehouse" class="form-control" style="height: 30px;" ></select>
									</div>
								</div>
							</div>		
							
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> 
									 <input type="text" id="item_code" name="item_code" class="form-control input-sm" placeholder="P/N" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>품명</label> 
									 <input type="text" id="item_nm" name="item_nm" class="form-control input-sm" placeholder="품명" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
								
							<!-- <div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> 
									<input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" maxlength="10" /> 자재코드
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>제품명</label> 
									<input type="text" id="item_nm" name="item_nm" placeholder="ex) 제품명"
									 class="form-control input-sm" maxlength="10" />
								</div>
							</div> -->
							
						</div>
				
						<div id="grid_list" style="width: 100%; height: 600px;"></div>
						<div id="grid_list2" style="width: 100%; height: 60px;"></div>
					</div>
				
					
				
				</div>
				
				
				
				
				
				
			</section>
		</div>
	</section>
	
    <!-- /.content -->
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
var startValue_combo2 = "";

var comboValue_nm = new Array;
var comboValue_cd = new Array;

$(function($) {
 	fnLoadCommonOption(); 	 
 	
 	slcMaterial();
 	fnCdD('business', 'MC1012');
//  	fnCdD('item_type', 'MC1014');
 	
 	init_grid_list();
 	
 	init_grid_list2();
 	
 	
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
		$('#macc_chndate, #m_delivery_day, #m_order_day').daterangepicker({
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



$("#business").change(function(){
	var val = $("#business option:selected").val();
	if(val == "ALL") {
		$("#warehouse option:eq(0)").prop("selected", true);	
		$("#warehouse").attr("disabled", true);
	} else {
		$("#warehouse").attr("disabled", false);
		slcWarehouse('warehouse', val);
	}
	loadList();
});

// $("#item_type").change(function(){
// 	loadList();
// });

$("#warehouse").change(function(){
	loadList();
});

var materialArr = new Array;

function slcMaterial() {
	console.log("slcMaterial()");
	
	var page_url = "/info/material/selectMaterial";
// 	var postData = "item_code=" + encodeURIComponent($("#item_code").val())
// 	 + "&item_nm=" + encodeURIComponent($("#item_nm").val());
	
	$.ajax({
		url : page_url,
		type : 'POST',
// 		data : postData, 
 		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				materialArr = rowArr;
				$.each(rowArr, function(idx, row){
					comboValue_nm.push(row.item_nm);
					comboValue_cd.push(row.item_code);
				});
				if (startValue_combo2 == "") {
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
					
				}
				
			}
		},complete: function () {
			startValue_combo2 = ":)";
			
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
		}
	});
}

function slcWarehouse(val){
	console.log("slcWarehouse("+val+")");
	
	initOptions($('#'+val)); // select 박스 초기화
	
	var strUrl = "/frontend/warehouse/selectWarehouse_master_header";
	var postData = "";
	
	if( $("#business option:selected").val() != "ALL" ) {
		postData = "business_code=" + encodeURIComponent($("#business option:selected").val());
		postData += "&business_codeT=" + "";
		if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
			postData +=  encodeURIComponent("MD1282");	
		}
	}
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
// 	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		var sub = val.substr(0,2);
	    		
	    		//  if(valsub != "m_")
	   /*  		if(sub.indexOf("m_") == -1) // val
	    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>"); */
	    		
				$.each(rowArr, function(idx, row){
					$("#"+val ).append("<option value=" + row.warehouse_code + ">" + row.warehouse_nm + "</option>");
				});
				
	 			$("#"+val+" option:eq(0)").prop("selected", true);	
	 			if( val == "business" ) {
	 				$("#"+val+" option:eq(1)").prop("selected", true);	
	 			}
	    			
	 			
	    	} else if(data.status == "200" && (data.rows).length==0 ) {
	    		initOptions($('#'+val)); // select 박스 초기화
	    		$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
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
// 	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		if(val != "routingGubun") {
		    		var sub = val.substr(0,2);
		    		
		    		//  if(valsub != "m_")
		    		if(sub.indexOf("m_") == -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						if( val == "business" && row.detail_code == "MD1282" || row.detail_code == "MD1526" ) {
							
						} else {
							$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						}
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		 			if( val == "business" ) {
		 				$("#"+val+" option:eq(1)").prop("selected", true);	
		 			}
	    		} else {
	    			var objt = new Object();
	    			$.each(rowArr, function(idx, row){
	    				objt = new Object();
	    				objt.filter1_val = row.filter1_val;
	    				objt.text = row.code_nm;
	    				objt.id = row.detail_code;
	    				
	    				routingGubun.push(objt);
	    			});
// 	    			console.log("routingGubun");
// 	    			console.log(routingGubun);
	    		}	
	 			
	    	} else if(data.status == "200" && (data.rows).length==0 && val != "routingGubun" ) {
	    		initOptions($('#'+val)); // select 박스 초기화
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	slcWarehouse('warehouse', 'MD1243');
	    }
	});
	
}


function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
        	selectColumn: false,
			lineNumbers : false,
			
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'business_code', caption:'Business Code', size:'20%', style:'text-align:center', hidden: true},
			{ field:'business_nm', caption:'Business', size:'15%', style:'text-align:center', sortable: true},
			{ field:'warehouse_code', caption:'Warehouse Code', size:'20%', style:'text-align:center', hidden: true},
			{ field:'warehouse_nm', caption:'창고', size:'10%', style:'text-align:center', sortable: true}, 
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center', sortable: true}, 
			{ field:'item_spec', caption:'자재내역', size:'20%', style:'text-align:center', hidden: true},
			{ field:'item_type_code', caption:'자재유형코드', size:'20%', style:'text-align:center', hidden: true},
			{ field:'item_type_nm', caption:'자재유형명', size:'20%', style:'text-align:center', hidden: true},
			{ field:'meins', caption:'단위', size:'20%', style:'text-align:center', hidden: true},
			{ field:'warehousing_price', caption:'단가', size:'15%', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              } 
			},
			{ field:'safety_stock_qty', caption:'안전 재고 수량', size:'10%', style:'text-align:center', sortable: true}, 
			{ field:'warehousing_qty', caption:'재고 수량', size:'10%', style:'text-align:center', sortable: true}, 
			{ field:'price', caption:'재고 금액', size:'15%', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              } 
			}
			], 
	/* 	sortData: [{field: 'vendor_code', direction: 'ASC'}], */
		records: [ ],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	loadList();
}


function grid_list_tot()
{
	
	setTimeout(function(){
	      w2ui['grid_list2'].resize();
	      w2ui['grid_list2'].refresh();

	   }, 200);
	
	var rowArr3 = w2ui['grid_list'].records; 
	
	var tot_warehousing_price = 0;	
	var tot_safety_stock_qty = 0;
	var tot_warehousing_qty = 0;
	var tot_price = 0;
	
	currentRecid = Number(i) + 1;
	
	console.log("lenght?????" + rowArr3.length);

	for(var i = 0; i < rowArr3.length; i ++)
	{
		var data = rowArr3[i];
		
		
		var warehousing_price = data.warehousing_price;
		if(warehousing_price == '' ||  warehousing_price == 'null' 
				|| warehousing_price == undefined ||  warehousing_price == 'undefined')
		{
			warehousing_price = 0;
		}
		
		var safety_stock_qty = data.safety_stock_qty;
		if(safety_stock_qty == '' ||  safety_stock_qty == 'null' 
				|| safety_stock_qty == undefined ||  safety_stock_qty == 'undefined')
		{
			safety_stock_qty = 0;
		}
		
		var warehousing_qty = data.warehousing_qty;
		if(warehousing_qty == '' ||  warehousing_qty == 'null' 
				|| warehousing_qty == undefined ||  warehousing_qty == 'undefined')
		{
			warehousing_qty = 0;
		}
		
		var price = data.price;
		if(price == '' || price == 'null' 
				|| price == undefined ||  price == 'undefined')
		{
			price = 0;
		}
		
		console.log("i??" + i);
		console.log("warehousing_price??" + warehousing_price);
		console.log("warehousing_qty??" + warehousing_qty);
		console.log("price??" + price);
		
		tot_warehousing_price = tot_warehousing_price + parseInt(warehousing_price);
		tot_safety_stock_qty = tot_safety_stock_qty + parseInt(safety_stock_qty);
		tot_warehousing_qty = tot_warehousing_qty + parseInt(warehousing_qty); 
		tot_price = tot_price + parseInt(price); 
		

	}
	
	
	tot_warehousing_price = w2utils.formatters['number'](tot_warehousing_price);
	tot_price = w2utils.formatters['number'](tot_price); 

		               	
	w2ui['grid_list2'].set('g1',{ tot_warehousing_price : tot_warehousing_price, tot_safety_stock_qty : tot_safety_stock_qty 
									, tot_warehousing_qty : tot_warehousing_qty, tot_price : tot_price});
	
}

function init_grid_list2(){
	var rowArr = [];
	
	$('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
			//lineNumbers : true,
            footer: false,
            lineNumbers : false,
            selectColumn: false
        },
        multiSelect: false,
        
        columns: [                
      
				{ field:'', caption:'', size:'20%', style:'text-align:center', hidden: true},
				{ field:'', caption:'', size:'15%', style:'text-align:center', sortable: true},
				{ field:'', caption:' Code', size:'20%', style:'text-align:center', hidden: true},
				{ field:'', caption:'', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'', caption:'', size:'10%', style:'text-align:center', sortable: true},
				{ field:'', caption:'', size:'20%', style:'text-align:center', sortable: true}, 
				{ field:'', caption:'', size:'20%', style:'text-align:center', hidden: true},
				{ field:'', caption:'', size:'20%', style:'text-align:center', hidden: true},
				{ field:'', caption:'', size:'20%', style:'text-align:center', hidden: true},
				{ field:'', caption:'', size:'20%', style:'text-align:center', hidden: true},
				{ field:'tot_warehousing_price', caption:'합계', size:'15%', style:'text-align:center', sortable: true},
				{ field:'tot_safety_stock_qty', caption:'', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'tot_warehousing_qty', caption:'', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'tot_price', caption:' ', size:'15%', style:'text-align:center', sortable: true}
			
			], 
			
		records: [
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	
		w2ui['grid_list2'].add([
	          			 { recid:'g1', tot_warehousing_price : '' , tot_safety_stock_qty : '' , tot_warehousing_qty : '', tot_price : ''}
	          	     ]);

}


function loadList() {
	console.log("loadList()");
	
	var vv1 = "0"; //
	var vv2 = "0"; // 
	var vv3 = "0"; // 
	
	var page_url = "/frontend/warehouse/selectWarehouse";
	// 5
	var postData = "item_code=" + encodeURIComponent($("#item_code").val())
	 + "&item_nm=" + encodeURIComponent($("#item_nm").val());

	// Business
	if( $("#business option:selected").val() != "ALL") {
		postData += "&business_code=" + encodeURIComponent($("#business option:selected").val());
		postData += "&business_codeT=" + "";
		if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
			postData +=  encodeURIComponent("MD1282");	
		}
	} else {
		postData += "&business_code=" + encodeURIComponent("");
	}
	

	
	// Warehouse
	if( $("#warehouse option:selected").val() != "ALL") {
		postData += "&warehouse_code=" + encodeURIComponent($("#warehouse option:selected").val());
	} else {
		postData += "&warehouse_code=" + encodeURIComponent("");
	}
	var warehouse_code = $("#warehouse option:selected").val();
	if(warehouse_code == 'wm19')
	{
		page_url = "/frontend/consumable/selectWarehouseRaw";
		
		
		postData +=  "&out_warehousing_status=" + encodeURIComponent('i');
	}
	
	
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				w2ui.grid_list.clear();
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					if(row.warehousing_price == "") {
						row.warehousing_price = 0;
					}
					if(row.warehousing_qty == "") {
						row.warehousing_qty = 0;
					}
					// 재고금액(price)은 단가(warehousing_price)*재고수량(warehousing_qty)
					row.price = parseInt(row.warehousing_price)*parseInt(row.warehousing_qty);
					
					row.warehousing_price = Number(row.warehousing_price);				
					row.safety_stock_qty = Number(row.safety_stock_qty);
					row.warehousing_qty = Number(row.warehousing_qty);
					row.price = Number(row.price);
					
					vv1 = parseInt(vv1) + parseInt(row.safety_stock_qty);
					vv2 = parseInt(vv2) + parseInt(row.warehousing_qty);
					vv3 = parseInt(vv3) + parseInt(row.price);
// 					 if (startValue_combo == "") {
// 						comboValue_nm.push(row.item_nm);
// 						comboValue_cd.push(row.item_code);
// 					} 
				});
				w2ui['grid_list'].records = rowArr;
// 				 if (startValue_combo == "") {
// 					 $('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
// 					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
// 				} 

				w2ui.grid_list.add([
				       				{	recid : 's', 
				       					business_code : '', business_nm : '', warehouse_code : '', warehouse_nm : '', 
				       					item_code : '', item_nm : '', item_spec : '',
				       					item_type_code : '', item_type_nm : '', meins : '',
				       					safety_stock_qty : '', warehousing_qty : '', price : ''
				       				} , 
				       			  	    
				       			]);
				
				
			} else {
				w2ui.grid_list.clear();
			}
			
			
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		},complete: function () {
// 			 startValue_combo = ":)"; 
	
			 grid_list_tot();
		}
	});
	
}

function loadList2() {
	console.log("loadList2()");
	var vv1 = "0"; //
	var vv2 = "0"; // 
	var vv3 = "0"; // 

	// 5
	var postData = "item_code=" + encodeURIComponent($("#item_code").val())
	 + "&item_nm=" + encodeURIComponent($("#item_nm").val());

	// Business
	if( $("#business option:selected").val() != "ALL") {
		postData += "&business_code=" + encodeURIComponent($("#business option:selected").val());
		postData += "&business_codeT=" + "";
		if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
			postData +=  encodeURIComponent("MD1282");	
		}
	} else {
		postData += "&business_code=" + encodeURIComponent("");
	}
	
	// Warehouse
	if( $("#warehouse option:selected").val() != "ALL") {
		postData += "&warehouse_code=" + encodeURIComponent($("#warehouse option:selected").val());
	} else {
		postData += "&warehouse_code=" + encodeURIComponent("");
	}

	
	var page_url = "/frontend/consumable/selectWarehouseRaw";

	
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				w2ui.grid_list.clear();
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					if(row.warehousing_price == "") {
						row.warehousing_price = 0;
					}
					if(row.warehousing_qty == "") {
						row.warehousing_qty = 0;
					}
					// 재고금액(price)은 단가(warehousing_price)*재고수량(warehousing_qty)
					row.price = parseInt(row.warehousing_price)*parseInt(row.warehousing_qty);
					

					vv1 = parseInt(vv1) + parseInt(row.safety_stock_qty);
					vv2 = parseInt(vv2) + parseInt(row.warehousing_qty);
					vv3 = parseInt(vv3) + parseInt(row.price);
					/* if (startValue_combo == "") {
						comboValue_nm.push(row.item_nm);
						comboValue_cd.push(row.item_code);
					} */
				});
				w2ui['grid_list'].records = rowArr;
				 if (startValue_combo == "") {
					$('#item_nm').w2field('combo', { items: comboValue_nm });
					$('#item_code').w2field('combo', { items: comboValue_cd });
				} 

				w2ui.grid_list.add([
				       				{	recid : 's', 
				       					business_code : '', business_nm : '', warehouse_code : '', warehouse_nm : '', 
				       					item_code : '', item_nm : '', item_spec : '',
				       					item_type_code : '', item_type_nm : '', meins : '',
				       					safety_stock_qty : '', warehousing_qty : '', price : ''
				       				} , 
				       			  	     
				       			]);
			
			} else
			{
				w2ui['grid_list'].clear();
			}
			
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		},complete: function () {
			 startValue_combo = ":)"; 
				document.getElementById("item_code").style.removeProperty("height");
				document.getElementById("item_nm").style.removeProperty("height");
				
				grid_list_tot();
		
		}
	});
	
} 

// $("#item_code").change(_.debounce(function(event) 
// 		{
	
// 			var item_code = $("#item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('item_code key_up : '+ value);
				
// 				getItemInfo('cd',value);
// 				return value
// 			});
	
// 	},400));

// $("#item_nm").change(_.debounce(function(event) {
	
// 			var item_nm = $("#item_nm").val();
// 			$(this).val(function(index, value) {
// 					console.log('item_nm key_up : '+ value);
		
// 				getItemInfo('nm',value);
// 				return value
// 			});
	
// 	},400));
	
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


//엑셀 1024
function excelFileDownload()
{
	console.log("excelFileDownload()");
	
	var gridCols = w2ui['grid_list'].columns;
	console.log("gridCols::"+gridCols);
	var gridData = w2ui['grid_list'].records;

	var fileName = '창고관리.xlsx';
	var sheetTitle = '창고관리';
	var sheetName = '창고관리';
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	console.log("param_col_id::"+param_col_id);
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


function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
}
</script>

</body>
</html>