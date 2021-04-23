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
    
}
	</style>
	<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
	<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
	<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>
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
		<jsp:param name="selected_menu_cd" value="1066" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      자재 품질 분석
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 자재 품질 분석</a></li><li class="active">품질관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search_csr" onclick="loadData();" class="btn btn-warning btn-sm">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>조회년도(From)</label> 
									<select id="s_inspection_year" name="s_inspection_year" class="form-control input-sm s_cond" data-placeholder="Action 구분선택...">
										<option value="2020">2020년</option>
										<option value="2021">2021년</option>
										<option value="2022">2022년</option>
										<option value="2023">2023년</option>
										<option value="2024">2024년</option>
										<option value="2025">2025년</option>
										<option value="2026">2026년</option>
										<option value="2027">2027년</option>
										<option value="2028">2028년</option>
										<option value="2029">2029년</option>
										<option value="2030">2030년</option>
									</select>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>조회년도(To)</label> 
									<select id="e_inspection_year" name="e_inspection_year" class="form-control input-sm s_cond" data-placeholder="Action 구분선택...">
										<option value="2020">2020년</option>
										<option value="2021">2021년</option>
										<option value="2022">2022년</option>
										<option value="2023">2023년</option>
										<option value="2024">2024년</option>
										<option value="2025">2025년</option>
										<option value="2026">2026년</option>
										<option value="2027">2027년</option>
										<option value="2028">2028년</option>
										<option value="2029">2029년</option>
										<option value="2030">2030년</option>
									</select>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> 
									<div>
										<input type="text" id="p_item_code" name="p_item_code" class="w2ui-field q-w2ui-list s_cond" maxlength="100"  style="width: 100%;"/>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> 
									<div>
										<input type="text" id="p_item_nm" name="p_item_nm" class="w2ui-field q-w2ui-list s_cond" maxlength="100" style="width: 100%;"/>
									</div>
								</div>

							</div>
							
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>공정명</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="s_rtng" class="form-control select2 input-sm s_cond" data-placeholder="" style="width: 100%;">
										</select>
									</div>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>검사항목</label>
									<div class="form-group" style="margin-bottom: 0px;">
										<select id="s_insp_item" class="form-control select2 input-sm s_cond" data-placeholder="" style="width: 100%;">
										</select>
									</div>
								</div>
							</div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<!-- 로딩바 -->
							<div id="progress_Loading" class="col-md-12 text-center"
								style="margin-top: 180px;">
								<!-- class="col-md-12 text-center"  -->
								<img src="/res/images/common/loading.gif" />
							</div>
							
							<!-- 차트 영역 -2 -->
							<div class="row" style="margin-bottom: 10px;" >
								<div class="col-md-12">
									<div class="col-md-12 text-center">
										<div id="table_chart2" style="width: 100%; height: 200px; text-align: center;"></div>
									</div>
								</div>
							</div>

							<!-- 차트 영역 -->
							<div class="row" >
								<div class="col-md-12">
									<div class="col-md-12 text-center">
										<div id="table_chart1" style="width: 100%; height: 250px; text-align: center;"></div>
									</div>
									
								</div>
							</div>
						</div>
						<!-- 테이블 -->
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 150px; "></div>
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

var colorList = [
'#FF0000',
'#0100FF',
'#FFE400',
'#1DDB16',
'#000000',
'#5F00FF',
'#00D8FF'
];

var layoutStr = '';
var chartData = [];
var chartData2 = [];

var layoutStr = "";
var layoutStr2 = "";

$(function($) {
	loadMatInfo();
 	fnLoadCommonOption(); 	 
 	settingLayout();
 	init_grid_list();
	settingLayout2();
	
	$('#s_rtng').on("change",function(event){ 
		getInspInfo($('#p_item_code').val(), $('#s_rtng').val());
 	}); 
	
	$('#s_insp_item').on("change",function(event){ 
		loadData();		
 	});
	
	$('#s_inspection_year').on("change",function(event){
		var s_dt = $('#s_inspection_year').val();
		var e_dt = $('#e_inspection_year').val();
		
		if(s_dt.length > 0 && e_dt.length > 0)
		{
			if(Number(s_dt) > Number(e_dt))
			{
				$('#e_inspection_year').val(s_dt);
			}
		}
		
		getInspInfo($('#p_item_code').val(), $('#s_rtng').val());
 	});
	
	$('#e_inspection_year').on("change",function(event){
		var s_dt = $('#s_inspection_year').val();
		var e_dt = $('#e_inspection_year').val();
		
		if(s_dt.length > 0 && e_dt.length > 0)
		{
			if(Number(s_dt) > Number(e_dt))
			{
				$('#s_inspection_year').val(e_dt);
			}
		}
		
		getInspInfo($('#p_item_code').val(), $('#s_rtng').val());
 	}); 
})



