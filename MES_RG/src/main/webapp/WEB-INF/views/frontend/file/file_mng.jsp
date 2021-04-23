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
  <title> <%=pageTitle %> </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

	<jsp:include page="/common/header_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>


<body class="hold-transition skin-<%= thema %> sidebar-mini"><!-- <.%=thema%.> -->
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1014" />
		<jsp:param name="selected_menu_cd" value="1033" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			파일 등록 <small> 파일 관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>파일 관리 </a></li>
			<li class="active">파일 등록</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box" style="margin-bottom:0px; border: none;">
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="row">
									<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
										<div class="box-header with-border" style=" background-color: #DB8EB5;">
											<h3 class="box-title">조회 조건</h3>
											<div class="box-tools pull-right">
												<button type="button"   onclick="openMngMod();" class="btn btn-info btn-sm"  >관리 부서/구분 관리</button>
												<button type="button"   onclick="openMod('ins');" class="btn btn-primary btn-sm"  >등록</button>
												<button type="button"   onclick="openMod('upd');" class="btn btn-primary btn-sm"  >수정</button>
												<button type="button"   onclick="delFile();" class="btn btn-danger btn-sm"  >삭제</button>
												<button type="button"   onclick="loadList();" class="btn btn-warning  btn-sm"  >조회</button>	 
											</div>
										</div>
										<div class="box-body">
											<div class="row">
												<div class="form-group">
													<div class="col-sm-2">
														<label>관리 부서(Level 1)</label> <select id="file_class_code"  class="form-control input-sm file_class_code" onchange="loadList();"></select>
													</div>
													<div class="col-sm-2">
														<label>파일 구분(Level 2)</label> <select  id="file_type_code"  class="form-control input-sm file_type_code"  onchange="loadList();"><option value=""> --관리 부서 선택해주세요. </option></select>
													</div>
													<div class="col-sm-2">
														<label>작성자</label> <input type="combo" id="creator_nm"  class="form-control input-sm" placeholder="작성자"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>문서 번호</label> <input type="combo" id="input_rev_no"  class="form-control input-sm" placeholder="문서 번호"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>파일 제목</label> <input type="combo" id="input_file_name"  class="form-control input-sm" placeholder="파일 제목"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
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
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

