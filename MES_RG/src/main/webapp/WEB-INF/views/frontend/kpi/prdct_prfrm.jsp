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
		<jsp:param name="selected_menu_p_cd" value="1013" />
		<jsp:param name="selected_menu_cd" value="1029" />
	</jsp:include>

<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>	

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        생산 실적 정보
        <small>KPI Monitoring</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> KPI Monitoring</a></li><li class="active">생산 실적 정보</li>
      </ol>
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
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>연도</label>
									 <select id="date" name="date" class="form-control" style="height: 30px;" >
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>P/N</label>
									 <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>품명</label>
									 <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
					
										<div class="form-group">
											<label>자재 유형</label> 
											<select id="item_type_code" name="item_type_code" class="form-control" style="height: 30px;">
											</select>
										</div>
							</div>
							
						</div>
						
						<!-- chart grid -->
						<div class="row" style="margin-bottom: 10px">
							<div class="col-md-12 text-center">
								<div id="chartHolder" style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
							</div>
						</div>
						
						<div class="row" style="margin-bottom: 5px;">
								<div class="col-md-3 text-left" >
									<h3 class="" style="margin: 0; margin-left: 15px;" id="idxMonth">월별상세</h3>
								</div>
						
								<div class="col-md-3 text-right" >
									<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">액셀다운로드</button>
								</div>
							
								<div class="col-md-3 text-left" >
									<h3 class="" style="margin: 0; margin-left: 15px;">일자별상세</h3>
								</div>
							
								<div class="col-md-3 text-right">
									<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload2();">액셀다운로드</button>
								</div>
						</div>
						
						<div class="row">
							
							<div class="col-md-6">
								<div id="grid_list_lt" style="width: 100%; height: 200px; "></div>
							</div>
							
							<div class="col-md-6">
								<div id="grid_list_rt" style="width: 100%; height: 200px; "></div>
							</div>
						</div>
						<!-- chart grid -->
					</div>
				</div>
				<!-- 
				<div class="row" style="margin-bottom: 10px">
					<div class="col-md-12 text-center">
						<div id="chartHolder" style="width: 100%; height: 350px; text-align: center; margin-bottom: 5px;"></div>
					</div>
				</div>
			
			<div class="row" style="margin-bottom: 5px;">
					<div class="col-md-3 text-left" >
						<h3 class="" style="margin: 0; margin-left: 15px;">월별상세</h3>
					</div>
			
					<div class="col-md-3 text-right" >
						<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">액셀다운로드</button>
					</div>
				
					<div class="col-md-3 text-left" >
						<h3 class="" style="margin: 0; margin-left: 15px;">일자별상세</h3>
					</div>
				
					<div class="col-md-3 text-right">
						<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload2();">액셀다운로드</button>
					</div>
			</div>
			
			
				<div class="row">
					
					<div class="col-md-6">
						<div id="grid_list_lt" style="width: 100%; height: 200px; "></div>
					</div>
					
					<div class="col-md-6">
						<div id="grid_list_rt" style="width: 100%; height: 200px; "></div>
					</div>
				</div> -->
				
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">Business</label>
							<div class="col-sm-7">
								<select class="form-control input-sm" id="m_business" name="m_business" >
								 	<option value="business1">business1</option>
								 	<option value="business2">business2</option>
								 	<option value="business3">business3</option>
								</select>
							</div>
						</div>
					</div>
					
					<div class="row" id="ct_codeView">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_customer_code" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">거래처명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_customer_nm" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_address" value="">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telf1">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telfx">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_email_address">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_business_reg_num">
							</div>
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveCustomer();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
<!-- ./wrapper -->

