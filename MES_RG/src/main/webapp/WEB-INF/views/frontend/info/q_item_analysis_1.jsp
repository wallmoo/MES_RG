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
									<label>| 조회 년</label> 
									<select id="s_inspection_year" name="s_inspection_year" class="form-control input-sm s_cond" data-placeholder="Action 구분선택...">
										<option value="2020">2020년</option>
										<option value="2021">2021년</option>
										<option value="2022">2022년</option>
										<option value="2023">2023년</option>
										<option value="2023">2024년</option>
										<option value="2023">2025년</option>
										<option value="2023">2026년</option>
										<option value="2023">2027년</option>
										<option value="2023">2028년</option>
										<option value="2023">2029년</option>
										<option value="2023">2030년</option>
									</select>
								</div>
							</div>
<!-- 							<div class="col-sm-2"> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label>P/N</label>  -->
<!-- 									<div> -->
<!-- 										<input type="text" id="p_item_code" name="p_item_code" class="w2ui-field q-w2ui-list s_cond" maxlength="100"  style="width: 100%;"/> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> 
									<div>
										<input type="text" id="p_item_code" name="p_item_code" class="form-control input-sm matnr s_cond" maxlength="100"  style="width: 100%;" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> 
									<div>
<!-- 										<input type="text" id="p_item_nm" name="p_item_nm" class="w2ui-field q-w2ui-list s_cond" maxlength="100" style="width: 100%;" /> -->
										<input type="text" id="p_item_nm" name="p_item_nm" class="form-control input-sm matnr s_cond" maxlength="100"  style="width: 100%;" readonly="readonly"/>
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
										<div id="table_chart2" style="width: 100%; height: 300px; text-align: center;"></div>
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

<div class="modal fade" id="modal_mcode" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_title">자재목록</h4>
			</div>
			<div class="modal-body" id="">
				<div class="row">
					<div class="col-md-12 form-horizontal">
						<div class="form-group">
							<label class="col-sm-3 control-label">자재코드</label>
							<div class="col-sm-9">
								<input type="input" id="mm_matnr" name="mm_matnr" class="form-control input-sm">
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-12" style="height: 100%; width: 100%;">
								<div id="grid_matnr" style="height: 300px;"></div>
							</div>
						</div>
					</div>
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
	init_grid_matnr();
	
	$("#mm_matnr").keyup(_.debounce(function(event) {
		
		var matnr = $("#mm_matnr").val();
		var tmpArr = [];
		var rowNum = 1;
		w2ui['grid_matnr'].lock('loading...', true);
		
		if(matnr.length == 0)
		{
			$.each(matnrRowArr, function(idx, row){
				var obj = Object();
				obj.recid = idx + 1;
				obj.item_code = row.item_code;
				obj.item_nm = row.item_nm;

				tmpArr.push(obj);
			});
		} else {
			$.each(matnrRowArr, function(idx, row){
				var obj = Object();
				if(row.item_code.toLowerCase().indexOf(matnr.toLowerCase()) != -1)
				{
					obj.recid = rowNum;
					obj.item_code = row.item_code;
					obj.item_nm = row.item_nm;
					tmpArr.push(obj);
					rowNum++;
				}
			});	
		}
		w2ui['grid_matnr'].clear();
		w2ui['grid_matnr'].records = tmpArr;
		w2ui['grid_matnr'].refresh();
		w2ui['grid_matnr'].unlock();	
	
		if(w2ui['grid_matnr'].records.length > 0)
		{
			w2ui['grid_matnr'].select(1);	
		} else {
			w2ui['grid_matnr'].selectNone();
		}
	},100));	

	$("#mm_matnr").pressEnter(function(e) {
		$("#modal_mcode").modal('hide');
		
		if(w2ui['grid_matnr'].getSelection().length > 0)
		{
			var getData = w2ui['grid_matnr'].get(w2ui['grid_matnr'].getSelection());	
			$("#p_item_code").val(getData[0].item_code);
			$("#p_item_nm").val(getData[0].item_nm);
			
			getRtngInfo(getData[0].item_code);
		} else {
			$("#p_item_code").val("");
	 		$('#p_item_nm').val("");
	 		$('#s_rtng').val("");
	 		$('#s_insp_item').val("");
		}
	});
	
	$(".matnr").focus(function(){
		$("#mm_matnr").val("");
		w2ui['grid_matnr'].clear();
		load_matnr();
		setTimeout(function(){ 
			w2ui['grid_matnr'].resize(); 
			w2ui['grid_matnr'].refresh(); 
		}, 200); 
		
		$("#modal_mcode").modal('show');
		
		setTimeout(function(){ 
			$("#mm_matnr").focus(); 
		}, 200);
		
	});
	
	$('.s_cond').on("change",function(event){ 
		var a = $('#p_item_code').val();
		var b = $('#p_item_nm').val();
		var c = $('#s_rtng').val();
		var d = $('#s_insp_item').val();
		
		if(nullToBlank(a).length > 0 && nullToBlank(b).length > 0 && nullToBlank(c).length > 0 && nullToBlank(d).length > 0)
		{
			getQAnalData_1();
			getQAnalData_2();
		}
 	}); 
})