//밑에꺼
function settingLayout()
{
	
	rMateChartH5.create("chart1", "table_chart1", "", "100%", "100%");
	rMateChartH5.create("chart2", "table_chart2", "", "100%", "100%");
	
	var tmpArr = new Array();
	makeLayout(0,100,1,1, tmpArr, tmpArr);
	makeLayout2('OK', 'NG', 100);
	

	
	rMateChartH5.calls("chart2", { "setLayout" : layoutStr2, "setData" : []});
	rMateChartH5.calls("chart1", { "setLayout" : layoutStr, "setData" : []});
 	
	rMateChartH5.call("chart1", "hasNoData", true);
	rMateChartH5.call("chart2", "hasNoData", true);
	
	$('#progress_Loading').css("display", "none");
	$('#table_chart1').css("display", "");	

}

//위에꺼
function settingLayout2()
{
	
	var inspection_year = $('#s_inspection_year').val();
	var from_date = inspection_year+""+moment().subtract(1, 'months').format('MM');
	var to_date = inspection_year+""+moment().format('MM');
	
	
	$('#table_chart2').css("display", "");
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
 

//회사명 변경시 1개 이상 조회시 select box로 1개일시 input창
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
        	lineNumbers: true,
            footer: true
        },
        multiSelect: false,
        columns: [
			{ field:'end_time', caption:'검사일', size:'20%', style:'text-align:center',sortable :true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);
	                return moment(html).format("YYYY-MM-DD");
	              }			
			},
			{ field:'product_po', caption:'작업지시번호', size:'20%', style:'text-align:center',sortable :true},
			{ field:'routing_code', caption:'공정코드', size:'20%', style:'text-align:center',sortable :true},
	        { field:'val_seq', caption:'S/L', size:'20%', style:'text-align:center',sortable :true}, 
			{ field:'inspection_item', caption:'검사 항목 ', size:'20%', style:'text-align:center',sortable :true}, 
			{ field:'spec', caption:'검사기준', size:'10%', style:'text-align:center',sortable :true},
			{ field:'min_spec', caption:'규격(LCL)', size:'10%', style:'text-align:center',sortable :true},
			{ field:'max_spec', caption:'규격(UCL)', size:'10%', style:'text-align:center',sortable :true},
			{ field:'insp_val', caption:'측정 data', size:'25%', style:'text-align:center',sortable :true},
			{ field:'insp_rst', caption:'측정 결과', size:'10%', style:'text-align:center',sortable :true}
			], 
		records: [
		],
		onReload: function(event) {
		},
		onClick: function (event) {}
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

function dataTipFunc(seriesId, seriesName, index, xName, yName, data, values) {
	 return "<b>" + data["product_po"] + "</b><br/>"
	 + "SLOT : " + data["g_slot"] + "<br/>"   
	 + "측정값 : " + data["insp_val"];	     
}

function fillJsFunc(seriesId, index, data, values){
 		
	return colorList[data.color_seq];
}

function axisLabelFunc(id, value){
	var tmp = value.split('/');
	return  tmp[1];
}

