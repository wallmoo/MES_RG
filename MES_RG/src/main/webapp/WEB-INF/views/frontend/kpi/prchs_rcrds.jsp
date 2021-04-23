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
			<jsp:param name="selected_menu_p_cd" value="1013" />
			<jsp:param name="selected_menu_cd" value="1032" />
		</jsp:include>

		<link rel="stylesheet"
			href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
		<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
		<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					구매 실적 정보 <small>KPI Monitoring</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> KPI
							Monitoring</a></li>
					<li class="active">구매 실적 정보</li>
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
								<h3 class="box-title">조회조건</h3>
								<div class="box-tools pull-right">
									<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">액셀다운로드</button>
									<button type="button" id="btn_search_csr"
										onclick="loadAllList();" class="btn btn-warning btn-sm">조회</button>
								</div>
							</div>
							<div id="" class="box-body">
								<div class="row">

									<div class="col-sm-2">
										<div class="form-group">
											<label>연도</label> <select id="date" name="date"
												class="form-control" style="height: 30px;">
											</select>
										</div>
									</div>


									<div class="col-sm-2">
										<div class="form-group">
											<label>구분</label> <select id="gubun" name="gubun"
												class="form-control" style="height: 30px;">
												<option value="">발주</option>
												<option value="in">입고</option>
												<option value="no">미입고</option>
											</select>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>거래처</label> <select id="account_code"
												name="account_code" class="form-control"
												style="height: 30px;">
											</select>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>자재 유형</label> <select id="item_type_code"
												name="item_type_code" class="form-control"
												style="height: 30px;" onchange="fnAccount();">

											</select>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group" style="display: none;">
											<label>P/N</label> <input type="text" id="item_code"
												name="item_code" placeholder="ex) P/N"
												class="form-control input-sm"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group" style="display: none;">
											<label>품명</label> <input type="text" id="item_nm"
												name="item_nm" placeholder="ex) 품명"
												class="form-control input-sm"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" />
										</div>
									</div>


								</div>

								<div class="row" style="margin-bottom: 10px">

									<div class="col-md-12 text-center">
										<div id="chartHolder3"
											style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
									</div>

								</div>

								<div class="col-md-12" style="margin-bottom: 20px">

									<div id="grid_list3" style="width: 100%; height: 300px;"></div>

								</div>
								<div class="col-md-12">
									<div class="col-md-6"></div>
									<div class="col-md-6" style="margin-bottom:20px;">
			                           <button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload2();">액셀다운로드</button>
			                        </div>
								</div>
								<div class="col-md-6 text-center">
									<div id="chartHolder2"
										style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
								</div>

								
								<div class="row">
									
									<div class="col-md-6">
										<div id="grid_list" style="width: 100%; height: 350px;"></div>
										<div id="grid_list2"
											style="width: 100%; display: none; height: 60px;"></div>
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
		var chartLength = "";
		var chartData = new Array();
		var layoutStr2 = "";
		var chartLength2 = "";
		var chartData2 = new Array();
		var layoutStr3 = "";
		var chartLength3 = "";

		$(function($) {
			fnLoadCommonOption();

			var date = new Date();
			var currYear = date.getFullYear();

	         $("#date").append("<option value='"+(currYear-10)+"'>" + (currYear-10) + "</option>");
	         $("#date").append("<option value='"+(currYear-9)+"'>" + (currYear-9) + "</option>");
	         $("#date").append("<option value='"+(currYear-8)+"'>" + (currYear-8) + "</option>");
	         $("#date").append("<option value='"+(currYear-7)+"'>" + (currYear-7) + "</option>");
	         $("#date").append("<option value='"+(currYear-6)+"'>" + (currYear-6) + "</option>");
	         $("#date").append("<option value='"+(currYear-5)+"'>" + (currYear-5) + "</option>");
	         $("#date").append("<option value='"+(currYear-4)+"'>" + (currYear-4) + "</option>");
	         $("#date").append("<option value='"+(currYear-3)+"'>" + (currYear-3) + "</option>");
	         $("#date").append("<option value='"+(currYear-2)+"'>" + (currYear-2) + "</option>");
	         $("#date").append("<option value='"+(currYear-1)+"'>" + (currYear-1) + "</option>");
	         $("#date").append("<option value='"+(currYear)+"'>" + currYear + "</option>");
	         $("#date").append("<option value='"+(currYear+1)+"'>" + (currYear+1) + "</option>");

	 		
	 		 $("#date option:eq(10)").prop("selected", true);
			//$("#date").val(currYear).prop("selected", true);

			fnCdD('item_type_code', 'MC1014');

			initGridList();
			initGridList2();
			initGridList3();

			loadList();
			
			var recids = w2ui.grid_list.getSelection();
			
			w2ui['grid_list'].hideColumn(recids[0], 'in_menge');
			w2ui['grid_list'].hideColumn(recids[0], 'in_price');
			
			w2ui['grid_list'].hideColumn(recids[0], 'no_menge');
			w2ui['grid_list'].hideColumn(recids[0], 'no_price');
			

			loadList_graph();

			loadList_first();
		})

		function fnLoadCommonOption() {
			console.log('fnLoadCommonOption()');

			$('#request_date_range')
					.daterangepicker(
							{
								opens : 'right',
								locale : {
									format : 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
									monthNames : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									dayNames : [ '일', '월', '화', '수', '목', '금',
											'토' ],
									dayNames : [ '일', '월', '화', '수', '목', '금',
											'토' ],
									dayNamesShort : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									showMonthAfterYear : true,
									yearSuffix : '년',
									orientation : "top left"
								},
							});
		}

		function fnCdD(val, val2) {
			console.log("fnCdD(" + val + ")");

			initOptions($('#' + val)); // select 박스 초기화

			var strUrl = "/info/codeDetail/selectCdD";
			var postData = "master_code=" + encodeURIComponent(val2);

			$.ajax({
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
								$("#" + val).append("<option value="+''+">" + "전체"+ "</option>");

								$.each(rowArr, function(idx, row){

									$("#" + val).append("<option value=" + row.detail_code + ">"+ row.code_nm+ "</option>");
									
								});

									$("#" + val + " option:eq(0)").prop("selected",true);

							}

						},
						error : function(jqXHR, textStatus, errorThrown) {
							//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
						},

						complete : function() {

							fnAccount();
							requestItem();
						}
					});

		}

		//품명,품번 자동완성
		$("#item_nm").change(_.debounce(function(event) {

			var item_nm = $("#item_nm").val();
			$(this).val(function(index, value) {

				getItemInfo('nm', value);
				return value
			});

		}, 400));
		
		$("#item_code").change(

		_.debounce(function(event) {

			var item_code = $("#item_code").val();
			$(this).val(function(index, value) {
				console.log('item_code key_up : ' + value);

				getItemInfo('cd', value);
				return value
			});

		}, 400));

		var startValue_combo2 = "";
		var comboValue_nm_i = new Array();
		var comboValue_cd = new Array();

		var materialArr = new Array;

		function fnAccount() {

			initOptions($('#account_code')); // select 박스 초기화

			var strUrl = "/frontend/repair/selectPurchaseSearch";

			var item_type_code = $("#item_type_code").val();
			var item_code = $("#item_code").val();
			var item_nm = $("#item_nm").val();

			var postData = "item_type_code="
					+ encodeURIComponent(item_type_code) + "&item_code="
					+ encodeURIComponent(item_code) + "&item_nm="
					+ encodeURIComponent(item_nm);

			$.ajax({
						url : strUrl,
						type : "POST",
						data : postData,
						dataType : 'json',
						async : false, // 다 끝나고 다음 처리 해!
						success : function(data, textStatus, jqXHR) {
							//	 	    	console.log("(data.rows).length = " + (data.rows).length);
							if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
								rowArr = data.rows;
								$("#account_code").append(
										"<option value="+''+">" + "전체"
												+ "</option>");

								$.each(rowArr, function(idx, row) {

									$("#account_code").append(
											"<option value=" + row.account_code + ">"
													+ row.account_nm
													+ "</option>");
									row.recid = idx + 1;
									/* if (startValue_combo2 == "") {
										comboValue_nm_i.push(row.item_nm);
										comboValue_cd.push(row.item_code);
									} */
								});
								$("account_code option:eq(0)").prop("selected",
										true);

								/* if (startValue_combo2 == "") {
									
									$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm_i,false) ,match : 'contains' });				
									$('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
								} */
							}

						},
						error : function(jqXHR, textStatus, errorThrown) {
						},
						complete : function() {
							requestItem();
							//startValue_combo2 =")";
						}
					});

		}

		function requestItem() {

			console.log("requestItem 탓다");

			var strUrl = "/frontend/repair/selectPurchaseSearch";

			var item_type_code = $("#item_type_code").val();
			var account_code = $("#account_code").val();

			var postData = "item_type_code="
					+ encodeURIComponent(item_type_code) + "&account_code="
					+ encodeURIComponent(account_code);

			$.ajax({
				url : strUrl,
				type : 'POST',
				data : postData,
				data_type : 'json',
				success : function(data) {
					if (data.status == 200 && (data.rows).length > 0) {
						rowArr = data.rows;

						console.log("length ?? " + rowArr.length);
						console.log("comboValue_nm_i length ?? "
								+ comboValue_nm_i.length);
						materialArr = rowArr;
						$.each(rowArr, function(idx, row) {

							if (startValue_combo2 == "") {
								comboValue_nm_i.push(row.item_nm);
								comboValue_cd.push(row.item_code);
							}
						});

						console.log("comboValue_nm_i length ?? "
								+ comboValue_nm_i.length);
						if (startValue_combo2 == "") {

							$('#item_nm').w2field('combo', {
								items : _.uniq(comboValue_nm_i, false),
								match : 'contains'
							});
							$('#item_code').w2field('combo', {
								items : _.uniq(comboValue_cd, false),
								match : 'contains'
							});
						}
					} else {

					}

				},
				complete : function() {
					startValue_combo2 = ":)";

					document.getElementById("item_code").style
							.removeProperty("height");
					document.getElementById("item_nm").style
							.removeProperty("height");
				}
			});
		}

		function getItemInfo(type, value) {

			console.log('getItemInfo() : ' + value);
			var result = "";
			if (type == 'cd') {
				$.each(materialArr, function(idx, row) {

					if (value == row.item_code) {
						console.log('row.item_nm : ' + row.item_nm);
						result = row.item_nm;
						$("#item_nm").val(result);
					}
				});

				if (result == '') {
					$("#item_nm").val('');
				}

			} else if (type == 'nm') {

				$.each(materialArr, function(idx, row) {

					if (value == row.item_nm) {
						console.log('row.item_code : ' + row.item_code);
						result = row.item_code;
						$("#item_code").val(result);
					}
				});
				if (result == '') {
					$("#item_code").val('');
				}

			}

		}

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

				{
					field : 'account_code',caption : '거래처코드',size : '10%',style : 'text-align:center',hidden : true

				}, {
					field : 'account_nm',caption : '거래처ㄴㄴ명',size : '13%',style : 'text-align:center'

				},

				{
					field : 'item_code',caption : 'P/N',size : '13%',style : 'text-align:center'

				}, {
					field : 'item_nm',caption : '품명',size : '13%',style : 'text-align:center'

				}, {
					field : 'item_type_code',caption : '자재코드',size : '10%',style : 'text-align:center',hidden : true
				}, {
					field : 'item_type_nm',caption : '자재명',size : '10%',style : 'text-align:center',hidden : true
				}, {
					field : 'menge',caption : '발주수량',size : '8%',sortable :true,style : 'text-align:center',
					render : function(record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						html = w2utils.formatters['number'](html);
						html = setComma(html);
						return html;
					}
				}, {
					field : 'total_price',caption : '발주금액',sortable :true,size : '10%',style : 'text-align:center',
					render : function(record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						html = w2utils.formatters['number'](html);
						html = setComma(html);
						return html;
					}
				}, {
					field : 'in_menge',caption : '입고수량',sortable :true,size : '8%',style : 'text-align:center',
					render : function(record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						html = w2utils.formatters['number'](html);
						html = setComma(html);
						return html;
					}
				}, {
					field : 'in_price',caption : '입고금액',sortable :true,size : '10%',style : 'text-align:center',
					render : function(record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						html = w2utils.formatters['number'](html);
						html = setComma(html);
						return html;
					}
				}, {
					field : 'no_menge',caption : '미입고수량',sortable :true,size : '9%',style : 'text-align:center',
					render : function(record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						html = w2utils.formatters['number'](html);
						html = setComma(html);
						return html;
					}
				}, {
					field : 'no_price',caption : '미입고금액',sortable :true,size : '9%',style : 'text-align:center',
					render : function(record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						html = w2utils.formatters['number'](html);
						html = setComma(html);
						return html;
					}
				}

				],
				sortData : [ ],
				records : [], //
				onReload : function(event) {
					//loadList();
				},
				onClick : function(event) {
				}
			});
			loadList();

		}

		function loadAllList() {

			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			w2ui['grid_list'].clear();
			loadList();
			loadList_graph();
		}

		$("#item_type_code").change(function() {

			var item_type_code = $("#item_type_code").val();

			loadList();
			loadList_graph();
			loadList_first();

			fnAccount();
			requestItem();

		});

		// 	  $("#gubun").change(function(){
		//           var gubun = $("#gubun").val();

		// //           if(gubun == ''){

		// //         	  w2ui['grid_list'].removeColumn('recid', 'total_price');
		// //         	  w2ui['grid_list'].addColumn('no_price', { field: 'total_price', caption: '발주', size: '10%', sortable: true, attr: 'align=center', resizable: true ,
		// // 							            	  render: function (record, index, col_index) {
		// // 								                    	var val = this.getCellValue(index, col_index);
		// // 								                       return w2utils.formatNumber(Number(val));
		// // 							            	  		}

		// // 							                    });		

		// //           }else if(gubun == 'in'){

		// //         	  w2ui['grid_list'].removeColumn('recid', 'total_price');
		// //         	  w2ui['grid_list'].addColumn('no_price', { field: 'total_price', caption: '입고', size: '10%', sortable: true, attr: 'align=center', resizable: true ,
		// // 							            	  render: function (record, index, col_index) {
		// // 								                    	var val = this.getCellValue(index, col_index);
		// // 								                       return w2utils.formatNumber(Number(val));
		// // 							            	  		}

		// // 							                    });		

		// //           }else if(gubun == 'no'){

		// //         	  w2ui['grid_list'].removeColumn('recid', 'total_price');
		// //         	  w2ui['grid_list'].addColumn('no_price', { field: 'total_price', caption: '미입고', size: '10%', sortable: true, attr: 'align=center', resizable: true ,
		// // 							            	  render: function (record, index, col_index) {
		// // 								                    	var val = this.getCellValue(index, col_index);
		// // 								                       return w2utils.formatNumber(Number(val));
		// // 							            	  		}

		// // 							                    });	
		// //           }

		//           loadList();
		//           loadList_graph();

		//        });

		$("#gubun").change(function() {

			loadList_first();
			//loadList();
			loadList_graph();
			
			var gubun = $("#gubun").val();
			var recids = w2ui.grid_list.getSelection();
			
			w2ui['grid_list'].refresh();
		    w2ui['grid_list'].unlock();
		    w2ui['grid_list'].clear();
			
			if(gubun == ''){
				w2ui['grid_list'].hideColumn(recids[0], 'in_menge');
				w2ui['grid_list'].hideColumn(recids[0], 'in_price');
				
				w2ui['grid_list'].hideColumn(recids[0], 'no_menge');
				w2ui['grid_list'].hideColumn(recids[0], 'no_price');
				
				w2ui['grid_list'].showColumn(recids[0], 'total_price');
				w2ui['grid_list'].showColumn(recids[0], 'menge');
				
				
				loadList();
				
			}else if(gubun == 'in'){
				w2ui['grid_list'].showColumn(recids[0], 'in_menge');
				w2ui['grid_list'].showColumn(recids[0], 'in_price');
				
				w2ui['grid_list'].hideColumn(recids[0], 'no_menge');
				w2ui['grid_list'].hideColumn(recids[0], 'no_price');
				
				w2ui['grid_list'].hideColumn(recids[0], 'total_price');
				w2ui['grid_list'].hideColumn(recids[0], 'menge');
				
				loadList();
				
			}else if(gubun == 'no'){
				w2ui['grid_list'].hideColumn(recids[0], 'in_menge');
				w2ui['grid_list'].hideColumn(recids[0], 'in_price');
				
				w2ui['grid_list'].showColumn(recids[0], 'no_menge');
				w2ui['grid_list'].showColumn(recids[0], 'no_price');
				
				w2ui['grid_list'].hideColumn(recids[0], 'total_price');
				w2ui['grid_list'].hideColumn(recids[0], 'menge');
				
				loadList();
			}

		});
		$("#account_code").change(function() {
			//requestItem();

			var account_code = $("#account_code").val();

			loadList_first();
			loadList();
			loadList_graph();

			//requestItem();

		});

		$("#date").change(function() {
			loadList_first();
			loadList();
			loadList_graph();

		});

		function initGridList2() {
			console.log('initGridList()');
			var rowArr = [];

			$('#grid_list2').w2grid({
				name : 'grid_list2',
				show : {
					selectColumn : false,
					lineNumbers : false,
					footer : false
				},
				multiSelect : false,
				columns : [

				{
					field : '',
					caption : '',
					size : '10%',
					style : 'text-align:center',
					hidden : true
				}, {
					field : '',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				},

				{
					field : '',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				}, {
					field : '',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				}, {
					field : '',
					caption : '',
					size : '10%',
					style : 'text-align:center',
					hidden : true
				}, {
					field : '',
					caption : '',
					size : '10%',
					style : 'text-align:center',
					hidden : true
				}, {
					field : 'tot_menge',
					caption : '합계',
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'tot_total_price',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'tot_in_menge',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'tot_in_price',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'tot_no_menge',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				}, {
					field : 'tot_no_price',
					caption : '',
					size : '10%',
					style : 'text-align:center'
				}

				],
				sortData : [ {
					field : 'item_code',
					direction : 'ASC'
				} ],
				records : [], //
				onReload : function(event) {
					//loadList();
				},
				onClick : function(event) {
				}
			});
			w2ui['grid_list2'].add([ {
				recid : 'g1',
				tot_menge : '',
				tot_total_price : '',
				tot_in_menge : '',
				tot_in_price : '',
				tot_no_menge : '',
				tot_no_price : ''
			} ]);
		}

		function grid_list_tot() {

			setTimeout(function() {
				w2ui['grid_list2'].resize();
				w2ui['grid_list2'].refresh();

			}, 200);

			var rowArr3 = w2ui['grid_list'].records;

			var tot_menge = 0;
			var tot_total_price = 0;
			var tot_in_menge = 0;
			var tot_in_price = 0;
			var tot_no_menge = 0;
			var tot_no_price = 0;

			currentRecid = Number(i) + 1;

			console.log("lenght?????" + rowArr3.length);

			for (var i = 0; i < rowArr3.length; i++) {
				var data = rowArr3[i];

				tot_menge = tot_menge + parseInt(data.menge);
				tot_total_price = tot_total_price + parseInt(data.total_price);
				tot_in_menge = tot_in_menge + parseInt(data.in_menge);
				tot_in_price = tot_in_price + parseInt(data.in_price);
				tot_no_menge = tot_no_menge + parseInt(data.no_menge);
				tot_no_price = tot_no_price + parseInt(data.no_price);

			}

			tot_total_price = w2utils.formatters['number'](tot_total_price);
			tot_in_price = w2utils.formatters['number'](tot_in_price);
			tot_no_price = w2utils.formatters['number'](tot_no_price);

			w2ui['grid_list2'].set('g1', {
				tot_menge : tot_menge,
				tot_total_price : tot_total_price,
				tot_in_menge : tot_in_menge,
				tot_in_price : tot_in_price,
				tot_no_menge : tot_no_menge,
				tot_no_price : tot_no_price
			}
			);

		}

		function loadList() {
			console.log('loadList()');

			var year = $("#date option:selected").val();
			var item_code = $("#item_code").val();
			var item_nm = $("#item_nm").val();
			var item_type_code = $("#item_type_code").val();
			var account_code = $("#account_code").val();
			var gubun = $('#gubun').val();
			console.log("gubun:" + $('#gubun').val());
			var month = current_month;
			
			var page_url = "";
			
			if(gubun == ''){
				page_url = "/frontend/repair/selectPurchaseList_total";
			}else if(gubun == 'in'){
				page_url = "/frontend/repair/selectPurchaseList_in";
			}else if(gubun == 'no'){
				page_url = "/frontend/repair/selectPurchaseList_no";
			}
			

			var postData = "year=" + encodeURIComponent(year) + "&month="
					+ encodeURIComponent(month)  + "&item_code="
					+ encodeURIComponent(item_code) + "&item_type_code="
					+ encodeURIComponent(item_type_code) + "&account_code="
					+ encodeURIComponent(account_code) + "&item_nm="
					+ encodeURIComponent(item_nm);

			/* 		var postData = "item_code=" + encodeURIComponent(item_code)
			 + "&item_nm=" + encodeURIComponent(item_nm); */
			try {

				w2ui.grid_list.selectNone();
				//w2ui['grid_list'].lock('loading...', true);
			} catch (e) {

			}

			$.ajax({
				url : page_url,
				type : 'POST',
				data : postData,
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.status == 200 && (data.rows).length > 0) {
						rowArr = data.rows;
						console.log("탓따------------------------ : "
								+ rowArr.length);
						$.each(rowArr, function(idx, row) {
							row.recid = idx + 1;
							row.menge = Number(row.menge);
							row.total_price = Number(row.total_price);
						})

						w2ui['grid_list'].records = rowArr;

					} else {
						console.log("탓따------------------------");
						w2ui['grid_list'].clear();

					}
					w2ui['grid_list'].refresh();
					w2ui['grid_list'].unlock();

				},
				complete : function() {
					grid_list_tot();
				}
			});

		}

		function getAccountCode(account_nm) {
			console.log(' account_nm : ' + account_nm);
			console.log(' firstGrapArr.length : ' + firstGrapArr.length);
			var result = '';
			for (var i = 0; i < firstGrapArr.length; i++) {
				console.log('firstGrapArr account_nm : '
						+ firstGrapArr[i].account_nm);
				console.log(' account_nm : ' + account_nm);
				if (firstGrapArr[i].account_nm == account_nm) {

					result = firstGrapArr[i].account_code;
				}
			}
			return result;
		}

		function loadList_graph() {
			console.log("loadList_graph()");

			var grapArr = new Array();
			chartData2 = new Array();

			var year = $("#date option:selected").val();
			var item_code = $("#item_code").val();
			var item_nm = $("#item_nm").val();
			var item_type_code = $("#item_type_code").val();
			var account_code = $("#account_code").val();
			var gubun = $('#gubun').val();
			var month = current_month;
			
			var page_url = "";
			
			if(gubun == ''){
				page_url = "/frontend/repair/selectPurchaseGraph_total";
			}else if(gubun == 'in'){
				page_url = "/frontend/repair/selectPurchaseGraph_in";
			}else if(gubun == 'no'){
				page_url = "/frontend/repair/selectPurchaseGraph_no";
			}else{}

			var postData = "year=" + encodeURIComponent(year) 
					+ "&month="+ encodeURIComponent(month) 
					+ "&item_code="+ encodeURIComponent(item_code) 
					//+ "&gubun="+ encodeURIComponent(gubun) 
					+ "&item_type_code="+ encodeURIComponent(item_type_code) 
					+ "&account_code="+ encodeURIComponent(account_code) 
					+ "&item_nm="+ encodeURIComponent(item_nm);
			var result;

			$.ajax({
						url : page_url,
						type : 'POST',
						data : postData,
						dataType : 'json',
						success : function(data) {
							if (data.status == 200 && (data.rows).length > 0) {
								//console.table(data.rows);
								grapArr = new Array();

								chartData2 = new Array();

								result = data.rows;

								console.table(result);
								console.log('size : ' + result.length);
								console.log('result[0].year : '
										+ result[0].year);
								if (result.length == 1 && result[0].year == '') {
									var dddd = [];
									document.getElementById("chart2").setData(
											dddd);
									makeLayout2();
									fnLoadChart2(new Array());
									rMateChartH5.call("chart2", "hasNoData",
											true);
									return;
								}

								for (var i = 1; i <= 12; i++) {
									var grapObj = new Object();
									grapObj.month = i;
									grapObj.account_code = 0;
									grapObj.total_price = 0;
									grapObj.account_nm = 0;

									grapArr.push(grapObj);

								}

								setTimeout(
										function() {
											console.log('result');
											console.table(result);

											var max_total_price = 0;
											for (var i = 0; i < result.length; i++) {

												var grapObj = new Object();

												console
														.log(' result[i].total_price : '
																+ result[i].total_price);
												console
														.log(' result[i].account_code : '
																+ result[i].account_code);
												console
														.log(' result[i].account_nm : '
																+ result[i].account_nm);
												console
														.log(' result[i].in_price : '
																+ result[i].in_price);
												console
														.log(' result[i].no_price : '
																+ result[i].no_price);

												if ($('#gubun').val() == "") {
													grapObj.total_price = result[i].total_price;
													grapObj.account_code = result[i].account_code;
													grapObj.account_nm = result[i].account_nm;

													grapObj.in_price = result[i].in_price;
													grapObj.no_price = result[i].no_price;

													grapArr.push(grapObj);

												} else if ($('#gubun').val() == "in") {
													grapObj.total_price = result[i].in_price;
													grapObj.account_code = result[i].account_code;
													grapObj.account_nm = result[i].account_nm;

													grapObj.in_price = result[i].in_price;
													grapObj.no_price = result[i].no_price;

													grapArr.push(grapObj);
												} else if ($('#gubun').val() == "no") {
													grapObj.total_price = result[i].no_price;
													grapObj.account_code = result[i].account_code;
													grapObj.account_nm = result[i].account_nm;

													grapObj.in_price = result[i].in_price;
													grapObj.no_price = result[i].no_price;

													grapArr.push(grapObj);
												}

												if (Number(max_total_price) < Number(grapObj.total_price)) {
													max_total_price = grapObj.total_price;
												}

											}
											max_total_price = Number(max_total_price)
													+ (Number(max_total_price) / 3);

											/* chartData2 = [	
											             { 
											               account_nm:"하이닉스", account_code:"AA-1234",  total_price:"1900", in_price:"2000", no_price:"2300"},
											              {
											        	   account_nm:"하이닉스2", account_code:"E17908877",  total_price:"2400", in_price:"2000", no_price:"2300"},
											              {
											            	account_nm:"하이닉스3", account_code:"E17908866", total_price:"900", in_price:"2000", no_price:"2300"}   
														]; */
											// 						firstGrapArr = grapArr;
											chartData2 = grapArr;

											makeLayout2();

											fnLoadChart2();

											// 						checkData(chartData2); 

										}, 500);
								
			
								
								
							} else {
								console.log('check');

								var d = [];
								document.getElementById("chart2").setData(d);

								makeLayout2();
								fnLoadChart2(new Array());

								rMateChartH5.call("chart2", "hasNoData", true);

							}

						},
						complete : function() {

						}
					});

			// 		hidePreloader();
			//checkData(chartData); // 데이터가 존재하는지 판별한다.
		}

		// hasNoData(false); 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면
		// false로 주어 차트 전체의 visible을 false로 설정합니다.
		// hasNoData(true); 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어
		// visible을 true로 설정합니다.
		// 	function checkData(data){
		// 		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		// 		/* if(data.length <= 0)
		// 			document.getElementById("chart1").hasNoData(true);

		// 			document.getElementById("chart2").hasNoData(true); */

		// 	}
		// PROPERTIES +
		// 이벤트
		// 클릭한 아이템 정보 보기
		function gridData(seriesId, displayText, index, data, values) {
			console.log("gridData()");

			console.log("seriesId?? " + seriesId);
			console.log("displayText?? " + displayText);
			console.log("index?? " + index);
			console.log("values?? " + values);

			var account_nm = displayText.split(" :")[0];

			var account_code = data.account_code;

			console.log("account_code?? " + account_code);

			//로드합시당
			// 		loadList_graph_after(account_code);
			loadList_after(account_code);

		}

		var current_month = '';
		function gridData2(seriesId, displayText, index, data, values) {
			console.log("gridData2()");

			var valMonth = values[0];

			var month = valMonth.replace('월', "");
			current_month = month;
			console.log("current_month?" + current_month);

			//loadList_graph_after(month);
			loadList_graph();
			loadList();

		}

		function loadList_after(account_code) {
			console.log('loadList_after()');

			var year = $("#date option:selected").val();
			var item_code = $("#item_code").val();
			var item_nm = $("#item_nm").val();
			var gubun = $("#gubun").val();
			var item_type_code = $("#item_type_code").val();
			var month = current_month;
			
			var page_url = "";
			
			if(gubun == ''){
				page_url = "/frontend/repair/selectPurchaseList_total";
			}else if(gubun == 'in'){
				page_url = "/frontend/repair/selectPurchaseList_in";
			}else if(gubun == 'no'){
				page_url = "/frontend/repair/selectPurchaseList_no";
			}

			var postData = "year=" + encodeURIComponent(year) + "&month="
					+ encodeURIComponent(month) + "&item_code="
					+ encodeURIComponent(item_code) + "&item_type_code="
					+ encodeURIComponent(item_type_code) + "&account_code="
					+ encodeURIComponent(account_code) + "&item_nm="
					+ encodeURIComponent(item_nm);

			w2ui['grid_list'].lock('loading...', true);
			w2ui['grid_list'].clear();

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
							row.menge = Number(row.menge);
							row.total_price = Number(row.total_price);
							
						});
						w2ui['grid_list'].records = rowArr;
					} else {
						w2ui['grid_list'].clear();

					}
				},
				complete : function() {
					w2ui['grid_list'].refresh();
					w2ui['grid_list'].unlock();

					grid_list_tot();

				}
			});

		}
		
		function loadList_graph_after(account_code) {
			console.log("loadList_graph_after()");

			grapArr = new Array();

			var year = $("#date option:selected").val();
			var item_code = $("#item_code").val();
			var item_nm = $("#item_nm").val();
			var gubun = $("#gubun").val();

			var month = current_month;

			var item_type_code = $("#item_type_code").val();

			var page_url = "";
			
			if(gubun == ''){
				page_url = "/frontend/repair/selectPurchaseGraph_total";
			}else if(gubun == 'in'){
				page_url = "/frontend/repair/selectPurchaseGraph_in";
			}else if(gubun == 'no'){
				page_url = "/frontend/repair/selectPurchaseGraph_no";
			}else{}

			var postData = "year=" + encodeURIComponent(year) + "&item_code="
					+ encodeURIComponent(item_code) + "&month="
					+ encodeURIComponent(month) + "&item_type_code="
					+ encodeURIComponent(item_type_code) + "&account_code="
					+ encodeURIComponent(account_code) + "&item_nm="
					+ encodeURIComponent(item_nm);

			var result;

			$
					.ajax({
						url : page_url,
						type : 'POST',
						data : postData,
						dataType : 'json',
						success : function(data) {
							if (data.status == 200 && (data.rows).length > 0) {
								//console.table(data.rows);
								result = data.rows;

								console.table(result);

								for (var i = 1; i <= 12; i++) {
									var grapObj = new Object();
									grapObj.month = i;
									grapObj.account_code = 0;
									grapObj.total_price = 0;
									grapObj.account_nm = 0;

									grapArr.push(grapObj);

								}
								
								setTimeout(
										function() {
											console.log('result');
											console.table(result);

											var max_total_price = 0;
											for (var i = 0; i < result.length; i++) {

												var grapObj = new Object();

												console
														.log(' result[i].total_price : '
																+ result[i].total_price);
												console
														.log(' result[i].account_code : '
																+ result[i].account_code);
												console
														.log(' result[i].account_nm : '
																+ result[i].account_nm);
												console
														.log(' result[i].in_price : '
																+ result[i].in_price);
												console
														.log(' result[i].no_price : '
																+ result[i].no_price);
												grapObj.total_price = result[i].total_price;
												grapObj.account_code = result[i].account_code;
												grapObj.account_nm = result[i].account_nm;

												grapObj.in_price = result[i].in_price;
												grapObj.no_price = result[i].no_price;

												grapArr.push(grapObj);

												if (Number(max_total_price) < Number(grapObj.total_price)) {
													max_total_price = grapObj.total_price;
												}

											}
											max_total_price = Number(max_total_price)
													+ (Number(max_total_price) / 3);
											/* chartData2 = [	
											             { 
											               account_nm:"하이닉스", account_code:"AA-1234",  total_price:"1900", in_price:"2000", no_price:"2300"},
											              {
											        	   account_nm:"하이닉스2", account_code:"E17908877",  total_price:"2400", in_price:"2000", no_price:"2300"},
											              {
											            	account_nm:"하이닉스3", account_code:"E17908866", total_price:"900", in_price:"2000", no_price:"2300"}   
														]; */

											chartData2 = grapArr;

											console.log(chartLength);

											// 						checkData(chartData2); 

											makeLayout2();
											fnLoadChart2();

										}, 500);
							} else {
								var d = [];
								document.getElementById("chart2").setData(d);
								makeLayout2();
								fnLoadChart2(new Array());
								rMateChartH5.call("chart2", "hasNoData", true);

							}

						},
						complete : function() {

						}
					});

			// 		checkData(chartData); // 데이터가 존재하는지 판별한다.
		}

		$("#gubun").change(function() {
			loadList();
			loadList_graph();
		});

		//성민

		// 첫 그리드
		function initGridList3() {
			console.log('initGridList3()');
			var rowArr = [];

			// project_manager
			$('#grid_list3').w2grid({
				name : 'grid_list3',
				show : {
					footer : true
				}, // , selectColumn: true
				columnGroups : [
				/*  { caption: '생산지시번호', master: true },
				 { caption: '주야', span: 1  } */
				],
				multiSelect : false,
				columns : [
				//33

				{
					field : 'recid',
					caption : 'No',
					size : '70px',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					hidden : true
				}, {
					field : 'gb',
					caption : '구분',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true
				}, {
					field : 'c1',
					caption : '1월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c2',
					caption : '2월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c3',
					caption : '3월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c4',
					caption : '4월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c5',
					caption : '5월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c6',
					caption : '6월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, //v
				{
					field : 'c7',
					caption : '7월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c8',
					caption : '8월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c9',
					caption : '9월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c10',
					caption : '10월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c11',
					caption : '11월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				}, {
					field : 'c12',
					caption : '12월',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				},

				{
					field : 'p',
					caption : '합계',
					size : '10%',
					sortable : true,
					attr : 'align=center',
					resizable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (record.gb != '달성률(%)') {
							return w2utils.formatNumber(Number(val));
						} else {
							return val + '%';
						}
					}
				} ],
				sortData : [],
				total : 0,
				recordHeight : 30,
				onReload : function(event) {
				},
				onClick : function(event) {
				},
				onDblClick : function(event) {
				}
			});

			// 차트 값 넣기
			loadList_first();

		}

		//----------------------------------------------------------------------
		var grapArr = new Array();

		var listArr = new Array();

		//       function loadList_first(){
		// 			console.log("loadList_first()");

		// 			chartData = [
		// 			             {recid: 1, 
		// 			              gb:"수량", c1:"300", c2:"500", c3:"250", c4:"330", c5:"40", 
		// 			              c6:"110", c7:"252", c8:"21", c9:"57", c10:"89", c11:"500", c12:"210", p:"2659"},
		// 			              {recid: 2, 
		// 				          gb:"시간", c1:"3", c2:"12", c3:"24", c4:"3", c5:"6", 
		// 				          c6:"10", c7:"9", c8:"2", c9:"10", c10:"7", c11:"2", c12:"1", p:"89"},
		// 			];

		// 			w2ui['grid_list3'].records = chartData;

		// 			w2ui['grid_list3'].refresh();
		// 			w2ui['grid_list3'].unlock();

		// 			chartData = new Array();

		// 			for(var i = 1; i <=12; i ++)
		// 			{
		// 				var grapObj = new Object();
		// 				grapObj.month = i + "월";

		// 				grapObj.su = w2ui.grid_list3.get(1)['c'+i];
		// 				grapObj.time = w2ui.grid_list3.get(2)['c'+i];

		// 				chartData.push(grapObj);
		// 			}

		// 			chartLength = chartData.length;
		// 			console.log("chartLength = " + chartLength);
		// 			console.log("chartData");
		// 			console.log( chartData );

		// 			makeLayout3();
		// 			fnLoadChart();
		// 	 }
		
		var max_total_price = 0;
		var max_total_price2 = 0;
		
		var max_total_price3 = 0;
	    var max_total_price4 = 0;
	    var prev_no_sum = 0;
	    var origin_prev_no_sum = 0;

		function loadList_first() {
			console.log("loadList_first()");

			w2ui['grid_list3'].clear();

			chartData = new Array();

			var account_code = $("#account_code").val();
			var item_type_code = $("#item_type_code").val();
			var year = $("#date").val();
			
			var gubun = $("#gubun").val();
			
			var page_url = "";
			
			if(gubun == "in"){
				page_url = "/frontend/repair/purchaseGrid_in";
			}else{
				page_url = "/frontend/repair/purchaseGrid";
			}


			var postData = "account_code=" + encodeURIComponent(account_code)
					+ "&item_type_code=" + encodeURIComponent(item_type_code)
					+ "&year=" + encodeURIComponent(year);

			var resultData;

			$.ajax({
						url : page_url,
						type : 'POST',
						data : postData,
						dataType : 'json',
						success : function(data) {
							if (data.status == 200 && (data.rows).length > 0) {

								resultData = data.rows;
								grapArr = new Array();

								for (var i = 1; i <= 12; i++) {
									var grapObj = new Object();
									grapObj.month = i + "월";
									grapObj.total_price = 0;
									grapObj.in_price = 0;
									grapObj.no_price = 0;
									grapObj.goal = 0;
									grapObj.sum_price_acc = 0;
									grapObj.goal_acc = 0;

									grapArr.push(grapObj);

								}

								var hap1 = 0;
								var hap2 = 0;

								var hap3 = 0;
								var hap4 = 0;

								var hap5 = 0;
								var hap6 = 0;

								max_total_price = 0;
								max_total_price2 = 0;
								
								max_total_price3 = 0;
				                   max_total_price4 = 0;

								for (var i = 0; i < resultData.length; i++) {

									console.log("i????????" + i);
									var grapObj = new Object();
									var month = resultData[i].month;

									console.log("resultData[i].total_price ?"
											+ resultData[i].total_price);
									console.log("resultData[i].goal ?"
											+ resultData[i].goal);

									//-----------------------------------------------------------

									//-----------------------------------------------------------
									grapObj.month = resultData[i].month + "월";
									grapObj.total_price = resultData[i].total_price;
									grapObj.in_price = resultData[i].in_price;
									grapObj.no_price = resultData[i].no_price;
									grapObj.prev_no_price = resultData[i].prev_no_price;
									console.log("grapObj.no_price::"+resultData[i].no_price)
									console.log("grapObj.prev_no_price::"+resultData[i].prev_no_price)
									grapObj.goal = resultData[i].goal;

									grapArr[Number(month) - 1] = grapObj;

									hap1 = Number(hap1)
											+ Number(resultData[i].total_price);
									hap2 = Number(hap2)
											+ Number(resultData[i].goal);
									hap5 = Number(hap5)
											+ Number(resultData[i].in_price);
									hap6 = Number(hap6)
											+ Number(resultData[i].no_price);

									//누적 합계
									hap3 = Number(hap3)
											+ Number(resultData[i].sum_price_acc);
									hap4 = Number(hap4)
											+ Number(resultData[i].goal_acc);

								}

								//누적합계 그래프에 추가
								for (var i = 0; i < grapArr.length; i++) {
									var grapObj = grapArr[i];

									if (i == 0) {
										grapObj.sum_price_acc = grapArr[i].total_price;
										grapObj.test = grapArr[i].total_price;
										grapObj.goal_acc = grapArr[i].goal;
									} else {
										grapObj.sum_price_acc = Number(grapArr[i].total_price)
												+ Number(grapArr[i - 1].sum_price_acc);
										grapObj.test = Number(grapArr[i].total_price)
												+ Number(grapArr[i - 1].test);
										grapObj.goal_acc = Number(grapArr[i].goal)
												+ Number(grapArr[i - 1].goal_acc);
									}

									grapArr[i] = grapObj;
								}

								chartData = grapArr;
								//입고누적합계 그래프
								for (var i = 0; i < grapArr.length; i++) {
									var grapObj = grapArr[i];

									if (i == 0) {
										grapObj.sum_in_price_acc = grapArr[i].in_price;
									} else {
										grapObj.sum_in_price_acc = Number(grapArr[i].in_price) + Number(grapArr[i - 1].sum_in_price_acc);
									}

									grapArr[i] = grapObj;
								}

								chartData = grapArr;

								//미입고누적합계 그래프
								for (var i = 0; i < grapArr.length; i++) {
									var grapObj = grapArr[i];

									if (i == 0) {
										console.log("grapArr[i].prev_no_price::"+ grapArr[i].prev_no_price)
										grapObj.sum_no_price_acc = Number(grapArr[i].no_price) + Number(grapArr[i].prev_no_price);
									} else {
										grapObj.sum_no_price_acc = Number(grapArr[i].no_price) + Number(grapArr[i - 1].sum_no_price_acc);
									}
									prev_no_sum = Number(grapObj.sum_no_price_acc) + Number(grapObj.sum_no_price_acc)/10;
									origin_prev_no_sum = Number(grapObj.sum_no_price_acc);
									grapArr[i] = grapObj;
								}

								chartData = grapArr;


								//그리드 값 추가
								var listArr = [ {}, {}, {}, {}, {}, {}, {} ,{}];

								for (var i = 0; i < 8; i++) {
									listArr[i].recid = Number(i) + 1;

									if (i == 0) {
										listArr[i].gb = '목표금액(원)';
										for (var j = 0; j < grapArr.length; j++) {

											listArr[i]['c' + (Number(j) + 1)] = grapArr[j].goal;

											if (grapArr[j].goal == 0
													|| grapArr[j].goal == null
													|| grapArr[j].goal == 'NaN'
													|| grapArr[j].goal == "undefined") {
												grapArr[j].goal = 0;
											}

											console.log("listArr[1]??"
													+ listArr[i]['c'
															+ (Number(j) + 1)]);

// 											if (Number(max_total_price2) < Number(grapArr[j].total_price)) {
// 												max_total_price2 = grapArr[j].total_price;
// 											}

										}
										listArr[i].p = hap2;

									} else if (i == 1) {

										listArr[i].gb = '발주 금액(원)';
										for (var j = 0; j < grapArr.length; j++) {
											var gb1 = listArr[i]['c'
													+ (Number(j) + 1)]
											listArr[i]['c' + (Number(j) + 1)] = grapArr[j].total_price;

											console.log("listArr[0]??"
													+ listArr[i]['c'
															+ (Number(j) + 1)]);

// 											if (Number(max_total_price) < Number(grapArr[j].goal)) {
// 												max_total_price = grapArr[j].goal;
// 											}
										}
										listArr[i].p = hap1;

									} else if (i == 2) {

										listArr[i].gb = '입고 금액(원)';
										for (var j = 0; j < grapArr.length; j++) {
											var gb1 = listArr[i]['c'
													+ (Number(j) + 1)]
											listArr[i]['c' + (Number(j) + 1)] = grapArr[j].in_price;

										}
										listArr[i].p = hap5;
										
										if(Number(max_total_price3) < Number(listArr[i].p)){
											max_total_price3 = listArr[i].p ;
			        					}

									} else if (i == 3) {

										listArr[i].gb = '미입고 금액(원)';
										for (var j = 0; j < grapArr.length; j++) {
											var gb1 = listArr[i]['c'
													+ (Number(j) + 1)]
											listArr[i]['c' + (Number(j) + 1)] = grapArr[j].no_price;

										}
										listArr[i].p = hap6;
										if(Number(max_total_price4) < Number(listArr[i].p)){
											max_total_price4 = listArr[i].p ;
			        					}

									} else if (i == 4) {
										listArr[i].gb = '달성률(%)';
										for (var j = 0; j < grapArr.length; j++) {
											var per = (Number(grapArr[j].total_price) / Number(grapArr[j].goal)) * 100;
											listArr[i]['c' + (Number(j) + 1)] = per
													.toFixed(2);

											if (listArr[i]['c'
													+ (Number(j) + 1)] == 0
													|| listArr[i]['c'
															+ (Number(j) + 1)] == null
													|| listArr[i]['c'
															+ (Number(j) + 1)] == 'NaN'
													|| listArr[i]['c'
															+ (Number(j) + 1)] == "undefined") {
												listArr[i]['c'
														+ (Number(j) + 1)] = 0;
											}

											if (Number(grapArr[j].goal) == 0) {
												listArr[i]['c'
														+ (Number(j) + 1)] = 0;
											}
										}
										
										var hap ;
				  	               		if(hap2 == 0){
				  	               			hap3 = 0;
				  	               		listArr[i].p = hap3.toFixed(0);
				  	               		}else{
				  	               			hap3 = (Number(hap1) / Number(hap2)) * 100;
				  	               			listArr[i].p = hap3.toFixed(2);
				  	               		}

// 										var hap3 = (Number(hap1) / Number(hap2)) * 100;
// 										listArr[i].p = hap3.toFixed(2);

									} else if (i == 5) {
										listArr[i].gb = '누적목표금액(원)';

										console.log('CHECK grapArr.length '
												+ grapArr.length);

										for (var j = 0; j < grapArr.length; j++) {

											if (j == 0) {
												listArr[i]['c'+ (Number(j) + 1)] = Number(listArr[0]['c'+ (Number(j) + 1)]);
											} else {
												listArr[i]['c'+ (Number(j) + 1)] = Number(listArr[0]['c'+ (Number(j) + 1)])+ Number(listArr[i]['c'+ j]);
											}

											//합계	  

											listArr[i].p = Number(listArr[0]['c'+ (Number(j) + 1)])+ Number(listArr[i]['c' + j]);
											
											if(Number(max_total_price2) < Number(listArr[i].p)){
				                          		max_total_price2 = listArr[i].p ;
				        					}

										}

									} else if (i == 6) {
										listArr[i].gb = '누적 발주금액(원)';

										for (var j = 0; j < grapArr.length; j++) {

											if (j == 0) {
												listArr[i]['c'+ (Number(j) + 1)] = Number(listArr[1]['c'+ (Number(j) + 1)]);
											} else {
												listArr[i]['c'+ (Number(j) + 1)] = Number(listArr[1]['c'+ (Number(j) + 1)])+ Number(listArr[i]['c'+ j]);
											}
											listArr[i].p = Number(listArr[1]['c'+ (Number(j) + 1)])+ Number(listArr[i]['c' + j]);
											
											if(Number(max_total_price2) < Number(listArr[i].p)){
				                          		max_total_price2 = listArr[i].p ;
				        					}
										}
									} else if (i == 7) {
										listArr[i].gb = '누적 미입고금액(원)';
										for (var j = 0; j < grapArr.length; j++) {
											
										console.log("grapArr[j].prev_no_price::"+grapArr[j].prev_no_price)
											if (j == 0) {
												listArr[i]['c'+ (Number(j) + 1)] = Number(listArr[3]['c'+ (Number(j) + 1)])+Number(grapArr[j].prev_no_price);
											} else {
												listArr[i]['c'+ (Number(j) + 1)] = Number(listArr[3]['c'+ (Number(j) + 1)])+ Number(listArr[i]['c'+ j]);
											}
											listArr[i].p = Number(listArr[3]['c'+ (Number(j) + 1)])+ Number(listArr[i]['c' + j]);
											
											if(Number(max_total_price2) < Number(listArr[i].p)){
				                          		max_total_price2 = listArr[i].p ;
				        					}
										}
									}

								}
								
								 max_total_price2 = Number(max_total_price2) + Number(max_total_price2)/10;
								 max_total_price3 = Number(max_total_price3) + Number(max_total_price3)/10;
			                     max_total_price4 = Number(max_total_price4) + Number(max_total_price4)/10;

								console.log("탓따------------------------ : "
										+ listArr.length);
								w2ui['grid_list3'].records = listArr;

								chartLength = chartData.length;

								makeLayout3();
								fnLoadChart(chartData);

							} else {

								w2ui.grid_list3.clear();

								console.log('check');

								var b = [];
								document.getElementById("chart3").setData(b);
								makeLayout3();

								fnLoadChart(new Array());

								rMateChartH5.call("chart3", "hasNoData", true);
							}

						},
						complete : function() {

							w2ui['grid_list3'].refresh();
							w2ui['grid_list3'].unlock();

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

		function fnLoadChart(chartData) {
			rMateChartH5.create("chart3", "chartHolder3", "", "100%", "100%");

			rMateChartH5.calls("chart3", {
				"setLayout" : layoutStr3,
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

		function axisLabelFunc(id, value) {
			return value / 100000000 + "억";
		}

		function axisLabelFunc2(id, value) {
			return value / 100000000 + "억";
		}
		
		

		//-----------------------------------------------------------------------------
		function makeLayout3() {

			var date = $("#date option:selected").val();

			var gubun = $("#gubun").val();

			var priceT = "";

			if (gubun == '') {

				priceT = 'total_price';

				layoutStr3 = '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
						+ '<Options>'
						+ '<Caption text="'+date+'년 발주 금액 그래프"/>'
						+ '<SubCaption text="--" textAlign="center" />'
						+ '<Legend useVisibleCheck="true"/>'
						+ '</Options>'
						//+ '<Line2DChart showDataTips="true" itemClickJsFunction="gridData2" selectionMode="single" paddingTop="0">'
						+ '<Column2DChart showDataTips="true" itemClickJsFunction="gridData2" columnWidthRatio="0.55" dataTipDisplayMode="axis">'
						+ '<horizontalAxis>'
						+ '<CategoryAxis categoryField="month" padding="0.2"/>'
						+ '</horizontalAxis>'
						+ '<verticalAxis>'
						//                       +'<LinearAxis minimum="0"/>'
						+ '<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0" />'
						+ '</verticalAxis>'
 						+ '<series>'
						/*
						itemRenderer는 Tip이 보여지는 영역차트 부분에 ItemRenderer에서 제공하는 모양을 그려줍니다
						이 예제에서는 Diamond입니다
						사용할 수 있는 도형을 모두 표현한 예제는 Chart Samples 의 범례 예제를 참고하십시오.
						 */

// 						+ '<Column2DSet type="clustered">'
// 						+ '<series>'
// 						+ '<Column2DSeries labelPosition="gubun" yField="'+priceT+'" displayName="발주금액">'
// 						+ '<fill>'
// 						+ '<SolidColor color="#41b2e6"/>'
// 						+ '</fill>'
// 						+ '<showDataEffect>'
// 						+ '<SeriesInterpolate/>'
// 						+ '</showDataEffect>'
// 						+ '</Column2DSeries>'

// 						+ '<Column2DSeries yField="sum_price_acc" >'
// 						+ '<fill>'
// 						+ '<SolidColor color="#4452a8" alpha="0"/>'
// 						+ '</fill>'

// 						+ '<showDataEffect>'
// 						+ '<SeriesInterpolate/>'
// 						+ '</showDataEffect>'
// 						+ '</Column2DSeries>'
// 						+ '</series>'
// 						+ '</Column2DSet>'
// 						//---------------------------------------------------------------------------------------------
						
// 						  //하나더
// 	                           +'<Column2DSet type="clustered"> '
// 	                            +'<series showDataTips="false">'
// 	                            +'<Column2DSeries yField="+priceT+" labelPosition="gubun" >'
// 	                            +'<fill>'
// 	                              +'<SolidColor color="#41b2e6" alpha="0" />'
// 	                           +'</fill>'

// 	                          +'</Column2DSeries>'
	                          
	                          
	                          
// 	                          +'<Column2DSeries yField="sum_price_acc" displayName="누적 발주금액" visible="true">'
// 	                              +'<fill>'
// 	                                 +'<SolidColor color="#4452a8" />'
// 	                              +'</fill>'
// 	                                 +'<verticalAxis>'
// 	                               +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total_price2+'"/>'
// 	                            +'</verticalAxis>'
	                            
	                           
// 	                                +'<showDataEffect>'
// 	                                   +'<SeriesInterpolate/>'
// 	                               +'</showDataEffect>'
// 	                          +'</Column2DSeries>'
// 	                          +'</series>'
// 	                            +'</Column2DSet>'
	                            
// 	                            //


        //+'<series>'
        +'<Column2DSeries labelPosition="gubun" yField="'+priceT+'" displayName="발주금액">'
        +'<showDataEffect>'
        +' <SeriesInterpolate/>'
        +' </showDataEffect>'
        +'  </Column2DSeries>'

        +'  <Column2DSeries yField="sum_price_acc" displayName="누적발주금액" >'
        +'   <showDataEffect>'
        +'        <SeriesInterpolate/>'
        +'       </showDataEffect>'
        +'<verticalAxis>'
        +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total_price2+'"/>'
     +'</verticalAxis>'
        +'   </Column2DSeries>'
       // +'</series>'
						
						//-------------------------------------

						+ '<Line2DSeries  yField="goal"   displayName="목표금액" itemRenderer="CircleItemRenderer">'
						/* itemRenderer는 Circle입니다 */
						+'<lineStroke>'
                           +'<Stroke color="#ffd736" weight="2"/>'
                        +'</lineStroke>'
						+ '<showDataEffect>'
						+ '<SeriesInterpolate/>'
						+ '</showDataEffect>'
						+ '</Line2DSeries>'

						+ '<Line2DSeries yField="goal_acc"  labelJsFunction="axisLabelFunc2"  displayName="누적목표금액" itemRenderer="CircleItemRenderer">'
						/* itemRenderer는 Circle입니다 */
						+ '<lineStroke>'
						+ '<Stroke color="#fc4141" weight="2"/>'
						+ '</lineStroke>'
						+ '<verticalAxis>'
						+ '<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum="'+max_total_price2 +'"/>'
						+ '</verticalAxis>'
						+ '<showDataEffect>'
						+ '<SeriesInterpolate/>'
						+ '</showDataEffect>'
						+ '</Line2DSeries>'

						//누적그래프

 						+ '</series>'

						+ '<verticalAxisRenderers>'

						+ '<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="true">'
						/* vAxis1을 참조 */
						//                           +'<axisStroke>'
						//                              +'<Stroke color="rgb(65, 178, 230)" weight="3" caps="none"/>'
						//                          +'</axisStroke>'
						+ '</Axis2DRenderer>'

						+ '<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="true">'
						/* vAxis2를 참조 */
						//                          +'<axisStroke>'
						//                             +'<Stroke color="rgb(0, 182, 170)" weight="3" caps="none"/>'
						//                         +'</axisStroke>'
						+ '</Axis2DRenderer>'

						+ '</verticalAxisRenderers>'

						/* hover시 선 뜨는거 유무 */
						+ '<annotationElements>'
						+ '<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
						+ '</CrossRangeZoomer>'
						+ '</annotationElements>'
						+ '  </Column2DChart>' + '</rMateChart>';

			} else if (gubun == 'in') {
				priceT = 'in_price';
				layoutStr3 = '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
						+ '<Options>'
						+ '<Caption text="'+date+'년 입고 금액 그래프"/>'
						+ '<SubCaption text="--" textAlign="center" />'
						+ '<Legend useVisibleCheck="true"/>'
						+ '</Options>'
						+ '<Line2DChart showDataTips="true" itemClickJsFunction="gridData2" dataTipDisplayMode="axis" paddingTop="0">'
						+ '<horizontalAxis>'
						+ '<CategoryAxis categoryField="month" padding="0.2"/>'
						+ '</horizontalAxis>'
						+ '<verticalAxis>'
						//                       +'<LinearAxis minimum="0"/>'
						+ '<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0" />'
						+ '</verticalAxis>'
						+ '<series>'
						/*
						itemRenderer는 Tip이 보여지는 영역차트 부분에 ItemRenderer에서 제공하는 모양을 그려줍니다
						이 예제에서는 Diamond입니다
						사용할 수 있는 도형을 모두 표현한 예제는 Chart Samples 의 범례 예제를 참고하십시오.
						 */

						+ '<Column2DSet type="clustered">'
						+ '<series>'
						+ '<Column2DSeries labelPosition="gubun" yField="'+priceT+'" displayName="입고금액">'
						+ '<fill>'
						+ '<SolidColor color="#41b2e6"/>'
						+ '</fill>'
						+ '<showDataEffect>'
						+ '<SeriesInterpolate/>'
						+ '</showDataEffect>'
						+ '</Column2DSeries>'
						
						+ '</series>'
						+ '</Column2DSet>'
						//누적그래프
                          +'<Line2DSeries yField="sum_in_price_acc" fill="#ffffff" radius="5" displayName="누적 입고금액" itemRenderer="CircleItemRenderer">'
                        /* itemRenderer는 Circle입니다 */
                         +'<lineStroke>'
                                 +'<Stroke color="#4452a8" weight="2"/>'
                             +'</lineStroke>'
                             
                         	+'<verticalAxis>'
                          +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total_price3+'"/>'
                       +'</verticalAxis>'
                       
                            +'<showDataEffect>'
                                +'<SeriesInterpolate/>'
                            +'</showDataEffect>'
                       +'</Line2DSeries>'
						+ '</series>'

						+ '<verticalAxisRenderers>'

						+ '<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="true">'
						/* vAxis1을 참조 */
						//                           +'<axisStroke>'
						//                              +'<Stroke color="rgb(65, 178, 230)" weight="3" caps="none"/>'
						//                          +'</axisStroke>'
						+ '</Axis2DRenderer>'
						+ '<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="true">'
						/* vAxis2를 참조 */
						//                          +'<axisStroke>'
						//                             +'<Stroke color="rgb(0, 182, 170)" weight="3" caps="none"/>'
						//                         +'</axisStroke>'
						+ '</Axis2DRenderer>'
						+ '</verticalAxisRenderers>'

						/* hover시 선 뜨는거 유무 */
						+ '<annotationElements>'
						+ '<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
						+ '</CrossRangeZoomer>'
						+ '</annotationElements>'
						+ '</Line2DChart>' + '</rMateChart>';
			} else if (gubun == 'no') {
				priceT = 'no_price';
				layoutStr3 = '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
						+ '<Options>'
						+ '<Caption text="'+date+'년 미입고 금액 그래프"/>'
						+ '<SubCaption text="--" textAlign="center" />'
						+ '<Legend useVisibleCheck="true"/>'
						+ '</Options>'
						+ '<Line2DChart showDataTips="true" itemClickJsFunction="gridData2" dataTipDisplayMode="axis" paddingTop="0">'
						+ '<horizontalAxis>'
						+ '<CategoryAxis categoryField="month" padding="0.2"/>'
						+ '</horizontalAxis>'
						+ '<verticalAxis>'
						//                       +'<LinearAxis minimum="0"/>'
						+ '<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0" />'
						+ '</verticalAxis>'
						+ '<series>'
						/*
						itemRenderer는 Tip이 보여지는 영역차트 부분에 ItemRenderer에서 제공하는 모양을 그려줍니다
						이 예제에서는 Diamond입니다
						사용할 수 있는 도형을 모두 표현한 예제는 Chart Samples 의 범례 예제를 참고하십시오.
						 */

						+ '<Column2DSet type="clustered">'
						+ '<series>'
						+ '<Column2DSeries labelPosition="gubun" yField="'+priceT+'" displayName="미입고금액">'
						+ '<fill>'
						+ '<SolidColor color="#41b2e6"/>'
						+ '</fill>'
						+ '<showDataEffect>'
						+ '<SeriesInterpolate/>'
						+ '</showDataEffect>'
						+ '</Column2DSeries>'

						+ '</series>'
						+ '</Column2DSet>'
						//누적그래프
                          +'<Line2DSeries yField="sum_no_price_acc" fill="#ffffff" radius="5" displayName="누적 미입고금액" itemRenderer="CircleItemRenderer">'
                        /* itemRenderer는 Circle입니다 */
                         +'<lineStroke>'
                                 +'<Stroke color="#4452a8" weight="2"/>'
                             +'</lineStroke>'
                             
                         	+'<verticalAxis>'
                          +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+prev_no_sum+'"/>'
                       +'</verticalAxis>'
                       
                            +'<showDataEffect>'
                                +'<SeriesInterpolate/>'
                            +'</showDataEffect>'
                       +'</Line2DSeries>'
						+ '</series>'

						+ '<verticalAxisRenderers>'

						+ '<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="true">'
						/* vAxis1을 참조 */
						//                           +'<axisStroke>'
						//                              +'<Stroke color="rgb(65, 178, 230)" weight="3" caps="none"/>'
						//                          +'</axisStroke>'
						+ '</Axis2DRenderer>'
						+ '<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="true">'
						/* vAxis2를 참조 */
						//                          +'<axisStroke>'
						//                             +'<Stroke color="rgb(0, 182, 170)" weight="3" caps="none"/>'
						//                         +'</axisStroke>'
						+ '</Axis2DRenderer>'

						+ '</verticalAxisRenderers>'

						/* hover시 선 뜨는거 유무 */
						+ '<annotationElements>'
						+ '<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
						+ '</CrossRangeZoomer>'
						+ '</annotationElements>'
						+ '</Line2DChart>' + '</rMateChart>';
			}

		}

		//---------------------------------------------------------------------------------------------------------------------------------------------------------------	
		function makeLayout2() {
			var date = $("#date option:selected").val();

			var gubun = $("#gubun").val();

			var gubunT = "";

			if (gubun == '') {
				gubunT = '발주';
			} else if (gubun == 'in') {
				gubunT = '입고';
			} else if (gubun == 'no') {
				gubunT = '미입고';
			}

			layoutStr2 = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+ '<Options>'
					+ '<Caption text="'+date+'년 '+gubunT+' 비율"/>'
					+ '<SubCaption text="--"/>'
					+ '<Legend useVisibleCheck="true"/>'
					+ '</Options>'
					+ '<CurrencyFormatter id="numFmt" currencySymbol="%" alignSymbol="right"/>'
					/*
					Pie3D 차트 생성시에 필요한 Pie3DChart 정의합니다
					showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.
					 */
					+ '<Pie3DChart showDataTips="true"  itemClickJsFunction="gridData" depth="50" paddingLeft="100" paddingTop="50" paddingRight="100" paddingBottom="50">'
					+ '<series>'
					+ '<Pie3DSeries nameField="account_nm" field="total_price" labelPosition="inside" color="#ffffff" startAngle="240">'
					/* Pie3DChart 정의 후 Pie3DSeries labelPosition="inside"정의합니다 */
					+ '<showDataEffect>'
					/* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
					+ '<SeriesInterpolate duration="1000"/>'
					/*
					SeriesInterpolate 효과는 시리즈 데이터가 데이터로 표시될 때 데이터의 변화된 내용을 가지고 효과를 적용합니다
					 - 공통 -
					elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
					minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
					            이 값보다 짧은 시간에 effect가 실행되지 않습니다
					offset : effect개시의 지연시간을 설정합니다 default:0
					 perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
					 */
					+ '</showDataEffect>'
					+ '</Pie3DSeries>'
					+ '</series>'
					+ '</Pie3DChart>' + '</rMateChart>';
		}

		//-------------------------------------------------------------------------------------------------------------------
		
		function excelFileDownload()
			{
			console.log("excelFileDownload()");
			var gridCols = w2ui['grid_list'].columns;
			var gridData = w2ui['grid_list'].records;
			
			var nm = "구매실적정보";
		
			var fileName = '구매실적정보.xlsx';
			var sheetTitle = '구매실적정보';
			var sheetName = '구매실적정보';
			
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
		console.log("excelFileDownload2()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;
		
		var nm = "거래처별구매실적정보";
	
		var fileName = '거래처별구매실적정보.xlsx';
		var sheetTitle = '거래처별구매실적정보';
		var sheetName = '거래처별구매실적정보';
		
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
		
		
		function initOptions(obj) {
			$(obj).find('option').remove().end()
			//	    .append('<option value="All">-----</option>')
			.val();
		}

		function setComma(n) {
			var reg = /(^[+-]?\d+)(\d{3})/; // 정규식
			n += ''; // 숫자를 문자열로 변환         
			while (reg.test(n)) {
				n = n.replace(reg, '$1' + ',' + '$2');
			}
			return n;
		}

		function getFormatDate(d) {
			var month = d.getMonth() + 1;
			var date = d.getDate();
			month = (month < 10) ? "0" + month : month;
			date = (date < 10) ? "0" + date : date;
			return d.getFullYear() + '-' + month + '-' + date;
		}
	</script>

</body>
</html>