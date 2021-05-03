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
			<jsp:param name="selected_menu_cd" value="1118" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					자재  요청 관리(담당자용)<small>구매/자재 관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>구매/자재 관리 </a></li>
					<li class="active">자재  요청 관리(담당자용)</li>
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
														<h3 class="box-title">프로젝트 정보</h3>
														<div class="box-tools pull-right">
															<button type="button" id="btn_dlv_csr" onclick="bomNewOrder();" class="btn btn-info btn-sm">불출 처리</button>
															<button type="button" id="btn_ins_csr" onclick="bomOrder();" class="btn btn-primary btn-sm">견적 요청</button>															
															<button type="button" id="btn_search_csr" onclick="loadLeftGrid();" class="btn btn-warning btn-sm">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-2">
																	<label>자재 요청일</label> 
																	<input type="text" id="S_PJT_GRD" name="S_PJT_GRD" placeholder="ex) 프로젝트 등급"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGridData(); return false;}"/>
																</div>
																
																<div class="col-sm-2">
																	<label>제조사</label> 
																	<select id="S_CST_IDX" name="S_CST_IDX" class="form-control" style="height: 30px;" ></select>
																</div>	
																				
																<div class="col-sm-2">
																	<label>품목</label> 
																	<input type="text" id="S_PJT_NM" name="S_PJT_NM" placeholder="ex) 프로젝트명"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGridData(); return false;}"/>
																</div>
																																							
																<div class="col-sm-2">
																	<label>제조사 Model No</label> 
																	<input type="text" id="S_PJT_PRD_NM" name="S_PJT_PRD_NM" placeholder="ex) 품명"
																	 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadLeftGridData(); return false;}"/>
																</div>

																<div class="col-sm-2">
																	<label>요청 유형</label>
																	<select id="S_CST_IDX2" name="S_CST_IDX2" class="form-control" style="height: 30px;" ></select>
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
		<div class="modal fade" id="modal_info" data-backdrop="static">
			<div class="modal-dialog modal-md" style="width: 800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_code_title">BOM 등록/수정</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="bom_lvl0" name="bom_lvl0" class="form-horizontal">
							<div class="row">
								<div class="col-md-12 text-center">
									<label class="col-sm-1 control-label" style="padding-left: 0px">제조사</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="combo" id="S_MTL_MKR_CD" name="S_MTL_MKR_CD" class="form-control input-sm pull-right" placeholder="제조사" 
													onkeypress="if(event.keyCode==13) {requestGrid3(); return false;}" >
									</div>		
									
									<label class="col-sm-1 control-label" style="padding-left: 0px">품목</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="combo" id="S_MTL_NM" name="S_MTL_NM" class="form-control input-sm pull-right" placeholder="품목" 
													onkeypress="if(event.keyCode==13) {requestGrid3(); return false;}" >
									</div>	
									
									<label class="col-sm-2 control-label" style="padding-left: 0px">제조사 품번</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="combo" id="S_MTL_MKR_NO" name="S_MTL_MKR_NO" class="form-control input-sm pull-right" placeholder="제조사 품번" 
													onkeypress="if(event.keyCode==13) {requestGrid3(); return false;}" >
									</div>	
									<div class="col-sm-2">
										<button type="button" class="btn btn-default btn-sm" onclick="requestGrid3()">조회</button>
										<button type="button" class="btn btn-success btn-sm" onclick="addBOM()">등록</button>
									</div>	
								</div>
								<div class="col-sm-12">
									<div id="grid_list3" class="w2g-h200" style="margin-top: 10px;"></div>
								</div>
							</div>
						</form>
						
						<form id="bom_lvl1" name="bom_lvl1" class="form-horizontal" style="margin-top: 10px">
							<div class="row">
								<div class="col-md-12 text-center" style="margin-top: 20px; text-align: right;">
									<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAddModal()">등록</button>
									<button type="button" id="" class="btn btn-danger btn-sm" data-dismiss="modal">닫기</button>
								</div>	
								<div class="col-sm-12">
									<div id="grid_list4" class="w2g-h200" style="margin-top: 10px;"></div>
								</div>
							</div>
						</form>						
						
						<input type="hidden" id="hiddenProduct_code"> 
						<input type="hidden" id="hiddenM_item_code">
					</div>				
				</div>
			</div>
		</div>

		<div class="modal fade" id="modal_add" data-backdrop="static">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_add_title">등록</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
							<div class="col-sm-9">
								<div class="row">
									<div class="form-group">
										<label class="col-sm-3 control-label">품명</label>
										<div class="col-sm-7">
											<input type="combo" class="form-control input-sm pull-right clear_val2" id="add_nm" maxlength="100">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-sm-3 control-label">P/N</label>
										<div class="col-sm-7">
											<input type="combo" class="form-control input-sm pull-right clear_val2" id="add_code" maxlength="100">
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-3">
								<button type="button" id="" class="btn btn-default btn-sm" onclick="selmaterial()">검색</button>
							</div>
							<div class="col-sm-12">
								<div id="grid_list6" class="w2g-h200" style="margin-top: 10px;"></div>
							</div>
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

	var grid_material_data;
	var grid_add_data;
	var grid_lev1_data;
	var grid_lev2_data;
	var startValue_combo = "";
	
	var minDate = getFormatDate(new Date());
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	comboValue_nm3 = new Array;
	comboValue_cd3 = new Array;
	
	
	$(function($) {
		fnCdD('S_PJT_PRD_UNT', 'MC1027');//공통코드를 호출-재고 단위
		requestClient('S_CST_IDX');//고객사 정보를 검색폼 드랍다운 형태로 만듬
	
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
				footer : true
			},
			multiSelect : false,
			columns : [ 
				{ field:'pjt_IDX', caption:'자재요청 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_REG_DT', caption:'요청 유형', size:'7%', style:'text-align:center', sortable: true},
	        	{ field:'pjt_GRD', caption:'자재 요청일', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'pjt_NM', caption:'요청자', size:'10%', style:'text-align:center', sortable: true},
				{ field:'pjt_CD', caption:'프로젝트코드', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_QTY', caption:'재고수량', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_QTY', caption:'요청수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_DLV_QTY', caption:'불출수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_STATE', caption:'견적요청여부', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_STATE', caption:'Status', size:'8%', style:'text-align:center', sortable: true}
				
				
			],
			sortData : [ {
				field : 'mtl_REQ_MST',
				direction : 'DESC'
			} 
			],
			records : [], // rowArr
			onSelect : function(event) {
				event.onComplete = function() {
					w2ui['grid_list2'].refresh();
					
					// 오른쪽 그리드
					loadRightGrid(this.get(event.recid).pjt_IDX);
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
		
		var page_url = "/info/info/selectMaterialRequest";
		var postData = "MTL_REQ_TYPE=" + encodeURIComponent($("#S_MTL_REQ_TYPE").val()) 
					+ "&MTL_REQ_REG_DT=" + encodeURIComponent($("#S_MTL_REQ_REG_DT").val())
					+ "&MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					+ "&MTL_NM=" + encodeURIComponent($("#S_MTL_NM").val())
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
				{ field: 'BOM_IDX', caption: 'Bom idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'pjt_IDX', caption: 'Project idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'MTL_IDX', caption: '자재번호 IDX ', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'mtl_QTY', caption: '제조사명', style: 'text-align:center', sortable: true,},
				{ field: 'mtl_NM', caption: '품목', style: 'text-align:center', sortable: true },
				{ field: 'mtl_MKR_NO', caption: '제조사품번', style: 'text-align:center', sortable: true },
				{ field: 'mtl_UNT', caption: '단위', style: 'text-align:center', sortable: true },
				{ field: 'bom_MTL_QTY', caption: '수량', style: 'text-align:center', sortable: true, editable: { type: 'int' } },
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
	function loadRightGrid(pjtIDX) {
		console.log(loadRightGrid);
		
		var page_url = "/info/info/selectBOMbyPRO";
		var postData = "pjt_IDX=" + encodeURIComponent(pjtIDX);
		
		$("#hiddenIdx").val(pjtIDX);
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

					if (startValue_combo == "") {
						$('#r_mt_name').w2field('combo', {
							items : _.uniq(comboValue_cd, false),
							match : 'contains'
						});
					}
				} else {
					//w2ui.grid_list.clear();
				}
				w2ui['grid_list2'].refresh();
				w2ui['grid_list2'].unlock();

				requestRightGrid('grid_list2');
			},
			complete : function() {
				startValue_combo = ":)";
				document.getElementById("r_mt_name").style.removeProperty("height");
			}
		});
	}
	function requestRightGrid(gridname) {//기능을 모르겠음
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

	function ItemInsUp() {
		console.log(w2ui.grid_list2.get("pjt_IDX"));
		
		var key = w2ui.grid_list2.getSelection();

		if (key.length == 0) {
			insertBom();
		} else if (key.length == 1) {
			updateBom();
		}

	}

	function insertBom() {
		var keys = w2ui.grid_list.getSelection();
		
		if (keys == null || keys == "") {
			alert("먼저 프로젝트를 선택하여주십시오");
		} else {
			$(".clear_val").val('');

			$("#modal_info").modal('show');
			setTimeout(function() {
				w2ui['grid_list3'].resize();
				w2ui['grid_list3'].refresh();
				
				w2ui['grid_list4'].resize();
				w2ui['grid_list4'].refresh();				
			}, 200);
			
			requestGrid3();
			requestGrid4();

			$('#hiddenProduct_code').val('');
			$('#hiddenM_item_code').val('');
		}

	};
	function loadGrid3() {
		var rowArr = [];

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
				{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true}
			], 
			sortData: [{field: 'mtl_IDX', direction: 'DESC'}],			
			records : [],
			total : 0,
			recordHeight : 30,
			onReload : function(event) {
			},

			onSelect : function(event) {
				event.onComplete = function() {
					/*
					w2ui['grid_list4'].refresh();
					w2ui['grid_list5'].refresh();
					 */
					var item_code = this.get(event.recid).mtl_IDX;
					// 오른쪽 그리드
					$('#hiddenProduct_code').val(item_code);
					grid_material_data = this.get(event.recid);
				}
			},
			onUnselect : function(event) {
				event.onComplete = function() {
					comboValue_nm4 = new Array;
					comboValue_cd4 = new Array;
					comboValue_nm5 = new Array;
					comboValue_cd5 = new Array;
					$('#hiddenProduct_code').val('');
					
					w2ui['grid_list4'].clear();		
					w2ui['grid_list4'].refresh();					
					/*
					w2ui['grid_list5'].clear();		
					w2ui['grid_list5'].refresh();
					 */
				}
			}
		});
	}
	function requestGrid3() {
/* 		var page_url = "/info/account/selectMaterial";
		var postData = "MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					  + "&MTL_CATE=" + encodeURIComponent($("#S_MTL_CATE").val())
					  + "&MTL_NM="   + encodeURIComponent($("#S_MTL_NM").val())
					  + "&MTL_MKR_NO="+ encodeURIComponent($("#S_MTL_MKR_NO").val()); */
		
		var keys = $("#hiddenIdx").val();
		var page_url = "/info/info/selectMaterialsBOM";
		var postData = 'pjt_IDX=' + keys;

		w2ui['grid_list3'].lock('loading...', true);
		w2ui['grid_list3'].clear();
		w2ui['grid_list3'].refresh();
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
						comboValue_nm3.push(row.mtl_NM + "");
						comboValue_cd3.push(row.mtl_IDX + "");
					});
					w2ui['grid_list3'].records = rowArr;
					$('#g3_item_nm').w2field('combo', {
						items : _.uniq(comboValue_nm3, false),
						match : 'contains'
					});
					$('#g3_item_type_code').w2field('combo', {
						items : _.uniq(comboValue_cd3, false),
						match : 'contains'
					});
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list3'].refresh();
				w2ui['grid_list3'].unlock();
			},
			complete : function() {
				document.getElementById("g3_item_nm").style.removeProperty("height");
				document.getElementById("g3_item_type_code").style.removeProperty("height");
			}
		});
	}

	function loadGrid4(){
		var rowArr = [];
		
		$('#grid_list4').w2grid({
			name : 'grid_list4',
			show : {
				lineNumbers : true,
				footer : true,
				selectColumn : true
			},
			multiSelect : false,

			columns : [
				{ field: 'BOM_IDX', caption: 'Bom idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'pjt_IDX', caption: 'Project idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'MTL_IDX', caption: '자재번호 IDX ', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'mtl_QTY', caption: '제조사명', style: 'text-align:center', sortable: true,},
				{ field: 'mtl_NM', caption: '품목', style: 'text-align:center', sortable: true },
				{ field: 'mtl_MKR_NO', caption: '제조사품번', style: 'text-align:center', sortable: true },
				{ field: 'mtl_UNT', caption: '단위', style: 'text-align:center', sortable: true },
				{ field: 'bom_MTL_QTY', caption: '수량', style: 'text-align:center', sortable: true, editable: { type: 'int' } },
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
	function requestGrid4(){		
		var pjtIDX = $('#hiddenIdx').val();
		var page_url = "/info/info/selectBOMbyPRO";
		var postData = "pjt_IDX=" + encodeURIComponent(pjtIDX);
		
		w2ui['grid_list4'].lock('loading...', true);
		w2ui['grid_list4'].clear();
		w2ui['grid_list4'].refresh();
		
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
					w2ui['grid_list4'].records = rowArr;

					if (startValue_combo == "") {
						$('#r_mt_name').w2field('combo', {
							items : _.uniq(comboValue_cd, false),
							match : 'contains'
						});
					}
				} else {
					//w2ui.grid_list.clear();
				}
				w2ui['grid_list4'].refresh();
				w2ui['grid_list4'].unlock();

				requestRightGrid('grid_list4');
			},
			complete : function() {
				startValue_combo = ":)";
				document.getElementById("r_mt_name").style.removeProperty("height");
			}
		});		
	}

	function addBOM() {		
		if($('#hiddenProduct_code').val() == '' || $('#hiddenProduct_code').val() == null){
			fnMessageModalAlert("알림", "제품을 1개 이상 선택하셔야 합니다.");
		} else {
			var BomInputDatas = w2ui.grid_list3.getSelection();
			var DataList = [];
			var insertPJT = $("#hiddenIdx").val();//PJT_IDX
			for (var i = 0; i < BomInputDatas.length; i++) {
				var Data = {
					pjt_IDX : encodeURIComponent(insertPJT),
					mtl_IDX : w2ui.grid_list3.records[i].mtl_IDX,
					bom_MTL_QTY : w2ui.grid_list3.records[i].bom_MTL_QTY,
					mtl_REG_DT : w2ui.grid_list3.records[i].mtl_REG_DT
				};
				DataList.push(Data);
			}

			if (confirm("등록하시겠습니까?")) {
				var page_url = "/info/info/InsertMaterialsBOM";
				console.log(DataList);
				var jsonData = JSON.stringify(DataList);
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
							loadRightGrid($("#hiddenIdx").val());
							requestGrid3();
						} else {
							alert("오류가 발생하였습니다");
						}
					},
					complete : function() {
						document.getElementById("add_nm").style.removeProperty("height");
						document.getElementById("add_code").style.removeProperty("height");
						
						requestGrid4();
					}
				});
			}			
		}			
	}
	function addlev2() {
		if ($('#hiddenProduct_code').val() == '' || $('#hiddenProduct_code').val() == null) {
			fnMessageModalAlert("알림", "제품(0LEV)을 1개 선택하셔야 합니다.");
		} else {
			if ($('#hiddenM_item_code').val() == '' || $('#hiddenM_item_code').val() == null) {
				fnMessageModalAlert("알림", "원자재(1LEV)를 1개 선택하셔야 합니다.");
			} else {
				$("#modal_add_title").text('Bom 2lev 등록');
				$(".clear_val2").val('');
				$("#modal_add").modal('show');
				setTimeout(function() {
					w2ui['grid_list6'].resize();
					w2ui['grid_list6'].refresh();
				}, 200);
				selmaterial();
			}
		}
	}
	function selmaterial() {
		/*
		grid_add_data = '';
		var lvl = 'MD1246';
		if($("#modal_add_title").text() == 'Bom 1lev 등록'){
			lvl = 'MD1245';
		}
		 */
		var page_url = "/info/material/selectMaterial";
		var postData = 'item_type_code=' + lvl;
		postData = postData + '&item_nm=' + $('#add_nm').val();
		postData = postData + '&item_code=' + $('#add_code').val();

		w2ui['grid_list3'].lock('loading...', true);
		w2ui['grid_list3'].clear();
		w2ui['grid_list3'].refresh();
		comboValue_nm6 = new Array;
		comboValue_cd6 = new Array;
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData,
			data_type : 'json',
			success : function(data) {
				if (data.status == 200 && (data.rows).length > 0) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row) {
						row.recid = idx + 1;
						comboValue_nm6.push(row.item_nm);
						comboValue_cd6.push(row.item_code);
					});
					w2ui['grid_list6'].records = rowArr;
					$('#add_nm').w2field('combo', {
						items : _.uniq(comboValue_nm6, false),
						match : 'contains'
					});
					$('#add_code').w2field('combo', {
						items : _.uniq(comboValue_cd6, false),
						match : 'contains'
					});
				} else {
					//w2ui.grid_list.clear();
				}
			},
			complete : function() {
				document.getElementById("add_nm").style.removeProperty("height");
				document.getElementById("add_code").style.removeProperty("height");
			}
		});
	}

	function saveAddModal() {
		var lvl = 'MD1246';
		if ($("#modal_add_title").text() == 'Bom 1lev 등록') {
			lvl = 'MD1245';
		}
		var selectdata = w2ui.grid_list6.getSelection();
		if (selectdata != '') {
			var msg = '등록을 완료 하였습니다.';
			var page_url = "/info/insertBomlist";
			var postData = "product_item_code=" + grid_material_data.item_code
					+ "&business_code=" + grid_material_data.business_code
					+ "&product_item_nm=" + grid_material_data.item_nm
					+ "&c_item_code=" + grid_add_data.item_code + "&c_item_nm="
					+ grid_add_data.item_nm + "&item_type_code="
					+ grid_add_data.item_type_code + "&item_type_nm="
					+ grid_add_data.item_type_nm + "&spec="
					+ grid_add_data.item_spec + "&meins=" + grid_add_data.meins;

			if (lvl == 'MD1245') {//원자재등록
				postData = postData + "&stufe=" + 1 + "&m_item_code="
						+ grid_material_data.item_code + "&m_item_nm="
						+ grid_material_data.item_nm;
				msg = '원자재(1LEV)의' + msg;
			} else {//부자재등록
				postData = postData + "&stufe=" + 2 + "&m_item_code="
						+ grid_lev1_data.c_item_code + "&m_item_nm="
						+ grid_lev1_data.c_item_nm;
				msg = '부자재(2LEV)의' + msg;
			}

			$.ajax({
				url : page_url,
				type : 'POST',
				data : postData,
				data_type : 'json',
				success : function(data) {
					if (data.status == 200) {
						fnMessageModalAlert("결과", msg); // Notification(MES)
					} else if (data.status == 500 && data.msg == 'fall') {
						fnMessageModalAlert("결과", "이미 존재하는 값은 등록이 불가능합니다.");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다."); // Notification(MES)
				},
				complete : function() {
					$("#modal_add").modal('hide');
					requestGrid4();
					requestGrid5();
				}
			});

		} else {
			fnMessageModalAlert("알림", "등록할 제품을 1개 선택해주세요.");
		}
		$('#hiddenM_item_code').val('');
	}

	function dellev1() {
		if (w2ui.grid_list4.getSelection().length == 0) {
			fnMessageModalAlert("에러", "삭제하실 정보를 선택해주세요!");
			return;
		}
		fnMessageModalConfirm("알림", "원자재(1LEV)의 선택한 내용을 삭제하시겠습니까?<br />원자재 삭제시 하위의 부자재도 모두 삭제됩니다.", function(result) {
			if (result) {
				var strUrl = "/info/deleteBomlist";
				var postData = "c_item_code="
						+ grid_lev1_data.c_item_code
						+ "&product_item_code="
						+ grid_lev1_data.product_item_code
						+ "&business_code="
						+ grid_lev1_data.business_code
						+ "&m_item_code=" + grid_lev1_data.m_item_code
						+ "&stufe=" + 1;
				deletelev1_2(strUrl, postData);
			}
		});
	}
	function dellev2() {
		if (w2ui.grid_list5.getSelection().length == 0) {
			fnMessageModalAlert("에러", "삭제하실 정보를 선택해주세요!");
			return;
		}
		fnMessageModalConfirm("알림", "부자재(2LEV)의 선택한 내용을 삭제하시겠습니까?", function(result) {
			if (result) {
				var strUrl = "/info/deleteBomlist";
				var postData = "c_item_code=" + grid_lev2_data.c_item_code
						+ "&product_item_code="
						+ grid_lev2_data.product_item_code + "&business_code="
						+ grid_lev2_data.business_code + "&m_item_code="
						+ grid_lev2_data.m_item_code + "&stufe=" + 2;
				deletelev1_2(strUrl, postData);
			}
		});
	}

	function deletelev1_2(strUrl, postData) {
		$.ajax({
			url : strUrl,
			type : "POST",
			dataType : 'json',
			data : postData,
			async : false,
			success : function(data) {
				if (data.status == "200") {
					fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다."); // Notification(MES)
			},
			complete : function() {
				$("#modal_add").modal('hide');
				requestGrid4();
				requestGrid5();
			}
		});
		$('#hiddenM_item_code').val('');
	}


	// ############################
	function fnCdD(val, val2){//공통코드를 드랍다운 메뉴화
		console.log("fnCdD("+val+")");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/codeDetail/selectCdD";
		var postData = "master_code=" + encodeURIComponent(val2);
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    dataType: 'json', 
		    async : false, // 다 끝나고 다음 처리 해!
		    success:function(data, textStatus, jqXHR){
//	 	    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
		    		rowArr = data.rows;
		    		
		    		var sub = val.substr(0,2);
		    		
		    		//  if(valsub != "m_")
		    		if(sub.indexOf("m_") == -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    //fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    }
		});
	}	
	// init component
	function fnLoadCommonOption() {
	 	console.log('fnLoadCommonOption()');
	 	
		$('#PJT_DLV_DT').daterangepicker({
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
	 	
		$('#S_PJT_REG_DT, #S_PJT_DLV_DT').daterangepicker({
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
		
		$('#S_PJT_REG_DT').val("");
		$('#S_PJT_DLV_DT').val("");
		
	}	
	function getFormatDate(d) {
		var month = d.getMonth() + 1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		return d.getFullYear() + '-' + month + '-' + date;
	}

	// 고객사 가져오기
	function requestClient(val){
		console.log("requestClient");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/account/selectClient";
		var postData = "";
		
		//w2ui['grid_list'].lock('loading...', true);
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    async : false, // 다 끝나고 다음 처리 해!
		    dataType: 'json', 
		    success:function(data, textStatus, jqXHR){
//	 	    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length > 0) {
		    		rowArr = data.rows;
		    		
		    		/* 검색어 입력시 */
		    		var sub = val.substr(0,2);

		    		if(sub.indexOf("S_") != -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val ).append("<option value=" + row.cst_IDX + ">" + row.cst_NM + "</option>");
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    //fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
	    	
		    }
		});
	}
	
	//셀렉트박스 초기화
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
		//.append('<option value="All">-----</option>')
	    .val();
	}	
	
	//엑셀파일 다운로드
	function excelFileDownload() {
		var gridCols = w2ui['grid_list2'].columns;
		var gridData = w2ui['grid_list2'].records;

		var fileName = 'Bom 관리.xlsx';
		var sheetTitle = 'Bom 관리';
		var sheetName = 'Bom 관리';

		var param_col_name = "", param_col_id = "", param_col_align = "", param_col_width = "";
		var is_rownum = true;

		if (gridCols != null && gridCols.length > 0) {
			for (var i = 0; i < gridCols.length; i++) {
				if (!gridCols[i].hidden) {
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width == undefined ? "10" : (gridCols[i].width).replace('px', '')) + ",";
				}
			}
			param_col_name = param_col_name.substr(0, param_col_name.length - 1);
			param_col_id = param_col_id.substr(0, param_col_id.length - 1);
			param_col_align = param_col_align.substr(0, param_col_align.length - 1);
			param_col_width = param_col_width.substr(0, param_col_width.length - 1);
		}

		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name=" + encodeURIComponent(fileName);
			export_data += "&sheet_title=" + encodeURIComponent(sheetTitle);
			export_data += "&sheet_name=" + encodeURIComponent(sheetName);
			export_data += "&header_col_names=" + encodeURIComponent(param_col_name);
			export_data += "&header_col_ids=" + encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns=" + encodeURIComponent(param_col_align);
			export_data += "&header_col_widths=" + encodeURIComponent(param_col_width);
			export_data += "&cmd=" + encodeURIComponent("grid_goods_detail");
			export_data += "&body_data=" + encodeURIComponent(JSON.stringify(gridData));

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
					
					link_url += "?file_path=" + encodeURIComponent(file_path);
					link_url += "&file_name=" + encodeURIComponent(file_name);

					$(location).attr('href', link_url);
				}
			},
			complete : function() { }
		});
	}	
</script>

</body>
</html>