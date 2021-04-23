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
		<jsp:param name="selected_menu_p_cd" value="1042" />
		<jsp:param name="selected_menu_cd" value="1092" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
		설비 가동 정보
      </h1>
<!--       <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">고객사 관리</li>
      </ol> -->
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
				<!-- Progress Bar 
				 	<div id="hiddenDivLoading" style="visibility:hidden">
					다중 코드 입력 창 iframe 
					    <iframe id="iframeLoading" frameborder="0" style="z-index:-1; position:absolute; visibility:hidden"></iframe>
 					        <div id='load_List'><img src='/img/loading.gif' /></div>
						
 					</div> -->
					<!-- Progress Bar -->

					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						   	<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
<!-- 							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertCustomer();">등록</button>
					     	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="updateCustomer();">수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteCustomer();">삭제</button> -->
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
<!-- 							<div class="col-sm-2">
								<div class="form-group">
									 <label>Business</label>
									 <select id="business" name="business" class="form-control" style="height: 30px;" >
									 	<option value="ALL" selected="selected">전체</option> 
									 	<option value="business1">business1</option>
									 	<option value="business2">business2</option>
									 	<option value="business3">business3</option>
									 </select>
								</div>
							</div>  -->
							
							<div class="col-sm-2">
							<label>조회일자</label>
								<div class="input-group">
									 
									  <input type="combo" id="work_end_time" name="work_end_time" class="form-control pull-right input-sm" " 
									onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
												<div class="input-group-addon">
													<i class="fa fa-calendar"></i>
												</div>
								</div>
								
								
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>설비코드</label>
									  <select id="machine_nm" name="machine_nm" class="form-control" style="height: 30px;" >
									  </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>EVENT</label>
									<div class="form-group" style="margin-bottom: 0px;">
									<select id="gb" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
											<option value="">전체</option>
											<option value="PROCESS">PROCESS</option>
											<option value="UNPROCESS">비가동</option>
											<option value="WAITING">WAITING</option>
										
										</select>
									</div>
								</div>
							</div>
							
<!-- 														<div class="col-sm-2">
								<div class="form-group">
									 <label>Machine</label>
									 <select id="machine" name="machine" class="form-control" style="height: 30px;" >
									 	<option value="ALL" selected="selected">전체</option> 
									 	<option value="machine1">machine1</option>
									 	<option value="machine2">machine2</option>
									 	<option value="machine3">machine3</option>
									 </select>
								</div>
							</div>  -->
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>작업지시번호</label> 
									 <input type="combo" id="product_po" name="product_po" class="form-control input-sm" placeholder="작업지시번호" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="고객사명" -->
<!-- 										maxlength="15" onkeypress="if(event.keyCode==13) {loadList(); return false;}"  > -->
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>P/N</label>
									 <input type="combo" id="item_code" name="item_code" class="form-control input-sm" placeholder="P/N" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="land" name="land" class="form-control input-sm" placeholder="사업장" -->
<!-- 										maxlength="3" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
									
								</div>
							</div>
							

							
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> 
									<input type="combo" id=item_nm name="item_nm" class="form-control input-sm" placeholder="품명" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									<input type="text" id="customer_code" name="customer_code" class="form-control input-sm" placeholder="고객사코드" -->
<!-- 										maxlength="10" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
								</div>
							</div>
							
							
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 550px;"></div> 
							</div>
							
							<div class="col-md-12">
								<div id="grid_list2" style="width: 100%; height: 70px; margin-top:20px;"></div> 
							</div>
							
						</div>
					</div>
				</div>
				<!-- <div id="grid_list" style="width: 100%; height: 620px;"></div> -->
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->


<!-- modal_end -->
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