function makeLayout(min, max, lcl, ucl, range_arr, arr) {
	layoutStr =
        '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
              +'<Options>'
            	  +'<Caption text="SLOT 별 측정값 비교" />'
              +'</Options>'
            +'<NumberFormatter id="numFmt" precision="0"/>'
              +'<Plot2DChart showDataTips="true" dataTipJsFunction="dataTipFunc">'
                 +'<horizontalAxis>'
                      +'<CategoryAxis categoryField="x_mod_val" labelJsFunction="axisLabelFunc"/>'
                  +'</horizontalAxis>'
                 +'<verticalAxis>'
                    +'<LinearAxis minimum="'+min+'" maximum="'+max+'" title="측정값"/>'
                +'</verticalAxis>'
                
                
          		+'<backgroundElements>'
                	+'<GridLines direction="both"/>'
                
                	+'<AxisMarker>'
                
                
                
                		+'<ranges>';

                
                
                for(var i=0 ;i<range_arr.length;i++)
                {
                	var x_start = range_arr[i].x_start;
                	var x_end = '';
                	if(i == range_arr.length-1)
                	{
                		x_end = arr[arr.length-1].x_mod_val;
                	} else {
                		
                		var tmp = range_arr[i+1].x_start.split('/');
                		var end_seq = Number(tmp[0])-1;
						
                		x_end = arr[end_seq].x_mod_val;
                	}
                		
                	
                	var lcl = range_arr[i].lcl;
                	var ucl = range_arr[i].ucl;
                	
                	
                	
                	layoutStr += '<AxisRange startValue="'+lcl+'" endValue="'+ucl+'" horizontalStartValue="'+x_start+'" horizontalEndValue="'+x_end+'" >'
                    +'<fill>'
                    +'<SolidColor color="#eef3f6" alpha="0.8"/>'
                 	+'</fill>'
                    +'</AxisRange>';
                }
                
                
                layoutStr +='</ranges>'
		                	+'</AxisMarker>'
		           			+'</backgroundElements>'
		                   +'<series>'
		                      +'<Plot2DSeries yField="g_val" displayName="Population" fillJsFunction="fillJsFunc">'
// 		                          +'<showDataEffect>'
// 		                              +'<SeriesZoom relativeTo="chart" duration="1000"/> '
// 		                         +'</showDataEffect>'
		                     +'</Plot2DSeries>'
		                   +'</series>'
		                   +'<annotationElements>'
		                   +'<CrossRangeZoomer zoomType="both"/>'
		                +'</annotationElements>'
		                
		             +'</Plot2DChart>'
		        +'</rMateChart>';
	

}
//chart - 2
function makeLayout2(data1, data2, maximum) {

	layoutStr2 =
		'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
           +'<Options>'
              +'<Caption text="불량수량/합격수량 비교"/>'
                +'<SubCaption text="" textAlign="center" />'
              +'<Legend defaultMouseOverAction="false" />'
          +'</Options>'
         +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single">'
             +'<horizontalAxis>'
                   +'<CategoryAxis categoryField="cd"/>'
              +'</horizontalAxis>'
              +'<verticalAxis>'
                 +'<LinearAxis maximum="'+maximum+'"/>'
             +'</verticalAxis>'
                +'<series>'
                   +'<Column2DSeries labelPosition="outside" yField="data1" displayName="'+data1+'">'
//                         +'<showDataEffect>'
//                            +'<SeriesInterpolate/>'
//                        +'</showDataEffect>'
                  +'</Column2DSeries>'
                  +'<Column2DSeries labelPosition="outside" yField="data2" displayName="'+data2+'">'
//                         +'<showDataEffect>'
//                            +'<SeriesInterpolate/>'
//                        +'</showDataEffect>'
                  +'</Column2DSeries>'
              +'</series>'
              
              
         
         
          +'</Column2DChart>'
       +'</rMateChart>';
}

var comboValue = new Array;
var matnrRowArr = new Array;

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
				
				$('#p_item_code').w2field('combo', {items: comboValue_cd, match : 'contains' })
				 .on('change', function () {
					 
		            $.each(comboValue, function(idx, row){
						var p_id = row.id;
						var p_text = row.text;
						
						if(p_id == $('#p_item_code').val())
						{
							$('#p_item_nm').w2field().set(p_text);
							getRtngInfo(p_id);
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
							getRtngInfo(p_id);
						}
					});
				});
			}
		},complete: function () {
		}
	});
}

function getRtngInfo(p_id)
{
	var page_url = "/frontend/insp/getRtngInfo";
	var postData = "item_code=" + encodeURIComponent(p_id);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data:postData,
		success : function( data ) {
			if(data.status == 200) {
				
				initOptions($('#s_rtng'));
				initOptions($('#s_insp_item'));				
				
				$.each(data.rows, function(idx, row){
					$('#s_rtng').append("<option value=" + row.routing_code + ">" + row.routing_nm + " ("+row.routing_code + ")</option>");
				});
				
			} else {
				initOptions($('#s_rtng'));
				initOptions($('#s_insp_item'));	
			}
		},complete: function () {
			
			getInspInfo($('#p_item_code').val(), $('#s_rtng').val());
		}
	});
}

