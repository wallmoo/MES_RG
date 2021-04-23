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
		<jsp:param name="selected_menu_cd" value="1091" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      기타 입출고 내역
        <small>구매/자재관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>   기타 입출고 내역</a></li><li class="active">기타 재고 관리</li>
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
									<label>상태</label>
									<div class="form-group" style="margin-bottom: 0px;">
									<select id="warehousing_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
											<option value="">전체</option>
											<option value="i">입고</option>
											<option value="o">출고</option>
										
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<label id="date_nm" >기준일자</label> 
								<div class="input-group">
									<input type="text" 
										class="form-control pull-right input-sm" style="" id="search_date" placeholder="yyyymmdd~yyyymmdd">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>자재유형</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="item_type_code" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
											
										</select>
									</div>
								</div>
							</div>	
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id=item_code name="item_code" placeholder="ex) P/N"
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
						<div id="tabs" style="width: 100%;"></div>
						<div id="selected-tab" style="padding: 20px 10px">
							<div id="grid_list" style="width: 100%; height: 550px;"></div>
							<div id="grid_list2" style="width: 100%; height: 60px;"></div>
						</div>
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
				<h4 class="modal-title" id="modal_info_title">출고</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
				

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label" id="modal_date_title" >출고일자</label>
							<div class="input-group col-sm-4">
								<input type="text" 
									class="form-control pull-right input-sm" style="" id="m_out_date" onchange="" placeholder="yyyymmdd">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
							</div>
						</div>
					</div>
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">재고수량</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_warehousing_qty" maxlength="8" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">수량</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_cnt" maxlength="8" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">담당자</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_out_user" maxlength=50>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label" id="modal_comment_title">출고사유</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_out_comment" maxlength=50>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveProcess();">저장</button>
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


