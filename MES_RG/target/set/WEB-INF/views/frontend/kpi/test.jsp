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
    		
		.q-w2ui-list
		{
			height: 30px;
			line-height: 30px;
			padding: 5px 10px;
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
									 <select id="m_year" name="m_year" class="form-control" style="height: 30px;" >
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>ioList</label>
									 <select id="ioList" name="ioList" class="form-control" style="height: 30px;" >
									 </select>
								</div>
							</div>
							
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> 
									<div>
										<input type="text" id="p_item_code" name="p_item_code" class="w2ui-field q-w2ui-list" style="width: 100%;"/>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> 
									<div>
										<input type="text" id="p_item_nm" name="p_item_nm" class="w2ui-field q-w2ui-list" style="width: 100%;"/>
									</div>
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
									<h3 class="" style="margin: 0; margin-left: 15px;">월별상세</h3>
								</div>
						
								<div class="col-md-3 text-right" >
									<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload('grid_list_lt');">액셀다운로드</button>
								</div>
							
								<div class="col-md-3 text-left" >
									<h3 class="" style="margin: 0; margin-left: 15px;">일자별상세</h3>
								</div>
							
								<div class="col-md-3 text-right">
									<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload('grid_list_rt');">액셀다운로드</button>
								</div>
						</div>
						
						<div class="row">
							
							<div class="col-md-6">
								<div id="grid_list_lt" style="width: 100%; height: 220px; "></div>
							</div>
							
							<div class="col-md-6">
								<div id="grid_list_rt" style="width: 100%; height: 220px; "></div>
							</div>
						</div>
						<!-- chart grid -->
					</div>
				</div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
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
	
	var comboValue = new Array;
	var matnrRowArr = new Array;
	
	$(function($) {
		loadMatInfo();
	 	fnLoadCommonOption(); 	 
	 	 	
	 	
	 	makeLayout(10);
	 	
	 	var date = new Date();
		var currYear = date.getFullYear();

		var y_idx = 2020;
		while(true)
		{
			$("#m_year").append("<option value='" + y_idx +"'>" + y_idx + "년</option>");
			
			if(y_idx == currYear)
			{
				break;
			}
			y_idx++;
		}
		
		$("#m_year").val(currYear).prop("selected", true);
	 	
	 	fnLoadLeftGrid();
	 	fnLoadRightGrid();
	 	loadList();
	})
	
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
				{ field:'m_month', caption:'월', size:'10%', style:'text-align:center', sortable: true},
				{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'prod_menge', caption:'계획 수량', size:'10%', style:'text-align:center', sortable: true },
				{ field:'prfr_menge', caption:'실적 수량', size:'10%', style:'text-align:center', sortable: true },
				{ field:'c_dfct_cnt', caption:'불량 수량', size:'10%', style:'text-align:center', sortable: true },
				{ field:'dfct_rate', caption:'불량율', size:'10%', style:'text-align:center', sortable: true },
				], 
			sortData: [{field: 'pn', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
			},
			onClick: function (event) {}
		});
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
				{ field:'p_mm', caption:'일자', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'prod_menge', caption:'계획 수량', size:'10%', style:'text-align:center', sortable: true },
				{ field:'prfr_menge', caption:'실적 수량', size:'10%', style:'text-align:center', sortable: true },
				{ field:'c_dfct_cnt', caption:'불량 수량', size:'10%', style:'text-align:center', sortable: true },
				{ field:'dfct_rate', caption:'불량율', size:'10%', style:'text-align:center', sortable: true }
				], 
			records: [],	
			onReload: function(event) {
			},
			onClick: function (event) {}
		});
	}
	
	$("#date").change(function(){
		loadList();
	});
	
	$("#p_item_code").change(function(){
		loadList();
		
		if($("#p_item_code").val().length == 0)
		{
			$("#p_item_nm").val('');
		}
		
	});
	
	$("#p_item_nm").change(function(){
		loadList();
		
		if($("#p_item_nm").val().length == 0)
		{
			$("#p_item_code").val('');
		}
	});
	
	
	function loadList() {		
		var page_url = "/insp/dfctKpiGraph";
		var postData = "m_year=" + encodeURIComponent($("#m_year").val())
			 + "&item_code=" + encodeURIComponent($("#p_item_code").val());
		
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				console.log(data);
				chartData = [];
				
				var max = 0;
				
				if(data.status == 200 && (data.rows).length>0 ) {
					$.each(data.rows, function(idx, row){
						if(idx == 0)
						{
							max = row.c_dfct_cnt;
						}
						
						if(max < row.c_dfct_cnt){
							max = row.c_dfct_cnt;
						}
					});
					
					if(max == 0)
					{
						max = 10;
					}
					
					
					chartData = data.rows;
					
					chartLength = chartData.length;
					
					makeLayout(max);
					fnLoadChart();

					checkData(chartData); // 데이터가 존재하는지 판별한다.
					
					//왼쪽 그리드 조회
					if(data.status == 200 && (data.rows_lt).length>0 ) {
						$.each(data.rows_lt, function(idx, row){
							row.recid = idx+1;
						});
						w2ui['grid_list_lt'].records = data.rows_lt;
					} else {
						w2ui.grid_list_lt.clear();
					}
					w2ui['grid_list_lt'].refresh();
					w2ui['grid_list_lt'].unlock();
					
					//오른쪽 그리드 조회
					if(data.status == 200 && (data.rows_rt).length>0 ) {
						$.each(data.rows_rt, function(idx, row){
							row.recid = idx+1;
						});
						w2ui['grid_list_rt'].records = data.rows_rt;
					} else {
						w2ui.grid_list_rt.clear();
					}
					w2ui['grid_list_rt'].refresh();
					w2ui['grid_list_rt'].unlock();
					
					
				} else {
					checkData(chartData);
				}
			},complete: function () {
				
			}
		});
	}
	
	// hasNoData(false); 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면
		// false로 주어 차트 전체의 visible을 false로 설정합니다.
	// hasNoData(true); 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어
		// visible을 true로 설정합니다.
	function checkData(data){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		if(data.length <= 0)
			document.getElementById("chart1").hasNoData(true);
		
	}
	// PROPERTIES +
	// 이벤트
	// 클릭한 아이템 정보 보기
	function gridData (seriesId, displayText, index, data, values) {
		console.log("gridData()");
		
		/* var machine_name = values[0];
		machine_name = machine_name.substr(0, 1);
					
		loadList2(machine_name); */
	}
	
	
	//-------------------------------------------------------------------------------------------------------------------
	// 촤트
	
	// 차트 로딩 
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
	
	function makeLayout(max){
		
		var date = $("#m_year option:selected").val();
		
		 layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+'<Options>'
					+'<Caption text="'+date+'년 불량 누적 그래프"/>'
						+'<SubCaption text="-----------------------------" textAlign="center" />'
						+'<Legend defaultMouseOverAction="false" />'
					+'</Options>'
					+'<Column3DChart showDataTips="true" itemClickJsFunction="gridData" columnWidthRatio="0.4" selectionMode="single">'
						+'<horizontalAxis>'
							+'<CategoryAxis categoryField="p_mm" />'
						+'</horizontalAxis>'
						//+'<verticalAxis>'
							/* +'<LinearAxis />'
						+'</verticalAxis>' */
						
						 /* BrokenAxis를 설정 하시려면 해당 축이 설정될 곳에 BrokenAxis를 설정하십시오. */
	                      //+'<BrokenAxis id="vAxis" brokenMinimum="3000" brokenMaximum="100000" maximum="120000" brokenRatio="0.8"  />' // maximum="100000" minimum= "' + 0 + '"
	                      //+'<BrokenAxis id="vAxis" formatter="{numfmt}" />'
	                       /* brokenMinimum - Broken축이 시작될 값 입니다. */
	                       /* brokenMaximum - Broken축이 끝날 값 입니다. */
	                        /* brokenRatio - Broken축이 그려질 위치 값입니다. 0 ~ 1이 유효값이며 0에 가까울수록 축의 최소값에 가까워지며 */
	                       /* 1에 가까워질수록 축의 최대값에 가까워집니다. */
	                // +'</verticalAxis>'
	                    //+'<verticalAxisRenderers>'
	                     //   +'<BrokenAxis2DRenderer axis="{vAxis}"/>'
	                     /* BrokenAxis를 사용할 경우에는 BrokenAxis2DRenderer를 설정해야 합니다. */
	                      /* 이 외의 렌더러를 설정할 경우 올바르게 표현이 되지 않습니다. */
	                   // +'</verticalAxisRenderers>'
	                    
						+'<series>'
						
						+'<Column3DSeries labelPosition="outside" yField="c_dfct_cnt" displayName="누적불량수" >'
							  +' <showDataEffect>'
							 	+' <SeriesInterpolate/>'
							  +' </showDataEffect>'
						    +' </Column3DSeries>'
						    
// 						    +'<Column3DSeries labelPosition="outside" yField="ersu" displayName="불량수량" >'
// 						 	  +' <showDataEffect>'
// 						 		+' <SeriesInterpolate/>'
// 					 		 +' </showDataEffect>'
// 				 		  +' </Column3DSeries>'
				 		 
// 				 		  +'<Column3DSeries labelPosition="outside" yField="tat" displayName="TAT(평균)" >'
// 				 			 +' <showDataEffect>'
// 				 				+' <SeriesInterpolate/>'
// 			 				+' </showDataEffect>'
// 		 				  +' </Column3DSeries>'
		 				  
		 				  
		 				+'</series>'
 				 + '</Column3DChart>'
					+'</rMateChart>';

		 
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
		
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
	    .val();
	}
	
	function loadMatInfo() {
		var page_url = "/info/material/selectMaterial";
		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					comboValue = new Array;
					
					var comboValue_cd = new Array;
					var comboValue_nm = new Array;
					
					matnrRowArr = data.rows;
					$.each(matnrRowArr, function(idx, row){
						
						var obj = new Object();
						obj.id = row.item_code;
						obj.text = row.item_nm;

						comboValue.push(obj);
						comboValue_cd.push(row.item_code);
						comboValue_nm.push(row.item_nm);
					});
					
					
					
					
					
					for(var i=0;i<comboValue_cd.length;i++)
					{
						$("#ioList").append("<option value='" + comboValue_cd[i] +"'>" + comboValue_cd[i] + "</option>");
					}
					
					
					
					
					
					
					$('#p_item_code').w2field('combo', {items: comboValue_cd, match : 'contains' })
					 .on('change', function () {
						 
			            $.each(comboValue, function(idx, row){
							var p_id = row.id;
							var p_text = row.text;
							
							if(p_id == $('#p_item_code').val())
							{
								$('#p_item_nm').w2field().set(p_text);
							}
						});
					 });
					
					
					$('#p_item_nm').w2field('combo', {items: comboValue_nm, match : 'contains' }).on('change', function () {
						 
			            $.each(comboValue, function(idx, row){
							var p_id = row.id;
							var p_text = row.text;
							
							if(p_text == $('#p_item_nm').val())
							{
								$('#p_item_code').w2field().set(p_id);	
							}
						});
					});
				}
			},complete: function () {
			}
		});
	}
	

	
	
	$.fn.select2.amd.require(
			['select2/data/array', 'select2/utils'],
			function (ArrayData, Utils) {
				function CustomData($element, options) {
					CustomData.__super__.constructor.call(this, $element, options);
				}
				
				function contains(str1, str2) {
					return new RegExp(str2, "i").test(str1);
				}

				Utils.Extend(CustomData, ArrayData);
				
				CustomData.prototype.query = function (params, callback) {
					if (!("page" in params)) {
						params.page = 1;
					}
					var pageSize = 50;
					var results = this.$element.children().map(function(i, elem) {
						if (contains(elem.innerText, params.term)) {
							return {			
								id:[elem.innerText, i].join(""),
								text:elem.innerText
							};
						}
					});
					callback({
						results:results.slice((params.page - 1) * pageSize, params.page * pageSize),
						pagination:{
							more:results.length >= params.page * pageSize
						}
					});
				};

				
				initOptions("#ioList");				
				
				$("#ioList").select2({
					ajax:{},
					allowClear:true,
					width:"element",
					dataAdapter:CustomData
				});
			});
			
			
			
			
	function excelFileDownload(grid_nm)
	{
		
		
		var gridCols = w2ui[grid_nm].columns;
		var gridData = w2ui[grid_nm].records;

		if(grid_nm == 'grid_list_rt')
		{
			var fileName = '일자별상세.xlsx';
			var sheetTitle = '일자별상세';
			var sheetName = '일자별상세';	
		} else {
			var fileName = '월별상세.xlsx';
			var sheetTitle = '월별상세';
			var sheetName = '월별상세';
		}
		
		
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