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
		<jsp:param name="selected_menu_cd" value="1071" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			수리 진행현황 모니터링 <small> Overhaul</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Overhaul </a></li>
			<li class="active">수리 진행현황 모니터링</li>
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
											<h3 class="box-title">수리 진행 대상</h3>
											<div class="box-tools pull-right">
												<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning  btn-sm" onclick="">조회</button>	 
											</div>
										</div>
										<div class="box-body">
											<div class="col-sm-12">
												<div class="row">
													<div class="form-group">
														<div class="col-sm-2">
															<label>반입처 고객사명</label> <input type="text" id="in_customer_nm"  class="form-control input-sm" placeholder="고객사명"
															onkeypress="if(event.keyCode==13) {loadList(); return false;}">
														</div>
														<div class="col-sm-2">
															<label>반출처 고객사명</label> <input type="text" id="out_customer_nm"  class="form-control input-sm" placeholder="고객사명"
															onkeypress="if(event.keyCode==13) {loadList(); return false;}">
														</div>
														<div class="col-sm-2">
															<label>P/N</label> <input type="text" id="req_item_code" name="req_item_code" class="form-control input-sm" placeholder="P/N"
															onkeypress="if(event.keyCode==13) {loadList(); return false;}">
														</div>
														<div class="col-sm-2">
															<label>품명</label> <input type="text" id="req_item_nm" name="req_item_nm" class="form-control input-sm" placeholder="품명"
															onkeypress="if(event.keyCode==13) {loadList(); return false;}">
														</div>
														<div class="col-sm-2">
															<label>S/N</label> <input type="text" id="req_sernr" name="req_sernr" class="form-control input-sm" placeholder="S/N"
															onkeypress="if(event.keyCode==13) {loadList(); return false;}">
														</div>
													</div>
												</div>
											</div>
											<div class="col-sm-12">
												<div id="grid_list" class="w2g-h600" style="margin-top: 10px;"></div>
											</div>
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
comboValue_nm4 = new Array;
comboValue_nm5 = new Array;
colorlist = new Array;

var InFindList = [];
var OutFindList = [];

$(function($) {
 	loadLeftGrid();
})

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

// loadLeftGrid
function loadLeftGrid(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : true,
            footer: true,
            selectColumn : false,
        },
        columns: [                
        	{ field:'repair_num', caption:'접수 번호', style:'text-align:center', sortable: true},
        	{ field:'repair_date', caption:'입고일자', style:'text-align:center', sortable: true},
			{ field:'customer_integration_nm', caption:'고객사', style:'text-align:center', sortable: true},
			{ field:'carry_in_customer_code', caption:'반입처 코드', hidden : true},
			{ field:'in_customer_nm', caption:'반입 고객사명', style:'text-align:center', hidden : true},
			{ field:'carry_in_land', caption:'반입처', style:'text-align:center', sortable: true},
			{ field:'carry_out_customer_code', caption:'반출처 코드', hidden : true},
			{ field:'out_customer_nm', caption:'반출 고객사명', style:'text-align:center', hidden : true},
			{ field:'carry_out_land', caption:'반출처', style:'text-align:center', sortable: true},
			{ field:'repair_class_nm', caption:'수리 구분', style:'text-align:center', sortable: true},
			{ field:'using_day', caption:'사용일수', style:'text-align:center', sortable: true},
			{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},

			{ field:'sernr', caption:'S/N', style:'text-align:center', sortable: true},
			{ field:'out_date', caption:'출고일자', style:'text-align:center', sortable: true, hidden : true},
			
			{ field:'proc1_date_d', caption:'입고검사', style:'text-align:center',sortable: true},
			{ field:'proc2_date_d', caption:'세정', style:'text-align:center', sortable: true},
			{ field:'proc3_date_d', caption:'반조립', style:'text-align:center', sortable: true},
			{ field:'proc4_date_d', caption:'중간검사', style:'text-align:center', sortable: true},
			{ field:'proc5_date_d', caption:'최종검사', style:'text-align:center', sortable: true},
			{ field:'proc6_date_d', caption:'수리완료보고서', style:'text-align:center', sortable: true},
			{ field:'out_status', caption:'출고여부', style:'text-align:center' ,sortable: true
				
				,render: function (record, index, col_index) {
					var html = '';
					var out_date = w2ui.grid_list.records[index].out_date; 
	              
					console.log('out_date : ' + out_date);
					if(out_date != '' && out_date != 'null' && out_date != null)
					{
						html = '출고완료';
					}else
					{
						html = '';
					}
	               return html;
	           } , hidden : true
			
			
			}
			], 
		records: [
			], // rowArr
		onSelect: function (event) {
		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
		},
		onRefresh: function(event) {

		}     
	});
	loadList();
	
	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {
		 settingColor();
	   }, 100));
}
var gridDataArr;

