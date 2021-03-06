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
		<jsp:param name="selected_menu_p_cd" value="1109" />
		<jsp:param name="selected_menu_cd" value="1114" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>프로젝트 관리 <small>프로젝트</small></h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>프로젝트관리</a></li><li class="active">프로젝트 등록/수정</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						 	<!-- <button type="button" id="btn_create" class="btn btn-success btn-sm" onclick="fileComment();">완료</button> -->
					     	<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="requestIU_modal();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteProject();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button> 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>프로젝트 등급</label> <input type="text" id="S_PJT_GRD" name="S_PJT_GRD" placeholder="ex) 프로젝트 등급"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>

							<div class="col-sm-2">
								<div class="form-group">
									<label>프로젝트명</label> <input type="text" id="S_PJT_NM" name="S_PJT_NM" placeholder="ex) 프로젝트명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>고객사</label> 
									<select id="S_CST_IDX" name="S_CST_IDX" class="form-control" style="height: 30px;" 
									onchange="loadLists()"></select>
								</div>
							</div>	
														
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> <input type="text" id="S_PJT_PRD_NM" name="S_PJT_PRD_NM" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
														
							<div class="col-sm-2">
								<div class="form-group">
								<label>납품 요청일</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" id="S_PJT_DLV_DT" placeholder="yyyymmdd~yyyymmdd"
											onchange="loadLists()">
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
											onchange="loadLists()">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>	
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id="grid_list" style="width: 100%; height: 600px;"></div>
					</div>
				</div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>


 
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
							<label for="" class="col-sm-3 control-label">프로젝트 번호</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-left" id="PJT_IDX"  readonly="readonly">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">프로젝트 등급</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-left" id="PJT_GRD" >
							</div>
						</div>
					</div>
									
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">프로젝트명</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-left" id="PJT_NM" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">프로젝트 코드</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-left" id="PJT_CD" >
							</div>
						</div>
					</div>					
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사</label>
							<div class="col-sm-8">
								<select id="CST_IDX" class="form-control input-sm" name="CST_IDX"></select>
							</div>
						</div>
					</div>					
														
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">제품명</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-left" id="PJT_PRD_NM" >
							</div>
						</div>
					</div>
													
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">발주수량</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm pull-left" id="PJT_PRD_QTY" >
							</div>
						</div>
					</div>
							
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">단위</label>
							<div class="col-sm-8">
								<select class="form-control input-sm" id="PJT_PRD_UNT" name="PJT_PRD_UNT" ></select>
							</div>
						</div>
					</div>							
															
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">납품요청일</label>
							<div class="col-sm-8">
								<div class="input-group">
									<input type="text" class="form-control input-sm dp_component_mo" id="PJT_DLV_DT" name="PJT_DLV_DT">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveProject();">저장</button>
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
<!-- ./wrapper -->


