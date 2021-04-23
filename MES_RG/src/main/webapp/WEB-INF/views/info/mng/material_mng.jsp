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
			<jsp:param name="selected_menu_p_cd" value="1012" />
			<jsp:param name="selected_menu_cd" value="1021" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					자재 관리 <small>기준정보관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li>
					<li class="active">자재 관리</li>
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
									<button type="button" id="btn_excel"
										class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
									<button type="button" id="btn_create"
										class="btn btn-primary btn-sm" onclick="insertMaterial();">등록</button>
									<button type="button" id="btn_update"
										class="btn btn-info btn-sm" onclick="updateMaterial();">수정</button>
									<button type="button" id="btn_delete"
										class="btn btn-danger btn-sm" onclick="deleteMaterial();">삭제</button>
									<button type="button" id="btn_search_csr" onclick="loadList();"
										class="btn btn-warning btn-sm" onclick="">조회</button>
								</div>
							</div>
							<div id="" class="box-body">
								<div class="row">

									<div class="col-sm-2">
										<div class="form-group">
											<label>Business</label> <select id="business" name="business"
												class="form-control" style="height: 30px;">
												<!-- 
									 	<option value="ALL" selected="selected">전체</option> 
									 	<option value="business1">business1</option>
									 	<option value="business2">business2</option>s
									 	<option value="business3">business3</option> -->
											</select>
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>P/N</label> <input type="combo" id="item_code"
												name="item_code" class="form-control input-sm"
												placeholder="P/N"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}">
											<!-- <input type="text" id="item_code" name="item_code" class="form-control input-sm" placeholder="P/N"
										maxlength="40" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>품명</label> <input type="combo" id="item_nm"
												name="item_nm" class="form-control input-sm"
												placeholder="품명"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}">
											<!-- <input type="text" id="item_nm" name="item_nm" class="form-control input-sm" placeholder="품명"
										maxlength="40" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
										</div>
									</div>


									<div class="col-sm-2">
										<div class="form-group">
											<label>자재 유형</label> <select id="item_type" name="item_type"
												class="form-control" style="height: 30px;">
												<!-- <option value="ALL" selected="selected">전체</option> 
									 	<option value="mt_type1">mt_type1</option>
									 	<option value="mt_type2">mt_type2</option>
									 	<option value="mt_type3">mt_type3</option> -->
											</select>
										</div>
									</div>

									<div class="col-sm-2 hidden">
										<div class="form-group">
											<label>등급 관리</label> <select id="class_yn" name="class_yn"
												class="form-control" style="height: 30px;">
												<option value="ALL" selected="selected">전체</option>
												<option value="Y">대상</option>
												<option value="N">미대상</option>
											</select>
										</div>
									</div>

									<div class="col-sm-2">
										<div class="form-group">
											<label>안전재고 관리</label> <select id="safety_stock_yn"
												name="safety_stock_yn" class="form-control"
												style="height: 30px;">
												<option value="ALL" selected="selected">전체</option>
												<option value="Y">대상</option>
												<option value="N">미대상</option>
											</select>
										</div>
									</div>


									<div class="col-md-12">
										<div id="grid_list" style="width: 100%; height: 620px;"></div>
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
		<div class="modal fade" id="modal_info" data-backdrop="static">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_code_title">등록</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="frm_routingItnbr" name="frm_routingItnbr"
							class="form-horizontal">
							<input type="hidden" id="fg_check_yn" name="fg_check_yn"
								value="N">

							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">Business</label>
									<div class="col-sm-7">
										<select class="form-control input-sm" id="m_business"
											name="m_business">
										</select>
									</div>
								</div>
							</div>

							<div class="row" id="ct_codeView">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">P/N</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm pull-right"
											id="m_item_code" maxlength="100">
									</div>
									<div class="col-sm-3">
										<button type="button" id="btn_check"
											class="btn btn-primary btn-sm">P/N 중복체크</button>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">품명</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right"
											id="m_item_nm" maxlength="100">
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">자재내역</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right"
											id="m_item_spec" maxlength="100">
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">자재유형</label>
									<div class="col-sm-7">
										<select class="form-control input-sm" id="m_item_type"
											name="m_item_type">
										</select>
									</div>
								</div>
							</div>


							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">단위</label>
									<div class="col-sm-7">
										<select class="form-control input-sm" id="m_meins"
											name="m_meins">
											<option value="EA" selected="selected">EA</option>
											<option value="BOX">BOX</option>
											<option value="ROLL">ROLL</option>
										</select>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">입고단가</label>
									<div class="col-sm-3" style="padding-right: 0px;">
										<input type="text" class="form-control input-sm pull-right"
											id="m_warehousing_price" maxlength="100"
											onKeypress="onlyNumber();" style="IME-MODE: disabled;">
									</div>
									<label for="" class="col-sm-2 control-label"
										style="padding-left: 0px; padding-right: 12px; width: 12%;">출고단가</label>
									<div class="col-sm-3" style="padding-left: 0px;">
										<input type="text" class="form-control input-sm pull-right"
											id="m_release_price" maxlength="100"
											onKeypress="onlyNumber();" style="IME-MODE: disabled;">
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">외주입고단가</label>
									<div class="col-sm-3" style="padding-right: 0px;">
										<input type="text" class="form-control input-sm pull-right"
											id="m_outsourcing_price" onKeypress="onlyNumber();">
									</div>
									<label for="" class="col-sm-2 control-label"
										style="padding-left: 0px; padding-right: 12px; width: 12%;">위치</label>
									<div class="col-sm-3" style="padding-left: 0px;">
										<input type="text" class="form-control input-sm pull-right"
											id="m_location">
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="rdo_mretire_yn" class="col-sm-3 control-label">수입검사여부</label>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label style="margin-right: 10px;"> <input
											type="radio" id="m_receiving_inspection_ynY"
											name="rdo_receiving_inspection_yn" class="flat-red" value="Y">
											대상
										</label>
									</div>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label> <input type="radio"
											id="m_receiving_inspection_ynN"
											name="rdo_receiving_inspection_yn" class="flat-red" value="N"
											checked="checked"> 미대상
										</label>
									</div>
								</div>
							</div>

							<div class="row hidden">
								<div class="form-group">
									<label for="rdo_mretire_yn" class="col-sm-3 control-label">등급관리여부</label>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label style="margin-right: 10px;"> <input
											type="radio" id="m_classY" name="rdo_class_yn"
											class="flat-red" value="Y"> 대상
										</label>
									</div>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label> <input type="radio" id="m_classN"
											name="rdo_class_yn" class="flat-red" value="N"
											checked="checked"> 미대상
										</label>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="rdo_mretire_yn" class="col-sm-3 control-label">안전재고
										관리여부</label>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label style="margin-right: 10px;"> <input
											type="radio" id="m_safety_stock_ynY"
											name="rdo_safety_stock_yn" class="flat-red" value="Y">
											대상
										</label>
									</div>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label> <input type="radio" id="m_safety_stock_ynN"
											name="rdo_safety_stock_yn" class="flat-red" value="N"
											checked="checked"> 미대상
										</label>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">안전재고수량</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right"
											id="m_safety_menge" maxlength="100"
											oninput="maxLengthCheck(this);" disabled="disabled">
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="rdo_mretire_yn" class="col-sm-3 control-label">원자재
										불출여부</label>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label style="margin-right: 10px;"> <input
											type="radio" id="m_safety_stock_ynY" name="rdo_one_yn"
											class="flat-red" value="Y" checked="checked"> 대상
										</label>
									</div>
									<div class="col-sm-4" style="padding-top: 7px;">
										<label> <input type="radio" id="m_safety_stock_ynN"
											name="rdo_one_yn" class="flat-red" value="N"> 미대상
										</label>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">창고</label>
									<div class="col-sm-3" style="padding-right: 0px;">
										<select class="form-control input-sm" id="m_in_ware_code"
											name="m_in_ware_code">
											
										</select>
									</div>
									<!-- <label for="" class="col-sm-2 control-label"
										style="padding-left: 0px; padding-right: 12px; width: 12%;">생산창고</label>
									<div class="col-sm-3" style="padding-left: 0px;">
										<select class="form-control input-sm" id="m_prod_ware_code"
											name="m_prod_ware_code">
											
										</select>
									</div> -->
								</div>
							</div>

							<div class="row">
								<div class="col-md-12" id="msg"
									style="font-weight: bold; color: blue;"></div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
							<button type="button" id="" class="btn btn-success btn-sm"
								onclick="saveMaterial();">저장</button>
							<button type="button" id="" class="btn btn-default btn-sm"
								data-dismiss="modal">닫기</button>
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
		var startValue_combo = "";
		comboValue_nm = new Array;
		comboValue_cd = new Array;
		// 	var color = new Array;
		$(function($) {

			fnCdD('business', 'MC1012'); // Id, Master_code
			fnCdD('m_business', 'MC1012');

			fnCdD('item_type', 'MC1014');
			fnCdD('m_item_type', 'MC1014');
			
			//입고창고
			fnCdD_wh('m_in_ware_code', 'MD1243');
			//생산창고
			//fnCdD('m_prod_ware_code', 'MC1020');

			fnLoadCommonOption();
			fnLoadCompanyGrid();

			// 	 	$('#grid_list').on('DOMSubtreeModified propertychange', _.debounce(function() {
			// 			colorArr(); 
			// 		}, 100));
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

			$('input[type="radio"].flat-red').iCheck({
				checkboxClass : 'icheckbox_flat-green',
				radioClass : 'iradio_flat-green',
				handle : 'radio'
			});

			$("#m_safety_menge").keyup(function(event) {
				if (event.which >= 37 && event.which <= 40)
					return;
				$(this).val(function(index, value) {
					return value.replace(/\D/g, "").replace(189, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});

		}

		function fnLoadCompanyGrid() {
			// 	 console.log(page_url);
			var rowArr = [];

			$('#grid_list').w2grid({
				name : 'grid_list',
				show : {
					selectColumn : true,
					lineNumbers : false,
					footer : true
				},
				multiSelect : false,
				columns : [ {
					field : 'business_code',
					caption : 'Business Code',
					size : '10%',
					style : 'text-align:center',
					hidden : true
				}, {
					field : 'business_nm',
					caption : 'Business',
					size : '10%',
					style : 'text-align:center',
					sortable : true
				}, {
					field : 'item_code',
					caption : 'P/N',
					size : '10%',
					style : 'text-align:center',
					sortable : true
				}, {
					field : 'item_nm',
					caption : '품명',
					size : '15%',
					style : 'text-align:center',
					sortable : true
				}, {
					field : 'item_type_code',
					caption : '자재유형 코드',
					size : '10%',
					style : 'text-align:center',
					hidden : true
				}, {
					field : 'item_type_nm',
					caption : '자재유형',
					size : '7%',
					style : 'text-align:center',
					sortable : true
				},{
					field : 'in_ware_nm',
					caption : '입고창고',
					size : '7%',
					style : 'text-align:center',
					sortable : true
				},{
					field : 'in_ware_code',
					caption : '입고창고코드',
					size : '7%',
					style : 'text-align:center',
					sortable : true,
					hidden : true
				},
				/* {
					field : 'prod_ware_nm',
					caption : '생산창고',
					size : '7%',
					style : 'text-align:center',
					sortable : true
				},  */
				{
					field : 'meins',
					caption : '기본단위',
					size : '7%',
					style : 'text-align:center',
					sortable : true
				}, {
					field : 'warehousing_price',
					caption : '입고단가',
					size : '9%',
					style : 'text-align:center',
					sortable : true
					
					,render: function (record, index, col_index) {
		       	        var html = this.getCellValue(index, col_index);

		              html = w2utils.formatters['number'](html);
		              html = setComma(html);
		                  return html;
		              } 
					
				}, {
					field : 'release_price',
					caption : '출고단가',
					size : '9%',
					style : 'text-align:center',
					sortable : true
					
					,render: function (record, index, col_index) {
		       	        var html = this.getCellValue(index, col_index);

		              html = w2utils.formatters['number'](html);
		              html = setComma(html);
		                  return html;
		              } 
					
				}, {
					field : 'outsourcing_price',
					caption : '외주입고단가',
					size : '9%',
					style : 'text-align:center',
					sortable : true
					
					,render: function (record, index, col_index) {
		       	        var html = this.getCellValue(index, col_index);

		              html = w2utils.formatters['number'](html);
		              html = setComma(html);
		                  return html;
		              } 
					
				}, {
					field : 'location',
					caption : '위치',
					size : '10%',
					style : 'text-align:center',
					sortable : true
				},

				{
					field : 'receiving_inspection_yn',
					caption : '수입검사여부',
					size : '7%',
					style : 'text-align:center',
					sortable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (val == "N")
							return '비검사대상';
						else
							return '검사대상';
					}
				},

				{
					field : 'class_yn',
					caption : '등급관리여부',
					size : '7%',
					style : 'text-align:center',
					sortable : true,
					hidden : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (val == "N")
							return '비등급대상';
						else
							return '등급대상';
					}
				}, {
					field : 'safety_stock_yn',
					caption : '안전재고 관리 여부',
					size : '8%',
					style : 'text-align:center',
					sortable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (val == "N")
							return '비관리대상';
						else
							return '관리대상';
					}
				}, {
					field : 'safety_menge',
					caption : '안전재고수량',
					size : '10%',
					style : 'text-align:center',
					hidden : false,
					sortable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						var safety_stock_yn = w2ui.grid_list.records[index].safety_stock_yn; 
						if (safety_stock_yn == 'N') {
							return '';
						}
						return val;
					}
				}, {
					field : 'one_yn',
					caption : '원자재 불출 여부',
					size : '8%',
					style : 'text-align:center',
					sortable : true,
					render : function(record, index, col_index) {
						var val = this.getCellValue(index, col_index);
						if (val == "N")
							return '비불출대상';
						else
							return '불출대상';
					}
				}, {
					field : 'item_spec',
					caption : '자재내역',
					size : '10%',
					style : 'text-align:center',
					sortable : true
				}, {
					field : 'creator_nm',
					caption : '등록자',
					size : '5%',
					style : 'text-align:center',
					sortable : true
				}, {
					field : 'updater_nm',
					caption : '수정자',
					size : '5%',
					style : 'text-align:center',
					sortable : true
				}, {
					field : 'creator',
					caption : '등록자',
					size : '4%',
					style : 'text-align:center',
					sortable : true,
					hidden : true
				}, {
					field : 'updater',
					caption : '수정자',
					size : '4%',
					style : 'text-align:center',
					sortable : true,
					hidden : true
				}

				],
				sortData : [ {
					field : 'customer_code',
					direction : 'ASC'
				} ],
				records : [], //
				onReload : function(event) {
					//loadList();
				},
				onClick : function(event) {
				}
			});
			loadList();
		}

		$("#m_item_code").change(function() {
			$("#fg_check_yn").val("N");
		});

		$("#business").change(function() {
			loadList();
		});

		$("#item_type").change(function() {
			loadList();
		});

		// 	$("#class_yn").change(function(){
		// 		loadList();
		// 	});

		$("#safety_stock_yn").change(function() {
			loadList();
		});

		$("#m_item_type")
				.change(
						function() {
							console.log("m_item_type change()");
							var val = $("#m_item_type option:selected").val();
							if (val == "MD1245") { // 원자재 코드 : MD1245
								console.log("원자재 선택");

								$(
										':radio[name="rdo_receiving_inspection_yn"][value="Y"]')
										.iCheck('check');
								$(':radio[name="rdo_receiving_inspection_yn"]')
										.iCheck('update');

								// 			$(':radio[name="rdo_class_yn"][value="Y"]').iCheck('check');
								// 			$(':radio[name="rdo_class_yn"]').iCheck('update');

								$(
										':radio[name="rdo_safety_stock_yn"][value="Y"]')
										.iCheck('check');
								$(':radio[name="rdo_safety_stock_yn"]').iCheck(
										'update');
							}

						});

		// 
		$(":radio[name='rdo_safety_stock_yn']")
				.on(
						'ifChecked',
						function(event) {
							//  		  console.log("rdo_safety_stock_yn = " + $(":radio[name='rdo_safety_stock_yn']:checked").val());

							var radioV = $(
									":radio[name='rdo_safety_stock_yn']:checked")
									.val();

							if (radioV == "Y") {
								$("#m_safety_menge").val('0');
								$("#m_safety_menge").attr('disabled', false);
							} else {
								$("#m_safety_menge").val('');
								$("#m_safety_menge").attr('disabled', true);
							}
						});

		$(":radio[name='rdo_one_yn']").on('ifChecked', function(event) {
			//	  console.log("rdo_safety_stock_yn = " + $(":radio[name='rdo_safety_stock_yn']:checked").val());

			var radioV = $(":radio[name='rdo_one_yn']:checked").val();

		});

		$("#btn_check").on('click', function(e) {
			e.preventDefault();
			if ($.trim($("#m_item_code").val()).length == 0) {
				fnMessageModalAlert("알림", "P/N를 입력하세요.");
				return;
			}

			fncheckMaterial();
		});

		function fncheckMaterial() {
			var item_code = $("#m_item_code").val();
			var postData = "item_code=" + encodeURIComponent(item_code);
			var formURL = "/info/material/checkMaterial";

			$
					.ajax({
						url : formURL,
						type : "POST",
						data : postData,
						success : function(data, textStatus, jqXHR) {
							if (data.status == "200") {
								if (data.cnt > 0) {
									$("#fg_check_yn").val("N");
									fnMessageModalAlert("알림",
											"입력하신 자재 코드는 사용할 수 없습니다.(이미 사용중)");
								} else {
									$("#fg_check_yn").val("Y");
									fnMessageModalAlert("알림",
											"입력하신 자재 코드는 사용할 수 있습니다.");
								}
							} else {
								fnMessageModalAlert("알림",
										"입력하신 자재 코드 중복여부를 확인하는데 에러가 발생하였습니다.");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							fnMessageModalAlert("알림",
									"입력하신 자재 코드 중복여부를 확인하는데 에러가 발생하였습니다.");
						}
					});
		}

		function loadList() {
			//// 조회 합시당
			console.log("loadList()");

			var page_url = "/info/material/selectMaterial";
			var postData = "item_code="
					+ encodeURIComponent($("#item_code").val()) + "&item_nm="
					+ encodeURIComponent($("#item_nm").val());

			// Business
			if ($("#business option:selected").val() != "ALL") {
				postData += "&business_code="
						+ encodeURIComponent($("#business option:selected")
								.val());

				postData += "&business_codeT=" + "";
				if ($("#business option:selected").val() == "MD1243"
						|| $("#business option:selected").val() == "MD1244") {
					postData += encodeURIComponent("MD1282");
				}
			} else {
				postData += "&business_code=" + encodeURIComponent("");
			}
			// 자재 유형
			if ($("#item_type option:selected").val() != "ALL") {
				postData += "&item_type_code="
						+ encodeURIComponent($("#item_type option:selected")
								.val());
			} else {
				postData += "&item_type_code=" + encodeURIComponent("");
			}
			// 등급 관리
			if ($("#class_yn option:selected").val() != "ALL") {
				postData += "&class_yn="
						+ encodeURIComponent($("#class_yn option:selected")
								.val());
			} else {
				postData += "&class_yn=" + encodeURIComponent("");
			}
			// 안전재고 관리
			if ($("#safety_stock_yn option:selected").val() != "ALL") {
				postData += "&safety_stock_yn="
						+ encodeURIComponent($(
								"#safety_stock_yn option:selected").val());
			} else {
				postData += "&safety_stock_yn=" + encodeURIComponent("");
			}

			w2ui['grid_list'].lock('loading...', true);
			$.ajax({
				url : page_url,
				type : 'POST',
				data : postData,
				dataType : 'json',
				success : function(data) {
					if (data.status == 200 && (data.rows).length > 0) {
						comboValue_nm = new Array;
						comboValue_cd = new Array;
						// 					color = new Array;
						rowArr = data.rows;
						$.each(rowArr, function(idx, row) {
							row.recid = idx + 1;
							if (startValue_combo == "") {
								comboValue_nm.push(row.item_nm);
								comboValue_cd.push(row.item_code);
							}

							row.warehousing_price = Number(row.warehousing_price);
							row.release_price = Number(row.release_price);
							row.outsourcing_price = Number(row.outsourcing_price);
							row.safety_menge = Number(row.safety_menge);
							if (row.safety_stock_yn == 'N') {
								row.safety_menge = 0;
								// 							color.push(idx);
								// 							row.safety_menge = '<div style="background-color:#DBDBDB;">'+row.safety_menge+'</div>';
							}

						});
						w2ui['grid_list'].records = rowArr;
						if (startValue_combo == "") {

							$('#item_nm').w2field('combo', {
								items : comboValue_nm,
								match : 'contains'
							});
							$('#item_code').w2field('combo', {
								items : comboValue_cd,
								match : 'contains'
							});
						}
					} else {
						w2ui.grid_list.clear();
					}
					w2ui['grid_list'].refresh();
					w2ui['grid_list'].unlock();
				},
				complete : function() {
					startValue_combo = ":)";
					w2ui.grid_list.refresh();
					$('#grid_list').w2render('grid_list');
					// 			    colorArr();
				}
			});

		}

		// 	function colorArr() {
		// 		$.each(color, function(idx, row){
		// 			console.log("row = " + row);
		// 			$('#grid_grid_list_data_'+row+'_12').attr('style','background-color: #DBDBDB; color: #FFFFFF; text-align:center; border: 1px solid #c5c5c5;');
		// 		});
		// 	}

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
							console.log("(data.rows).length = "
									+ (data.rows).length);
							if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
								rowArr = data.rows;

								var sub = val.substr(0, 2);
								// 		    		console.log("sub = " + sub);
								//  if(valsub != "m_")
								if (sub.indexOf("m_") == -1) // val
									$("#" + val).append( "<option value="+'ALL'+">" + "전체" + "</option>");

								$.each(rowArr, function(idx, row) {
									if (val == "business" && row.detail_code == "MD1282") {

									} else {
										$("#" + val).append( "<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
									}
								});

								$("#" + val + " option:eq(0)").prop("selected",true);
								
								if (val == "m_item_type") {$("#" + val + " option:eq(2)").prop("selected", true);}

							} else if (data.status == "200" && (data.rows).length == 0) {
								initOptions($('#' + val)); // select 박스 초기화

							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
						},
						complete : function() {

						}
					});

		}
		
		function fnCdD_wh(val, val2) {
			console.log("fnCdD_wh(" + val + ")");

			//initOptions($("#customer_integration_code")); // select 박스 초기화
			
			var strUrl = "/info/select_wh_mng";
			var postData = "business_code=" + encodeURIComponent(val2);

			$.ajax({
						url : strUrl,
						type : "POST",
						//data : postData,
						dataType : 'json',
						async : false, // 다 끝나고 다음 처리 해!
						success : function(data, textStatus, jqXHR) {
							//	 	    	console.log("(data.rows).length = " + (data.rows).length);
							if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
								rowArr = data.rows;

								var sub = val.substr(0, 2); 
								//  if(valsub != "m_")
								//$("#m_in_ware_code").append("<option value="+''+">" + "전체"+ "</option>");
								
								$.each(rowArr, function(idx, row) {
									
									$("#m_in_ware_code").append("<option value=" + row.warehouse_code + ">"+ row.warehouse_nm + "</option>");});

									$("#m_in_ware_code option:eq(0)").prop("selected",true);

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

		// modal 띄우기 
		function insertMaterial() {
			console.log('insertMaterial()');

			/* $("#modal_info > .input-sm").val(''); */
			w2ui.grid_list.selectNone();
			// insert
			$("#modal_code_title").text('등록');
			$("#m_item_code").attr('disabled', false);
			$("#btn_check").show();
			$("#fg_check_yn").val("N");

			$("#m_business option:eq(0)").prop("selected", true);

			$("#m_item_code").val('');
			$("#m_item_nm").val('');
			$("#m_item_spec").val('');

			$("#m_item_type option:eq(2)").prop("selected", true);
			$("#m_meins option:eq(0)").prop("selected", true);

			$("#m_warehousing_price").val('');
			$("#m_release_price").val('');

			$("#m_outsourcing_price").val('');
			$("#m_location").val('');

			$(':radio[name="rdo_receiving_inspection_yn"][value="N"]').iCheck(
					'check');
			$(':radio[name="rdo_receiving_inspection_yn"]').iCheck('update');

			// 		$(':radio[name="rdo_class_yn"][value="N"]').iCheck('check');
			// 		$(':radio[name="rdo_class_yn"]').iCheck('update');

			$(':radio[name="rdo_safety_stock_yn"][value="N"]').iCheck('check');
			$(':radio[name="rdo_safety_stock_yn"]').iCheck('update');

			$("#m_safety_menge").val('');
			
			$("#m_in_ware_code option:eq(0)").prop("selected", true);
// 			$("#m_prod_ware_code option:eq(0)").prop("selected", true);

			$("#modal_info").modal('show');

		}

		function updateMaterial() {
			console.log('updateMaterial()');

			/* $("#modal_info > .input-sm").val(''); */

			var key = w2ui.grid_list.getSelection();
			if (key.length == 1) {
				// update
				$("#modal_code_title").text('수정');
				var data = w2ui.grid_list.get(key[0]);
				$("#m_item_code").attr('disabled', true);

				$("#btn_check").hide();
				$("#fg_check_yn").val("Y");

				$("#m_business").val(data.business_code).prop("selected", true);

				$("#m_item_code").val(data.item_code);
				$("#m_item_nm").val(data.item_nm);
				$("#m_item_spec").val(data.item_spec);

				$("#m_item_type").val(data.item_type_code).prop("selected",
						true);
				$("#m_meins").val(data.meins).prop("selected", true);

				$("#m_warehousing_price").val(data.warehousing_price);
				$("#m_release_price").val(data.release_price);

				$("#m_outsourcing_price").val(data.outsourcing_price);
				$("#m_location").val(data.location);

				$(
						':radio[name="rdo_receiving_inspection_yn"][value="'
								+ data.receiving_inspection_yn + '"]').iCheck(
						'check');
				$(':radio[name="rdo_receiving_inspection_yn"]')
						.iCheck('update');

				// 			$(':radio[name="rdo_class_yn"][value="'+ data.class_yn +'"]').iCheck('check');
				// 			$(':radio[name="rdo_class_yn"]').iCheck('update');

				$(
						':radio[name="rdo_safety_stock_yn"][value="'
								+ data.safety_stock_yn + '"]').iCheck('check');
				$(':radio[name="rdo_safety_stock_yn"]').iCheck('update');
				
				
				$("#m_in_ware_code").val(data.in_ware_code);
// 				$("#m_prod_ware_code").val(data.prod_ware_code);

				if (data.safety_stock_yn == "Y") {
					$("#m_safety_menge").val(data.safety_menge);
				} else {
					$("#m_safety_menge").val("");
				}
				$("#modal_info").modal('show');
			} else {
				fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			}

		}

		function saveMaterial() {
			console.log('saveMaterial()');

			var business_code = $("#m_business option:selected").val();
			var business_nm = $("#m_business option:selected").text();

			var item_code = $("#m_item_code").val();
			var item_nm = $("#m_item_nm").val();
			var item_spec = $("#m_item_spec").val();

			var item_type_code = $("#m_item_type option:selected").val();
			var item_type_nm = $("#m_item_type option:selected").text();

			var meins = $("#m_meins option:selected").val();

			var warehousing_price = $("#m_warehousing_price").val();
			var release_price = $("#m_release_price").val();

			var receiving_inspection_yn = $(
					':radio[name="rdo_receiving_inspection_yn"]:checked').val();
			var class_yn = $(':radio[name="rdo_class_yn"]:checked').val();
			var safety_stock_yn = $(
					':radio[name="rdo_safety_stock_yn"]:checked').val();
			var one_yn = $(':radio[name="rdo_one_yn"]:checked').val();
			var outsourcing_price = $("#m_outsourcing_price").val();
			var location = $("#m_location").val();
			
			var in_ware_code = $("#m_in_ware_code").val();
// 			var prod_ware_code = $("#m_prod_ware_code").val();

			var safety_menge = "";
			if (safety_stock_yn == "Y") {
				safety_menge = $("#m_safety_menge").val();
			}

			var key = w2ui.grid_list.getSelection();

			if (key.length == 0) {
				flag = "I";
			} else if (key.length == 1) {
				flag = "U";
			}

			// 		if(flag=="I" && !chkSubmit($("#m_item_code"), "P/N를")) return;
			if ($("#fg_check_yn").val() == "N") {
				fnMessageModalAlert("알림", "P/N 중복체크를 확인하세요.");
				return;
			} else if (flag == "I" && !chkSubmit($("#m_item_code"), "P/N를"))
				return;

			if (flag == "I" && !chkSubmit($("#m_item_nm"), "품명을"))
				return;

			if (safety_stock_yn == "Y"
					&& numberChk($("#m_safety_menge"), "안전재고수량를"))
				return;

			console.log("flag = " + flag);

			$("#modal_info").modal('hide');

			var strUrl = "/info/material/saveMaterial";
			var postData = "flag=" + flag 
					+ "&item_code="+ encodeURIComponent(item_code) 
					+ "&item_nm="+ encodeURIComponent(item_nm)

					+ "&business_code=" + encodeURIComponent(business_code)
					+ "&business_nm=" + encodeURIComponent(business_nm)

					+ "&item_type_code=" + encodeURIComponent(item_type_code)
					+ "&item_type_nm=" + encodeURIComponent(item_type_nm)
					
					//1221
					+ "&in_ware_code=" + encodeURIComponent(in_ware_code)
// 					+ "&prod_ware_code=" + encodeURIComponent(prod_ware_code)

					+ "&item_spec=" + encodeURIComponent(item_spec) + "&meins="
					+ encodeURIComponent(meins) + "&warehousing_price="
					+ encodeURIComponent(warehousing_price) + "&release_price="
					+ encodeURIComponent(release_price)

					+ "&receiving_inspection_yn="
					+ encodeURIComponent(receiving_inspection_yn)
					+ "&class_yn=" + encodeURIComponent("N") // class_yn
					+ "&safety_stock_yn=" + encodeURIComponent(safety_stock_yn)
					+ "&one_yn=" + encodeURIComponent(one_yn)
					+ "&outsourcing_price="
					+ encodeURIComponent(outsourcing_price) + "&location="
					+ encodeURIComponent(location);

			if (safety_stock_yn == "Y") {
				postData += "&safety_menge=" + encodeURIComponent(safety_menge);
			} else {
				postData += "&safety_menge=" + "0";
			}

			// escape(

			$.ajax({
				url : strUrl,
				type : "POST",
				dataType : 'json',
				data : postData,
				success : function(data, textStatus, jqXHR) {
					if (data.status == "200") {
						fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
						startValue_combo = "";
						loadList();
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다."); // Notification(MES)
				},
				complete : function() {
				}
			});
		}

		function deleteMaterial() {
			console.log('deleteMaterial()');

			var key = w2ui.grid_list.getSelection();
			if (key.length == 0) {
				fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
				return;
			} else if (key.length > 1) {
				fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
				return;
			} else {

				var data = w2ui.grid_list.get(key[0]);
				var code = data.item_code;

				fnMessageModalConfirm(
						"알림",
						"선택한 내용을 삭제하시겠습니까?",
						function(result) {
							if (result) {
								console.log("code = " + code);

								var strUrl = "/info/material/deleteMaterial";
								var postData = "item_code=" + code;

								$
										.ajax({
											url : strUrl,
											type : "POST",
											dataType : 'json',
											data : postData,
											async : false,
											success : function(data,
													textStatus, jqXHR) {
												if (data.status == "200") {
													console.log(data);
													startValue_combo = "";
													loadList();
													fnMessageModalAlert("결과",
															"정상적으로 처리되었습니다."); // Notification(MES)
												}
											},
											error : function(jqXHR, textStatus,
													errorThrown) {
												fnMessageModalAlert("결과",
														"정보를 처리하는데 에러가 발생하였습니다."); // Notification(MES)
											},
											complete : function() {
											}
										});

							}
						});
			}
		}

		//엑셀 1024
		function excelFileDownload() {
			console.log("excelFileDownload()");
			var gridCols = w2ui['grid_list'].columns;

			console.log("gridCols::" + gridCols);

			var gridData = w2ui['grid_list'].records;

			var fileName = '자재관리.xlsx';
			var sheetTitle = '자재관리';
			var sheetName = '자재관리';

			var param_col_name = "", param_col_id = "", param_col_align = "", param_col_width = "";

			console.log("param_col_name::" + param_col_name);

			var is_rownum = true;

			if (gridCols != null && gridCols.length > 0) {
				for (var i = 0; i < gridCols.length; i++) {
					if (!gridCols[i].hidden) {
						param_col_name += gridCols[i].caption + ",";
						param_col_id += gridCols[i].field + ",";
						param_col_align += "center" + ",";
						param_col_width += (gridCols[i].width == undefined ? "10"
								: (gridCols[i].width).replace('px', ''))
								+ ",";
					}
				}
				param_col_name = param_col_name.substr(0,
						param_col_name.length - 1);
				param_col_id = param_col_id.substr(0, param_col_id.length - 1);
				param_col_align = param_col_align.substr(0,
						param_col_align.length - 1);
				param_col_width = param_col_width.substr(0,
						param_col_width.length - 1);
			}

			var export_url = "/export/export_client_jqgrid";
			var export_data = "file_name=" + encodeURIComponent(fileName);
			export_data += "&sheet_title=" + encodeURIComponent(sheetTitle);
			export_data += "&sheet_name=" + encodeURIComponent(sheetName);
			export_data += "&header_col_names="
					+ encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="
					+ encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="
					+ encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="
					+ encodeURIComponent(param_col_width);
			export_data += "&cmd=" + encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="
					+ encodeURIComponent(JSON.stringify(gridData));

			$.ajax({
				url : export_url,
				data : export_data,
				type : 'POST',
				dataType : 'json',
				success : function(data) {
					if (data.status == 200) {
						var file_path = data.file_path;
						var file_name = data.file_name;
						var protocol = jQuery(location).attr('protocol');
						var host = jQuery(location).attr('host');
						var link_url = "/file/attach_download";
						link_url += "?file_path="
								+ encodeURIComponent(file_path);
						link_url += "&file_name="
								+ encodeURIComponent(file_name);

						$(location).attr('href', link_url);
					}
				},
				complete : function() {
				}
			});
		}

		function maxLengthCheck(object) {

			if (object.value <= 0) {
				$("#m_safety_menge").val('0');
			}

			if (object.value.length > object.maxLength) {
				object.value = object.value.slice(0, object.maxLength);
				// 	        console.log("object.value = " + object.value);

				// 	        console.log("object.value = " + object.maxLength);
			}

			if (object.value > 0 && (object.value).substring(0, 1) == "0") {
				$("#m_safety_menge").val((object.value).substring(1, 2));
			}
		}

		// 미 입력시
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

		function numberChk(s) {
			console.log("s.val() = " + s.val());
			var chkStyle = /[^0-9]/g; //체크 방식(숫자)
			if (chkStyle.test(s.val())) {
				fnMessageModalAlert("알림", "안전재고수량은 숫자만 입력 가능합니다.");
				return true;
			} else {
				return false;
			}
		}

		function initOptions(obj) {
			$(obj).find('option').remove().end()
			//		    .append('<option value="All">-----</option>')
			.val();
		}

		//key 누를때 숫자만 가능하도록.
		function onlyNumber() {

			if ((event.keyCode < 48) || (event.keyCode > 57))

				event.returnValue = false;

		}
		function setComma(n) {
		    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
		    n += '';                          // 숫자를 문자열로 변환         
		    while (reg.test(n)) {
		       n = n.replace(reg, '$1' + ',' + '$2');
		    }         
		    return n;
		}
	</script>

</body>
</html>