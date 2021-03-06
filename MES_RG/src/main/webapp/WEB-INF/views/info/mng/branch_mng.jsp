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
		<jsp:param name="selected_menu_p_cd" value="1012" />
		<jsp:param name="selected_menu_cd" value="1113" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1> 기업 정보 관리 <small>기준정보관리</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">기업 정보 관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						   	<button type="button"  class="btn btn-primary btn-sm" onclick="excelFileDownload('grid_list','기업 정보 관리');">엑셀다운로드</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="showIU_modal();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteBranch();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div  class="box-body">
						<div class="row">

							<div class="col-sm-2">
								<div class="form-group">
									 <label>사업장</label> 
									  <input type="combo" id="S_BCO_PLC" name="S_BCO_PLC" class="form-control input-sm" placeholder="사업장" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
								</div>
							</div>
							
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 620px;"></div> 
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
<div class="modal fade" id="modal_info" data-backdrop="static">
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
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">회사코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_IDX" maxlength="100" readonly="readonly">
							</div>
						</div>
					</div>
									
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">회사명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_NM" maxlength="30">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_NO" maxlength="20">
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">대표자</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_CEO_NM" maxlength="10">
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업장</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="BCO_PLC" maxlength="20">
							</div>
						</div>
					</div>						
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_ADD" value="" maxlength="60">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_TEL" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_FAX" maxlength="14">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_ML1" maxlength="60">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">URL</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="BCO_HP" maxlength="50">
							</div>
						</div>
					</div>					
					
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button"  class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button"  class="btn btn-success btn-sm" onclick="saveBranch();">저장</button>
					<button type="button"  class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
<!-- ./wrapper -->

<script type="text/javascript">
	var startValue_combo = "";
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	$(function($) {
		fnLoadCompanyGrid();
	})

	function fnLoadCompanyGrid(){
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
	        	{ field:'bco_IDX', caption:'회사코드', size:'7%', style:'text-align:center' , sortable: true},
	        	{ field:'bco_NM', caption:'회사명', size:'10%', style:'text-align:center', sortable: true},
	        	{ field:'bco_CEO_NM', caption:'대표자', size:'10%', style:'text-align:center' , sortable: true},
	        	{ field:'bco_PLC', caption:'사업장', size:'10%', style:'text-align:center' , sortable: true},
				{ field:'bco_ADD', caption:'주소', size:'17%', style:'text-align:center', sortable: true},
				{ field:'bco_TEL', caption:'전화번호', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'bco_FAX', caption:'팩스', size:'8%', style:'text-align:center', sortable: true}, 
				{ field:'bco_ML1', caption:'이메일', size:'8%', style:'text-align:center', sortable: true},
				{ field:'bco_NO', caption:'사업자번호', size:'7%', style:'text-align:center', sortable: true}
				], 
			sortData: [{field: 'bco_IDX', direction: 'DESC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	
	function loadList() {
		console.log("loadList()");
		
		var page_url = "/info/account/selectBranch";
		var postData = "BCO_PLC=" + encodeURIComponent($("#S_BCO_PLC").val());

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
							comboValue_nm.push(row.BCO_NM ? row.BCO_NM+'' : '');
							comboValue_cd.push(row.BCO_IDX ? row.BCO_IDX+'' : '');
						}
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#BCO_NM').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#BCO_IDX').w2field('combo', { items: comboValue_cd, match : 'contains' });
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
	
	//등록/수정 모달 생성
	function showIU_modal() {
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			insertBranch();
		} else  if( key.length==1 ) {	
			updateBranch();	
		}
	}			
	// modal 띄우기 
	function insertBranch() {
		console.log('insertBranch()');
	
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('등록');
 		
		$("#BCO_IDX").val('');
		$("#BCO_NM").val('');
		$("#BCO_CEO_NM").val('');
		$("#BCO_PLC").val('');
		$("#BCO_ADD").val('');
		$("#BCO_TEL").val('');
		$("#BCO_FAX").val('');
		$("#BCO_ML1").val('');
		$("#BCO_HP").val('');
		$("#BCO_NO").val('');

		$("#modal_info").modal('show');
	}
	
	function updateBranch() {
		console.log('updateBranch()');
			
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			
			var data = w2ui.grid_list.get(key[0]);			
			
			$("#BCO_IDX").val(data.bco_IDX);
			$("#BCO_NM").val(data.bco_NM);
			$("#BCO_CEO_NM").val(data.bco_CEO_NM);
			$("#BCO_CEO_NM").val(data.bco_PLC);
			$("#BCO_ADD").val(data.bco_ADD);
			$("#BCO_TEL").val(data.bco_TEL);
			$("#BCO_FAX").val(data.bco_FAX);
			$("#BCO_ML1").val(data.bco_ML1);
			$("#BCO_HP").val(data.bco_HP);
			$("#BCO_NO").val(data.bco_NO);
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveBranch() {
		console.log('saveBranch()');
		
		var BCO_IDX = $("#BCO_IDX").val();
		var BCO_NM = $("#BCO_NM").val();
		var BCO_CEO_NM = $("#BCO_CEO_NM").val();
		var BCO_PLC = $("#BCO_PLC").val();
		var BCO_ADD = $("#BCO_ADD").val();
		var BCO_TEL = $("#BCO_TEL").val();
		var BCO_FAX = $("#BCO_FAX").val();
		var BCO_ML1 = $("#BCO_ML1").val();
		var BCO_HP = $("#BCO_HP").val();
		var BCO_NO = $("#BCO_NO").val();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
			BCO_IDX = 0;
		} else if (key.length == 1){
			flag = "U";
		}

		//if(flag=="I" && !chkSubmit($("#m_account_code"), "기업 정보코드를")) return;
		if(flag=="I" && !chkSubmit($("#BCO_NM"), "회사명을")) return;

		console.log("flag = " + flag);
		
		$("#modal_info").modal('hide');
		
		var strUrl = "/info/account/saveBranch";
		var postData = "flag=" + flag
				+ "&BCO_IDX=" + encodeURIComponent(BCO_IDX)
				+ "&BCO_NM=" + encodeURIComponent(BCO_NM)
				+ "&BCO_CEO_NM=" + encodeURIComponent(BCO_CEO_NM)
				+ "&BCO_PLC=" + encodeURIComponent(BCO_PLC)
				+ "&BCO_ADD=" + encodeURIComponent(BCO_ADD)
				+ "&BCO_TEL=" + encodeURIComponent(BCO_TEL)
				+ "&BCO_FAX=" + encodeURIComponent(BCO_FAX)
				+ "&BCO_ML1=" + encodeURIComponent(BCO_ML1)
				+ "&BCO_HP=" + encodeURIComponent(BCO_HP)
				+ "&BCO_NO=" + encodeURIComponent(BCO_NO);

		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	startValue_combo = "";
			    	loadList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
		    }
		});
	}
	
	function deleteBranch() {
		console.log('deleteBranch()');
	
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {
 
			var data = w2ui.grid_list.get(key[0]);
			var code = data.bco_IDX;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/account/deleteBranch";
					var postData = "BCO_IDX=" + code;
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		console.log(data);
						 		w2ui.grid_list.clear();
						 		loadList();
						 		
						    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
						 	}
						 },
						 error: function(jqXHR, textStatus, errorThrown){
						    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
						 },
						 complete: function() {
						 }
					});
				}
			});
		} 
	}
	
</script>

</body>
</html>