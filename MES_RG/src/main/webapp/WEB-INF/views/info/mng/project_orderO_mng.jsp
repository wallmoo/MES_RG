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
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <title> <%=pageTitle %> </title>
  
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
			<jsp:param name="selected_menu_cd" value="1121" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>구매발주 관리(담당자용) <small>구매/자재 관리</small></h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>구매/자재 관리 </a></li>
					<li class="active">구매발주 관리(담당자용)</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<section class="col-lg-12">
						<div class="box" style="margin-bottom: 0px; border: none;">
							<div class="box-body">
								<div class="row">
									<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
										<div class="col-sm-12">
											<div class="row">
												<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
													<div class="box-header with-border" style="background-color: #DB8EB5;">
														<h3 class="box-title">조회조건 및 기타 관리</h3>
														<div class="box-tools pull-right">
															<button type="button" id="btn_excel_csr" onclick="printFile();" class="btn btn-success btn-sm">발주서(PDF)출력</button>
															<button type="button" id="btn_dlv_csr" onclick="showSimpleOrderModal();" class="btn btn-info btn-sm">약식 발주서 작성</button>
															<button type="button" id="btn_ins_csr" onclick="loadLeftGrid();" class="btn btn-primary btn-sm">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-3">
																	<label>프로젝트명</label> 
																	<select id="S_PJT_IDX" name="S_PJT_IDX" class="form-control" style="height: 30px;" onChange="loadLeftGrid();return false;"></select>
																</div>

																<div class="col-sm-2">
																	<label>납품 요청일</label>
																	<div class="input-group">
																		<input type="text" class="form-control pull-right input-sm" id="S_MTL_ORD_DLV_DT" placeholder="yyyymmdd~yyyymmdd"
																		onchange="searchs();">
																		<div class="input-group-addon">
																			<i class="fa fa-calendar"></i>
																		</div>
																	</div>
																</div>

																<div class="col-sm-2">
																	<label>거래처</label> 
																	<select id="S_VDR_IDX" name="S_VDR_IDX" class="form-control" style="height: 30px;" onChange="loadLeftGrid();return false;"></select>
																</div>																	
															</div>
														</div>
														<div id="grid_list" class="w2g-h300" style="margin-top: 10px;"></div>
													</div>
												</div>
											</div>
										</div>
									
										<div class="col-sm-12">
											<div class="row">
												<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
													<div class="box-header with-border" style="background-color: #DB8EB5;">
														<h3 class="box-title">발주 자재 상세 현황</h3>
														<div class="box-tools pull-right">
															<button type="button" id="btn_excel_csr" onclick="updateAllMTL();" class="btn btn-success btn-sm">일괄 입고 처리</button>
															<button type="button" id="btn_dlv_csr" onclick="showOrdModal();" class="btn btn-info btn-sm">자재 입고 처리</button>
															<!-- <button type="button" id="btn_ins_csr" onclick="bomOrder();" class="btn btn-primary btn-sm">조회</button> -->
														</div>
													</div>
													<div class="box-body">
														<div id="grid_list2" class="w2g-h300" style="margin-top: 10px;"></div>
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
		<div class="modal fade" id="modal_eachOrderForm" data-backdrop="static">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_add_title">자재입고</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
							<div class="col-sm-10">
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">입고 수량</label>
										<div class="col-sm-6">
											<input type="number" id="WHS_HIS_QTY" name="WHS_HIS_QTY" placeholder="ex) 1000" class="form-control input-sm" maxlength="10" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">취소 수량</label>
										<div class="col-sm-6">
											<input type="number" id="WHS_HIS_CANCEL_QTY" name="WHS_HIS_CANCEL_QTY" placeholder="ex) 1000" class="form-control input-sm" maxlength="10" />
										</div>
									</div>
								</div>								
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">입고 일자</label>
										<div class="input-group col-sm-6" style="padding-left:15px;">
											<input type="text" class="form-control pull-right input-sm" id="WHS_HIS_REG_DT" placeholder="yyyymmdd~yyyymmdd">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>											
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-sm-4 control-label">검수 여부</label>
										<div class="col-sm-6">
											<select id="ORD_CHK_STATUS" name="ORD_CHK_STATUS" class="form-control" style="height: 30px;" >
												<option value="Y">검수완료</option>
												<option value="N">검수 중</option>
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
							<button type="button" class="btn btn-success btn-sm" onclick="updateEachMTL()">저장</button>
							<button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>		
		<!--  -->

		<!-- 약식 발주서 작성 -->
		<div class="modal fade" id="modal_simpleOrderForm" data-backdrop="static">
			<div class="modal-dialog modal-md" style="width: 800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_code_title">강제 발주서 발행</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="bom_lvl0" name="bom_lvl0" class="form-horizontal">
							<input type="hidden" name="BOM_IDX" id="BOM_IDX">
							<div class="row">
								<div class="col-md-12 text-center">
									<label class="col-sm-1 control-label" style="padding-left: 0px">제조사</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="text" id="S_Mo_MTL_MKR_CD" name="S_Mo_MTL_MKR_CD" class="form-control input-sm pull-right" placeholder="제조사" 
													onkeypress="if(event.keyCode==13) {loadGridData3(); return false;}" >
									</div>		
									
									<label class="col-sm-1 control-label" style="padding-left: 0px">품목</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="text" id="S_Mo_MTL_NM" name="S_Mo_MTL_NM" class="form-control input-sm pull-right" placeholder="품목" 
													onkeypress="if(event.keyCode==13) {loadGridData3(); return false;}" >
									</div>	
									
									<label class="col-sm-2 control-label" style="padding-left: 0px">제조사 품번</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="text" id="S_Mo_MTL_MKR_NO" name="S_Mo_MTL_MKR_NO" class="form-control input-sm pull-right" placeholder="제조사 품번" 
													onkeypress="if(event.keyCode==13) {loadGridData3(); return false;}" >
									</div>	
									<div class="col-sm-2">
										<button type="button" class="btn btn-default btn-sm" onclick="loadGridData3()">조회</button>
										<button type="button" class="btn btn-success btn-sm" onclick="loadGridData4()">등록</button>
									</div>	
								</div>

								<div class="col-sm-12">
									<div id="grid_list3" class="w2g-h200" style="margin-top: 10px;"></div>
								</div>
							</div>
						</form>
						
						<div class="row">					
							<div class="form-group" style="margin: 30px 0 0">
								<label class="col-sm-2 control-label">프로젝트명</label>
								<div class="col-sm-4">
									<select id="S_Mo_PJT_IDX" name="S_Mo_PJT_IDX" class="form-control" style="height: 30px;margin-bottom:5px;" onChange="addPopupRequest(); return false;"></select>
								</div>		
								
								<label class="col-sm-2 control-label">거래처</label> 					
								<div class="col-sm-4">
									<select id="S_Mo_VDR_IDX" name="S_Mo_VDR_IDX" class="form-control" style="height: 30px;margin-bottom:5px;" ></select>
								</div>
																
								<label class="col-sm-2 control-label">입고 요청 사업장</label>
								<div class="col-sm-4">
									<select id="S_Mo_MTL_ORD_PLC" name="S_Mo_MTL_ORD_PLC" class="form-control" style="height: 30px;" ></select>
								</div>	

								<label class="col-sm-2 control-label">납품요청일자</label>
								<div class="input-group col-sm-3" style="padding-left:15px;">
									<input type="text" class="form-control pull-right input-sm" id="S_Mo_MTL_ORD_DLV_DT" placeholder="yyyymmdd~yyyymmdd"
										onkeypress="if(event.keyCode==13) {return false;}">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
								</div>		
							</div>
							<div class="col-sm-12">
								<div id="grid_list4" class="w2g-h200" style="margin-top: 10px;"></div>
							</div>
						</div>
					</div>	
					
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<button type="button" class="btn btn-danger btn-sm" onclick="makeOrder();">저장</button>
							<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
	<input type="hidden" id="hiddenIdx" name="hiddenIdx" />
	<input type="hidden" id="rightIDX" name="rightIdx" />
	<!-- ./wrapper -->


