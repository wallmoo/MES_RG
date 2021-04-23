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
		<jsp:param name="selected_menu_cd" value="1063" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	수입검사
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>품질관리</a></li><li class="active">수입검사</li>
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
									<label>원자재코드</label> <input type="text" id="item_code" name="item_code" placeholder="ex) 원자재코드"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>원자재명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 원자재명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>	
						
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">	
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>구매처</label> <input type="text" id="account_nm" name="account_nm" placeholder="ex) 구매처"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
								</div>
							</div>	
							<div class="col-sm-4">
								<div class="form-group">
								<label>검사 일자</label>
								<input type="checkbox" id="chk_eindt" name="chk_eindt" value="1" style="margin: 0px;" onchange="chgEindt();" >
								<div class="input-group">
									<input type="text" class="form-control pull-right input-sm" style="" id="income_date" placeholder=""> <!-- yyyymmdd~yyyymmdd -->
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
								</div>
									<!-- <div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="order_day" placeholder="yyyymmdd~yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div> -->
								</div>
							</div>
							
							<!-- <div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>검사진행 현황</label> <input type="text" id="customer_nm" name="customer_nm" placeholder="ex) 검사진행 현황"
									 class="form-control input-sm" maxlength="10" />
								</div>
							</div>	 -->
							<div class="col-sm-4">    
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
						<div id="grid_list" style="height: 560px; margin: 15px"></div>
					</div>
					</section>
				</div>	
				
				<div class="row" style="position: absolute; right: 45px; width: 48%; height:600px;">
					
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">수입 검사 측정 상세</h3>
								<input type="hidden" id='g1_recid'/>
								<div class="box-tools pull-right">
									
									<button type="button" id="btn_delete" class="btn btn-success btn-sm" onclick="requestOK();">OK</button>
									<button type="button" id="btn_delete" class="btn btn-success btn-sm" onclick="requestNG();">NG</button>
								</div>
							</div>
							<div id="grid_list3" style="height: 555px; margin: 15px"></div>
						</div>
					</div>
					
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">수입 검사 결과</h3>
							</div>
							<div id="grid_list2" style="height: 55px; margin: 15px"></div>
						</div>
					</div>
					
					
				</div>
			</div>
			</section>
		</div>
    <!-- /.content -->
  
  

<!--  -->
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->

<!-- 모달 커팅 -->
<div class="modal fade" id="mng_mod" data-backdrop="static">
	<div id="mod_dialog" class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-6" style="padding: 0px;">
					<h4 class="modal-title" id="modal_code_title">수입검사결과등록</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div id="progress" class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_insertInfo" name="frm_insertInfo" class="form-horizontal">							
					<div id="hiddenMemberNm" class="form-group row">
						<label for="" class="col-sm-3 control-label ">작업자명</label>
						<div class="col-sm-8">
							<input type="hidden" class="form-control clear_field member" id="mod_gubun"  />
							<input type="text" class="form-control clear_field member" id="mod_member_nm"  />
						</div>
					</div>
					<div id="" class="form-group row">
						<label for="" class="col-sm-3 control-label ">발주수량</label>
						<div class="col-sm-8">
							<input type="text" class="form-control clear_field member" id="mod_menge"  />
						</div>
					</div>
					<div id="" class="form-group row">
						<label for="" class="col-sm-3 control-label ">합격수량</label>
						<div class="col-sm-8">
							<input type="text" class="form-control clear_field member" id="mod_pass_menge"  />
						</div>
					</div>
					
					
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="btn_save" class="btn btn-success btn-sm" onclick="saveIncoming();">확인</button>
					<button type="button" id="close_mod" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
var startValue_combo = "";
var comboValue_nm = new Array;
var comboValue_cd = new Array;
var comboValue_ac = new Array;

$(function($) {
	fnLoadCommonOption(); 	 
	fnIncomeDate();
	
	$("#income_date").attr("disabled",true);
	$("#income_date").val('');
	
 	init_grid_list();
 	init_grid_list2();
 	init_grid_list3();
 	
 	loadList();
 	
})

