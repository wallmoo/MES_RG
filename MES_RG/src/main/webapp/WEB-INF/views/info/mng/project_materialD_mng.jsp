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
			<jsp:param name="selected_menu_cd" value="1117" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					자재  요청 관리(연구원용)<small>구매/자재 관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>구매/자재 관리 </a></li>
					<li class="active">자재  요청 관리(연구원용)</li>
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
															<button type="button" id="btn_search_csr" onclick="loadLeftGridData();" class="btn btn-primary btn-sm">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-2">
																	<label>프로젝트 등급</label> 
																	<input type="text" id="S_PJT_GRD" name="S_PJT_GRD" placeholder="ex) 프로젝트 등급"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGridData(); return false;}"/>
																</div>
									
																<div class="col-sm-2">
																	<label>프로젝트명</label> 
																	<input type="text" id="S_PJT_NM" name="S_PJT_NM" placeholder="ex) 프로젝트명"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadLeftGridData(); return false;}"/>
																</div>
																
																<div class="col-sm-2">
																	<label>고객사</label> 
																	<select id="S_CST_IDX" name="S_CST_IDX" class="form-control" style="height: 30px;" ></select>
																</div>	
																							
																<div class="col-sm-2">
																	<label>품명</label> 
																	<input type="text" id="S_PJT_PRD_NM" name="S_PJT_PRD_NM" placeholder="ex) 품명"
																	 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadLeftGridData(); return false;}"/>
																</div>

																<div class="col-sm-2">
																	<label>납품 요청일</label>
																	<div class="input-group">
																		<input type="text" class="form-control pull-right input-sm" id="S_PJT_DLV_DT" placeholder="yyyymmdd~yyyymmdd">
																		<div class="input-group-addon">
																			<i class="fa fa-calendar"></i>
																		</div>
																	</div>
																</div>

																<div class="col-sm-2">
																	<label>프로젝트 등록일</label>
																	<div class="input-group">
																		<input type="text" 
																			class="form-control pull-right input-sm" id="S_PJT_REG_DT" placeholder="yyyymmdd~yyyymmdd">
																		<div class="input-group-addon">
																			<i class="fa fa-calendar"></i>	
																		</div>
																	</div>
																</div>																
															</div>
														</div>
														<div id="grid_list" class="w2g-h300" style="margin-top: 10px;"></div>
													</div>
												</div>
											</div>
										</div>

										<div class="col-sm-5">
											<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border" style="background-color: #DB8EB5;">
													<h3 class="box-title">재고조회</h3>
													<div class="box-tools pull-right">
														<button type="button" id="btn_search_csr" onclick="bomNewOrder();" class="btn btn-primary btn-sm">신규자재 요청</button>
														<button type="button" id="btn_ins_csr" onclick="showBomOrderModal();" class="btn btn-primary btn-sm">자재 요청</button>
													</div>
												</div>
												<div class="box-body">
													<div class="row">
														<div class="form-group">
															<div class="col-sm-6">
																<label>자재검색</label> 
																<input type="combo" id="r_mt_name" name="r_mt_name" class="form-control input-sm" placeholder="자재검색"
																	onkeypress="if(event.keyCode==13) {requestRightGrid(); return false;}" style="padding: 5px 10px;">
															</div>
														</div>
													</div>
													<div id="grid_list2" class="w2g-h300" style="margin-top: 10px;"></div>
												</div>
											</div>
										</div>
									
										<div class="col-sm-12">
											<div class="row">
												<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
													<div class="box-header with-border" style="background-color: #DB8EB5;">
														<h3 class="box-title">자재요청내역</h3>
														<div class="box-tools pull-right">
															<button type="button" id="btn_search_csr" onclick="loadLeftGridData();" class="btn btn-primary btn-sm">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-2">
																	<label>자재 요청일</label> 
																	<div class="input-group">
																		<input type="text" class="form-control pull-right input-sm" id="S_MTL_REQ_REG_DT" placeholder="yyyymmdd~yyyymmdd">
																		<div class="input-group-addon">
																			<i class="fa fa-calendar"></i>	
																		</div>
																	</div>																	
																</div>
																<div class="col-sm-2">
																	<label>제조사</label> 
																	<input type="text" id="S_MTL_MKR_CD" name="S_MTL_MKR_CD" placeholder="ex) 제조사"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadRequestGridData(); return false;}"/>
																</div>	
																<div class="col-sm-2">
																	<label>품번</label> 
																	<input type="text" id="S_MTL_MD_NO" name="S_MTL_MD_NO" placeholder="ex) 품번"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadRequestGridData(); return false;}"/>
																</div>
																<div class="col-sm-2">
																	<label>요청 유형</label>
																	<input type="text" id="S_MTL_REQ_TYPE" name="S_MTL_REQ_TYPE" placeholder="ex) 요청 유형"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadRequestGridData(); return false;}"/>
																</div>															
															</div>
														</div>
														<div id="grid_list3" class="w2g-h300" style="margin-top: 10px;"></div>
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
		<div class="modal fade" id="modal_bomReqForm" data-backdrop="static">
			<div class="modal-dialog modal-md" style="width: 800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_code_title">자재요청</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="bom_lvl0" name="bom_lvl0" class="form-horizontal">
							<div class="row">
								<div class="col-md-12 text-center">
									<label class="col-sm-1 control-label" style="padding-left: 0px">요청자</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<input type="combo" id="MTL_REQ_REG_ID" name="S_MTL_MKR_CD" class="form-control input-sm pull-right" placeholder="요청자">
									</div>		
									
									<label class="col-sm-2 control-label" style="padding-left: 0px">자재요청일자</label>
									<div class="col-sm-3" style="padding-left: 0px; padding-right: 0px">
										<input type="text" class="form-control pull-right input-sm" id="MTL_REQ_REG_DT" placeholder="yyyymmdd">
									</div>	
								</div>
								<div class="col-sm-12">
									<div id="grid_list4" name="grid_list4" class="w2g-h200" style="margin-top: 10px;"></div>
								</div>
							</div>
						</form>					
						
						<input type="hidden" id="hiddenProduct_code"><!-- 선택된 Material 번호 --> 
						<input type="hidden" id="hiddenM_item_code">
					</div>				
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<button type="button" id="" class="btn btn-success btn-sm" onclick="saveBomReq();">저장</button>
							<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
						</div>
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
						<h4 class="modal-title" id="modal_code_title">등록</h4>
		        	</div>
					<div class="modal-body" id="modal_code_body">
						<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">	
							<input type="hidden" id="upload_mode"/>
							<input type="hidden" class="clear_field" id="mod_file_group"/>
							<input type="hidden" class="clear_field" id="mod_file_no"/>				
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">자재코드</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right" id="MTL_IDX" maxlength="100" readonly="readonly">
									</div>
								</div>
							</div>
											
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">자재분류</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right" id="MTL_CATE" maxlength="30">
									</div>
								</div>
							</div>
		
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">품목</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right" id="MTL_NM" maxlength="20">
									</div>
								</div>
							</div>
		
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">제조사</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="MTL_MKR_CD" maxlength="14">
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">제조사 품번</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm pull-right" id="MTL_MKR_NO" maxlength="10">
									</div>
								</div>
							</div>	
							
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">규격</label><!-- 공통코드 ea/kg 중 선택 -->
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="MTL_STD" value="" maxlength="60">
									</div>
									
								</div>
							</div>
							
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">단가</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="MTL_PRICE" maxlength="14">
									</div>
								</div>
							</div>
						
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">재고단위</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="MTL_UNT" maxlength="14">
									</div>
								</div>
							</div>				
						
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">Datasheet URL</label>
									<div class="col-sm-7">
										<textarea type="text" class="form-control input-sm pull-right" id="MTL_DS_URL" ></textarea>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">비고</label>
									<div class="col-sm-7">
										<input type="text" class="form-control input-sm" id="MTL_BG" maxlength="60">
									</div>
								</div>
							</div>					
							
							<div class="row">
								<label class="col-sm-3 control-label">이미지 파일</label>
								<div class="col-sm-7" style="padding-right: 0px;">
									<input type="text" id="mod_file_name" name="mod_file_name" class="form-control input-sm clear_field" readonly>
								</div>	
								<div class="col-sm-1" style="padding-left: 7px;">
									<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
										<input id="file_group" type="file" class="fileupload file_info" name="file[]">
									</span>
								</div>
							</div>					
							
							
							<div class="row">
								<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAccount();">저장</button>
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
	
	comboValue_nm4 = new Array;
	comboValue_cd4 = new Array;
	
	$(function($) {
		fnCdD('S_PJT_PRD_UNT', 'MC1027');//공통코드를 호출-재고 단위
		requestClient('S_CST_IDX');//고객사 정보를 검색폼 드랍다운 형태로 만듬
		requestVendor('S_VDR_IDX');//거래처 정보를 검색폼 드랍다운 형태로 만듬
		
		fnLoadCommonOption();//등록폼 달력
		fnLoadDeliveryOption();//검색폼 달력
		
		fnLoadLeftGrid();
		fnLoadRightGrid();
		fnloadFootGrid();
		fnLoadModalGrid();
	});


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
			} ],
			records : [], // rowArr
			onSelect : function(event) {
				event.onComplete = function() {
					w2ui['grid_list2'].refresh();
					
					// 오른쪽 그리드
					loadRightGridData(this.get(event.recid).pjt_IDX);
					
					// 하단 그리드
					loadFootGridData(this.get(event.recid).pjt_IDX);
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

			}
		});

		loadLeftGridData();
	}
	function loadLeftGridData() {//grid_list Data Arr
		console.log("loadLeftGridData()");
		
		var page_url = "/info/account/selectProject";
		var postData = "PJT_GRD=" + encodeURIComponent($("#S_PJT_GRD").val()) 
				+ "&PJT_NM=" + encodeURIComponent($("#S_PJT_NM").val()) 
				+ "&CST_IDX=" + encodeURIComponent($("#S_CST_IDX").val())
				+ "&PJT_PRD_NM=" + encodeURIComponent($("#S_PJT_PRD_NM").val()) 
				+ "&PJT_DLV_DT=" + encodeURIComponent($("#S_PJT_DLV_DT").val()) 
				+ "&PJT_REG_DT=" + encodeURIComponent($("#S_PJT_REG_DT").val());

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
			multiSelect : true,

			columns : [
				{ field: 'bom_IDX', caption: 'Bom idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'pjt_IDX', caption: 'Project idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'mtl_IDX', caption: '자재번호 IDX ', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'mtl_QTY', caption: '제조사명', style: 'text-align:center', sortable: true,},
				{ field: 'mtl_NM', caption: '자재명', style: 'text-align:center', sortable: true },
				{ field: 'mtl_MKR_NO', caption: '제조사 품번', style: 'text-align:center', sortable: true },
				{ field: 'mtl_STD', caption: '규격/상세', style: 'text-align:center', sortable: true, hidden: true },
				{ field: 'mtl_UNT', caption: '단위', style: 'text-align:center', sortable: true },			
				{ field: 'bom_MTL_QTY', caption: '재고수량', style: 'text-align:center', sortable: true },
				{ field: 'mtl_REQ_QTY', caption: '요청수량', style: 'text-align:center', sortable: true, hidden: true },				
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
	function loadRightGridData(pjtIDX) {
		console.log(loadRightGridData);
		
		var page_url = "/info/info/selectBOMbyPRO";
		var postData = "PJT_IDX=" + encodeURIComponent(pjtIDX);
		
		$("#hiddenIdx").val(pjtIDX);//프로젝트 번호 세팅
		
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

	function fnloadFootGrid() {//하단 그리드 - 자재요청내역
		var rowArr = [];

		$('#grid_list3').w2grid({
			name : 'grid_list3',
			show : {
				lineNumbers : true,
				selectColumn : false,
				footer : true,
				toolbarSave : true
			},
			multiSelect : false,
	        columns: [                
				{ field:'pjt_IDX', caption:'자재요청 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_REQ_TYPE', caption:'요청 유형', size:'7%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_REQ_REG_DT', caption:'자재 요청일', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_REQ_REG_ID', caption:'요청자', size:'10%', style:'text-align:center', sortable: true},
				{ field:'pjt_CD', caption:'프로젝트코드', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true, hidden: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_QTY', caption:'재고수량', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_QTY', caption:'요청수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_DLV_QTY', caption:'불출수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_STATE', caption:'견적요청여부', size:'8%', style:'text-align:center', sortable: true
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
				{ field:'mtl_REQ_STATE', caption:'Status', size:'8%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						if(html == '1') {
							return '요청등록';
						} else if(html == '2') {
							return '견적진행';
						} else if(html == '3') {
							return '불출대기';
						} else if(html == '4') {
							return '불출완료';
						}
						return html;
	           		} 					
				}
			], 
			sortData: [{field: 'MTL_REQ_IDX', direction: 'DESC'}],			
			records : [],
			total : 0,
			recordHeight : 30,
			onReload : function(event) {

			},
			onClick : function(event) {

			},			
			onSelect : function(event) {
				event.onComplete = function() {

				}
			},
			onUnselect : function(event) {
				event.onComplete = function() {

				}
			}
		});
	}
	function loadFootGridData(pjtIDX) {
		console.log("loadRequestGridData()");
		
		var page_url = "/info/info/selectMaterialRequest";
		var postData = "PJT_IDX=" + encodeURIComponent(pjtIDX)
					+ "&MTL_REQ_TYPE=" + encodeURIComponent($("#S_MTL_REQ_TYPE").val()) 
					+ "&MTL_REQ_REG_DT=" + encodeURIComponent($("#S_MTL_REQ_REG_DT").val())
					+ "&MTL_NM=" + encodeURIComponent($("#S_MTL_NM").val())
					+ "&MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					+ "&MTL_MKR_NO=" + encodeURIComponent($("#S_MTL_MKR_NO").val());
		
		w2ui['grid_list3'].lock('loading...', true);
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
					w2ui['grid_list3'].records = rowArr;
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
					w2ui.grid_list3.clear();
				}
				w2ui['grid_list3'].refresh();
				w2ui['grid_list3'].unlock();
			},
			complete : function() {

			}
		});
	}

	function showBomOrderModal() {//자재요청 모달창
		console.log(w2ui.grid_list2.get("PJT_IDX"));
		
		var keys = w2ui.grid_list2.getSelection();//BOM 자료중 선택된 데이터만 전송
		var ModalDataList = [];
		
		if (keys == null || keys == "") {
			alert("견적을 요청할 항목을 선택하여주십시오");
		} else {
			$(".clear_val").val('');//검색어 초기화

			var insertPJT = $("#hiddenIdx").val();//PJT_IDX
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
	function loadModalGridData(rowArr) {//선택된 값을 배열로 전달한다.
		console.log(rowArr);
		
		w2ui['grid_list4'].lock('loading...', true);
		w2ui['grid_list4'].clear();
		w2ui['grid_list4'].refresh();
		
		$.each(rowArr, function(idx, row) {
			row.recid = idx + 1;
			comboValue_cd.push(row.c_item_nm + "");
		});
		
		w2ui['grid_list4'].records = rowArr;
		w2ui['grid_list4'].unlock();
	}	

	function fnLoadModalGrid() {
		var rowArr = [];

		$('#grid_list4').w2grid({
			name: 'grid_list4',
			show: {
				lineNumbers: true,
				footer: true,
				selectColumn: true
			},
			multiSelect: true,

			columns: [
				{ field: 'bom_IDX', caption: 'Bom idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'pjt_IDX', caption: 'Project idx', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'mtl_IDX', caption: '자재번호 IDX ', size: '10%', style: 'text-align:center', hidden: true },
				{ field: 'mtl_QTY', caption: '제조사명', style: 'text-align:center', sortable: true,},
				{ field: 'mtl_NM', caption: '자재명', style: 'text-align:center', sortable: true },
				{ field: 'mtl_MKR_NO', caption: '제조사 품번', style: 'text-align:center', sortable: true },
				{ field: 'mtl_STD', caption: '규격/상세', style: 'text-align:center', sortable: true },
				{ field: 'mtl_UNT', caption: '단위', style: 'text-align:center', sortable: true },			
				{ field: 'bom_MTL_QTY', caption: '재고수량', style: 'text-align:center', sortable: true },
				{ field: 'mtl_REQ_QTY', caption: '요청수량', style: 'text-align:center', sortable: true, editable: { type: 'int' } },
			],
			records: [],
			total: 0,
			recordHeight: 30,
			onChange : function(event) {//갯수 수정
				event.onComplete = function() {//onSave
					console.log("onChange");

					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
					
					w2ui.grid_list4.save();				
				}
			}
		});
	}
	function saveBomReq() {		
		var keys = w2ui.grid_list4.getSelection();
		var reqDataList = [];
		var mtl_REQ_QTY_val = 0;
		if (keys == null || keys == "") {
			alert("자재요청할 항목을 선택하여주십시오");
		} else {
			for (var i = 0; i < keys.length; i++) {
				if(w2ui.grid_list4.records[keys[i]-1].mtl_REQ_QTY == null) {
					mtl_REQ_QTY_val = 0;
				} else {
					mtl_REQ_QTY_val = w2ui.grid_list4.records[keys[i]-1].mtl_REQ_QTY;
				}
				var Data = {
					BOM_IDX : w2ui.grid_list4.records[keys[i]-1].bom_IDX,
					PJT_IDX : w2ui.grid_list4.records[keys[i]-1].pjt_IDX,
					MTL_IDX : w2ui.grid_list4.records[keys[i]-1].mtl_IDX,
					MTL_QTY : w2ui.grid_list4.records[keys[i]-1].mtl_QTY,
					MTL_NM : w2ui.grid_list4.records[keys[i]-1].mtl_NM,
					MTL_MKR_NO : w2ui.grid_list4.records[keys[i]-1].mtl_MKR_NO,
					MTL_STD : w2ui.grid_list4.records[keys[i]-1].mtl_STD,
					MTL_UNT : w2ui.grid_list4.records[keys[i]-1].mtl_UNT,
					BOM_MTL_QTY : w2ui.grid_list4.records[keys[i]-1].bom_MTL_QTY,
					MTL_REQ_QTY : mtl_REQ_QTY_val,
					MTL_REQ_REG_DT : $('#MTL_REQ_REG_DT').val()
				};
				reqDataList.push(Data);
			}			

			if (confirm("등록하시겠습니까?")) {
				console.log(reqDataList);

				var page_url = "/info/info/insertMaterialRequest";
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
							loadRightGridData($("#hiddenIdx").val());
							loadFootGridData($("#hiddenIdx").val());
							$("#modal_bomReqForm").modal('hide');
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

	// ############################
	// init component
	function fnLoadCommonOption() {
	 	console.log('fnLoadCommonOption()');
	 	
		$('#PJT_DLV_DT, #MTL_REQ_REG_DT').daterangepicker({
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
		    loadLeftGridData();
		}); 
	}
	
	function fnLoadDeliveryOption() {
	 	console.log('fnLoadCommonOption()');
	 	
		$('#S_PJT_REG_DT, #S_PJT_DLV_DT, #S_MTL_REQ_REG_DT').daterangepicker({
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
		$('#S_MTL_REQ_REG_DT').val("");
		
	}	

</script>

</body>
</html>