function getInspInfo(p_item_code, p_routing_code)
{
	
	if(p_item_code == '' || p_routing_code == '')
		return;
	
	var page_url = "/frontend/insp/getInspInfo";
	var postData = "item_code=" + encodeURIComponent(p_item_code);
	postData += "&routing_code=" + encodeURIComponent(p_routing_code);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data:postData,
		success : function( data ) {
			if(data.status == 200) {
				
				initOptions($('#s_insp_item'));
				
				$.each(data.rows, function(idx, row){
					$('#s_insp_item').append("<option value=" + row.inspection_seq + ">" + row.inspection_item  + " ("+row.inspection_seq+")</option>");
				});
				
				var a = $('#p_item_code').val();
				var b = $('#p_item_nm').val();
				var c = $('#s_rtng').val();
				var d = $('#s_insp_item').val();
				
				if(nullToBlank(a).length > 0 && nullToBlank(b).length > 0 && nullToBlank(c).length > 0 && nullToBlank(d).length > 0)
				{
					getQAnalData_1();
					getQAnalData_2();
				}
				
			} else {
				initOptions($('#s_insp_item'));
			}
		},
		complete: function () {
			
		}
	});
}

function initOptions(obj) {
    $(obj)
    .find('option')
    .remove()
    .end()
    .val();
}

function getQAnalData_1()
{
	var m_year = $('#s_inspection_year').val();
	var n_year = $('#e_inspection_year').val();
	var item_code = $('#p_item_code').val();
	var p_item_nm = $('#p_item_nm').val();
	var routing_code = $('#s_rtng').val();
	var inspection_seq = $('#s_insp_item').val();
	

	
	var page_url = "/frontend/insp/getQAnalData_1";
	var postData = "m_year=" + encodeURIComponent(m_year);
	postData += "&n_year=" + encodeURIComponent(n_year);
	postData += "&item_code=" + encodeURIComponent(item_code);
	postData += "&p_item_nm=" + encodeURIComponent(p_item_nm);
	postData += "&routing_code=" + encodeURIComponent(routing_code);
	postData += "&inspection_seq=" + encodeURIComponent(inspection_seq);
	FunLoadingBarStart();	
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data:postData,
		success : function( data ) {
			if(data.status == 200) {
				
				
				var maximum = 0;
				var arr = new Array();
				
				
				
				for(var m=Number(m_year) ; m<Number(n_year)+1; m++)
				{
					for(var i=1 ; i<13; i++)
					{
						var vals = new Object();
						
						vals.cd = m + '년 ' +i + '월';
						
						var exist_flag = 0;
						$.each(data.rows, function(idx, row){
							if( m == Number(row.end_year) && Number(i) == Number(row.end_month))
							{
								vals.data1 = (data.rows[idx].prod_menge == null)?0:Number(data.rows[idx].prod_menge);
								vals.data2 = (data.rows[idx].ng_cnt == null)?0:Number(data.rows[idx].ng_cnt);
								
								var myArray = [Math.ceil(vals.data1*1.2), Math.ceil(vals.data2*1.2), maximum]
								maximum = Math.max.apply(null, myArray);

								exist_flag++;
							}
						});	
							
						if(exist_flag == 0)
						{
							vals.data1 = 0;
							vals.data2 = 0;
						}
						
						arr.push(vals);
					}
				}
				
				
				
				
				
				
				/*
				var maximum = 0;
				var arr = new Array();
				
				for(var i=1 ; i<13; i++)
				{
					var vals = new Object();
					
					vals.cd = i + '월';
					
					var exist_flag = 0;
					$.each(data.rows, function(idx, row){
						if(Number(i) == Number(row.end_month))
						{
							vals.data1 = (data.rows[idx].prod_menge == null)?0:Number(data.rows[idx].prod_menge);
							vals.data2 = (data.rows[idx].ng_cnt == null)?0:Number(data.rows[idx].ng_cnt);
							
							var myArray = [Math.ceil(vals.data1*1.2), Math.ceil(vals.data2*1.2), maximum]
							maximum = Math.max.apply(null, myArray);

							exist_flag++;
						}
					});	
						
					if(exist_flag == 0)
					{
						vals.data1 = 0;
						vals.data2 = 0;
					}
					
					arr.push(vals);
				}
				*/			
				makeLayout2('OK', 'NG', maximum);
			 	rMateChartH5.calls("chart2", { "setLayout" : layoutStr2, "setData" : arr});
			}
		},complete: function () {
			FunLoadingBarEnd();
		}
	});
}

