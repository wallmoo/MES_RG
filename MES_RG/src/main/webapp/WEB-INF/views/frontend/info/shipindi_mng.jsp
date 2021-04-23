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
		<jsp:param name="selected_menu_p_cd" value="1016" />
		<jsp:param name="selected_menu_cd" value="1045" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
     	 출하지시관리
        <small>주문/출하관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 출하지시관리</a></li><li class="active">주문/출하관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">출하지시 대상 조회</h3>
						<div class="box-tools pull-right">
							<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							<button type="button" id="btn_create" 
							class="btn btn-info btn-sm" onclick="makeItem();">지시생성</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" 
							class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
								<label>주문일자</label>
								<button type="button" id="btn_today" onclick="todayLoadList();" 
							class="btn btn-warning btn-sm">금일</button><!-- loadList(); -->	 
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="delivery_date" placeholder="" onchange="loadList();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>| 주문번호</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<input type="text" id="order_num" name="order_num" class="form-control input-sm" placeholder="주문번호" 
										 onkeypress="if(event.keyCode==13) {loadList(); return false;}">
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
									<label>고객사명</label> <input type="combo" id="customer_nm" name="customer_nm" placeholder="ex) 고객사명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group" style="margin-right:0;">
									<label>P/N</label> <input type="text" id="item_code" name="m_item_code" placeholder="ex) P/N"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group" style="margin-right:0;">
									<label>품명</label> <input type="text" id="item_nm" name="m_item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>
						</div>
						<div id="grid_list" style="width: 100%; height: 300px; margin-bottom: 20px"></div>
					</div>
				</div>
				
				<div class="row" style="padding:15px;">		
					<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">출하지시</h3>
							<div class="box-tools pull-right">
						     	<button type="button" id="btn_search" class="btn btn-danger btn-sm" 
								onclick="deleteItem();">삭제</button>	
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
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:70%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">검사항목 편집</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="col-md-12">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group" style="margin-right:0;">
									<label>주문번호</label> <input type="text" id="m_order_num" name="m_order_num" placeholder="ex) 주문번호"
									 class="form-control input-sm" maxlength="100"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group" style="margin-right:0;">
									<label>고객사</label> <input type="text" id="m_customer_nm" name="m_customer_nm" placeholder="ex) 고객사"
									 class="form-control input-sm" maxlength="100"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group" style="margin-right:0;">
									<label>사업장</label> <input type="text" id="m_land" name="m_land" placeholder="ex) 사업장"
									 class="form-control input-sm" maxlength="100" />
								</div>
							</div>
							
							
							<div class="col-sm-6">
								<div class="box-tools pull-right">
									<button type="button" id="btn_create" 
									class="btn btn-success btn-sm" onclick="plus();">추가</button>
									<button type="button" id="btn_create" 
									class="btn btn-danger btn-sm" onclick="minus();">삭제</button> 
									<button type="button" id="btn_create" 
									class="btn btn-info btn-sm" onclick="saveProcess();">저장</button>
								</div>
							</div>
						</div>
						</div>
					<div class="row">
						<div class="col-md-7">
							<div id="modalGrid" style="width: 100%; height: 400px;" ></div>
						</div>
						<div class="col-md-5">
							<div id="modalGrid2" style="width: 100%; height: 400px;" ></div>
						</div>
					</div>
						
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="saveModal();">저장</button> -->
					<button type="button" id="" class="btn btn-default btn-sm" onclick="saveModal();">닫기</button>
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
var startValue_combo = "";
comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;
comboValue_nm4 = new Array;
comboValue_nm5 = new Array;

