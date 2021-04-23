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
		<jsp:param name="selected_menu_cd" value="1028" />
	</jsp:include>

<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>	

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        설비 가동 정보
        <small>KPI Monitoring</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> KPI Monitoring</a></li><li class="active">설비 가동 정보</li>
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
							
							<div class="col-sm-2"">
								<div class="form-group">
									 <label>설비구분</label>
									 <select id="fclty_clsfc" name="fclty_clsfc" class="form-control" style="height: 30px;" >
									 	
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>설비명</label>
									 <select id="facilities" name="facilities" class="form-control" style="height: 30px;" >
										<option value="" selected="selected">전체</option>
									 </select>
								</div>
							</div>
							
<!-- 							<div class="col-sm-2"> -->
<!-- 								<div class="form-group"> -->
<!-- 									 <label>월</label> -->
<!-- 									 <select id="month" name="month" class="form-control" style="height: 30px;" > -->
<!-- 										<option value="" selected="selected">전체</option> -->
<!-- 										<option value="1">1</option> -->
<!-- 										<option value="2">2</option> -->
<!-- 										<option value="3">3</option> -->
<!-- 										<option value="4">4</option> -->
<!-- 										<option value="5">5</option> -->
<!-- 										<option value="6">6</option> -->
<!-- 										<option value="7">7</option> -->
<!-- 										<option value="8">8</option> -->
<!-- 										<option value="9">9</option> -->
<!-- 										<option value="10">10</option> -->
<!-- 										<option value="11">11</option> -->
<!-- 										<option value="12">12</option> -->
<!-- 									 </select> -->
<!-- 								</div> -->
<!-- 							</div> -->
							
						</div>
						<!-- 	
						<div class="row" style="margin-bottom: 10px">
							<div class="col-md-6">
								<div id="chartHolder1" style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
							</div>
							<div class="col-md-6">
								<div id="chartHolder2" style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
							</div> -->
						</div>
						
						<div class="row">
							<div class="col-md-12">
								<div id="chartHolder3" style="width: 100%; height: 300px;"></div>
							</div>
							
							<div class="col-md-12">
                           		<div id=chartHolder4 style="width: 100%; height: 300px; "></div>
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


  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->