comboValue_po = new Array;
comboValue_ic = new Array;
comboValue_mc = new Array;


	
	$(function($) {


		fnCdD('m_machine_nm', 'MC1014');
		fnCdD('machine_nm', 'MC1014');
		
		
	 	fnLoadCommonOption(); 	 
	 	fnLoadCustomerGrid();

	 	
	})
	
	function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		
		$('#work_end_time').daterangepicker({
			opens: 'right', 
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
	
		});
		
		$('#origin_end_time').daterangepicker({
			opens: 'right', 
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
	
		});
	}
	
	
	$("#m_machine_code").change(function(){
		$("#fg_check_yn").val("N");
	});
	
	
	$("#machine_nm").change(function(){
		loadList();
	});
	
	function fnLoadCustomerGrid(){
	// 	 console.log(page_url);
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
				{ field:'machine_code', caption:'설비코드', size:'12%', style:'text-align:center', sortable: true }, 			
				{ field:'gb', caption:'EVENT', size:'12%', style:'text-align:center'
					 ,render: function (record, index, col_index) {
						var gb = this.getCellValue(index, col_index);

		                if(gb == 'PROCESS')
		            	{
		            	   return 'PROCESS';
		            	   
		            	}
		                else if (gb == 'UNPROCESS')
		            	{
		            		 return '비가동';
		            	}
		                else(gb == 'WAITING')
		            	{
		            		 return 'WAITING';
		            	}
		            	
		               return html;
		               }  
				}, 
				{ field:'work_str_time', caption:'시작', size:'20%', style:'text-align:center', sortable: true}, 
				{ field:'work_end_time', caption:'종료', size:'20%', style:'text-align:center', sortable: true}, 
				{ field:'work_time_sec', caption:'work_time_sec', size:'20%', style:'text-align:center', sortable: true}, 
				{ field:'today_time_sec', caption:'today_time_sec', size:'20%', style:'text-align:center', sortable: true}, 
				{ field:'work_time_hour', caption:'시간', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'product_po', caption:'작업지시번호', size:'15%', style:'text-align:center', sortable: true},
				{ field:'item_code', caption:'P/N', size:'15%', style:'text-align:center', sortable: true}, 
				{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center', sortable: true}, 
				{ field:'prod_menge', caption:'생산수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'prod_fail_menge', caption:'불량수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'per', caption:'가동률', size:'8%', style:'text-align:center', sortable: true}
				], 
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	
	

	function loadList() {
		
		w2ui.grid_list.clear();
		
		var page_url = "/frontend/repair/selectOperation_2";
		
		var date = $("#work_end_time").val();
		var origin_end_time = $("#origin_end_time").val();
		var gb = $('#gb').val();
		var machine_code = $('#machine_nm').val() || "";
		var product_po = $('#product_po').val() || "";
		var item_code = $('#item_code').val() || "";
		var item_nm = $('#item_nm').val() || "";
		
		var postData = {
				 work_str_time : date,
				 origin_end_time : origin_end_time,
				 gb : gb,
				 machine_code : machine_code,
				 product_po : product_po, 
				 item_code : item_code,
				 item_nm : item_nm
			
		};
		w2ui['grid_list'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length > 0){
					rowArr = data.rows;
					comboValue_po = new Array;
					comboValue_ic = new Array;
					comboValue_mc = new Array;
					
					
					$.each(rowArr, function(idx, row){
						row.recid = idx + 1;
						comboValue_po.push(row.product_po ? row.product_po+'' : '');
						comboValue_ic.push(row.item_code ? row.item_code+'' : '');
						comboValue_mc.push(row.item_nm ? row.machine_code+'' : '');
					});
					
					var date =  $("#work_end_time").val();
					var machine_code = $('#machine_nm').val() || "";	
					var prod_menge =  rowArr[0].prod_menge_sum;
					var prod_fail_menge =  rowArr[0].prod_fail_menge_sum;
					
					var work_time_sec = rowArr[0].work_time_sec_sum;
					var today_time_sec =  rowArr[0].today_time_sec_sum;
					
					var work_time_hour = '';
					var today_time_hour = '';
					
					var per = ( Number(work_time_sec) / Number(today_time_sec) ) * 100;
				
					w2ui['grid_list'].records = rowArr;
					

					// Drop List
					$('#product_po').w2field('combo', { items: _.uniq(comboValue_po, false), match : 'contains' });//유니크가 each문 중복을 막음
					document.getElementById("product_po").style.removeProperty("height");
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_ic, false), match : 'contains' });
					document.getElementById("item_code").style.removeProperty("height");
					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_mc, false), match : 'contains' });
					document.getElementById("item_nm").style.removeProperty("height");
				} else {
					w2ui['grid_list'].clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
				
				
				
				
			}, complete : function(){
				
				startValue_combo = ":)";
				w2ui['grid_list'].refresh();

			}			
			
		});
		
	}
	
	
	
	function loadList2() {
		
		w2ui.grid_list2.clear();
		
		var page_url = "/frontend/machine/selectProductOperStatus_2";
		
		var date = $("#work_end_time").val();

		var origin_date = $("#origin_end_time").val();
		var gb = $('#gb').val();
		var machine_code = $('#machine_nm').val() || "";
		var product_po = $('#product_po').val() || "";
		var item_code = $('#item_code').val() || "";
		var item_nm = $('#item_nm').val() || "";
		
		var postData = {
				 work_str_time : date,
				 gb : gb,
				 machine_code : machine_code,
				 product_po : product_po, 
				 item_code : item_code,
				 item_nm : item_nm
			
		};
		w2ui['grid_list'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length > 0){
					rowArr = data.rows;
					comboValue_po = new Array;
					comboValue_ic = new Array;
					comboValue_mc = new Array;
					
					
					$.each(rowArr, function(idx, row){
						row.recid = idx + 1;
					});
					
					w2ui['grid_list'].records = rowArr;
				
				} else {
					w2ui['grid_list'].clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
				
			}, complete : function(){
				
				startValue_combo = ":)";
				w2ui['grid_list'].refresh();
			}			
			
		});
		
	}

	// 실패
	 /* $('#customer_nm').w2field('combo', {	
	    url: '/info/customer/selectCustomer2', 
	    renderItem: function (item) {
	    	console.log("item - render");
	    	//console.log(item);
	        return item.customer_nm;
	    },
	    renderDrop: function (item) {
	    	console.log("item - renderDrop");
	    	//console.log(item);
	        return item.customer_nm;
	    },
	    compare: function (item, search) {
	    	console.log("item - search");
	    	//console.log(item);
	    	
	        var customer_nm = search;
	        
	        var match = false;
	        var re1 = new RegExp(customer_nm, 'i');
	            if ( re1.test(item.customer_nm) ) match = true;
	      
	        return match;
	    },
	    onSearch: function (event) {
	    	console.log("event - onSearch");
	    	console.log(event);
	    }, 
	    onNew: function (event) {
	        console.log('++ New Item: Do not forget to submit it to the server too', event);
	        $.extend(event.item, { customer_nm : event.item.text });
	    }
	});  */

	function fnCdD(val, val2){
		console.log("fnCdD("+val+")");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/machine/selectMachine";
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
		    			$("#"+val ).append("<option value=''>" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						if( val == "business" && row.machine_nm == "초음파세척기" ) {
							
						} else {
							$("#"+val ).append("<option value=" + row.machine_code + ">" + row.machine_code + "</option>");
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
	
	/* function fnBusiness(val){
		console.log("fnBusiness("+val+")");
		
		initOptions($('#'+val+'business')); // select 박스 초기화
		
		var strUrl = "/info/codeDetail/selectCdD";
		var postData = "master_code=" + encodeURIComponent("MC1012");
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    dataType: 'json', 
		    async : false, // 다 끝나고 다음 처리 해!
		    success:function(data, textStatus, jqXHR){
		    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length>0 ) { // 1
		    		rowArr = data.rows;
		    		
		    		if(val != "m_")
		    			$("#"+val+"business" ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val+"business" ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					});
					
		 			$("#"+val+"business option:eq(0)").prop("selected", true);	 			
					
		    	} else if(data.status == "200" && (data.rows).length==0 ) {
		    		initOptions($('#'+val+'business')); // select 박스 초기화
		    		
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    }
		});
	} */
	
	// modal_dcode 모달
	$( "#btn_dcode_add" ).on('click', function(e) {
// 		if(e.target.id == "btn_dcode_add"){
			$("form").each(function() {  
				if(this.name == "frm_dcode") {
		        	this.reset();
		        	$("#d_code_order").val("9999");
		        	$("#d_master_code").val("MC1017");
		        }  
     		});
			
			$("#btn_dcode_del").prop("disabled", true);
			$("#d_cmd").val("insert.detail_code");
			
			$("#modal_dcode").modal('show');
// 		}
	});
	
	

	$( "#btn_dcode_save" ).on('click', function(e) {
		e.preventDefault();
// 		if(e.target.id == "btn_dcode_save"){
			if($.trim($("#d_code_nm").val()).length == 0 || $.trim($("#d_code_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Code)", "코드명을 입력하세요.(영문코드포함)");
				return;
			}
			
			if($.trim($("#d_code_order").val()).length != 4) {
				fnMessageModalAlert("Notification(Code)", "코드출력순서를 4자리를 입력하세요.");
				return;
			}
			
			$("#d_code_use_yn").val($(':radio[name="rdo_dcode_use_yn"]:checked').val());
			fnSaveCode("frm_dcode");
// 		}
	});	
	

	function fnSaveCode(frm_name){
	  var postData = $("#"+frm_name).serializeArray();
	  var formURL = "/backend/code/save_code";
	  
	  $.ajax({
	      url : formURL,
	      type: "POST",
	      data : postData,
	      success:function(data, textStatus, jqXHR){
	      	if(data.status == "200") {
	      		fnMessageModalAlert("Notification(Code)", "입력하신 코드를 저장하였습니다.");
	      		
      			/* var grid = $("#grid_mcode");
      			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
      			fnSearchDetailCodeGrid(selected_master_code); */
      			
      			fnCdD('m_customer_integration', 'MC1017');
      			fnCdD('customer_integration', 'MC1017');
      			
      			$("#modal_dcode").modal('hide');
	      		
	      	} else {
	      		fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");	
	      	}
	      },
	      error: function(jqXHR, textStatus, errorThrown){
	        fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");	
	      }
	  });
	}
	
	$( "#btn_check" ).on('click', function(e) {
		e.preventDefault();
		if($.trim($("#m_customer_code").val()).length == 0) {
			fnMessageModalAlert("알림", "고객사코드를 입력하세요.");
			return;
		}
		
		/* if($.trim($("#m_member_id").val()).length < 3) {
			fnMessageModalAlert("Notification(Organ)", "고객사코드는 3자리이상을 입력하세요.");
			return;
		} */
		fnCheckCustomer();
	});
	
	function fnCheckCustomer(){
		var customer_code = $("#m_customer_code").val();
		var postData = "customer_code="+encodeURIComponent(customer_code);
	  var formURL = "/info/customer/checkCustomer";
	  
	  $.ajax({
	      url : formURL,
	      type: "POST",
	      data : postData,
	      success:function(data, textStatus, jqXHR){
	      	if(data.status == "200") {
	      		if(data.cnt > 0) {
	      			$("#fg_check_yn").val("N");
	      			fnMessageModalAlert("알림", "입력하신 고객사 코드는 사용할 수 없습니다.(이미 사용중)");
	      		} else {
	      			$("#fg_check_yn").val("Y");
	      			fnMessageModalAlert("알림", "입력하신 고객사 코드는 사용할 수 있습니다.");
	      		}
	      	} else {
	      		fnMessageModalAlert("알림", "입력하신 고객사 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
	      	}
	      },
	      error: function(jqXHR, textStatus, errorThrown){
	        fnMessageModalAlert("알림", "입력하신 고객사 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
	      }
	  });
	}
	
	// modal 띄우기 
	function insertCustomer() {
		console.log('insertCustomer()');
	
		/* $("#modal_info > .input-sm").val(''); */
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('등록');
 		$("#m_customer_code").attr('disabled',false);
 		$("#btn_check").show();
 		$("#fg_check_yn").val("N");
 		
 		$("#m_customer_code").val('');
		$("#m_customer_nm").val('');
		$("#m_address").val('');
		$("#m_land").val('');
		$("#m_telf").val('');
		$("#m_telfx").val('');
		$("#m_email_address").val('');
		$("#m_business_reg_num").val('');

		$("#m_business option:eq(0)").prop("selected", true);	 			
		$("#m_customer_integration option:eq(0)").prop("selected", true);	 			
		
		$("#modal_info").modal('show');
	
	}
	
	function updateCustomer() {
		console.log('updateCustomer()');
		
		/* $("#modal_info > .input-sm").val(''); */
		
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			var data = w2ui.grid_list.get(key[0]);
			$("#m_customer_code").attr('disabled',true);
			
			$("#btn_check").hide();
			$("#fg_check_yn").val("Y");
			
			$("#m_customer_code").val(data.customer_code);
			$("#m_customer_nm").val(data.customer_nm);
			$("#m_address").val(data.address);
			$("#m_land").val(data.land);
			$("#m_telf").val(data.telf);
			$("#m_telfx").val(data.telfx);
			$("#m_email_address").val(data.email_address);
			$("#m_business_reg_num").val(data.business_reg_num);
			$("#m_business").val(data.business_code).prop("selected", true);
			$("#m_customer_integration").val(data.customer_integration_code).prop("selected", true);
			
		
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveCustomer() {
		console.log('saveCustomer()');
		
		var customer_code = $("#m_customer_code").val();
		var customer_nm = $("#m_customer_nm").val();
		var address = $("#m_address").val();
		var land = $("#m_land").val();
		var telf = $("#m_telf").val();
		var telfx = $("#m_telfx").val();
		var email_address = $("#m_email_address").val();
		var business_reg_num = $("#m_business_reg_num").val();
		var business_code = $("#m_business option:selected").val();
		var business_nm = $("#m_business option:selected").text();
		
		
		var customer_integration_code = $("#m_customer_integration option:selected").val();
		var customer_integration_nm = $("#m_customer_integration option:selected").text();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
		} else if (key.length == 1){
			flag = "U";
		}

// 		if(flag=="I" && !chkSubmit($("#m_customer_code"), "고객사코드를")) return;

		if($("#fg_check_yn").val() == "N") {
			fnMessageModalAlert("알림", "고객사코드 중복체크를 확인하세요.");
			return;
		} else if(flag=="I" && !chkSubmit($("#m_customer_code"), "고객사코드를")) return;
		
		if(/* flag=="I" && */ !chkSubmit($("#m_customer_nm"), "고객사명을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_land"), "사업장을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_address"), "주소를")) return; 
		
// 		if(flag=="I" && !chkSubmit($("#m_telf"), "전화번호를")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_telfx"), "팩스를")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_email_address"), "이메일을")) return;
		
// 		if(flag=="I" && !chkSubmit($("#m_business_reg_num"), "사업자번호를")) return;
		
		// var flag = nullToBlank(customer_code)==''?"I":"U";
		console.log("flag = " + flag);
		
		console.log( "customer_code = " + $("#m_customer_code").val() );
		console.log( "customer_nm = " +$("#m_customer_nm").val() );
		console.log( "address = " +$("#m_address").val() );
		console.log( "land = " +$("#m_land").val() );
		console.log( "telf = " +$("#m_telf").val() );
		console.log( "telfx = " +$("#m_telfx").val() );
		console.log( "email_address = " +$("#m_email_address").val() );
		console.log( "business_reg_num = " +$("#m_business_reg_num").val() );
		console.log( "business code = " +$("#m_business option:selected").val() );
		console.log( "business name = " +$("#m_business option:selected").text() );
		
		console.log( "customer_integration code = " +$("#m_customer_integration option:selected").val() );
		console.log( "customer_integration name = " +$("#m_customer_integration option:selected").text() );
		
		$("#modal_info").modal('hide');
		
		var strUrl = "/info/customer/saveCustomer";
		var postData = "flag=" + flag
			+ "&customer_code=" + encodeURIComponent(customer_code)
			+ "&customer_nm=" + encodeURIComponent(customer_nm)
			+ "&business_code=" + encodeURIComponent(business_code)
			+ "&business_nm=" + encodeURIComponent(business_nm)
			+ "&customer_integration_code=" + encodeURIComponent(customer_integration_code)
			+ "&customer_integration_nm=" + encodeURIComponent(customer_integration_nm)
			+ "&land=" + encodeURIComponent(land)
			+ "&address=" + encodeURIComponent(address)
			+ "&telf=" + encodeURIComponent(telf)
			+ "&telfx=" + encodeURIComponent(telfx)
			+ "&email_address=" + encodeURIComponent(email_address)
			+ "&business_reg_num=" + encodeURIComponent(business_reg_num);
				 
		// escape(
		
		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	loadList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
		    }
		});
	}
	
	function deleteCustomer() {
		console.log('deleteCustomer()');
	
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {
 
			var data = w2ui.grid_list.get(key[0]);
			var code = data.customer_code;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/customer/deleteCustomer";
					var postData = "customer_code=" + code;
					
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
	
	//엑셀 1024
	function excelFileDownload()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;

		var fileName = 'oper_status.xlsx';
		var sheetTitle = '설비별 가동현황';
		var sheetName = '설비별 가동현황';
		
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
	
	// 미 입력시
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
//		    .append('<option value="All">-----</option>')
	    .val();
	}
	
</script>

</body>
</html>