//밑에꺼
function settingLayout()
{
	
	rMateChartH5.create("chart1", "table_chart1", "", "100%", "100%");
	rMateChartH5.create("chart2", "table_chart2", "", "100%", "100%");
	
	makeLayout(100,1,1);
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
			{ field:'product_po', caption:'작업지시번호', size:'20%', style:'text-align:center'},
			{ field:'routing_code', caption:'공정코드', size:'20%', style:'text-align:center'},
	        { field:'val_seq', caption:'S/L', size:'20%', style:'text-align:center'}, 
			{ field:'inspection_item', caption:'검사 항목 ', size:'20%', style:'text-align:center'}, 
			{ field:'spec', caption:'검사기준', size:'10%', style:'text-align:center'},
			{ field:'min_spec', caption:'규격(LSL)', size:'25%', style:'text-align:center'},
			{ field:'max_spec', caption:'규격(USL)', size:'10%', style:'text-align:center'},
			{ field:'insp_val', caption:'측정 data', size:'25%', style:'text-align:center'}
			], 
		records: [
		],
		onReload: function(event) {
		},
		onClick: function (event) {}
	});

}

function init_grid_matnr(){
	$('#grid_matnr').w2grid({ 
        name: 'grid_matnr',
        show: {
        	lineNumbers: true,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'item_code', caption:'자재코드', size:'20%', style:'text-align:center'},
			{ field:'item_nm', caption:'자재명', size:'20%', style:'text-align:center'}
			], 
		records: [
		],
		onReload: function(event) {
		},
		onDblClick: function (event) {
			console.log(event);
			$("#modal_mcode").modal('hide');
			
			var getData = w2ui['grid_matnr'].get(event.recid);	
			$("#p_item_code").val(getData.item_code);
			$("#p_item_nm").val(getData.item_nm);
			
			getRtngInfo(getData.item_code);
		}
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

function makeLayout(max, lsl, usl) {
	layoutStr =
        '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
              +'<Options>'
                 +'<Caption text="SLOT 별 측정값 비교" />'
                   +'<SubCaption text="마우스 드래그로 영역을 설정하면 확대/축소를 할 수 있습니다."/>'
               +'</Options>'
            /*
                 Plot2D 차트 생성시에 필요한 Plot2DChart 정의합니다
                   showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
            */
             +'<NumberFormatter id="numFmt1" precision="2"/>'
             +'<NumberFormatter id="numFmt2" precision="0" useThousandsSeparator="true"/>'
//             +'<Plot2DChart showDataTips="true" dataTipJsFunction="dataTipFunc">'
 				+'<Plot2DChart showDataTips="true">'
                 +'<verticalAxis>'
                    +'<LinearAxis id="vAxis" minimum="0" maximum="'+max+'" title="측정값"/>'
                   +'</verticalAxis>'
                   +'<horizontalAxis>'
                      +'<LinearAxis id="hAxis" title="SLOT"/>'
                  +'</horizontalAxis>'
                 +'<backgroundElements>'
                      +'<GridLines direction="both"/>'
                      
                      +'<AxisMarker>'
                      +'<ranges>'
                      +'<AxisRange startValue="'+lsl+'" endValue="'+usl+'" label="" labelHorizontalAlign="left">'
                      +'<fill>'
                      +'<SolidColor color="#eef3f6" />'
                   	  +'</fill>'
                      +'</AxisRange>'
                      
                      +'</ranges>'
                      +'</AxisMarker>'
                      
                 +'</backgroundElements>'
                 +'<series>'
                      +'<Plot2DSeries xField="gdp" yField="bigmac" labelPosition="up" upLabelField="country" upLabelYOffset="1" radius="6.5">'
                         +'<fill>'
                            +'<SolidColor color="#f9ad02"/>'
                         +'</fill>'
                       /* Plot2DChart 정의 후 Plot2DSeries labelPosition="inside"정의합니다 */
                        +'<showDataEffect>'
                          /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
                               +'<SeriesZoom relativeTo="series"/>'
                             /*
                                 SeriesZoom은 시리즈 데이터가 새로운 시리즈 데이터로 표시될 때 줌 효과를 적용합니다
                                - 공통속성 -
                                   elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
                                 minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
                                              이 값보다 짧은 시간에 effect가 실행되지 않습니다
                                offset : effect개시의 지연시간을 설정합니다 default:0
                                   perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
                                  - SeriesZoom속성 -
                                   horizontalFocus - center,left,right : 줌을 시작하는 수평의 초점을 정합니다 default:center
                                  verticalFocus - center,top,bottom : 줌을 시작하는 수직의 초점을 정합니다 default:center
                                relativeTo - chart,series : 줌의 초점을 위한 경계를 정합니다 default:chart
                               */
                         +'</showDataEffect>'
                     +'</Plot2DSeries>'
                   +'</series>'
                 +'<annotationElements>'
                      +'<CrossRangeZoomer zoomType="both"/>'
                   +'</annotationElements>'
             +'</Plot2DChart>'
        +'</rMateChart>';

}
//chart - 2
function makeLayout2(from_date, to_date, maximum) {

	layoutStr2 =
		'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
           +'<Options>'
              +'<Caption text="불량수량/합격수량 비교"/>'
                +'<SubCaption text="" textAlign="center" />'
              +'<Legend defaultMouseOverAction="false" />'
          +'</Options>'
         +'<Column3DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single">'
             +'<horizontalAxis>'
                   +'<CategoryAxis categoryField="cd"/>'
              +'</horizontalAxis>'
              +'<verticalAxis>'
                 +'<LinearAxis maximum="'+maximum+'"/>'
             +'</verticalAxis>'
                +'<series>'
                   +'<Column3DSeries labelPosition="outside" yField="data1" displayName="'+from_date+'">'
                        +'<showDataEffect>'
                           +'<SeriesInterpolate/>'
                       +'</showDataEffect>'
                  +'</Column3DSeries>'
                  +'<Column3DSeries labelPosition="outside" yField="data2" displayName="'+to_date+'">'
                        +'<showDataEffect>'
                           +'<SeriesInterpolate/>'
                       +'</showDataEffect>'
                  +'</Column3DSeries>'
              +'</series>'
          +'</Column3DChart>'
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
				
// 				$('#p_item_code').w2field('combo', {items: comboValue_cd, match : 'contains' })
// 				 .on('change', function () {
					 
// 		            $.each(comboValue, function(idx, row){
// 						var p_id = row.id;
// 						var p_text = row.text;
						
// 						if(p_id == $('#p_item_code').val())
// 						{
// 							$('#p_item_nm').w2field().set(p_text);
// 							getRtngInfo(p_id);
// 						}
// 					});
// 				 });
				
				
// 				$('#p_item_nm').w2field('combo', {items: comboValue_nm, match : 'contains' }).on('change', function () {
					 
// 		            $.each(comboValue, function(idx, row){
// 						var p_id = row.id;
// 						var p_text = row.text;
						
// 						if(p_text == $('#p_item_nm').val())
// 						{
// 							$('#p_item_code').w2field().set(p_id);	
// 							getRtngInfo(p_id);
// 						}
// 					});
// 				});
			}
		},complete: function () {
		}
	});
}