<script type="text/javascript">
	var startValue_combo = "";
	var minDate = getFormatDate(new Date());
	
	comboValue_nm = new Array;
	comboValue_cd = new Array;
	
	var loadingEnd= false;
	
	$(function($) {
		fnCdD('PJT_PRD_UNT', 'MC1027');//공통코드를 호출-재고 단위
		
		requestClient('CST_IDX');//고객사 정보를 드랍다운 형태로 만듬
		requestClient('S_CST_IDX');
	
		fnLoadCommonOption('#PJT_DLV_DT');//등록폼 달력
		fnLoadDeliveryOption('#S_PJT_REG_DT, #S_PJT_DLV_DT', 'left');//검색폼 달력		
		
		fnLoadProjectGrid(); 

		loadingEnd=true;
	})
	function loadLists(){
		if(loadingEnd){
			loadList();
		}
	}
	
	function fnLoadProjectGrid() {
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,//프로젝트 등록일, 프로젝트 등급, 프로젝트명, 프로젝트 코드, 고객사, 제품명, 발주수량, 단위, 납품 요청일
	        columns: [                
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
			sortData: [{field: 'pjt_IDX', direction: 'DESC'}],
			records: [],	//
			onReload: function(event) {},
			onClick: function (event) {}
		});
		loadList();
	}
	function loadList() {
		console.log("loadList()");
		
		var PJT_DLV_DT_DATA = $("#PJT_DLV_DT").val();
		PJT_DLV_DT_DATA = PJT_DLV_DT_DATA.replace(/-/gi, "");		

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
			dataType : 'json',
			success : function( data ) {
				console.log(data);
				
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						if (startValue_combo == "") {
							comboValue_nm.push(row.pjt_NM ? row.pjt_NM+'' : '');
							comboValue_cd.push(row.pjt_IDX ? row.pjt_IDX+'' : '');
						}
					});
					w2ui['grid_list'].records = rowArr;
					if (startValue_combo == "") {
						$('#pjt_NM').w2field('combo', { items: comboValue_nm, match : 'contains' });
						$('#pjt_IDX').w2field('combo', { items: comboValue_cd, match : 'contains' });
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
	function requestIU_modal() {
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			insertProject();
		} else  if( key.length==1 ) {	
			updateProject();	
		}
	}
	
	// modal 띄우기 
	function insertProject() {
		console.log('insertProject()');
	
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('프로젝트 등록');
 		
		$("#PJT_IDX").val('');
		$("#CST_IDX").val('');
		$("#PJT_GRD").val('');
		$("#PJT_NM").val('');
		$("#PJT_CD").val('');
		$("#PJT_PRD_NM").val('');
		$("#PJT_PRD_QTY").val('');
		$("#PJT_PRD_UNT").val('');
		$("#PJT_DLV_DT").val(minDate);

		$("#modal_info").modal('show');
	}
	
	function updateProject() {
		console.log('updateProject()');
			
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('프로젝트 수정');
			
			var data = w2ui.grid_list.get(key[0]);			
			
			$("#PJT_IDX").val(data.pjt_IDX);
			//$("#CST_IDX").val(data.cst_IDX);
			$("#CST_IDX").val(data.cst_IDX).prop("selected", true);
			$("#PJT_GRD").val(data.pjt_GRD);
			$("#PJT_NM").val(data.pjt_NM);
			$("#PJT_CD").val(data.pjt_CD);
			$("#PJT_PRD_NM").val(data.pjt_PRD_NM);
			$("#PJT_PRD_QTY").val(data.pjt_PRD_QTY);
			//$("#PJT_PRD_UNT").val(data.pjt_PRD_UNT);
			$("#PJT_PRD_UNT").val(data.pjt_PRD_UNT).prop("selected", true);
			console.log(data.pjt_PRD_UNT);
			$("#PJT_DLV_DT").val(data.pjt_DLV_DT);

			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
	}
	
	function saveProject() {
		console.log('saveProject()');
		
		var PJT_IDX = $("#PJT_IDX").val();
		var CST_IDX = $("#CST_IDX").val();
		var PJT_GRD = $("#PJT_GRD").val();
		var PJT_NM = $("#PJT_NM").val();
		var PJT_CD = $("#PJT_CD").val();
		var PJT_PRD_NM = $("#PJT_PRD_NM").val();
		var PJT_PRD_QTY = $("#PJT_PRD_QTY").val();
		var PJT_PRD_UNT = $("#PJT_PRD_UNT").val();
		var PJT_DLV_DT = $("#PJT_DLV_DT").val();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
			MTL_IDX = 0;
		} else if (key.length == 1){
			flag = "U";
		}

		if(flag=="I" && !chkSubmit($("#PJT_NM"), "프로젝트명을")) return;

// 		var flag = nullToBlank(Project_code)==''?"I":"U";
		console.log("flag = " + flag);
 		console.log( "PJT_NM = " + $("#PJT_NM").val() );
 		console.log( "PJT_DLV_DT = " + $("#PJT_DLV_DT").val() );

		
		$("#modal_info").modal('hide');

		var strUrl = "/info/account/saveProject";
		if(flag=="U") {		
		var postData = "flag=" + flag
				+ "&PJT_IDX=" + encodeURIComponent(PJT_IDX)
				+ "&CST_IDX=" + encodeURIComponent(CST_IDX)
				+ "&PJT_GRD=" + encodeURIComponent(PJT_GRD)
				+ "&PJT_NM=" + encodeURIComponent(PJT_NM)
				+ "&PJT_CD=" + encodeURIComponent(PJT_CD)
				+ "&PJT_PRD_NM=" + encodeURIComponent(PJT_PRD_NM)
				+ "&PJT_PRD_QTY=" + encodeURIComponent(PJT_PRD_QTY)
				+ "&PJT_PRD_UNT=" + encodeURIComponent(PJT_PRD_UNT)
				+ "&PJT_DLV_DT=" + encodeURIComponent(PJT_DLV_DT);
		} else {
			var postData = "flag=" + flag
				+ "&CST_IDX=" + encodeURIComponent(CST_IDX)
				+ "&PJT_GRD=" + encodeURIComponent(PJT_GRD)
				+ "&PJT_NM=" + encodeURIComponent(PJT_NM)
				+ "&PJT_CD=" + encodeURIComponent(PJT_CD)
				+ "&PJT_PRD_NM=" + encodeURIComponent(PJT_PRD_NM)
				+ "&PJT_PRD_QTY=" + encodeURIComponent(PJT_PRD_QTY)
				+ "&PJT_PRD_UNT=" + encodeURIComponent(PJT_PRD_UNT)		
				+ "&PJT_DLV_DT=" + encodeURIComponent(PJT_DLV_DT);
		}				
		
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
		    	}.2
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() { }
		});
	}
	
	function deleteProject() {
		console.log('deleteProject()');
	
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {
 
			var data = w2ui.grid_list.get(key[0]);
			var code = data.pjt_IDX;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/info/account/deleteProject";
					var postData = "PJT_IDX=" + code;
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		console.log(data);
						 		startValue_combo = "";
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