<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
String memberNm= SessionUtil.getMemberNm(request);
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
    	#item_code{
    		height: 30px !important;
    	}
    	#item_nm{
    		height: 30px !important;
    	}
    	#account_nm{
    		height: 30px !important;
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
		<jsp:param name="selected_menu_p_cd" value="1043" />
		<jsp:param name="selected_menu_cd" value="1095" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	수입검사이력조회
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
							<h3 class="box-title">수입 검사 대상</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							</div>
						</div>
						
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>	
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>구매처</label> <input type="text" id="account_nm" name="account_nm" placeholder="ex) 구매처"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>	
							<div class="col-sm-4">
								<div class="form-group">
								<label>진행상태</label>
									<select id="m_insp_status" name="m_insp_status" class="form-control select2 input-sm cond_2" data-placeholder="">
										<option value="">전체</option>
										<option value="발주요청">발주요청</option>
										<option value="검사진행중">검사진행중</option>
										<option value="수입검사완료">수입검사완료</option>
										<option value="부분입고">부분입고</option>
										<option value="입고완료">입고완료</option>
									</select>
								</div>
							</div>
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">	
							<div class="col-sm-4 hide">
								<div class="form-group">
									<label>검사 일자</label>
									<input type="checkbox" id="chk_eindt" name="chk_eindt" value="1" style="margin: 0px;" onchange="chgEindt();" >
									<div class="input-group">
										<input type="text" class="form-control pull-right input-sm" style="" id="income_date" placeholder=""> <!-- yyyymmdd~yyyymmdd -->
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-4 hide">    
								<div class="col-sm-12" style="padding-left: 0px;">
					                  <label for="rdo_routing_yn" class="control-label">검사진행 현황</label>
					             </div>
			                  	 <label>
					               <input type="radio" name="rdo_routing_yn" class="flat-red form-control" value="ALL" checked> 전체 
					             </label>
					             
					             <label>
					               <input type="radio" name="rdo_routing_yn" class="flat-red form-control" value="N" > 판정전
					             </label>
					             
					             <label>
					               <input type="radio" name="rdo_routing_yn" class="flat-red form-control" value="Y" > 판정후
					             </label>
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
								<h3 class="box-title">수입 검사 결과</h3>
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
								<h3 class="box-title">수입 검사 결과</h3>
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
var comboValue_nm = new Array;
var comboValue_cd = new Array;
var comboValue_ac = new Array;
var memberNm = '<%=memberNm%>';

$(function($) {

 	fnLoadCommonOption(); 	 

 	$("#income_date").attr("disabled",true);
	$("#income_date").val('');
	
 	init_grid_list();
 	
 	init_grid_list2();
 	
 	init_grid_list3();
 	
 	loadList();
 	
 
})


