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
		<jsp:param name="selected_menu_cd" value="1052" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      원자재 재고 관리
        <small>구매/자재관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 구매/자재관리</a></li><li class="active">원자재 재고 관리</li>
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
						   	<button type="button" id="btn_download" class="btn btn-info btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							<!-- <button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="inStock();">수정</button> -->
							<button type="button" id="btn_search_csr" onclick="tabGridLoad();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {tabGridLoad(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> <input type="text" id="item_nm" name="customer_nm" placeholder="ex) 품명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {tabGridLoad(); return false;}" />
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>커팅이력</label> <input type="text" id="product_po" name="product_po" placeholder="ex) 커팅이력"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {tabGridLoad(); return false;}" />
								</div>
							</div>
							
							
						</div>
						<div id="tabs" style="width: 100%;"></div>
						<div id="selected-tab" style="padding: 20px 10px">
							<div id="grid_list" style="width: 100%; height: 600px;"></div>
							<div id="grid_list2" style="width: 100%; height: 60px;"></div>
						</div>
					</div>
				</div>
				
				
				
				
			</section>
		</div>
	</section>
  </div>
 
 <div class="modal fade" id="modal_stock" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title">파일 수정</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<!-- <input type="hidden" id="upload_mode"/> -->
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">입고문서번호</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_in_date_doc">
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">P/N</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_item_code">
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">품명</label>
						<div class="col-sm-8">
							<input class="form-control" id="m_item_nm">
						</div>
					</div>
					<%-- <div class="form-group row">
						<div class="col-sm-2"></div>
						<div class="col-sm-5">
							<label for="" class="col-sm-5 control-label ">발주수량</label>
							<div class="col-sm-7">
								<input class="form-control" 
								onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;"id="m_menge">
							</div>
						</div>
						<div class="col-sm-4">
							<label for="" class="col-sm-4 control-label ">잔량</label>
							<div class="col-sm-8">
								<input class="form-control" id="m_jan_menge"
								onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">입고량</label>
						<div class="col-sm-5">
							<input type="int" maxlength="100"  class="form-control input-sm pull-right clear_field dp_component_d"
							 onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;" id="m_in_menge"  >
						</div>
					</div> --%>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">현재 Serial_NO</label>
						<div class="col-sm-5">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field dp_component_d" id="m_current_serial_no"  >
						</div>
					</div>
					
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">변경 Serial_NO</label>
						<div class="col-sm-5">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field dp_component_d" id="m_serial_no"  >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">Mill Sheet No</label>
						<div class="col-sm-5">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field" id="m_mill_sheet_no"  >
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-sm-3 control-label">첨부파일</label>
						<div class="col-sm-7" style="padding-right: 0px;">
							<input type="text" id="mod_file_name" name="mod_file_name" class="form-control input-sm clear_field" readonly>
						</div>	
						<div class="col-sm-1" style="padding-left: 7px;">
							<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
								<input id="file_group" type="file" class="fileupload file_info" name="file[]">
							</span>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="saveFile" class="btn btn-success btn-sm" onclick="modFile()">수정</button>
					<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
  
  
  
  
  
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>


<script type="text/javascript">
comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;



$(function($) {

	tab_grid();
 	fnLoadCommonOption(); 	 

 	init_grid_list();
 	init_grid_list2();
 	
 	fnLoadFileHandler();
 	loadList1();
 
})
 

