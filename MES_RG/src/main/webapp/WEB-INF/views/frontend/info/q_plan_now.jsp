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
		<jsp:param name="selected_menu_cd" value="1107" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
       	수입검사 계획
        <small>구매/자재 관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 수입검사 계획</a></li><li class="active">구매/자재 관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
		<section class="col-lg-12">
			<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
				<div class="box-header with-border" style=" background-color: #DB8EB5;">
					<h3 class="box-title">수입검사 현황조회</h3>
					<div class="box-tools pull-right">
						<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="saveDirect();">수입검사 대상 확정</button>
						<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>
					</div>
				</div>
				<div id="" class="box-body">
					<div class="row">
						<div class="col-sm-3">                                                                    
							<div class="form-group">
								<label>발주일자</label>
								<div class="input-group">
									<input type="text" 
										class="form-control pull-right input-sm" style="" id="purchase_date" placeholder="yyyymmdd~yyyymmdd" onChange="loadList();">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
								</div>
							</div>
						</div>	
						<div class="col-sm-3">
							<div class="form-group">
								<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
								 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
								 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>구매처</label> <input type="text" id="account_nm" name="account_nm" placeholder="ex) 구매처"
								 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
							</div>
						</div>
						
						<div class="col-md-3">
							<div class="form-group">
								<label>진행상태</label>
								<select id="suip_status" name="suip_status" class="form-control select2 input-sm" data-placeholder="Action 구분선택...">
									<option value="">전체</option>
									<option value="미확정">미확정</option>
									<option value="확정">확정</option>
									<option value="공정마스터정보없음">공정마스터정보없음</option>
								</select>
							</div>
						</div>
						
						
					</div>
					<div id="row" style="position: relative; height:600px;">
						<div id="grid_list" style="width: 100%; height: 600px;"></div>
					</div>
				</div>
			</div>
		</section>				
		</div>
	</section>
 </div>


  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>


<script type="text/javascript">

var comboValue_nm1 = new Array;
var comboValue_nm2 = new Array;

$(function($) {
	$('#suip_status').val('미확정');
	
 	fnLoadCommonOption(); 
 	init_grid_list();
 	loadList();
})

function fnLoadCommonOption() {
 	
	 $("#suip_status").change(function(){
        loadList();
     });
	 
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

	$('#purchase_date').daterangepicker({
		opens: 'right',
		locale: {
			format : 'YYYYMMDD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
	    startDate: moment(minDate).add(-180, 'days'),
	    endDate: moment(minDate).add(180, 'days')
	}); 
 
 
	$("#m_order_price").keyup(function(event) {
		if(event.which >= 37 && event.which <= 40) return;
		$(this).val(function(index, value) {
			return value
			.replace(/\D/g, "")
			//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		});
	});
	
	$('input[type="radio"].flat-red').iCheck({
			checkboxClass: 'icheckbox_flat-green',
			radioClass: 'iradio_flat-green',
			handle: 'radio'
		});
		
		
	var minDate = getFormatDate(new Date());
	 $('#product_req_date').daterangepicker({
		opens: 'right',
		locale: {
			format : 'YYYYMMDD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
	    startDate: moment(minDate),
   		endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(30, 'days')
	});
}

$("#projectBox").change(function(){
	
	var val = $("#projectBox option:selected").val(); // text();
	
	console.log("val = " + val);
	
	if(val=="") {
		return;
	}
	
});



function init_grid_list(){
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
        	selectColumn: false,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [
				{ field:'purchase_date', caption:'발주일자', size:'10%', style:'text-align:center',sortable :true},
				{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center',sortable :true}, 
				{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center',sortable :true},
				{ field:'account_nm', caption:'구매처', size:'10%', style:'text-align:center',sortable :true},
				{ field:'menge', caption:'주문수량', size:'10%', style:'text-align:center',sortable :true},
				{ field:'suip_status', caption:'진행상태', size:'5%', style:'text-align:center',sortable :true},
				
				{ field:'purchase_order_num', caption:'purchase_order_num', size:'5%', style:'text-align:center',sortable :true, hidden:true},
				{ field:'purchase_num', caption:'purchase_num', size:'5%', style:'text-align:center',sortable :true, hidden:true},
			], 
	
		records: [],
		onReload: function(event) {
		},
		onSelect: function (event) {
 			event.onComplete = function () {
 			}
		},
		onClick: function (event) {}
	});

}

function loadList()
{
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	var suip_status = $('#suip_status').val();
	var purchase_date = $('#purchase_date').val();
	var account_nm = $('#account_nm').val();
	
	
	var page_url = "/insp/selcSuipInspOrd";
	
	var postData = "item_nm=" + encodeURIComponent(item_nm)
		+ "&item_code=" + encodeURIComponent(item_code)
		+ "&purchase_date=" + encodeURIComponent(purchase_date)
		+ "&account_nm=" + encodeURIComponent(account_nm)
		+ "&suip_status=" + encodeURIComponent(suip_status);
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				comboValue_nm1 = [];
				comboValue_nm2 = [];
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					comboValue_nm1.push(row.item_code);
					comboValue_nm2.push(row.item_nm);
					row.menge = Number(row.menge);
	
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
			
			
		},complete: function () {
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
		}
	});
}


function saveDirect()
{
	var key = w2ui.grid_list.getSelection();
	
	if( key.length != 1 ) {
		fnMessageModalAlert("알림", "하나의 항목을 선택해주세요.");
		return;	
	}
	
	fnMessageModalConfirm("알림", "품질검사 대상으로 확정하시겠습니까?", function(result){
		if(result == false) {
			return;
		}
		
		var rowData = w2ui['grid_list'].get(key[0]);
		
		var item_code = rowData.item_code;	
		var item_nm = rowData.item_nm;
		var menge = rowData.menge;
		var purchase_order_num = rowData.purchase_order_num;
		var purchase_num = rowData.purchase_num;
		
		var url = "/insp/confirmSuipInsp";
		var postData = "item_code=" + encodeURIComponent(item_code)
		+"&item_nm=" + encodeURIComponent(item_nm)
		
		+"&purchase_order_num=" + encodeURIComponent(purchase_order_num)
		+"&purchase_num=" + encodeURIComponent(purchase_num)
		+"&product_menge=" + encodeURIComponent(menge);
		
		
				 
		$.ajax({
		    url : url,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
		    		if(data.rtng_size == 0) {
		    			fnMessageModalAlert("알림", "해당 자재에 대한 공정정보가 없습니다.<br>공정관리 메뉴에서 정보를 등록해주세요.");
		    		} else {
		    			fnMessageModalAlert("알림", "정상적으로 처리되었습니다.");
		    			loadList();
		    		}
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("알림", "정보를 처리하는데 에러가 발생하였습니다.");
		    },
		    complete: function() {
		    }
		});
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

//key 누를때 숫자만 가능하도록.
function onlyNumber(){

     if((event.keyCode<48)||(event.keyCode>57))

        event.returnValue=false;

}
</script>

</body>
</html>