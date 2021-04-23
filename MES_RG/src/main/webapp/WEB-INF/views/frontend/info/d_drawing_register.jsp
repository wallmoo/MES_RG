<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
String memberId = SessionUtil.getMemberId(request);
String memberNm = SessionUtil.getMemberNm(request);
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
	
	<style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	</style>
</head>


<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1040" />
		<jsp:param name="selected_menu_cd" value="1047" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      도면 등록
        <small>도면관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 도면 관리</a></li><li class="active">도면 등록</li>
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
												<button type="button"   onclick="openMod('ins');" class="btn btn-primary btn-sm"  >등록</button>
												<button type="button"   onclick="requsetModalPw();" class="btn btn-primary btn-sm"  >수정</button>
												<button type="button"   onclick="delFile();" class="btn btn-danger btn-sm"  >삭제</button>
												<button type="button"   onclick="loadList();" class="btn btn-warning  btn-sm"  >조회</button>	 
											</div>
										</div>
										<div class="box-body">
											<div class="row">
												<div class="form-group">
													<div class="col-sm-2">
														<label>P/N</label> <input type="text" id="item_code"  class="form-control input-sm" placeholder="P/N"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>품명</label> <input type="text" id="item_nm"  class="form-control input-sm" placeholder="품명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													
													<div class="col-sm-2">
														<label>업체명</label> <input type="text" id="drw_nm"  class="form-control input-sm" placeholder="업체명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>적용</label> <input type="text" id="drw_no"  class="form-control input-sm" placeholder="적용"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>

													
													<div class="col-sm-2">
														<label>Rev.No</label> <input type="text" id="file_rev_no"  class="form-control input-sm" placeholder="Rev.No"
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
					<input type="hidden" id="fg_check_yn" name="fg_check_yn" value="N">
					<input type="hidden" id="upload_mode"/>
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>
					<input type="hidden" class="form-control input-sm pull-right" id="m_business_code"/>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">Business</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right" id="m_business_nm"  name="m_business_nm"  >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">P/N</label>
						<!-- <div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right" id="m_item_code"  >
						</div> -->
						<div class="col-sm-5">
							<input type="text" class="form-control input-sm pull-right" id="m_item_code" maxlength="100" >
						</div>
						<div class="col-sm-3">
	                  		<button type="button" id="btn_check" class="btn btn-primary btn-sm">P/N 중복체크</button>
	                   </div>
	                   
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">품명</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right" id="m_item_nm"  >
						</div>
					</div>
					
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">업체명</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right" id="m_drw_nm"  >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">적용</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right" id="m_drw_no"  >
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
						<label class="col-sm-3 control-label">cad첨부파일</label>
						<div class="col-sm-7" style="padding-right: 0px;">
							<input type="text" id="mod_cad_file_name" name="mod_cad_file_name" class="form-control input-sm clear_field" readonly>
						</div>	
						<div class="col-sm-1" style="padding-left: 7px;">
							<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"  onclick="type('cad');"> <i class="fa fa-plus"></i>
								<input id="file_group" type="file" class="fileupload file_info" name="file[]">
							</span>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label">pdf첨부파일</label>
						<div class="col-sm-7" style="padding-right: 0px;">
							<input type="text" id="mod_pdf_file_name" name="mod_pdf_file_name" class="form-control input-sm clear_field" readonly>
						</div>	
						<div class="col-sm-1" style="padding-left: 7px;">
							<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn" onclick="type('pdf');"> <i class="fa fa-plus"></i>
								<input id="file_group" type="file" class="fileupload file_info" name="file[]">
							</span>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="saveFile" class="btn btn-success btn-sm" onclick="insFile()">저장</button>
					<button type="button"  class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 비밀번호확인 모달 -->