var tab_flag = 'A'   
//tab설정
function tab_grid(){
	$('#tabs').w2tabs({
        name: 'tabs',
        active: 'tab1',
        tabs: [
            { id: 'tab1', text: '입고내역', style: "background-color: #8bcb77;"  },
            { id: 'tab2', text: '출고내역', style: 'background-color:' },
 
        ],
        onClick: function (event) {
           // $('#selected-tab').html(event.target);
            // style: 'background-color:#8bcb77'
            // w2ui.grid_list.set(index, { w2ui: { "style": "color: black; background-color: #FFD8D8;" } });
      			w2ui['tabs'].set('tab1' ,  { style: "background-color:;"  });
     			w2ui['tabs'].set('tab2' ,  { style: "background-color:;"  });
 
     			tab_flag = event.target;
     			
	            if(event.target == 'tab1')
	        	{
	            	
	            	
	       			console.log(' 입고내역');
	       			w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });
	       			
	       			var recids = w2ui.grid_list.getSelection();
	       			
	       			if(event.target == 'tab1')
	 				{
	       				tab_flag = 'A';
	       				
	       				$("#btn_update").show();
				
	       				w2ui['grid_list'].hideColumn(recids[0], 'product_po');
	       				
	       				w2ui['grid_list'].showColumn(recids[0], 'in_date_doc');
	 					w2ui['grid_list'].showColumn(recids[0], 'mill_sheet_no');
	 	 				w2ui['grid_list'].showColumn(recids[0], 'down_file');	
	 	 				
	 	 				w2ui['grid_list2'].hideColumn(recids[0], 'serial_no');
						w2ui['grid_list2'].hideColumn(recids[0], 'product_po');
	       				w2ui['grid_list2'].showColumn(recids[0], 'in_date_doc');
	 					w2ui['grid_list2'].showColumn(recids[0], 'mill_sheet_no');
	 	 				w2ui['grid_list2'].showColumn(recids[0], 'down_file');			
	 	 				
	 				}
	       			
	       			loadList1();
	   
	        	}else if(event.target == 'tab2')
	        	{
	     
	        		w2ui['grid_list'].refresh();
	    			w2ui['grid_list'].unlock();
	    			w2ui['grid_list'].clear();
	    			
	        		tab_flag = 'B';
	        		
	      			console.log(' 출고내역');
	      			w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });
	      			

	 				var recids = w2ui.grid_list.getSelection();
	 				
	 				
	 				if(event.target == 'tab2')
	 				{
	 					w2ui['grid_list'].refresh();
	 					w2ui['grid_list'].unlock();
	 					
	 					$("#btn_update").hide();
	 					w2ui['grid_list'].showColumn(recids[0], 'product_po');
	 					
	 					w2ui['grid_list'].hideColumn(recids[0], 'in_date_doc');
	 					w2ui['grid_list'].hideColumn(recids[0], 'mill_sheet_no');
	 	 				w2ui['grid_list'].hideColumn(recids[0], 'down_file');	
	 	 				
						w2ui['grid_list2'].showColumn(recids[0], 'product_po');
						w2ui['grid_list2'].hideColumn(recids[0], 'serial_no');
	 					w2ui['grid_list2'].hideColumn(recids[0], 'in_date_doc');
	 					w2ui['grid_list2'].hideColumn(recids[0], 'mill_sheet_no');
	 	 				w2ui['grid_list2'].hideColumn(recids[0], 'down_file');	
	 				}
	 				
	      			loadList2();
	       		}
				
	   			w2ui['tabs'].refresh();
        }
    });
}

function tabGridLoad(){
	
	deleteItems = new Array;
	
	if( tab_flag == 'A' ) {
		console.log("loadList_tab1");
		loadList1();
	}else if ( tab_flag == 'B' ){	
		console.log("loadList_tab2");
		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
		w2ui['grid_list'].clear();
		
		loadList2();	
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
 			{ field:'in_date_doc', caption:'입고번호', size:'10%', style:'text-align:center', sortable: true},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center', sortable: true},
			{ field:'warehousing_price', caption:'단가', size:'8%', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }		
			},
			{ field:'serial_no', caption:'Serial', size:'10%', style:'text-align:center', sortable: true, hidden : true}, 
			{ field:'product_po', caption:'커팅이력', size:'12%', style:'text-align:center', hidden : true,sortable :true},
			{ field:'original_cnt', caption:'Original 수량', size:'10%', style:'text-align:center', sortable: true},
			
			{ field:'meins', caption:'단위', size:'8%', style:'text-align:center', sortable: true},
			
			{ field:'mill_sheet_no', caption:'Mill Sheet No', size:'15%', style:'text-align:center', sortable: true}, 
			{ field:'down_file', caption:'Mill Sheet 파일첨부', size:'25%', style:'text-align:left', sortable: true}
			], 

		records: [
		
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}
function grid_list_tot()
{
	
	setTimeout(function(){
	      w2ui['grid_list2'].resize();
	      w2ui['grid_list2'].refresh();

	   }, 200);
	
	var rowArr3 = w2ui['grid_list'].records; 
	
	var tot_price = 0;	
	var tot_original_cnt = 0;
	
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
		
		var original_cnt = data.original_cnt;
		if(original_cnt == '' ||  original_cnt == 'null' 
				|| original_cnt == undefined ||  original_cnt == 'undefined')
		{
			original_cnt = 0;
		}
		
		console.log("i??" + i);
		console.log("warehousing_price??" + warehousing_price);
 		
		tot_price = tot_price + parseInt(warehousing_price);
		tot_original_cnt = tot_original_cnt + Number(original_cnt);
		var tot_original_cnt1 = 0;
		tot_original_cnt1 = tot_original_cnt.toFixed(1);
		
		

	}
	
	tot_price = w2utils.formatters['number'](tot_price); 

		               	
	w2ui['grid_list2'].set('g1',{ tot_price : tot_price, tot_original_cnt : tot_original_cnt1});
	
}

