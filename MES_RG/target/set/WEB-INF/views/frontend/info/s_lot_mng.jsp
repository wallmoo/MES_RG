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
	http://localhost:8080/frontend/location/info/s_plan_make
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
		<jsp:param name="selected_menu_cd" value="1061" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	LOT추적
        <small>생산관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>LOT추적</a></li><li class="active">생산관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row" style="position: relative; height:600px;">
			<div class="row" style="position: absolute; width: 49%; height:600px; margin:0;">
				<section class="col-lg-12">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">LOT작업지시 조회</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							</div>
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>LOT작업지시번호</label> <input type="text" id="product_po" name="product_po" placeholder="ex) LOT작업지시번호"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>	
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>	
							<div class="col-sm-3">
								<div class="form-group">
								<label>생산일자</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="product_date" placeholder="yyyymmdd~yyyymmdd" onchange="loadList_direct();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>		
						</div>
						<div id="grid_list" style="height: 600px; margin: 15px"></div>
					</div>
					
				</div>	
				
				<div class="row" style="position: absolute; right: 45px; width: 48%; height:600px;">
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">원자재 투입내역</h3>
								<!-- <div class="box-tools pull-right">
						     		<button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="deleteWorker();">작업지시현황</button>
								</div> -->
							</div>
							<div id="grid_list2" style="height: 150px; margin: 15px""></div>
						</div>
					</div>
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">공정이력</h3>
								
							</div>
							<div id="grid_list3" style="height: 150px; margin: 15px""></div>
						</div>
					</div>
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">검사실적</h3>
								
							</div>
							<div id="grid_inpt" style="height: 150px; margin: 15px""></div>
						</div>
					</div>
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