<div class="modal fade" id="modal_pw" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title" >수정 비밀번호 입력</h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<input type="hidden" class="form-control input-sm pull-right" id="m_business_code"/>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">비밀번호</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right" id="m_password"  name="m_password"  >
						</div>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-sm-2"></div>
				<div class="col-sm-6">
						<input type="text" maxlength="100"  class="form-control input-sm pull-right" id="m_password_input"  name="m_password_input"  >
					</div>
				<div class="col-md-4 text-left">
				    <button type="button" id="savePw" class="btn btn-success btn-sm" onclick="confirmPw()">확인</button>
					<button type="button"  class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
comboValue_nm4 = new Array;
comboValue_nm5 = new Array;


$(function($) {
	requestPassword();
	fnBusiness('m_');
	fnBusiness("mod_");

 	loadGrid();
	loadList();
	requestMaterial();
	
	


	fnLoadFileHandler();
	
 	
 	
})



//품명,품번 자동완성
$("#m_item_nm").change(_.debounce(function(event) {
	
	var item_nm = $("#m_item_nm").val();
	$(this).val(function(index, value) {
		console.log('m_item_nm key_up : '+ value);
		
		getItemInfo('nm',value);
		return value
	});
	
},400));
$("#m_item_code").change(_.debounce(function(event) 
		{
	
			var item_code = $("#m_item_code").val();
			$(this).val(function(index, value) {
				console.log('item_code key_up : '+ value);
				
				getItemInfo('cd',value);
				return value
			});
	
},400));

$("#m_item_code").change(function(){
	$("#fg_check_yn").val("N");
});

$( "#btn_check" ).on('click', function(e) {
	e.preventDefault();
	if($.trim($("#m_item_code").val()).length == 0) {
		fnMessageModalAlert("알림", "PN를 입력하세요.");
		return;
	}
	
	fncheckPN();
});

function fncheckPN(){	
  var item_code = $("#m_item_code").val();
  var postData = "item_code="+encodeURIComponent(item_code);
  var formURL = "/frontend/drwfile/fnCheckPN";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		if(data.cnt > 0) {
      			$("#fg_check_yn").val("N");
      			fnMessageModalAlert("알림", "입력하신 PN는 사용할 수 없습니다.(이미 사용중)");
      		} else {
      			$("#fg_check_yn").val("Y");
      			fnMessageModalAlert("알림", "입력하신 PN는 사용할 수 있습니다.");
      		}
      	} else {
      		fnMessageModalAlert("알림", "입력하신 PN 중복여부를 확인하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("알림", "입력하신 PN 중복여부를 확인하는데 에러가 발생하였습니다.");	
      }
  });
}


