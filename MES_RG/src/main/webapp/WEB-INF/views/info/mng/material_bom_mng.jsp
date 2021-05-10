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
			<jsp:param name="selected_menu_p_cd" value="1122" />
			<jsp:param name="selected_menu_cd" value="1123" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					프로젝트별 재고 관리 <small> 재고관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>재고관리 </a></li>
					<li class="active">프로젝트별 재고 관리</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<section class="col-lg-12">
						<div class="box" style="margin-bottom: 0px; border: none;">
							<div id="" class="box-body">
								<div class="row">
									<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
										<div class="col-sm-7">
											<div class="row">
												<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
													<div class="box-header with-border" style="background-color: #DB8EB5;">
														<h3 class="box-title">프로젝트 정보</h3>
														<div class="box-tools pull-right">
															<button type="button" id="btn_search_csr" onclick="loadLeftGrid();" class="btn btn-primary btn-sm" onclick="">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-2">
																	<div class="form-group">
																		<label>프로젝트 등급</label> <input type="text" id="S_PJT_GRD" name="S_PJT_GRD" placeholder="ex) 프로젝트 등급"
																		 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																	</div>
																</div>
									
																<div class="col-sm-2">
																	<div class="form-group">
																		<label>프로젝트명</label> <input type="text" id="S_PJT_NM" name="S_PJT_NM" placeholder="ex) 프로젝트명"
																		 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																	</div>
																</div>
																
																<div class="col-sm-2">
																	<div class="form-group">
																		<label>고객사</label> 
																		<select id="S_CST_IDX" name="S_CST_IDX" class="form-control" style="height: 30px;" 
																		onchange="searchs()"></select>
																	</div>
																</div>	
																							
																<div class="col-sm-2">
																	<div class="form-group">
																		<label>품명</label> <input type="text" id="S_PJT_PRD_NM" name="S_PJT_PRD_NM" placeholder="ex) 품명"
																		 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																	</div>
																</div>
																							
																<div class="col-sm-2">
																	<div class="form-group">
																	<label>납품 요청일</label>
																		<div class="input-group">
																			<input type="text" 
																				class="form-control pull-right input-sm" id="S_PJT_DLV_DT" placeholder="yyyymmdd~yyyymmdd"
																				onchange="searchs()">
																			<div class="input-group-addon">
																				<i class="fa fa-calendar"></i>	
																			</div>
																		</div>
																	</div>
																</div>
																
																<div class="col-sm-2">
																	<div class="form-group">
																	<label>프로젝트 등록일</label>
																		<div class="input-group">
																			<input type="text" 
																				class="form-control pull-right input-sm" id="S_PJT_REG_DT" placeholder="yyyymmdd~yyyymmdd"
																				onchange="searchs()">
																			<div class="input-group-addon">
																				<i class="fa fa-calendar"></i>	
																			</div>
																		</div>
																	</div>
																</div>																
															</div>
														</div>
														<div id="grid_list" class="w2g-h600" style="margin-top: 10px;"></div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-sm-5">
											<div class="box box-success box-solid"
												style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border"
													style="background-color: #DB8EB5;">
													<h3 class="box-title">BOM 리스트</h3>
													<div class="box-tools pull-right">
														<button type="button" id="btn_ins_csr" onclick="excelFileDownload('grid_list2','프로젝트 재고관리');" class="btn btn-info btn-sm" onclick="">엑셀다운로드</button>
														<button type="button" id="btn_search_csr" onclick="requestRightGrid('grid_list2');" class="btn btn-primary btn-sm" onclick="">조회</button>
														<button type="button" id="btn_ins_csr" onclick="ItemInsUp();" class="btn btn-primary btn-sm" onclick="">등록/수정</button>
														<%-- <button type="button" id="btn_del_csr" onclick="delItem();" class="btn btn-primary btn-sm" onclick="">수정</button> --%>
													</div>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-6">
																<label>자재검색</label> 
																<input type="combo" id="r_mt_name" name="r_mt_name" class="form-control input-sm" placeholder="자재검색"
																	onkeypress="if(event.keyCode==13) {requestRightGrid('grid_list2'); return false;}" style="padding: 5px 10px;">
															</div>
														</div>
													</div>
													<div id="grid_list2" class="w2g-h600" style="margin-top: 10px;"></div>
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
																	