function loadList(){
	w2ui.grid_list.clear();
	var pageUrl = "/frontend/repair/selectrepairReqT";
	
	var req_customer_nm = $('#req_customer_nm').val();
	var req_item_code = $('#req_item_code').val();
	var req_item_nm = $('#req_item_nm').val();
	var req_sernr = $('#req_sernr').val();
	
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
	
	var postData = {
		customer_integration_nm : req_customer_nm,
		carry_in_customer_code : inCustomerCode || '',
		carry_out_customer_code : outCustomerCode || '',
		item_code : req_item_code,
		item_nm : req_item_nm,
		sernr : req_sernr
	}
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : pageUrl,
		type : "POST",
		data : postData,
		dataType : 'json',
		success : function(data){
			colorlist.length = 0;
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					row.using_day = Number(row.using_day);
						if (startValue_combo == "") {
							gridDataArr = rowArr;
							comboValue_nm1.push(row.in_customer_nm);
							comboValue_nm2.push(row.item_code);
							comboValue_nm3.push(row.item_nm);
							comboValue_nm4.push(row.sernr);
							comboValue_nm5.push(row.out_customer_nm);
						}
					
					InFindList[row.in_customer_nm] = row.carry_in_customer_code;
					OutFindList[row.out_customer_nm] = row.carry_out_customer_code;
					
					
					var num = 0;
					if(row.proc1_date != "" && row.proc1_date != null){
						
						num = 11;
					}
					if(row.proc2_date != "" && row.proc2_date != null){
										
						num = 12;
					}
					if(row.proc3_date != "" && row.proc3_date != null){
						
						num = 13;
					}
					if(row.proc4_date != "" && row.proc4_date != null){
						
						num = 14;
					}
					if(row.proc5_date != "" && row.proc5_date != null){
						
						num = 15;
					}
					if(row.proc6_date != "" && row.proc6_date != null){
						
						num = 16;
					}

					colorlist.push(num);
					
				});
				w2ui.grid_list.records = rowArr;


			} else {
				w2ui.grid_list.clear();
			}
			w2ui.grid_list.refresh();
			w2ui.grid_list.unlock();
			$('#in_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#req_item_code').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#req_item_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#req_sernr').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			$('#out_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm5,false) ,match : 'contains' });
			
			
		}, complete : function(){
			startValue_combo = ":)";
	
			document.getElementById("in_customer_nm").style.removeProperty("height");
			document.getElementById("req_item_code").style.removeProperty("height");
			document.getElementById("req_item_nm").style.removeProperty("height");
			document.getElementById("req_sernr").style.removeProperty("height");
			document.getElementById("out_customer_nm").style.removeProperty("height");
		
			
			settingColor();
		}
	});
}

function settingColor()
{

	var rowArr = w2ui.grid_list.records;
	$.each(rowArr, function(idx, row){

		
		var num = 0;
		if(row.proc1_date != "" && row.proc1_date != null){
			
			num = 11;
		}
		if(row.proc2_date != "" && row.proc2_date != null){
							
			num = 12;
		}
		if(row.proc3_date != "" && row.proc3_date != null){
			
			num = 13;
		}
		if(row.proc4_date != "" && row.proc4_date != null){
			
			num = 14;
		}
		if(row.proc5_date != "" && row.proc5_date != null){
			
			num = 15;
		}
		if(row.proc6_date != "" && row.proc6_date != null){
			
			num = 16;
		}

		colorlist.push(num);
		
	});
	
	columnsColor();
}


// function getItemInfo2(type, value)
// {
// 	console.log('getItemInfo2() : ' + value);
// 	var result = "";
// 	if(type == 'cd')
// 	{
// 		$.each(gridDataArr, function(idx, row){
			
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
		
// 		$.each(gridDataArr, function(idx, row){
			
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

function columnsColor(){
	for(var i = 0 ; colorlist.length > i ; i++){
		var nowindex = i+1;
		
		if(colorlist[i] != '0' ){
			$('#grid_grid_list_rec_'+nowindex+' td').eq(colorlist[i]).attr('style','background-color: orange;text-align:center');
		}
	}
}
</script>

</body>
</html>