<script type="text/javascript">
	var layoutStr = "";
	var chartLength = "";
	var chartData = new Array();
	
	$(function($) {
	 	fnLoadCommonOption(); 	
 	 	fnCdD('item_type_code', 'MC1014');
	 	
	 	//fnCdD('pn', /* '',  */'partition/selectPartitionDetail'); // Id, 파라미터, 어느 테이블 참조하는지.(컨트롤러 메소드명)
	 	
	 	var date = new Date();
		var currYear = date.getFullYear();

		$("#date").append("<option value='" +(currYear-2) +"'>" + (currYear-2) + "</option>");
		$("#date").append("<option value='" +(currYear-1) +"'>" + (currYear-1) + "</option>");
		$("#date").append("<option value='" +(currYear) +"'>" + currYear + "</option>");
		$("#date").append("<option value='" +(currYear+1) +"'>" + (currYear+1) + "</option>");

		
		$("#date option:eq(2)").prop("selected", true);
		
		//$("#year option:eq(2)").prop("selected", true);
		//$("#date").val(currYear).prop("selected", true);
	 	
	 	fnLoadLeftGrid();
	 	fnLoadRightGrid();
	 	
	 	loadList();
	 	requestItem();

	})
	
	
	$("#item_nm").change(_.debounce(function(event) {
	
	var item_nm = $("#item_nm").val();
	$(this).val(function(index, value) {
		console.log('item_nm key_up : '+ value);
		
		getItemInfo('nm',value);
		return value
	});
	
	},400));
	$("#item_code").change(
			
			_.debounce(function(event) 
			{
		
				var item_code = $("#item_code").val();
				$(this).val(function(index, value) {
					console.log('item_code key_up : '+ value);
					
					getItemInfo('cd',value);
					return value
				});
		
	},400));
	
	function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		
		$('#request_date_range').daterangepicker({
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
	
	
	function fnLoadLeftGrid(){
		 console.log('fnLoadLeftGrid()');
		var rowArr = [];
		
		$('#grid_list_lt').w2grid({ 
	        name: 'grid_list_lt',
	        show: {
	        	selectColumn: false,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
				{ field:'item_code', caption:'P/N', size:'25%', style:'text-align:center', sortable: true}, 
				{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center', sortable: true}, 
				{ field:'prod_menge', caption:'실적 수량', size:'8%', style:'text-align:center', sortable: true },
				{ field:'prod_fail_menge', caption:'불량 수량', size:'8%', style:'text-align:center', sortable: true },
				{ field:'fail_per', caption:'불량율', size:'8%', style:'text-align:center' , sortable: true},
				{ field:'process_time', caption:'TAT(평균)', size:'10%', style:'text-align:center', sortable: true ,
					render:function(record, index, col_index) {
  	                    var html = this.getCellValue(index, col_index);
  	                    
  	                    return html + '일';
                	  }},
				{ field:'d_process_time', caption:'환산TAT', size:'10%', style:'text-align:center' , sortable: true,
      					render:function(record, index, col_index) {
      	                    var html = this.getCellValue(index, col_index);
      	                    
      	                    return html + '일';
                    	  }}
				
				], 
			sortData: [{field: 'pn', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		//loadList_lt();
	}
	
	function fnLoadRightGrid(){
		 console.log('fnLoadRightGrid()');
		var rowArr = [];
		
		$('#grid_list_rt').w2grid({ 
	        name: 'grid_list_rt',
	        show: {
	        	selectColumn: false,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
				{ field:'product_date', caption:'실적일자', size:'15%', style:'text-align:center', sortable: true}, 
				{ field:'item_code', caption:'P/N', size:'25%', style:'text-align:center', sortable: true}, 
				{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center', sortable: true}, 
				{ field:'prod_menge', caption:'실적 수량', size:'8%', style:'text-align:center' , sortable: true},
				{ field:'prod_fail_menge', caption:'불량 수량', size:'8%', style:'text-align:center', sortable: true },
				{ field:'fail_per', caption:'불량율', size:'8%', style:'text-align:center', sortable: true },
				{ field:'process_time', caption:'TAT(평균)', size:'10%', style:'text-align:center', sortable: true ,
					render:function(record, index, col_index) {
  	                    var html = this.getCellValue(index, col_index);
  	                    
  	                    return html + '일';
                	  }},
				{ field:'d_process_time', caption:'환산TAT', size:'10%', style:'text-align:center' , sortable: true,
      					render:function(record, index, col_index) {
      	                    var html = this.getCellValue(index, col_index);
      	                    
      	                    return html + '시간';
                    	  }}
				
				
				], 
			sortData: [{field: 'customer_code', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		//loadList_rt();
	}
	
	$("#date").change(function(){
		loadList();
		loadList_lt();
		loadList_rt();
	});
	
	var startValue_combo = "";

	comboValue_nm_i = new Array;
	comboValue_cd = new Array;

	var materialArr = new Array;

	//모달 제품
	function requestItem(){
		var page_url = "/frontend/repair/selectRepairItem";
		
	/* 	var postData = "item_code=" + encodeURIComponent(item_code)
			+ "&item_nm=" + encodeURIComponent(item_nm); */
		
		$.ajax({
			url : page_url,
			type : 'POST',
			//data : postData,
			data_type : 'json',
			success : function(data){
				if(data.status == 200 && (data.rows).length > 0){
					rowArr = data.rows;
					materialArr = rowArr;
					$.each(rowArr, function(idx, row){
						row.recid = idx + 1;
						
						if (startValue_combo == "") {
							comboValue_nm_i.push(row.item_nm);
							comboValue_cd.push(row.item_code);
						}
					});
				
					
					if (startValue_combo == "") {
						
						
						$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm_i,false) ,match : 'contains' });				
						$('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
					}
				} else {
					
				}

			}, complete : function() {
				startValue_combo = ":)";
			}
		});
	}
	
	function getItemInfo(type, value)
	{
		
		console.log('getItemInfo() : ' + value);
		var result = "";
		if(type == 'cd')
		{
			$.each(materialArr, function(idx, row){
				
				if(value == row.item_code)
				{
					console.log('row.item_nm : ' + row.item_nm);
					result = row.item_nm;		
					$("#item_nm").val(result);
				}
			});

			if(result == ''){
				$("#item_nm").val('');
			}
			
		}else if(type == 'nm')
		{
			
			$.each(materialArr, function(idx, row){
				
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
	
	function fnCdD(val, val2) {
		console.log("fnCdD(" + val + ")");

		initOptions($('#' + val)); // select 박스 초기화

		var strUrl = "/info/codeDetail/selectCdD";
		var postData = "master_code=" + encodeURIComponent(val2);

		$
				.ajax({
					url : strUrl,
					type : "POST",
					data : postData,
					dataType : 'json',
					async : false, // 다 끝나고 다음 처리 해!
					success : function(data, textStatus, jqXHR) {
						//	 	    	console.log("(data.rows).length = " + (data.rows).length);
						if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
							rowArr = data.rows;

							var sub = val.substr(0, 2);

							//  if(valsub != "m_")
							$("#item_type_code").append("<option value="+''+">" + "전체"+ "</option>");

							$.each(rowArr, function(idx, row) {
								
								//MD1245 MD1246 MD1250
								if(row.detail_code != 'MD1245' && row.detail_code != 'MD1246' && row.detail_code != 'MD1250'){

									$("#item_type_code").append("<option value=" + row.detail_code + ">"+ row.code_nm+ "</option>");
								}
								
							});

								$("#item_type_code option:eq(0)").prop("selected",true);

						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
					},

					complete : function() {
 						loadList();

					}
				});

	}
	
	$("#item_type_code").change(function() {

		var item_type_code = $("#item_type_code").val();

		loadList();

	});
	
	var goal = 0;

	
	function loadList() {
		console.log("loadList()");
				
		try{
			w2ui.grid_list_lt.clear();
			w2ui.grid_list_rt.clear();
			w2ui['grid_list_lt'].refresh();
			w2ui['grid_list_rt'].refresh();
		}catch(e)
		{
			
		}
		chartData = new Array();
		
		var year = $("#date").val();
  		var item_type_code = $("#item_type_code").val();
		var item_code = $("#item_code").val(); 
		var item_nm = $("#item_nm").val(); 
		
		var page_url = "/frontend/repair/selectProduct";
		
		var postData = "year=" + encodeURIComponent(year)
     			+"&item_type_code=" + encodeURIComponent(item_type_code) 
				+"&item_code=" + encodeURIComponent(item_code)
				+"&item_nm=" + encodeURIComponent(item_nm);
		var result ;
		
		
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					//console.table(data.rows);
					result = data.rows;
	
					console.table(result); 
					var grapArr = new Array();
					
					
					for(var i = 1; i<= 12; i++)
					{
						var grapObj = new Object();
						grapObj.month = i + "월";
						grapObj.prod_menge = 0;
						grapObj.prod_fail_menge = 0;
						grapObj.process_time = 0;
						grapObj.d_process_time = 0;
						
						grapObj.goal = 0;
						
						grapObj.item_type_code = $("#item_type_code").val();
						grapArr.push(grapObj);
						
					}
					
					// 9월 하나만 있어서 하나만 되서 가라ㅏ로 데이터 만들어야함 
					 goal = 0;
					for(var i = 0; i< result.length; i++)
					{
						var grapObj = new Object();
						var month = result[i].month;
						
						grapObj.month = result[i].month + "월";
						grapObj.prod_menge = result[i].prod_menge;
						
						grapObj.goal = result[i].goal;
						
						
						grapObj.prod_fail_menge = result[i].prod_fail_menge;
						grapObj.process_time = ((result[i].process_time)/24).toFixed(1);
						grapObj.d_process_time = (result[i].d_process_time)*24;
						grapObj.item_type_code = $("#item_type_code").val();
						grapArr[Number(month) - 1] = grapObj;
						
						console.log("--------------------------------------------------")
						console.log("grapObj.prod_fail_menge" + result[i].month + "월");
						console.log("월별목표:::"+result[i].goal)
						console.log("grapObj.prod_fail_menge" + result[i].prod_fail_menge);
						console.log("grapObj.prod_menge" + result[i].prod_menge);
						console.log("--------------------------------------------------")
						
						if(Number(goal) < Number(result[i].goal)) {

							goal = Number(result[i].goal);
							
						}
				
						if(Number(goal) < Number(grapObj.process_time)) {

							goal = Number(grapObj.process_time);
							
						}
						
						
					}
					
					console.log('MAX : ' + goal);
					
					
					setTimeout(function () {
						console.log('result');
						console.table(result); 
						
						chartData = grapArr;
						
						chartLength = chartData.length;
						
						console.log(chartLength);
						
						makeLayout();
						fnLoadChart();
						
				
					}, 500);
				} else {
					console.log('check');
					var b = [];
					document.getElementById("chart1").setData(b);
					makeLayout();
					fnLoadChart();
					rMateChartH5.call("chart1", "hasNoData", true);					
					
				}
				
			},complete: function () {
				
				
			}
		});
	
// 		hidePreloader();
		//checkData(chartData); // 데이터가 존재하는지 판별한다.
	}
	
	function gridData (seriesId, displayText, index, data, values) {
		console.log("gridData()");
		
		var valMonth = values[0];
			
		//var month = valMonth.substr(0, month.length -1);
		
		var month = valMonth.replace('월',"");
		
		console.log("month?" + month);
		
		loadList_lt(month);
		loadList_rt(month);  
		hMonthChange(month);
	}
	
	function hMonthChange(month){
		$("#idxMonth").text(month + "월별 상세");
	}
	
	
	function loadList_lt(month) {
		console.log("loadList_lt()");
		
		var year = $("#date").val();
		var item_code = $("#item_code").val(); 
		var item_nm = $("#item_nm").val(); 
		var item_type_code = $("#item_type_code").val();
		
		var page_url = "/frontend/repair/selectProduct2";
		
		var postData = "year=" + encodeURIComponent(year)
			 + "&month=" + encodeURIComponent(month)
			 
			 +"&item_type_code=" + encodeURIComponent(item_type_code) 
			 + "&item_code=" + encodeURIComponent(item_code)
			 + "&item_nm=" + encodeURIComponent(item_nm);
		
		
		w2ui['grid_list_lt'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					console.table(data);
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						
						row.prod_menge = Number(row.prod_fail_menge);
						row.prod_fail_menge = Number(row.prod_menge);
						row.process_time = Number(row.process_time);
						row.d_process_time = Number(row.d_process_time);
					});
					w2ui['grid_list_lt'].records = rowArr;
				} else {
					w2ui.grid_list_lt.clear();
				}
				w2ui['grid_list_lt'].refresh();
				w2ui['grid_list_lt'].unlock();
			},complete: function () {}
		});
		
	}
	
	function loadList_rt(month) {
		console.log("loadList_rt()");
		var year = $("#date").val();
		var item_code = $("#item_code").val(); 
		var item_nm = $("#item_nm").val(); 
		var item_type_code = $("#item_type_code").val();
		
		var page_url = "/frontend/repair/selectProduct3";
		
		var postData = "year=" + encodeURIComponent(year)
			 + "&item_code=" + encodeURIComponent(item_code)
			 +"&item_type_code=" + encodeURIComponent(item_type_code) 
			 + "&month=" + encodeURIComponent(month)
			 + "&item_nm=" + encodeURIComponent(item_nm);
		
		
		w2ui['grid_list_rt'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					console.table(data);
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						
						row.prod_menge = Number(row.prod_fail_menge);
						row.prod_fail_menge = Number(row.prod_menge);
						row.process_time = Number(row.process_time);
						row.d_process_time = Number(row.d_process_time);
					});
					w2ui['grid_list_rt'].records = rowArr;
				} else {
					w2ui.grid_list_rt.clear();
					
					
					
					
				}
				w2ui['grid_list_rt'].refresh();
				w2ui['grid_list_rt'].unlock();
			},complete: function () {}
		});
		
	}
	
	
	
	// hasNoData(false); 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면
		// false로 주어 차트 전체의 visible을 false로 설정합니다.
	// hasNoData(true); 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어
		// visible을 true로 설정합니다.
	//-------------------------------------------------------------------------------------------------------------------
	
	// 프리로더를 보이게 합니다.
	function showPreloader()
	{
	  document.getElementById("chart1").showAdditionalPreloader();
	}
	 
	// 프리로더를 제거합니다.
	function hidePreloader()
	{
	   document.getElementById("chart1").removeAdditionalPreloader();
	}
	// 차트 로딩
	
	
	function fnLoadChart() {
		rMateChartH5.create("chart1", "chartHolder", "", "100%", "100%");
		
		rMateChartH5.calls("chart1", {
			   "setLayout" : layoutStr,
			    "setData" : chartData
		});
	}
	
    function axisLabelFunc(id, value){
  		return value + " 개";
  	}
	   
    function axisLabelFunc2(id, value){
		return value + "시간";
	}
	   
	
	function makeLayout(){
		
		var year = $("#date").val();
		
		 layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+'<Options>'
					+'<Caption text="'+year+'년 생산 실적 그래프"/>'
						+'<SubCaption text="-----------------------------" textAlign="center" />'
						+'<Legend useVisibleCheck="true"/>'
						//+'<Legend defaultMouseOverAction="false" />'
						+'<CurrencyFormatter id="numFmt" currencySymbol="시간" alignSymbol="right"/>'
					+'</Options>'
					+'<Combination2DChart showDataTips="true" itemClickJsFunction="gridData" dataTipDisplayMode="axis" paddingTop="0">'
					//+'<Combination2DChart showDataTips="true" itemClickJsFunction="gridData" columnWidthRatio="0.4" selectionMode="single">'
						+'<horizontalAxis>'
							+'<CategoryAxis categoryField="month" />'
						+'</horizontalAxis>'
						+'<verticalAxis>'
							 +'<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0"/>'
						+'</verticalAxis>' 
	                    
						+'<series>'
						
						+'<Column2DSet type="clustered">'
                        +'<series>'
						
						+'<Column2DSeries labelPosition="outside" yField="prod_menge" displayName="실적수량">'
							 +'<fill>'
		                         +'<SolidColor color="#5ddc96"/>'
		                      +'</fill>'
							  +' <showDataEffect>'
							 	+' <SeriesInterpolate/>'
							  +' </showDataEffect>'
						    +' </Column2DSeries>'
						    
						 
						    
						    +'<Column2DSeries labelPosition="outside" yField="prod_fail_menge" displayName="불량수량" >'
							 +'<fill>'
		                         +'<SolidColor color="#ffbf12"/>'
		                      +'</fill>'
						 	  +' <showDataEffect>'
						 		+' <SeriesInterpolate/>'
					 		 +' </showDataEffect>'
				 		  +' </Column2DSeries>'
				 		  
				 		 +'</series>'
	                      +'</Column2DSet>'
	                      
	                       +'<Line2DSeries yField="goal" fill="#ffffff" radius="5" displayName="목표TAT" itemRenderer="CircleItemRenderer">'
		                    +'<lineStroke>'
		                        +'<Stroke color="#ffd736" weight="2"/>'
		                    +'</lineStroke>'
		                    
		                    +'<verticalAxis>'
	                         +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum=" '+goal+'"/>'
	                      +'</verticalAxis>' 
	                      
		                   +'<showDataEffect>'
		                       +'<SeriesInterpolate/>'
		                   +'</showDataEffect>'
		             	 +'</Line2DSeries>' 
		 				  
		 				 +'<Line2DSeries  yField="process_time"  radius="5"  displayName="환산TAT (시간)" itemRenderer="CircleItemRenderer">'
	                      +'<lineStroke>'
		                      +'<Stroke color="#a85ff3" weight="2"/>'
		                  +'</lineStroke>'
		                  
		                  +'<verticalAxis>'
	                         +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum=" '+goal+'"/>'
	                      +'</verticalAxis>' 
	                      
                         +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                    +'</Line2DSeries>'
                  
		 				  
		 				  
		 				+'</series>'
		 				
		 				+'<verticalAxisRenderers>'
		 				
// 		 				 +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="true">'
//                         /* vAxis1을 참조 */
//                               +'<axisStroke>'
//                                  +'<Stroke color="#5ddc96" weight="3" caps="none"/>'
//                              +'</axisStroke>'
//                         +'</Axis2DRenderer>'
                        
//                        +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="true">'
//                        /* vAxis2를 참조 */
//                              +'<axisStroke>'
//                                 +'<Stroke color="#a85ff3" weight="3" caps="none"/>'
//                             +'</axisStroke>'
//                        +'</Axis2DRenderer>'
                       
//                        +'<Axis2DRenderer axis="{vAxis3}" placement="right" showLine="true">'
//                        /* vAxis2를 참조 */
//                              +'<axisStroke>'
//                                 +'<Stroke color="#ffd736" weight="3" caps="none"/>'
//                             +'</axisStroke>'
//                        +'</Axis2DRenderer>'
                        
                       +'</verticalAxisRenderers>'
		 				
 				 + '</Combination2DChart>'
					+'</rMateChart>';

		 
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
		
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
//		    .append('<option value="All">-----</option>')
	    .val();
	}
	
	//엑셀 다운로드
	function excelFileDownload()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list_lt'].columns;
		var gridData = w2ui['grid_list_lt'].records;

		var nm = $("#idxMonth").html()+"내역";

		var fileName = nm + '.xlsx';
		var sheetTitle = '월별상세내역';
		var sheetName = '월별상세내역';
		
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

	function excelFileDownload2()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list_rt'].columns;
		var gridData = w2ui['grid_list_rt'].records;

		var fileName = '일자별상세내역.xlsx';
		var sheetTitle = '일자별상세내역';
		var sheetName = '일자별상세내역';
		
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