function getQAnalData_2()
{
	var m_year = $('#s_inspection_year').val();
	var n_year = $('#e_inspection_year').val();
	var item_code = $('#p_item_code').val();
	var p_item_nm = $('#p_item_nm').val();
	var routing_code = $('#s_rtng').val();
	var inspection_seq = $('#s_insp_item').val();
	
	
	var page_url = "/frontend/insp/getQAnalData_2";
	var postData = "m_year=" + encodeURIComponent(m_year);
	postData += "&n_year=" + encodeURIComponent(n_year);
	postData += "&item_code=" + encodeURIComponent(item_code);
	postData += "&p_item_nm=" + encodeURIComponent(p_item_nm);
	postData += "&routing_code=" + encodeURIComponent(routing_code);
	postData += "&inspection_seq=" + encodeURIComponent(inspection_seq);
	FunLoadingBarStart();
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data:postData,
		success : function( data ) {
			if(data.status == 200) {
				var arr = new Array();
				var lcl = 0;
				var ucl = 0;
				var max = 0;
				var min = 0;
				var pre_po = '';
				var spec = '';
				var color_seq = -1;
				var range_arr = [];
				var x_mod_val = 0;
				
				$.each(data.rows, function(idx, row){
										
					row.recid = idx + 1;
					
					var vals = new Object();

					var insp_val = (data.rows[idx].insp_val == null)?0:data.rows[idx].insp_val;
					var val_seq = (data.rows[idx].val_seq == null)?0:data.rows[idx].val_seq;

					vals.g_slot = val_seq;
					vals.insp_val = insp_val;
					vals.product_po = row.product_po;
					
					//PO 별 그래프 색상 설정 & po별 lcl, ucl 저장: Start
					if(pre_po != vals.product_po)
					{
						pre_po = vals.product_po;
						color_seq++;
						if(color_seq == 7)
							color_seq = 0;
						
						var rangeObj = new Object();
						rangeObj.x_start = x_mod_val+ "/" +row.val_seq;
						rangeObj.lcl = row.min_spec;
						rangeObj.ucl = row.max_spec;
						
						range_arr.push(rangeObj);
					}
					vals.color_seq = color_seq;
					//PO 별 그래프 색상 설정 & po별 lcl, ucl 저장 : End
					
					vals.lcl = row.min_spec;
					vals.ucl = row.max_spec;
					
					vals.x_mod_val = x_mod_val + "/" +row.val_seq;
					x_mod_val++;
					arr.push(vals);
				
				});
				
				w2ui['grid_list'].clear();
				w2ui['grid_list'].records = data.rows;
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
				
				
				$.each(range_arr, function(idx, row){
					
					if(idx == 0)
					{
						lcl = Number(row.lcl);
						ucl = Number(row.ucl);
					}
					
					if(Number(row.lcl) < Number(lcl))
					{
						lcl = Number(row.lcl);
					}
					if(Number(row.ucl) > Number(ucl))
					{
						ucl = Number(row.ucl);
					}
				});
				
				
				
				
				
				min =  (Number(lcl) - (Number(ucl) - Number(lcl)));	
				max =  (Number(ucl) + (Number(ucl) - Number(lcl)));	
				
				if(max == 0)
					max = 1;
				
				$.each(arr, function(idx, row){
					//lcl, ucl 범위를 벗어나는 값은 lcl, ucl값으로 일괄 설정
					if(Number(row.insp_val) < Number(row.lcl))
					{
						row.g_val = Number(min);
					} else if(Number(row.insp_val) > Number(row.ucl))
					{
						row.g_val = Number(max);
					} else {
						row.g_val = row.insp_val;
					}
				});
				
				makeLayout(min, max, lcl, ucl, range_arr, arr);
				rMateChartH5.calls("chart1", { "setLayout" : layoutStr, "setData" : arr });
			}
		},complete: function () {
			FunLoadingBarEnd();
		}
	});
}

function loadData()
{
	var a = $('#p_item_code').val();
	var b = $('#p_item_nm').val();
	var c = $('#s_rtng').val();
	var d = $('#s_insp_item').val();
	
	if(nullToBlank(a).length == 0 || nullToBlank(b).length == 0 || nullToBlank(c).length == 0 || nullToBlank(d).length == 0)
	{
		fnMessageModalAlert("알림", "조회 조건을 모두 입력해 주세요.");
		return;
	}
	
	
	getQAnalData_1();
	getQAnalData_2();
}
</script>

</body>
</html>