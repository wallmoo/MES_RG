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
		<jsp:param name="selected_menu_cd" value="1087" />
	</jsp:include>

<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>	

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
       	아이템별 공정현황
        <small>생산관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 생산관리</a></li><li class="active">아이템별 공정현황</li>
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
							<button type="button" id="btn_search_csr" onclick="fnLoadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
									<div class="form-group">
									<label>일자</label>
										<div class="input-group">
											<input type="text" 
												class="form-control pull-right input-sm" style="" id="item_fair_date" placeholder="yyyymmdd~yyyymmdd">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>
									</div>
								</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>P/N</label>
									 <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									 <label>품명</label>
									 <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm"/>
								</div>
							</div>
							
						</div>
						
						<div class="row" style="margin-bottom: 10px">
							<div class="col-md-12 text-center">
								<div id="chartHolder" style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 300px; "></div>
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
	 	before_loadList();

	 	init_grid_list();
	 	
		makeLayout();
		fnLoadChart(new Array());
		
	 	//loadList_graph();
	})

	
// 	 $("#item_nm").change(_.debounce(function(event) {
			
// 			var item_nm = $("#item_nm").val();
// 			$(this).val(function(index, value) {
				
// 				getItemInfo('nm',value);
// 				return value;
// 			});
			
// 		},400));
// 	$("#item_code").change(
			
// 			_.debounce(function(event) 
// 			{
		
// 				var item_code = $("#item_code").val();
// 				$(this).val(function(index, value) {
// 					console.log('item_code key_up : '+ value);
					
// 					getItemInfo('cd',value);
// 					return value;
// 				});
		
// 	},400));
	
	function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		var minDate = getFormatDate(new Date());
		
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
		
		$('#item_fair_date').daterangepicker({
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
		   //startDate: moment(minDate),
           endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(7, 'days')
		});
	}
	
	function init_grid_list(){
		 console.log('init_grid_list()');
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
				{ field:'routing_code', caption:'라우팅코드', size:'5%', style:'text-align:center',sortable :true}, 
				{ field:'gb', caption:'라우팅명', size:'10%', style:'text-align:center',sortable :true
					,render : function (record, index, col_index){
						var val = this.getCellValue(index, col_index);
						
						var gb = w2ui.grid_list.records[index].gb; 
						
						if(gb == "WAITING"){
							val =  '<div style="background-color:#ffd368;">'+ val  +'</div>';
						}
						
						return val;
					}
				}, 
				{ field:'item_code', caption:'P/N', size:'25%', style:'text-align:center',sortable :true}, 
				{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center',sortable :true}, 
				{ field:'work_time', caption:'작업시간', size:'10%', style:'text-align:center',sortable :true}, 
				{ field:'unwork_time', caption:'비가동시간', size:'10%', style:'text-align:center' ,sortable :true},
				{ field:'all_time', caption:'총작업시간', size:'10%', style:'text-align:center' , hidden : true }
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
	
	
	var startValue_combo = "";

	comboValue_nm1 = new Array;
	comboValue_nm2 = new Array;

	 
	
	
	
	
	
	var grapArr = new Array();
	function loadList_graph() {
		console.log("loadList_graph()");
		
		chartData = new Array();
		grapArr = new Array();
		
		var work_end_time = $("#item_fair_date").val();
		work_end_time = work_end_time.replace(/-/gi, "");
		
		var item_code = $("#item_code").val();
		var item_nm = $("#item_nm").val();
		
		var postData = "work_end_time=" + encodeURIComponent(work_end_time)
					+"&item_nm=" + encodeURIComponent(item_nm)
					+"&item_code=" + encodeURIComponent(item_code);
		
		var page_url = "/frontend/consumable/selectItemFair_graph";
	
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
	
					for(var i = 0; i< result.length; i++)
					{
						var grapObj = new Object();
						grapObj.gb = result[i].gb;
						grapObj.unwork_time = result[i].unwork_time;
						grapObj.work_time = result[i].work_time;
						grapObj.waiting_time = result[i].waiting_time;
						grapArr.push(grapObj);
						
						/* if(result[i].gb == 'WAITING'){
							grapObj.gb =  '대기';
							grapObj.unwork_time = 0;
							grapObj.work_time = 0;
							grapObj.waiting_time = work_time;
							grapArr.push(grapObj);
						}else
						{
							grapObj.gb =  result[i].gb;
							grapObj.unwork_time = unwork_time;
							grapObj.work_time = work_time;
							grapObj.waiting_time = 0;
							grapArr.push(grapObj);
						} */
					}
					
					setTimeout(function () {
					
					
				
						chartData = grapArr;
		
						chartLength = chartData.length;
						
						console.log(chartLength);
						
						makeLayout();
						fnLoadChart(chartData);
						
				
					}, 500);
				} else {
					console.log('check');
					var b = [];
					//document.getElementById("chart1").setData(b);
					makeLayout();
					fnLoadChart(new Array());
					rMateChartH5.call("chart1", "hasNoData", true);					
				}
				
			},complete: function () {
				
			}
		});
	
