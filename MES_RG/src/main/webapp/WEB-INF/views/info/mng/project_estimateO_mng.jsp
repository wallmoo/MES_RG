<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "RealGain"; //SessionUtil.getProperties("mes.company");
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
</head>


<body class="hold-transition skin-<%=thema%> sidebar-mini">
	<!-- <.%=thema%.> -->
	<div class="wrapper">
		<jsp:include page="/common/top_menu_inc" flush="true">
			<jsp:param name="fb_div" value="F" />
			<jsp:param name="page_title" value="0" />
		</jsp:include>

		<jsp:include page="/common/sidebar_menu_inc" flush="true">
			<jsp:param name="menu_div" value="F" />
			<jsp:param name="selected_menu_p_cd" value="1116" />
			<jsp:param name="selected_menu_cd" value="1125" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					구매 견적 관리(관리자용)<small>구매/자재 관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>구매/자재 관리 </a></li>
					<li class="active">구매 견적 관리(담당자용)</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<section class="col-lg-12">
						<div class="box" style="margin-bottom: 0px; border: none;">
							<div id="" class="box-body">
								<div class="row">
									<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
										<div class="col-sm-12">
											<div class="row">
												<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
													<div class="box-header with-border" style="background-color: #DB8EB5;">
														<h3 class="box-title">구매 견적 결과 관리</h3>
														<div class="box-tools pull-right">
															<button type="button" id="btn_excel_csr" onclick="excelFileDownload('grid_list','구매견적 관리');" class="btn btn-success btn-sm">Excel Download</button>
															<button type="button" id="btn_dlv_csr" onclick="makeOrder();" class="btn btn-info btn-sm">구매 발주 등록</button>
															<button type="button" id="btn_ins_csr" onclick="saveEstimate();" class="btn btn-primary btn-sm">등록/수정</button>
															<button type="button" id="btn_search_csr" onclick="loadLeftGrid();" class="btn btn-primary btn-sm" onclick="">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-2">
																	<label>거래처</label> 
																	<select id="S_VDR_IDX" name="S_VDR_IDX" class="form-control" style="height: 30px;" ></select>
																</div>
									
																<div class="col-sm-2">
																	<label>프로젝트명</label> 
																	<input type="text" id="S_PJT_NM" name="S_PJT_NM" placeholder="ex) 프로젝트명"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																</div>
																
																<div class="col-sm-2">
																	<label>견적 요청일</label>
																	<div class="input-group">
																		<input type="text" class="form-control pull-right input-sm" id="S_MTL_EST_REG_DT" placeholder="yyyymmdd~yyyymmdd">
																		<div class="input-group-addon">
																			<i class="fa fa-calendar"></i>
																		</div>
																	</div>
																</div>		
																
																<div class="col-sm-2">
																	<label>품명</label> 
																	<input type="text" id="S_MTL_NM" name="S_MTL_NM" placeholder="ex) 품명"
																	 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																</div>																														
																
																<div class="col-sm-2">
																	<label>제조사</label> 
																	<input type="text" id="S_MTL_MKR_CD" name="S_MTL_MKR_CD" placeholder="ex) 제조사"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																</div>	
																							
																<div class="col-sm-2">
																	<label>제조사 Model No</label> 
																	<input type="text" id="S_MTL_MKR_NO" name="S_MTL_MKR_NO" placeholder="ex) 제조사 Model No"
																	 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																</div>																
															</div>
														</div>
														<div id="grid_list" class="w2g-h600" style="margin-top: 10px;"></div>
													</div>
												</div>
											</div>										
										</div>
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

		<!-- 모달 커팅 -->
		<div class="modal fade" id="modal_orderForm" data-backdrop="static">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_add_title">구매 발주 등록</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
							<div class="col-sm-10">
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">입고 요청 사업장</label>
										<div class="col-sm-6">
											<select id="MTL_ORD_PLC" name="MTL_ORD_PLC" class="form-control" style="height: 30px;" ></select>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">납품요청일자</label>
										<div class="input-group col-sm-6">
											<input type="text" class="form-control pull-right input-sm" id="MTL_ORD_DLV_DT" placeholder="yyyymmdd~yyyymmdd">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>											
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">하자 증권</label>
										<div class="col-sm-6">
											<select id="MTL_ORD_FLE1" name="MTL_ORD_FLE1" class="form-control" style="height: 30px;" >
												<option value="N">No</option>
												<option value="Y">Yes</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">이행 증권</label>
										<div class="col-sm-6">
											<select id="MTL_ORD_FLE1" name="MTL_ORD_FLE2" class="form-control" style="height: 30px;" >
												<option value="N">No</option>
												<option value="Y">Yes</option>
											</select>											
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">계약서</label>
										<div class="col-sm-6">
											<select id="MTL_ORD_FLE1" name="MTL_ORD_FLE3" class="form-control" style="height: 30px;" >
												<option value="N">No</option>
												<option value="Y">Yes</option>
											</select>											
										</div>
									</div>
								</div>																								
							</div>
						<input type="hidden" id="hiddenProduct_code"> 
						<input type="hidden" id="hiddenM_item_code">							
						</form>
					</div>
					<div class="modal-footer" style="border-top-color: transparent !important;">
						<div class="col-md-12 text-center" style="margin-top: 10px">
							<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAddModal()">등록</button>
							<button type="button" id="" class="btn btn-danger btn-sm" data-dismiss="modal">취소</button>
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
	
	<input type="hidden" id="hiddenIdx" name="hiddenIdx" />
	<input type="hidden" id="rightIDX" name="rightIdx" />
	<!-- ./wrapper -->