$('#revision_btn').on('click', function(){
	$('.upd_info').attr('disabled', false);
	isRev = true;
 	$('#mod_new_revno').attr('disabled', true);

	$('#mod_new_file_comment').attr('disabled', false); 

	$('#mod_pdf_file_name').val('');
	$('#mod_cad_file_name').val('');
	
	var new_revno = $('#mod_file_rev_no').val();
	new_revno = (new_revno.substring(new_revno.lastIndexOf('.')+1,new_revno.length)*1+1)+"";
	console.log(new_revno);
	var new_revno2 = "";
	if(new_revno.length < 2){
		for(var i = 0; i < 2 - new_revno.length; i++){
			new_revno2 += '0';
		}
	}
	new_revno = new_revno2+new_revno+"";
	console.log(new_revno);
	
	$('#mod_new_revno').val('Rev.'+new_revno);
})
//common field
var curBsCD = "";
var curBsNm = "";
var curFile = null;
var isRev = false;
// loadLeftGrid
function loadGrid(){
// 	 console.log('fnSetLoadWorkerGrid()');
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
        	{ field:'business_code', caption:'비즈니스코드', style:'text-align:center', hidden : true},
  
        	{ field:'cad_file_path', caption:'cad파일path', style:'text-align:center', hidden : true},
        	{ field:'cad_file_name', caption:'cad파일name', style:'text-align:center', hidden : true},
        	{ field:'cad_file_ext', caption:'cad파일ext', style:'text-align:center', hidden : true},
        	{ field:'cad_file_size', caption:'cad파일size', style:'text-align:center', hidden : true},
        	
        	{ field:'pdf_file_path', caption:'pdf파일path', style:'text-align:center', hidden : true},
         	{ field:'pdf_file_name', caption:'pdf파일name', style:'text-align:center', hidden : true},
         	{ field:'pdf_file_ext', caption:'pdf파일ext', style:'text-align:center', hidden : true},
         	{ field:'pdf_file_size', caption:'pdf파일size', style:'text-align:center', hidden : true},
         	
        	{ field:'file_name', caption:'파일', style:'text-align:center', hidden : true},
        	{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center', sortable: true},
		
			{ field:'drw_nm', caption:'업체명', size:'12%', style:'text-align:center', sortable: true},
			{ field:'drw_no', caption:'적용', size:'12%', style:'text-align:center', sortable: true},	

			{ field:'file_rev_no', caption:'Rev.No', size:'12%', style:'text-align:center', sortable: true},
			{ field:'down_cad_file_name', caption:'cad파일', size:'20%', style:'text-align:left', sortable: true},
			{ field:'down_pdf_file_name', caption:'pdf파일', size:'20%', style:'text-align:left', sortable: true},
			{ field:'creator', caption:'작성자', size:'10%', style:'text-align:center', sortable: true}
			], 
	/* 	sortData: [{field: 'business_code', direction: 'ASC'}], */
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function(){
				var key = w2ui.grid_list.getSelection();
				var data = w2ui.grid_list.get(key[0]);
				curBsCD = data.business_code;
				curBsNm = data.business_nm;
			}
			 
		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
}

var startValue_combo = "";
var startValue_combo2 = "";
comboValue_nm = new Array;
comboValue_cd = new Array;

var startValue_combo3 = "";


var materialArr = new Array;


comboValue_ctm_cd = new Array;
comboValue_ctm_nm = new Array;

function requestMaterial(){
	var page_url = "/info/material/selectMaterial3";
	var postData = 'business_code=MD1243&item_nm='+$('#m_item_nm').val();
	startValue_combo = "";
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData,
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				materialArr = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
					if (startValue_combo2 == "") {
						comboValue_nm.push(row.item_nm);
						comboValue_cd.push(row.item_code);
					}
				});
				console.log('#########CHECK 1  ');
				if (startValue_combo2 == "") {
					/*
						#수정사항 20200923
						아래에 주석으로 막아놓은 부분 확인해보면,
						무엇 때문인지 알듯
					*/
					
					// 20200922 기존꺼 -> 메인화면의 item_nm 과 비교해 보면 됨.
					//($'#m_item_nm').w2field('combo', { items: comboValue_nm });
					//$('#m_item_code').w2field('combo', { items: comboValue_cd });
					
					// 20200922 수정한거 -> 메인화면과 동일하게 맞췄음. 
					
					console.log('#########CHECK ');
					$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
					$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
				}
			} else {
				
			}

		}, complete : function() {
			startValue_combo2 = ":)";
		}
	});
}

function selectCustomer(){
	var page_url = "/info/customer/selectCustomer";
	startValue_combo3 = "";
	$.ajax({
		url : page_url,
		type : 'POST',
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				materialArr = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
					if (startValue_combo3 == "") {
						comboValue_ctm_cd.push(row.customer_code);
						comboValue_ctm_nm.push(row.customer_nm);
					}
				});
				console.log('#########CHECK 1  ');
				if (startValue_combo3 == "") {
			
					
					console.log('#########CHECK ');
					$('#m_customer_nm').w2field('combo', { items: _.uniq(comboValue_ctm_nm,false) ,match : 'contains' });
	
				}
			} else {
				
			}

		}, complete : function() {
			startValue_combo3 = ":)";
		}
	});
}

