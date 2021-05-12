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
			<jsp:param name="selected_menu_cd" value="1121" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					구매발주 관리(담당자용)<small>구매/자재 관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>구매/자재 관리 </a></li>
					<li class="active">구매발주 관리(담당자용)</li>
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
														<h3 class="box-title">조회조건 및 기타 관리</h3>
														<div class="box-tools pull-right">
															<button type="button" id="btn_excel_csr" onclick="makeOrdPDF();" class="btn btn-success btn-sm">발주서(PDF)출력</button>
															<button type="button" id="btn_dlv_csr" onclick="showOrdModal();" class="btn btn-info btn-sm">약식 발주서 작성</button>
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
							<button type="button" id="" class="btn btn-success btn-sm" onclick="updateEachMTL()">저장</button>
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
	var rowArr = [];
	var rowArrDtl = [];
	var reqDataList = [];

	var startValue_combo = "";
	
	var minDate = getFormatDate(new Date());
	var loadingEnd = false;
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	comboValue_nm3 = new Array;
	comboValue_cd3 = new Array;
	
	$(function($) {
		requestProject('S_PJT_IDX');//프로젝트명 가져오기
		requestVendor('S_VDR_IDX');//거래처 정보를 검색폼 드랍다운 형태로 만듬
	
		fnLoadCommonOption('#WHS_HIS_REG_DT');
		fnLoadDeliveryOption('#S_MTL_ORD_DLV_DT','right');//검색폼 달력
		
		fnLoadLeftGrid();
		fnLoadRightGrid();
		loadingEnd=true;
	})

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
				{ field:'mtl_ORD_DLV_DT', caption:'납품요청일', size:'7%', style:'text-align:center', sortable: true},
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
						
						if(html == '1') {
							return 'X';
						} else if(html == '2') {
							return 'O';
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
						
						if(html == '1') {
							return 'X';
						} else if(html == '2') {
							return 'O';
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
						} else {
							return '승인';
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
				{ field:'ord_DTL_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true},
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
				{ field:'calcul_DLV_DT', caption:'납품일자', size:'8%', style:'text-align:center', sortable: true},
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
						if (data != 0) {
							alert("추가되었습니다");
							loadRightGrid(ORD_IDX);
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
				'WHS_HIS_QTY' : WHS_HIS_QTY,
				'WHS_HIS_CANCEL_QTY' : WHS_HIS_CANCEL_QTY,
				'WHS_HIS_REG_DT' : WHS_HIS_REG_DT,
				'ORD_CHK_STATUS' : ORD_CHK_STATUS
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
						if (data != 0) {
							rowArrDtl=[];
							reqDataList=[];

							w2ui.grid_list.clear();
							loadLeftGrid();
							
							w2ui.grid_list2.clear();
							
							alert("추가되었습니다");
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
	function showOrdModal() {
		var keys = w2ui.grid_list2.getSelection();
		var ModalDataList = [];
		
		if (keys == null || keys == "") {
			alert("개별 입고할 구매발주번호를 선택하여주십시오");
		} else {
/* 			$("#WHS_HIS_QTY").val() = "";
			$("#WHS_HIS_CANCEL_QTY").val() = ""; */
			
			$("#modal_eachOrderForm").modal('show');
		}
	}
	//개별 자재 입고 처리
	function updateEachMTL() {
		var keys = w2ui.grid_list2.getSelection();
		var ModalDataList = [];
		
		if (keys == null || keys == "") {
			alert("개별 입고할 구매발주번호를 선택하여주십시오");
		} else {
			var data = w2ui.grid_list.get(keys[0]);			
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
					ORD_IDX : w2ui.grid_list2.records[keys[i]-1].ord_IDX,
					MTL_ORD_DTL_IDX : w2ui.grid_list2.records[keys[i]-1].mtl_ORD_DTL_IDX,
					MTL_IDX : w2ui.grid_list2.records[keys[i]-1].mtl_IDX,
					WHS_HIS_QTY : w2ui.grid_list2.records[keys[i]-1].ord_DTL_QTY,
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
						if (data != 0) {
							rowArrDtl=[];
							reqDataList=[];

							w2ui.grid_list.clear();
							loadLeftGrid();
							
							w2ui.grid_list2.clear();
							
							alert("추가되었습니다");
							
							$("#modal_eachOrderForm").modal('hide');
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