<!-- 모달 커팅 -->
<div class="modal fade" id="mng_mod" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-6" style="padding: 0px;">
					<h4 class="modal-title" id="modal_code_title">관리 부서,구분 관리</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div id="progress" class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_insertInfo" name="frm_insertInfo" class="form-horizontal">							
						
						<div class="form-group row">
							<div class="col-sm-6 ">
								<div class="col-sm-12 pull-right">
									<label for="" class="col-sm-3 col-form-label">관리 부서</label>
									<div class="col-sm-9 text-right">
										<button type="button" class="btn btn-white btn-sm" onclick="openSubMod1('ins')">추가</button>
										<button type="button" class="btn btn-white btn-sm" onclick="openSubMod1('upd')">수정</button>
										<button type="button" class="btn btn-white btn-sm" onclick="delClass()">삭제</button>
									</div>
								</div>
							</div>
							<div class="col-sm-6 ">
								<div class="col-sm-12 pull-right">
									<label for="" class="col-sm-3 col-form-label">파일 구분</label>
									<div class="col-sm-9 text-right">
										<button type="button" class="btn btn-white btn-sm" onclick="openSubMod2('ins')">추가</button>
										<button type="button" class="btn btn-white btn-sm" onclick="openSubMod2('upd')">수정</button>
										<button type="button" class="btn btn-white btn-sm" onclick="delType()">삭제</button>	
									</div>
								</div>
							</div>
						</div>
						
						<div class="form-group row">
							<div class="col-sm-6">
								<div id="mgrid_list1" class="w2g-h300"></div>
							</div>
							<div class="col-sm-6">
								<div id="mgrid_list2" class="w2g-h300"></div>
							</div>
						</div>
						
			
					</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="close_mod" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="sub_mod1" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title" >추가 / 수정</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<input type="hidden"  class="clear_field" id="hid_file_class_code"/>							
					<div class="form-group">
						<label for="" class="col-sm-3 control-label ">관리 부서명</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field" id="sm_file_class_cn">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="saveClassBtn" class="btn btn-success btn-sm">저장</button>
					<button type="button"  class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="sub_mod2" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title">추가 / 수정</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div  class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body">
				<form name="frm_insertInfo" class="form-horizontal">
					<input type="hidden" id="hid_file_type_code"/>							
					<div class="form-group">
						<label for="" class="col-sm-3 control-label">파일 구분명</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field" id="sm_file_type_cn">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" class="btn btn-success btn-sm" id="saveTypeBtn">저장</button>
					<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="ins_mod" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title" >등록 / 수정</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<input type="hidden" id="upload_mode"/>
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">관리 부서</label>
						<div class="col-sm-8">
							<select  class="form-control clear_field file_class_code org_info" id="mod_file_class_code"  ></select>
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">파일 구분</label>
						<div class="col-sm-8">
							<select class="form-control file_type_code clear_field org_info" id="mod_file_type_code"  ></select>
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">문서 번호</label>
						<div class="col-sm-8">
							<input class="form-control clear_field org_info" id="mod_input_rev_no" />
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">파일 제목</label>
						<div class="col-sm-8">
							<input class="form-control clear_field org_info" id="mod_input_file_name" />
						</div>
					</div>
					<div class="form-group row">
						<div class="row">
							<div class="col-sm-2">
							</div>
							<div class="col-sm-6">
								<label for="" class="col-sm-4 control-label ">개정일</label>
								<div class="col-sm-8">
									<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field org_info dp_component_d" id="mod_input_date" >
								</div>
							</div>
						</div>
					</div>
					<div class="form-group row">
						<div class="row">
							<div class="col-sm-2">
							</div>
							<div class="col-sm-6">
								<label for="" class="col-sm-4 control-label ">Rev/no</label>
								<div class="col-sm-8">
									<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field org_info" id="mod_file_rev_no"  >
								</div>
							</div>
							<div class="col-sm-3">
								<button type="button" id="revision_btn" class="btn btn-sm" >Revision</button>
							</div>
						</div>
					</div>
					<div class="form-group row">
						<div class="row">
							<div class="col-sm-2">
							</div>
							<div class="col-sm-6">
								<label for="" class="col-sm-4 control-label ">개정이력</label>
								<div class="col-sm-8">
									<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field org_info" id="mod_file_comment"  >
								</div>
							</div>
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">New 개정일</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field upd_info dp_component_d" id="mod_new_input_date"  >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">New Rev/no</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field upd_info" id="mod_new_revno"  >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">New 개정이력</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field upd_info" id="mod_new_file_comment" >
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label">첨부파일</label>
						<div class="col-sm-7" style="padding-right: 0px;">
							<input type="text" id="mod_file_name" name="mod_file_name" class="form-control input-sm clear_field" readonly>
						</div>	
						<div class="col-sm-1" style="padding-left: 7px;">
							<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
								<input id="file_group" type="file" class="fileupload file_info" name="file[]">
							</span>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="saveFile" class="btn btn-success btn-sm" onclick="insFile()">저장</button>
					<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
comboValue_nm1 = new Array;
comboValue_nm2 = new Array;
comboValue_nm3 = new Array;

$(function($) {
	
	loadCommFn();
	fnFileClass(null, '#file_class_code', null, '--전체--','');
	fnFileClass(null, '#mod_file_class_code');
 	loadGrid();
 	loadModGrid();
 	fnLoadFileHandler();
 	
 	loadList();
 	
})

$('#file_class_code').change(function(){
	fnFileType($(this).val(), '#file_type_code', null, '--전체--', '');
})
$('#mod_file_class_code').change(function(){
	fnFileType($(this).val(), '#mod_file_type_code');
})
$('#revision_btn').on('click', function(){
	$('.upd_info').attr('disabled', false);
	$('#mod_new_input_date').datepicker('setDate', moment().format('YYYY-MM-DD'));
	isRev = true;
	$('#mod_new_revno').attr('disabled', true);
	var new_revno = $('#mod_file_rev_no').val();
	new_revno = (new_revno.substring(new_revno.lastIndexOf('.')+1,new_revno.length)*1+1)+"";
	console.log(new_revno);
	var new_revno2 = "";
	if(new_revno.length < 3){
		for(var i = 0; i < 3 - new_revno.length; i++){
			new_revno2 += '0';
		}
	}
	new_revno = new_revno2+new_revno+"";
	console.log(new_revno);
	
	$('#mod_new_revno').val('Rev.'+new_revno);
})
$('#close_mod').on('click',function(){
	location.reload();
})
//common field
//var curBsCD = "";
//var curBsNm = "";
var curFile = null;
var isRev = false;

