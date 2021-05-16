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
			<jsp:param name="selected_menu_cd" value="1119" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					구매 견적 관리(거래처용)<small>구매/자재 관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>구매/자재 관리 </a></li>
					<li class="active">구매 견적 관리(거래처용)</li>
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
															<button type="button" id="btn_dlv_csr" onclick="excelFileDownload('grid_list','구매 견적 관리');" class="btn btn-info btn-sm">견적 요청 Excel Download</button>
															<button type="button" id="btn_ins_csr" onclick="excelInsert();" class="btn btn-primary btn-sm">견적 결과 Excel Upload</button>															
															<button type="button" id="btn_search_csr" onclick="loadLeftGrid();" class="btn btn-warning btn-sm">조회</button>
														</div>
													</div>
													<div class="box-body">
														<div class="row">
															<div class="form-group">																
																<div class="col-sm-2" style="display:none;">
																	<label>거래처</label> 
																	<select id="S_VDR_IDX" name="S_VDR_IDX" class="form-control" style="height: 30px;" 
																	onchange="searchs();"></select>
																</div>
									
																<div class="col-sm-2">
																	<label>프로젝트명</label> 
																	<input type="text" id="S_PJT_NM" name="S_PJT_NM" placeholder="ex) 프로젝트명" class="form-control input-sm" 
																	onkeypress="if(event.keyCode==13) {searchs(); return false;}"/>
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
																	<input type="text" id="S_MTL_NM" name="S_MTL_NM" placeholder="ex) 품명" class="form-control input-sm" maxlength="100" 
																	onkeypress="if(event.keyCode==13) {searchs(); return false;}"/>
																</div>																														
																
																<div class="col-sm-2">
																	<label>제조사</label> 
																	<input type="text" id="S_MTL_MKR_CD" name="S_MTL_MKR_CD" placeholder="ex) 제조사"
																	 class="form-control input-sm" onkeypress="if(event.keyCode==13) {searchs(); return false;}"/>
																</div>	
																							
																<div class="col-sm-2">
																	<label>제조사 Model No</label> 
																	<input type="text" id="S_MTL_MKR_NO" name="S_MTL_MKR_NO" placeholder="ex) 제조사 Model No"
																	 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {searchs(); return false;}"/>
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
						
		<div class="modal fade" id="modal_ExcelUpload" data-backdrop="static">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_add_title">엑셀 일괄업로드</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
							<div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">파일명</label>
									<form method="POST" enctype="multipart/form-data" id="excelUploadForm">
										<div class="col-sm-7" style="padding-right: 0px;">
											<input type="text" id="excelName" name="excelName" class="form-control input-sm clear_field" readonly>
										</div>
										<div class="col-sm-1" style="padding-left: 5px;">
											<input type="hidden" id="pjidxHidden" name="pjidxHidden">
											<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn" > <i class="fa fa-plus"></i>
												<input id="excelFile" type="file" class="fileupload file_info" name="excelFile" onchange="$('#excelName').val(this.value)">
											</span>
										</div>
									</form>
								</div>
<!-- 							<div class="row"> -->
<!-- 								<label class="col-sm-3 control-label">하자증권 파일</label> -->
<!-- 								<div class="col-sm-7" style="padding-right: 0px;"> -->
<!-- 									<input type="text" id="MTL_ORD_FLE1_NAME" name="MTL_ORD_FLE1_NAME" class="form-control input-sm clear_field" readonly> -->
<!-- 								</div>	 -->
<!-- 								<div class="col-sm-1" style="padding-left: 7px;"> -->
<!-- 									<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i> -->
<!-- 										<input id="file_group" type="file" class="fileupload file_info" name="MTL_ORD_FLE1" onchange="$('#MTL_ORD_FLE1_NAME').val(this.value)"> -->
<!-- 									</span> -->
<!-- 								</div> -->
<!-- 							</div> -->
								
								
						</div>
					</div>
					<br/>&nbsp;* 수정가능한 컬럼은 MOQ, 단가,납기가능일,비고 입니다.
					<br/>&nbsp;* 견적요청excel을 다운받은후 해당컬럼을 수정해주세요.
				
					<div class="modal-footer" style="border-top-color: transparent !important;">
						<div class="col-md-12 text-center" style="margin-top: 10px">
							<button type="button" id="" class="btn btn-success btn-sm" onclick="UploadExcels()">등록</button>
							<button type="button" id="" class="btn btn-danger btn-sm" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
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
	<!-- ./wrapper -->


