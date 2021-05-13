<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><%=pageTitle%></title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

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
															<button type="button" id="btn_dlv_csr" onclick="showReqModal();" class="btn btn-info btn-sm">구매 발주 등록</button>
															<button type="button" id="btn_ins_csr" onclick="saveEstimate();" class="btn btn-primary btn-sm">등록/수정</button>
															<button type="button" id="btn_search_csr" onclick="loadLeftGrid();" class="btn btn-primary btn-sm" onclick="">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-2">
																	<label>거래처</label> 
																	<select id="S_VDR_IDX" name="S_VDR_IDX" class="form-control" style="height: 30px;" onChange="loadLeftGrid(); return false;" ></select>
																</div>
									
																<div class="col-sm-2">
																	<label>프로젝트명</label> 
																	 <select id="S_PJT_NM" name="S_PJT_NM" class="form-control" style="height: 30px;" onChange="loadLeftGrid(); return false;"></select>
																</div>
																
																<div class="col-sm-2">
																	<label>견적 요청일</label>
																	<div class="input-group">
																		<input type="text" class="form-control pull-right input-sm" id="S_MTL_EST_REG_DT" placeholder="yyyymmdd~yyyymmdd"
																		onchange="searchs();">
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
										<div class="input-group col-sm-6" style="padding-left:15px;">
											<input type="text" class="form-control pull-right input-sm" id="MTL_ORD_DLV_DT" placeholder="yyyymmdd~yyyymmdd"
											onkeypress="if(event.keyCode==13) {return false;}">
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
											<select id="MTL_ORD_FLE2" name="MTL_ORD_FLE2" class="form-control" style="height: 30px;" >
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
											<select id="MTL_ORD_FLE3" name="MTL_ORD_FLE3" class="form-control" style="height: 30px;" >
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
							<button type="button" id="" class="btn btn-success btn-sm" onclick="makeOrder()">등록</button>
							<button type="button" id="" class="btn btn-danger btn-sm" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>		
		<!--  -->
		
		<!-- 모달 커팅 -->
		<div class="modal fade" id="modal_estimateForm" data-backdrop="static">
			<div class="modal-dialog modal-md" style="width: 1000px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_code_title">견적 요청 등록/수정</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="AddorUpdate" name="AddorUpdate" class="form-horizontal">
							<input type="hidden" name="flag" id="flag">
							<div class="row">
								<div class="col-md-12 text-center">
							
									<label class="col-sm-1 control-label" style="padding-left: 0px">프로젝트명</label>
									<div class="col-sm-4">
										<select id="S_PJT_IDX" name="S_PJT_IDX" class="form-control" style="height: 30px;" onChange="addPopupRequest(); return false;"></select>
									</div>		
									
									<label class="col-sm-1 control-label" style="padding-left: 0px">거래처</label> 					
									<div class="col-sm-4">
										<select id="S_VDR_IDX4" name="S_VDR_IDX4" class="form-control" style="height: 30px;" ></select>
									</div>
									
								</div>
								
								<div class="col-md-5 text-left" style="margin-top:5px;">
									<label class="col-sm-3 control-label" style="padding-left: 0px">견적요청일자</label>
									<div class="input-group">
										<input type="text" class="form-control pull-right input-sm" id="MTL_EST_REG_DT" placeholder="yyyymmdd~yyyymmdd"
										o>
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>	
								</div>								
								<div class="col-sm-12">
									<div id="grid_list_popup" class="w2g-h200" style="margin-top: 10px;"></div>
								</div>
							</div>
						</form>					
						
						<input type="hidden" id="hiddenProduct_code"> 
						<input type="hidden" id="hiddenM_item_code">
					</div>	
					<div class="modal-footer" style="border-top-color: transparent !important;">
						<div class="col-md-12 text-center" style="margin-top: 10px">
							<button type="button" id="" class="btn btn-success btn-sm" onclick="saveEstimatePopup()">저장</button>
							<button type="button" id="" class="btn btn-danger btn-sm" data-dismiss="modal">닫기</button>
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
	
	<input type="hidden" id="hiddenPjtIdx" name="hiddenPjtIdx" />
	<!-- ./wrapper -->