<script type="text/javascript">
	var rowArr = [];
	var rowArrDtl = [];
	var reqDataList = [];

	var startValue_combo = "";
	
	var minDate = getFormatDate(new Date());
	var loadingEnd = false;
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
		
	$(function($) {
		requestProject('S_PJT_IDX');//프로젝트명 가져오기
		requestProject('S_Mo_PJT_IDX');//프로젝트명 가져오기
		
		requestVendor('S_VDR_IDX');//거래처 정보를 검색폼 드랍다운 형태로 만듬
		requestVendor('S_Mo_VDR_IDX');//거래처 정보를 검색폼 드랍다운 형태로 만듬
		
		requestBranchInfo('MTL_ORD_PLCP');//사업장 정복
		requestBranchInfo('S_Mo_MTL_ORD_PLC');//사업장 정복
		
		fnLoadCommonOption('#WHS_HIS_REG_DT, #S_Mo_MTL_ORD_DLV_DT');
		fnLoadDeliveryOption('#S_MTL_ORD_DLV_DT','right');//검색폼 달력
		
		fnLoadLeftGrid();
		fnLoadRightGrid();

		fnLoadGrid3();
		//loadGridData3();
		
		fnLoadGrid4();
		
		fnLoadPopupModalGrid();
		fnLoadPopupModalGrid2();
		
		loadingEnd=true;
	})

	function showSimpleOrderModal(){	
		loadGridData3();
		
		w2ui['grid_list3'].selectNone();
		w2ui['grid_list4'].refresh();
		
		$("#modal_simpleOrderForm").modal('show');
	}
	
	function searchs(){
		if(loadingEnd){
			loadLeftGrid();
		}
	}
	
	// fnLoadLeftGrid
	function fnLoadLeftGrid() {
		var rowArr = [];

		$('#grid_list').w2grid({
			name : 'grid_list',
			show : {
				lineNumbers : true,
				footer : true
			},
			multiSelect : false,
			columns : [ 
				{ field:'pjt_IDX', caption:'프로젝트 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'vdr_IDX', caption:'거래처 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'ord_IDX', caption:'구매발주 번호', size:'7%', style:'text-align:center', sortable: true},
				{ field:'mtl_ORD_DLV_DT', caption:'납품요청일', size:'7%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
	
						return html.substring(0,10);
	           		} 	
				},
	        	{ field:'vdr_NM', caption:'거래처', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_ORD_PLC', caption:'입고장소', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_ORD_REG_ID', caption:'이메일 발송여부', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == '1') {
							return 'X';
						} else if(html == '2') {
							return 'O';
						} else {
							return 'O';
						}
						return html;
	           		} 					
				}, 
				{ field:'mtl_ORD_FLE1', caption:'하자증권', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == 'N') {
							return 'N';
						} else if(html == 'Y') {
							return 'Y';
						} else {
							var html2='<a href="'+html+'" download>'+html.substring(html.lastIndexOf("/")+1, html.length);
							return html2;
						}
						return html;
           			} 		
				}, 
				{ field:'mtl_ORD_FLE2', caption:'이행증권', size:'8%', style:'text-align:center', sortable: true
           			,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == 'N') {
							return 'N';
						} else if(html == 'Y') {
							return 'Y';
						} else {
							var html2='<a href="'+html+'" download>'+html.substring(html.lastIndexOf("/")+1, html.length);
							return html2;
						}
						return html;
	           		} 		
				},
				{ field:'mtl_ORD_FLE3', caption:'계약서', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == 'N') {
							return 'N';
						} else if(html == 'Y') {
							return 'Y';
						} else {
							var html2='<a href="'+html+'" download>'+html.substring(html.lastIndexOf("/")+1, html.length);
							return html2;
						}
						return html;
	           		} 		
				},
				{ field:'mtl_ORD_STATUS', caption:'거래승인여부', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == 'Y') {
							return '승인';
						} else if(html == 'N') {
							return '거절';
						} else if(html == 'O') {
							return '입고완료';
						} else if(html == 'I') {
							return '진행중';
						}						
						return html;
	           		} 					
				}
			],
			sortData : [ {
				field : 'ord_IDX',
				direction : 'DESC'
			} 
			],
			records : [], // rowArr
			onSelect : function(event) {
				event.onComplete = function() {
					w2ui['grid_list2'].refresh();
					
					// 오른쪽 그리드
					rowArrDtl = [];
					loadRightGrid(this.get(event.recid).ord_IDX);
				}
			},
			onUnselect : function(event) {
				event.onComplete = function() {
					w2ui['grid_list2'].clear();
					w2ui['grid_list2'].refresh();
					comboValue_cd = new Array;
				}
			},
			onClick : function(event) {
				//grid_list2(); // 클릭 이벤트
			}
		});

		loadLeftGrid();
	}
	function loadLeftGrid() {//grid_list Data Arr
		console.log("loadLeftGrid()");

		if($('#S_PJT_IDX').val() == "ALL") {
			PJT_IDX = "0";
		} else {
			PJT_IDX = $('#S_PJT_IDX').val();
		}	
		if($('#S_VDR_IDX').val() == "ALL") {
			VDR_IDX = "0";
		} else {
			VDR_IDX = $('#S_VDR_IDX').val();
		}	
		var page_url = "/info/info/selectMaterialOrder";
		var postData = "PJT_IDX=" + PJT_IDX 
				+ "&MTL_ORD_DLV_DT=" + encodeURIComponent($("#S_MTL_ORD_DLV_DT").val()) 
				+ "&VDR_IDX="   + VDR_IDX;

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
/* 						comboValue_nm.push(row.pjt_PRD_NM + "");
						comboValue_cd.push(row.pjt_IDX + ""); */
					});
					
					//
					w2ui['grid_list'].records = rowArr;
					
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

	function fnLoadRightGrid() {
		$('#grid_list2').w2grid({
			name : 'grid_list2',
			show : {
				lineNumbers : true,
				footer : true,
				selectColumn : true
			},
			multiSelect : true,

			columns : [ 
				{ field:'mtl_REQ_IDX', caption:'구매발주 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_IDX', caption:'프로젝트 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'ord_IDX', caption:'주문발주 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_ORD_DTL_IDX', caption:'발주 상세 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true},
				{ field:'mtl_STD', caption:'재고규격', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'ord_DTL_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} },
				{ field:'ord_DTL_QTY', caption:'발주수량', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_QTY', caption:'입고수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'calcul_cha_QTY', caption:'잔량', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
/* 						var html = this.get(event.recid).ord_DTL_QTY - this.get(event.recid).mtl_QTY;
						return html; */
	           		} 
				},
				{ field:'ord_CHK_STATUS', caption:'검수여부', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == 'Y') {
							return '검수 완료';
						} else {
							return '검수 전';
						}
						return html;
	           		} 
				},
				{ field:'calcul_DLV_DT', caption:'납품일자', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
	
						return html.substring(0,10);
	           		} 	
				},
				{ field:'ord_DTL_STATUS', caption:'Status', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == 'I') {
							return '진행중';
						} else if(html == 'E') {
							return '부분 입고';
						} else if(html == 'A') {
							return '입고';							
						} else {
							return '진행중';
						}
						return html;
	           		} 
				}
			],
			records : [],
			total : 0,
			recordHeight : 30,
			onReload : function(event) { },

			onClick : function(event) {
				console.log(this.get(event.recid));
			},
			onDblClick : function(event) { },
			onChange : function(event) {
				event.onComplete = function() {
					console.log("onChange");

					// # 20200922 콤보에 떠도 , 다 입력하고 엔터쳤을 때 문제 생김

					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
					
					w2ui.grid_list2.save();
				}
			}
		});
	}	
	function loadRightGrid(ord_IDX) {
		console.log(loadRightGrid);
		
		var page_url = "/info/info/selectMaterialOrdDTL";
		var postData = "ORD_IDX=" + encodeURIComponent(ord_IDX);
		
		
		w2ui['grid_list2'].lock('loading...', true);
		w2ui['grid_list2'].clear();
		w2ui['grid_list2'].refresh();
		
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData,
			data_type : 'json',
			success : function(data) {
				console.log(data);
				if (data.status == 200 && (data.rows).length > 0) {
					rowArrDtl = data.rows;
					$.each(rowArrDtl, function(idx, row) {
						row.recid = idx + 1;
						comboValue_cd.push(row.c_item_nm + "");
					});
					w2ui['grid_list2'].records = rowArrDtl;
				} else {
					
				}
				w2ui['grid_list2'].refresh();
				w2ui['grid_list2'].unlock();
			},
			complete : function() {

			}
		});
	}
	//일괄 입고 처리
	function updateAllMTLVO() {		
		console.log(rowArrDtl);
		var keys = w2ui.grid_list.getSelection();
		
		if (rowArrDtl.length < 1) {
			alert("일괄 입고할 구매발주번호를 선택하여주십시오");
		} else {
			var data = w2ui.grid_list.get(keys[0]);			
			var ORD_IDX = data.ord_IDX;//구매발주번호		
			
			if (confirm("일괄 입고처리를 진행하시겠습니까?")) {
				var page_url = "/info/info/updateAllMtlVO";
				var postData = "ORD_IDX=" + encodeURIComponent(ORD_IDX);

				$.ajax({
					url : page_url,
					type : 'POST',
					data : postData,
					data_type : 'json',
					success : function(data) {
						if (data.status == 200 && (data.rows).length > 0) {
							fnMessageModalAlert("결과", "성공하였습니다");
							loadRightGrid(ORD_IDX);
						} else {
							fnMessageModalAlert("오류", data.msg);
						}
					},
					complete : function() {

					}
				});
			}			
		}
	}	
	function updateAllMTL() {		
		console.log(rowArrDtl);
		var keys = w2ui.grid_list.getSelection();
		
		if (rowArrDtl.length < 1) {
			alert("일괄 입고할 구매발주번호를 선택하여주십시오");
		} else {
			var data = w2ui.grid_list.get(keys[0]);			
			var ORD_IDX = data.ord_IDX;//구매발주번호		
			
			for (var i = 0; i < rowArrDtl.length; i++) {
				var Data = {
						ORD_IDX : rowArrDtl[i].ord_IDX,
						MTL_ORD_DTL_IDX : rowArrDtl[i].mtl_ORD_DTL_IDX,
						MTL_IDX : rowArrDtl[i].mtl_IDX,
						WHS_HIS_QTY : rowArrDtl[i].ord_DTL_QTY
				};				
				reqDataList.push(Data);
			}
			
			var mstData = {
				'ORD_IDX': ORD_IDX,
				'WHS_HIS_QTY' : $("#WHS_HIS_QTY").val(),
				'WHS_HIS_CANCEL_QTY' : $("#WHS_HIS_CANCEL_QTY").val(),
				'WHS_HIS_REG_DT' : $("#WHS_HIS_REG_DT").val(),
				'ORD_CHK_STATUS' : $("#ORD_CHK_STATUS").val()
			}
			
			if (confirm("일괄 입고처리를 진행하시겠습니까?")) {
				console.log(reqDataList);

				var page_url = "/info/info/updateAllMTL";
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
						if (data.status == 200) {
							rowArrDtl=[];
							reqDataList=[];

							w2ui.grid_list.clear();
							loadLeftGrid();
							
							w2ui.grid_list2.clear();
							fnMessageModalAlert("결과", "성공하였습니다");
						} else {
							fnMessageModalAlert("오류", data.msg);
						}
					},
					complete : function() {

					}
				});
			}			

		}
	}
	function showOrdModal() {
		var keys = w2ui.grid_list2.getSelection();
		var ModalDataList = [];
		
		if (keys == null || keys == "") {
			alert("개별 입고할 구매발주번호를 선택하여주십시오");
		} else {
			$("#WHS_HIS_QTY").val('');
			$("#WHS_HIS_CANCEL_QTY").val(''); 
			
			$("#modal_eachOrderForm").modal('show');
		}
	}
	//개별 자재 입고 처리
	function updateEachMTL() {
		var keys = w2ui.grid_list2.getSelection();
		var keys2 = w2ui.grid_list.getSelection();
		var ModalDataList = [];
		reqDataList.length=0;
		if (keys == null || keys == "") {
			alert("개별 입고할 구매발주번호를 선택하여주십시오");
		} else {
			var data = w2ui.grid_list.get(keys2[0]);			
			var ORD_IDX = data.ord_IDX;//구매발주번호	

			if($('#WHS_HIS_QTY').val() == "") {
				var WHS_HIS_QTY = "0";
			}
			if($('#WHS_HIS_CANCEL_QTY').val() == "") {
				var WHS_HIS_CANCEL_QTY = "0";
			}
			var mstData = {
					'ORD_IDX': ORD_IDX,
					'WHS_HIS_QTY': $("#WHS_HIS_QTY").val(),
					'WHS_HIS_CANCEL_QTY': $("#WHS_HIS_CANCEL_QTY").val(),
					'WHS_HIS_REG_DT': $("#WHS_HIS_REG_DT").val(),
					'ORD_CHK_STATUS': $("#ORD_CHK_STATUS").val()
				}			
			
			for (var i = 0; i < keys.length; i++) {
				var DataList = {
					ORD_IDX : w2ui.grid_list2.records[keys[i]].ord_IDX,
					MTL_ORD_DTL_IDX : w2ui.grid_list2.records[keys[i]].mtl_ORD_DTL_IDX,
					MTL_IDX : w2ui.grid_list2.records[keys[i]].mtl_IDX,
					WHS_HIS_QTY : w2ui.grid_list2.records[keys[i]].ord_DTL_QTY,
					WHS_HIS_QTY : WHS_HIS_QTY
				};
				reqDataList.push(DataList);
			}			

			if (confirm("등록하시겠습니까?")) {
				console.log(reqDataList);

				var page_url = "/info/info/updateEachMTL";
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
						if (data.status == 200 ) {
							rowArrDtl=[];
							reqDataList=[];

							w2ui.grid_list.clear();
							loadLeftGrid();
							
							w2ui.grid_list2.clear();

							fnMessageModalAlert("결과", "성공하였습니다");
							$("#modal_eachOrderForm").modal('hide');
						} else {
							fnMessageModalAlert("오류", data.msg);
						}
					},
					complete : function() {

					}
				});
			}
		}		
	}
	function printFile(){
		var key=w2ui.grid_list.getSelection();
		if(key.length==0){
			alert("출력하실 발주번호를 클릭해주세요.");
			return false;
		}else{
		var ORD_IDXS = w2ui.grid_list.get(key[0]).ord_IDX;
		var url = "/materials/print?ORD_IDX="+ORD_IDXS;
		var option = "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=800, height=700, left=0, top=0";
		window.open(url,"팝업미리보기",option);
		}
	}
	
	function fnLoadPopupModalGrid() {
		var rowArr = [];

		$('#modal_grid_1').w2grid({
			name : 'modal_grid_1',
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
					w2ui.modal_grid_1.save();
					
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
			
			w2ui['modal_grid_1'].lock('loading...', true);
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
						w2ui['modal_grid_1'].records = rowArr;
					} else {
						w2ui.modal_grid_1.clear();
					}
					w2ui['modal_grid_1'].refresh();
					w2ui['modal_grid_1'].unlock();
				},
				complete : function() {

				}
			});
			},200);
		}

	function saveEstimatePopup(){
		var keys = w2ui.modal_grid_1.getSelection();
		var reqDataList = [];
		var mtl_REQ_QTY_val = 0;
		
		if (keys == null || keys == "") {
			alert("견적요청할 항목을 선택하여주십시오");
		} else {
			for (var i = 0; i < keys.length; i++) {
				if(w2ui.modal_grid_1.records[keys[i]-1].mtl_REQ_QTY == null) {
					mtl_REQ_QTY_val = 0;
				} else {
					mtl_REQ_QTY_val = w2ui.modal_grid_1.records[keys[i]-1].mtl_REQ_QTY;
				}
				var Data = {
					flag : "I",
					EST_IDX : w2ui.modal_grid_1.records[keys[i]-1].est_IDX,
					MTL_REQ_IDX : w2ui.modal_grid_1.records[keys[i]-1].mtl_REQ_IDX,	
					PJT_IDX : $("#S_PJT_IDX").val(),
					PJT_IDX2 : w2ui.modal_grid_1.records[keys[i]-1].pjt_IDX,
					BOM_IDX : w2ui.modal_grid_1.records[keys[i]-1].bom_IDX,
					PJT_CD : w2ui.modal_grid_1.records[keys[i]-1].pjt_CD,
					PJT_NM : w2ui.modal_grid_1.records[keys[i]-1].pjt_NM,
					MTL_IDX : w2ui.modal_grid_1.records[keys[i]-1].mtl_IDX,
					MTL_MKR_CD : w2ui.modal_grid_1.records[keys[i]-1].mtl_MKR_CD,
					MTL_NM : w2ui.modal_grid_1.records[keys[i]-1].mtl_NM,
					MTL_MKR_NO : w2ui.modal_grid_1.records[keys[i]-1].mtl_MKR_NO,
					MTL_STD : w2ui.modal_grid_1.records[keys[i]-1].mtl_STD,
					MTL_UNT : w2ui.modal_grid_1.records[keys[i]-1].mtl_UNT,
					MTL_REQ_QTY : mtl_REQ_QTY_val,
					MTL_REQ_TYPE : w2ui.modal_grid_1.records[keys[i]-1].mtl_REQ_TYPE,
					MTL_EST_REG_DT : $('#MTL_EST_REG_DT').val(),
					MTL_EST_REG_ID : w2ui.modal_grid_1.records[keys[i]-1].mtl_REQ_REG_ID,
					S_VDR_IDX3 : $('#S_VDR_IDX').val()+""
				};
				reqDataList.push(Data);
			}			
			console.log(reqDataList);
			var checkVali=false;
			if (confirm("등록하시겠습니까?")) {
					var a = w2ui.modal_grid_1.getSelection().length;
					var b = w2ui.modal_grid_1.records.length;
					if(b-a>0){
						if(confirm("현재 선택하신 수는 "+a+"개이며, 전체수는 "+b+"개입니다. 정말 등록하시겠습니까?")){
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
								w2ui['modal_grid_1'].clear();
								addPopupRequest();
								addPopupRequest2();
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
	function fnLoadPopupModalGrid2() {
		var rowArr = [];

		$('#modal_grid_2').w2grid({
			name : 'modal_grid_2',
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
				{ field:'pjt_CD', caption:'프로젝트코드', size:'12%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true, hidden: true},
				{ field:'mtl_REQ_TYPE', caption:'요청 유형', size:'7%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_REG_DT', caption:'자재 요청일', size:'7%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_REG_ID', caption:'요청자', size:'7%', style:'text-align:center', sortable: true},
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
					w2ui.modal_grid_2.save();
					
					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
								
				}
			}			
		});
	}	
	function addPopupRequest2() {//grid_list Data Arr
		
		var VDR_IDX_VAL = $('#S_VDR_IDX').val();
		var PJT_IDX = $('#S_PJT_IDX').val();	
		
		var page_url = "/info/info/selectEstimate";
		var postData = "PJT_NM=" + encodeURIComponent($("#S_PJT_NM").val()) 
						+ "&MTL_EST_REG_DT=" + encodeURIComponent($("#S_MTL_EST_REG_DT").val())
						+ "&VDR_IDX=" + encodeURIComponent(VDR_IDX_VAL)
						+ "&MTL_NM=" + encodeURIComponent($("#S_MTL_NM").val()) 
						+ "&MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val()) 
						+ "&MTL_MKR_NO=" + encodeURIComponent($("#S_MTL_MKR_NO").val())
						+ "&PJT_IDX=" + encodeURIComponent(PJT_IDX);

		w2ui['modal_grid_2'].lock('loading...', true);
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
					w2ui['modal_grid_2'].records = rowArr;
				} else {
					w2ui.modal_grid_2.clear();
				}
				w2ui['modal_grid_2'].refresh();
				w2ui['modal_grid_2'].unlock();
			},
			complete : function() {

			}
			});
		},200);
	}

	function saveEstimatePopup2() {
			var keys = w2ui.modal_grid_2.getSelection();
			/*
			if(MTL_ORD_PLC == "") {
				alert("입고요청 사업장 정보를 선택하여주십시오");
				return;
			} else if(MTL_ORD_DLV_DT == "") {
				alert("납품요청 일자를 선택하여주십시오");			
			} else {
			*/
				for (var i = 0; i < keys.length; i++) {
					var Data = {
							ORD_IDX : w2ui.modal_grid_2.records[keys[i]].ord_IDX,
							PJT_IDX : w2ui.modal_grid_2.records[keys[i]].pjt_IDX,
							MTL_IDX : w2ui.modal_grid_2.records[keys[i]].mtl_IDX,
							MTL_DTL_PRICE : w2ui.modal_grid_2.records[keys[i]].mtl_EST_PRICE,
							MTL_REQ_QTY : w2ui.modal_grid_2.records[keys[i]].mtl_REQ_QTY
					};				
					reqDataList.push(Data);
				}
				var PJT_IDX = $("#PJT_IDX").val();
				//var PJT_IDX = w2ui.grid_list.records[0].pjt_IDX;
				var VDR_IDX = $("#S_VDR_IDX").val();
				var MTL_ORD_PLC = $("#MTL_ORD_PLCP").val();
				var MTL_ORD_DLV_DT = $("#MTL_ORD_DLV_DTP").val();
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

	function fnLoadGrid3() {
		$('#grid_list3').w2grid({
			name : 'grid_list3',
			show : {
				lineNumbers : true,
				selectColumn : true,
				toolbarSave : true
			},
			multiSelect : true,
	        columns: [                
	        	{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'mtl_CATE', caption:'자재 분류', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} 
				},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true}
			], 
			sortData: [{field: 'mtl_IDX', direction: 'DESC'}],			
			records : [],
			total : 0,
			recordHeight : 30,
			onReload : function(event) {
				
			},
			onSelect : function(event) {

			},
			onUnselect : function(event) {

			}
		});

		//loadGridData3();
	}
	function loadGridData3() {	
		console.log("loadGridData3()");
		var rowArr = [];
		
		var page_url = "/info/account/selectMaterial";
		var postData = "MTL_MKR_CD=" + encodeURIComponent($("#S_Mo_MTL_MKR_CD").val())
					  + "&MTL_NM="   + encodeURIComponent($("#S_Mo_MTL_NM").val())
					  + "&MTL_MKR_NO="+ encodeURIComponent($("#S_Mo_MTL_MKR_NO").val());
		//postData ="";

		w2ui['grid_list3'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				comboValue_cd = new Array;
				comboValue_nm = new Array;
				
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						
						if (startValue_combo == "") {
							comboValue_nm.push(row.mtl_NM ? row.mtl_NM + '' : '');
							comboValue_cd.push(row.mtl_IDX ? row.mtl_IDX + '' : '');
						}
					});
					
					w2ui['grid_list3'].records = rowArr;
					
					if (startValue_combo == "") {
						$('#MTL_NM').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#MTL_IDX').w2field('combo', { items: comboValue_cd, match : 'contains' });
					}
				} else {
					
				}
				
				w2ui['grid_list3'].refresh();
				w2ui['grid_list3'].unlock();
			},complete: function () {

			}
		});		
	}
	function fnLoadGrid4(){
		$('#grid_list4').w2grid({
			name : 'grid_list4',
			show : {
				lineNumbers : true,
				footer : true,
				selectColumn : false
			},
			multiSelect : false,
			columns : [
	        	{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'mtl_CATE', caption:'자재 분류', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center;background-color:#fff1ce;', sortable: true, editable:{type: 'int'}
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		}
				},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'ord_DTL_QTY', caption:'발주수량', size:'8%', style:'text-align:center;background-color:#fff1ce;', sortable: true, editable:{type: 'int'} 
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} 				
				}
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
					w2ui.grid_list4.save();
					
					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
								
				}
			}			
	    });

		//loadGridData4();
	}
	
	var rowArrData = [];
	function loadGridData4(){		
		var keys = w2ui.grid_list3.getSelection();//BOM 자료중 선택된 데이터만 전송
		rowArrData.length = 0;//array 초기화
		
		for (var i = 0; i < keys.length; i++) {
			var Data = {
				mtl_IDX : w2ui.grid_list3.records[keys[i]-1].mtl_IDX,
				mtl_CATE : w2ui.grid_list3.records[keys[i]-1].mtl_CATE,
				mtl_NM : w2ui.grid_list3.records[keys[i]-1].mtl_NM,
				mtl_MKR_NO : w2ui.grid_list3.records[keys[i]-1].mtl_MKR_NO,
				mtl_STD : w2ui.grid_list3.records[keys[i]-1].mtl_STD,
				mtl_MKR_CD : w2ui.grid_list3.records[keys[i]-1].mtl_MKR_CD,
				mtl_PRICE : w2ui.grid_list3.records[keys[i]-1].mtl_PRICE,
				mtl_UNT : w2ui.grid_list3.records[keys[i]-1].mtl_UNT,
				ord_DTL_QTY : w2ui.grid_list3.records[keys[i]-1].ord_DTL_QTY
			};
			rowArrData.push(Data);
		}

		w2ui['grid_list4'].lock('loading...', true);		
 		$.each(rowArrData, function(idx, row) {
			row.recid = idx + 1;
			comboValue_cd.push(row.c_item_nm + "");
		}); 
		console.log(rowArrData);
		//w2uid['grid_list4'].clear();
		w2ui['grid_list4'].refresh();
		w2ui['grid_list4'].records = rowArrData;
		w2ui['grid_list4'].unlock();		
	}
	function addOrderMtl() {
		console.log(w2ui.grid_list2.get("PJT_IDX"));
		
		$("#MTL_REQ_REG_ID").val("${memberNm}");
	
		var keys = w2ui.grid_list2.getSelection();//BOM 자료중 선택된 데이터만 전송
		var ModalDataList = [];
		
		if (keys == null || keys == "") {
			alert("요청할 항목을 선택하여주십시오");
		} else {
			$(".clear_val").val('');//검색어 초기화

			var insertPJT = $("#hiddenPjtIdx").val();//PJT_IDX
			
			for (var i = 0; i < keys.length; i++) {
				var Data = {
					bom_IDX : w2ui.grid_list2.records[keys[i]-1].bom_IDX,
					pjt_IDX : w2ui.grid_list2.records[keys[i]-1].pjt_IDX,
					mtl_IDX : w2ui.grid_list2.records[keys[i]-1].mtl_IDX,
					mtl_QTY : w2ui.grid_list2.records[keys[i]-1].mtl_QTY,
					mtl_NM : w2ui.grid_list2.records[keys[i]-1].mtl_NM,
					mtl_MKR_NO : w2ui.grid_list2.records[keys[i]-1].mtl_MKR_NO,
					mtl_STD : w2ui.grid_list2.records[keys[i]-1].mtl_STD,
					mtl_UNT : w2ui.grid_list2.records[keys[i]-1].mtl_UNT,
					bom_MTL_QTY : w2ui.grid_list2.records[keys[i]-1].bom_MTL_QTY,
					mtl_REQ_QTY : w2ui.grid_list2.records[keys[i]-1].mtl_REQ_QTY					
				};
				ModalDataList.push(Data);
			}
			
			console.log(ModalDataList);
			
			$("#modal_bomReqForm").modal('show');
			
			setTimeout(function() {
				w2ui['grid_list4'].resize();
				w2ui['grid_list4'].refresh();				
			}, 200);
			
			loadModalGridData(ModalDataList);

			$('#hiddenProduct_code').val('');
			$('#hiddenM_item_code').val('');
		}		
	}
	//강제 발주 등록
	function makeOrder() {
		if(rowArrData.length < 1) {
			fnMessageModalAlert("알림", "구매발주를 등록할 항목을 선택하여주십시오");
		} else if($('#S_Mo_VDR_IDX').val() == "ALL") {
			fnMessageModalAlert("알림", "거래처 정보를 선택하여주십시오");
		} else if($('#S_Mo_MTL_ORD_PLC').val() == "ALL") {
			fnMessageModalAlert("알림", "입고요청 사업장 정보를 선택하여주십시오");
		} else if($('#S_Mo_MTL_ORD_DLV_DT').val() == "") {
			fnMessageModalAlert("알림", "납품요청 일자를 선택하여주십시오");
		} else {			
			var reqDataList = [];
			
			if($('#S_Mo_PJT_IDX').val() == "ALL") {
				PJT_IDX = "0";
			} else {
				PJT_IDX = $('#S_Mo_PJT_IDX').val();
			}	
			var PJT_IDX = PJT_IDX;
			var VDR_IDX = $("#S_Mo_VDR_IDX").val();
			var MTL_ORD_PLC = $("#S_Mo_MTL_ORD_PLC").val();
			var MTL_ORD_DLV_DT = $("#S_Mo_MTL_ORD_DLV_DT").val();
			var MTL_ORD_FLE1 = "N";
			var MTL_ORD_FLE2 = "N";
			var MTL_ORD_FLE3 = "N";
			var MTL_ORD_TYPE = "2";
			
			var mtl_PRICE = 0;
			var ord_DTL_QTY = 0;
			for (var i = 0; i < rowArrData.length; i++) {
				if(rowArrData[i].mtl_PRICE != null) mtl_PRICE = rowArrData[i].mtl_PRICE;
				else mtl_PRICE = 0;
				
				if(rowArrData[i].ord_DTL_QTY != null) ord_DTL_QTY = rowArrData[i].ord_DTL_QTY; 
				else ord_DTL_QTY = 0;
				
				var Data = {
					PJT_IDX : PJT_IDX,
					MTL_IDX : rowArrData[i].mtl_IDX,
					MTL_DTL_PRICE : mtl_PRICE,
					MTL_REQ_QTY : ord_DTL_QTY
				};				
				reqDataList.push(Data);
			}

			var mstData = {
				'PJT_IDX': PJT_IDX,
				'VDR_IDX': VDR_IDX,
				'MTL_ORD_PLC': MTL_ORD_PLC,
				'MTL_ORD_DLV_DT': MTL_ORD_DLV_DT,
				'MTL_ORD_TYPE': MTL_ORD_TYPE,
				'MTL_ORD_FLE1': MTL_ORD_FLE1,
				'MTL_ORD_FLE2': MTL_ORD_FLE2,
				'MTL_ORD_FLE3': MTL_ORD_FLE3
			}
			
			if (confirm("등록하시겠습니까?")) {
				console.log("makeOrder:");
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
							loadLeftGrid();
							
							alert("추가되었습니다");
							$("#modal_simpleOrderForm").modal('hide');
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


</script>

</body>
</html>