function loadCommFn(){
	
	$('.dp_component_mo').datepicker({
		language: 'kr',
		autoclose:true,
		viewMode: 'months',
	    minViewMode: 'months',
		format:'yyyy-mm'
	}).on('show', function(e) {
		$('.datepicker').css('z-index', '9999');
	});
	
	$('.dp_component_d').datepicker({
		language: 'kr',
		autoclose:true,
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		format:'yyyy-mm-dd'
	}).on('show', function(e) {
		$('.datepicker').css('z-index', '9999');
	});
	$('.dp_component_d').datepicker('setDate', moment().format('YYYY-MM-DD'));
	
}



// loadLeftGrid
function loadGrid(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : true,
            footer: true,
            selectColumn: true
        },
        multiSelect: true,
        columns: [                
        	{ field:'file_class_code', caption:'부서코드', style:'text-align:center', hidden : true},
        	{ field:'file_type_code', caption:'구분코드', style:'text-align:center', hidden : true},
        	{ field:'file_path', caption:'파일path', style:'text-align:center', hidden : true},
        	{ field:'file_name', caption:'파일', style:'text-align:center', hidden : true},
        	
        	{ field:'file_class', caption:'관리 부서', style:'text-align:center',size : 40, sortable: true},
			{ field:'file_type', caption:'파일 구분', style:'text-align:center',size : 80, sortable: true},
			{ field:'creator_nm', caption:'작성자', style:'text-align:center',size : 40, sortable: true},
			{ field:'input_date', caption:'개정일', style:'text-align:center',size : 50, sortable: true},
			{ field:'input_rev_no', caption:'문서 번호', style:'text-align:center',size : 70, sortable: true},
			{ field:'input_file_name', caption:'파일 제목', style:'text-align:center', sortable: true},
			{ field:'file_rev_no', caption:'Rev.No', style:'text-align:center',size : 40, sortable: true},
			{ field:'file_comment', caption:'개정이력', style:'text-align:center', sortable: true},
			
			{ field:'down_file', caption:'첨부 파일명', style:'text-align:left', sortable: true}
			], 
		sortData: [{field: 'file_class', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function(){
				var key = w2ui.grid_list.getSelection();
				var data = w2ui.grid_list.get(key[0]);
			//	curBsCD = data.business_code;
			//	curBsNm = data.business_nm;
			}
			 
		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
}

function loadModGrid(){
	var rowArr = [];
	
	$('#mgrid_list1').w2grid({
		name : 'mgrid_list1',
		show: {
			selectColumn : true
		},
		multiSelect : true,
		columns: [
			{ field:'file_class_code', hidden: true, caption:'관리 부서 코드', style:'text-align:center'},
			{ field:'file_class_nm', caption:'관리 부서명', style:'text-align:center'}
		],
		sortData: [{field: 'file_class_code'}],
		records: [],
		onSelect : function (event){
			event.onComplete = function(){
				var key = w2ui.mgrid_list1.getSelection();
				
				var data = w2ui.mgrid_list1.get(key[0]);
				
				loadMngModList2(data.file_class_code);
				$('#hid_file_class_code').val(data.file_class_code);
				w2ui.mgrid_list2.selectNone();
			}
		},
		onUnselect : function (event){
			$('#hid_file_class_code').val('');
			w2ui.mgrid_list2.clear();
		},
		onClick : function(event) {
			
		}
		
	})
		$('#mgrid_list2').w2grid({
		name : 'mgrid_list2',
		show: {
			selectColumn : true
		},
		multiSelect : true,
		columns: [
			{ field:'file_type_code', hidden: true, caption:'파일 구분 코드', style:'text-align:center'},
			{ field:'file_type_nm', caption:'파일 구분명', style:'text-align:center'}
		],
		sortData: [{field: 'file_type_code'}],
		records: [],
		onSelect : function (event){
			
		},
		onUnselect : function (event){
			
		},
		onClick : function(event) {
			
		}
		
	})
}

function openMngMod(){
	loadMngModList1();
	 setTimeout(function(){
		 w2ui['mgrid_list1'].resize();
         w2ui['mgrid_list1'].refresh();
         w2ui['mgrid_list2'].resize();
         w2ui['mgrid_list2'].refresh();
	   }, 200);
	 
	$('#mng_mod').modal('show');
}

// connect server

// select main list
function loadList() {
	var page_url = "/file/file_select";
	var postData = {
//		business_code : $('#m_business_code').val() || "",
		file_class_code : $('#file_class_code').val() || "",
		file_type_code : $('#file_type_code').val() || "",
		input_file_name : $('#input_file_name').val() || "",
		creator_nm : $('#creator_nm').val() || "",
		input_rev_no : $('#input_rev_no').val() || "",
		file_final_yn : 'Y'
	}
	
	w2ui.grid_list.lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success: function (data){
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr,function(idx, row){
					row.recid = idx + 1;
					row.down_file = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
					if(row.input_file_name)comboValue_nm1.push(row.input_file_name);
					if(row.creator_nm)comboValue_nm2.push(row.creator_nm);
					if(row.input_rev_no)comboValue_nm3.push(row.input_rev_no);
					
				})
				w2ui.grid_list.records = rowArr;
				if (startValue_combo == "") {
					$('#input_file_name').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					$('#creator_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
					$('#input_rev_no').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
				}
			} else {
				w2ui.grid_list.clear();
			}
			
			w2ui.grid_list.refresh();
			w2ui.grid_list.unlock();
			
			
		}, complete: function(){
			
			startValue_combo = ":)";
	
			document.getElementById("creator_nm").style.removeProperty("height");
			document.getElementById("input_file_name").style.removeProperty("height");
			document.getElementById("input_rev_no").style.removeProperty("height");
			
			w2ui.grid_list.selectNone();
		}
	})
}

