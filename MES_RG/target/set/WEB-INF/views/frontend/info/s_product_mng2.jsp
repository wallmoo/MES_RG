<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title><%=pageTitle%></title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

<jsp:include page="/common/header_inc" flush="true">
	<jsp:param name="page_title" value="0" />
</jsp:include>

<style type="text/css">
.ichk_label {
	font-weight: unset;
	font-size: 12px;
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
					설비 생산분석 <small>생산관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 설비 생산분석</a></li>
					<li class="active">생산관리</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<section class="col-lg-12">
						<div class="box box-success box-solid"
							style="min-height: 90px; border-color: #DB8EB5;">
							<!-- Progress Bar 
				 	<div id="hiddenDivLoading" style="visibility:hidden">
					다중 코드 입력 창 iframe 
					    <iframe id="iframeLoading" frameborder="0" style="z-index:-1; position:absolute; visibility:hidden"></iframe>
 					        <div id='load_List'><img src='/img/loading.gif' /></div>
						
 					</div> -->
							<!-- Progress Bar -->

							<div class="box-header with-border"
								style="background-color: #DB8EB5;">
								<h3 class="box-title">설비 생산성 분석</h3>
								<div class="box-tools pull-right">
									<button type="button" id="btn_search_csr" onclick="loadList();"
										class="btn btn-warning btn-sm" onclick="">조회</button>
								</div>
							</div>
							<div id="" class="box-body">
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<label>조회기간</label>
											<div class="input-group">
												<input type="text" class="form-control pull-right input-sm"
													style="" id="order_day" placeholder="yyyymmdd~yyyymmdd">
												<div class="input-group-addon">
													<i class="fa fa-calendar"></i>
												</div>
											</div>
										</div>
									</div>

									<div class="col-sm-2" style="margin-top: 25px;">
										<div class="form-group">
											<label> <input type="radio" id="rdo_status_type"
												name="rdo_status_type" class="flat-red form-control"
												value="i" checked> 주간
											</label> <label> <input type="radio" id="rdo_status_type"
												name="rdo_status_type" class="flat-red form-control"
												value="u"> 월간
											</label>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>설비분류</label> <select id="pn" name="pn"
												class="form-control" style="height: 30px;">

											</select>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>설비명</label> <select id="machine_nm" name="machine_nm"
												class="form-control" style="height: 30px;">
												<option value="ALL" selected="selected">전체</option>
											</select>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>P/N</label> <input type="text" id="item_code"
												name="item_code" placeholder="ex) P/N"
												class="form-control input-sm" maxlength="40"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>품명</label> <input type="text" id="item_nm"
												name="item_nm" placeholder="ex) 품명"
												class="form-control input-sm" maxlength="40"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
										</div>
									</div>


								</div>

								<div class="row" style="margin-bottom: 10px; margin-top: 20px;">
									<div class="col-md-12 text-center">
										<div id="chartHolder"
											style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
									</div>
								</div>

								<div class="row">
									<div class="col-sm-12" style="margin-bottom: 15px;">
										<span>설비별 생산량 상세 요약</span>
									</div>
								</div>

								<div class="row">
									<div class="col-md-12">
										<div id="grid_list" style="width: 100%; height: 235px;"></div>
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
		var materialArr = new Array();
		comboValue_nm1 = new Array;
		comboValue_nm2 = new Array;

		$(function($) {
			fnLoadCommonOption();
			initGridList();
			timeCheck();
			fnCdD('pn', 'MC1021');
			loadList();
			slcMaterial();
		})

// 		//품명,품번 자동완성
// 		$("#item_nm").change(_.debounce(function(event) {

// 			var item_nm = $("#item_nm").val();
// 			$(this).val(function(index, value) {
// 				console.log('item_nm key_up : ' + value);

// 				getItemInfo('nm', value);
// 				return value
// 			});

// 		}, 400));

// 		$("#item_code").change(

// 		_.debounce(function(event) {

// 			var item_code = $("#item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('item_code key_up : ' + value);

// 				getItemInfo('cd', value);
// 				return value
// 			});

// 		}, 400));

// 		function getItemInfo(type, value) {
// 			console.log('getItemInfo() : ' + value);
// 			var result = "";
// 			if (type == 'cd') {
// 				$.each(materialArr, function(idx, row) {

// 					if (value == row.item_code) {
// 						console.log('row.item_nm : ' + row.item_nm);
// 						result = row.item_nm;
// 						$("#item_nm").val(result);
// 					}
// 				});

// 				if (result == '') {
// 					$("#item_nm").val('');
// 				}

// 			} else if (type == 'nm') {

// 				$.each(materialArr, function(idx, row) {

// 					if (value == row.item_nm) {
// 						console.log('row.item_code : ' + row.item_code);
// 						result = row.item_code;
// 						$("#item_code").val(result);
// 					}
// 				});
// 				if (result == '') {
// 					$("#item_code").val('');
// 				}
		

// 			}

// 		}
		var startValue_combo = "";
		function slcMaterial() {
			console.log("slcMaterial()");
			var item_nm =   $("#item_nm").val();
			var item_code =   $("#item_code").val();

			var page_url = "/info/product/selectS_product2";
			// 	var postData = "item_code=" + encodeURIComponent($("#item_code").val())
			// 	 + "&item_nm=" + encodeURIComponent($("#item_nm").val());
			var postData = "item_nm=" + encodeURIComponent(item_nm)
						 + "&item_code=" + encodeURIComponent(item_code);

			$.ajax({
				url : page_url,
				type : 'POST',
				// 		data : postData, 
				dataType : 'json',
				success : function(data) {
					if (data.status == 200 && (data.rows).length > 0) {
						rowArr = data.rows;
						
						$.each(rowArr, function(idx, row) {
							row.recid = idx + 1;
							if (startValue_combo == "") {
								materialArr = rowArr;
								comboValue_nm1.push(row.item_nm);
								comboValue_nm2.push(row.item_code);
							}
						});
						if (startValue_combo == "") {

							$('#item_nm').w2field('combo', {items : _.uniq(comboValue_nm1, false), match : 'contains'});
							$('#item_code').w2field('combo', {items : _.uniq(comboValue_nm2, false), match : 'contains'});

						}

					} else {

					}
				},
				complete : function() {
					startValue_combo = ":)";
					document.getElementById("item_code").style.removeProperty("height");
					document.getElementById("item_nm").style.removeProperty("height");
				}
			});
		}

		function fnLoadCommonOption() {
			console.log('fnLoadCommonOption()');

			$('input[type="radio"].flat-red').iCheck({
				checkboxClass : 'icheckbox_flat-green',
				radioClass : 'iradio_flat-green',
				handle : 'radio'
			});

			var minDate = getFormatDate(new Date());

			// 		 $('#order_day, #c_prod_day').daterangepicker({
			// 				opens: 'right',
			// 				locale: {
			// 					format : 'YYYYMMDD'	,
			// 					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
			// 							'7월', '8월', '9월', '10월', '11월', '12월' ],
			// 					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
			// 					showMonthAfterYear : true,
			// 					yearSuffix : '년'
			// 			    },
			// 		 	     endDate: '2020-08-31' 
			// 			}); 

			$("#m_order_price").keyup(function(event) {
				if (event.which >= 37 && event.which <= 40)
					return;
				$(this).val(function(index, value) {
					return value.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
		}

		function timeCheck() {
			// 		 $('#order_day').data('daterangepicker').remove();
			$('#order_day').daterangepicker(
					{
						opens : 'right',
						singleDatePicker : false,
						//					      timePicker: true,
						//					      timePicker24Hour:true,
						locale : {
							format : 'YYYYMMDD',
							monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
									'7월', '8월', '9월', '10월', '11월', '12월' ],
							daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
							showMonthAfterYear : true,
							yearSuffix : '년',
							orientation : "top left"
						},
						startDate : moment(
								[ moment().format('YYYY'),
										moment().format('MM') - 1,
										moment().format('DD'), 20, 30 ]).add(
								-7, 'days'),
						endDate : moment(
								[ moment().format('YYYY'),
										moment().format('MM') - 1,
										moment().format('DD'), 20, 30 ]).add(0,
								'days')
					}).focus(function() {
				$(".calendar-table").show();
			});

			$(':radio[name="rdo_status_type"]')
					.on(
							'ifChecked',
							function(event) {
								console
										.log("ssss = "
												+ $(
														":radio[name='rdo_status_type']:checked")
														.val());

								if ($(":radio[name='rdo_status_type']:checked")
										.val() == 'i') {

									$('#order_day').data('daterangepicker')
											.remove();
									$('#order_day')
											.daterangepicker(
													{
														opens : 'right',
														singleDatePicker : false,
														//						      timePicker: true,
														timePicker24Hour : true,
														locale : {
															format : 'YYYYMMDD',
															monthNames : [
																	'1월', '2월',
																	'3월', '4월',
																	'5월', '6월',
																	'7월', '8월',
																	'9월',
																	'10월',
																	'11월',
																	'12월' ],
															daysOfWeek : [ "일",
																	"월", "화",
																	"수", "목",
																	"금", "토" ],
															showMonthAfterYear : true,
															yearSuffix : '년',
															orientation : "top left"
														},
														startDate : moment(
																[
																		moment()
																				.format(
																						'YYYY'),
																		moment()
																				.format(
																						'MM') - 1,
																		moment()
																				.format(
																						'DD'),
																		08, 30 ])
																.add(-7, 'days'),
														endDate : moment(
																[
																		moment()
																				.format(
																						'YYYY'),
																		moment()
																				.format(
																						'MM') - 1,
																		moment()
																				.format(
																						'DD'),
																		20, 30 ])
																.add(0, 'days')
													}).focus(function() {
												$(".calendar-table").show();
											});

								} else if ($(
										":radio[name='rdo_status_type']:checked")
										.val() == 'u') {

									$('#order_day').data('daterangepicker')
											.remove();

									$('#order_day').daterangepicker(
											{

												opens : 'right',
												autoUpdateInput : true,
												singleDatePicker : true,
												locale : {
													format : 'YYYYMM',
													monthNames : [ '1월', '2월',
															'3월', '4월', '5월',
															'6월', '7월', '8월',
															'9월', '10월', '11월',
															'12월' ],
													daysOfWeek : [ "일", "월",
															"화", "수", "목", "금",
															"토" ],
													showMonthAfterYear : false,
													yearSuffix : '년',
													orientation : "top left"
												}
											});

								}

							});

		}

		/* $(":radio[name='rdo_status_type']").on('ifChecked', function(event){
		// 		  console.log("ssss = " + $(":radio[name='rdo_status_type']:checked").val());
		// 		  loadList();
			   var ss = $(':radio[name="rdo_status_type"]:checked').val();

		}); */

		function initGridList() {
			console.log('initGridList()');
			var rowArr = [];

			$('#grid_list').w2grid({
				name : 'grid_list',
				show : {
					selectColumn : false,
					lineNumbers : false,
					footer : true
				},
				multiSelect : false,
				columns : [
				// 				{ field:'c1', caption:'일자', size:'10%', style:'text-align:center'}, 
				// 				{ field:'c2', caption:'품명', size:'10%', style:'text-align:center'}, 
				// 				{ field:'c3', caption:'수량', size:'10%', style:'text-align:center'}, 
				// 				{ field:'c4', caption:'비율', size:'10%', style:'text-align:center' },
				// 				{ field:'c5', caption:'발주 수량', size:'10%', style:'text-align:center' }

				{
					field : 'dt',
					caption : '일자',
					size : '10%',
					sortable :true,
					style : 'text-align:center'
				}, {
					field : 'product_po',
					caption : '작업지시 번호',
					size : '16%',
					sortable :true,
					style : 'text-align:center'
				}, // 80px
				{
					field : 'item_code',
					caption : 'P/N',
					size : '10%',
					sortable :true,
					style : 'text-align:center'
				}, {
					field : 'item_nm',
					caption : '품명',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'order_menge',
					caption : '계획수량',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'routing_code',
					caption : '라우팅 코드',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'routing_seq',
					caption : '라우팅 순번',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'routing_nm',
					caption : '라우팅명',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'prod_end_time',
					caption : '실적시간',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'machine_code',
					caption : '설비코드',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'machine_nm',
					caption : '설비명',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'prod_menge',
					caption : '실적수량',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'prod_fail_menge',
					caption : '불량수량',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'prod_fail_f',
					caption : '불량율',
					sortable :true,
					size : '10%',
					style : 'text-align:center'
				} ],
				sortData : [ {
					field : 'pn',
					direction : 'ASC'
				} ],
				records : [], //
				onReload : function(event) {
					//loadList();
				},
				onClick : function(event) {
				}
			});
		}

		/* 	$("#order_day").change(function(){
		 console.log("11111");
		 loadList();
		 }); */

		$("#pn").change(function() {
			if ($("#pn option:selected").val() != 'ALL') {
				$("#machine_nm").attr('disabled', false);
				fnMachine();
			} else {
				$("#machine_nm").attr('disabled', true);
				$("#machine_nm option:eq(0)").prop("selected", true);
				loadList();
			}
			// 		loadList();
		});

		$("#machine_nm").change(function() {
			loadList();
		});

		function loadList() {
			console.log("loadList()");

			chartData = [];

			var order_day = $('#order_day').val();
			var machine_class_code = $("#pn option:selected").val(); // machine_class_code
			var machine_code = $("#machine_nm option:selected").val(); // machine_code

			var item_nm = $("#item_nm").val();
			var item_code = $("#item_code").val();

			var gb = "";

			console.log("machine_class_code = " + machine_class_code);
			console.log("machine_code = " + machine_code);

			console.log("item_nm = " + item_nm);
			console.log("item_code = " + item_code);

			var page_url = "/info/product/selectS_product2"; // "/info/machine/selectMachine";

			var postData = "item_nm=" + encodeURIComponent(item_nm);
			postData += "&item_code=" + encodeURIComponent(item_code);

			if ($(":radio[name='rdo_status_type']:checked").val() == 'i') {
				postData += "&gb=" + encodeURIComponent("i");
				postData += "&dt_i=" + encodeURIComponent(order_day);
				postData += "&dt_u=" + "";
			} else if ($(":radio[name='rdo_status_type']:checked").val() == 'u') {
				postData += "&gb=" + encodeURIComponent("u");
				postData += "&dt_i=" + "";
				postData += "&dt_u=" + encodeURIComponent(order_day);
			}

			if (machine_class_code == "ALL") {
				postData += "&machine_class_code=" + "";
				postData += "&machine_code=" + "";
			} else {
				if (machine_code == "ALL") {
					postData += "&machine_class_code="
							+ encodeURIComponent(machine_class_code); // where machin_code in (서브쿼리) +  으로
					postData += "&machine_code=" + "";
				} else {
					postData += "&machine_code="
							+ encodeURIComponent(machine_code);
					postData += "&machine_class_code=" + "";
				}
			}

			console.log(postData);

			//		w2ui['grid_list'].lock('loading...', true);
			w2ui['grid_list'].clear();

			$.ajax({
				url : page_url,
				type : 'POST',
				dataType : 'json',
				data : postData,
				success : function(data) {
					chartData = new Array();

					if (data.status == 200 && (data.rows).length > 0) {
						// 차트
						var chartData_object = new Object();

						rowArr = data.rows;
						$.each(rowArr, function(idx, row) {
							chartData_object = new Object();
							// 						row.recid = idx+1;
							chartData_object.prod_menge = row.sumPM;
							chartData_object.prod_fail_menge = row.sumPFM;
							chartData_object.Month = row.dt;

							chartData.push(chartData_object);
							
							
						});
					}

				},
				complete : function() {
					// 차트
					console.log("length = " + chartData.length);
					chartLength = chartData.length;
					makeLayout();
					fnLoadChart();

					// 				hidePreloader();
					checkData(chartData); // 데이터가 존재하는지 판별한다.

				}
			});

			/* chartData = [
			    			{ Month:"2020-06-11", su:"700"},
			    			{ Month:"2020-06-12", su:"800"},
			    			{ Month:"2020-06-13", su:"700"},
			    			{ Month:"2020-06-14", su:"750"},
			    			{ Month:"2020-06-15", su:"720"} 
						];	 */

			// 		chartLength = chartData.length;
			// 		makeLayout();
			// 		fnLoadChart();
			// 		// hidePreloader();
			// 		checkData(chartData); // 데이터가 존재하는지 판별한다.
		}

		// hasNoData(false); 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면
		// false로 주어 차트 전체의 visible을 false로 설정합니다.
		// hasNoData(true); 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어
		// visible을 true로 설정합니다.
		function checkData(data) {
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			if (data.length <= 0)
				document.getElementById("chart1").hasNoData(true);

		}

		// 차트 클릭하면 나타나는 이벤트, 여기에서 그리드 조회하게 타면됨.
		// PROPERTIES +
		// 이벤트
		// 클릭한 아이템 정보 보기
		function gridData(seriesId, displayText, index, data, values) {
			console.log("gridData()");

			console.log("seriesId??" + seriesId);
			console.log("displayText??" + displayText);
			console.log("index??" + index);
			console.log("data??");
			console.log(data);
			console.log("values??" + values);

			var order_day = values[0];
			var machine_class_code = $("#pn option:selected").val(); // machine_class_code
			var machine_code = $("#machine_nm option:selected").val(); // machine_code

			var item_nm = $("#item_nm").val();
			var item_code = $("#item_code").val();

			var page_url = "/info/product/selectS_product";

			if (displayText.indexOf('실적수량') != -1) {

				page_url = "/info/product/selectS_product";
			} else {
				page_url = "/info/product/selectS_product_fail";
			}

			var postData = "item_nm=" + encodeURIComponent(item_nm);
			postData += "&item_code=" + encodeURIComponent(item_code);

			if ($(":radio[name='rdo_status_type']:checked").val() == 'i') {
				postData += "&gb=" + encodeURIComponent("i");
				postData += "&dt=" + encodeURIComponent(order_day);
			} else if ($(":radio[name='rdo_status_type']:checked").val() == 'u') {
				postData += "&gb=" + encodeURIComponent("u");
				// 			postData += "&dt=" + $("#order_day").val();
				postData += "&dt=" + encodeURIComponent(order_day);
			}

			if (machine_class_code == "ALL") {
				postData += "&machine_class_code=" + "";
				postData += "&machine_code=" + "";
			} else {
				if (machine_code == "ALL") {
					postData += "&machine_class_code="
							+ encodeURIComponent(machine_class_code); // where machin_code in (서브쿼리) +  으로
					postData += "&machine_code=" + "";
				} else {
					postData += "&machine_code="
							+ encodeURIComponent(machine_code);
					postData += "&machine_class_code=" + "";
				}
			}

			w2ui['grid_list'].lock('loading...', true);
			w2ui['grid_list'].clear();
			
			var startValue_combo2 = "";
			comboValue_nm3 = new Array;
			comboValue_nm4 = new Array;

			$.ajax({
				url : page_url,
				type : 'POST',
				dataType : 'json',
				data : postData,
				success : function(data) {
					if (data.status == 200 && (data.rows).length > 0) {
						rowArr = data.rows;
						$.each(rowArr, function(idx, row) {
							row.recid = idx + 1;
							//row.prod_fail_f = row.prod_fail_f.substr(0, 6);
							
							if (startValue_combo2 == "") {
						
								gridDataArr = rowArr;
								
								comboValue_nm3.push(row.item_code);
								comboValue_nm4.push(row.item_nm);
		 					}
							

							row.order_menge = Number(row.order_menge);
							row.prod_menge = Number(row.prod_menge);
							row.prod_fail_menge = Number(row.prod_fail_menge);
							row.prod_fail_f = Number(row.prod_fail_f);
						});
						w2ui['grid_list'].records = rowArr;
					}
					if (startValue_combo2 == "") {
						$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
						$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
						
						
					}
					
				},
				complete : function() {
					w2ui['grid_list'].refresh();
					w2ui['grid_list'].unlock();
					
					startValue_combo2=":)";
					document.getElementById("item_code").style.removeProperty("height");
					document.getElementById("item_nm").style.removeProperty("height");
				}
			});

			/* chartData = new Array();
			
			chartData = [
				{recid:1, c1:"2020-06-11", c2:"Plate#1", c3:"40", c4:"30%"},
				{recid:2, c1:"2020-06-12", c2:"Plate#2", c3:"80", c4:"10%"}
			];
			
			w2ui['grid_list'].records = chartData;

			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock(); */

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

		function fnMachine() {
			console.log("fnMachine");
			initOptions($('#machine_nm')); // select 박스 초기화

			var strUrl = "/info/machine/selectMachine";
			var postData = "machine_class_code="
					+ encodeURIComponent($("#pn").val());

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

								$("#machine_nm").append(
										"<option value="+'ALL'+">" + "전체"
												+ "</option>");
								$.each(rowArr, function(idx, row) {
									$("#machine_nm").append(
											"<option value=" + row.machine_code + ">"
													+ '(' + row.machine_code
													+ ') ' + row.machine_nm
													+ "</option>");
								});

								$("#machine_nm option:eq(0)").prop("selected",
										true);
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

		function fnCdD(val, val2) {
			console.log("fnCdD(" + val + ")");

			//initOptions($('#'+val)); // select 박스 초기화

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

								$("#" + val).append("<option value="+'ALL'+">" + "전체"+ "</option>");

								$.each(rowArr, function(idx, row) {
									if (val == "pn") {
										$("#" + val).append(
												"<option value=" + row.detail_code + ">"
														+ row.code_nm
														+ "</option>");
									}
								});

								$("#" + val + " option:eq(0)").prop("selected",
										true);
								$("#machine_nm option:eq(0)").prop("selected",
										true);
								$("#machine_nm").attr("disabled", true);
							}

						},
						error : function(jqXHR, textStatus, errorThrown) {
							//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
						},
						complete : function() {
							// 		    	fnMachine();
						}
					});

		}
		//-------------------------------------------------------------------------------------------------------------------
		// 촤트

		// 차트 로딩 
		// 프리로더를 보이게 합니다.
		function showPreloader() {
			document.getElementById("chart1").showAdditionalPreloader();
		}

		// 프리로더를 제거합니다.
		function hidePreloader() {
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

		function makeLayout() {
			// 		var date = $("#order_day").val().substr(0, 4);

			layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+ '<Options>'
					// 					+'<Caption text="'+date+'년 일자별 생산량"/>'
					+ '<Caption text="일자별 MOVEMENT"/>'
					+ '<SubCaption text="-----------------------------" textAlign="center" />'
					+ '<Legend defaultMouseOverAction="false" />'
					+ '</Options>'
					+ '<Column3DChart showDataTips="true" itemClickJsFunction="gridData" columnWidthRatio="0.55" selectionMode="single">'
					+ '<horizontalAxis>'
					+ '<CategoryAxis categoryField="Month" />'
					+ '</horizontalAxis>'
					+ '<verticalAxis>'
					+ '<LinearAxis />'
					+ '</verticalAxis>'
					+ '<series>'

					+ '<Column3DSeries labelPosition="outside" yField="prod_menge" displayName="실적수량" >'
					+ '<fill>'
					+ '<SolidColor color="#5ddc96"/>'
					+ '</fill>'
					+ ' <showDataEffect>'
					+ ' <SeriesInterpolate/>'
					+ ' </showDataEffect>'
					+ ' </Column3DSeries>'

					+ '<Column3DSeries labelPosition="outside" yField="prod_fail_menge" displayName="불량수량" >'
					+ '<fill>'
					+ '<SolidColor color="#ffbf12"/>'
					+ '</fill>'
					+ ' <showDataEffect>'
					+ ' <SeriesInterpolate/>'
					+ ' </showDataEffect>' + ' </Column3DSeries>'

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

					+ '</series>' + '</Column3DChart>' + '</rMateChart>';

		}

		//-------------------------------------------------------------------------------------------------------------------

		function initOptions(obj) {
			$(obj).find('option').remove().end().val();
		}
	</script>

</body>
</html>