function getItemInfo(type, value)
{
	var result = "";
	if(type == 'cd')
	{
		$.each(materialArr, function(idx, row){
			
			if(value == row.item_code)
			{
				result = row.item_nm;
		
				$("#m_item_nm").val(result);
			}
		});
		if(result == ''){
			$("#m_item_nm").val('');
		}
		
	
		
	}else if(type == 'nm')
	{
		
		$.each(materialArr, function(idx, row){
			
			if(value == row.item_nm)
			{
				result = row.item_code;
				$("#m_item_code").val(result);
			}
		});
		if(result == ''){
			$("#m_item_code").val('');
		}
	}

	
	
}

// $("#item_nm").change(_.debounce(function(event) {
// 	console.log('CCCCCCCCCCCCCCCC : ');
// 	var item_nm = $("#item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('item_nm key_up : '+ value);
		
// 		getItemInfo('nm',value);
// 		return value
// 	});
	
// 	},400));

// 	$("#item_code").change(
			
// 			_.debounce(function(event) 
// 			{
		
// 				var item_code = $("#item_code").val();
// 				$(this).val(function(index, value) {
// 					console.log('item_code key_up : '+ value);
					
// 					getItemInfo('cd',value);
// 					return value
// 				});
		
// 	},400));
	
// 	var materialArr = new Array;
	
// 	function getItemInfo(type, value)
// 	{
		
// 		console.log('getItemInfo() : ' + value);
// 		var result = "";
// 		if(type == 'cd')
// 		{
// 			$.each(materialArr, function(idx, row){
				
// 				if(value == row.item_code)
// 				{
// 					console.log('row.item_nm : ' + row.item_nm);
// 					result = row.item_nm;		
// 					$("#item_nm").val(result);
// 				}
// 			});

// 			if(result == ''){
// 				$("#item_nm").val('');
// 			}
			
// 		}else if(type == 'nm')
// 		{
			
// 			$.each(materialArr, function(idx, row){
				
// 				if(value == row.item_nm)
// 				{
// 					console.log('row.item_code : ' + row.item_code);
// 					result = row.item_code;
// 					$("#item_code").val(result);
// 				}
// 			});
// 			if(result == ''){
// 				$("#item_code").val('');
// 			}
			
// 		}

		
		
// 	}


// select main list
function loadList() {
	var page_url = "/frontend/drwfile/selectDrwFile";
	var postData = {
		customer_nm : $('#customer_nm').val() || "",
		item_nm : $('#item_nm').val() || "",
		item_code : $('#item_code').val() || "",
		drw_nm : $('#drw_nm').val() || "",
		drw_no : $('#drw_no').val() || "",
		file_final_yn : 'Y',
		file_del_yn : 'N'
	}
	
	//w2ui.grid_list.lock('loading...', true);
	console.log(postData);
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
					
					if(row.cad_file_name != null && row.cad_file_name != '' && row.cad_file_name != 'null'){
						row.down_cad_file_name = '<a href="/file/attach_download?file_path=' + encodeURIComponent(row.cad_file_path) +'&file_name=' + encodeURIComponent(row.cad_file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.cad_file_name+ '</i>';
					}
					else
					{
						row.down_cad_file_name = '';
					}
					if(row.pdf_file_name != null && row.pdf_file_name != '' && row.pdf_file_name != 'null'){
						row.down_pdf_file_name = '<a href="/file/attach_download?file_path=' + encodeURIComponent(row.pdf_file_path) +'&file_name=' + encodeURIComponent(row.pdf_file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.pdf_file_name+ '</i>';
					}else{
						row.down_pdf_file_name = '';
						
					}
					if (startValue_combo == "") {
						materialArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.drw_nm);
						comboValue_nm4.push(row.drw_no);
						comboValue_nm5.push(row.file_rev_no);
					}
				})
				w2ui.grid_list.records = rowArr;
				
				

				
			} else {
				w2ui.grid_list.clear();
			}
			
			w2ui.grid_list.refresh();
			w2ui.grid_list.unlock();
			
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#drw_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#drw_no').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			$('#file_rev_no').w2field('combo', { items: _.uniq(comboValue_nm5,false) ,match : 'contains' });
			
			
			
		}, complete: function(){
			w2ui.grid_list.selectNone();
			startValue_combo = ":)";
	
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("drw_nm").style.removeProperty("height");
			document.getElementById("drw_no").style.removeProperty("height");
			document.getElementById("file_rev_no").style.removeProperty("height");
		}
	})
}

