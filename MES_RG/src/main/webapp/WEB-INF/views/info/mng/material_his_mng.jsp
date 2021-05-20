<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<div class="wrapper">
		<jsp:include page="/common/top_menu_inc" flush="true">
			<jsp:param name="fb_div" value="F" />
			<jsp:param name="page_title" value="0" />
		</jsp:include>

		<jsp:include page="/common/sidebar_menu_inc" flush="true">
			<jsp:param name="menu_div" value="F" />
			<jsp:param name="selected_menu_p_cd" value="1122" />
			<jsp:param name="selected_menu_cd" value="1124" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>자재재고관리 <small>재고관리</small></h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 재고관리</a></li>
					<li class="active">자재재고관리</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<section class="col-lg-12">
						<div class="box box-success box-solid"
							style="min-height: 90px; border-color: #DB8EB5;">

							<div class="box-header with-border" style="background-color: #DB8EB5;">
								<h3 class="box-title">조회조건</h3>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-primary btn-sm" onclick="excelFileDownload('grid_list','자재 재고 관리');">엑셀다운로드</button>
									<button type="button" id="btn_in" class="btn btn-primary btn-sm" onclick="showStockAjustModal('IN');">입고조정</button>
									<button type="button" id="btn_out" class="btn btn-primary btn-sm" onclick="showStockAjustModal('OUT');">출고조정</button>
									<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>
								</div>
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-sm-2">
										<div class="form-group">
											<label>제조사</label> 
											<input type="combo" id="S_MTL_MKR_CD" name="S_MTL_MKR_CD" class="form-control input-sm" placeholder="제조사"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>자재분류</label> 
											<input type="combo" id="S_MTL_CATE" name="S_MTL_CATE" class="form-control input-sm" placeholder="자재분류"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>품목</label> 
											<input type="combo" id="S_MTL_NM" name="S_MTL_NM" class="form-control input-sm" placeholder="품목"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<label>제조사 품번</label> 
											<input type="combo" id="S_MTL_MKR_NO" name="S_MTL_MKR_NO" class="form-control input-sm" placeholder="제조사 품번"
												onkeypress="if(event.keyCode==13) {loadList(); return false;}">
										</div>
									</div>
								</div>
								<div id="tabs" style="width: 100%;"></div>
								<div id="selected-tab" style="padding: 20px 10px">
									<div id="grid_list" style="width: 100%; height: 620px;"></div>
									<div id="grid_list2" style="width: 100%; height: 620px;"></div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</section>
			<!-- //content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- 모달(출고/입고) -->
		<div class="modal fade" id="modal_stockAjust" data-backdrop="static">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_stockAjust_title">입고/출고 조정</h4>
					</div>
					<div class="modal-body" id="modal_code_body">
						<form id="frm_inOut" name="frm_inOut" class="form-horizontal" method="POST">
							<div class="row">
								<div class="form-group">
									<label for="WHS_HIS_QTY" class="col-sm-3 control-label">수량</label>
									<div class="col-sm-7">
										<input type="number" class="form-control input-sm pull-right" id="WHS_HIS_QTY" name="WHS_HIS_QTY" maxlength="30">
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label for="WHS_HIS_BG" class="col-sm-3 control-label">비고</label>
									<div class="col-sm-7">
										<textarea class="form-control input-sm pull-right" id="WHS_HIS_BG" name="WHS_HIS_BG" rows="2"></textarea>
									</div>
								</div>
							</div>


							<div class="row">
								<div class="col-md-12" id="msg" style="font-weight: bold; color: blue;"></div>
							</div>
							<input type="hidden" name="WHS_HIS_GB" id="WHS_HIS_GB" />
						</form>
					</div>
					<div class="modal-footer">
						<div class="col-md-12 text-center">
							<button type="button" class="btn btn-success btn-sm" onclick="stockAdjust();">저장</button>
							<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 2차모달끝 -->

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
	var GB = "";

	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	$(function($) {
		tab_grid();
		fnLoadList1Grid();
		fnLoadList2Grid();
		
		loadList();
	})
	
	var currentTab = 'tab1';
	//tab설정
	function tab_grid(){
		$('#date_parent').hide();

		$('#tabs').w2tabs({
	        name: 'tabs',
	        active: 'tab1',
	        tabs: [
	            { id: 'tab2', text: '입고내역' },
	            { id: 'tab3', text: '출고내역' },
	            { id: 'tab1', text: '재고현황', style: "background-color: #8bcb77;" }
	        ],
	        onClick: function (event) {
	        	w2ui['tabs'].set('tab1', { style: "background-color:;" });
	 			w2ui['tabs'].set('tab2', { style: "background-color:;" });
				w2ui['tabs'].set('tab3', { style: "background-color:;" });
				
	  			$('#btn_in').attr('disabled', true);
				$('#btn_out').attr('disabled', true);

				currentTab = event.target;
				var recids = w2ui.grid_list.getSelection();
	            if(event.target == 'tab1') {  	
	      			$('#btn_in').attr('disabled', false);
	       			$('#btn_out').attr('disabled', false);
	       			
	            	w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });
	        	} else if(event.target == 'tab2') {
	      			console.log(' 입고내역');

	            	w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });
	    			//$('#date_parent').show(); 			
	       		} else if(event.target == 'tab3') {
	     			console.log(' 출고내역');

	            	w2ui['tabs'].set('tab3' ,  { style: "background-color: #8bcb77;"  });
	            	
/* 	    			document.getElementById('whs_HIS_DT').innerHTML = '출고일자';
	    			document.getElementById('whs_HIS_GB').innerHTML = '출고유형';
	    			document.getElementById('whs_HIS_QTY').innerHTML = '출고수량';    */
	      		}
				
	   			w2ui['tabs'].refresh();
	   			
	   			loadList();
	        }
		});
	}
	
	function loadList(){
		if(currentTab=='tab1') {
			$("#grid_list").show();
			$("#grid_list2").hide();
			
			loadList1();
		} else if(currentTab=='tab2') {
			$("#grid_list").hide();
			$("#grid_list2").show();
			
			loadList2("IN");
		} else if(currentTab=='tab3') {
			$("#grid_list").hide();
			$("#grid_list2").show();
			
			loadList2("OUT");
		} else {
			console.log('tab1');
			$("#grid_list").show();
			$("#grid_list2").hide();
			
			loadList1();			
		}
	}
	function fnLoadList1Grid(){
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: true,
	        columns: [                
	        	{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'mtl_CATE', caption:'자재 분류', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
				{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
				{ field:'mtl_QTY', caption:'재고수량', size:'8%', style:'text-align:center', sortable: true},
				/* { field:'mtl_BG', caption:'비고', size:'7%', style:'text-align:center', sortable: true} */
			], 
			sortData: [{field: 'mtl_IDX', direction: 'DESC'}],
			records: [],	//
			onReload: function(event) {

			},
			onClick: function (event) {},
			onChange : function(event) {

			}	
		});
	}
	function loadList1() {
		console.log("loadList1()");
		
		var page_url = "/info/account/selectMaterial";
		var postData = "MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					  + "&MTL_CATE=" + encodeURIComponent($("#S_MTL_CATE").val())
					  + "&MTL_NM="   + encodeURIComponent($("#S_MTL_NM").val())
					  + "&MTL_MKR_NO="+ encodeURIComponent($("#S_MTL_MKR_NO").val());

		w2ui['grid_list'].lock('loading...', true);
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
							comboValue_nm.push(row.MTL_NM ? row.MTL_NM+'' : '');
							comboValue_cd.push(row.MTL_IDX ? row.MTL_IDX+'' : '');
						}
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#MTL_NM').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#MTL_IDX').w2field('combo', { items: comboValue_cd, match : 'contains' });
					}
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {
				startValue_combo = ":)";
			}
		});
	}

	function fnLoadList2Grid() {
		// 	 console.log(page_url);
		
			$('#grid_list2').w2grid({ 
		        name: 'grid_list2',
		        show: {
		        	selectColumn: false,
					lineNumbers : false,
		            footer: true
		        },
		        multiSelect: false,
		        columns: [                
		        	{ field:'whs_HIS_IDX', caption:'입출고 번호', size:'7%', style:'text-align:center' , sortable: true, hidden:true},
		        	{ field:'mtl_IDX', caption:'자재코드', size:'7%', style:'text-align:center' , sortable: true},
		        	{ field:'mtl_CATE', caption:'자재 분류', size:'10%', style:'text-align:center', sortable: true},
		        	{ field:'mtl_NM', caption:'품목', size:'10%', style:'text-align:center' , sortable: true},
					{ field:'mtl_MKR_NO', caption:'제조사 품번', size:'17%', style:'text-align:center', sortable: true},
					{ field:'mtl_STD', caption:'규격', size:'8%', style:'text-align:center', sortable: true}, 
					{ field:'mtl_MKR_CD', caption:'제조사', size:'8%', style:'text-align:center', sortable: true}, 
					{ field:'mtl_PRICE', caption:'단가', size:'8%', style:'text-align:center', sortable: true},
					{ field:'mtl_UNT', caption:'재고단위', size:'8%', style:'text-align:center', sortable: true},
					{ field:'mtl_QTY', caption:'재고수량', size:'8%', style:'text-align:center', sortable: true},
					{ field:'whs_HIS_DT', caption:'일자', size:'8%', style:'text-align:center', sortable: true},
					{ field:'whs_HIS_GB', caption:'유형', size:'8%', style:'text-align:center', sortable: true
						,render: function (record, index, col_index) {
							var html = this.getCellValue(index, col_index);
							if(html=="IN") {
								return "입고";
							} else if(html=="OUT") {
								return "출고";
							} else {
								return "입고";
							}
			              html = w2utils.formatters['number'](html);
			              html = setComma(html);
			                  return html;
			              } 
					},
					{ field:'whs_HIS_QTY', caption:'수량', size:'8%', style:'text-align:center', sortable: true},
					{ field:'whs_HIS_BG', caption:'비고', size:'8%', style:'text-align:center', sortable: true},
				], 
				sortData: [{field: 'whs_HIS_IDX', direction: 'DESC'}],
				records: [],
			});
	}		
	function loadList2(GB) {
		console.log("loadList2()");
		var rowArr = [];
		var GB = GB;
		var page_url = "/info/info/selectWHS";
		var postData = "MTL_MKR_CD=" + encodeURIComponent($("#S_MTL_MKR_CD").val())
					  + "&MTL_CATE=" + encodeURIComponent($("#S_MTL_CATE").val())
					  + "&MTL_NM="   + encodeURIComponent($("#S_MTL_NM").val())
					  + "&MTL_MKR_NO="+ encodeURIComponent($("#S_MTL_MKR_NO").val())
					  + "&WHS_HIS_GB=" + GB;

		w2ui['grid_list2'].lock('loading...', true);
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
							comboValue_nm.push(row.MTL_NM ? row.MTL_NM+'' : '');
							comboValue_cd.push(row.MTL_IDX ? row.MTL_IDX+'' : '');
						}
					});
					w2ui.grid_list2.clear();
					w2ui['grid_list2'].records = rowArr;
				} else {
					w2ui.grid_list2.clear();
				}
				w2ui['grid_list2'].refresh();
				w2ui['grid_list2'].unlock();
			},complete: function () {
				
			}
		});
		
	}

	//입/출고 조정 모달창 띄우기
	function showStockAjustModal(GB){
		var key = w2ui.grid_list.getSelection();
		var modal_title ="";
		
		if(key.length==0){
			fnMessageModalAlert("알림", "추가하실 자재코드를 선택해 주세요.");
			return false;
		} else {
			$("#WHS_HIS_QTY").val("") ;
			$("#WHS_HIS_BG").val("");
			
			$("#modal_stockAjust").modal('show');
			
			if (GB == "IN") {
				modal_title = "입고 조정";
			} else {
				modal_title = "출고 조정";
			}
			
			$("#WHS_HIS_GB").val(GB);
			$("#modal_stockAjust_title").html(modal_title);
		}
	}		
	//강제 입고/출고 조정
	function stockAdjust() {		
		var keys = w2ui.grid_list.getSelection();
		var reqDataList = [];
		var WHS_HIS_QTY;
		
		if(keys.length==0) {
			fnMessageModalAlert("알림", "추가하실 자재코드를 선택해 주세요.");
			return false;
		} else {
			var data = w2ui.grid_list.get(keys[0]);			
			var ORD_IDX = 0;//구매발주번호	
			var MTL_ORD_DTL_IDX = 0;
			var WHS_HIS_GB = $("#WHS_HIS_GB").val();//WHS_HIS_GB
			
			if($('#WHS_HIS_QTY').val() == "") {
				WHS_HIS_QTY = "0";
			} else {
				WHS_HIS_QTY = $('#WHS_HIS_QTY').val();
			}
			
			for (var i = 0; i < keys.length; i++) {
				if(w2ui.grid_list.records[keys[i]-1].mtl_ORD_DTL_IDX !="")  MTL_ORD_DTL_IDX = w2ui.grid_list.records[keys[i]-1].mtl_ORD_DTL_IDX;
				if(w2ui.grid_list.records[keys[i]-1].ord_IDX !="")  ORD_IDX = w2ui.grid_list.records[keys[i]-1].ord_IDX;
				
				var DataList = {
					ORD_IDX : w2ui.grid_list.records[keys[i]-1].ord_IDX,
					MTL_ORD_DTL_IDX : MTL_ORD_DTL_IDX,
					MTL_IDX : w2ui.grid_list.records[keys[i]-1].mtl_IDX,
					WHS_HIS_GB : WHS_HIS_GB,
					WHS_HIS_TYPE : "F",
					WHS_HIS_QTY : WHS_HIS_QTY,
					WHS_HIS_BG : $("#WHS_HIS_BG").val()
				};
				
				reqDataList.push(DataList);
			}			

			if (confirm("등록하시겠습니까?")) {
				console.log(reqDataList);

				var page_url = "/info/info/stockAdjust";
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
							reqDataList=[];

							loadList1();
							
							alert("추가되었습니다");
							
							$("#modal_stockAjust").modal('hide');
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