$(function($) {

 	fnLoadCommonOption(); 	 

 	init_grid_list();

 	init_grid_list2();
 	
 	init_grid_list3();
 	init_grid_list4();
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
		
		 $('#product_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			    startDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(-2, 'month'),
			    endDate:  moment(minDate)
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
 
        },
        multiSelect: false,
        columns: [                
			{ field:'product_po', caption:'LOT작업지시번호', size:'10%', style:'text-align:center', frozen: true,sortable :true},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center',sortable :true}, // 80px
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center',sortable :true}, // 120px
			{ field:'prod_menge', caption:'생산예정 수량', size:'10%', style:'text-align:center',sortable :true},// 120px
			{ field:'prod_fail_menge', caption:'불량발생 수량', size:'10%', style:'text-align:center',sortable :true},
			], 

		records: [
			          
		],
		onSelect: function (event) {
	    	  event.onComplete = function () {
					console.log("onSelect");
					
					var key = w2ui.grid_list.getSelection();
					var current_recid = key[0];		
					var data = w2ui.grid_list.get(current_recid);
					loadList2(data.product_po);
					
					var key = w2ui.grid_list.getSelection();
					var current_recid = key[0];		
					var data = w2ui.grid_list.get(current_recid);
					loadList3(data.product_po);
				
				}
			},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list2'].clear();		
				w2ui['grid_list2'].refresh();
				
				w2ui['grid_list3'].clear();		
				w2ui['grid_list3'].refresh();
				
				w2ui['grid_inpt'].clear();		
				w2ui['grid_inpt'].refresh();
				
			}
		},
		onReload: function(event) {
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
   
        },
        multiSelect: false,
        columns: [                

			{ field:'item_code', caption:'P/N', size:'15%', style:'text-align:center',sortable :true},
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center',sortable :true},
			{ field:'serial_no', caption:'Serial No', size:'12%', style:'text-align:center',sortable :true},
			{ field:'warehouse_raw_qty', caption:'투입수량', size:'10%', style:'text-align:center',sortable :true},
			{ field:'mill_sheet_no', caption:'Mill Sheet No', size:'15%', style:'text-align:center',sortable :true},
			{ field:'down_file', caption:'Mill Sheet 파일', size:'15%', style:'text-align:center',sortable :true},// 120px
			], 
		
		records: [
		          
		],	//
		onSelect: function (event) {
	    	  event.onComplete = function () {
					console.log("onSelect");
					
					
				
				}
			},
		onUnselect: function (event) {
			event.onComplete = function () {
				
			}
		},
		onReload: function(event) {
			//loadList();
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

			{ field:'routing_code', caption:'공정코드', size:'10%', style:'text-align:center',sortable :true}, // 120px
			{ field:'routing_nm', caption:'공정명', size:'25%', style:'text-align:center',sortable :true},
			{ field:'machine_code', caption:'공정장비', size:'17%', style:'text-align:center',sortable :true},
			{ field:'prod_menge', caption:'생산수량', size:'10%', style:'text-align:center',sortable :true}, // right // 120px
			{ field:'prod_fail_menge', caption:'불량수량', size:'10%', style:'text-align:center',sortable :true
				  ,render: function (record, index, col_index) {
                     var html = this.getCellValue(index, col_index);

                     if(html == null || html == 'null')
                    {
                    	  html = 0;
                    }
                    return html;
                 }          	
			
			},
			{ field:'member_nm', caption:'작업자', size:'15%', style:'text-align:center',sortable :true},
			{ field:'process_time', caption:'소요시간', size:'15%', style:'text-align:center',sortable :true},
			// 120px
			], 

		records: [
	
		],	//
		onReload: function(event) {
			//loadList();
		},
		onSelect: function (event) {
	    	  event.onComplete = function () {
					console.log("onSelect");
					
					var key = w2ui.grid_list.getSelection();
					var current_recid = key[0];		
					var data = w2ui.grid_list.get(current_recid);
				
					
					var key3 = w2ui.grid_list3.getSelection();
					var current_recid3 = key3[0];		
					var data3 = w2ui.grid_list3.get(current_recid3);
					
					
					loadInpt(data.product_po, data.item_code, data3.routing_code);
					
				
				}
			},
		onUnselect: function (event) {
			event.onComplete = function () {
		
				
				w2ui['grid_inpt'].clear();		
				w2ui['grid_inpt'].refresh();
				
			}
		},
		onClick: function (event) {}
	});

}
function init_grid_list4(){
var rowArr = [];
	
	$('#grid_inpt').w2grid({ 
        name: 'grid_inpt',
        show: {
        	lineNumbers: true,
            footer: true
        },
        multiSelect: false,
        columns: [                

			{ field:'inspection_item', caption:'검사 항목 ', size:'10%', style:'text-align:center',sortable :true}, // 120px
			{ field:'sample_type', caption:'샘플타입', size:'10%', style:'text-align:center',sortable :true},
			{ field:'spec', caption:'검사기준', size:'10%', style:'text-align:center',sortable :true},
			{ field:'min_spec', caption:'규격(LSL)', size:'10%', style:'text-align:center',sortable :true},
			{ field:'max_spec', caption:'규격(USL)', size:'10%', style:'text-align:center',sortable :true},
			{ field:'insp_val', caption:'측정 data', size:'10%', style:'text-align:center',sortable :true},
			{ field:'insp_rst', caption:'측정결과', size:'10%', style:'text-align:center',sortable :true}
			

			], 
		records: [
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}

var firstLoadFlag = false;
var firstCheck = false;

function loadList_direct()
{
	
	loadList();	
	firstCheck = true;
}

var comboValue_nm1 = new Array;
var comboValue_nm2 = new Array;
var comboValue_nm3 = new Array;

var check_value = '';
// 좌측 리스트 조회
var gridDataArr;
function loadList()
{
	
	console.log("loadList()");

	
	var product_po = $("#product_po").val();
	var item_code = $("#item_code").val();
	var item_nm = $("#item_nm").val();
	var product_date = $("#product_date").val();
	
	if(firstCheck){
		if(product_po == '' && item_code == ''  && item_nm == '' )
		{
			fnMessageModalAlert("알림", "검색조건을 입력해주세요."); // Notification
			return;
		}
	}
	


	/* var status = 'e';
	var routing_code = 'F'; */
	
	var status = '';
	var routing_code = '';
	
	var page_url = "/frontend/consumable/selectLot";
	
	//w2ui['grid_list'].lock('loading...', false);
	var postData = "product_po=" + encodeURIComponent(product_po)
				+"&item_code=" + encodeURIComponent(item_code)
				+"&item_nm=" + encodeURIComponent(item_nm)
				+"&product_date=" + encodeURIComponent(product_date)
				+"&status=" + encodeURIComponent(status)
				+"&routing_code=" + encodeURIComponent(routing_code);
	

	//w2ui['grid_list'].lock('loading...', true);
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
					if (check_value == '') {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.product_po);
						comboValue_nm2.push(row.item_code);
						comboValue_nm3.push(row.item_nm);
					}
					
					row.prod_menge = Number(row.prod_menge);
					row.prod_fail_menge = Number(row.prod_fail_menge);
					
				});
				

				if(firstLoadFlag){
					w2ui['grid_list'].records = rowArr;
				}
				firstLoadFlag = true;
				console.log('check_value : ' + check_value);


					
				
			
			}
			else
			{
				w2ui['grid_list'].clear();
			}
			
		
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			$('#product_po').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			
		},complete: function () {
			check_value = ":)";
			document.getElementById("product_po").style.removeProperty("height");
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
		}
	});
}

