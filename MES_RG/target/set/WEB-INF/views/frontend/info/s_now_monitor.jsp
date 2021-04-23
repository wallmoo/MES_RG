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
			<jsp:param name="selected_menu_cd" value="1058" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					생산 진행현황 모니터링 <small>생산관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 생산 진행현황
							모니터링</a></li>
					<li class="active">생산관리</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<section class="col-lg-12">
						<div class="box box-success box-solid"
							style="min-height: 90px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border"
								style="background-color: #DB8EB5;">
								<h3 class="box-title">생산계획 현황조회</h3>
								<div class="box-tools pull-right">
									<button type="button" id="btn_delete"
										class="btn btn-info btn-sm" onclick="requestInfo_modal();">실적상세보기</button>
									<button type="button" id="btn_search_csr" onclick="loadList();"
										class="btn btn-warning btn-sm">조회</button>
									<!-- loadList(); -->

								</div>
							</div>
							<div id="" class="box-body">
								<div class="row">

									<div class="col-sm-2">
										<div class="form-group">
											<label>P/N</label> <input type="text" id="item_code"
												name="item_code" placeholder="ex) P/N"
												class="form-control input-sm" maxlength="100"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>품명</label> <input type="text" id="item_nm"
												name="item_nm" placeholder="ex) 품명"
												class="form-control input-sm" maxlength="100"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
										</div>
									</div>



									<div class="col-sm-1">
										<div class="form-group" style="margin-bottom: 0px;">
											<label>진행상태</label>
											<div class="form-group" style="margin-bottom: 0px;">
												<select id="s_type" class="form-control select2 input-sm"
													data-placeholder="" style="width: 100%;"
													onchange="loadList()">
													<option value="">전체</option>
													<option value="n">대기중</option>
													<option value="i">진행중</option>
													<option value="e">진행완료</option>
												</select>
											</div>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>다음 공정</label> <input type="text" id="next_routing_nm"
												name="next_routing_nm" placeholder="ex) 다음공정"
												class="form-control input-sm" maxlength="100"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<div class="row">
												<label>※정렬기준</label>
											</div>
											<div class="row">
												<label> <input type="radio" id="rdo_status_type"
													name="rdo_status_type" class="flat-red form-control"
													value="PN" checked> P/N
												</label> <label> <input type="radio" id="rdo_status_type"
													name="rdo_status_type" class="flat-red form-control"
													value="lot"> LOT작업지시 번호
												</label>
											</div>
										</div>
									</div>
									<div class="box-tools pull-right">
										<div class="form-group" style="margin-top: 10px;">
											<div class=col-sm-12>
												<button type="button"
													style="border: 1px solid #9e9e9e; outline: 0; padding: 10px 20px 10px 20px; background-color: #ffd368;"
													disabled="disabled">
													<span>대기중</span>
												</button>
												<button type="button"
													style="border: 1px solid #9e9e9e; outline: 0; padding: 10px 20px 10px 20px; background-color: #73dd5e;"
													disabled="disabled">
													<span>진행중</span>
												</button>
												<button type="button"
													style="border: 1px solid #9e9e9e; outline: 0; padding: 10px 20px 10px 20px; background-color: #fb6763; color: #ffffff;"
													disabled="disabled">
													<span>진행완료</span>
												</button>
											</div>
										</div>
									</div>


								</div>
								<div id="row" style="position: relative; height: 600px;">

									<div id="grid_list2" style="height: 600px;"></div>

								</div>
							</div>
						</div>

					</section>
				</div>
			</section>

			<!-- /.content -->
		</div>


		<div class="modal fade" id="modal_info" data-backdrop="static">
			<div class="modal-dialog modal-md" style="width: 60%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_code_title">생산진행현황 상세보기</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<div class="row">
							<div class="col-md-12">
								<div id="modalGrid" style="width: 100%; height: 400px;"></div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
							<button type="button" id="" class="btn btn-default btn-sm"
								data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- modal2 end -->




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
		var startValue_combo = "";

		var gridSize = 30;

		comboValue_nm1 = new Array;
		comboValue_nm2 = new Array;
		comboValue_nm3 = new Array;
		$(function($) {

			fnLoadCommonOption();

			init_grid_list(initGridList_columns());
			init_grid_list2();

			loadList();

		})

		$(":radio[name='rdo_status_type']").on('ifChecked', function(event) {
			loadList();
		});

		//품명,품번 자동완성
		// $("#item_nm").change(_.debounce(function(event) {

		// 	var item_nm = $("#item_nm").val();
		// 	$(this).val(function(index, value) {
		// 		console.log('item_nm key_up : '+ value);

		// 		getItemInfo('nm',value);
		// 		return value
		// 	});

		// },400));

		// $("#item_code").change(

		// 		_.debounce(function(event) 
		// 		{

		// 			var item_code = $("#item_code").val();
		// 			$(this).val(function(index, value) {
		// 				console.log('item_code key_up : '+ value);

		// 				getItemInfo('cd',value);
		// 				return value
		// 			});

		// },400));

		// function getItemInfo(type, value)
		// {
		// 	console.log('getItemInfo() : ' + value);
		// 	var result = "";
		// 	if(type == 'cd')
		// 	{
		// 		$.each(rowArr, function(idx, row){

		// 			if(value == row.item_code)
		// 			{
		// 				console.log('row.item_nm : ' + row.item_nm);
		// 				result = row.item_nm;		
		// 				$("#item_nm").val(result);
		// 			}
		// 		});

		// 		if(result == ''){
		// 			$("#item_nm").val('');
		// 		}

		// 	}else if(type == 'nm')	
		// 	{

		// 		$.each(rowArr, function(idx, row){

		// 			if(value == row.item_nm)
		// 			{
		// 				console.log('row.item_code : ' + row.item_code);
		// 				result = row.item_code;
		// 				$("#item_code").val(result);
		// 			}
		// 		});
		// 		if(result == ''){
		// 			$("#item_code").val('');
		// 		}

		// 	}

		// 	loadList();

		// }

		// init component
		function fnLoadCommonOption() {
			console.log('fnLoadCommonOption()');

			$('input[type="radio"].flat-red').iCheck({
				checkboxClass : 'icheckbox_flat-green',
				radioClass : 'iradio_flat-green',
				handle : 'radio'
			});

			var minDate = getFormatDate(new Date());
			$('#macc_chndate, #m_delivery_day, #m_order_day').daterangepicker(
					{
						opens : 'right',
						singleDatePicker : true,
						locale : {
							format : 'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
							monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
									'7월', '8월', '9월', '10월', '11월', '12월' ],
							daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
							showMonthAfterYear : true,
							yearSuffix : '년',
							orientation : "top left"
						},
						startDate : moment(minDate)
					});

			$('#order_day, #c_prod_day').daterangepicker(
					{
						opens : 'right',
						locale : {
							format : 'YYYYMMDD',
							monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
									'7월', '8월', '9월', '10월', '11월', '12월' ],
							daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
							showMonthAfterYear : true,
							yearSuffix : '년'
						},
						endDate : '2020-08-31'
					});

			$("#m_order_price").keyup(function(event) {
				if (event.which >= 37 && event.which <= 40)
					return;
				$(this).val(function(index, value) {
					return value.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
		}

		//회사명 변경시 1개 이상 조회시 select box로 1개일시 input창
		$("#projectBox").change(function() {

			var val = $("#projectBox option:selected").val(); // text();

			console.log("val = " + val);

			if (val == "") {
				return;
			}

		});

		function init_grid_list() {
			var rowArr = [];

			$('#grid_list').w2grid({
				name : 'grid_list',
				show : {
					selectColumn : true,
					lineNumbers : true,
					footer : true
				},
				multiSelect : true,
				columns : [ {
					field : 'lot',
					caption : 'Lot 작업지시',
					size : '15%',
					style : 'text-align:center'
				}, {
					field : 'item_num',
					caption : 'P/N',
					size : '15%',
					style : 'text-align:center'
				}, {
					field : 'item_nm',
					caption : '품명',
					size : '10%',
					style : 'text-align:center'
				},

				{
					field : 'cnt_1',
					caption : '요청 예정 수량',
					size : '12%',
					style : 'text-align:center'
				}, {
					field : 'cnt_2',
					caption : '불량 발생 수량',
					size : '12%',
					style : 'text-align:center'
				}, {
					field : 'cnt_2',
					caption : '진행 수량',
					size : '10%',
					style : 'text-align:center'
				} ],

				records : [

				], //
				onReload : function(event) {
					//loadList();
				},
				onClick : function(event) {
				}
			});

		}
		function init_grid_list(colObj) {
			var rowArr = [];

			$('#grid_list2').w2grid({
				name : 'grid_list2',
				show : {
					selectColumn : false,
					lineNumbers : false,
					footer : true
				},
				multiSelect : false,
				columns : colObj,

				records : [

				], //
				onReload : function(event) {
					//loadList();
				},
				onClick : function(event) {
				}
			});

		}

		function initGridList_columns() {
			var colObj = [];
			colObj
					.push(
							{
								field : 'product_po',
								caption : 'Lot 작업지시',
								size : '120px',
								style : 'text-align:center',
								frozen : true,
								sortable : true
							},
							{
								field : 'item_code',
								caption : 'P/N',
								size : '120px',
								style : 'text-align:center',
								frozen : true,
								sortable : true
							},
							{
								field : 'item_nm',
								caption : '품명',
								size : '150px',
								style : 'text-align:center',
								frozen : true,
								sortable : true
							},

							{
								field : 'product_menge',
								caption : '요청 예정 수량',
								size : '100px',
								style : 'text-align:center',
								frozen : true,
								sortable : true
							},
							{
								field : 'prod_fail_menge',
								caption : '불량 발생 수량',
								size : '100px',
								style : 'text-align:center',
								frozen : true,
								sortable : true,
								render : function(record, index, col_index) {
									var html = this.getCellValue(index,
											col_index);

									if (html == null || html == 'null') {
										html = 0;
									}
									return html;
								}
							},

							{
								field : 'process_menge',
								caption : '진행 수량',
								size : '70px',
								style : 'text-align:center',
								frozen : true,
								sortable : true,
								render : function(record, index, col_index) {
									var html = this.getCellValue(index,
											col_index);

									var product_menge = w2ui.grid_list2.records[index].product_menge;
									var prod_fail_menge = w2ui.grid_list2.records[index].prod_fail_menge;

									if (prod_fail_menge == null
											|| prod_fail_menge == ''
											|| prod_fail_menge == 'null') {
										prod_fail_menge = 0;
									}
									var result = Number(product_menge)
											- Number(prod_fail_menge);
									return result;
								}

							}, {
								field : 'routing_code',
								caption : '현재진행공정',
								size : '120px',
								frozen : true,
								style : 'text-align:center',
								hidden : true
							}, {
								field : 'routing_nm',
								caption : '현재공정',
								size : '150px',
								frozen : true,
								style : 'text-align:center',
								hidden : false
							}, {
								field : 'next_routing_nm',
								caption : '다음공정',
								size : '120px',
								frozen : true,
								style : 'text-align:center',
								hidden : false
							}, {
								field : 'next_routing_code',
								caption : '다음공정',
								size : '120px',
								frozen : true,
								style : 'text-align:center',
								hidden : true
							}, {
								field : 'product_status_info',
								caption : '상태',
								size : '70px',
								frozen : true,
								style : 'text-align:center',
								hidden : true
							});

			for (var i = 1; i <= gridSize; i++) {

				colObj
						.push({
							field : 'c' + i,
							caption : '공정#' + i,
							size : '170px',
							attr : 'align=center',
							frozen : false,
							render : function(record, index, col_index) {
								var val = this.getCellValue(index, col_index);

								// 생산진행 상태 생산전 대기 n / 작업시작 i / 비가동시작 us / 비가동종료 ue / 작업종료 e / 생산종료 y
								/* w2ui.grid_list2.record[index].routing_nm */

								var routing_code = w2ui.grid_list2.records[index].routing_code;
								var routing_nm = w2ui.grid_list2.records[index].routing_nm;
								var statusData = w2ui.grid_list2.records[index].product_status_info;

								var next_routing_nm = w2ui.grid_list2.records[index].next_routing_nm;
								var next_routing_code = w2ui.grid_list2.records[index].next_routing_code;
								var current_routing_nm = val.split('[#]')[0];
								var current_routing_info = val.split('[#]')[1];
								var current_routing_code = val.split('[#]')[2];

								//val = val.replace('[#]',' ');

								if (current_routing_nm == null
										|| current_routing_nm == 'null') {
									current_routing_nm = '';
								}
								if (current_routing_info == null
										|| current_routing_info == 'null') {
									current_routing_info = '';
								}
								if (current_routing_code == null
										|| current_routing_code == 'null') {
									current_routing_code = '';
								}
								val = current_routing_nm + ' '
										+ current_routing_info;

								if (routing_code == current_routing_code) {
									//if(val.indexOf(routing_nm) != -1){

									//var 현재그리드상태값 = 그리드에서.product_status_info

									if (statusData == 'n') {

									} else if (statusData == 'i'
											|| statusData == 'us'
											|| statusData == 'ue') {
										val = '<div style="background-color:#73dd5e;">'
												+ val + '</div>';
									} else if (statusData == 'e'
											|| statusData == 'y') {
										val = '<div style="background-color:#fb6763; color:#ffffff;">'
												+ val + '</div>';
									} else if (statusData == 'h') {
										val = '<div style="background-color:#000000; color:#ffffff;">'
												+ val + '</div>';
									} else {

									}

								} else {
									if (next_routing_code == current_routing_code) {

										if (statusData == 'n'
												|| statusData == 'e'
												|| statusData == 'y') {
											val = '<div style="background-color:#ffd368;">'
													+ val + '</div>';
										}
									}

								}

								return val;

							}
						});
			}

			return colObj;
		}

		function init_grid_list2() {
			var rowArr = [];

			$('#modalGrid').w2grid({
				name : 'modalGrid',
				show : {
					selectColumn : false,
					lineNumbers : true,
					footer : true
				},
				multiSelect : false,
				columns : [ {
					field : 'routing_code',
					caption : '공정코드',
					size : '12%',
					style : 'text-align:center'
				}, {
					field : 'routing_nm',
					caption : '공정명',
					size : '20%',
					style : 'text-align:center'
				}, {
					field : 'routing_gubun',
					caption : '공정구분',
					size : '20%',
					style : 'text-align:center',
					hidden : true
				}, {
					field : 'machine_code',
					caption : '공정장비코드',
					size : '20%',
					style : 'text-align:center'
				}, {
					field : 'machine_nm',
					caption : '공정장비',
					size : '20%',
					style : 'text-align:center',
					hidden : false
				},

				{
					field : 'prod_menge',
					caption : '생산수량',
					size : '15%',
					style : 'text-align:center'
				}, {
					field : 'prod_fail_menge',
					caption : '불량수량',
					size : '15%',
					style : 'text-align:center'
				}, {
					field : 'status',
					caption : '상태',
					size : '15%',
					style : 'text-align:center',
					render : function(record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						if (html == 'n') {
							return '대기';
						} else if (html == 'i') {
							return '작업시작';
						} else if (html == 'us') {
							return '비가동시작';
						} else if (html == 'ue') {
							return '비가동종료';
						} else if (html == 'e') {
							return '작업종료';
						} else if (html == 'y') {
							return '생산종료';
						} else if (html == 'h') {
							return 'HOLD';
						}
						return html;
					}
				}, {
					field : 'member_nm',
					caption : '작업자',
					size : '10%',
					style : 'text-align:center',
					editable : {
						type : 'text'
					}
				}, {
					field : 'prod_str_time',
					caption : '시작',
					size : '15%',
					style : 'text-align:center'
				}, {
					field : 'prod_end_time',
					caption : '종료',
					size : '15%',
					style : 'text-align:center'
				}, {
					field : 'process_time',
					caption : '소요시간',
					size : '15%',
					style : 'text-align:center'
				}

				],

				records : [], //

				onChange : function(event) {
				},

				onReload : function(event) {
				},
				onClick : function(event) {
				}
			});

		}

		//-------------------------------------------------------------------------------------------------------------------

		// 실적 상세보기 팝업
		function requestInfo_modal() {
			var key = w2ui.grid_list2.getSelection();

			w2ui['modalGrid'].clear();
			w2ui['modalGrid'].refresh();
			setTimeout(function() {
				w2ui['modalGrid'].resize();
				w2ui['modalGrid'].refresh();

			}, 200);

			if (key.length == 1) {

				loadList2();

				$("#modal_info").modal('show');

			} else {
				fnMessageModalAlert("알림", "항목을 1개 선택하여야 합니다."); // Notification
			}

		}
		var routing_codesArr;
		var routing_nmsArr;
		// 왼쪽 리스트 조회
		function loadList() {

			console.log("loadList()");

			/* 
			 var order_day = $("#order_day").val();
			 order_day = order_day.replace(/-/gi, "");  */
			var item_nm = $("#item_nm").val();
			var item_code = $("#item_code").val();

			var flag = $(":radio[name='rdo_status_type']:checked").val();
			/* 
			if(routing_code == null)
			{
				routing_code = '';	
			} */
			var page_url = "/frontend/consumable/selectProductMonitoring";

			var correct_yn = $(":radio[name='m_correct_yn_yn']:checked").val();
			var product_status = $("#s_type").val();
			var next_routing_nm = $("#next_routing_nm").val();

			//w2ui['grid_list'].lock('loading...', false);
			var postData = "item_nm=" + encodeURIComponent(item_nm)
					+ "&item_code=" + encodeURIComponent(item_code)
					+ "&product_status=" + encodeURIComponent(product_status)
					+ "&next_routing_nm=" + encodeURIComponent(next_routing_nm)
					+ "&flag=" + encodeURIComponent(flag);

			//w2ui['grid_list'].lock('loading...', true);
			$
					.ajax({
						url : page_url,
						type : 'POST',
						data : postData,
						dataType : 'json',
						success : function(data) {
							if (data.status == 200 && (data.rows).length > 0) {
								rowArr = data.rows;

								$
										.each(
												rowArr,
												function(idx, row) {
													row.recid = idx + 1;

													if (row.machine_code != null
															&& row.machine_code != 'null'
															&& row.machine_code != '') {
														row.routing_nm = row.routing_nm
																+ ' ('
																+ row.machine_code
																+ ')';
													}
													var routing_codes = row.routing_codes;
													var routing_nms = row.routing_nms;
													var prod_menges = row.prod_menges;
													var prod_fail_menges = row.prod_fail_menges;
													/* [생산,생산_자주검사,품질,품질_자주검사,장비,장비_자주검사] */

													if (routing_nms != 'null'
															&& routing_nms != ''
															&& routing_nms != null) {

														var routing_nms = routing_nms
																.replace('Q,C',
																		'Q#C');
														routing_nmsArr = routing_nms
																.split(',');

														var prod_mengesArr = prod_menges
																.split(',');
														var prod_fail_mengesArr = prod_fail_menges
																.split(',');

														var routing_codes = routing_codes
																.replace('Q,C',
																		'Q#C');
														routing_codesArr = routing_codes
																.split(',');

														for (var i = 1; i <= gridSize; i++) {
															var valueName = 'c'
																	+ i;
															var prod_menge = prod_mengesArr[i - 1];
															var prod_fail_menge = prod_fail_mengesArr[i - 1];

															if (prod_menge == 'undefined'
																	|| prod_menge == undefined
																	|| prod_menge == 'null'
																	|| prod_menge == null
																	|| prod_menge == '') {
																prod_menge = 0;
															}
															if (prod_fail_menge == 'undefined'
																	|| prod_fail_menge == undefined
																	|| prod_fail_menge == 'null'
																	|| prod_fail_menge == null
																	|| prod_fail_menge == '') {
																prod_fail_menge = 0;
															}
															var menge_info = prod_menge
																	+ '/'
																	+ prod_fail_menge;

															row[valueName] = routing_nmsArr[i - 1];

															var current_routing_code = routing_codesArr[i - 1];
															console
																	.log('##current_routing_code : '
																			+ current_routing_code);
															if (row[valueName] != null) {
																row[valueName] = row[valueName]
																		.replace(
																				'Q#C',
																				'Q,C');
																row[valueName] = row[valueName]
																		+ '[#]('
																		+ menge_info
																		+ ')[#]'
																		+ current_routing_code;
															}

														}
													}

													if (row.item_code)
														comboValue_nm1
																.push(row.item_code);
													if (row.item_nm)
														comboValue_nm2
																.push(row.item_nm);
													if (row.next_routing_nm)
														comboValue_nm3
																.push(row.next_routing_nm);

													row.product_menge = Number(row.product_menge);
													row.prod_fail_menge = Number(row.prod_fail_menge);
													row.process_menge = Number(row.process_menge);

												});

								gridDataArr = rowArr;

								w2ui['grid_list2'].records = rowArr;

								if (startValue_combo == "") {
									$('#item_code').w2field('combo', {
										items : _.uniq(comboValue_nm1, false),
										match : 'contains'
									});
									$('#item_nm').w2field('combo', {
										items : _.uniq(comboValue_nm2, false),
										match : 'contains'
									});
									$('#next_routing_nm').w2field('combo', {
										items : _.uniq(comboValue_nm3, false),
										match : 'contains'
									});
								}

							} else {
								w2ui['grid_list2'].clear();
							}

							w2ui['grid_list2'].refresh();
							w2ui['grid_list2'].unlock();

							//changeGridUI(gridDataArr);

						},
						complete : function() {
							startValue_combo = ":)";
							document.getElementById("item_code").style
									.removeProperty("height");
							document.getElementById("item_nm").style
									.removeProperty("height");
							document.getElementById("next_routing_nm").style
									.removeProperty("height");
						}

					});

		}
		//모달 리스트 조회 
		function loadList2() {
			console.log("loadList2()");

			var key = w2ui.grid_list2.getSelection();
			var data = w2ui.grid_list2.get(key[0]);
			var product_po = data.product_po;

			var page_url = "/frontend/consumable/selectProductOperation";

			var postData = "product_po=" + encodeURIComponent(product_po);

			$.ajax({
				url : page_url,
				type : 'POST',
				data : postData,
				dataType : 'json',
				success : function(data) {
					if (data.status == 200 && (data.rows).length > 0) {
						rowArr = data.rows;

						$.each(rowArr, function(idx, row) {
							row.recid = idx + 1;

							var prod_menge = row.prod_menge;
							var prod_fail_menge = row.prod_fail_menge;
							if (prod_menge == 'undefined'
									|| prod_menge == undefined
									|| prod_menge == 'null'
									|| prod_menge == null || prod_menge == '') {
								prod_menge = 0;
							}
							if (prod_fail_menge == 'undefined'
									|| prod_fail_menge == undefined
									|| prod_fail_menge == 'null'
									|| prod_fail_menge == null
									|| prod_fail_menge == '') {
								prod_fail_menge = 0;
							}

							row.prod_menge = prod_menge;
							row.prod_fail_menge = prod_fail_menge;
						});

						gridDataArr = rowArr;

						w2ui['modalGrid'].records = rowArr;

					} else {
						w2ui['modalGrid'].clear();
					}

					w2ui['modalGrid'].refresh();
					w2ui['modalGrid'].unlock();

					//changeGridUI(gridDataArr);

				},
				complete : function() {

				}
			});
		}

		//-------------------------------------------------------------------------------------------------------------------

		//-------------------------------------------------------------------------------------------------------------------

		function getFormatDate(d) {
			var month = d.getMonth() + 1;
			var date = d.getDate();
			month = (month < 10) ? "0" + month : month;
			date = (date < 10) ? "0" + date : date;
			return d.getFullYear() + '-' + month + '-' + date;
		}

		//미 입력시
		function chkSubmit(item, msg) {
			if (item.val().replace(/\s/g, "") == "") {
				fnMessageModalAlert("알림", msg + " 입력해 주세요.");
				item.val("");
				item.focus();
				return false;
			} else {
				return true;
			}
		}

		function initOptions(obj) {
			$(obj).find('option').remove().end()
			//	    .append('<option value="All">-----</option>')
			.val();
		}
	</script>

</body>
</html>