<script type="text/javascript">
	var startValue_combo = "";
	
	var minDate = getFormatDate(new Date());
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	$(function($) {
		fnCdD('S_PJT_PRD_UNT', 'MC1027');//공통코드를 호출-재고 단위
		requestVendor('S_VDR_IDX');//고객사 정보를 검색폼 드랍다운 형태로 만듬
		requestBranchInfo('MTL_ORD_PLC');//사업장 정복
		
		fnLoadCommonOption();//등록폼 달력
		fnLoadDeliveryOption();//검색폼 달력
		
		fnLoadLeftGrid();
	})


	// fnLoadLeftGrid
	function fnLoadLeftGrid() {
		var rowArr = [];

		$('#grid_list').w2grid({
			name : 'grid_list',
			show : {
				lineNumbers : true,
				footer : true,
				selectColumn : true
			},
			multiSelect : true,
			columns : [ 
				{ field:'est_CD', caption:'구매견적 코드', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_IDX', caption:'프로젝트 번호', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_CD', caption:'프로젝트코드', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'MTL_REQ_IDX', caption:'자재요청 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true, hidden: true},
				{ field:'VDR_IDX', caption:'거래처 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'vdr_NM', caption:'거래처', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_QTY', caption:'요청수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_MOQ', caption:'MOQ', size:'8%', style:'text-align:center;', sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_REG_DT', caption:'견적요청일', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_PRICE', caption:'단가', size:'7%', style:'text-align:center;', sortable: true},
	        	{ field:'mtl_TOT_PRICE', caption:'금액', size:'10%', style:'text-align:center;', sortable: true},
				{ field:'mtl_EST_DLV_DT', caption:'납기가능일', size:'10%', style:'text-align:center;', sortable: true},
				{ field:'mtl_EST_BG', caption:'비고', size:'8%', style:'text-align:center;', sortable: true},
			],			
			
			sortData : [ {
				field : 'EST_IDX',
				direction : 'DESC'
			} 
			],
			records : [], // rowArr
			onSelect : function(event) {
				event.onComplete = function() {

				}
			},
			onUnselect : function(event) {
				event.onComplete = function() {

				}
			},
			onClick : function(event) {

			}
		});

		loadLeftGrid();
	}
	function loadLeftGrid() {//grid_list Data Arr
		console.log("loadLeftGrid()");
		
		var page_url = "/info/info/selectEstimate";
		var postData = "PJT_NM=" + encodeURIComponent($("#S_PJT_NM").val()) 
						/* + "&VDR_IDX=" + encodeURIComponent($("#S_VDR_IDX").val())  */
						+ "&MTL_EST_REG_DT=" + encodeURIComponent($("#S_MTL_EST_REG_DT").val())
						+ "&MTL_NM=" + encodeURIComponent($("#S_MTL_NM").val()) 
						+ "&MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val()) 
						+ "&MTL_MKR_NO=" + encodeURIComponent($("#S_MTL_MKR_NO").val());

		w2ui['grid_list'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData,
			data_type : 'json',
			success : function(data) {
				console.log(data);
				
				if (data.status == 200 && (data.rows).length > 0) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row) {
						row.recid = idx + 1;
						comboValue_nm.push(row.pjt_PRD_NM + "");
						comboValue_cd.push(row.pjt_IDX + "");
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#Business').w2field('combo', {
							items : comboValue_nm,
							match : 'contains'
						});
						$('#Business').w2field('combo', {
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

			}
		});
	}
	function showReqModal() {
		console.log(w2ui.grid_list.get("pjt_IDX"));
		
		var keys = w2ui.grid_list.getSelection();
		var ModalDataList = [];
		
		if (keys == null || keys == "") {
			alert("구매발주를 등록할 항목을 선택하여주십시오");
		} else {
			$(".clear_val").val('');//검색어 초기화

/* 			var insertPJT = $("#hiddenIdx").val();//PJT_IDX
			for (var i = 0; i < keys.length; i++) {
				var Data = {
					//PJT_IDX : encodeURIComponent(insertPJT),
					mtl_REQ_IDX : w2ui.grid_list.records[keys[i]-1].mtl_REQ_IDX,
					pjt_IDX : w2ui.grid_list.records[keys[i]-1].pjt_IDX,
					bom_IDX : w2ui.grid_list.records[keys[i]-1].bom_IDX,
					pjt_CD : w2ui.grid_list.records[keys[i]-1].pjt_CD,
					pjt_NM : w2ui.grid_list.records[keys[i]-1].pjt_NM,
					mtl_IDX : w2ui.grid_list.records[keys[i]-1].mtl_IDX,
					mtl_MKR_CD : w2ui.grid_list.records[keys[i]-1].mtl_MKR_CD,
					mtl_NM : w2ui.grid_list.records[keys[i]-1].mtl_NM,
					mtl_MKR_NO : w2ui.grid_list.records[keys[i]-1].mtl_MKR_NO,
					mtl_STD : w2ui.grid_list.records[keys[i]-1].mtl_STD,
					mtl_UNT : w2ui.grid_list.records[keys[i]-1].mtl_UNT,
					mtl_REQ_QTY : w2ui.grid_list.records[keys[i]-1].mtl_REQ_QTY,
					mtl_REQ_TYPE : w2ui.grid_list.records[keys[i]-1].mtl_REQ_TYPE,
					mtl_REQ_REG_DT : w2ui.grid_list.records[keys[i]-1].mtl_REQ_REG_DT,
					mtl_REQ_REG_ID : w2ui.grid_list.records[keys[i]-1].mtl_REQ_REG_ID
				};
				ModalDataList.push(Data);
			} */
			
			console.log(ModalDataList);
			
			$("#modal_orderForm").modal('show');
			
/* 			$('#hiddenProduct_code').val('');
			$('#hiddenM_item_code').val(''); */
		}
	}
	function makeOrder() {
		showReqModal();
	}
	// ############################
	// init component
	function fnLoadCommonOption() {
	 	console.log('fnLoadCommonOption()');
	 	
		$('#MTL_ORD_DLV_DT').daterangepicker({
			opens: 'right',
			singleDatePicker: true,
			locale: {
				format : 'YYYY-MM-DD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		    startDate : moment(minDate)
		})
		.on("change", function() {
		    loadLeftGrid();
		}); 
	}
	function fnLoadDeliveryOption() {
	 	console.log('fnLoadCommonOption()');
	 	
		$('#S_MTL_EST_REG_DT, #S_PJT_DLV_DT').daterangepicker({
			opens: 'left',
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
 			startDate: moment().subtract(30, 'days').format('YYYY-MM-DD'),
			endDate: moment().format('YYYY-MM-DD'),
		}); 
		
		$('#S_MTL_EST_REG_DT').val("");
		$('#S_PJT_DLV_DT').val("");
		
	}	
	
</script>

</body>
</html>