$(function($) {
	
	
	fnCdD('item_type_code', 'MC1014');
 	fnLoadCommonOption(); 	 

 	init_grid_list();
 	
 	init_grid_list2();
 	
 	loadList();
 
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
		 
			var minDate = getFormatDate(new Date());
	 		 $('#m_out_date').daterangepicker({
					opens: 'right',
					singleDatePicker: true,
					locale: {
						format : 'YYYYMMDD'	,
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
						showMonthAfterYear : true,
						yearSuffix : '년'
				    },
				    startDate : moment(minDate)
				    
				}); 
		 loadCommFn();
}

function loadCommFn(){
	$('#search_date').daterangepicker({
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
	    startDate : moment().subtract(30, 'days').format('YYYYMMDD'),
 	    endDate:  moment().format('YYYYMMDD')
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


//위 리스트
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
            { field:'business_code', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
            { field:'business_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
            { field:'warehouse_code', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
            { field:'warehouse_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
            { field:'warehousing_status', caption:'상태', size:'10%', style:'text-align:center' , hidden : true
            	,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'i')
	            	{
	            	   return '입고';
	            	}else(html == 'o')
	            	{
	            		 return '출고';
	            	}
	            	
	               return html;
	           } 		
            },
            { field:'date', caption:'기준일자', size:'10%', style:'text-align:center' },
            { field:'item_spec', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
            { field:'item_type_code', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
            { field:'item_type_nm', caption:'자재유형', size:'10%', style:'text-align:center', sortable: true},
        	{ field:'item_code', caption:'P/N', size:'20%', style:'text-align:center', sortable: true}, // 120px
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center', sortable: true},
			{ field:'warehousing_price', caption:'단가', size:'10%', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              } 	
			}, // right // 120px
			{ field:'in_qty', caption:'입고 수량', size:'10%', style:'text-align:center', sortable: true},
			{ field:'out_qty', caption:'출고 수량', size:'10%', style:'text-align:center', sortable: true},
			{ field:'meins', caption:'단위', size:'10%', style:'text-align:center', sortable: true, hidden : true},
			{ field:'price', caption:'금액', size:'10%', style:'text-align:center', sortable: true, hidden : true
	/* 			,render: function (record, index, col_index)
				{
					var val = this.getCellValue(index, col_index);
					

					val = w2utils.formatters['number'](val);
					val = setComma(val);
					
					return val;
			 
	      		}	 */
			}, // right // 120px
			{ field:'comment', caption:'사유', size:'10%', style:'text-align:center', hidden : true}
			], 
	/* 	sortData: [{field: 'vendor_code', direction: 'ASC'}], */
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

function settingTotal(warehousing_price,warehousing_qty)
{
	
	if(warehousing_price == '' || warehousing_price == 'null' || warehousing_price == null)
	{
		warehousing_price = 0;
	}
	if(warehousing_qty == '' || warehousing_qty == 'null' || warehousing_qty == null)
	{
		warehousing_qty = 0;
	}
	val = Number(warehousing_price) * Number(warehousing_qty);	
	
	return val;
}


function grid_list_tot()
{
	
	setTimeout(function(){
	      w2ui['grid_list2'].resize();
	      w2ui['grid_list2'].refresh();

	   }, 200);
	
	var rowArr3 = w2ui['grid_list'].records; 
	
	var tot_warehousing_price = 0;	
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
		var warehousing_qty = data.warehousing_qty;
		if(warehousing_qty == '' ||  warehousing_qty == 'null' 
				|| warehousing_qty == undefined ||  warehousing_qty == 'undefined')
		{
			warehousing_qty = 0;
		}
		var price = data.price;
		if(price == '' ||  price == 'null' 
				|| price == undefined ||  price == 'undefined')
		{
			price = 0;
		}
		
		console.log("i??" + i);
		console.log("warehousing_price??" + warehousing_price);
		console.log("warehousing_qty??" + warehousing_qty);
		console.log("price??" + price);
		
		tot_warehousing_price = tot_warehousing_price + parseInt(warehousing_price);
		tot_warehousing_qty = tot_warehousing_qty + parseInt(warehousing_qty);
		tot_price = tot_price + parseInt(price);
		
		

	}
	
	tot_warehousing_price = w2utils.formatters['number'](tot_warehousing_price); 
	tot_price = w2utils.formatters['number'](tot_price); 

		               	
	w2ui['grid_list2'].set('g1',{ tot_warehousing_price : tot_warehousing_price, tot_warehousing_qty : tot_warehousing_qty, tot_price : tot_price});
	
}

//아래 총합
function init_grid_list2(){
	var rowArr = [];
	
	$('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: false
        },
        multiSelect: false,
        columns: [      
 			
            { field:'', caption:'', size:'10%', style:'text-align:center' },
            { field:'', caption:'', size:'10%', style:'text-align:center' },
            { field:'', caption:'', size:'10%', style:'text-align:center', hidden : true},
            { field:'', caption:'', size:'10%', style:'text-align:center', hidden : true},
            { field:'', caption:'', size:'10%', style:'text-align:center', sortable: true},
        	{ field:'', caption:'', size:'20%', style:'text-align:center', sortable: true}, // 120px
			{ field:'', caption:'', size:'20%', style:'text-align:center', sortable: true},
			{ field:'tot_warehousing_price', caption:'합계', size:'10%', style:'text-align:center', sortable: true}, // right // 120px
			{ field:'tot_warehousing_qty', caption:'', size:'10%', style:'text-align:center', sortable: true},
			{ field:'', caption:'', size:'10%', style:'text-align:center', sortable: true},
			{ field:'tot_price', caption:'', size:'10%', style:'text-align:center', sortable: true}, // right // 120px
			{ field:'', caption:'', size:'10%', style:'text-align:center'}
			], 

		records: [
		
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	w2ui['grid_list2'].add([
		          			 { recid:'g1', tot_warehousing_price : '', tot_warehousing_qty : '', tot_price : ''}
		          	     ]);
}



//-------------------------------------------------------------------------------------------------------------------

//엑셀 다운로드
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '기타 입출고내역.xlsx';
	var sheetTitle = '기타 입출고내역';
	var sheetName = '기타 입출고내역';
	
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

var comboValue_nm1 = new Array;
var comboValue_nm2 = new Array;
var startValue_combo = "";


/* function loadList() {
	console.log("loadList()");
	
	var rec = 
		[
		 { recid:1, item_nm:"나연", warehousing_price:"26", warehousing_qty:"1", price:"100"},
		 { recid:2, item_nm:"정연", warehousing_price:"25", warehousing_qty:"1", price:"100"},
		 { recid:3, item_nm:"모모", warehousing_price:"25", warehousing_qty:"1", price:"100"},
		 { recid:4, item_nm:"사나", warehousing_price:"25", warehousing_qty:"1", price:"100"},
		 { recid:5, item_nm:"지효", warehousing_price:"25", warehousing_qty:"1", price:"100"},
		 { recid:6, item_nm:"미나", warehousing_price:"24", warehousing_qty:"1", price:"100"},
		 { recid:7, item_nm:"다현", warehousing_price:"23", warehousing_qty:"1", price:"100"},
		 { recid:8, item_nm:"채영", warehousing_price:"22", warehousing_qty:"1", price:"100"},
		 { recid:9, item_nm:"쯔위", warehousing_price:"22", warehousing_qty:"1", price:"100"},

		 
		 ];

		
		w2ui['grid_list'].records = rec;
		
		setTimeout(function(){
			w2ui['grid_list'].resize();
			w2ui['grid_list'].refresh();
	   }, 200);
		
	
   return; 

	w2ui['grid_list'].lock('loading...', true);
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
				});
				w2ui['grid_list'].records = rowArr;
			} else {
				w2ui.grid_list.clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		},complete: function () {}
	});
	
}
 */

 function loadList(){
	
	console.log('loadList()');
	
	w2ui['grid_list'].clear();
	var warehousing_status =  $("#warehousing_status").val();
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	var item_type_code = $("#item_type_code").val();
	
	var date = $("#search_date").val();
	date = date.replace(/-/gi, "");
	
	var page_url = "/frontend/consumable/selectWarehouseHis";
	
	//w2ui['grid_list'].lock('loading...', false);
	var postData = "item_nm=" + encodeURIComponent(item_nm)
		+ "&warehousing_status=" + encodeURIComponent(warehousing_status)
		+ "&item_code=" + encodeURIComponent(item_code)
		+ "&item_type_code=" + encodeURIComponent(item_type_code)
		+ "&date=" + encodeURIComponent(date);
	
	try{
		
		w2ui.grid_list.selectNone();
		w2ui['grid_list'].lock('loading...', true);
	}catch(e)
	{
		
	}
	
	var tototo = [];//추가될 로우의 인덱스를 담을 배열
	var tototo2 = [];//월합계를 담을 배열
	var date2 = [];//
	
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
				
				
				var forV = 0;//추가되는 row갯수도 더해서 for문을 돌리기위해 씀
				var n = 0;//idx대신 사용 
				var month_p = 0;//합계
				$.each(rowArr, function(idx, row){
					
					//값에 토탈펑션
					row.price = settingTotal(row.warehousing_price, row.warehousing_qty);
					
					/* row.recid = idx+1; */
					var date = (row.date).substring(0,7);//월만 잘라서 가져옴
					month_p=parseInt(month_p)+parseInt(row.price);//월 합계


					forV +=1;//로우 갯수 구하는것
					if(idx <= rowArr.length-2){//if문안에 있는건 합계 로우가 총 몇개필요한지 계산하는것
						var nxtDate = (rowArr[idx + 1].date).substring(0,7);
						if( date != nxtDate ) {
							forV +=1;//합계 로우갯수가 추가되어서 1을 더함
							tototo2.push(month_p);//월합계를 담음
							date2.push(date);
							month_p = 0;//월 합계 초기화
						}
					}
					
					if(row.item_code)comboValue_nm1.push(row.item_code);
					if(row.item_nm)comboValue_nm2.push(row.item_nm);
					
					
		
				});//each문 끝
				tototo2.push(month_p);//마지막 월 합계 담음
				date2.push(date);
				var am = 0;//월합계를 꺼내기위한 인덱스
				for(var j=0; j<forV; j++){//합계 로우를 추가하기위한 for문
					
					 if(rowArr[j].date) {//합계 로우가 아니면 
						 	rowArr[j].recid = n+1;
							
							if(j <= forV-2){//마지막거랑 그위에 로우를 비교하기위해
								var date = (rowArr[j].date).substring(0,7);
								var nxtDate = (rowArr[n+1].date).substring(0,7);
								//로우를 추가히기위한 if문
								if( date != nxtDate ) {
									var ob = new Object	();
									ob.recid = n+2;
									ob.item_nm = date2[am]+' 계';
									ob.price = tototo2[am];
									ob.date = "";//if문을 위한 공백
									rowArr.splice( n+1, 0, ob);//중간에 로우 추가
									tototo.push(n+1); 
									am+=1;
								}
							}
							
						}
						
						n+=1;
					
				}//for문 끝
				
				//마지막 합계 로우 추가
				var ob = new Object	();
				ob.recid = n+2;
				ob.price = '합계 : ' + tototo2[am];
				ob.date = "";
				rowArr.splice( n+1, 0, ob);
				tototo.push(n+1); 

				w2ui['grid_list'].records = rowArr;
				
				for(var s=0; s<=15; s++){
					$("#grid_grid_list_data_" + tototo[j] + "_"+s)
					.css("border-left", "none").css("border-right", "none").css("background-color", "darkgray");
					
				}
				
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			if (startValue_combo == "") {
				
				$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
				$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			}
			try{
				//changeGridUI(gridDataArr);
			}catch(e)
			{
				
			}
			
			
		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			console.log('==============================');
			console.log(tototo2);
			grid_list_tot();
			
			for(var j=0; j<tototo.length; j++){
//					$("#grid_grid_list_rec_" + (tototo[j]+1)).css("background-color", "darkgray");
				/* $("#grid_grid_list_data_" + tototo[j] + "_4").css("border-right", "none");  */
				
				for(var s=0; s<=15; s++){
					$("#grid_grid_list_data_" + tototo[j] + "_"+s)
					.css("border-left", "none").css("border-right", "none").css("background-color", "darkgray");
					
				}
			}
		}
	});
} 


var currentModalType = '';
function requestOut()
{
	currentModalType = 'OUT';
	console.log('requestOut()');
	
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==1 ) {
		var data = w2ui.grid_list.get(key[0]);
		
		$("#modal_info_title").text('출고');
		$('#m_cnt').val('');
		$('#m_out_user').val('');
		$('#m_out_comment').val('');
		$('#m_warehousing_qty').val(data.warehousing_qty);
		$('#m_warehousing_qty').attr('disabled', true);
		
		$("#modal_date_title").text('출고일자');
		$("#modal_comment_title").text('출고사유');
		
		$("#modal_info").modal('show');
		
	

	} else {
		fnMessageModalAlert("알림", "출고하실 항목을 선택해주세요."); // Notification
	}
}


function requestIn()
{
	currentModalType = 'IN';
	console.log('requestIn()');
	var key = w2ui.grid_list.getSelection();
	if( key.length==1 ) {
		var data = w2ui.grid_list.get(key[0]);

		$("#modal_info_title").text('입고');
		$('#m_cnt').val('');
		$('#m_out_user').val('');
		$('#m_out_comment').val('');
		$('#m_warehousing_qty').val(data.warehousing_qty);
		$('#m_warehousing_qty').attr('disabled', true);
		$("#modal_date_title").text('입고일자');
		$("#modal_comment_title").text('입고사유');
		
		$("#modal_info").modal('show');
		
	

	} else {
		fnMessageModalAlert("알림", "입고하실 항목을 선택해주세요."); // Notification
	}
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
  //	 	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		var sub = val.substr(0,2);
	    		
	    		//  if(valsub != "m_")
	    		if(sub.indexOf("m_") == -1) // val
	    			$("#"+val ).append("<option value="+''+">" + "전체" + "</option>");
	    		
				$.each(rowArr, function(idx, row){
					if( val == "business" && row.detail_code == "MD1282" ) {
						
					} else {
						if(row.detail_code != 'MD1245'){
							$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						}
					}
				});
				
	 			$("#"+val+" option:eq(0)").prop("selected", true);	
	 			if( val == "business" ) {
	 				$("#"+val+" option:eq(1)").prop("selected", true);	
	 			}
	 			
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
	
}

$("#item_code").change(_.debounce(function(event) {
	
	loadList();
	
	
	
},400));

$("#item_nm").change(_.debounce(function(event) {
	
	loadList();
	
},400)); 


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