$(function($) {

 
 	init_grid_list();

 	init_grid_list2();
 	
 	fnLoadCommonOption(); 
 	modalGrid();
 	modalGrid2();
 	loadList();
 	
 	loadModal();
 	
 	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {

 		gridReDrw(); 

 		}, 100));
 	
	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {

		console.log('DOMSubtreeModified');
		changeGridUI(w2ui.grid_list.records);
   }, 100));
	
	w2ui['grid_list'].clear();
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
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
			lineNumbers : false,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'order_num', caption:'주문번호', size:'10%', style:'text-align:center',sortable :true}, // 80px
			{ field:'request_num', caption:'발주번호', size:'10%', style:'text-align:center',sortable :true}, // 80px
			{ field:'delivery_date', caption:'주문일자', size:'10%', style:'text-align:center',sortable :true}, // 200px
			{ field:'customer_nm', caption:'고객사', size:'10%', style:'text-align:center',sortable :true}, // 120px
			{ field:'land', caption:'사업장', size:'10%', style:'text-align:center',sortable :true}, // 120px
			{ field:'item_code', caption:'P/N', size:'20%', style:'text-align:center',sortable :true},
			{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center',sortable :true},
			{ field:'menge', caption:'주문요청수량', size:'10%', style:'text-align:center',sortable :true}, // right // 120px
			{ field:'order_stock_menge', caption:'주문요청 잔량', size:'15%', style:'text-align:center',sortable :true
			
				 ,	
				 
				 render: function (record, index, col_index) {
	               var html = this.getCellValue(index, col_index);
	    
	         
	               console.log('html : ' + html);
	               try{
	            	   var menge = w2ui.grid_list.records[index].menge; 
	             	
	             	  html = Number(menge) - Number(html);
	               }catch(e)
	               {
	            	   
	               }
	               return html;
	           } 	  
				
			},
			{ field:'manager_nm', caption:'담당자', size:'10%', style:'text-align:center',sortable :true}
			], 
		records: [
		
		          
		],	//
		onSelect: function (event) {
			event.onComplete = function () {
				
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list2'].refresh();
				// 오른쪽 그리드
				 deleteItems = new Array;
				 loadList2(data.order_num, data.item_code);
			}
		},
		onReload: function(event) {
			//loadList();
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
            footer: true
        },
        multiSelect: false,
        columns: [                

			{ field:'delivery_num', caption:'출하지시번호', size:'15%', style:'text-align:center',sortable :true}, // 120px
			{ field:'success_status', caption:'출하상태', size:'10%' , sortable: true , style:'text-align:center'
				
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'N')
	            	{
	            	   return '미출하';
	            	}else if(html == 'I')
	            	{
	            		 return '부분출하';
	            	}else if(html == 'Y')
	            	{
	            		 return '출하완료';
	            	}
	               return html;
	           } 	
		}, 
			{ field:'location', caption:'보관위치', size:'10%', style:'text-align:center',sortable :true},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center',sortable :true},
			{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center',sortable :true}, // right // 120px
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
			{ field:'delivery_order_menge', caption:'출하지시수량', size:'15%', style:'text-align:center',sortable :true},
			{ field:'delivery_order_date', caption:'출하예정일자', size:'15%', style:'text-align:center', editable: { type: 'date', format: 'yyyy-mm-dd'},sortable :true},// 120px
			{ field:'creator_nm', caption:'등록자', size:'10%', style:'text-align:center',sortable :true}
			], 
		/* sortData: [{field: 'vendor_code', direction: 'ASC'}], */
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
	
// 	var materialArr = new Array;
	
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
	var materialArr = new Array;
//상단 리스트 조회
function loadList()
{
	console.log("loadList()");
	w2ui['grid_list'].clear();
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
	   
	var delivery_date = $("#delivery_date").val();
		delivery_date = delivery_date.replace()
	var customer_nm = $("#customer_nm").val();
	var request_num = $("#request_num").val();
	
	var item_code = $("#item_code").val();
	var item_nm = $("#item_nm").val();
	
	var order_num = $("#order_num").val();
	
	var page_url = "/frontend/consumable/selectOrder2";

	
	var postData = "delivery_date=" + encodeURIComponent(delivery_date)
	 +"&customer_nm=" + encodeURIComponent(customer_nm)
	  +"&item_code=" + encodeURIComponent(item_code)
	   +"&item_nm=" + encodeURIComponent(item_nm)
	   +"&order_num=" + encodeURIComponent(order_num)
	 +"&request_num=" + encodeURIComponent(request_num);
	
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
						comboValue_nm1.push(row.customer_nm);
						comboValue_nm2.push(row.request_num);
						comboValue_nm3.push(row.item_code);
						comboValue_nm4.push(row.item_nm);
						comboValue_nm5.push(row.order_num);
					}
					
					row.menge = Number(row.menge);
					row.order_stock_menge = Number(row.order_stock_menge);
				});
				
				w2ui['grid_list'].records = rowArr;
				

			
			} else
			{
				w2ui['grid_list'].clear();
				
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#request_num').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			$('#order_num').w2field('combo', { items: _.uniq(comboValue_nm5,false) ,match : 'contains' });
			
			
			try{
				w2ui['grid_list2'].clear();
				
				
			}catch(e)
			{
				
			}
			
			changeGridUI(gridDataArr);
			w2ui['grid_list'].refresh();
// 			changeGridUI(gridDataArr);
		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("customer_nm").style.removeProperty("height");
			document.getElementById("request_num").style.removeProperty("height");
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("order_num").style.removeProperty("height");
		}
	});
}



