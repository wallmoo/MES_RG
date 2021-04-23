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
		<jsp:param name="selected_menu_p_cd" value="1043" />
		<jsp:param name="selected_menu_cd" value="1076" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	공정검사이력조회
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>품질관리</a></li><li class="active">공정검사이력조회</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row" style="position: relative; height:600px;">
			<div class="row" style="position: absolute; width: 49%; height:600px; margin:0;">
				<section class="col-lg-12">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">공정 검사 대상</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							</div>
						</div>
						
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>작업지시번호</label> <input type="text" id="m_product_po" name="m_product_po" placeholder="ex) 작업지시번호"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>P/N</label> <input type="text" id="m_item_code" name="m_item_code" placeholder="ex) P/N"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>	
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>품명</label> <input type="text" id="m_item_nm" name="m_item_nm" placeholder="ex) 품명"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>	
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">	
<!-- 							<div class="col-sm-4"> -->
<!-- 								<div class="form-group" style="margin-bottom: 0px;"> -->
<!-- 									<label>LOT 작업지시번호</label> <input type="text" id="customer_nm" name="customer_nm" placeholder="ex) LOT 작업지시번호" -->
<!-- 									 class="form-control input-sm" maxlength="50" /> -->
<!-- 								</div> -->
<!-- 							</div>	 -->
							<div class="col-sm-4">
								<div class="form-group">
								<label>생산요청일자</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm cond_2" style="" id="m_product_req_date" placeholder="yyyymmdd~yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group">
								<label>진행상태</label>
									<select id="m_flag" name="m_flag" class="form-control select2 input-sm cond_2" data-placeholder="">
										<option value="">전체</option>
										<option value="검사전">검사전</option>
										<option value="검사진행중">검사진행중</option>
										<option value="검사완료">검사완료</option>
										<option value="품질검사항목없음">품질검사항목없음</option>
									</select>
								</div>
							</div>

							<div class="col-sm-4">    
								<div class="form-group" style="margin-top:0px;">
									<label>검사구분</label>
									<div style="padding-top: 4px;">          
							            <label>
							            	<input type="radio" id="rdo_ps_gubun" name="rdo_ps_gubun" class="flat-red form-control" value="P" checked> 생산
							            </label> 
							            <label>
							            	<input type="radio" id="rdo_ps_gubun" name="rdo_ps_gubun" class="flat-red form-control" value="S" > 수입검사
							            </label>
						            </div>
						        </div>
							</div>



						</div>
						<div id="grid_list" style="height: 470px; margin: 15px"></div>
					</div>
					
				</div>	
				
				<div class="row" style="position: absolute; right: 45px; width: 48%; height:600px;">
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">공정 검사 결과</h3>
<!-- 								<div class="box-tools pull-right"> -->
<!-- 						     		<button type="button" id="btn_delete" class="btn btn-success btn-sm" onclick="deleteWorker();">OK</button> -->
<!-- 									<button type="button" id="btn_delete" class="btn btn-success btn-sm" onclick="deleteWorker();">NG</button> -->
<!-- 								</div> -->
							</div>
							<div id="grid_chk" style="height: 270px; margin: 15px""></div>
						</div>
					</div>
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">작업 실적</h3>
<!-- 								<div class="box-tools pull-right"> -->
<!-- 									<select id="m_gubun" name="m_gubun" class="form-control select2 input-sm" data-placeholder=""> -->
<!-- 										<option value="">전체</option> -->
<!-- 										<option value="a">초물</option> -->
<!-- 										<option value="b">중물</option> -->
<!-- 										<option value="c">종물</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
							</div>
							<div id="grid_inpt" style="height: 250px; margin: 15px""></div>
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

// $('#m_gubun').change(function(){
// 	loadInpt();
// });

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
 	
 	$(".cond_1").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	
 	$('.cond_2').on("change",function(event){ 
		loadList();
 	}); 
 	
 	$(":radio[name='rdo_ps_gubun']").on('ifChecked', function(event){
		  loadList();
	});
})


//품명,품번 자동완성
// $("#m_item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#m_item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('m_item_nm key_up : '+ value);
		
// 		getItemInfo('nm',value);
// 		return value
// 	});
	
// },400));

// $("#m_item_code").change(
		
// 		_.debounce(function(event) 
// 		{
	
// 			var item_code = $("#m_item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('m_item_code key_up : '+ value);
				
// 				getItemInfo('cd',value);
// 				return value
// 			});
	
// },400));