//mgrid_list1 select
function loadMngModList1(){
	var pageUrl = "/file/selectFileClass";
	 var postData = {
			del_yn : "N"
	};
	w2ui.mgrid_list1.lock('loading...', true);
	$.ajax({
		url : pageUrl,
		type: 'POST',
		data : postData,
		dataType : 'json',
		success : function(data) {
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				})
				
				w2ui.mgrid_list1.records = rowArr;
			} else {
				w2ui.mgrid_list1.clear();
			}
			
			w2ui.mgrid_list1.refresh();
			w2ui.mgrid_list1.unlock();
		}
	})
}
// mgrid_list2 select
function loadMngModList2(fileClassType) {
	var pageUrl = "/file/selectFileType";
	var postData = {
			file_class_code : fileClassType,
			del_yn : 'N'
	}
	w2ui.mgrid_list2.lock('loading...', true);
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success :function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				})
				
				w2ui.mgrid_list2.records = rowArr;
			} else {
				w2ui.mgrid_list2.clear();				
			}
			
			w2ui.mgrid_list2.refresh();
			w2ui.mgrid_list2.unlock();
		}
	})
}

// insert /update file_info
function openMod(mode){
	
	curFile = null;
	isRev = false;
	
	$('.upd_info').attr('disabled', true);
	$('#revision_btn').attr('disabled', true);
	
	$('#mod_input_file_name').attr('disabled', false);
	$('#mod_input_rev_no').attr('disabled', false);
	$('#mod_file_rev_no').attr('disabled', false);
	$('#mod_file_comment').attr('disabled', false);
	$('#mod_input_date').attr('disabled', false);
	
	$('#upload_mode').val(mode);
	$('.clear_field').val('');
	$('#mod_input_date').datepicker('setDate', moment().format('YYYY-MM-DD'));
	
	if('upd' == mode){
		$('#revision_btn').attr('disabled', false);
		$('#mod_file_rev_no').attr('disabled', true);
		$('#mod_file_comment').attr('disabled', true);
		$('#mod_input_date').attr('disabled', true);
		$('#mod_input_file_name').attr('disabled', true);
		$('#mod_input_rev_no').attr('disabled', true);
//		$('.org_info').attr('disabled', true);
		var recids = w2ui.grid_list.getSelection();
		if(recids.length != 1){
			fnMessageModalAlert("알림", "수정 하실 파일 정보를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
			return false;
		}
		
		var pdata = w2ui.grid_list.get(recids[0]);
		
		var keys = Object.keys(pdata);
		$.each(keys, function(idx, key){
			 //if(key == 'm_business_code') key = 'business_code';
			$('#mod_' + key).val(pdata[key]);
			//if(key =='file_name') $('#mod_file_name_input').val(pdata[key].substring(0,pdata[key].lastIndexOf('.')));
			/* if(key == 'business_code'){
				$('#mod_business_code').change();
			} */
			if(key == 'file_class_code'){
				$('#mod_file_class_code').change();
			}
			
		})
		
		$('#mod_file_type_code').val(pdata['file_type_code']);
		
	} else if('ins' == mode){
		$('#file_btn').attr('disabled', false);
		/* $('#mod_business_code').val($('#m_business_code').val());
		$('#mod_business_code').change(); */
		$('#mod_file_class_code').val($('#file_class_code').val());
		$('#mod_file_class_code').change();
		$('#mod_file_type_code').val($('#file_type_code').val());
		
		$('.org_info').attr('disabled', false);
		$('#mod_file_no').val('1');
		$('#mod_file_rev_no').val('Rev.001');
		$('#mod_file_rev_no').attr('disabled', true);
	}
	
	$('#ins_mod').modal('show');
	
}

// insert/update file_class_type
function openSubMod1(mode){
	
	if(mode == 'ins'){
		$("#sub_mod1 .clear_field").val('');
	}
	if(mode == 'upd'){
		var recids = w2ui.mgrid_list1.getSelection();
		if(recids.length != 1){
			fnMessageModalAlert("알림", "수정 하실 부서코드를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
			return false;
		}
		var pdata = w2ui.mgrid_list1.get(recids[0]);
		$('#sm_file_class_cn').val(pdata.file_class_nm);
		$('#hid_file_class_code').val(pdata.file_class_code);
	}
	
	$('#saveClassBtn').off('click').on('click', function(){
		saveClass(mode);
	});
	
	$("#sub_mod1").modal('show');
}
// insert/update
function openSubMod2(mode){
	
	if(!$('#hid_file_class_code').val()){
		fnMessageModalAlert("알림", "부서를 선택해주세요.");	// Notification(MES)
		return false;
	}
	
	if(mode == 'ins'){
		$('#sub_mod2 .clear_field').val('');
	}
	if(mode == 'upd'){
		var recids = w2ui.mgrid_list2.getSelection();
		if(recids.length != 1){
			fnMessageModalAlert("알림", "수정하실 파일 구분는 하나만 선택해 주세요.");	// Notification(MES)
			return false;
		}
		var pdata =w2ui.mgrid_list2.get(recids[0]);
		$('#sm_file_type_cn').val(pdata.file_type_nm);
		$('#hid_file_type_code').val(pdata.file_type_code);
	}
	$('#saveTypeBtn').off('click').on('click',function(){
		saveType(mode);
	})
	
	$('#sub_mod2').modal('show');
}

// save detail info
function saveClass(mode){
	var pageUrl = "";
	if(mode == 'ins') pageUrl = "/file/insFileClass";
	else if (mode == 'upd') pageUrl = '/file/updFileClass';
	
	if(!$('#sm_file_class_cn').val()){
		fnMessageModalAlert("알림", "부서명을 입력해 주세요.");	// Notification(MES)
	}
	
	var postData = {
			//business_code : $('#m_business_code').val() || "",
			//business_nm : $('#m_business_code').text() || "",
			file_class_nm : $('#sm_file_class_cn').val() || "",
			file_class_code : $('#hid_file_class_code').val() || "" 
	}
	
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function (data){
			if(data.status == 200){
				if(mode == 'ins') fnMessageModalAlert("결과", "관리 부서 등록을 완료 하였습니다.");	// Notification(MES)
				else if(mode == 'upd') fnMessageModalAlert("결과", "관리 부서 수정을 완료 하였습니다.");	// Notification(MES)
				$('#sub_mod1').modal('hide');
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){
			loadMngModList1();
		}
	});
	
};

// delete class
function delClass(){
	
	fnMessageModalConfirm('알림', '관리 부서 삭제를 진행 하시겠습니까?',function(chk){
		if(chk){
			var recids = w2ui.mgrid_list1.getSelection();
			var rData ;
		 	var classData = [];
			$.each(recids, function(idx, recid){
				rData = w2ui.mgrid_list1.get(recid);
				rData.del_yn = 'Y';
				classData.push(rData);
			})
			var pageUrl = "/file/delFileClass";
			var p = "param=" + encodeURIComponent(JSON.stringify(classData));
			
			$.ajax({
				url : pageUrl,
				type: 'POST',
				data : p,
				dataType : 'json',
				success : function(data){
					if(data.status == 200){
						fnMessageModalAlert("결과", "관리 부서 삭제를 완료 하였습니다.");	// Notification(MES)
						w2ui.mgrid_list1.selectNone();
						$('#hid_file_class_code').val();
						loadMngModList1();
						w2ui.mgrid_list2.clear();
					}
				},
				error : function(jqXHR, textStatus, errorThrown){
					fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다. / " + textStatus);	// Notification(MES)
				}, complete : function(){
					loadMngModList1();
				}
				
			}) 
		}
	});
	
}
// save type
function saveType(mode){
	var pageUrl = "";
	if(mode == 'ins') pageUrl = "/file/insFileType";
	else if (mode == 'upd') pageUrl = '/file/updFileType';
	
	if(!$('#sm_file_type_cn').val()){
		fnMessageModalAlert("알림", "파일 구분명을 입력해 주세요.");	// Notification(MES)
	}
	
	var postData = {
			file_class_code : $('#hid_file_class_code').val() || "",
			file_type_code : $('#hid_file_type_code').val() || "",
			file_type_nm : $('#sm_file_type_cn').val() || "",
	}
	
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function (data){
			if(data.status == 200){
				if(mode == 'ins') fnMessageModalAlert("결과", "파일 구분 등록을 완료 하였습니다.");	// Notification(MES)
				else if(mode == 'upd') fnMessageModalAlert("결과", "파일 구분 수정을 완료 하였습니다.");	// Notification(MES)
				$('#sub_mod2').modal('hide');
			}
			
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){
			loadMngModList2($('#hid_file_class_code').val());
		}
	});
}