function fnIncomeDate() {
 	$('#income_date').daterangepicker({
		opens: 'right',
		locale: {
			format : 'YYYYMMDD'	,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
					'7월', '8월', '9월', '10월', '11월', '12월' ],
			daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			showMonthAfterYear : true,
			yearSuffix : '년'
	    },
		startDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(-7, 'days'),
		endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(0, 'days')
	}); 
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
		
		 $('#order_day, #c_prod_day, #income_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
// 		 	     enddate: '2020-08-31' 
 				startDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(-7, 'days'),
				endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(0, 'days')
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


function chgEindt() {	
	var chk_flag = $("#chk_eindt").is(":checked");
	if(chk_flag) {	
		$("#income_date").attr("disabled",false);
		
		fnIncomeDate();
		// 판정후로 변경
		$('input:radio[name=rdo_routing_yn]:input[value="'+"Y"+'"]').iCheck('check');
		$(':radio[name="rdo_routing_yn"]').iCheck('update');
		
		loadList();
	} else {
	 	$("#income_date").attr("disabled",true);
	 	
	 	$("#income_date").val('');
		// 전체로 변경
// 		$('input:radio[name=rdo_routing_yn]:input[value="'+"ALL"+'"]').iCheck('check');
// 		$(':radio[name="rdo_routing_yn"]').iCheck('update');
		
		loadList();
	}
}

//gird_list1의 이벤트
$(":radio[name='rdo_routing_yn']").on('ifChecked', function(event){
	 var ssss = $(":radio[name='rdo_routing_yn']:checked").val();
	  console.log("ssss = " + ssss );
		
	  if( ssss == "Y" ) { // 판정후 ( date 가  들어감. )
		  fnIncomeDate();
		  $("#income_date").attr("disabled",false);
		  $("input:checkbox[id='chk_eindt']").prop("checked", true); //  $( 'input[name="consent"]' ).attr( 'checked', true );
		  
	  }  else { // 판정전 + ALL  ( date 가  안 들어감. )
		  $("#income_date").val('');
		  $("#income_date").attr("disabled",true);
		  $("input:checkbox[id='chk_eindt']").prop("checked", false);
	  }
	  
	  loadList();
	  
});

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
			{ field:'purchase_order_num', caption:'구매문서번호', size:'10%', style:'text-align:center', hidden: true},
			{ field:'purchase_num', caption:'구매문서 품목 번호', size:'10%', style:'text-align:center', hidden: true},
// 			{ field:'item_code', caption:'품번', size:'10%', style:'text-align:center', hidden: true},
// 			{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center', hidden: true},
			
			{ field:'item_code', caption:'원자재 코드', size:'10%', style:'text-align:center' }, // 80px
			{ field:'item_nm', caption:'원자재명', size:'10%', style:'text-align:center'}, // 200px
			
			
			{ field:'account_nm', caption:'구매처', size:'20%', style:'text-align:center'}, // 120px
			{ field:'menge', caption:'발주 수량', size:'10%', style:'text-align:center',hidden: true}, // 120px
			{ field:'in_menge', caption:'입고 수량', size:'10%', style:'text-align:center'}, // 120px
			{ field:'income_date', caption:'검사 일자', size:'10%', style:'text-align:center'},
			
			{ field:'item_nm', caption:'검사 방법', size:'10%', style:'text-align:center', hidden: true},
			
			
			{ field:'item_spec', caption:'검사 방법', size:'10%', style:'text-align:center', hidden: true}, 
			{ field:'item_type_code', caption:'검사 방법', size:'10%', style:'text-align:center', hidden: true}, 
			{ field:'item_type_nm', caption:'검사 방법', size:'10%', style:'text-align:center', hidden: true}, 
			{ field:'unit_price', caption:'검사 방법', size:'10%', style:'text-align:center', hidden: true}, 
			{ field:'income_menge', caption:'검사 방법', size:'10%', style:'text-align:center', hidden: true}
			
		
			], 
		/* sortData: [{field: 'vendor_code', direction: 'ASC'}], */
		records: [
		
		          
		],	//
		onReload: function(event) {
			//loadList();
		}, 
		onSelect: function (event) {
			event.onComplete = function () {
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				$('#g1_recid').val(key[0]);
				loadList2(data.purchase_order_num, data.purchase_num);
				
				loadList3(data.item_code);
			}
		}, 
		onUnselect: function (event) {
			event.onComplete = function () {
				$('#g1_recid').val('');
				
				w2ui['grid_list2'].clear();		
				w2ui['grid_list2'].refresh();
				
				w2ui['grid_list3'].clear();		
				w2ui['grid_list3'].refresh();
				
			}
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
			lineNumbers : false,
			footer: false
        },
        multiSelect: false,
        columns: [                
			{ field:'item_code', caption:'item_code', size:'15%', style:'text-align:center', hidden: true },
			{ field:'pass_yn', caption:'최종 결과', size:'15%', style:'text-align:center', 				
				render : function(record, index, col_index){
					var html = this.getCellValue(index, col_index);
					if (html == 'Y') {
						return "합격";	
					} else if (html == 'N') {
						return "불합격";
					}
				}
			}, // 120px
			{ field:'income_people', caption:'검사자', size:'15%', style:'text-align:center'}
			], 
		/* sortData: [{field: 'vendor_code', direction: 'ASC'}], */
		records: [ ],	//
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
        multiSelect: false,
        columns: [                
    		{ field:'item_code', caption:'아이템코드 ', size:'20%', style:'text-align:center', hidden: true }, // 120px
    		{ field:'inspection_seq', caption:'검사항목순번 ', size:'20%', style:'text-align:center', hidden: true }, // 120px
    		
    		{ field:'inspection_tool', caption:'검툴 ', size:'20%', style:'text-align:center', hidden: true }, // 120px
    		{ field:'inspection_method', caption:'검사방법 ', size:'20%', style:'text-align:center', hidden: true }, // 120px
    		
    		
			{ field:'inspection_item', caption:'검사 항목 ', size:'20%', style:'text-align:center' }, // 120px
			
			{ field:'inspection_gubun_nm', caption:'검사기준', size:'10%', style:'text-align:center', hidden: false },
			{ field:'inspection_gubun', caption:'검사기준', size:'10%', style:'text-align:center', hidden: false },
			{ field:'spec', caption:'규격', size:'10%', style:'text-align:center'},
			{ field:'min_spec', caption:'규격(LSL)', size:'10%', style:'text-align:center'},
			{ field:'max_spec', caption:'규격(USL)', size:'10%', style:'text-align:center'},
			{ field:'result_spec', caption:'측정 Data', size:'25%', style:'text-align:center', /* editable:{type:'float'}, */
				render : function(record, index, col_index){
					
					var html = this.getCellValue(index, col_index);
					
					if(record.inspection_gubun != 'MD1543')
					{
						if(record.result_spec == 'OK'){
							return '<span style="background-color:green;color: white;padding: 40px;">OK</span>';	
						} else if(record.result_spec == 'NG'){
							return '<span style="background-color:red;color: white;padding: 40px;">NG</span>';
						} else {
		                    return html || '';	
						}	
					} else {
						return html || '';
					}
				}
			}, // text
			
			{ field:'pass_yn', caption:'판정', size:'10%', style:'text-align:center',
				render : function(record, index, col_index){
					var html = this.getCellValue(index, col_index);
					
					if (html == 'Y') {
						return "합격";	
					} else if (html == 'N') {
						return "불합격";
					}
				}
			
			} // 합/불
			], 
		/* sortData: [{field: 'vendor_code', direction: 'ASC'}], */
		records: [ ],	//
		onEditField: function(event){
			if (event.originalEvent.keyCode == 13 )
			{
				event.preventDefault();
			}
		},
		
		onSelect: function (event) {
		   event.onComplete = function () {
		    	console.log("event.column = " + event.column );
			   if( event.column == 10 ) {
				   var getData = w2ui.grid_list3.get(event.recid);
	
				   console.log("getData.inspection_gubun = " + getData.inspection_gubun);
				   
				   if(getData.inspection_gubun == 'MD1543') {					
// 			    	  w2ui['grid_list3'].columns[6].editable = { type: 'date', format: 'yyyy.mm.dd'};			 
					  w2ui['grid_list3'].columns[10].editable = { type: 'float' };
			      } else if(getData.inspection_gubun == 'MD1544' || getData.inspection_gubun == 'MD1545')
	 				{
					   console.log("getData.result_spec = " + getData.result_spec);
					   
			    	 	 w2ui['grid_list3'].columns[10].editable = false;
 						if(getData.result_spec == 'NG')
 	 					{
 	 						w2ui['grid_list3'].set(event.recid, { result_spec: 'OK', pass_yn: 'Y' });
 	 					}
 	 					else if(getData.result_spec == 'OK' || getData.result_spec == '')
 	 					{
 	 						w2ui['grid_list3'].set(event.recid, { result_spec: 'NG', pass_yn: 'N' });
 	 					}
 						
 						var rcd = getData.recid;
 						var rcdDt = getData.result_spec;
 						
 						saveIncome_result3(rcd, rcdDt);
	 					
	 				}
			      
			      
			   }

		   }
		},
		
		onChange : function(event){
			event.onComplete= function(){				
				console.log("등록한 값 = " + event.value_new);
				
				if(event.value_new.length > 100 ) {
					fnMessageModalAlert("알림", "측정 Data의 값을 100이하로 입력해 주세요.");
					return;
				}
				
				if(event.value_new.length == 0 ) {
					fnMessageModalAlert("알림", "측정 Data의 값을 입력해 주세요.");
					return;
				}
				
				var rdata = w2ui['grid_list3'].getChanges();
				
// 				console.log('rdata changes');
// 				console.log(rdata);
// 				console.log("rdata[0].recid = " + rdata[0].recid);
				
				var o = w2ui.grid_list3.get(rdata[0].recid).min_spec || '0';
		    	var t = w2ui.grid_list3.get(rdata[0].recid).max_spec || '0';
		    	
				var pass_yn = "N";
				
				if ( parseInt(o) <= parseInt(event.value_new) ) {
					if( parseInt(t) >= parseInt(event.value_new)) {
		    			pass_yn = "Y";
					}
		    	} 
				
				w2ui['grid_list3'].set(rdata[0].recid, { pass_yn: pass_yn });
				
				w2ui['grid_list3'].save();
				
				var rcd = rdata[0].recid;
				var rcdDt = rdata[0].result_spec;
				
				
				saveIncome_result3(rcd, rcdDt);
				
				
				// ★★★★ 내일에 하장
				/* $.each(rdata, function(idx, nRId){
					if(nRId.warehouse_nm){
						// 비지니스 조회하는 곳에서 전체가 사라지고 비지니시 selected된 값으로 저장 하게 함. nRid 이 변수가 저장할때로 감
						nRId.warehouse_nm = w2ui['grid_list'].get(nRId.recid).warehouse_nm;
						nRId.warehouse_code = w2ui['grid_list'].get(nRId.recid).warehouse_code; // warehouse_code 코드 구하기
						nRId.business_code = $("#business option:selected").val();
						nRId.business_nm = $("#business option:selected").text();
								
								
						if(nRId.warehouse_code ){ // 이거 있으면 수정임
							console.log("수정");
							 updWarehouseDiv(nRId);
						}else {
							console.log("등록");
							insWarehouseDiv(nRId); // 이거 없음 등록임
						}
						// ★★★★ 내일에 하장
					}
				}); */
				
			}
		},
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}