//지시 생성
function makeItem()
{
	console.log('makeItem()');
	
	w2ui['modalGrid'].clear();
	w2ui['modalGrid'].refresh();
	
	
	w2ui['modalGrid2'].clear();
	w2ui['modalGrid2'].refresh();
	var key = w2ui.grid_list.getSelection();
	setTimeout(function(){
	      w2ui['modalGrid'].resize();
	      w2ui['modalGrid'].refresh();
	      
	      w2ui['modalGrid2'].resize();
	      w2ui['modalGrid2'].refresh();
	   }, 200);
	 if( key.length==1 ) {
		// update
		$("#modal_code_title").text('출하지시 생성 및 수정관리');
		var data = w2ui.grid_list.get(key[0]);
		$("#m_order_num").attr('disabled',true);
		$("#m_customer_nm").attr('disabled',true);
		$("#m_land").attr('disabled',true);
		
		$("#m_customer_nm").val(data.customer_nm);
		$("#m_order_num").val(data.order_num);
		$("#m_land").val(data.land);

		$("#ct_codeView").css('display', '');

		loadList_modal();
		requestDeliveryOrder(data.order_num, '');
		
		$("#modal_info").modal('show');
	} else {
		fnMessageModalAlert("알림", "생성하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
	}
	
}

function modalGrid() {
	console.log("modalGrid()");
	
	var rowArr = [];
	
	$('#modalGrid').w2grid({ 
        name: 'modalGrid',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: true
           
        },
        multiSelect: true,
        summary: true,
        columns: [              
			{field: 'order_num', caption: '주문번호', size:'30%', style:'text-align:center' , hidden : true },
			{field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'},
			{field: 'item_nm', caption: '품명', size:'30%', style:'text-align:center'},
			{ field:'menge', caption:'주문요청수량', size:'25%', style:'text-align:center'},
			{ field:'order_stock_menge', caption:'주문요청잔량', size:'25%',  style:'text-align:center'

 
				,render: function (record, index, col_index) {
	               var html = this.getCellValue(index, col_index);
	    
	         
	               console.log('html : ' + html);
	               try{
	            	   var menge = w2ui.modalGrid.records[index].menge; 
	             	
	             	  html = Number(menge) - Number(html);
	               }catch(e)
	               {
	            	   
	               }
	               return html;
	           } 	  
			
			},
			{ field:'stock_menge', caption:'재고수량', size:'20%',  style:'text-align:center'
				,render: function (record, index, col_index) {
		               var html = this.getCellValue(index, col_index);
		    
		               
		               if(html == null || html == '')
		           		{
		            	   html = 0;
		            	 }
		               return html;
		           } 	 
			
			},
			{ field:'delivery_date', caption:'주문일자', size:'25%',  style:'text-align:center'}
			
			], 

		records: [
		          
			],
		
		onSelect: function (event) {
			event.onComplete = function () {
				
				var key = w2ui.modalGrid.getSelection();

				var data = w2ui.modalGrid.get(key[0]);
				
				w2ui['modalGrid2'].refresh();
				// 오른쪽 그리드
				// requestDeliveryOrder(data.order_num, data.item_code);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
			}
		},
		onClick: function (event) {

		}, onChange: function(event) {
			
			event.onComplete = function () {
				
				
				
			}
	
		}	
	});
	
	
	//w2ui['modalGrid'].records = gridDataArr;
}


function loadList_modal() {
	console.log("loadList_modal()");
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);

	var customer_nm = data.customer_nm;
	var order_num = data.order_num;

	
	var page_url = "/frontend/consumable/selectOrder";
	
	var postData = "order_num=" + encodeURIComponent(order_num)
	 +"&customer_nm=" + encodeURIComponent(customer_nm);

	w2ui['modalGrid'].lock('loading...', true);
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
				

				w2ui['modalGrid'].records = rowArr;
			
			
			} else
			{
				w2ui['modalGrid'].clear();
			}
			w2ui['modalGrid'].refresh();
			w2ui['modalGrid'].unlock();
		},complete: function () {
			
		}
	});
	
}
function requestDeliveryOrder(order_num, item_code){
	var page_url = "/frontend/consumable/selectDeliveryOrder";
	
	var postData = "order_num=" + encodeURIComponent(order_num);
/* 	+ "&item_code=" + encodeURIComponent(item_code); */
	
	w2ui['modalGrid2'].lock('loading...', true);
	w2ui['modalGrid2'].clear();	
	w2ui['modalGrid2'].refresh();
	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
				});
			
				
				w2ui['modalGrid2'].records = rowArr;
					
				
			} else {
				//w2ui.grid_list.clear();
			}
			
			w2ui['modalGrid2'].refresh();
			w2ui['modalGrid2'].unlock();
			
	
		   	

		}, complete : function() {}
	});
}