//delete type
function delType(){
	fnMessageModalConfirm('알림', '파일 구분 삭제를 진행 하시겠습니까?',function(chk){
		if(chk){
			var recids = w2ui.mgrid_list2.getSelection();
			var rData ;
		 	var classData = [];
			$.each(recids, function(idx, recid){
				rData = w2ui.mgrid_list2.get(recid);
				rData.del_yn = 'Y';
				classData.push(rData);
			})
			var pageUrl = "/file/delFileType";
			var p = "param=" + encodeURIComponent(JSON.stringify(classData));
			
			$.ajax({
				url : pageUrl,
				type: 'POST',
				data : p,
				dataType : 'json',
				success : function(data){
					if(data.status == 200){
						fnMessageModalAlert("결과", "파일 구분 삭제를 완료 하였습니다.");	// Notification(MES)
						w2ui.mgrid_list2.selectNone();
					}
				},
				error : function(jqXHR, textStatus, errorThrown){
					fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다. / " + textStatus);	// Notification(MES)
				}, complete : function(){
					loadMngModList2($('#hid_file_class_code').val());
				}
				
			}) 
		}
	})
	
}

// ins file info
function insFile() {
	
	//var businessCode =$('#mod_business_code').val();
	var fileClassCode = $('#mod_file_class_code').val();
	var fileClass = $('#mod_file_class_code option:selected').text();
	var fileTypeCode = $('#mod_file_type_code').val();
	var fileType = $('#mod_file_type_code option:selected').text();
	var revno = $('#mod_file_rev_no').val();
	var fileComment = $('#mod_file_comment').val();
	var nrevno = $('#mod_new_revno').val();
	var nfileComment = $('#mod_new_file_comment').val();
	var fileGroup = $('#mod_file_group').val() || '';
	var fileNo = $('#mod_file_no').val() || '';
	var fileName = $('#mod_file_name').val() || '';
	var inputFileName = $('#mod_input_file_name').val() || '';
	var inputRevNo = $('#mod_input_rev_no').val() || '';
	var inputDate = $('#mod_input_date').val().replace(/-/gi,'') || '';
	var ninputDate = $('#mod_new_input_date').val().replace(/-/gi,'') || '';
	
	if(!fileClassCode || !fileTypeCode || !inputFileName || !inputRevNo ){
		fnMessageModalAlert("알림", "관리 부서, 파일 구분는 필수 값입니다.");	// Notification(MES)
		return false;
	}
	
	if((fileGroup) && (!fileClassCode || !fileTypeCode || !nrevno || !nfileComment)){
		fnMessageModalAlert("알림", "수정 시 관리 부서, 파일 구분, Rev/no 는 필수 값입니다.");	// Notification(MES)
		return false;
	}
	
	fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
		if(chk){
			
			if(curFile){
				curFile.submit();
			} else {
				if(fileGroup && fileNo && !isRev){
					var pageUrl = '/file/updFileInfo';
					var postData = {
						file_group : fileGroup,
						file_no : fileNo,
						//business_code : businessCode,
						file_class_code : fileClassCode,
						file_class : fileClass,
						file_type_code : fileTypeCode,
						file_type : fileType,
						file_rev_no : revno,
						file_comment : fileComment,
						input_file_name : inputFileName,
						input_rev_no : inputRevNo,
						input_date : inputDate
						
					}
					$.ajax({
						url : pageUrl,
						type : 'POST',
						data : postData,
						dataType : 'json',
						success : function(data){
							if(data.status = 200){
								fnMessageModalAlert("결과", "파일정보 수정을 완료 하였습니다.");	// Notification(MES)
								$('#ins_mod').modal('hide');
							}
						},
						error : function(jqXHR, textStatus, errorThrown){
							fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
						}, complete : function(){
							loadList();
						}
					})
				} else {
					fnMessageModalAlert("알림", "등록된 파일 정보가 없습니다.");	// Notification(MES)
				}
			}
			
			
		}
	})
	
}