// insert /update file_info
function openMod(mode){
	

	curFile = null;
	isRev = false;
	
	console.log('openMod : ' + mode);
	$('.upd_info').attr('disabled', true);
	$('#revision_btn').attr('disabled', true);
	$('#upload_mode').val(mode);
	$('.clear_field').val('');

	$('#mod_file_rev_no').val('');
	$('#mod_file_comment').val('');
	$('#m_item_code').val('');
	$('#m_item_nm').val('');
	$('#m_drw_no').val('');
	$('#m_drw_nm').val('');
	
 	$('#m_item_code').attr('disabled', false);
	$('#m_item_nm').attr('disabled', false); 
	$('#m_drw_no').attr('disabled', false);
	$('#m_drw_nm').attr('disabled', false);
	$('#m_business_nm').attr('disabled', true);
	
	
	
	if('upd' == mode){
		isRev = true;
		$('#revision_btn').attr('disabled', false);
//		$('.org_info').attr('disabled', true);
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		if(recids.length != 1){
			fnMessageModalAlert("알림", "수정 하실 파일 정보를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
			return false;
		}
		if( recids.length==1){
			
			$("#m_item_nm").val(pdata.item_nm);
			$("#m_item_code").val(pdata.item_code);
			$("#m_drw_no").val(pdata.drw_no);
			$("#m_drw_nm").val(pdata.drw_nm);
			$('#mod_file_rev_no').val(pdata.file_rev_no);
			$('#mod_file_comment').val(pdata.file_comment);
			
			//mod_new_revno, mod_new_file_comment
	
			$('#m_item_code').attr('disabled', true);
			$('#m_item_nm').attr('disabled', true); 
	
			/* $('#m_drw_no').attr('disabled', true);
			$('#m_drw_nm').attr('disabled', true); */

		 	$('#mod_file_rev_no').attr('disabled', true);
			$('#mod_file_comment').attr('disabled', true); 
			
		 	$('#mod_new_revno').attr('disabled', true);
			$('#mod_new_file_comment').attr('disabled', true); 
			
			$("#modal_pw").modal('hide');
			$('#ins_mod').modal('show');
		}
		var keys = Object.keys(pdata);
		$.each(keys, function(idx, key){
			if(key == 'm_business_code') key = 'business_code';
			$('#mod_' + key).val(pdata[key]);
			if(key == 'business_code'){
				$('#mod_business_code').change();
			}
			if(key == 'file_class_code'){
				$('#mod_file_class_code').change();
			}
		})
		
		$("#btn_check").hide();
		$("#fg_check_yn").val("Y");
		
	} else if('ins' == mode){
		
		w2ui.grid_list.selectNone();
		$('#file_btn').attr('disabled', false);
	
		$("#btn_check").show();
 		$("#fg_check_yn").val("N");
 		
		$('.org_info').attr('disabled', false);
		$('#mod_file_no').val('1');
		$('#mod_file_rev_no').val('Rev.01');
		//$('#mod_file_rev_no').attr('disabled', true);
	}
	
	$('#ins_mod').modal('show');
	
}

function requsetModalPw(){
	var key = w2ui.grid_list.getSelection();
	if( key.length==1 ) {
		//confirmPw();
		$('#m_password').val('');
		$("#m_password_input").attr('disabled', true);
		
		$('#m_password_input').val('비밀번호를 입력해주세요');
		
		$("#modal_pw").modal('show');
	
	}else  if( key.length==0 ) {	
		fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택해주세요"); 	
	}
}

function confirmPw() {
	
	var _password = $('#m_password').val();
	var word = '비밀번호를 확인해주세요.'
	
	if(_password != password){
		$('#m_password_input').val(word);
	}else {
		console.log('마자용');
		$("#modal_pw").modal('hide');
		openMod('upd');
		
	}
	
}

// ins file info
function insFile() {
	
	var business_code = $('#m_business_code').val();
	var business_nm = $('#m_business_nm').val();
	console.log('business_code: ' + business_code);
	console.log('business_nm: ' + business_nm);
	
	var item_code = $('#m_item_code').val();
	var item_nm = $('#m_item_nm').val();
	var drw_no = $('#m_drw_no').val();
	var drw_nm = $('#m_drw_nm').val();
	
	var uploadMode = $('#upload_mode').val();
	
	var fileType = $('#mod_file_type_code option:selected').text();
	var revno = $('#mod_file_rev_no').val();
	var fileComment = $('#mod_file_comment').val();
	var nrevno = $('#mod_new_revno').val();
	var nfileComment = $('#mod_new_file_comment').val();
	var fileGroup = $('#mod_file_group').val() || '';
	var fileNo = $('#mod_file_no').val() || '';
	
	if($("#fg_check_yn").val() == "N") {
		fnMessageModalAlert("알림", "PN 중복체크를 확인하세요.");
		return;
	}
	if(item_code == '' || item_nm == ''){
		fnMessageModalAlert("알림", "품명을 입력해주세요.");	
		return;
	}
	if(drw_no == '' || drw_nm == ''){
		fnMessageModalAlert("알림", "업체명 또는 적용을 입력해주세요.");	
		return;
	}
	if('ins' == uploadMode && ( revno == '' || fileComment == '')){
		fnMessageModalAlert("알림", "Rev/no 또는 개정이력을입력해주세요.");	
		return;
	}
	
	if('upd' == uploadMode && ( nrevno == '' || nfileComment == '')){
		fnMessageModalAlert("알림", "버전 정보를 입력해주세요.");
		return;
	}
	var cad_file_path ='';
	var cad_file_name ='';
	var cad_file_ext ='';
	var cad_file_size ='';
	
	var pdf_file_path ='';
	var pdf_file_name ='';
	var pdf_file_ext ='';
	var pdf_file_size ='';
	

	
	var recids = w2ui.grid_list.getSelection();
	var pdata = w2ui.grid_list.get(recids[0]);
	if( recids.length==1){
		
		
		cad_file_path = pdata.cad_file_path;
		cad_file_name = pdata.cad_file_name;
		cad_file_ext = pdata.cad_file_ext;
		cad_file_size = pdata.cad_file_size;
		
		pdf_file_path = pdata.pdf_file_path;
		pdf_file_name = pdata.pdf_file_name;
		pdf_file_ext = pdata.pdf_file_ext;
		pdf_file_size = pdata.pdf_file_size;
	}
	
	
	if(curFile){
		
		fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
			if(chk){
				curFile.submit();
			}
		});
		
	}else
	{
		fnMessageModalConfirm('알림', '수정사항을 저장하시겠습니까?',function(chk){
			if(chk){
				
				if((fileGroup != '' && fileNo != '') && isRev){
					var pageUrl = '/frontend/drwfile/updFileInfo';
					var postData = {
						file_group : fileGroup,
						file_no : fileNo,
						business_code : business_code,
						business_nm : business_nm,
						
						
						item_code : item_code,
						item_nm : item_nm,
						drw_no : drw_no,
						drw_nm : drw_nm,
						
						file_rev_no : revno,
						file_comment : fileComment,
						file_new_rev_no : nrevno,
						file_new_comment : nfileComment,
		
						
				 		cad_file_path : cad_file_path,
				 		cad_file_name : cad_file_name,
				 		cad_file_ext : cad_file_ext,
				 		cad_file_size : cad_file_size,
				 		
				 		pdf_file_path : pdf_file_path,
						pdf_file_name : pdf_file_name, 
				 		pdf_file_ext : pdf_file_ext,
				 		pdf_file_size : pdf_file_size,
						
						mode : uploadMode,
											
						typeString: typeString
						
					}
					FunLoadingBarStart();
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
							FunLoadingBarEnd();
							loadList();
						}
					});
				}
			}
		});
	}
	
	/* fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
		if(chk){
			
			if(curFile){
				curFile.submit();
			} else {

				if(isRev){
					
				} else {
					fnMessageModalAlert("알림", "등록된 파일 정보가 없습니다.");	// Notification(MES)
				}
			}
			
			
		}
	}) */
	
}




