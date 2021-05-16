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
			<jsp:param name="selected_menu_cd" value="1120" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					구매 발주 관리(거래처용)<small>구매/자재 관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>구매/자재 관리 </a></li>
					<li class="active">구매 발주 관리(거래처용)</li>
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
															<button type="button" id="btn_excel_csr" onclick="printFile();" class="btn btn-success btn-sm">발주서(PDF)출력</button>
															<button type="button" id="btn_dlv_csr" onclick="orderFile();" class="btn btn-info btn-sm">파일첨부</button>
															<button type="button" id="btn_ins_csr" onclick="acceptOrder('Y');" class="btn btn-primary btn-sm">승인</button>
															<button type="button" id="btn_search_csr" onclick="acceptOrder('N');" class="btn btn-danger btn-sm" onclick="">거절</button>
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

																<div class="col-sm-2" style="display:none;">
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
			<div class="modal fade" id="modal_plus_file" data-backdrop="static">
				<div class="modal-dialog modal-md">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="modal_code_title">등록</h4>
			        	</div>
						<div class="modal-body" id="modal_code_body">
							<form id="frm_fileUpload" name="frm_fileUpload" class="form-horizontal"
							method="POST" enctype="multipart/form-data">	
								<input type="hidden" id="upload_mode"/>
								<input type="hidden" class="clear_field" id="mod_file_group"/>
								<input type="hidden" class="clear_field" id="mod_file_no"/>	
								<input type="hidden" id="FILE_ORD_IDX" name="FILE_ORD_IDX"/>		
								
								<div class="row">
									<label class="col-sm-3 control-label">하자증권 파일</label>
									<div class="col-sm-7" style="padding-right: 0px;">
										<input type="text" id="MTL_ORD_FLE1_NAME" name="MTL_ORD_FLE1_NAME" class="form-control input-sm clear_field" readonly>
									</div>	
									<div class="col-sm-1" style="padding-left: 7px;">
										<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
											<input id="file_group" type="file" class="fileupload file_info" name="MTL_ORD_FLE1" onchange="$('#MTL_ORD_FLE1_NAME').val(this.value)">
										</span>
									</div>
								</div>
								<br/>		
								
								<div class="row">
									<label class="col-sm-3 control-label">이행증권 파일</label>
									<div class="col-sm-7" style="padding-right: 0px;">
										<input type="text" id="MTL_ORD_FLE2_NAME" name="MTL_ORD_FLE2_NAME" class="form-control input-sm clear_field" readonly>
									</div>	
									<div class="col-sm-1" style="padding-left: 7px;">
										<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
											<input id="file_group" type="file" class="fileupload file_info" name="MTL_ORD_FLE2" onchange="$('#MTL_ORD_FLE2_NAME').val(this.value)">
										</span>
									</div>
								</div>	
								<br/>
								
								<div class="row">
									<label class="col-sm-3 control-label">게약서 파일</label>
									<div class="col-sm-7" style="padding-right: 0px;">
										<input type="text" id="MTL_ORD_FLE3_NAME" name="MTL_ORD_FLE3_NAME" class="form-control input-sm clear_field" readonly>
									</div>	
									<div class="col-sm-1" style="padding-left: 7px;">
										<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
											<input id="file_group" type="file" class="fileupload file_info" name="MTL_ORD_FLE3" onchange="$('#MTL_ORD_FLE3_NAME').val(this.value)">
										</span>
									</div>
								</div>				
								<br/>
								
								<div class="row">
									<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<div class="col-md-12 text-center">
								<button type="button" id="" class="btn btn-success btn-sm" onclick="saveFile();">저장</button>
								<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
	<form id="testFrm" name="testFrm" class="form-horizontal"
							method="POST" enctype="multipart/form-data">
		<input type="hidden" id="dummy" name="dummy" value="dummy">
	</form>
	<!-- ./wrapper -->


<script type="text/javascript">

	var grid_material_data;
	var grid_add_data;
	var grid_lev1_data;
	var grid_lev2_data;
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

	function fnLoadRightGrid() {
		var rowArr = [];

		$('#grid_list2').w2grid({
			name : 'grid_list2',
			show : {
				lineNumbers : true,
				footer : true,
				selectColumn : true
			},
			multiSelect : false,

			columns : [ 
				{ field:'mtl_REQ_IDX', caption:'구매발주 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_IDX', caption:'프로젝트 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				
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
	           		} 
				},
				{ field:'ord_DTL_QTY', caption:'발주수량', size:'10%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} 	
				},
				{ field:'calcul_QTY', caption:'입고수량', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} 	
				},
				{ field:'calcul_cha_QTY', caption:'잔량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'ord_CHK_STATUS', caption:'검수여부', size:'8%', style:'text-align:center', sortable: true},
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
					rowArr = data.rows;
					$.each(rowArr, function(idx, row) {
						row.recid = idx + 1;
						comboValue_cd.push(row.c_item_nm + "");
					});
					w2ui['grid_list2'].records = rowArr;
				} else {
					
				}
				w2ui['grid_list2'].refresh();
				w2ui['grid_list2'].unlock();

				requestRightGrid('grid_list2');
			},
			complete : function() {

			}
		});
	}
	function requestRightGrid(gridname) {
		$("#rightIDX").val(gridname);
		var cnm = $('#r_mt_name').val();
		if (cnm == '' || cnm == null) {
			return;
		}
		var list = w2ui[gridname].records;
		for (i = 0; list.length > i; i++) {
			var num = i + 1;
			if (list[i].c_item_nm.indexOf(cnm) !== -1) {
				$('#grid_' + gridname + '_rec_' + num + ' > td').css({ "color" : "red" });
			} else {
				$('#grid_' + gridname + '_rec_' + num + ' > td').css({ "color" : "black" });
			}
		}
	}

	//구매발주 승인/거절
	function acceptOrder(val) {
		var keys = w2ui.grid_list.getSelection();
		
		if (val == null || val == "") {
			alert("비정상 작동입니다.");
			return false;
		}
		
		if (keys == null || keys == "") {
			alert("처리할 구매발주를 선택하여주십시오");
		} else {
			var data = w2ui.grid_list.get(keys[0]);			
			var ORD_IDX = data.ord_IDX;//구매발주번호	

			if (confirm("진행하시겠습니까?")) {

				var page_url = "/info/info/acceptOrder";
				var postData = "ORD_IDX=" + ORD_IDX
							+"&MTL_ORD_STATUS=" + val;

				w2ui['grid_list'].lock('loading...', true);
				$.ajax({
					url : page_url,
					type : 'POST',
					data : postData,
					data_type : 'json',
					success : function(data) {
						if (data != 0) {
							w2ui.grid_list.clear();
							loadLeftGrid();
							w2ui.grid_list2.clear();
							alert("처리되었습니다");

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

	function orderFile(){
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "파일을 첨부할 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else{
			$("#modal_plus_file").modal('show');
			$("#FILE_ORD_IDX").val(w2ui.grid_list.get(key[0]).ord_IDX);
			}
	}
	//frm_fileUpload
	function saveFile(){
		if(confirm("저장하시겠습니까?")){

		
		var strUrl = "/info/account/saveBranch";
		strUrl = "/info/account/testUpload";
		var form = $("#frm_fileUpload")[0];
		
		var data = new FormData(form);
				 
		// escape(
		
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: strUrl,
			data: data,
			processData: false,
			contentType: false,
			cache: false,
			timeout: 600000,
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	loadLeftGrid();
					form.reset();
			    	$("#modal_plus_file").modal('hide');
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
		    }
		});
		}//if end
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
</script>

</body>
</html>