function loadList2(order_num, item_code){
	var page_url = "/frontend/consumable/selectDeliveryOrder";
	
	var postData = "order_num=" + encodeURIComponent(order_num)
 	+ "&item_code=" + encodeURIComponent(item_code); 
	
	w2ui['grid_list2'].lock('loading...', true);
	w2ui['grid_list2'].clear();	
	w2ui['grid_list2'].refresh();

	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
				});
				w2ui['grid_list2'].records = rowArr;
	
				
				
			} else {
				//w2ui.grid_list.clear();
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();		   	

		}, complete : function() {}
	});
}
function modalGrid2() {
	console.log("modalGrid2()");
	
	var rowArr = [];
	
	$('#modalGrid2').w2grid({ 
        name: 'modalGrid2',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: true
           
        },
        multiSelect: false,
        summary: true,
        columns: [     
              	{field: 'order_num', caption: 'order_num', size:'30%', style:'text-align:center', hidden : true},
            	{field: 'delivery_req_date', caption: 'delivery_req_date', size:'30%', style:'text-align:center', hidden : true},
            	{field: 'customer_code', caption: 'customer_code', size:'30%', style:'text-align:center', hidden : true},
            	{field: 'customer_nm', caption: 'customer_nm', size:'30%', style:'text-align:center', hidden : true},
            	{field: 'land', caption: 'land', size:'30%', style:'text-align:center', hidden : true},
            	{field: 'unit_price', caption: 'unit_price', size:'30%', style:'text-align:center', hidden : true},
            	{field: 'menge', caption: 'menge', size:'30%', style:'text-align:center', hidden : true},
            	{field: 'total_price', caption: 'total_price', size:'30%', style:'text-align:center', hidden : true},
            
            	
				{field: 'delivery_num', caption: 'delivery_num', size:'30%', style:'text-align:center', hidden : true},
				{field: 'item_code', caption: 'P/N', size:'20%', style:'text-align:center', hidden : false},
				{field: 'item_nm', caption: '풍명', size:'20%', style:'text-align:center', hidden : false},
				{field: 'delivery_order_date', caption: '출하예정일', size:'18%', style:'text-align:center'  , editable: { type: 'date' , format: 'yyyy-mm-dd'}},
				{field: 'delivery_order_menge', caption: '출하지시수량', size:'15%', style:'text-align:center', editable: { type: 'int' } },
				{field: 'success_status', caption: 'success_status', size:'30%', style:'text-align:center', hidden : true}
			], 

		records: [
		          
			],
		
		onSelect: function (event) {
// 			event.onComplete = function () {
// 				console.log("onSelect");
				
// 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
			}
		},
		onClick: function (event) {
// 			event.onComplete = function () {
// 				console.log("onClick");
// 			}
		}, onChange: function(event) {
			
			event.onComplete = function () {
				
				var eventColumn = event.column;
				console.log(event);
				w2ui.modalGrid2.save();
				
			}
		}	
	});
	
	
	//w2ui['modalGrid'].records = gridDataArr;
}

function loadModal()
{
	console.log("loadModal()");
	   
	var delivery_date = $("#delivery_date").val();
	var customer_nm = $("#customer_nm").val();
	
	var page_url = "/frontend/consumable/selectOrder";

	
	var postData = "delivery_date=" + encodeURIComponent(delivery_date)
	 +"&customer_nm=" + encodeURIComponent(customer_nm);
	
	w2ui['modalGrid'].lock('loading...', true);
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
				
				w2ui['modalGrid'].records = rowArr;
			
			
			} 
			w2ui['modalGrid'].refresh();
			w2ui['modalGrid'].unlock();
			
			
		},complete: function () {
			
		}
	});
}


function checkItemCount(p_item_code , p_menge, value)
{
	
	
	var rowArr = w2ui['modalGrid2'].records; 
	

	var menge = p_menge;
	var total_delivery_order_menge = 0;
	for(var i = 0; i<rowArr.length; i++)
	{
		var item_code = rowArr[i].item_code;
		
		if(value == 0){
			menge = rowArr[i].menge;
		}
		if(item_code == p_item_code)
		{
			var delivery_order_menge = rowArr[i].delivery_order_menge;
			total_delivery_order_menge = Number(total_delivery_order_menge) + Number(delivery_order_menge);
		}
		console.log("p_item_code???" + p_item_code);
		console.log("item_code???" + item_code);
		console.log("출하지시수량은???" + total_delivery_order_menge);
		console.log("주문요청수량은???" + menge);
	}
	
	
	if(Number(menge) < Number(total_delivery_order_menge) + Number(value))
	{
		console.log("틀렸어용");
		console.log("item_code???" + item_code);
		console.log("출하지시수량은???" + total_delivery_order_menge);
		console.log("주문요청수량은???" + menge);
		return false;
	}
	
	return true;
	
}