function delFile(){
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 이상 선택하여야 합니다."); // Notification
		return;
	} else{
	
		fnMessageModalConfirm('알림', '삭제하시겠습니까?',function(chk){
			if(chk){
				var recids = w2ui.grid_list.getSelection();
				var rData;
				var fileData = [];
				
				$.each(recids, function(idx, recid){
					rData = w2ui.grid_list.get(recid);
					fileData.push(rData);
				})
				var p = "param=" + encodeURIComponent(JSON.stringify(fileData));
				var pageUrl = "/frontend/drwfile/delFileInfo";
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
				});
		}});
	}

}

//set select box



var business_code = '';
var business_nm = '';

//business
function fnBusiness(val){
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent("MC1012")
	+ "&detail_code" + encodeURIComponent("MD1243");
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		

	    		business_code = rowArr[0].detail_code;
	    		business_nm = rowArr[0].code_nm;
	    		
	    		console.log('rowArr[0].detail_code : ' + rowArr[0].detail_code);
	    		
				$("#m_business_code").val(business_code);	
	 			$("#m_business_nm").val(business_nm);			
				
	    	} else if(data.status == "200" && (data.rows).length==0 ) {
	  
	    		
	    	} 
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    
	    }
	});
	
}

var password = '';
//business
function requestPassword(){
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent("MC1024")
	+ "&detail_code" + encodeURIComponent("MD1562");
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		password = rowArr[0].code_nm;
		console.log('password : ' + password);
				
	    	} else if(data.status == "200" && (data.rows).length==0 ) {
	  
	    		
	    	} 
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    
	    },
	    complete: function() {
	    
	    }
	});
	
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