function delFile(){
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else{
		fnMessageModalConfirm('알림', '파일 삭제를 진행 하시겠습니까?',function(chk){
			if(chk ){
				var recids = w2ui.grid_list.getSelection();
				var rData;
				var fileData = [];
				
				$.each(recids, function(idx, recid){
					rData = w2ui.grid_list.get(recid);
					fileData.push(rData);
				})
				var p = "param=" + encodeURIComponent(JSON.stringify(fileData));
				var pageUrl = "/file/delFileInfo";
				$.ajax({
					url : pageUrl,
					type : 'POST',
					data : p,
					dataType : 'json',
					success : function(data){
						if(data.status == 200){
							fnMessageModalAlert("결과", "파일정보 삭제를 완료 하였습니다.");	// Notification(MES)
						}
						},
					error : function(jqXHR, textStatus, errorThrown){
						fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다. / " + textStatus);	// Notification(MES)
					}, complete : function(){
						loadList();
					}
				})
			}
		})				
	}
}

//set select box

//business
/* 
function fnBusiness(val){
	initOptions($('#'+val+'business_code')); // select 박스 초기화
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent("MC1012");
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 /* 1 \*\/ ) {
	    		rowArr = data.rows;
	    		
	    		if(val != "m_" && val != "mod_")
	    			$("#"+val+"business_code" ).append("<option value="+''+">" + "전체" + "</option>");
	    		
				$.each(rowArr, function(idx, row){
					$("#"+val+"business_code" ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
				});
				
	 			$("#"+val+"business_code option:eq(0)").prop("selected", true);	 			
				
	    	} else if(data.status == "200" && (data.rows).length==0 ) {
	    		initOptions($('#'+val+'business_code')); // select 박스 초기화
	    		
	    	} 
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	console.log('3');
	    	if($('#'+val+'business_code').val()){
	    		fnFileClass('', '#'+ (val== 'm_' ? '' : val)+'file_class_code');
	    	}
	    }
	});
	
}
*/