function plus() {
	console.log("plus()");


	
/* 	if(getOrderMenge_Plus() < getDeliveryOrderMengeTot()+1)
	{
		fnMessageModalAlert('알림', '출하지시수량의 합은 주문요청수량보다 많을 수 없습니다.');		
		
		return;
	} */
	
	
	
	w2ui.modalGrid2.selectNone();
	w2ui['modalGrid2'].refresh();
	var rowArr = w2ui['modalGrid2'].records; 

	var currentRecid = Number(deleteItems.length) + Number(rowArr.length) + 1;
	console.log('currentRecid : ' + currentRecid);
	
/* 	w2ui['modalGrid2'].add([
	                		{ recid:  currentRecid , delivery_num : '', delivery_order_date: '', delivery_order_menge: '1'}
	                	]); */
	
	var minDate = getFormatDate(new Date());
	var selIdxArr = w2ui.modalGrid.getSelection();
	var chkLen = selIdxArr.length;
	
	
	for(var i = 0; i<chkLen; i++)
	{
		var row = w2ui.modalGrid.get(selIdxArr[i]);
		var currentRecid = Number(deleteItems.length) + Number(rowArr.length) + 1;
		
		
		/* if(row.menge < getDeliveryOrderMengeTot()+1)
		{
			fnMessageModalAlert('알림', '출하지시수량의 합은 주문요청수량보다 많을 수 없습니다.');		
			
			return;
		} */
		
		if(!checkItemCount(row.item_code, row.menge, 1))
		{
			fnMessageModalAlert('알림', '출하지시수량의 합은 주문요청수량보다 많을 수 없습니다.');		
			return;
		}
		
		w2ui['modalGrid2'].add(
			[
		        { recid:  currentRecid , 
		        	order_num : row.order_num, 
		        	delivery_req_date : row.delivery_req_date, 
		        	customer_code : row.customer_code, 
		        	customer_nm : row.customer_nm, 
		        	land : row.land, 
		        	unit_price : row.unit_price, 
		        	menge : row.menge, 
		        	total_price : row.total_price, 
		        	
		        	
		        	item_code : row.item_code, 
		        	item_nm : row.item_nm, 
		        	delivery_num : '', 
		        	delivery_order_date: minDate, 
		        	delivery_order_menge: '1'}
		       ]);
	}
	

	


}
var deleteItems = new Array;
//오른쪽 그리드에 값 삭제시
function minus() {
	var selIdxArr = w2ui.modalGrid2.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '삭제할 항목을 1개 이상 선택해야 합니다.');		
	}  else {
		for(var i=0; i<chkLen; i++){
		 	var row = w2ui.modalGrid2.get(selIdxArr[i]);
		 	
		 	// 삭제 어레이에 추가 한다.
		 	objt = new Object();
		 	objt.delivery_num = row.delivery_num;
			objt.delivery_order_date = row.delivery_order_date;
			objt.delivery_order_menge = row.delivery_order_menge;
			//objt.order_num = getOrderNum();
			
			if(objt.delivery_order_menge != '' && objt.delivery_order_menge != undefined && objt.delivery_order_menge != null)
			{
				console.log('deleteItems에 추가');
		 		deleteItems.push(objt);
			}
		 	
		 	w2ui['modalGrid2'].remove(row.recid);
		 	
			
		}
	 } 
	w2ui.modalGrid2.selectNone();	
	w2ui['modalGrid2'].refresh();

	
}


function saveModal()
{
	console.log("saveModal()");
	$("#modal_info").modal('hide');
	
	w2ui.grid_list.selectNone();	
	w2ui.grid_list2.selectNone();	
	w2ui['grid_list'].clear();
	w2ui['grid_list2'].clear();
	loadList();
}