function getItemInfo(type, value)
{
	console.log('getItemInfo() : ' + value);
	var result = "";
	if(type == 'cd')
	{
		$.each(rowArr, function(idx, row){
			
			if(value == row.item_code)
			{
				console.log('row.item_nm : ' + row.item_nm);
				result = row.item_nm;		
				$("#m_item_nm").val(result);
			}
		});

		if(result == ''){
			$("#m_item_nm").val('');
		}
		
	}else if(type == 'nm')
	{
		
		$.each(rowArr, function(idx, row){
			
			if(value == row.item_nm)
			{
				console.log('row.item_code : ' + row.item_code);
				result = row.item_code;
				$("#m_item_code").val(result);
			}
		});
		if(result == ''){
			$("#m_item_code").val('');
		}
		
	}

	loadList();
	
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
 		$('#m_product_req_date').daterangepicker({
			opens: 'right',
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		    startDate : moment(new Date()).add('days', -60),
			endDate : moment(new Date()).add('days', 60)
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
            footer: true
        },
        columns: [                
			{ field:'product_po', caption:'작업지시 번호', size:'20%', style:'text-align:center',sortable :true},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center',sortable :true},
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center',sortable :true},
			{ field:'', caption:'LOTNo.', size:'10%', style:'text-align:center', hidden:true},
			{ field:'product_menge', caption:'수량', size:'10%', style:'text-align:center',sortable :true},
			{ field:'product_req_date', caption:'생산 요청 일자', size:'20%', style:'text-align:center',sortable :true},
			{ field:'', caption:'검사 방법', size:'10%', style:'text-align:center', hidden:true},
			{ field:'routing_code', caption:'공정코드', size:'10%', style:'text-align:center',sortable :true},
			{ field:'routing_nm', caption:'공정명', size:'10%', style:'text-align:center',sortable :true},
			{ field:'flag', caption:'진행상태', size:'10%', style:'text-align:center',sortable :true}
			], 
		records: [
		],
		onReload: function(event) {
		},
		onSelect: function (event) {
			event.onComplete = function () {
				var item_code = w2ui.grid_list.get(event.recid).item_code;
				var routing_code = w2ui.grid_list.get(event.recid).routing_code;
				var product_po = w2ui.grid_list.get(event.recid).product_po;
				
				var item_nm = w2ui.grid_list.get(event.recid).item_nm;
				var product_req_date = w2ui.grid_list.get(event.recid).product_req_date;
				var routing_nm = w2ui.grid_list.get(event.recid).routing_nm;
				
				loadChk(item_code, routing_code, product_po);
			}
		},
		onUnselect: function (event) {
			w2ui['grid_chk'].clear();
			w2ui['grid_inpt'].clear();
		}
	});

}

function init_grid_list2(){
	
	$('#grid_chk').w2grid({ 
        name: 'grid_chk',
        show: {
            footer: true
        },
        multiSelect: true,
        columns: [                

              	{ field:'inspection_seq', caption:'NO', size:'5%', style:'text-align:center',sortable :true},
    			{ field:'routing_nm', caption:'공정명', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'inspection_time', caption:'작업시간(LOT)', size:'10%', style:'text-align:center', hidden:true},
    			{ field:'product_menge', caption:'투입수량', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'worker', caption:'작업자', size:'10%', style:'text-align:center', editable : { type: 'text'},sortable :true},
    			{ field:'inspection_item', caption:'검사항목', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'spec', caption:'SPEC(mm)', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'dfct_cnt', caption:'불량수량', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'comment', caption:'불량내용', size:'10%', style:'text-align:center', editable : { type: 'text'},sortable :true},
    			{ field:'end_time', caption:'검사종료시간', size:'15%', style:'text-align:center',sortable :true}
			], 
		records: [
		],	//
		onReload: function(event) {
		},
		onClick: function (event) {
		},
		onSelect: function (event) {
			event.onComplete = function () {
				loadInpt();
			}
		},
		onUnselect: function (event) {
			w2ui['grid_inpt'].clear();
		}
	});

}
function init_grid_list3(){
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
			{ field:'sample_type', caption:'샘플타입', size:'10%', style:'text-align:center', hidden:true},
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

//-------------------------------------------------------------------------------------------------------------------
$("#m_item_nm").change(_.debounce(function(event) {
	
	var item_nm = $("#m_item_nm").val();
	$(this).val(function(index, value) {
		console.log('item_nm key_up : '+ value);
		
		getItemInfo('nm',value);
		return value
	});
	
	},400));
	
	$("#m_item_code").change(
			
			_.debounce(function(event) 
			{
		
				var item_code = $("#m_item_code").val();
				$(this).val(function(index, value) {
					console.log('item_code key_up : '+ value);
					
					getItemInfo('cd',value);
					return value
				});
		
	},400));
	
	
	
	function getItemInfo(type, value)
	{
		
		console.log('getItemInfo() : ' + value);
		var result = "";
		if(type == 'cd')
		{
			$.each(gridDataArr, function(idx, row){
				
				if(value == row.item_code)
				{
					console.log('row.item_nm : ' + row.item_nm);
					result = row.item_nm;		
					$("#m_item_nm").val(result);
				}
			});

			if(result == ''){
				$("#m_item_nm").val('');
			}
			
		}else if(type == 'nm')
		{
			
			$.each(gridDataArr, function(idx, row){
				
				if(value == row.item_nm)
				{
					console.log('row.item_code : ' + row.item_code);
					result = row.item_code;
					$("#item_code").val(result);
				}
			});
			if(result == ''){
				$("#item_code").val('');
			}
			
		}

		
		
	}
	
	var gridDataArr;
//왼쪽 리스트 조회
function loadList()
{
	w2ui['grid_list'].clear();
	w2ui['grid_chk'].clear();
	w2ui['grid_inpt'].clear();
	
	var page_url = "/frontend/insp/selcInspMain";
	var postData = "product_po=" + encodeURIComponent($("#m_product_po").val())
			+ "&item_code=" + encodeURIComponent($("#m_item_code").val())
			+ "&item_nm=" + encodeURIComponent($("#m_item_nm").val())
			+ "&flag=" + encodeURIComponent($("#m_flag").val())
			+ "&routing_nm=" + encodeURIComponent('')
			+ "&search_type=" + encodeURIComponent($(":radio[name='rdo_ps_gubun']:checked").val())
			+ "&product_req_date=" + encodeURIComponent($("#m_product_req_date").val());

	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row) {
					row.recid = idx + 1;
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.product_po);
					}
					row.product_menge = Number(row.product_menge);
				});
				w2ui['grid_list'].records = rowArr;
				
				
				
				
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_list'].clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();

			$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#m_product_po').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
		},
		complete : function() {
			startValue_combo = ":)";
			
			document.getElementById("m_item_code").style.removeProperty("height");
			document.getElementById("m_item_nm").style.removeProperty("height");
			document.getElementById("m_product_po").style.removeProperty("height");
		}
	});
	
}