function fnFileClass(val, comp,  initSelect,  initTxt, initVal, fixYn){
	var $target ;
	if(!comp) $target = $('.file_class_code');
	else $target = $(comp);
	
	$target.html('');
	var strUrl = "/file/selectFileClass";
	var postData = "";
	//if(val) postData = "business_code=" + encodeURIComponent(val);
	postData="del_yn=N";
	var op = "";
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200"){
				rowArr = data.rows;
				if(initTxt) op += "<option value='"+initVal+"' >" + initTxt + "</option>";
				
				$.each(rowArr, function(idx, row){
					op += "<option value='" + row.file_class_code + "' >" + row.file_class_nm + "</option>";
				})
				
				$target.append(op);
				
				if(initSelect) $target.val(initSelect);
				else {
					if(!comp) $('.file_class_code option:eq(0)').prop("selected", true);
					else $(comp + ' option:eq(0)').prop('selected', true);
				}
			}
		},
		  error: function(jqXHR, textStatus, errorThrown){
		    //	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	//fnFileType($('#file_class_code').val());
	    	$('.file_class_code').change();
	    }
	})
}

function fnFileType(val, comp, initSelect,  initTxt, initVal, fixYn){
	
	var $target;
	
	if(!comp) $target = $('.file_type_code');
	else $target = $(comp);
	
	$target.html('');
	
	var strUrl = "/file/selectFileType";
	var postData = "";
	postData = "del_yn=" + encodeURIComponent("N");
	if(val) postData += "&file_class_code=" + encodeURIComponent(val);
	
	var op = "";
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200"){
				rowArr = data.rows;
				if(initTxt) op += "<option value='"+initVal+"' >" + initTxt + "</option>";
				$.each(rowArr, function(idx, row){
					op += "<option value='" + row.file_type_code + "' >" + row.file_type_nm + "</option>";
				})
				
				$target.append(op);
				
				
				if(initSelect) $target.val(initSelect);
				else {
					if(!comp) $('.file_type_code option:eq(0)').prop("selected", true);
					else $(comp + ' option:eq(0)').prop('selected',true);
				}
			}
		},
		  error: function(jqXHR, textStatus, errorThrown){
		    //	fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	})
}