var typeString = '';
function setUploadFileParma(pInfo, pName, pType){
	console.log(pName); 
	if(curFile == null){

		curFile = pInfo;
		typeString = pType;
		console.log('typeString : ' + typeString);
	}else
	{
		
		if(typeString.length == 3){
            if(typeString == pType)
            {
               curFile = pInfo;
               typeString = pType;         
            } else {
               if(pType == 'cad')
               {
                  curFile.files[1] = curFile.files[0];
                  curFile.files[0] = pInfo.originalFiles[0];
               } else if(pType == 'pdf')
               {
                  curFile.files[1] = pInfo.originalFiles[0];
               }   
               typeString = "cad#pdf";
            }
        } else if(typeString.length == 7){
            if(pType == 'cad')
            {
               curFile.files[0] = pInfo.originalFiles[0];
            } else if(pType == 'pdf')
            {
               curFile.files[1] = pInfo.originalFiles[0]; 
            }   
            typeString = "cad#pdf";
        }
		
		
		/* if ( curFile.files[0].name != pName) {
			
			if(pType == 'cad')
		      {
		         curFile.files[0] = pInfo.originalFiles[0];
		      }   
		      
		      if(pType == 'pdf')
		      {
		         curFile.files[1] = pInfo.originalFiles[0]; 
		      }   
		      
		      typeString = "cad#pdf";
		} */
		/* if ( curFile.files[0].name != pName) {
			
			curFile.files[1] = pInfo.files[0];
			if(typeString.indexOf('cad') == -1  || typeString.indexOf('pdf') == -1){
				
				typeString = typeString + '#' + pType ;
				
			}
			
			
			console.log('typeString : ' + typeString);
		} */
		else
		{
			curFile = null;
		
			curFile = pInfo;	
			typeString = pType;
		}
	}
	
	
	
	
	///////////////////////////
	
	
	
	
	

}