<script type="text/javascript">
	var startValue_combo = "";
	var reqDataList = [];
	
	var minDate = getFormatDate(new Date());
	var loadingEnd = false;
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	$(function($) {
		fnCdD('S_PJT_PRD_UNT', 'MC1027');//공통코드를 호출-재고 단위
		requestVendor('S_VDR_IDX');//고객사 정보를 검색폼 드랍다운 형태로 만듬
		requestVendor('S_VDR_IDX4');//고객사 정보를 검색폼 드랍다운 형태로 만듬
		requestBranchInfo('MTL_ORD_PLC');//사업장 정복
		requestProject('S_PJT_IDX');//프로젝트명 가져오기
		requestProject('S_PJT_NM');//프로젝트명 가져오기
		
		fnLoadCommonOption('#MTL_ORD_DLV_DT');//등록폼 달력
		fnLoadCommonOption('#MTL_ORD_DLV_DT');//등록폼 달력
		fnLoadDeliveryOption('#S_MTL_EST_REG_DT','right');//검색폼 달력
		fnLoadPopupModalGrid();
		fnLoadLeftGrid();
		fnLoadCommonOption();
		loadingEnd=true;
	});
	function searchs(){
		if(loadingEnd){
			loadLeftGrid();
		}
	}

	
	function fnLoadCommonOption() {
	 	console.log('fnLoadCommonOption()');
	 	
		$('#MTL_EST_REG_DT').daterangepicker({
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
		/*
		.on("change", function() {
		    loadRequestGridData();
		}); 
		*/
	}

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
				{ field:'mtl_REQ_IDX', caption:'자재요청 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true, hidden: true},
				{ field:'vdr_IDX', caption:'거래처 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				
				{ field:'vdr_NM', caption:'거래처', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_QTY', caption:'요청수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_MOQ', caption:'MOQ', size:'8%', style:'text-align:center;', sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_REG_DT', caption:'견적요청일', size:'10%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						return html.substring(0,10);
	           		} 
				},
				{ field:'mtl_EST_PRICE', caption:'단가', size:'7%', style:'text-align:center;', sortable: true},
	        	{ field:'mtl_TOT_PRICE', caption:'금액', size:'10%', style:'text-align:center;', sortable: true},
				{ field:'mtl_EST_DLV_DT', caption:'납기가능일', size:'10%', style:'text-align:center;', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);

						return html.substring(0,10);
	           		} 
				},
				{ field:'mtl_EST_BG', caption:'비고', size:'8%', style:'text-align:center;', sortable: true},
			],			
			
			sortData : [ {
				field : 'pjt_IDX',
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
		
		var VDR_IDX_VAL = "";
		var PJT_IDX = "";
		
		if($('#S_VDR_IDX').val() == "ALL") {
			VDR_IDX_VAL = "0";
		} else {
			VDR_IDX_VAL = $('#S_VDR_IDX').val();
		}	
		if($('#S_PJT_NM').val() == "ALL") {
			PJT_IDX = "0";
		} else {
			PJT_IDX = $('#S_PJT_NM').val();
		}			
		var page_url = "/info/info/selectEstimate";
		var postData = "PJT_IDX=" + PJT_IDX
						+ "&MTL_EST_REG_DT=" + encodeURIComponent($("#S_MTL_EST_REG_DT").val())
						+ "&VDR_IDX=" + encodeURIComponent(VDR_IDX_VAL)
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
		
		if($('#S_VDR_IDX').val() == "ALL") {
			alert("거래처 정보를 선택하여주십시오");
			return;
		}			
		if (keys == null || keys == "") {
			alert("구매발주를 등록할 항목을 선택하여주십시오");
		} else {
			$(".clear_val").val('');//검색어 초기화
		
			$("#modal_orderForm").modal('show');
		}
	}

	function makeOrder() {
		var keys = w2ui.grid_list.getSelection();

 		if(MTL_ORD_PLC == "") {
			alert("입고요청 사업장 정보를 선택하여주십시오");
			return;
		} else if(MTL_ORD_DLV_DT == "") {
			alert("납품요청 일자를 선택하여주십시오");			
		} else {
			for (var i = 0; i < keys.length; i++) {
				if(i == 0) {
					$('#hiddenPjtIdx').val(w2ui.grid_list.records[keys[i]-1].pjt_IDX);
				}
				var Data = {
						ORD_IDX : w2ui.grid_list.records[keys[i]-1].ord_IDX,
						PJT_IDX : w2ui.grid_list.records[keys[i]-1].pjt_IDX,
						MTL_IDX : w2ui.grid_list.records[keys[i]-1].mtl_IDX,
						MTL_DTL_PRICE : w2ui.grid_list.records[keys[i]-1].mtl_EST_PRICE,
						MTL_REQ_QTY : w2ui.grid_list.records[keys[i]-1].mtl_REQ_QTY
				};				
				reqDataList.push(Data);
			}
			
			var PJT_IDX = $("#hiddenPjtIdx").val();
			//var PJT_IDX = w2ui.grid_list.records[0].pjt_IDX;
			var VDR_IDX = $("#S_VDR_IDX").val();
			var MTL_ORD_PLC = $("#MTL_ORD_PLC").val();
			var MTL_ORD_DLV_DT = $("#MTL_ORD_DLV_DT").val();
			var MTL_ORD_FLE1 = $("#MTL_ORD_FLE1").val();
			var MTL_ORD_FLE2 = $("#MTL_ORD_FLE2").val();
			var MTL_ORD_FLE3 = $("#MTL_ORD_FLE3").val();
			
			var mstData = {
				'PJT_IDX': PJT_IDX,
				'VDR_IDX': VDR_IDX,
				'MTL_ORD_PLC': MTL_ORD_PLC,
				'MTL_ORD_DLV_DT': MTL_ORD_DLV_DT,
				'MTL_ORD_FLE1': MTL_ORD_FLE1,
				'MTL_ORD_FLE2': MTL_ORD_FLE2,
				'MTL_ORD_FLE3': MTL_ORD_FLE3
			}
			
			if (confirm("등록하시겠습니까?")) {
				console.log(reqDataList);

				var page_url = "/info/info/insertMaterialOrder";
				var jsonData = JSON.stringify({'mstData': mstData, 'reqDataList': reqDataList});
				
				console.log(jsonData);

				jQuery.ajaxSettings.traditional = true;
				$.ajax({
					url : page_url,
					type : 'POST',
					data : {
						"jsonData" : jsonData
					},
					data_type : 'json',
					success : function(data) {
						if (data != 0) {
							alert("추가되었습니다");
							$("#modal_orderForm").modal('hide');
						} else {
							alert("오류가 발생하였습니다");
						}
					},
					complete : function() {

					}
				});
			}				
		}
	}
	
	function saveEstimate() {
		fnLoadCommonOption();
		$("#S_PJT_IDX").val('ALL');
		console.log(w2ui.grid_list.get("pjt_IDX"));
		
		var keys = w2ui.grid_list.getSelection();	
		if (keys == null || keys == "") {
			addEstimates();
			$("#flag").val("I");
			$("#S_PJT_IDX").removeAttr('disabled');
			$("#S_VDR_IDX4").removeAttr('disabled');
		} else {
			editEstimates();
			$("#flag").val("U");
			$("#S_PJT_IDX").attr('disabled',true);
			$("#S_VDR_IDX4").attr('disabled',true);
		}
	}
	
	//grid_list_popup
	function addEstimates(){//등록
		$("#modal_estimateForm").modal('show');	
		addPopupRequest();

	}//addEsimates end
	function editEstimates(){//수정
		$("#modal_estimateForm").modal('show');
		editPopupRequest();
	}//editEstimates end
	
	function fnLoadPopupModalGrid() {
		var rowArr = [];

		$('#grid_list_popup').w2grid({
			name : 'grid_list_popup',
			show : {
				lineNumbers : true,
				footer : true,
				selectColumn : true
			},
			multiSelect : true,
			columns : [ 
				{ field:'est_IDX', caption:'기본IDX', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_REQ_IDX', caption:'자재요청 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_IDX', caption:'프로젝트 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'bom_IDX', caption:'BOM 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_CD', caption:'프로젝트코드', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true, hidden: true},
				{ field:'mtl_REQ_TYPE', caption:'요청 유형', size:'7%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_REQ_REG_DT', caption:'자재 요청일', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_REQ_REG_ID', caption:'요청자', size:'10%', style:'text-align:center', sortable: true},
				{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_QTY', caption:'요청수량', size:'8%', style:'text-align:center', sortable: true, editable:{type: 'int'} }
			],					
			records : [],
			total : 0,
			recordHeight : 30,
			onReload : function(event) { },

			onClick : function(event) {
				console.log(this.get(event.recid));
			},
			onDblClick : function(event) { },
			onChange : function(event) {//갯수 수정
				event.onComplete = function() {//onSave
					console.log("onChange");
					w2ui.grid_list_popup.save();
					
					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
								
				}
			}			
		});
	}	
	
	function addPopupRequest(){ // 팝업창에 있는 그리드 새로고침
		
		var page_url = "/info/info/selectMaterialRequest";
		var pjt_idxs = $("#S_PJT_IDX").val();
		if(pjt_idxs=="ALL"){
			pjt_idxs=0;
		}
		
		var postData = "PJT_IDX=" + pjt_idxs; 
		
		w2ui['grid_list_popup'].lock('loading...', true);
		setTimeout(function(){
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
					w2ui['grid_list_popup'].records = rowArr;
				} else {
					w2ui.grid_list_popup.clear();
				}
				w2ui['grid_list_popup'].refresh();
				w2ui['grid_list_popup'].unlock();
			},
			complete : function() {

			}
		});
		},200);
	}
	
	
	function editPopupRequest(){ // 팝업창에 있는 그리드 새로고침

		w2ui['grid_list_popup'].lock('loading...', true);
		w2ui.grid_list_popup.clear();
		
		var selectList = [];
		var selectval = w2ui.grid_list.getSelection();
		selectList = w2ui.grid_list.get(selectval);
		console.log(selectList);
		setTimeout(function(){
		
					$.each(selectList, function(idx, row) {
						row.recid = idx + 1;
						comboValue_nm.push(row.pjt_PRD_NM + "");
						comboValue_cd.push(row.pjt_IDX + "");
					});
					w2ui['grid_list_popup'].records = selectList;
				w2ui['grid_list_popup'].refresh();
				w2ui['grid_list_popup'].unlock();
			
		},200);
	}
	
	function saveEstimatePopup(){
		var keys = w2ui.grid_list_popup.getSelection();
		var reqDataList = [];
		var mtl_REQ_QTY_val = 0;
		if($("#flag").val()=="I"){
			if($('#S_VDR_IDX4').val() =="ALL") {
				alert("거래처 정보를 선택하여 주십시오");
				return;
			}
			if($("#S_PJT_IDX").val()=="ALL"){
				alert("프로젝트명을 선택하여 주십시오");
				return;
			}
		}
		if (keys == null || keys == "") {
			alert("견적요청할 항목을 선택하여주십시오");
		} else {
			for (var i = 0; i < keys.length; i++) {
				if(w2ui.grid_list_popup.records[keys[i]-1].mtl_REQ_QTY == null) {
					mtl_REQ_QTY_val = 0;
				} else {
					mtl_REQ_QTY_val = w2ui.grid_list_popup.records[keys[i]-1].mtl_REQ_QTY;
				}
				var Data = {
					flag : $("#flag").val(),
					EST_IDX : w2ui.grid_list.records[keys[i]-1].est_IDX,
					MTL_REQ_IDX : w2ui.grid_list.records[keys[i]-1].mtl_REQ_IDX,	
					PJT_IDX : $("#S_PJT_IDX").val(),
					PJT_IDX2 : w2ui.grid_list_popup.records[keys[i]-1].pjt_IDX,
                    BOM_IDX : w2ui.grid_list_popup.records[keys[i]-1].bom_IDX,
					PJT_CD : w2ui.grid_list_popup.records[keys[i]-1].pjt_CD,
					PJT_NM : w2ui.grid_list_popup.records[keys[i]-1].pjt_NM,
					MTL_IDX : w2ui.grid_list_popup.records[keys[i]-1].mtl_IDX,
					MTL_MKR_CD : w2ui.grid_list_popup.records[keys[i]-1].mtl_MKR_CD,
					MTL_NM : w2ui.grid_list_popup.records[keys[i]-1].mtl_NM,
					MTL_MKR_NO : w2ui.grid_list_popup.records[keys[i]-1].mtl_MKR_NO,
					MTL_STD : w2ui.grid_list_popup.records[keys[i]-1].mtl_STD,
					MTL_UNT : w2ui.grid_list_popup.records[keys[i]-1].mtl_UNT,
					MTL_REQ_QTY : mtl_REQ_QTY_val,
					MTL_REQ_TYPE : w2ui.grid_list_popup.records[keys[i]-1].mtl_REQ_TYPE,
					MTL_EST_REG_DT : $('#MTL_EST_REG_DT').val(),
					MTL_EST_REG_ID : w2ui.grid_list_popup.records[keys[i]-1].mtl_REQ_REG_ID,
					S_VDR_IDX3 : $('#S_VDR_IDX4').val()+""
				};
				reqDataList.push(Data);
			}			
			console.log(reqDataList);
			var checkVali=false;
			if (confirm("등록하시겠습니까?")) {
				if($("#flag").val()=="U"){
					var a = w2ui.grid_list_popup.getSelection().length;
					var b = w2ui.grid_list_popup.records.length;
					if(b-a>0){
						if(confirm("현재 선택하신 수는 "+a+"개이며, 전체수는 "+b+"개입니다. 정말 등록하시겠습니까?")){
							checkVali=true;
						}
					}else{
						checkVali=true;
					}
				}else{
					checkVali=true;
				}
				if(checkVali){
					var page_url = "/materials/info/insertEstimate";
					var jsonData = JSON.stringify(reqDataList);
					console.log(jsonData);
	
					jQuery.ajaxSettings.traditional = true;
					$.ajax({
						url : page_url,
						type : 'POST',
						data : {
							"jsonData" : jsonData
						},
						data_type : 'json',
						success : function(data) {
							if (data != 0) {
								alert("추가되었습니다");
								$("#modal_estimateForm").modal('hide');
								w2ui['grid_list'].clear();
								loadLeftGrid();
								$("#AddorUpdate")[0].reset();
							} else {
								alert("오류가 발생하였습니다");
							}
						},
						complete : function() {
	
						}
					});
				}
			}				
		}
		
	}
	
</script>

</body>
</html>