function saveIncome_result3(rcd, rcdDt) {
	console.log("saveIncome_result3 (rcd = " + rcd + ", rcdDt = " + rcdDt + ")");
	
	var key1 = w2ui.grid_list.getSelection();
	var purchase_order_num = w2ui.grid_list.get(key1[0]).purchase_order_num || '';
	

	var data = w2ui.grid_list3.get(rcd);
	console.log(data);
	var item_code = data.item_code || '';
	var inspection_seq = data.inspection_seq || '';
	
	var inspection_item   = data.inspection_item || '';
    var inspection_gubun  = data.inspection_gubun || '';
    var spec              = data.spec || '';
    var min_spec          = data.min_spec || '';
    var max_spec          = data.max_spec || '';
//     var result_spec       = data.result_spec || '';

	var pass_yn	          = data.pass_yn || ''; //  "";
    
    var inspection_tool   = data.inspection_tool || '';
    var inspection_method = data.inspection_method || '';
	
	var strUrl = "/info/inspection/saveIncome_result3";
	var postData = "item_code=" + encodeURIComponent(item_code)
			+ "&inspection_seq=" + encodeURIComponent(inspection_seq)
			+ "&purchase_order_num=" + encodeURIComponent(purchase_order_num)
	
			+ "&inspection_tool=" + encodeURIComponent(inspection_tool)
			+ "&inspection_method=" + encodeURIComponent(inspection_method)
			+ "&inspection_item=" + encodeURIComponent(inspection_item)
		    + "&inspection_gubun=" + encodeURIComponent(inspection_gubun)
		    + "&spec=" + encodeURIComponent(spec)
		    + "&min_spec=" + encodeURIComponent(min_spec)
		    + "&max_spec=" + encodeURIComponent(max_spec)
		    + "&pass_yn=" + encodeURIComponent(pass_yn)
		    		
    		+ "&result_spec=" + encodeURIComponent(rcdDt);
	
	// escape(
	
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
// 		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
		    	loadList3(item_code);
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
	    }
	});
	
}

