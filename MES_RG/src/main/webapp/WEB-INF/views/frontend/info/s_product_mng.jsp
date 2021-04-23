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
		<jsp:param name="selected_menu_cd" value="1060" />
	</jsp:include>

<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>	

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      설비 생산분석
        <small>생산관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 설비 생산분석</a></li><li class="active">생산관리</li>
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
						<h3 class="box-title">설비 생산성 분석</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
								<label>조회기간</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="order_day" placeholder="yyyymmdd~yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-sm-2" style="margin-top:25px;">
								<div class="form-group">
								 <label>
					               <input type="radio" id="rdo_status_type" name="rdo_status_type" class="flat-red form-control" value="i" checked> 주간 
					             </label>
					             <label>
					               <input type="radio" id="rdo_status_type" name="rdo_status_type" class="flat-red form-control" value="u" > 월간
					             </label>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>설비분류</label>
									 <select id="pn" name="pn" class="form-control" style="height: 30px;" >
										
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>설비명</label>
									 <select id="maktx" name="maktx" class="form-control" style="height: 30px;" >
										<option value="ALL" selected="selected">전체</option>
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>품명</label>
									 <input type="text" id="customer_nm" name="customer_nm" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="10" />
								</div>
							</div>
							
						</div>
						
						<div class="row" style="margin-bottom: 10px; margin-top:20px;">
							<div class="col-md-6 text-center">
								<div id="chartHolder" style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
							</div>
							<div class="col-md-6 text-center">
								<div id="chartHolder2" style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6" style="margin-bottom:15px;">
								<span>설비별 생산량 상세 요약</span>
							</div>
							<div class="col-sm-6" style="margin-bottom:15px;">
								<span>설비별 생산량 상세 요약</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div id="grid_list" style="width: 100%; height: 235px; "></div>
							</div>
							<div class="col-md-6">
								<div id="grid_list2" style="width: 100%; height: 235px; "></div>
							</div>
						</div>
					</div>
				</div>
				
			<!-- <div class="row" style="margin-bottom: 10px">
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
	
	var layoutStr2 = "";
	var chartLength2 = "";
	var chartData2 = new Array();
	
	
	$(function($) {
	 	fnLoadCommonOption(); 	 
	 	
	 	fnCdD('pn', 'MC1021');
	 	
	 	
	 	initGridList();
	 	initGridList2();
	 	loadList();
	})
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
		
		 $('#order_day, #c_prod_day').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
		 	     endDate: '2020-08-31' 
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
 
	
	function initGridList(){
		 console.log('initGridList()');
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
				{ field:'c1', caption:'일자', size:'10%', style:'text-align:center'}, 
				{ field:'c2', caption:'품명', size:'10%', style:'text-align:center'}, 
				{ field:'c3', caption:'수량', size:'10%', style:'text-align:center'}, 
				{ field:'c4', caption:'비율', size:'10%', style:'text-align:center' },
				{ field:'c5', caption:'발주 수량', size:'10%', style:'text-align:center' }
				], 
			sortData: [{field: 'pn', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	function initGridList2(){
		 console.log('initGridList2()');
		var rowArr = [];
		
		$('#grid_list2').w2grid({ 
	        name: 'grid_list2',
	        show: {
	        	selectColumn: false,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [           
				{ field:'c1', caption:'설비명', size:'10%', style:'text-align:center'}, 
				{ field:'c2', caption:'품명', size:'10%', style:'text-align:center'}, 
				{ field:'c3', caption:'수량', size:'10%', style:'text-align:center'}, 
				{ field:'c4', caption:'비율', size:'10%', style:'text-align:center' }
				], 
			sortData: [{field: 'pn', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}

	
	$("#date").change(function(){
		loadList();
		loadList_lt();
		loadList_rt();
	});
	
	$("#pn").change(function(){
		loadList();
		loadList_lt();
		loadList_rt();
	});
	
	$("#maktx").change(function(){
		loadList();
		loadList_lt();
		loadList_rt();
	});
	
	
	function loadList() {
		console.log("loadList()");
		
		chartData = new Array();
		
		chartData = [
		             {recid:1, c1:"2020-06-11", c2:"Plate#1", c3:"40", c4:"30%"},
		             {recid:2, c1:"2020-06-12", c2:"Plate#2", c3:"80", c4:"10%"}
		             ];
		
		
		w2ui['grid_list'].records = chartData;

		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
		
		// 레코드에 불러와서 하는거 ★★
// 		chartData = new Array();
			
		/* for(var i = 1; i <=12; i ++)
		{
			var vals = new Object();
			vals.mg = "";
			
			vals.val = w2ui.grid_list.get(1)['c'+i];
			vals.goal = w2ui.grid_list.get(2)['c'+i];
	
			chartData.push(vals);
		} */
			
		chartData = [
		             { Month:"2020-06-11", su:"700"} ,
		             { Month:"2020-06-12", su:"800"} ,
		             { Month:"2020-06-13", su:"700"} ,
		             { Month:"2020-06-14", su:"750"} ,
		             { Month:"2020-06-15", su:"720"} 
		            	 ];	
			
		chartData2 = [
		             {recid: 1, gb:"1호기", c1:"AA-1234", c2:"CCC", c3:"25", c4:"30" },
		              {recid: 2, gb:"2호기", c1:"E17908877", c2:"CCC", c3:"26", c4:"40" },
		              {recid: 3, gb:"3호기", c1:"E17908866", c2:"CCC", c3:"24", c4:"60" },
		              {recid: 4, gb:"4호기", c1:"E17908866", c2:"CCC", c3:"24", c4:"60" },
		              {recid: 5, gb:"5호기", c1:"E17908866", c2:"CCC", c3:"1", c4:"60" }   
		];
		
		chartLength = chartData.length;
		/* console.log("chartLength = " + chartLength);
		console.log("chartData");
		console.log( chartData ); */
		
		makeLayout();
		fnLoadChart();
		
		makeLayout2();
		fnLoadChart2();
	
// 		hidePreloader();
		checkData(chartData); // 데이터가 존재하는지 판별한다.
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
	
	function getFormatDate(d) {
		var month = d.getMonth() + 1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		return d.getFullYear() + '-' + month + '-' + date;
	}
	
	function fnCdD(val, val2){
		console.log("fnCdD("+val+")");
		
		//initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/codeDetail/selectCdD";
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
		    		
	    			$("#"+val ).append("<option value="+''+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						if( val == "pn") {
							$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						} 
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		 			
		 			
		    	} 
		    	
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    }
		});
		
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
	
	function fnLoadChart2() {
		rMateChartH5.create("chart2", "chartHolder2", "", "100%", "100%");
		
		rMateChartH5.calls("chart2", {
			   "setLayout" : layoutStr2,
			    "setData" : chartData2
		});
	}
	
	function makeLayout(){
		var date = $("#date option:selected").val();
		
		date = "2020";
		 layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+'<Options>'
					+'<Caption text="'+date+'년 일자별 생산량"/>'
						+'<SubCaption text="-----------------------------" textAlign="center" />'
						+'<Legend defaultMouseOverAction="false" />'
					+'</Options>'
					+'<Column3DChart showDataTips="true" itemClickJsFunction="gridData" columnWidthRatio="0.55" selectionMode="single">'
						+'<horizontalAxis>'
							+'<CategoryAxis categoryField="Month" />'
						+'</horizontalAxis>'
						+'<verticalAxis>'
							+'<LinearAxis />'
						+'</verticalAxis>'
						+'<series>'
						
						+'<Column3DSeries labelPosition="outside" yField="su" displayName="발주금액" >'
							  +' <showDataEffect>'
							 	+' <SeriesInterpolate/>'
							  +' </showDataEffect>'
						    +' </Column3DSeries>'
						   
				 		 /*  +'<Column3DSeries labelPosition="outside" yField="tat" displayName="입고금액" >'
				 			 +' <showDataEffect>'
				 				+' <SeriesInterpolate/>'
			 				+' </showDataEffect>'
		 				  +' </Column3DSeries>'
		 				  
		 				 +'<Column3DSeries labelPosition="outside" yField="ip" displayName="미입고 금액" >'
				 			 +' <showDataEffect>'
				 				+' <SeriesInterpolate/>'
			 				+' </showDataEffect>'
		 				  +' </Column3DSeries>' */
		 				  
		 				  
		 				+'</series>'
 				 + '</Column3DChart>'
					+'</rMateChart>';

		 
	}
	
	function makeLayout2() {
		var date = $("#date option:selected").val();
		date = "2020";
		layoutStr2 =
			'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Caption text="'+date+'년 설비별 생산량"/>'
              +'<SubCaption text="--"/>'
                +'<Legend useVisibleCheck="true"/>'
            +'</Options>'
          +'<CurrencyFormatter id="numFmt" currencySymbol="%" alignSymbol="right"/>'
             /*
           Pie3D 차트 생성시에 필요한 Pie3DChart 정의합니다
           showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.
             */
           +'<Pie3DChart showDataTips="true"  depth="50" paddingLeft="100" paddingTop="50" paddingRight="100" paddingBottom="50">'
                +'<series>'
                    +'<Pie3DSeries nameField="gb" field="c3" labelPosition="inside" color="#ffffff" startAngle="240">'
                     /* Pie3DChart 정의 후 Pie3DSeries labelPosition="inside"정의합니다 */
                        +'<showDataEffect>'
                            /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
                             +'<SeriesInterpolate duration="1000"/>'
                            /*
                           SeriesInterpolate 효과는 시리즈 데이터가 데이터로 표시될 때 데이터의 변화된 내용을 가지고 효과를 적용합니다
                             - 공통 -
                           elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
                           minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
                                        이 값보다 짧은 시간에 effect가 실행되지 않습니다
                          offset : effect개시의 지연시간을 설정합니다 default:0
                             perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
                            */
                       +'</showDataEffect>'
                   +'</Pie3DSeries>'
              +'</series>'
           +'</Pie3DChart>'
       +'</rMateChart>';
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
	
</script>

</body>
</html>