function saveProcess()
{
	console.log("saveProcess()");
	w2ui.modalGrid2.save();

/* 	if(getOrderMenge_Plus() < getDeliveryOrderMengeTot())
	{
		
		
		fnMessageModalAlert('알림', '출하지시수량의 합은 주문요청수량보다 많을 수 없습니다.');		
		
		return;
	} */
	var leftDataR = w2ui.modalGrid.records;
	//var chkLen = selIdxArr.length;
	
	console.log('leftDataR : ' + leftDataR.length);
	var resultFlag = true;
	for(var i = 0; i<leftDataR.length; i++)
	{
		var row = leftDataR[i];
		console.log('### i  : ['+i +']');
		console.log('row.item_code : ' + row.item_code);
		
		var p_item_code = row.item_code;
		var value = 0;
		var p_menge = row.menge;
			
			
		var rowArr = w2ui['modalGrid2'].records; 

		var menge = p_menge;
		var total_delivery_order_menge = 0;
		
		
		for(var j = 0; j<rowArr.length; j++)
		{
			console.log('### j  : ['+ j +']');
			
			var item_code = rowArr[j].item_code;
			
			
			if(item_code == p_item_code)
			{
				var delivery_order_menge = rowArr[j].delivery_order_menge;
				total_delivery_order_menge = Number(total_delivery_order_menge) + Number(delivery_order_menge);
			}
			
			console.log("item_code???" + rowArr[j].item_code);
			console.log("p_item_code???" + p_item_code);
			console.log("출하지시수량은???" + total_delivery_order_menge);
		}	
		
		console.log("leftDataR[j].item_code???" + row.item_code);
		console.log("p_item_code???22222???" + p_item_code);
		console.log("menge???22222???" + row.menge);
		console.log("출하지시수량은???22222????" + total_delivery_order_menge);
		
		console.log("value???22222???" + value);

		if(Number(menge) < Number(total_delivery_order_menge) + Number(value))
		{
			console.log("탔다요-------------------");
			
			console.log("leftDataR[j].item_code???" + row.item_code);
			console.log("p_item_code???22222???" + p_item_code);
			console.log("menge???22222???" + row.menge);
			console.log("출하지시수량은???22222????" + total_delivery_order_menge);
			
			resultFlag = false;
		}
		
	}
	if(resultFlag == false){
		fnMessageModalAlert('알림', '출하지시수량의 합은 주문요청수량보다 많을 수 없습니다.');
		
		console.log("탔다요2222222222222-------------------");
		console.log("leftDataR[j].item_code???" + row.item_code);
		console.log("p_item_code???22222???" + p_item_code);
		console.log("menge???22222???" + row.menge);
		console.log("출하지시수량은???22222????" + total_delivery_order_menge);
		return;
	}
	
	$.each(deleteItems, function(idx, row){
		
		if(row.delivery_num != '' )
		{
			deleteItem_modal(row.delivery_num);
		}
	
	}); ; 
	
	var records = w2ui.modalGrid2.records;
	var status = "OK";

	
	 
	$.each(records, function(idx, row){
		
		if( row.delivery_order_menge == "" || row.delivery_order_date == "") {
			status = "ERROR";
		}
		
	});
	if(status != "OK" ) {
		fnMessageModalAlert("알림", "출하예정일, 출하지시수량은 비워둘 수 없습니다. 다시 입력해 주세요.");
		return;
	}	 
	var key = w2ui.modalGrid.getSelection();
	var leftData = w2ui.modalGrid.get(key[0]);
/* 	$.each(records, function(idx, row){
		

		saveModalItem(leftData,row);
	}); */
	
	saveRealAll();
}
/* 
function saveAll(leftData)
{
	
	var records = w2ui.modalGrid2.records;
	
	if(records.length == 0 )
	{
		return;
	}
	
	var order_num = leftData.order_num;
	var item_code = leftData.item_code;
	var item_nm = leftData.item_nm;
	
	var delivery_req_date = leftData.delivery_date;
	var customer_code = leftData.customer_code;
	var customer_nm = leftData.customer_nm;
	var land  = leftData.land;
	
	var unit_price = leftData.unit_price;
	var menge = leftData.menge;
	var total_price = leftData.total_price;
	
	var strUrl = "/frontend/consumable/saveDeliveryOrder2";
	var postData = "gridData=" + encodeURIComponent(JSON.stringify(records))
	+ "&order_num=" +  encodeURIComponent(order_num)
	+ "&item_code=" +  encodeURIComponent(item_code)
	+ "&item_nm=" +  encodeURIComponent(item_nm)
	
	+ "&delivery_req_date=" +  encodeURIComponent(delivery_req_date)
	+ "&customer_nm=" +  encodeURIComponent(customer_nm)
	+ "&customer_code=" +  encodeURIComponent(customer_code)
	+ "&land=" +  encodeURIComponent(land)
	
	+ "&unit_price=" +  encodeURIComponent(unit_price)
	+ "&menge=" +  encodeURIComponent(menge)
	+ "&total_price=" +  encodeURIComponent(total_price);
	
	FunLoadingBarStart();
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
		//async : false,	
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
		    	var key = w2ui.modalGrid.getSelection();
				var data = w2ui.modalGrid.get(key[0]);
				w2ui['modalGrid2'].refresh();
				
				 var order_stock_menge = getDeliveryOrderMengeTot();

				 w2ui['modalGrid'].set(data.recid,{order_stock_menge : order_stock_menge}); 

				requestDeliveryOrder(data.order_num, data.item_code);
				
				
			
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
 */

