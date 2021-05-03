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
															<button type="button" id="btn_ins_csr" onclick="showReqModal();" class="btn btn-primary btn-sm">견적 요청</button>															
															<button type="button" id="btn_search_csr" onclick="loadRequestGridData();" class="btn btn-warning btn-sm">조회</button>
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
		<div class="modal fade" id="modal_requestForm" data-backdrop="static">
			<div class="modal-dialog modal-md" style="width: 1000px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_code_title">견적 요청 발행</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="bom_lvl0" name="bom_lvl0" class="form-horizontal">
							<div class="row">
								<div class="col-md-12 text-center">
									<label class="col-sm-1 control-label" style="padding-left: 0px">거래처#1</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<select id="S_VDR_IDX1" name="S_VDR_IDX1" class="form-control" style="height: 30px;" ></select>
									</div>		
									
									<label class="col-sm-1 control-label" style="padding-left: 0px">거래처#2</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<select id="S_VDR_IDX2" name="S_VDR_IDX2" class="form-control" style="height: 30px;" ></select>
									</div>	
									
									<label class="col-sm-1 control-label" style="padding-left: 0px">거래처#3</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<select id="S_VDR_IDX3" name="S_VDR_IDX3" class="form-control" style="height: 30px;" ></select>
									</div>		
									
									<label class="col-sm-1 control-label" style="padding-left: 0px">거래처#4</label>
									<div class="col-sm-2" style="padding-left: 0px; padding-right: 0px">
										<select id="S_VDR_IDX4" name="S_VDR_IDX4" class="form-control" style="height: 30px;" ></select>
									</div>
								</div>
								<div class="col-md-4 text-center">
									<label class="col-sm-2 control-label" style="padding-left: 0px">견적요청일자</label>
									<div class="input-group">
										<input type="text" class="form-control pull-right input-sm" id="S_PJT_DLV_DT" placeholder="yyyymmdd~yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>	
								</div>								
								<div class="col-sm-12">
									<div id="grid_list2" class="w2g-h200" style="margin-top: 10px;"></div>
								</div>
							</div>
						</form>					
						
						<input type="hidden" id="hiddenProduct_code"> 
						<input type="hidden" id="hiddenM_item_code">
					</div>	
					<div class="modal-footer" style="border-top-color: transparent !important;">
						<div class="col-md-12 text-center" style="margin-top: 10px">
							<button type="button" id="" class="btn btn-success btn-sm" onclick="saveAddModal()">저장</button>
							<button type="button" id="" class="btn btn-danger btn-sm" data-dismiss="modal">닫기</button>
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
		requestVendor('S_VDR_IDX');//고객사 정보를 검색폼 드랍다운 형태로 만듬
	
		fnLoadCommonOption();//등록폼 달력
		fnLoadDeliveryOption();//검색폼 달력
		
		fnLoadRequestGrid();
		fnLoadModalGrid();
	})


	// fnLoadRequestGrid
	function fnLoadRequestGrid() {
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
			sortData : [{
				field : 'MTL_REQ_MST',
				direction : 'DESC'
			}],
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

		loadRequestGridData();
	}
	function loadRequestGridData() {//grid_list Data Arr
		console.log("loadRequestGridData()");
		
		var page_url = "/info/info/selectMaterialRequest";
		var postData = "MTL_REQ_TYPE=" + encodeURIComponent($("#S_MTL_REQ_TYPE").val()) 
					+ "&MTL_REQ_REG_DT=" + encodeURIComponent($("#S_MTL_REQ_REG_DT").val())
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
		
		if (keys == null || keys == "") {
			alert("견적을 요청할 항목을 선택하여주십시오");
		} else {
			$(".clear_val").val('');

			$("#modal_requestForm").modal('show');
			setTimeout(function() {
				w2ui['grid_list2'].resize();
				w2ui['grid_list2'].refresh();				
			}, 200);
			
			requestGrid3();

			$('#hiddenProduct_code').val('');
			$('#hiddenM_item_code').val('');
		}
	}
	function fnLoadModalGrid() {
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
				{ field:'mtl_REQ_QTY', caption:'발주수량', size:'8%', style:'text-align:center', sortable: true}
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

					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
					
					w2ui.grid_list2.save();
					
					var updateContent = JSON.stringify(w2ui['grid_list2'].getChanges());//stringify(배열을 문자열json으로 바꿔줌.)!!
					
					var keys = $("#hiddenIdx").val();//프로젝트 번호
					var Bom_MTL_IDX = this.get(event.recid).mtl_IDX;//자재번호
					var Bom_MTL_QTY = this.get(event.recid).bom_MTL_QTY;//자재 수량

					var page_url = "/info/info/updateBomQuantity";		
					var postData = 'PJT_IDX=' + keys 
								+ "&MTL_IDX="+ Bom_MTL_IDX
								+ "&BOM_MTL_QTY="+ Bom_MTL_QTY;
					$.ajax({
						url : page_url,
						type : "POST",
						data : postData,
						data_type : 'json',
						cache : false,
						success : function(response) {
							alert('수량이 수정되었습니다.');
							loadModalGrid(keys);
						},
						error : function() {
							alert('Error while request...');
						}
					})					
				}
			}			
		});
	}	
	function loadModalGridData(pjtIDX) {//선택된 값을 배열로 전달한다.
		console.log(loadModalGrid);
		
		var page_url = "/info/info/selectBOMbyPRO";
		var postData = "PJT_IDX=" + encodeURIComponent(pjtIDX);
		
		$("#hiddenIdx").val(pjtIDX);
		
		w2ui['grid_list2'].lock('loading...', true);
		w2ui['grid_list2'].clear();
		w2ui['grid_list2'].refresh();
		
		w2ui['grid_list2'].records = rowArr;
	}	
	
	
	function insertBom() {
		var keys = w2ui.grid_list.getSelection();
		
		if (keys == null || keys == "") {
			alert("먼저 프로젝트를 선택하여주십시오");
		} else {
			$(".clear_val").val('');

			$("#modal_requestForm").modal('show');
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
		    loadRequestGridData();
		}); 
	}
	function fnLoadDeliveryOption() {
	 	console.log('fnLoadCommonOption()');
	 	
		$('#S_MTL_REQ_REG_DT, #S_PJT_DLV_DT').daterangepicker({
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
		
		$('#S_MTL_REQ_REG_DT').val("");
		$('#S_PJT_DLV_DT').val("");
		
	}	
	function getFormatDate(d) {
		var month = d.getMonth() + 1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		return d.getFullYear() + '-' + month + '-' + date;
	}

	// 제조사 가져오기
	function requestVendor(val){
		console.log("requestVendor");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/account/selectVendor";
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