// 		hidePreloader();
		//checkData(chartData); // 데이터가 존재하는지 판별한다.
	}
	
	function loadList() {
		console.log("loadList()");
		
		var work_end_time = $("#item_fair_date").val();
		work_end_time = work_end_time.replace(/-/gi, "");
		
		var item_code = $("#item_code").val();
		var item_nm = $("#item_nm").val();
		
		var page_url = "/frontend/consumable/selectItemFair";

		
		var postData = "work_end_time=" + encodeURIComponent(work_end_time)
					+"&item_nm=" + encodeURIComponent(item_nm)
					+"&item_code=" + encodeURIComponent(item_code);
		

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
						
						
					});
					
					gridDataArr = rowArr;

					w2ui['grid_list'].records = rowArr;
					
				
				}
				else
				{
					w2ui['grid_list'].clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
				
			},complete: function () {
				
			}
			
		});
	}

	
	// 클릭한 아이템 정보 보기
	function gridData (seriesId, displayText, index, data, values) {
		console.log("gridData()");
	
	}
	
	function hMonthChange(month){
		
	}
	
	
	
	// hasNoData(false); 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면
		// false로 주어 차트 전체의 visible을 false로 설정합니다.
	// hasNoData(true); 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어
		// visible을 true로 설정합니다.
	/* function checkData(data){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		if(data.length <= 0)
			document.getElementById("chart1").hasNoData(true);
		
	} */
	// PROPERTIES +
	// 이벤트
	
	
	
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
	
	
	function fnLoadChart(chartData) {
		rMateChartH5.create("chart1", "chartHolder", "", "100%", "100%");
		rMateChartH5.calls("chart1", {
			   "setLayout" : layoutStr,
			    "setData" : chartData
		});
	}
	
	function makeLayout(){
		
		 layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+'<Options>'
					+'<Caption text="아이템별 공정현황 그래프"/>'
						+'<SubCaption text="-----------------------------" textAlign="center" />'
						+'<Legend defaultMouseOverAction="false" />'
					+'</Options>'
					+'<Column3DChart showDataTips="true" itemClickJsFunction="gridData" columnWidthRatio="1" selectionMode="single">'
						+'<horizontalAxis>'
							+'<CategoryAxis categoryField="gb" />'
						+'</horizontalAxis>'
						+'<verticalAxis>'
							/* +'<LinearAxis />'
						+'</verticalAxis>' */
						
						 /* BrokenAxis를 설정 하시려면 해당 축이 설정될 곳에 BrokenAxis를 설정하십시오. */
	                      +'<BrokenAxis id="vAxis" brokenMinimum="1"  brokenMaximum="10" maximum="30" brokenRatio="0.6"  />' // maximum="100000" minimum= "' + 0 + '"
	                      //+'<BrokenAxis id="vAxis" formatter="{numfmt}" />'
	                       /* brokenMinimum - Broken축이 시작될 값 입니다. */
	                       /* brokenMaximum - Broken축이 끝날 값 입니다. */
	                        /* brokenRatio - Broken축이 그려질 위치 값입니다. 0 ~ 1이 유효값이며 0에 가까울수록 축의 최소값에 가까워지며 */
	                       /* 1에 가까워질수록 축의 최대값에 가까워집니다. */
	                 +'</verticalAxis>'
	                    +'<verticalAxisRenderers>'
	                        +'<BrokenAxis2DRenderer axis="{vAxis}"/>'
	                     /* BrokenAxis를 사용할 경우에는 BrokenAxis2DRenderer를 설정해야 합니다. */
	                      /* 이 외의 렌더러를 설정할 경우 올바르게 표현이 되지 않습니다. */
	                    +'</verticalAxisRenderers>'
	                    
						+'<series>'
						
						+'<Column3DSeries  yField="work_time" displayName="작업시간" >'
							  +' <showDataEffect>'
							 	+' <SeriesInterpolate/>'
							  +' </showDataEffect>'
						    +' </Column3DSeries>'
						    
						    +'<Column3DSeries  yField="unwork_time" displayName="비가동시간" >'
						 	  +' <showDataEffect>'
						 		+' <SeriesInterpolate/>'
					 		 +' </showDataEffect>'
				 		  +' </Column3DSeries>'
				 		    +'<Column3DSeries  yField="waiting_time" displayName="대기시간" >'
						 	  +' <showDataEffect>'
						 		+' <SeriesInterpolate/>'
					 		 +' </showDataEffect>'
				 		  +' </Column3DSeries>'
		 				  
		 				+'</series>'
 				 + '</Column3DChart>'
					+'</rMateChart>';

		 
	}
	function getFormatDate(d) {
		var month = d.getMonth() + 1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		return d.getFullYear() + '-' + month + '-' + date;
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
	
	
var rowArr2 = new Array();	
var materialArr = new Array;	
function before_loadList()
{
	console.log("before_loadList()");	  
	var order_day = $("#item_fair_date").val();
	order_day = order_day.replace(/-/gi, ""); 
	var product_status = 'y';
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	
	var page_url = "/frontend/consumable/selectProduct";
	
	var postData = "order_day=" + encodeURIComponent(order_day)
		+"&item_nm=" + encodeURIComponent(item_nm)
		+ "&item_code=" + encodeURIComponent(item_code)
		+ "&product_status=" + encodeURIComponent(product_status);
	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',			
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr2 = data.rows;
				materialArr = rowArr2;
				$.each(rowArr2, function(idx, row){
					row.recid = idx+1;
					if (startValue_combo == "") {
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
					}
					
				});

				
				$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
				$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			
			}
			else
			{
		
			}
	
		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
		
		}
	});
		
}
	
	
function getItemInfo(type, value)
{
	
	console.log('getItemInfo() : ' + value);
	var result = "";
	if(type == 'cd')
	{
		$.each(rowArr2, function(idx, row){
			
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
		
		$.each(rowArr2, function(idx, row){
			
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
	loadList();
	loadList_graph();
}

function fnLoadList(){
	var item_code = $("#item_code").val();
	var item_nm = $("#item_nm").val();
	var work_end_time = $("#item_fair_date").val();
	
	if(item_code == '' &&  item_nm == ''){
		fnMessageModalAlert('알림', '검색조건을 입력해주세요.');	
	}else{
		loadList();
		loadList_graph();
	}
}		
	
	
	
	
	
</script>

</body>
</html>