function loadList2(product_po)
{
	console.log("loadList2()");
	

	var page_url = "/frontend/consumable/selectLot2";
	
	w2ui['grid_list2'].lock('loading...', false);
	var postData = "product_po=" + encodeURIComponent(product_po);

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
					row.down_file = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'

					row.warehouse_raw_qty = Number(row.warehouse_raw_qty);
							
				});
				

				w2ui['grid_list2'].records = rowArr;
			
			
			}
			else
			{
				w2ui['grid_list2'].clear();
			}
			
		
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
		},complete: function () {

		}
	});
}

function loadList3(product_po)
{
	console.log("loadList3()");	

	var page_url = "/frontend/consumable/selectLot3";
	
	w2ui['grid_list3'].lock('loading...', false);
	var postData = "product_po=" + encodeURIComponent(product_po);
				

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
				

				w2ui['grid_list3'].records = rowArr;
			
			
			}
			else
			{
				w2ui['grid_list3'].clear();
			}
			
		
			w2ui['grid_list3'].refresh();
			w2ui['grid_list3'].unlock();
			
		},complete: function () {

		}
	});
}


//오른쪽 하단 리스트 조회
function loadInpt(product_po,item_code,routing_code)
{
	w2ui['grid_inpt'].clear();
	
	var page_url = "/frontend/insp/selcInspRstVal";
	var postData = "product_po=" + encodeURIComponent(product_po)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&routing_code=" + encodeURIComponent(routing_code);
			
			
	if(routing_code.indexOf('F') != -1)
	{
	 	postData += "&sample_type=" + encodeURIComponent('c');
	}
	
	
	
	w2ui['grid_inpt'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				var r_insp_case = '';
				rowArr = data.rows;
				$.each(rowArr, function(idx, row) {
					row.recid = idx + 1;
					//row.inspection_item = w2ui.grid_list3.get(w2ui.grid_list3.getSelection()[0]).inspection_item;
					row.prod_menge = Number(row.prod_menge);
					row.prod_fail_menge = Number(row.prod_fail_menge);
				});
				w2ui['grid_inpt'].records = rowArr;
				w2ui['grid_inpt'].refresh();
				w2ui['grid_inpt'].unlock();
				
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_inpt'].clear();
			} else {
				w2ui['grid_inpt'].clear();
				fnMessageModalAlert('알림', '데이터를 불러오는데 실패했습니다.');
			}
			
		},
		complete : function() {
			w2ui['grid_inpt'].refresh();
			w2ui['grid_inpt'].unlock();
		}
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
</script>

</body>
</html>