<script type="text/javascript">
	var chartData1 = [];
	var chartData2 = [];
	var chartData3 = [];
	
	var layoutStr1 = "";
	var layoutStr2 = "";
	var layoutStr3 = "";
	
	$("#fclty_clsfc").change(function(){
		if( $("#fclty_clsfc option:selected").val() != '') {
			$("#facilities").attr('disabled', false);
			fnMachine();
		} else {
			$("#facilities").attr('disabled', true);
			$("#facilities option:eq(0)").prop("selected", true);	
			loadList();
		}
// 		loadList();
	});
	
	$(function($) {
		
		fnCdD('fclty_clsfc');//설비구분
		
	 	fnLoadCommonOption();
	 	
	 	var date = new Date();
		var currYear = date.getFullYear();

		$("#date").append("<option value='" +(currYear-2) +"'>" + (currYear-2) + "</option>");
		$("#date").append("<option value='" +(currYear-1) +"'>" + (currYear-1) + "</option>");
		$("#date").append("<option value='" +(currYear) +"'>" + currYear + "</option>");
		$("#date").append("<option value='" +(currYear+1) +"'>" + (currYear+1) + "</option>");
		
		$("#date option:eq(2)").prop("selected", true);
		
		//$("#year option:eq(2)").prop("selected", true);
		//$("#date").val(currYear).prop("selected", true);
	 	
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
	
// 	$("#fclty_clsfc").change(function(){
// 		fnCdD2('facilities');
		
		
// 		//chartLoadList3();
// 	});
	
	$("#facilities").change(function(){
		
		loadList();
	});
	
	$("#date").change(function(){
		
		loadList();
	});
	
	function fnCdD(val, initTxt){
		console.log("fnCdD("+val+")");
		
// 		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/machine/selectMachine_class";
		
// 		var op = "";
		//var postData = "master_code=" + encodeURIComponent(val2);
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		   // data: postData, 
		    dataType: 'json', 
		    async : false, // 다 끝나고 다음 처리 해!
		    success:function(data, textStatus, jqXHR){
		    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
		    		rowArr = data.rows;
		    		
		    		var sub = val.substr(0,2);
// 		    		console.log("sub = " + sub);
		    		
		    		//  if(valsub != "m_")
		    		$("#"+val ).append("<option value="+''+">" + "전체" + "</option>");
		    		
		    		//if(initTxt) op += "<option value='' >" + "전체" + "</option>";
		    		
					$.each(rowArr, function(idx, row){
						if( val == "fclty_clsfc") {
						$("#"+val ).append("<option value=" + row.machine_class_code + ">"+ row.machine_class_nm + "</option>");
						}
						console.log("row.machine_class_nm:"+row.machine_class_nm);
					});
					
					$("#"+val+" option:eq(0)").prop("selected", true);	
		 			$("#facilities option:eq(0)").prop("selected", true);	
		 			$("#facilities").attr("disabled", true)
		    		
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
// 		    	$('#fclty_clsfc').change();
		    }
		});
		
	}
	
	function fnMachine() {
		console.log("fnMachine");
		initOptions($('#facilities')); // select 박스 초기화
		
		var strUrl = "/info/machine/selectMachine";
		var postData = "machine_class_code=" + encodeURIComponent( $("#fclty_clsfc").val() );
		
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
		    		
	    			$( "#facilities" ).append("<option value="+''+">" + "전체" + "</option>");
	    			
		    		$.each(rowArr, function(idx, row){
						$( "#facilities" ).append("<option value=" + row.machine_code + ">" + '('+row.machine_code +') '+row.machine_nm  + "</option>");
					});
					
		 			$("#facilities option:eq(0)").prop("selected", true);	
		 		} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	loadList();
		    }
		});
		
	}
	
		
	function loadList() {
		console.log("loadList()");
		
		chartData3 = new Array();
		
		var year = $("#date option:selected").val(); 
		var machine_class_code = $("#fclty_clsfc option:selected").val();
		var machine_code = $("#facilities option:selected").val();
		
		var page_url = "/frontend/repair/selectOperation_2";
		
		var postData = "year=" + encodeURIComponent(year);
		
		if( machine_class_code == "") {
			postData += "&machine_class_code=" + "";
			postData += "&machine_code=" + "";
		} else {
			if( machine_code == "") {
				postData += "&machine_class_code=" + encodeURIComponent( machine_class_code ); // where machin_code in (서브쿼리) +  으로
				postData += "&machine_code=" + "";
			} else {
				postData += "&machine_code=" + encodeURIComponent( machine_code );
				postData += "&machine_class_code=" + "";
			}
		}
		
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

					var grapArr = new Array();
					
					for(var i = 1; i<= 13; i++)
					{
						var grapObj = new Object();
						
						if( i == 13)
						{
							grapObj.month = "평균";
							grapObj.per = 0;
							grapObj.machine_class_code = 0;
							grapObj.machine_code = 0;
							grapObj.machine_nm = 0;
							grapArr.push(grapObj);

						}else
						{
							grapObj.month = i + "월";
							grapObj.per = 0;
							grapObj.machine_class_code = 0;
							grapObj.machine_code = 0;
							grapObj.machine_nm = 0;
							
							grapArr.push(grapObj);
						}

					}
	
					var hap = 0;
					var ten_hap=0;
					var ele_hap=0;					
					var count=0
					for(var i = 0; i< result.length; i++)
					{
						var grapObj = new Object();
						var month = result[i].month;
						
						grapObj.month = result[i].month + "월";
						grapObj.per = result[i].per;
						console.log("result[i].per:"+result[i].per)
						
						grapObj.machine_class_code = result[i].machine_class_code;
						console.log("result[i].machine_class_code:"+result[i].machine_class_code)
						
						grapObj.machine_code = result[i].machine_code;	
						console.log("result[i].machine_code:"+result[i].machine_code)
						
						grapObj.machine_nm = result[i].machine_nm;
						grapArr[Number(month) - 1] = grapObj;
						
						
 						if(result[i].month == 11){
 							count++;
 							ele_hap = Number(ele_hap) + Number(result[i].per);
 							ele_avg = ele_hap/count;
 							console.log("count:"+count);
 							}else if(result[i].month == 10){
 								count++;
 	 							ten_hap = Number(ten_hap) + Number(result[i].per);
 	 							ten_avg = ten_hap/count;									
 							}
						
						
						hap = Number(hap) + Number(result[i].per);
						avg = hap/12;
							
						console.log("hap은??" + hap);	
					}
					grapArr[9].per = ten_avg;
					grapArr[10].per = ele_avg;
					grapArr[12].per = avg;
			
					
					setTimeout(function () {
		
						chartData3 = grapArr;
						
						chartLength = chartData3.length;
						
						console.log(chartLength);

						makeLayout3();
						fnLoadChart();

					},300);
				} else {
					console.log('check');
					var b = [];
					document.getElementById("chart3").setData(b);
					makeLayout3();
					fnLoadChart();
					rMateChartH5.call("chart3", "hasNoData", true);					
					
				}
				
			},complete: function () {
				
				
			}
		});
	}
	
	
	function showPreloader()
	{
	  document.getElementById("chart3").showAdditionalPreloader();
	}
	 
	// 프리로더를 제거합니다.
	function hidePreloader()
	{
	   document.getElementById("chart3").removeAdditionalPreloader();
	}
	
	
	function fnLoadChart() {
		rMateChartH5.create("chart3", "chartHolder3", "", "100%", "100%");
		
		rMateChartH5.calls("chart3", {
			   "setLayout" : layoutStr3,
			    "setData" : chartData3
		});
	}
	
	function loadList2() {
		console.log("loadList2()");
		
		chartData4 = new Array();
		
		var year = $("#date option:selected").val(); 
		var machine_class_code = $("#fclty_clsfc option:selected").val();
		var machine_code = $("#facilities option:selected").val();
		
		var page_url = "/frontend/repair/selectOperation";
		
		var postData = "year=" + encodeURIComponent(year);
		
		if( machine_class_code == "") {
			postData += "&machine_class_code=" + "";
			postData += "&machine_code=" + "";
		} else {
			if( machine_code == "") {
				postData += "&machine_class_code=" + encodeURIComponent( machine_class_code ); // where machin_code in (서브쿼리) +  으로
				postData += "&machine_code=" + "";
			} else {
				postData += "&machine_code=" + encodeURIComponent( machine_code );
				postData += "&machine_class_code=" + "";
			}
		}
		
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

					var grapArr = new Array();
					
					for(var i = 0; i< result.length; i++)
					{
						var grapObj = new Object();
												
							grapObj.X = "("+result[i].machine_code+") "+result[i].machine_nm;
							grapObj.month = result[i].month;
							grapObj.per = result[i].per;
							grapObj.machine_class_code = result[i].machine_class_code;
							grapObj.machine_code = result[i].machine_code;
							grapObj.machine_nm = result[i].machine_nm;
							
							grapArr.push(grapObj);
						

					}
					
					setTimeout(function () {
		
						chartData4 = grapArr;
						
						chartLength = chartData4.length;
						
						console.log(chartLength);

						makeLayout4();
						fnLoadChart2();

					},300);
				} else {
					console.log('check');
					var b = [];
					document.getElementById("chart4").setData(b);
					makeLayout4();
					fnLoadChart2();
					rMateChartH5.call("chart4", "hasNoData", true);					
					
				}
				
			},complete: function () {
				
				
			}
		});
	}
	
	function showPreloader2()
	{
	  document.getElementById("chart4").showAdditionalPreloader();
	}
	 
	// 프리로더를 제거합니다.
	function hidePreloader2()
	{
	   document.getElementById("chart4").removeAdditionalPreloader();
	}
	
	
	function fnLoadChart2() {
		rMateChartH5.create("chart4", "chartHolder4", "", "100%", "100%");
		
		rMateChartH5.calls("chart4", {
			   "setLayout" : layoutStr4,
			    "setData" : chartData4
		});
	}
	
	function makeLayout1() {

		var date = $("#date option:selected").val();

		layoutStr1 =
         '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
             +'<Options>'
                +'<Caption text="'+date+'년 그룹별 가동율"/>'
                  +'<Legend useVisibleCheck="true"/>'
             +'</Options>'
           +'<Combination3DChart showDataTips="true" dataTipDisplayMode="axis"  itemClickJsFunction="loadList2" paddingTop="0" >' // dataTipJsFunction="dataTipJsFunc" | dataTipDisplayMode="axis"
           /*
                Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다
                showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
           */
                  +'<horizontalAxis>'
	                  +'<CategoryAxis categoryField="mg" padding="0.2"/>'
	              +'</horizontalAxis>'
	              +'<verticalAxis>'
	                  +'<LinearAxis minimum="0"/>'
	              +'</verticalAxis>'
	              
                  +'<series>'
                     +'<Column3DSeries labelPosition="outside" yField="val" displayName="그룹별 가동" showValueLabels="[0,1,2,3,4,5,6,7,8,9,10,11]">'
                        +'<fill>'
                           +'<SolidColor color="#41b2e6"/>'
                        +'</fill>'
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                    +'</Column3DSeries>'
                   
                    +'<Line2DSeries radius="6" yField="goal" displayName="목표대비가동율" itemRenderer="CircleItemRenderer" >'
                       /* +'<verticalAxis>'
                          +'<LinearAxis id="vAxis2" formatter="{numFmt2}" tickCount="7"/>'
                       +'</verticalAxis>' */
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                       /*  +'<lineStroke>'
                             +'<Stroke color="#f9bd03" weight="4"/>'
                         +'</lineStroke>' */
                        +'<stroke>'
                             +'<Stroke color="#f9bd03" weight="3"/>'
                         +'</stroke>'
                    +'</Line2DSeries>'
                  +'</series>'
                  
               
               +'<annotationElements>'
                   +'<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
                    +'</CrossRangeZoomer>'
              +'</annotationElements>'
             +'</Combination3DChart>'
        +'</rMateChart>';
	}

	function makeLayout3() {

		var date = $("#date option:selected").val();

		layoutStr3 =
         '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
             +'<Options>'
                +'<Caption text="'+date+'년 월별 가동율"/>'
                  +'<Legend useVisibleCheck="true"/>'
             +'</Options>'
           +'<Combination3DChart showDataTips="true" itemClickJsFunction="loadList2" dataTipDisplayMode="axis" paddingTop="0" >' // dataTipJsFunction="dataTipJsFunc"
           /*
                Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다
                showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
           */
                  +'<horizontalAxis>'
	                  +'<CategoryAxis categoryField="month" padding="0.2"/>'
	              +'</horizontalAxis>'
	              +'<verticalAxis>'
	                  +'<LinearAxis minimum="0"/>'
	              +'</verticalAxis>'
	              
                  +'<series>'
                  
                     +'<Column3DSeries labelPosition="outside" yField="per" displayName="월별 가동율" >'
//                         +'<fill>'
//                            +'<SolidColor color="#41b2e6"/>'
//                         +'</fill>'
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                    +'</Column3DSeries>'

                    /* +'<Line2DSeries radius="6" yField="goal" displayName="목표대비가동율" itemRenderer="CircleItemRenderer" >'
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                        +'<stroke>'
                             +'<Stroke color="#f9bd03" weight="3"/>'
                         +'</stroke>'
                    +'</Line2DSeries>' */
                  +'</series>'
               
               +'<annotationElements>'
                   +'<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
                    +'</CrossRangeZoomer>'
              +'</annotationElements>'
             +'</Combination3DChart>'
        +'</rMateChart>';
	}
	
	function makeLayout4() {

		var date = $("#date option:selected").val();
		
		var fclty_clsfc = $("#fclty_clsfc option:selected").text();
		
 		 if( fclty_clsfc=='전체') {
 			fnMessageModalAlert("알림","설비구분을 선택해야합니다.");
 		 }else{
		 
		layoutStr4 =
         '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
             +'<Options>'
                +'<Caption text="'+fclty_clsfc+' 가동율"/>'
                  +'<Legend useVisibleCheck="true"/>'
             +'</Options>'
           +'<Combination3DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0" >' // dataTipJsFunction="dataTipJsFunc"
           /*
                Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다
                showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
           */
                  +'<horizontalAxis>'
	                  +'<CategoryAxis categoryField="X" padding="0.2"/>'
	              +'</horizontalAxis>'
	              +'<verticalAxis>'
	                  +'<LinearAxis minimum="0"/>'
	              +'</verticalAxis>'
	              
                  +'<series>'
                  
                     +'<Column3DSeries labelPosition="outside" yField="per" displayName="월별 가동율" >'
//                         +'<fill>'
//                            +'<SolidColor color="#41b2e6"/>'
//                         +'</fill>'
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                    +'</Column3DSeries>'

                    /* +'<Line2DSeries radius="6" yField="goal" displayName="목표대비가동율" itemRenderer="CircleItemRenderer" >'
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                        +'<stroke>'
                             +'<Stroke color="#f9bd03" weight="3"/>'
                         +'</stroke>'
                    +'</Line2DSeries>' */
                  +'</series>'
               
               +'<annotationElements>'
                   +'<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
                    +'</CrossRangeZoomer>'
              +'</annotationElements>'
             +'</Combination3DChart>'
        +'</rMateChart>';
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