function load_matnr()
{
	var tmpArr = [];
	$.each(matnrRowArr, function(idx, row){
		var obj = Object();
		obj.recid = idx + 1;
		obj.item_code = row.item_code;
		obj.item_nm = row.item_nm;

		tmpArr.push(obj);
	});
	
	w2ui['grid_matnr'].records = tmpArr;
	w2ui['grid_matnr'].refresh();
	w2ui['grid_matnr'].unlock();	
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

				var insp_itm_arr = new Array;
				var rtng_arr = new Array;
				var rtng_code_arr = new Array;
				
				
				$.each(data.rows, function(idx, row){
					var obj = Object();
					obj.routing_code = row.routing_code;
					obj.routing_nm = row.routing_nm;

					rtng_arr.push(obj);
					
					insp_itm_arr.push(row.inspection_item);
					rtng_code_arr.push(row.routing_code);
				});
				
				var rtng_code_uniq_arr = _.uniqBy(rtng_code_arr);
				rtng_code_uniq_arr.sort();
				
				var insp_itm_uniq_arr = _.uniqBy(insp_itm_arr);
				insp_itm_uniq_arr.sort();
				
				console.log(rtng_code_uniq_arr);
				for(var i=0 ; i<rtng_code_uniq_arr.length; i++)
				{
					
					var obj = Object();
					obj.routing_code = rtng_code_uniq_arr[i];
					
					for(j=0 ; j<rtng_arr.length; j++)
					{
						if(obj.routing_code == rtng_arr[j].routing_code)
						{
							obj.routing_nm = rtng_arr[j].routing_nm;
						}
					}
					
					$('#s_rtng').append("<option value=" + obj.routing_code + ">" + obj.routing_nm + " ("+obj.routing_code + ")</option>");
				}

				for(var i=0 ; i<insp_itm_uniq_arr.length; i++)
				{
					$('#s_insp_item').append("<option value=" + insp_itm_uniq_arr[i] + ">" + insp_itm_uniq_arr[i] + "</option>");
				}	
			}
		},complete: function () {
			var a = $('#p_item_code').val();
			var b = $('#p_item_nm').val();
			var c = $('#s_rtng').val();
			var d = $('#s_insp_item').val();
			
			if(nullToBlank(a).length > 0 && nullToBlank(b).length > 0 && nullToBlank(c).length > 0 && nullToBlank(d).length > 0)
			{
				getQAnalData_1();
				getQAnalData_2();
			}
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
	var item_code = $('#p_item_code').val();
	var p_item_nm = $('#p_item_nm').val();
	var routing_code = $('#s_rtng').val();
	var inspection_item = $('#s_insp_item').val();
	

	
	var page_url = "/frontend/insp/getQAnalData_1";
	var postData = "m_year=" + encodeURIComponent(m_year);
	postData += "&item_code=" + encodeURIComponent(item_code);
	postData += "&p_item_nm=" + encodeURIComponent(p_item_nm);
	postData += "&routing_code=" + encodeURIComponent(routing_code);
	postData += "&inspection_item=" + encodeURIComponent(inspection_item);
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
				console.log(data.rows);
				$.each(data.rows, function(idx, row){
					var vals = new Object();
					if(row == null)
					{
						vals.cd =  $('#s_inspection_year').text();
						vals.data1 = 0;
						vals.data2 = 0;
						
						arr.push(vals);
						
						maximum =  100;
					} else {
						vals.cd =  $('#s_inspection_year').val();
						vals.data1 = (data.rows[idx].prod_menge == null)?0:data.rows[idx].prod_menge;
						vals.data2 = (data.rows[idx].ng_cnt == null)?0:data.rows[idx].ng_cnt;
						
						arr.push(vals);
						
						
						if(Number(vals.data1) >= Number(vals.data2))
						{
							maximum =  Math.ceil(vals.data1*1.1);						
						} else {
							maximum =  Math.ceil(vals.data2*1.1);	
						}	
					}
				});
				
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
	var item_code = $('#p_item_code').val();
	var p_item_nm = $('#p_item_nm').val();
	var routing_code = $('#s_rtng').val();
	var inspection_item = $('#s_insp_item').val();
	
	
	var page_url = "/frontend/insp/getQAnalData_2";
	var postData = "m_year=" + encodeURIComponent(m_year);
	postData += "&item_code=" + encodeURIComponent(item_code);
	postData += "&p_item_nm=" + encodeURIComponent(p_item_nm);
	postData += "&routing_code=" + encodeURIComponent(routing_code);
	postData += "&inspection_item=" + encodeURIComponent(inspection_item);
	FunLoadingBarStart();
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data:postData,
		success : function( data ) {
			if(data.status == 200) {
				var arr = new Array();
				var lsl = '';
				var usl = '';
				var max = 0;
				$.each(data.rows, function(idx, row){
					
					row.recid = idx + 1;
					
					if(idx == 0)
					{
						lsl = row.min_spec;
						usl = row.max_spec;
					}
					var vals = new Object();
					
 					//vals.country = (data.rows[idx].product_po == null)?0:data.rows[idx].product_po;
					vals.country = '';
					vals.gdp = (data.rows[idx].val_seq == null)?0:data.rows[idx].val_seq;
					vals.bigmac = (data.rows[idx].insp_val == null)?0:data.rows[idx].insp_val;
					
					if(vals.bigmac >= max)
					{
						max = vals.bigmac; 
					}
					
					arr.push(vals);
				
				});
				
				w2ui['grid_list'].records = data.rows;
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
				
				max =  Math.ceil(max*1.1);	
				if(max == 0)
					max = 1;
				makeLayout(max, lsl, usl);
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