function init_grid_list2(){
	var rowArr = [];
	
	$('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
        	selectColumn: false,
			lineNumbers : true,
            footer: false
        },
        multiSelect: false,
        columns: [      
 			{ field:'in_date_doc', caption:'', size:'10%', style:'text-align:center', sortable: true},
			{ field:'', caption:'', size:'10%', style:'text-align:center', sortable: true},
			{ field:'', caption:'', size:'25%', style:'text-align:center', sortable: true},
			{ field:'tot_price', caption:'합계', size:'8%', style:'text-align:center', sortable: true},
			{ field:'serial_no', caption:'', size:'10%', style:'text-align:center', sortable: true, hidden : true}, 
			{ field:'product_po', caption:'', size:'12%', style:'text-align:center', hidden : true},
			{ field:'tot_original_cnt', caption:'', size:'10%', style:'text-align:center', sortable: true},
			
			{ field:'', caption:'', size:'8%', style:'text-align:center', sortable: true},
			
			{ field:'mill_sheet_no', caption:'', size:'15%', style:'text-align:center', sortable: true}, 
			{ field:'down_file', caption:'', size:'25%', style:'text-align:left', sortable: true}
			], 

		records: [
		
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	w2ui['grid_list2'].add([
		          			 { recid:'g1', tot_price : '', tot_original_cnt:''}
		          	     ]);
}

//-------------------------------------------------------------------------------------------------------------------



//엑셀 다운로드
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '원자재 재고 관리.xlsx';
	var sheetTitle = '원자재 재고 관리';
	var sheetName = '원자재 재고 관리';
	
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
var startValue_combo = "";
// 조회
function loadList1()
{
	
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
	
	console.log("loadList1()");
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var item_nm = $('#item_nm').val();
	var item_code = $('#item_code').val();
	var product_po = $('#product_po').val();
	
	//var in_menge = w2ui["grid_list"].records.original_cnt;
	
	var page_url = "/frontend/consumable/selectWarehousingMng";
	
	var postData = "item_type_code=" + encodeURIComponent('MD1245')
				+ "&item_code=" + encodeURIComponent(item_code)
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
				console.log("startValue_combo==="+startValue_combo)
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.product_po);
						row.down_file = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
					
					}
					row.warehousing_price = Number(row.warehousing_price);
					row.original_cnt = Number(row.original_cnt);

					
					
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
			
			
			

		},complete: function () {
			startValue_combo = ":)";
			
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("product_po").style.removeProperty("height");
			
			grid_list_tot();
		}
	});
}


function loadList2()
{
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
	w2ui['grid_list'].clear();
	
	console.log("loadList2()");
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var item_nm = $('#item_nm').val();
	var item_code = $('#item_code').val();
	var product_po = $('#product_po').val();
	
	
	var page_url = "/frontend/consumable/selectWarehouseRawMng";
	
	var postData = "out_warehousing_status=" + encodeURIComponent('o')
				+ "&item_code=" + encodeURIComponent(item_code)
				+ "&item_nm=" + encodeURIComponent(item_nm)
				+ "&product_po=" + encodeURIComponent(product_po);
	
	
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
					if(row.item_code)comboValue_nm1.push(row.item_code);
					if(row.item_nm)comboValue_nm2.push(row.item_nm);
					if(row.product_po)comboValue_nm3.push(row.product_po);
					
					row.down_file = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
					}
					
					row.warehousing_price = Number(row.warehousing_price);
					row.original_cnt = Number(row.original_cnt);
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
			

		},complete: function () {
			startValue_combo = ":)";
	
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("product_po").style.removeProperty("height");
			
			grid_list_tot();
		}
	});
}

//-------------------------------------------------------------------------------------------------------------------

var curFile = null;

