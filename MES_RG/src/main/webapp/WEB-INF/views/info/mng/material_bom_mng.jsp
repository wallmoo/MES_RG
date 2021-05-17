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
																<div class="col-sm-2" style="display:none;">
																	<div class="form-group">
																		<label>프로젝트 등급</label> <input type="text" id="S_PJT_GRD" name="S_PJT_GRD" placeholder="ex) 프로젝트 등급"
																		 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																	</div>
																</div>
									
																<div class="col-sm-3">
																	<div class="form-group">
																		<label>프로젝트명</label> <input type="text" id="S_PJT_NM" name="S_PJT_NM" placeholder="ex) 프로젝트명"
																		 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																	</div>
																</div>
																
																<div class="col-sm-3">
																	<div class="form-group">
																		<label>고객사</label> 
																		<select id="S_CST_IDX" name="S_CST_IDX" class="form-control" style="height: 30px;" 
																		onchange="searchs()"></select>
																	</div>
																</div>	
																							
																<div class="col-sm-3">
																	<div class="form-group">
																		<label>품명</label> <input type="text" id="S_PJT_PRD_NM" name="S_PJT_PRD_NM" placeholder="ex) 품명"
																		 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadLeftGrid(); return false;}"/>
																	</div>
																</div>
																							
																<div class="col-sm-3">
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
																
																<div class="col-sm-2" style="display:none;">
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
													<h3 class="box-title">재고 조회</h3>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-6">
																<label>자재검색</label> 
																<input type="combo" id="S_MTL_NM" name="S_MTL_NM" class="form-control input-sm" placeholder="자재검색"
																	onkeypress="if(event.keyCode==13) {loadRightGrid(); return false;}" style="padding: 5px 10px;">
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
	
		fnLoadDeliveryOption('#S_PJT_REG_DT, #S_PJT_DLV_DT')
		
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
				{ field: 'bom_MTL_QTY', caption: '수량', style: 'text-align:center;', sortable: true},
			],
			records : [],
			total : 0,
			recordHeight : 30,
			onReload : function(event) { },

			onClick : function(event) {
				console.log(this.get(event.recid));
			},
			onDblClick : function(event) { },
		});
	}	
	function loadRightGrid(pjtIDX) {
		var pjtIDX = pjtIDX;
		if(pjtIDX == null) {
			var pjtIDX = $("#hiddenIdx").val();
		}
		
		console.log(loadRightGrid);
		
		var page_url = "/info/info/selectBOMbyPRO";
		var postData = "PJT_IDX=" + encodeURIComponent(pjtIDX)
						+ "&MTL_NM=" + encodeURIComponent($("#S_MTL_NM").val());		
		
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
	function requestRightGrid(gridname) {
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

	
</script>

</body>
</html>