<script type="text/javascript">
	var startValue_combo = "";
	
	var minDate = getFormatDate(new Date());
	
	var loadingEnd=false;
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	
	$(function($) {
		fnCdD('S_PJT_PRD_UNT', 'MC1027');//공통코드를 호출-재고 단위
		requestVendor('S_VDR_IDX');//고객사 정보를 검색폼 드랍다운 형태로 만듬
	
		fnLoadDeliveryOption('#S_MTL_EST_REG_DT','right');//검색폼 달력
		
		fnLoadLeftGrid();
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
				footer : true,
				selectColumn : true
			},
			multiSelect : true,
			columns : [ 
				{ field:'pjt_IDX', caption:'프로젝트 번호', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'pjt_CD', caption:'프로젝트코드', size:'17%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_REQ_IDX', caption:'자재요청 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true, hidden: true},
				{ field:'vdr_IDX', caption:'거래처 번호', size:'7%', style:'text-align:center', sortable: true, hidden: true},
				
				{ field:'est_IDX', caption:'견적번호', size:'5%', style:'text-align:center', sortable: true},
				{ field:'vdr_NM', caption:'거래처', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'pjt_NM', caption:'프로젝트명', size:'10%', style:'text-align:center', sortable: true},
				{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_REQ_QTY', caption:'요청수량', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_MOQ', caption:'MOQ', size:'8%', style:'text-align:center;background-color:#fff1ce;', sortable: true, editable: {type: 'int'} },
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_EST_REG_DT', caption:'견적요청일', size:'10%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
	
						return html.substring(0,10);
	           		} 					
				},
				{ field:'mtl_EST_PRICE', caption:'단가', size:'7%', style:'text-align:center;background-color:#fff1ce;', sortable: true, editable:{type: 'int'} 
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} 				
				},
	        	{ field:'mtl_TOT_PRICE', caption:'금액', size:'10%', style:'text-align:center;background-color:#e2efda;', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
						
						html = w2utils.formatters['number'](html);
						html = setComma(html);
						
						return html;
	           		} 
	        	},
				{ field:'mtl_EST_DLV_DT', caption:'납기가능일', size:'10%', style:'text-align:center;background-color:#fff1ce;', sortable: true, editable:{type: 'date'} 
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);
	
						return html.substring(0,10);
	           		} 				
				},
				{ field:'mtl_EST_BG', caption:'비고', size:'8%', style:'text-align:center;background-color:#fff1ce;', sortable: true, editable:{type: 'text'} },
			],			
			
			sortData : [ {
				field : 'est_IDX',
				direction : 'DESC'
			} 
			],
			records : [], // rowArr
			onChange : function(event) {//갯수 수정
				event.onComplete = function() {//onSave
					console.log("onChange");

					var eventColumn = event.column;
					console.log(event);
					console.log('event.value : ' + event.value);
					
					w2ui.grid_list.save();
					
					var updateContent = JSON.stringify(w2ui['grid_list'].getChanges());//stringify(배열을 문자열json으로 바꿔줌.)!!
					
					var EST_IDX = this.get(event.recid).est_IDX;//자재요청번호
					var MTL_EST_MOQ = this.get(event.recid).mtl_EST_MOQ;//MOQ
					var MTL_EST_PRICE = this.get(event.recid).mtl_EST_PRICE;//단가
					var MTL_EST_DLV_DT = this.get(event.recid).mtl_EST_DLV_DT;//납품 가능일
					var MTL_EST_BG = this.get(event.recid).mtl_EST_BG;//비고
					
					var page_url = "/info/info/updateEstVendor";		
					var postData = 'EST_IDX=' + EST_IDX 
									+ "&MTL_EST_MOQ="+ MTL_EST_MOQ
									+ "&MTL_EST_PRICE="+ MTL_EST_PRICE
									+ "&MTL_EST_DLV_DT="+ MTL_EST_DLV_DT
									+ "&MTL_EST_BG="+ MTL_EST_BG;	 
					$.ajax({
						url : page_url,
						type : "POST",
						data : postData,
						data_type : 'json',
						cache : false,
						success : function(response) {
							alert('수정되었습니다.');

							w2ui['grid_list'].refresh();
						},
						error : function() {
							alert('Error while request...');
						}
					})					
				}
			}	
		});

		loadLeftGrid();
	}
	function loadLeftGrid() {//grid_list Data Arr
		console.log("loadLeftGrid()");
		
		var page_url = "/info/info/selectEstimate";
		var VDR_IDX = $("#S_VDR_IDX").val();
		if(VDR_IDX=="ALL"){
			VDR_IDX=0;
		}
		var postData = "PJT_NM=" + encodeURIComponent($("#S_PJT_NM").val()) 
							/* + "&VDR_IDX=" + encodeURIComponent($("#S_VDR_IDX").val())  */
							+ "&MTL_EST_REG_DT=" + encodeURIComponent($("#S_MTL_EST_REG_DT").val())
							+ "&MTL_NM=" + encodeURIComponent($("#S_MTL_NM").val()) 
							+ "&MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val()) 
							+ "&MTL_MKR_NO=" + encodeURIComponent($("#S_MTL_MKR_NO").val())
							+ "&VDR_IDX=" + encodeURI(VDR_IDX);

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

	function excelInsert(){
		$("#modal_ExcelUpload").modal('show');
		 $("#excelUploadForm")[0].reset();
	}
	function UploadExcels(){
		console.log('saveAccount()');
		if(confirm("업로드 하시겠습니까?")){
	
			//$("#modal_ExcelUpload").modal('hide');
	
			var strUrl = "/info/info/insertestimateVExcel";
				//strUrl = "/info/account/test";
					 
			// escape(
			var form = $("#excelUploadForm")[0];
			
			var data = new FormData(form);
			console.log(data);
			
							
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: strUrl,
				data: data,
				processData: false,
				contentType: false,
				cache: false,
				timeout: 600000,
			    success:function(data){
					if(data.sucess){
						w2ui.grid_list.clear();
						fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
				    	startValue_combo = "";
						form.reset();

						searchs();
						$("#modal_ExcelUpload").modal('hide');
				}else{
						fnMessageModalAlert("결과", "일부컬럼에 에러가 발생하였습니다. <br/> 에러가 발생한 컬럼은 <br/>" + data.errors + "<br/>번컬럼입니다");// Notification(MES)
						w2ui.grid_list.clear();
						startValue_combo = "";
						form.reset();
						searchs();
						$("#modal_ExcelUpload").modal('hide');
				}
			    	
			    },
			    error: function(jqXHR, textStatus, errorThrown){
				    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
			    },
			    complete: function() {
			    }
			});
		}
	}

</script>

</body>
</html>