//-------------------------------------------------------------------------------------------------------------------

function loadChk(item_code, routing_code, product_po)
{
	w2ui['grid_chk'].clear();
	w2ui['grid_inpt'].clear();
	
	var page_url = "/frontend/insp/selcInspChkSht";
	var postData = "item_code=" + encodeURIComponent(item_code)
			+ "&product_po=" + encodeURIComponent(product_po)
			+ "&routing_code=" + encodeURIComponent(routing_code);

	w2ui['grid_chk'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row) {
					row.recid = idx + 1;
					row.product_menge = Number(row.product_menge);
					row.dfct_cnt = Number(row.dfct_cnt);
				});
				w2ui['grid_chk'].records = rowArr;
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_chk'].clear();
			} else {
				w2ui['grid_list'].clear();
				w2ui['grid_chk'].clear();
				w2ui['grid_inpt'].clear();
			}
			w2ui['grid_chk'].refresh();
			w2ui['grid_chk'].unlock();
		},
		complete : function() {
		}
	});
	
}


//-------------------------------------------------------------------------------------------------------------------

//오른쪽 하단 리스트 조회
function loadInpt()
{
	w2ui['grid_inpt'].clear();

	var selIdxArr = w2ui.grid_chk.getSelection();	//$('#p_slot').html();
	var product_po = w2ui.grid_chk.get(selIdxArr[0]).product_po;
	var item_code = w2ui.grid_chk.get(selIdxArr[0]).item_code;
	var routing_code = w2ui.grid_chk.get(selIdxArr[0]).routing_code;
	var inspection_seq = w2ui.grid_chk.get(selIdxArr[0]).inspection_seq;
	var product_menge = w2ui.grid_chk.get(selIdxArr[0]).product_menge;
	
	var spec = w2ui.grid_chk.get(selIdxArr[0]).spec;
	var min_spec = w2ui.grid_chk.get(selIdxArr[0]).min_spec;
	var max_spec = w2ui.grid_chk.get(selIdxArr[0]).max_spec;
	var inspection_gubun = w2ui.grid_chk.get(selIdxArr[0]).inspection_gubun;
	
	var page_url = "/frontend/insp/selcInspRstVal";
	var postData = "product_po=" + encodeURIComponent(product_po)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&routing_code=" + encodeURIComponent(routing_code)
			+ "&inspection_seq=" + encodeURIComponent(inspection_seq);
// 			+ "&sample_type=" + encodeURIComponent($('#m_gubun').val());

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
					row.inspection_item = w2ui.grid_chk.get(w2ui.grid_chk.getSelection()[0]).inspection_item;;
					
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