//-------------------------------------------------------------------------------------------------------------------

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
	
	var page_url = "/info/inspection/selectIncome_result"; // selectCsPr1 X
	var postData = "account_nm=" + encodeURIComponent(account_nm)
			 	 + "&item_code=" + encodeURIComponent(item_code) 
				 + "&item_nm=" + encodeURIComponent(item_nm);
	
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
				gridDataArr = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					comboValue_nm.push(row.item_nm);
					comboValue_cd.push(row.item_code);
					comboValue_ac.push(row.account_nm);
					
				});
				w2ui['grid_list'].records = rowArr;
				
				if (startValue_combo == "") {
					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
					$('#account_nm').w2field('combo', { items: _.uniq(comboValue_ac,false) ,match : 'contains' });
				}
				
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

// 검사자 등록
function saveIncoming(){
	var g1Recid = $('#g1_recid').val() || '';
	
	var income_people = $('#mod_member_nm').val() || '';
	var pass_menge = $('#mod_pass_menge').val() || '';
	
 	if(!income_people){
		fnMessageModalAlert("알림", "작업자를 입력해 주세요.");
		return false;
	}
 	
 	if(!pass_menge){
		fnMessageModalAlert("알림", "합격수량을 입력해주세요.");
		return false;
	}

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var purchase_order_num = data.purchase_order_num || '';
	var purchase_num = data.purchase_num || '';
	var pass_yn = $("#mod_gubun").val();
	
	var item_code = data.item_code || '';
	var item_nm = data.item_nm || '';
	var item_spec = data.item_spec || '';
	var item_type_code = data.item_type_code || '';
	var item_type_nm = data.item_type_nm || '';
	var unit_price = data.unit_price || '';
	var income_menge = data.income_menge || '';
	var today = getFormatDate(new Date()).replace(/-/gi, "");
	
	var strUrl = "/info/inspection/saveIncome_result2";
	var postData = "income_people=" + encodeURIComponent(income_people)
			+ "&purchase_order_num=" + encodeURIComponent(purchase_order_num)
			+ "&purchase_num=" + encodeURIComponent(purchase_num)
			+ "&pass_yn=" + encodeURIComponent(pass_yn)
			
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&item_nm=" + encodeURIComponent(item_nm)
			+ "&item_spec=" + encodeURIComponent(item_spec)
			+ "&item_type_code=" + encodeURIComponent(item_type_code)
			+ "&item_type_nm=" + encodeURIComponent(item_type_nm)
			+ "&unit_price=" + encodeURIComponent(unit_price)
			+ "&income_menge=" + encodeURIComponent(income_menge)
			+ "&income_date=" + encodeURIComponent(today)
			+ "&pass_menge=" + encodeURIComponent(pass_menge)
			+ "&purchase_status=" + encodeURIComponent('S');
						
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
		    	
				loadList('ins');
				loadList2(purchase_order_num, purchase_num);
				loadList3(item_code);
				
		    	$('#mng_mod').modal('hide');
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
	    }
	});
	
 	
	 