var file_upload_yn = 'N';
function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/frontend/drwfile/file_upload",
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
			
			console.log('######### fileupload');
			
			file_upload_yn = 'Y';
			
			console.log('######### file_upload_yn????' + file_upload_yn);

			var file_name = data.files[0].name;
			$('#mod_'+currentType+'_file_name').val(file_name);
			setUploadFileParma(data, data.files[0].name,currentType);
		},
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		console.log('always : ' + index);
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
    	
    /* 	$('#t_' + e.target.id).val(data.files[0].name);
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
		console.log('fileuploadsubmit pdf')
		commonSubmit($(this),data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

function commonSubmit(su,data)
{
	var $this = su;
	var business_code = $('#m_business_code').val();
	var business_nm = $('#m_business_nm').val();
	
	var item_code = '';
	var item_nm = '';
	
	var drw_no = '';
	var drw_nm = '';
		
	var item_code = $('#m_item_code').val();
	var item_nm = $('#m_item_nm').val();
	var drw_no = $('#m_drw_no').val();
	var drw_nm = $('#m_drw_nm').val();
	
	var revno = $('#mod_file_rev_no').val();
	var fileComment = $('#mod_file_comment').val();
	
	var nrevno = $('#mod_new_revno').val();
	var nfileComment = $('#mod_new_file_comment').val();
	var uploadMode = $('#upload_mode').val();
	var fileGroup = $('#mod_file_group').val();
	var fileNo = $('#mod_file_no').val();	
	
	
	var cad_file_path ='';
	var cad_file_name = $('#mod_cad_file_name').val();
	var cad_file_ext ='';
	var cad_file_size ='';
	
	var pdf_file_path ='';
	var pdf_file_name = $('#mod_pdf_file_name').val();
	var pdf_file_ext ='';
	var pdf_file_size ='';
	
	var recids = w2ui.grid_list.getSelection();
	var pdata = w2ui.grid_list.get(recids[0]);
	
	if( recids.length==1){
		
		
		cad_file_path = pdata.cad_file_path;
		cad_file_name = pdata.cad_file_name;
		cad_file_ext = pdata.cad_file_ext;
		cad_file_size = pdata.cad_file_size;
		
		pdf_file_path = pdata.pdf_file_path;
		pdf_file_name = pdata.pdf_file_name;
		pdf_file_ext = pdata.pdf_file_ext;
		pdf_file_size = pdata.pdf_file_size;
	}
	data.formData = {
		business_code : business_code,
		business_nm : business_nm,
		
		
		item_code : item_code,
		item_nm : item_nm,
		drw_no : drw_no,
		drw_nm : drw_nm,
		
		
		file_rev_no : revno,
		file_comment : fileComment,
		file_new_rev_no : nrevno,
		file_new_comment : nfileComment,
		
		mode : uploadMode,
		file_group : fileGroup,
		file_no : fileNo,
		
		cad_file_path : cad_file_path,
 		cad_file_name : cad_file_name,
 		cad_file_ext : cad_file_ext,
 		cad_file_size : cad_file_size,
 		
 		pdf_file_path : pdf_file_path,
		pdf_file_name : pdf_file_name, 
 		pdf_file_ext : pdf_file_ext,
 		pdf_file_size : pdf_file_size,
		
		
		typeString : typeString
		
	}
	console.log("data는?");
	console.log(data);
	$this.fileupload('send', data);	
	
}

var currentType = '';
function type(type)
{
	currentType = type;
	console.log('type : ' + type);
}


</script>

</body>
</html>