//입고
function inStock() {
	console.log('inStock()');

	var key = w2ui.grid_list.getSelection();
	
	
	curFile = null;
	isRev = false;
	
	$('#m_account_nm').attr('disabled', true);
	$('#m_item_code').attr('disabled', true);
	$('#m_item_nm').attr('disabled', true);
	$('#m_menge').attr('disabled', true);
	$('#m_current_serial_no').attr('disabled', true);
	$('.clear_field').val('');
	
	var recids = w2ui.grid_list.getSelection();
	
	var pdata = w2ui.grid_list.get(recids[0]);
	
	
	
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {
		var keys = Object.keys(pdata);
		
		
		$("#m_in_date_doc").val(pdata.in_date_doc);
		$("#m_item_code").val(pdata.item_code);
		$("#m_item_nm").val(pdata.item_nm);
		$("#m_menge").val(pdata.menge);
		
		var jan_menge = Number(pdata.menge) - Number(pdata.in_menge);
		$("#m_jan_menge").val(jan_menge);
		$("#m_in_menge").val(0);
		
		$("#m_current_serial_no").val(pdata.serial_no);
		
		$("#m_serial_no").val('');
		$("#m_mill_sheet_no").val(pdata.mill_sheet_no);
		
		
		if(pdata.file_name == null || pdata.file_name == 'null')
		{
			$("#mod_file_name").val('');
		}else{
			$("#mod_file_name").val(pdata.file_name);
		}
		
		
		$('#file_btn').attr('disabled', false);
		
		$('#m_in_date_doc').attr('disabled', true);
		$('#m_item_code').attr('disabled', true);
		$('#m_item_nm').attr('disabled', true);
		
		$('#m_menge').attr('disabled', true);
		$('#m_jan_menge').attr('disabled', true);
		$('#m_current_serial_no').attr('disabled', true);
		
		//$('#m_serial_no').attr('disabled', true);
	} 

	
	//w2ui.grid_list.selectNone();
	$('#modal_stock').modal('show');
	
}


//ins file info
function modFile() {
	
	
	var pageUrl = "";
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]); 
	
	//원재료
	var in_date_doc = $('#m_in_date_doc').val();
	var item_code = $('#m_item_code').val();

	var current_serial_no = $('#m_current_serial_no').val();
	var serial_no = $('#m_serial_no').val();
	var mill_sheet_no = $('#m_mill_sheet_no').val();
	
	if(!chkSubmit($("#m_serial_no"), "Serial_No를")) return false;
	if(!chkSubmit($("#m_mill_sheet_no"), "mill_sheet_no를")) return false;
	
	fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
		if(chk){
			
			if(curFile){
				curFile.submit();
			} else {
				if(!isRev){
					var pageUrl = '/frontend/consumable/MOD_warehousing_file_upload';
					var postData = {
							in_date_doc : in_date_doc,					
							item_code : item_code,
							current_serial_no : current_serial_no,
							serial_no : serial_no,
							mill_sheet_no : mill_sheet_no
						
					}
					FunLoadingBarStart();
					$.ajax({
						url : pageUrl,
						type : 'POST',
						data : postData,
						dataType : 'json',
						success : function(data){
							if(data.status = 200){
								fnMessageModalAlert("결과", "수정처리를 완료 하였습니다.");	// Notification(MES)
								$('#modal_stock').modal('hide');
							}
						},
						error : function(jqXHR, textStatus, errorThrown){
							fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
						}, complete : function(){
							tabGridLoad();
							FunLoadingBarEnd();
						}
					})
				} else {
					fnMessageModalAlert("알림", "등록된 파일 정보가 없습니다.");	// Notification(MES)
				}
			}
			
			
		}
	})
	/////////// 여기까지는 원재료 '입고' 할 때 사용 하는 것임
		
	
}

function setUploadFileParma(pInfo, pName){
	curFile = pInfo;
}

function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/frontend/consumable/MOD_warehousing_file_upload",
		dataType : 'json',
		autoUpload : false,
		enctype : "multipart/form-data",
 		//acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 30720000, 
		add: function(e, data){
			
			if(data.files[0].size > 30720000)
			{
				fnMessageModalAlert("알림", "파일 용량이 너무 큽니다.");
				return;
			}
			$('#mod_file_name').val(data.files[0].name);
			if(!$('#mod_input_file_name').val()) $('#mod_input_file_name').val(data.files[0].name);
			setUploadFileParma(data, data.files[0].name);
		},
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Error", file.error);
		} else {
			setUploadFileParma(data, file.name);
		}
	}).on('fileuploadprogressall', function(e, data) {
		 
		$('#progress').show();
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
    	
    	/* $('#t_' + e.target.id).val(data.files[0].name);
    	$('#a_' + e.target.id).val(data.result.file_group); */
    	
    	$('#modal_stock').modal('hide');

    	tabGridLoad();
 
    	
    	
	}).on('fileuploadfail', function(e, data) {
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).on('fileuploadsubmit', function(e, data){
		var $this = $(this);
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		var in_date_doc = $('#m_in_date_doc').val();
		var item_code = $('#m_item_code').val();
	
		var current_serial_no = $('#m_current_serial_no').val();
		var serial_no = $('#m_serial_no').val();
		var mill_sheet_no = $('#m_mill_sheet_no').val();
		data.formData = {
				
			in_date_doc : in_date_doc,
			item_code : item_code,
			current_serial_no : current_serial_no,
			serial_no : serial_no,
			mill_sheet_no : mill_sheet_no,

		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
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

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
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