//  	$("#mod_dialog").css('width', '80%');
//  	$("#hiddenMemberNm").css('display', 'none');
 	
// 	var data = w2ui.grid_list.get(g1Recid);
// 	console.table(data);
	
}

// OK 요청
function requestOK()
{
	console.log("OK");
	var g1Recid = $('#g1_recid').val() || '';
	$('#mod_member_nm').val('');
	$("#mod_gubun").val('Y');
	

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	$("#mod_menge").val(data.menge);
	
	$("#mod_menge").attr('disabled',true);
// 	$("#mod_dialog").css('width', '30%');
//  	$("#hiddenMemberNm").css('display', '');
 	
	if(!g1Recid){
		fnMessageModalAlert("알림", "수입검사대상을 선택해 주세요.");
		return false;
	}

	$('#mng_mod').modal('show');
}

// NG 요청
function requestNG()
{
	console.log("NG");
	
	var g1Recid = $('#g1_recid').val() || '';
	$('#mod_member_nm').val('');
	$("#mod_gubun").val('N');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	$("#mod_menge").val(data.menge);
	
	if(!g1Recid){
		fnMessageModalAlert("알림", "수입검사대상을 선택해 주세요.");
		return false;
	}
	
	$('#mng_mod').modal('show');
}

// 오른쪽 상단 리스트 조회
function loadList2(purchase_order_num, purchase_num, flag)
{
	var kes = [];
	
	if ( flag == "ins" || flag == "del" ) {
		kes = w2ui.grid_list2.getSelection();	
	}
	
	var page_url = "/info/inspection/selectIncome_result2";
	var postData = "purchase_order_num=" + encodeURIComponent(purchase_order_num)
	postData += "&purchase_num=" + encodeURIComponent(purchase_num);
	
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
				w2ui.grid_list2.clear();
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
		}, complete : function() {
			w2ui.grid_list2.refresh();
		    $('#grid_list2').w2render('grid_list1');
		    
		    if ( flag == "ins" || flag == "del" ) {
		    	 w2ui.grid_list2.select(kes[0]);
			}
		}
	});
	
}


//-------------------------------------------------------------------------------------------------------------------

// 저장
function saveItem()
{
	
}

// 오른쪽 하단 리스트 조회
function loadList3(item_code)
{
	var page_url = "/info/inspection/selectIncome_result3";
	var postData = "item_code=" + encodeURIComponent(item_code);
	
	w2ui['grid_list3'].lock('loading...', true);
	
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
				w2ui['grid_list3'].records = rowArr;
			} else {
				w2ui.grid_list3.clear();
			}
			
		}, complete : function() {
			w2ui['grid_list3'].refresh();
			w2ui['grid_list3'].unlock();
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