function initOptions(obj) {
    $(obj)
    .find('option')
    .remove()
    .end()
//	    .append('<option value="All">-----</option>')
    .val();
}

// upload file

function setUploadFileParma(pInfo, pName){
	curFile = pInfo;
}

function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/file/file_upload",
		dataType : 'json',
		autoUpload : false,
		enctype : "multipart/form-data",
 		//acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 30720000, 
		add: function(e, data){
			
			if(data.files[0].size > 30720000)
			{
				fnMessageModalAlert("알림", "파일 용량이 너무 큽니다.");
				return;
			}
			$('#mod_file_name').val(data.files[0].name);
			if(!$('#mod_input_file_name').val()) $('#mod_input_file_name').val(data.files[0].name);
			setUploadFileParma(data, data.files[0].name);
		},
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Error", file.error);
		} else {
			setUploadFileParma(data, file.name);
		}
	}).on('fileuploadprogressall', function(e, data) {
		 
		$('#progress').show();
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
    	
    	/* $('#t_' + e.target.id).val(data.files[0].name);
    	$('#a_' + e.target.id).val(data.result.file_group); */
    	
    	$('#ins_mod').modal('hide');
    	loadList();
    	
	}).on('fileuploadfail', function(e, data) {
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).on('fileuploadsubmit', function(e, data){
		var $this = $(this);
		//data.formData = {};
		//data.url = result.url;
		//var businessCode = $('#mod_business_code').val();
		var fileClassCode = $('#mod_file_class_code').val();
		var fileClass = $('#mod_file_class_code option:selected').text();
		var fileTypeCode = $('#mod_file_type_code').val();
		var fileType = $('#mod_file_type_code option:selected').text();
		var revno = $('#mod_file_rev_no').val();
		var fileComment = $('#mod_file_comment').val();
		var nrevno = $('#mod_new_revno').val();
		var nfileComment = $('#mod_new_file_comment').val();
		var uploadMode = $('#upload_mode').val();
		var fileGroup = $('#mod_file_group').val();
		var fileNo = $('#mod_file_no').val();
		var fileName = $('#mod_file_name').val();
		var inputFileName = $('#mod_input_file_name').val();
		var inputRevNo = $("#mod_input_rev_no").val();
		var inputDate = $('#mod_input_date').val().replace(/-/gi,'');;
		var ninputDate = $('#mod_new_input_date').val().replace(/-/gi,'');;
		data.formData = {
			//business_code : businessCode,
			file_class_code : fileClassCode,
			file_class : fileClass,
			file_type_code : fileTypeCode,
			file_type : fileType,
			file_rev_no : revno,
			file_comment : fileComment,
			file_new_rev_no : nrevno,
			file_new_comment : nfileComment,
			mode : uploadMode,
			file_group : fileGroup,
			file_no : fileNo,
			file_name : fileName,
			input_file_name : inputFileName,
			input_rev_no : inputRevNo,
			input_date : inputDate,
			input_new_date : ninputDate
			
		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}


</script>

</body>
</html>