function saveRealAll()
{

	var records = w2ui.modalGrid2.records;
	
	if(records.length == 0 )
	{
		return;
	}
	
	var gridData = new Array();
	$.each(records, function(idx, row){
		
		var sendData = new Object();
		sendData.order_num = row.order_num;
		sendData.item_code = row.item_code;
		sendData.item_nm = row.item_nm;
		sendData.delivery_req_date = row.delivery_req_date;
		sendData.customer_code = row.customer_code;
		sendData.customer_nm = row.customer_nm;
		sendData.land = row.land;
		sendData.unit_price = row.unit_price;
		sendData.menge = row.menge;
		sendData.total_price = row.total_price;
		sendData.delivery_num = row.delivery_num;
		sendData.delivery_order_menge = row.delivery_order_menge;
		sendData.delivery_order_date = row.delivery_order_date;
		sendData.success_status = row.success_status;
		
		gridData.push(sendData);
	});

	
	var strUrl = "/frontend/consumable/saveDeliveryOrderAll";
	var postData = "gridData=" + encodeURIComponent(JSON.stringify(gridData));
	
	FunLoadingBarStart();
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
		//async : false,	
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
		    	var key = w2ui.modalGrid.getSelection();
				var data = w2ui.modalGrid.get(key[0]);
				w2ui['modalGrid2'].refresh();
				
				 var order_stock_menge = getDeliveryOrderMengeTot();

				// w2ui['modalGrid'].set(data.recid,{order_stock_menge : order_stock_menge}); 
				
				loadList_modal();
				var order_num = $("#m_order_num").val();
				
		    	var key_main = w2ui.grid_list.getSelection();
				var data_main = w2ui.grid_list.get(key_main[0]);
				
				loadList2(order_num, data_main.item_code);
				requestDeliveryOrder(order_num, '');
				 
				/*  gridDataArr[key[0]].order_stock_menge = order_stock_menge;
				 changeGridUI(gridDataArr); */
				 
			   	
				 
				
				
				
			
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




function saveModalItem(gridData,row) {
	console.log('saveModalItem()');

	var delivery_num = row.delivery_num;
	var delivery_order_date = row.delivery_order_date;
	var delivery_order_menge = row.delivery_order_menge;
	
	var order_num = gridData.order_num;
	var item_code = gridData.item_code;
	var item_nm = gridData.item_nm;
	
	var delivery_req_date = gridData.delivery_date;
	var customer_code = gridData.customer_code;
	var customer_nm = gridData.customer_nm;
	var land  = gridData.land;
	
	var unit_price = gridData.unit_price;
	var menge = gridData.menge;
	var total_price = gridData.total_price;
	var success_status = row.success_status;
	

	
	var strUrl = "/frontend/consumable/saveDeliveryOrder";

	var postData = {
			 delivery_num : delivery_num,
			 delivery_order_date : delivery_order_date,
			 delivery_order_menge : delivery_order_menge,
			
			 order_num : order_num,
			 item_code : item_code,
			 item_nm : item_nm,
			
			 delivery_req_date : delivery_req_date,
			 customer_nm : customer_nm,
			 customer_code : customer_code,
			 land  : land,
			
			 unit_price : unit_price,
			 menge : menge,
			 total_price : total_price,
			 success_status : success_status
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
		    	var key = w2ui.modalGrid.getSelection();
				var data = w2ui.modalGrid.get(key[0]);
				w2ui['modalGrid2'].refresh();
				// 오른쪽 그리드
				requestDeliveryOrder(data.order_num, data.item_code);
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


//모달에서 저장시 삭제
function deleteItem_modal(delivery_num) {
	console.log('deleteItem_modal()');
		
	var strUrl = "/frontend/consumable/deleteDeliveryOrder";

	var postData = "delivery_num=" + encodeURIComponent(delivery_num);
	
	$.ajax({
		 url: strUrl,
		 type: "POST",
		 dataType : 'json', 
		 data : postData, 
		 async : false,
		 success:function(data, textStatus, jqXHR){
		 	if(data.status == "200") {
		 		console.log(data);
		 		loadList();
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
//-------------------------------------------------------------------------------------------------------------------





function getOrderNum()
{
	var key = w2ui.modalGrid.getSelection();

	var order_num = "";
	if( key.length==1 ) {	
		var data = w2ui.modalGrid.get(key[0]);
		order_num = data.order_num;
	}
	
	return order_num;
}

function requestCustomer_data(flag)
{
	var customer_nm = $("#m_customer_nm").val();
	var result = '';
	$.each(customerArr, function(idx, row){
		

		if(flag == 'customer_code')
		{
			if( row.customer_nm == customer_nm ) 
			{
				result = row.customer_code;
			}
		}else if(flag == 'land')
		{
			if( row.customer_nm == customer_nm ) 
			{
				result = row.land;
			}
		}
	});
	
	return result;
}

function deleteItem() {
	console.log('deleteItem()');

	var key = w2ui.grid_list2.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui.grid_list2.get(key[0]);
		var delivery_num = data.delivery_num;
		
		var success_status = data.success_status;
		
		if(success_status != 'N'){
			fnMessageModalAlert("알림", "미출하 상태일때 삭제가 가능합니다."); // Notification
			return;
		}else {
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					
					var strUrl = "/frontend/consumable/delDeliveryOrder";
					
					var postData = "delivery_num=" + encodeURIComponent(delivery_num);
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		console.log(data);
						 		loadList();
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
}

function getOrderMenge_Plus()
{
	var result = 0;
	var selIdxArr = w2ui.modalGrid.getSelection();
	var chkLen = selIdxArr.length;
	for(var i = 0; i<chkLen; i++)
	{
		var row = w2ui.modalGrid.get(selIdxArr[i]);
		result = Number(result) + Number(row.menge);
	}
	return result;

}

function getOrderMenge()
{
	var result = 0;
	var key = w2ui.modalGrid.getSelection();

	if( key.length==1 ) {	
		var data = w2ui.modalGrid.get(key[0]);
		result = data.menge;
		
	}
	
	return result;
}


function getDeliveryOrderMengeTot()
{
	
	var result = 0;
	var records = w2ui.modalGrid2.records;
	$.each(records, function(idx, row){
		
		result = Number(result) + Number(row.delivery_order_menge);
		
	});	
	
	console.log('getDeliveryOrderMengeTot : ' + result);
	
	return result;
}


//-------------------------------------------------------------------------------------------------------------------

var prev_order_num = '';
var savePoint = 0;
var start_idx= 0;

function changeGridUI(rowArr)
{
	
	//w2ui['grid_list'].refresh();
	//w2ui['grid_list'].unlock();
	
	if(rowArr.length == 0){
		return;
	}
	 prev_order_num = '';
	 presavePoint = 0;
	 start_idx= 0;

	 //console.log('changeGridUI() : '+ rowArr.length);
	 for(var i=rowArr.length - 1 ; i>=0; i--)
	 {
			var row = rowArr[i];
			if(prev_order_num == '')
			{
				savePoint = rowArr.length - 1 ; 
				prev_order_num = row.order_num;
			}
			//console.log('savePoint : ' + savePoint);
			//console.log('prev_order_num : ' + prev_order_num);
			if(prev_order_num != row.order_num)
			{
				start_idx = i + 1;	
				
				savePoint = savePoint - i; 
				//console.log('- - - - 변경  ');
				//console.log('start_idx : ' + start_idx);
				//console.log('savePoint : ' + savePoint);
				rowMerge('grid_list',start_idx,0,savePoint);
				
				rowMerge('grid_list',start_idx,1,savePoint);
				
				rowMerge('grid_list',start_idx,2,savePoint);		

				prev_order_num = row.order_num;
				savePoint = i;
	
			}else {
				if(i == 0 ){
					start_idx = i;	
					
					savePoint = savePoint - i + 1; 
					//console.log('- - - - 변경  ');
					//console.log('start_idx : ' + start_idx);
					//console.log('savePoint : ' + savePoint);
					rowMerge('grid_list',start_idx,0,savePoint);
					
					rowMerge('grid_list',start_idx,1,savePoint);	
					
					rowMerge('grid_list',start_idx,2,savePoint);
				}
				
			}
	
	  }

	// 초기 셋팅 
	$('#grid_grid_list_records .w2ui-grid-data').css("border","solid");
	$('#grid_grid_list_records .w2ui-grid-data').css("border-width","1px");
	
	$("[id*=grid_grid_list_data_0_]").css("border-top","none");
	
	$("[id*=grid_grid_list_data_][id*=_0]").css("border-left","none");
	
	
	$("[id*=grid_grid_list_data_][col=0]").css("background-color","rgb(255, 232, 232)");
	$("[id*=grid_grid_list_data_][col=1]").css("background-color","rgb(234, 255, 240)");
	$("[id*=grid_grid_list_data_][col=2]").css("background-color","rgb(234, 255, 240)");
	
	
}

function gridReDrw()
{	
	var rowArr = w2ui['grid_list'].records;
	request_num
	var prevVal = '';
	var mergeCnt = 0;
	
	$.each(rowArr, function(idx, row){
		if(idx == 0){
			prevVal = row['order_num'];
		}
		
		var val = row['order_num'];
		if(prevVal != val)
		{
			selcBoxMerge('grid_list',(idx-mergeCnt),mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt),0,mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt),1,mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt),2,mergeCnt);
			mergeCnt = 0;
		}
		mergeCnt++;
		prevVal = row['order_num'];
		
		if(idx+1 == rowArr.length)
		{
			selcBoxMerge('grid_list',(idx-mergeCnt+1),mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt+1),0,mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt+1),1,mergeCnt);
			rowMerge('grid_list',(idx-mergeCnt+1),2,mergeCnt);
		}
	});		

	
	$('#grid_grid_list_frecords').css("padding-top","1px");
	
	$('#grid_grid_list_records .w2ui-grid-data').css("border","solid");
	$('#grid_grid_list_records .w2ui-grid-data').css("border-width","1px");
	
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-top","solid");
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-left","solid");
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-bottom","solid");
	$('#grid_list').find('.w2ui-grid-data.w2ui-col-select').css("border-width","1px");
	
	/*
		$('.w2ui-grid-data.w2ui-col-select').css("border-top","solid");
		$('.w2ui-grid-data.w2ui-col-select').css("border-left","solid");
		$('.w2ui-grid-data.w2ui-col-select').css("border-bottom","solid");
		$('.w2ui-grid-data.w2ui-col-select').css("border-width","1px");
	*/
	
	$("[id*=grid_grid_list_data_][col=0]").css("background-color","rgb(255, 232, 232)");
	$("[id*=grid_grid_list_data_][col=1]").css("background-color","rgb(234, 255, 240)");
	$("[id*=grid_grid_list_data_][col=2]").css("background-color","rgb(255, 255, 234)");
}




/*
* grid : 그리드 ID
* start_row : span을 시작할 row(0부터 시작)
* start_col : span을 시작할 start_col(0부터 시작)
* merge_cnt : span 할 셀 개수
*/



function rowMerge(grid, start_row, start_col, merge_cnt)
{
	$("#grid_"+grid+"_data_"+start_row+"_"+start_col).attr("rowspan", merge_cnt);
	for(var i=start_row+1 ; i<merge_cnt+start_row; i++)
	{
	   $("#grid_"+grid+"_data_"+i+"_"+start_col).addClass('hide');
	}
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

function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '출하지시 관리.xlsx';
	var sheetTitle = '출하지시 관리';
	var sheetName = '출하지시 관리';
	
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
</script>

</body>
</html>