$('.cond_2').on("change",function(event){ 
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
				{ field:'purchase_order_num', caption:'구매문서번호', size:'10%', style:'text-align:center', hidden: true},
				{ field:'purchase_num', caption:'구매문서 품목 번호', size:'10%', style:'text-align:center', hidden: true},
				
				{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center' ,sortable :true}, // 80px
				{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center',sortable :true}, // 200px
				{ field:'account_nm', caption:'구매처', size:'20%', style:'text-align:center',sortable :true}, // 120px
				{ field:'in_menge', caption:'입고수량', size:'5%', style:'text-align:center', editable: { type: 'int' },sortable :true}, // 120px
				{ field:'insp_status', caption:'진행상태', size:'10%', style:'text-align:center',sortable :true}

], 
		records: [
		],
		onReload: function(event) {
		},
		onSelect: function (event) {
			event.onComplete = function () {
// 				var routing_nm = w2ui.grid_list.get(event.recid).routing_nm;
				var key = w2ui.grid_list.getSelection();
				var data = w2ui.grid_list.get(key[0]);
				
				loadChk(data.purchase_order_num, data.purchase_num);
				
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
    			{ field:'menge', caption:'투입수량', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'worker', caption:'작업자', size:'10%', style:'text-align:center', editable : { type: 'text'},sortable :true},
    			{ field:'inspection_item', caption:'검사항목', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'spec', caption:'SPEC(mm)', size:'10%', style:'text-align:center',sortable :true},
    			{ field:'c_dfct_cnt', caption:'불량수량', size:'10%', style:'text-align:center',sortable :true, editable: { type: 'int' }},
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
				var key = w2ui.grid_chk.getSelection();
				var data = w2ui.grid_chk.get(key[0]);
				
				loadInpt(data.inspection_seq );
				
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
	var gridDataArr;
// 왼쪽 리스트 조회
function loadList(flag) {
	
	var chk_flag = $("#chk_eindt").is(":checked");
	
	var kes = [];
	
	if ( flag == "ins" || flag == "del" ) {
		kes = w2ui.grid_list.getSelection();	
	}
	
   try{
	   w2ui['grid_list'].selectNone();
	   w2ui['grid_list2'].clear();
   }catch (e) 
   {
      
   }
	var account_nm = $("#account_nm").val();
	var income_date = $("#income_date").val();
	
	var item_code = $("#item_code").val();
	var item_nm = $("#item_nm").val();
	
	var pang_yn = $(":radio[name='rdo_routing_yn']:checked").val();
	
	var insp_status = $("#m_insp_status").val();
	
	var page_url = "/insp/selectIncome_result_s"; // selectCsPr1 X
	var postData = "account_nm=" + encodeURIComponent(account_nm)
			 	 + "&item_code=" + encodeURIComponent(item_code) 
			 	 + "&insp_status=" + encodeURIComponent(insp_status)
				 + "&item_nm=" + encodeURIComponent(item_nm)
				 + "&gubun_all=" + encodeURIComponent('all');
	
	if(chk_flag) {
		postData += "&income_date=" + encodeURIComponent(income_date);	
		postData += "&pang_yn=" + encodeURIComponent("X");
	} else {
		postData += "&pang_yn=" + encodeURIComponent(pang_yn);	 
	}
	
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
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm.push(row.item_nm);
						comboValue_cd.push(row.item_code);
						comboValue_ac.push(row.account_nm);
					}
					

					row.in_menge = Number(row.in_menge);

					
				});
				w2ui['grid_list'].records = rowArr;
				
				
					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
					$('#account_nm').w2field('combo', { items: _.uniq(comboValue_ac,false) ,match : 'contains' });
					
				
				
			} else {
				w2ui.grid_list.clear();
			}
			
		},complete: function () {
			
			startValue_combo = ":)";
	
			w2ui['grid_list'].unlock();
			w2ui.grid_list.refresh();			
		    $('#grid_list').w2render('grid_list');
		    
		    if ( flag == "ins" || flag == "del" ) {
		    	 w2ui.grid_list.select(kes[0]);
			}
		    
		}
	});
	
}

//-------------------------------------------------------------------------------------------------------------------

function loadChk( purchase_order_num, purchase_num )
{
	w2ui['grid_chk'].clear();
	w2ui['grid_inpt'].clear();
	
	var page_url = "/insp/selectIncome_result2_s";
	var postData = "purchase_num=" + encodeURIComponent(purchase_num)
			+ "&purchase_order_num=" + encodeURIComponent(purchase_order_num);

	w2ui['grid_chk'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				rowArr = data.rows;
				console.log(rowArr);
				$.each(rowArr, function(idx, row) {
					row.recid = idx + 1;
					row.c_dfct_cnt = Number(row.c_dfct_cnt);
				});
				
				
				
				w2ui['grid_chk'].records = rowArr;
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_chk'].clear();
			} else {
// 				w2ui['grid_list'].clear();
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
function loadInpt( inspection_seq )
{
	w2ui['grid_inpt'].clear();

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var purchase_order_num = data.purchase_order_num;
	var purchase_num = data.purchase_num;
	
	
	var page_url = "/insp/selectIncome_result3_s";
	var postData = "inspection_seq=" + encodeURIComponent(inspection_seq)
			+ "&purchase_order_num=" + encodeURIComponent(purchase_order_num)
			+ "&purchase_num=" + encodeURIComponent(purchase_num);

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
// 					row.inspection_item = w2ui.grid_chk.get(w2ui.grid_chk.getSelection()[0]).inspection_item;
					
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