<!--  									<label class="col-sm-2 control-label" style="padding-left: 0px">자재분류</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="combo" id="S_MTL_CATE" name="S_MTL_CATE" class="form-control input-sm pull-right" placeholder="자재분류" 
													onkeypress="if(event.keyCode==13) {requestGrid3(); return false;}" >
									</div> -->
									
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
<!-- 									<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAddModal()">등록</button> -->
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
<!-- 							<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAddModal()">등록</button> -->
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
	var loadingEnd = false;
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	comboValue_nm3 = new Array;
	comboValue_cd3 = new Array;
	
	comboValue_nm4 = new Array;
	comboValue_cd4 = new Array;
	
	comboValue_nm5 = new Array;
	comboValue_cd5 = new Array;
	
	comboValue_nm6 = new Array;
	comboValue_cd6 = new Array;
	
	$(function($) {
		fnCdD('S_PJT_PRD_UNT', 'MC1027');//공통코드를 호출-재고 단위
		requestClient('S_CST_IDX');//고객사 정보를 검색폼 드랍다운 형태로 만듬
	
		fnLoadCommonOption();//등록폼 달력
		fnLoadDeliveryOption();//검색폼 달력
		
		fnLoadLeftGrid();
		fnLoadRightGrid();
		loadGrid3();
		loadGrid4();
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
				{ field:'pjt_REG_DT', caption:'프로젝트 등록일', size:'7%', style:'text-align:center', sortable: true},
	        	{ field:'pjt_GRD', caption:'프로젝트 등급', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'pjt_CD', caption:'프로젝트 코드', size:'17%', style:'text-align:center', sortable: true},
				{ field:'cst_NM', caption:'고객사', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'pjt_PRD_NM', caption:'제품명', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'pjt_PRD_QTY', caption:'발주수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'pjt_PRD_UNT_NM', caption:'단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'pjt_DLV_DT', caption:'납품 요청일', size:'8%', style:'text-align:center', sortable: true}
			],
			sortData : [ {
				field : 'PJT_IDX',
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
		
		var page_url = "/info/account/selectProject";
		var postData = "PJT_GRD=" + encodeURIComponent($("#S_PJT_GRD").val()) 
				+ "&PJT_NM=" + encodeURIComponent($("#S_PJT_NM").val()) 
				+ "&CST_IDX="   + encodeURIComponent($("#S_CST_IDX").val())
				+ "&PJT_PRD_NM="   + encodeURIComponent($("#S_PJT_PRD_NM").val()) 
				+ "&PJT_DLV_DT="   + encodeURIComponent($("#S_PJT_DLV_DT").val()) 
				+ "&PJT_REG_DT="   + encodeURIComponent($("#S_PJT_REG_DT").val());

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
				startValue_combo = ":)";

				//document.getElementById("Business").style.removeProperty("height");
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
		var postData = "PJT_IDX=" + encodeURIComponent(pjtIDX);
		
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
			if (list[i].mtl_NM.indexOf(cnm) !== -1) {
				$('#grid_' + gridname + '_rec_' + num + ' > td').css({ "color" : "red" });
			} else {
				$('#grid_' + gridname + '_rec_' + num + ' > td').css({ "color" : "black" });
			}
		}
	}

	function ItemInsUp() {
		console.log(w2ui.grid_list2.get("PJT_IDX"));
		
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
	function updateBom() {
		var keys = w2ui.grid_list.getSelection();
		
		if (keys == null || keys == "") {
			alert("먼저 프로젝트를 선택하여주십시오");
		} else {
			$(".clear_val").val('');
			
			setTimeout(function() {
				w2ui['grid_list3'].resize();
				w2ui['grid_list3'].refresh();
				
				w2ui['grid_list4'].resize();
				w2ui['grid_list4'].refresh();				
			}, 200);
			
			$("#modal_info").modal('show');
			$("#bom_IDX").val(w2ui.grid_list2.get(keys[0]).bom_IDX);
			$('#hiddenProduct_code').val('');
			$('#hiddenM_item_code').val('');
			$('#BOM_IDX').val('')
			requestGrid3();
			requestGrid4();
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
	  	var S_MTL_MKR_CD =$("#S_MTL_MKR_CD").val();
	  	var S_MTL_NM = $("#S_MTL_NM").val();
		var S_MTL_MKR_NO = $("#S_MTL_MKR_NO").val();
		
		var page_url = "/info/info/selectMaterialsBOM";
		var postData = 'pjt_IDX=' + keys
					    +'&MTL_MKR_CD='+S_MTL_MKR_CD
					    +'&MTL_NM='+S_MTL_NM
					    +'&MTL_MKR_NO='+S_MTL_MKR_NO;


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
				//document.getElementById("g3_item_nm").style.removeProperty("height");
				//document.getElementById("g3_item_type_code").style.removeProperty("height");
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
		var postData = "PJT_IDX=" + encodeURIComponent(pjtIDX);
		
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
					PJT_IDX : encodeURIComponent(insertPJT),
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

</script>

</body>
</html>