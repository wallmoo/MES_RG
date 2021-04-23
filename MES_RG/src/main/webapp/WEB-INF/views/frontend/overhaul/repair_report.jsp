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
		<jsp:param name="selected_menu_p_cd" value="1017" />
		<jsp:param name="selected_menu_cd" value="1070" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			검사보고서 관리 <small> Overhaul</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Overhaul </a></li>
			<li class="active">검사보고서 관리</li>
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
												<button type="hidden" id="btn_cancel" onclick="cancelCompleteReport();" class="btn btn-danger btn-sm" onclick="">수리완료보고서 취소</button>
												<button type="hidden"  id="btn_out" onclick="requestOut_modal();" class="btn btn-info  btn-sm">출고처리</button>	
												<button type="button"  onclick="insReport();" class="btn btn-primary  btn-sm">보고서등록/수정</button>
												<button type="button"  onclick="loadList();" class="btn btn-warning  btn-sm">조회</button>	 
								 
											</div>
										</div>
										<div class="box-body">
											<div class="row">
												<div class="form-group">
													<div class="col-sm-1">
														<label>접수번호</label> <input type="repair_num" id="repair_num" class="form-control input-sm" placeholder="접수번호"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
			                                          <label>입고일자</label> 
			                                           <input type="checkbox" id="chk_eindt2" checked name="chk_eindt2" value="1" style="margin: 0px;" onchange="chgEindt(); " ><!-- checked -->
			                                          <div class="input-group">
			                                             <input type="text" 
			                                                class="form-control pull-right input-sm" style="" id="repair_date" placeholder="yyyymmdd~yyyymmdd">
			                                             <div class="input-group-addon">
			                                                <i class="fa fa-calendar"></i>
			                                             </div>
			                                          </div>
			                                       </div>
												   <div class="col-sm-2">
			                                          <label>출고일자</label> 
			                                           <input type="checkbox" id="chk_eindt" name="chk_eindt" value="1" style="margin: 0px;" onchange="chgEindt();" ><!-- checked -->
			                                          <div class="input-group">
			                                             <input type="text" 
			                                                class="form-control pull-right input-sm" style="" id="out_date"  placeholder="yyyymmdd~yyyymmdd">
			                                             <div class="input-group-addon">
			                                                <i class="fa fa-calendar"></i>
			                                             </div>
			                                          </div>
			                                       </div>
			                                       
			                                       <div class="col-sm-1">
								                        <div class="form-group">
								                           <label>상태</label>
								                           <div class="form-group">
								                              <select id="status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onchange="loadList();">
								                                 <option value="before">출고전</option>
								                                 <option value="after">출고</option>
								                              </select>
								                           </div>
								                        </div>
								                     </div> 
	                     
													<div class="col-sm-1">
														<label>반입처 고객사명</label> <input type="text" id="in_customer_nm"  class="form-control input-sm" placeholder="고객사명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-1">
														<label>반출처 고객사명</label> <input type="text" id="out_customer_nm"  class="form-control input-sm" placeholder="고객사명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-1">
														<label>P/N</label> <input type="text" id="item_code" class="form-control input-sm" placeholder="P/N"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-1">
														<label>품명</label> <input type="text" id="item_nm"  class="form-control input-sm" placeholder="품명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-1">
														<label>S/N</label> <input type="text" id="sernr"  class="form-control input-sm" placeholder="S/N" 
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
<div class="modal fade" id="ins_mod" data-backdrop="static">
	<div class="modal-dialog modal-lg" style="width: 1250px;">
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
					<input type="hidden" class="clear_field" id="mod_repair_num"/>
					<div class="form-group row" style="margin-bottom: 100px; margin-top: 45px;">
						<div class="col-sm-4">
							<div class="row" >
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE; margin-bottom: 10px; margin-left: 30px;">1. 입고</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status1"  disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
								
									
									<input type="text" class="form-control clear_field dp_component_d"
												id="mod_proc1_date">
				
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="form-control clear_field" id="mod_proc1_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc1_file_name" name="mod_proc1_file_name" class="form-control input-sm clear_field file_upload_read" readonly>
									<input type="hidden" id="mod_proc1_file_group" name="mod_proc1_file_group" class="form-control input-sm clear_field">
								</div>
								<div class="col-sm-1" style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-success btn-sm fileinput-button " style="" id="file_btn1"> <i class="fa fa-plus"></i>
										<input id="file_group1" type="file" class="fileupload clear_field" data-cd = 'MD1271' data-num = 'proc1' name="file1">
									</span>
								</div>
								<div class="col-sm-1" style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-danger btn-sm filedelete-button " style="" id="file_dbtn1" data-cd = 'MD1271' data-num = 'proc1'> <i class="fa fa-minus"></i>
									</span>
								</div>
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">2. 세정</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status2" disabled="disabled"  />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
							
										<input type="text" class="form-control clear_field dp_component_d"
												id="mod_proc2_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="form-control clear_field" id="mod_proc2_manager_nm" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc2_file_name" name="mod_proc2_file_name" class="form-control input-sm clear_field file_upload_read" readonly>
									<input type="hidden" id="mod_proc2_file_group" name="mod_proc2_file_group" class="form-control input-sm clear_field">
								</div>
								<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-success btn-sm fileinput-button " style="" id="file_btn2"> <i class="fa fa-plus"></i>
										<input id="file_group2" type="file" class="fileupload clear_field" data-cd = 'MD1272' data-num = 'proc2' name="file2">
									</span>
								</div>
								<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-danger btn-sm filedelete-button " style=" " id="file_dbtn2" data-cd = 'MD1272' data-num = 'proc2'> <i class="fa fa-minus"></i>
									</span>
								</div>
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label "  style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">3. 반조립</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status3"  disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
					
										<input type="text" class="form-control clear_field dp_component_d"
												id="mod_proc3_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="form-control clear_field" id="mod_proc3_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc3_file_name" name="mod_proc3_file_name" class="form-control input-sm clear_field file_upload_read" readonly>
									<input type="hidden" id="mod_proc3_file_group" name="mod_proc3_file_group" class="form-control input-sm clear_field">
								</div>
								<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-success btn-sm fileinput-button " style=" " id="file_btn3"> <i class="fa fa-plus"></i>
										<input id="file_group3" type="file" class="fileupload clear_field" data-cd = 'MD1273' data-num = 'proc3' name="file3">
									</span>
								</div>
								<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-danger btn-sm filedelete-button " style=" " id="file_dbtn3" data-cd = 'MD1273' data-num = 'proc3'> <i class="fa fa-minus"></i>
									</span>
								</div>
							</div>
							
						</div>
					</div>
					
					
					<div class="form-group row">
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">4. 중간검사</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status4" disabled="disabled" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
						
												<input type="text" class="form-control clear_field dp_component_d"
												id="mod_proc4_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="form-control clear_field" id="mod_proc4_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc4_file_name" name="mod_proc4_file_name" class="form-control input-sm clear_field file_upload_read" readonly>
									<input type="hidden" id="mod_proc4_file_group" name="mod_proc4_file_group" class="form-control input-sm clear_field">
								</div>
								<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-success btn-sm fileinput-button " style=" " id="file_btn4"> <i class="fa fa-plus"></i>
										<input id="file_group4" type="file" class="fileupload clear_field" data-cd = 'MD1274' data-num = 'proc4' name="file4">
									</span>
								</div>
								<div class="col-sm-1" style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-danger btn-sm filedelete-button " style=" " id="file_dbtn4" data-cd = 'MD1274' data-num = 'proc4'> <i class="fa fa-minus"></i>
									</span>
								</div>
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">5. 최종</label>
							</div> 
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status5" disabled="disabled" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
							
										<input type="text" class="form-control clear_field dp_component_d"
												id="mod_proc5_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="form-control clear_field" id="mod_proc5_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc5_file_name" name="mod_proc5_file_name" class="form-control input-sm clear_field file_upload_read" readonly>
									<input type="hidden" id="mod_proc5_file_group" name="mod_proc5_file_group" class="form-control input-sm clear_field">
								</div>
								<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-success btn-sm fileinput-button " style=" " id="file_btn5"> <i class="fa fa-plus"></i>
										<input id="file_group5" type="file" class="fileupload clear_field" data-cd = 'MD1275' data-num = 'proc5' name="file5">
									</span>
								</div>
								<div class="col-sm-1" style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-danger btn-sm filedelete-button " style=" " id="file_dbtn5" data-cd = 'MD1275' data-num = 'proc5'> <i class="fa fa-minus"></i>
									</span>
								</div>
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">6. 수리완료보고서</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status6" disabled="disabled" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
						
										<input type="text" class="form-control clear_field dp_component_d"
												id="mod_proc6_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="form-control clear_field" id="mod_proc6_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc6_file_name" name="mod_proc6_file_name" class="form-control input-sm clear_field file_upload_read" readonly>
									<input type="hidden" id="mod_proc6_file_group" name="mod_proc6_file_group" class="form-control input-sm clear_field">
								</div>
								<div class="col-sm-1"  style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-success btn-sm fileinput-button " style=" " id="file_btn6"> <i class="fa fa-plus"></i>
										<input id="file_group6" type="file" class="fileupload clear_field" data-cd = 'MD1276' data-num = 'proc6' name="file6">
									</span>
								</div>
								<div class="col-sm-1" style="padding-left: 0px; padding-right: 0px;">
									<span class="btn btn-danger btn-sm filedelete-button " style=" " id="file_dbtn6" data-cd = 'MD1276' data-num = 'proc6'> <i class="fa fa-minus"></i>
									</span>
								</div>
							</div>
							
						</div>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button"  class="btn btn-default btn-sm" id="close_mod" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 출고일자날짜 모달 -->
<div class="modal fade" id="modal_date" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title" >출고일자</h4>
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
						<label for="" class="col-sm-3 control-label ">출고일자</label>
						<div class="input-group col-md-7">
							<input type="text" 
								class="form-control pull-right input-sm" style="" id="m_out_date" placeholder="yyyymmdd">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
						</div>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
				    <button type="button" id="savePw" class="btn btn-success btn-sm" onclick="requestOut();">확인</button>
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
comboValue_nm6 = new Array;

var InFindList = [];
var OutFindList = [];

var gProcNm = {
		'MD1271' : '입고검사',
		'MD1272' : '세정',
		'MD1273' : '반조립',
		'MD1274' : '중간검사',
		'MD1275' : '최종검사',
		'MD1276' : '수리완료보고서'
}

$(function($) {
	
	$("#btn_cancel").hide();
	$("#btn_out").hide();
	loadCommFn();
 	loadGrid();
 	loadList();
 	
 	fnLoadFileHandler();
})


// //품명,품번 자동완성
// $("#item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('item_nm key_up : '+ value);
		
// 		getItemInfo('nm',value);
// 		return value
// 	});
	
// },400));
// $("#item_code").change(
		
// 		_.debounce(function(event) 
// 		{
	
// 			var item_code = $("#item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('item_code key_up : '+ value);
				
// 				getItemInfo('cd',value);
// 				return value
// 			});
	
// },400));

function getTimeStamp() {
  var d = new Date();
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


function getFormatDate(d) {
			var month = d.getMonth() + 1;
			var date = d.getDate();
			month = (month < 10) ? "0" + month : month;
			date = (date < 10) ? "0" + date : date;
			return d.getFullYear() + '-' + month + '-' + date;
}
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
		
	/* 	$('.dp_component_d').daterangepicker({
			language: 'kr',
			autoclose:true,
		      timePicker: true,
		      timePicker24Hour:true,
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			format:'yyyy-mm-dd'
		}).on('show', function(e) {
			$('.datepicker').css('z-index', '9999');
		}); */
		//$('.dp_component_d').datepicker('setDate', moment().format('YYYY-MM-DD'));
		

		
		
		var minDate = getFormatDate(new Date());
		
		var currentDate = getTimeStamp();
		
		console.log('currentDate : ' + currentDate);
		$('.dp_component_d').daterangepicker(
				{
					opens : 'right',
					singleDatePicker : true,
				     timePicker: true,
				      timePicker24Hour:true,
					locale : {
						format : 'YYYY-MM-DD HH:mm:ss', //'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
						showMonthAfterYear : true,
						yearSuffix : '년',
						orientation : "top left"
					},
						startDate : moment(currentDate).format('YYYY-MM-DD HH:mm:ss')
					
				});
		//$('.dp_component_d').daterangepicker('setDate', moment().format('YYYY-MM-DD'));
		
		$('#out_date, #repair_date').daterangepicker({
			language: 'kr',
			opens: 'right',
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		    startDate : moment().subtract(30, 'days').format('YYYY-MM-DD'),
	 	    endDate:  moment().format('YYYY-MM-DD')
		});
		
		var currentDate = getTimeStamp();
		
		$('#m_out_date').daterangepicker(
				{
					opens : 'right',
					singleDatePicker : true,
				     timePicker: true,
				      timePicker24Hour:true,
					locale : {
						format : 'YYYY-MM-DD HH:mm:ss', //'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
						showMonthAfterYear : true,
						yearSuffix : '년',
						orientation : "top left"
					},
						startDate : moment(currentDate).format('YYYY-MM-DD HH:mm:ss')
					
				});
		
		
}

function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}
	
function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
}

$('.filedelete-button').on('click', function(){
	var repairNum = $('#mod_repair_num').val() || '';
	var reportCode = $(this).attr('data-cd');
	var procNum = $(this).attr('data-num');
	var fileGroup = $('#mod_'+procNum+'_file_group').val() || '';
	
	console.log('data :: ' + repairNum + '/'+reportCode + '/'+ procNum+'/'+fileGroup);	
	if(!repairNum) {
		fnMessageModalAlert("알림", "수리 접수 번호가 없습니다.\n새로 고침 후 다시 시도 해 주세요.");	// Notification(MES)
		return false;
	}
	if(!fileGroup) {
		fnMessageModalAlert("알림", "등록 된 파일이 없습니다.");	// Notification(MES)
		return false;
	}
	
	var pageUrl = '/file/delete_repair_file/' + reportCode
	var postData = {
			repair_num  : repairNum,
			file_group : fileGroup
	}
	
	$.ajax({
		url : pageUrl,
		type: 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.status == 200){

				var num = procNum.slice(-1);
				$('#mod_status'+num+'').val('등록전');
				$('#mod_'+procNum+'_manager_nm').val('');
				$('#mod_'+procNum+'_file_name').val('');
				$('#mod_'+procNum+'_file_group').val('');
				$('#file_group'+ procNum.substring(4)).val('');
			}
		}
	})
})

$('#close_mod').on('click',function(){
	//location.reload();
	
	loadList();
})

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
        multiSelect: false,
        columnGroups : [
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 1, master: true },
            { span: 28, caption: '중간검사' },
         
        ],
        columns: [                
			{ field:'repair_num', caption:'접수번호', style:'text-align:center', sortable: true},
			{ field:'repair_date', caption:'입고일자', style:'text-align:center', sortable: true},
			{ field:'customer_integration_nm', style:'text-align:center', caption:'고객사명' , sortable: true},
			
			{ field:'carry_in_customer_code', caption:'반입처 코드', hidden : true},
			{ field:'in_customer_nm', caption:'반입 고객사명', style:'text-align:center', hidden : true},
			{ field:'carry_in_land', caption:'반입처', style:'text-align:center', sortable: true},
			{ field:'carry_out_customer_code', caption:'반출처 코드', hidden : true},
			{ field:'out_customer_nm', caption:'반출 고객사명', style:'text-align:center', hidden : true},
			{ field:'carry_out_land', caption:'반출처', style:'text-align:center', sortable: true},
			
			{ field:'repair_class_nm', caption:'수리 구분', style:'text-align:center', sortable: true},
			{ field:'repair_class_code', caption:'수리 구분', style:'text-align:center', sortable: true, hidden:true},
			{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true},
			{ field:'sernr', caption:'S/N', style:'text-align:center', sortable: true},
			{ field:'out_date', caption:'출고일자', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == '0')
	            	{
	            	   return '';
	            	}else
	            	{
	            		return html;
	            	}
	            
	           }
	        },
			//중간검사 6개
			{ field:'proc1_file_down', caption:'입고검사', style:'text-align:center', sortable: true},
			{ field:'proc1_file_name', hidden: true, style:'text-align:center'},
			{ field:'proc1_file_group', hidden : true, style:'text-align:center'},
			{ field:'status1', caption:'등록1', hidden : true},
			{ field:'proc1_manager_nm', caption:'담당자1', hidden : true},
			
			{ field:'proc2_file_down', caption:'세정', style:'text-align:center', sortable: true},
			{ field:'proc2_file_name', hidden : true, style:'text-align:center'},
			{ field:'proc2_file_group', hidden : true, style:'text-align:center'},
			{ field:'status2', caption:'등록2',  hidden : true},
			{ field:'proc2_manager_nm', caption:'담당자2', hidden : true},
			
			{ field:'proc3_file_down', caption:'반조립', style:'text-align:center', sortable: true},
			{ field:'proc3_file_name', hidden: true, style:'text-align:center'},
			{ field:'proc3_file_group', hidden: true, style:'text-align:center'},
			{ field:'status3', caption:'등록3',  hidden : true},
			{ field:'proc3_manager_nm', caption:'담당자3', hidden : true},
			
			{ field:'proc4_file_down', caption:'중간검사', style:'text-align:center', sortable: true},
			{ field:'proc4_file_name', hidden : true, style:'text-align:center'},
			{ field:'proc4_file_group', hidden : true, style:'text-align:center'},
			{ field:'status4', caption:'등록4',  hidden : true},
			{ field:'proc4_manager_nm', caption:'담당자4', hidden : true},
			
			{ field:'proc5_file_down', caption:'최종검사', style:'text-align:center', sortable: true},
			{ field:'proc5_file_name', hidden : true, style:'text-align:center'},
			{ field:'proc5_file_group', hidden : true, style:'text-align:center'},
			{ field:'status5', caption:'등록5',  hidden : true},
			{ field:'proc5_manager_nm', caption:'담당자5', hidden : true},
			
			{ field:'proc6_file_down', caption:'수리완료보고서', style:'text-align:center', sortable: true},
			{ field:'proc6_file_name', hidden :  true, style:'text-align:center'},
			{ field:'proc6_file_group', hidden : true, style:'text-align:center'},
			{ field:'status6', caption:'등록6', hidden : true} ,
			{ field:'proc6_manager_nm', caption:'담당자6', hidden : true},
			
			{ field:'success_status', caption:'finish', hidden : true}
			], 
		/* sortData: [{field: 'repair_num', direction: 'ASC'}], */		
		 records: [
			], // rowArr
		onSelect: function (event) {
			 event.onComplete = function () {
				console.log("onSelect");
				
				
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				if(data.proc6_file_name != '')
				{
					$("#btn_cancel").show();
					$("#btn_out").show();
				}else
				{
					$("#btn_cancel").hide();
					$("#btn_out").hide();
				}
				
			}

		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
}

function requestOut_modal()
{
	
	var keys = w2ui.grid_list.getSelection();
	var pData = w2ui.grid_list.get(keys[0]);
	
	if( keys.length==0 ) {
		fnMessageModalAlert("알림", "출고처리할 정보를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
		return false;
	}else  if( keys.length==1 ) {	
		if(pData.out_date != '' && pData.out_date != 'null' && pData.out_date != null && pData.out_date != '0' && pData.out_date != 0)
		{
			
			fnMessageModalAlert("알림", "이미 출고되었습니다.");	// Notification(MES)
			return false;
		}else{
			$("#modal_date").modal('show');
		}
		
	}

}

function requestModal() {
	
}

function requestOut()
{
	var keys = w2ui.grid_list.getSelection();
	
	var pData = w2ui.grid_list.get(keys[0]);
	
	var out_date_time = $("#m_out_date").val();
	var out_date_split = out_date_time.split(" ");
	
	//날짜만 뽑기
	var out_date = out_date_split[0];
	out_date = out_date.replace(/-/gi, ""); 
	
	console.log("out_date? " + out_date);
	
	var repair_num = pData.repair_num;
	
	
	 if(pData.success_status == 'Y')
	 { 	
		var strUrl = "/frontend/repair/updateOutDate";
		
		var postData ={ 
				out_date : out_date,
				out_date_time : out_date_time,
				repair_num : repair_num
				}
		FunLoadingBarStart();
		 $.ajax({
			 url: strUrl,
			 type: "POST",
			 dataType : 'json', 
			 data : postData, 
			 async : false,
			 success:function(data, textStatus, jqXHR){
			 	if(data.status == "200") {
			 		console.log(data);
			 		loadList();
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
			 	}
			 },
			 error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
			 },
			 complete: function() {
				 $("#modal_date").modal('hide');
				 FunLoadingBarEnd();
			 }
		});  
	
	 }else {
		fnMessageModalAlert("알림", "출고처리를 할 수 없습니다.");	// Notification(MES)
		return false;
	} 
	
	//
}
function chgEindt()
{
   console.log('chgEindt()');
   
   loadList();
}

var gridDataArr;

function loadList(){
   w2ui.grid_list.clear();
   var pageUrl = '/frontend/repair/selectrepairReqR';
   
   var spdate = $('#out_date').val().split(' - ');
   var out_date_start = spdate[0];
   var out_date_end = spdate[1];
   
   var spdate2 = $('#repair_date').val().split(' - ');
   var in_date_start = spdate2[0];
   var in_date_end = spdate2[1];
   
   var chk_eindt = $("input:checkbox[id='chk_eindt']").is(":checked")
   if(chk_eindt == 'false' || chk_eindt == false)
   {
      out_date_start = '';
      out_date_end = '';
   }
   
   var chk_eindt2 = $("input:checkbox[id='chk_eindt2']").is(":checked")
   if(chk_eindt2 == 'false' || chk_eindt2 == false)
   {
	   in_date_start = '';
	   in_date_end = '';
   }
   
   var status = $("#status").val();
   
   
   //var costomerNm = $('#customer_integration_nm').val();
   var inCustomerCode = $('#in_customer_nm').val();
   if($('#in_customer_nm').val() != "" && $('#in_customer_nm').val() != null){
      inCustomerCode = InFindList[inCustomerCode];
      if(inCustomerCode == 'undefined'){
         inCustomerCode = ''
      }
   }
   var outCustomerCode = $('#out_customer_nm').val();
   if($('#out_customer_nm').val() != "" && $('#out_customer_nm').val() != null){
      outCustomerCode = OutFindList[outCustomerCode];
      if(outCustomerCode == 'undefined'){
         outCustomerCode = ''
      }
   }
   var itemCode = $('#item_code').val();
   var itemNm = $('#item_nm').val();
   var sernr = $('#sernr').val();
   var repair_num = $('#repair_num').val();
   
   var postData = {
         out_date_start : out_date_start || '',
         out_date_end : out_date_end || '',
         in_date_start : in_date_start || '',
         in_date_end : in_date_end || '',
         //customer_integration_nm : costomerNm || '',
         carry_in_customer_code : inCustomerCode || '',
         carry_out_customer_code : outCustomerCode || '',
         item_code : itemCode || '',
         item_nm : itemNm || '',
         sernr : sernr || ''
         ,
         repair_num : repair_num || ''
         ,
         status : status || ''
   }
	
	w2ui['grid_list'].lock('loading...',true);
	$.ajax({
		url : pageUrl,
		type : "POST",
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){

				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
					'<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
					
					if(!row.proc1_file_group) row.status1 = '등록전';
					else {
						row.status1 = "등록후";
						row.proc1_file_down = '<a href="/file/attach_download?file_path=' + row.proc1_file_path +'&file_name=' + encodeURIComponent(row.proc1_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc1_file_name+ '</i>'
					}
					
					if(!row.proc2_file_group) row.status2 = '등록전';
					else {
						row.proc2_file_down = '<a href="/file/attach_download?file_path=' + row.proc2_file_path +'&file_name=' + encodeURIComponent(row.proc2_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc2_file_name+ '</i>'
						row.status2 = "등록후";
					}
					
					if(!row.proc3_file_group) row.status3 = '등록전';
					else {
						row.proc3_file_down = '<a href="/file/attach_download?file_path=' + row.proc3_file_path +'&file_name=' + encodeURIComponent(row.proc3_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc3_file_name+ '</i>'
						row.status3 = "등록후";
					}
					
					if(!row.proc4_file_group) row.status4 = '등록전';
					else {
						row.proc4_file_down = '<a href="/file/attach_download?file_path=' + row.proc4_file_path +'&file_name=' + encodeURIComponent(row.proc4_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc4_file_name+ '</i>'
						row.status4 = "등록후";
					}
					
					if(!row.proc5_file_group) row.status5 = '등록전';
					else {
						row.proc5_file_down = '<a href="/file/attach_download?file_path=' + row.proc5_file_path +'&file_name=' + encodeURIComponent(row.proc5_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc5_file_name+ '</i>'
						row.status5 = "등록후";
					}
					
					if(!row.proc6_file_group) row.status6 = '등록전';
					else {
						row.proc6_file_down = '<a href="/file/attach_download?file_path=' + row.proc6_file_path +'&file_name=' + encodeURIComponent(row.proc6_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc6_file_name+ '</i>'
						row.status6 = "등록후";
					}
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.in_customer_nm);
						comboValue_nm2.push(row.item_code);
						comboValue_nm3.push(row.item_nm);
						comboValue_nm4.push(row.sernr);
						comboValue_nm5.push(row.out_customer_nm);
						comboValue_nm6.push(row.repair_num);
					}

					
					
					InFindList[row.in_customer_nm] = row.carry_in_customer_code;
					OutFindList[row.out_customer_nm] = row.carry_out_customer_code;
				});
				w2ui.grid_list.records = rowArr;
				
				

			} else {
				w2ui.grid_list.clear();
			}
			w2ui.grid_list.refresh();
			w2ui.grid_list.unlock();
			$('#in_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#sernr').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			$('#out_customer_nm').w2field('combo', { items: _.uniq(comboValue_nm5,false) ,match : 'contains' });
			$('#repair_num').w2field('combo', { items: _.uniq(comboValue_nm6,false) ,match : 'contains' });
			
		}, complete : function(){
			startValue_combo = ":)";
	
			document.getElementById("in_customer_nm").style.removeProperty("height");
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("sernr").style.removeProperty("height");
			document.getElementById("out_customer_nm").style.removeProperty("height");
			document.getElementById("repair_num").style.removeProperty("height");
			
			var startValue_combo = "";

			comboValue_nm1 = new Array;
			comboValue_nm2 = new Array;
			comboValue_nm3 = new Array;
			comboValue_nm4 = new Array;
			comboValue_nm5 = new Array;
			comboValue_nm6 = new Array;
		}
	})
}

// open ins modal
function insReport() {
	$('.clear_field').val('');
 	var minDate = getFormatDate(new Date());
 	var currentDate = getTimeStamp();
	$('.dp_component_d').daterangepicker(
			{
				opens : 'right',
				singleDatePicker : true,
			     timePicker: true,
			      timePicker24Hour:true,
				locale : {
					format : 'YYYY-MM-DD HH:mm:ss', //'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년',
					orientation : "top left"
				},
					startDate : moment(currentDate).format('YYYY-MM-DD HH:mm:ss')
				
			}); 

	$('.filedelete-button').attr('disabled', false);
	$('.fileupload').attr('disabled', false);

	var recids = w2ui.grid_list.getSelection();
	
	var pData;
	if(recids){
		if(recids.length != 1){
			fnMessageModalAlert("알림", "수정 하실 보고서 정보를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
			return false;
		}
		
		// init mod data
		//$('.clear_field').val('');
		//$('.clear_field.dp_component_d').datepicker('setDate', moment().format('YYYY-MM-DD'));
		// input mod data
		
		pData = w2ui.grid_list.get(recids[0]);
		
	

		
		if(pData.success_status == "Y") {
			fnMessageModalAlert("알림", "완료 보고서를 올린 건은 수정 할 수 없습니다.");	// Notification(MES)
			return false;
		}
		
	

		var keys = Object.keys(pData);

		$.each(keys, function(idx, key){
			
			console.log('key : ' + key);
			if(key.includes('file_group')){
				//console.log('file key :: ' + idx + ' / ' + key);
				//console.log(key.substring(4,5));
				var kidx = key.substring(4,5) - 1;
				var repair_class_code = pData.repair_class_code;
				
				var pNum = key.substring(4,5);
				
				if( repair_class_code == 'MD1578'){
					$('#file_group'+(kidx+1)).attr('disabled', false);
					$('#file_btn'+(kidx+1)).attr('disabled', false);
					
				}else if(kidx != 0 && !pData['proc' + kidx + '_file_group']){
					$('#file_group'+(kidx+1)).attr('disabled', true);
					$('#file_btn'+(kidx+1)).attr('disabled', true);
					$('#mod_proc'+kidx+'_date').attr('disabled', false);
				}else{
					$('#mod_proc'+kidx+'_date').attr('disabled', true);
				}
				
				//var insDate = $('#mod_proc'+pNum+'_date').val();
				/* if(kidx != 0 && !pData['proc' + kidx + '_file_group']){
					$('#mod_proc'+kidx+'_date').attr('disabled', false);
				}else{
					$('#mod_proc'+kidx+'_date').attr('disabled', true);
				}
				 */
				console.log('kidx : ' + kidx);
				var managerNm = pData['proc' + kidx + '_manager_nm'];
				console.log('managerNm : ' + managerNm);
				$('#mod_proc' + kidx + '_manager_nm').val(managerNm);
			}
	 		
			
			if(pData[key]) $('#mod_'+key).val(pData[key]);
		})
		
		$('#ins_mod').modal('show');

	} else {
		fnMessageModalAlert("알림", "수정 하실 보고서 정보를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
	} 
}





function cancelCompleteReport()
{
	
	var keys = w2ui.grid_list.getSelection();
	
	var pData = w2ui.grid_list.get(keys[0]);
		
	var repair_num = pData.repair_num;
	
	var strUrl = "/frontend/repair/cancelCompleteReport";
	
	var postData = "repair_num=" + encodeURIComponent(repair_num);

	$.ajax({
		 url: strUrl,
		 type: "POST",
		 dataType : 'json', 
		 data : postData, 
		 async : false,
		 success:function(data, textStatus, jqXHR){
		 	if(data.status == "200") {
		 		console.log(data);
		 		w2ui.grid_list.selectNone();
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

// function getItemInfo(type, value)
// {
// 	console.log('getItemInfo() : ' + value);
// 	var result = "";
// 	if(type == 'cd')
// 	{
// 		$.each(gridDataArr, function(idx, row){
			
// 			if(value == row.item_code)
// 			{
// 				console.log('row.item_nm : ' + row.item_nm);
// 				result = row.item_nm;		
// 				$("#item_nm").val(result);
// 			}
// 		});

// 		if(result == ''){
// 			$("#item_nm").val('');
// 		}
		
// 	}else if(type == 'nm')
// 	{
		
// 		$.each(gridDataArr, function(idx, row){
			
// 			if(value == row.item_nm)
// 			{
// 				console.log('row.item_code : ' + row.item_code);
// 				result = row.item_code;
// 				$("#item_code").val(result);
// 			}
// 		});
// 		if(result == ''){
// 			$("#item_code").val('');
// 		}
		
// 	}

// }



function saveDate(procDate2, insDate2) {
	console.log('saveDate()');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var repair_num = data.repair_num;
	
	
	var strUrl = "/frontend/ovehaul/updateReportDate";

	var postData = {
			repair_num : repair_num ,
			procDate : procDate2,
			insDate : insDate2
		}
	$.ajax({
	    url : strUrl,
	    type : "POST", 
	    dataType : 'json', 
	    data : postData, 
		//async : false,	
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
	    },
	    complete: function() {
	    }
	});
}

// file upload
var file_upload_yn = 'N';


function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/file/repairReport/"  + $(this).attr('data-num'),
		dataType : 'json',
		autoUpload : true,
		enctype : "multipart/form-data",
 		//acceptFileTypes : /(\.|\/)(xlsx)$/i,
		maxFileSize : 30720000, 
		add: function(e, data){
			console.log('fileupload');
			if(data.files[0].size > 30720000)
			{
				fnMessageModalAlert("알림", "파일 용량이 너무 큽니다.");
				return;
			}
			
			console.log('######### fileupload');
			
			file_upload_yn = 'Y';
			
			
			
			console.log('######### file_upload_yn????' + file_upload_yn);
			
			var procNum = $(this).attr('data-num');
			var strNum = procNum.slice(-1);
			var procCd = $(this).attr('data-cd');
			console.log('strNum :' + strNum);
			
			
			if(procNum == 'proc6'){
				fnMessageModalConfirm('알림', '최종 보고서 파일 업로드를 진행 하시겠습니까?\n수리 완료 보고서 업로드 후엔 수정 하실 수 없습니다.',function(chk){
					if(chk){
						
				
						var repairNum = $('#mod_repair_num').val() || '';
						

						
				
						
						var insDate = $('#mod_'+procNum+'_date').val();
						var proManager = $('#mod_'+procNum+'_manager_nm').val();
						
						if(!insDate){
							fnMessageModalAlert("알림", procNum + "번 등록일자는 필수 입니다.");
							return false;
						}
						if(!repairNum){
							fnMessageModalAlert("알림", '수리 접수 번호가 없습니다. 등록창을 다시 띄워 주세요.');
							return false;
						}
						
						///////////////////////////////////////////////////////
						var insDate2 = $('#mod_'+procNum+'_date').val();
						
					    //var insDate2_sub = insDate2.substr(0,8);
						
					    var dateArr = new Date(insDate2);
					    
						var prevNum = Number(strNum) -1 ;
						
						var prevDate = $('#mod_proc'+prevNum+'_date').val();
						//var prevDate_sub = prevDate.substr(0,8);
						
						var prev_dateArr = new Date(prevDate);
						
						var tot_date = Number(dateArr) - Number(prev_dateArr);
						
						
						if(strNum > prevNum){
							if(tot_date == 0 || tot_date < 0){
								fnMessageModalAlert("알림", strNum + "번 처리일자가" + prevNum +"번 처리일자 보다 과거일 수 없습니다.");
								
								return false;
							}
							
						}
						//////////////////////////////////////////////////
						if(!proManager){
							fnMessageModalAlert("알림", strNum + "번 담당자를 입력해주세요.");
							return false;
						}
						if(file_upload_yn == 'Y'){
							console.log("file_upload_yn :::::: 11111111 ");
							for(var i = 1; i < 7; i++){
								console.log("file_upload_yn :::::: 22222222 ");
								var fileInput = 'proc'+ [i];
								
								var fileNb = $('#mod_'+fileInput+'_file_name').val();
								
								var procDate2 = "";
								var insDate2 = "";
								
								var insDate = $('#mod_'+procNum+'_date').val();
								
								if(fileNb != ''){
									if(fileInput == 'proc1'){
										procDate2 = 'proc1_date';
										insDate2 = $('#mod_proc1_date').val();
										
									}else if(fileInput == 'proc2'){
										procDate2 = 'proc2_date';
										insDate2 = $('#mod_proc2_date').val();
										
									}else if(fileInput == 'proc3'){
										procDate2 = 'proc3_date';
										insDate2 = $('#mod_proc3_date').val();
										
									}else if(fileInput == 'proc4'){
										procDate2 = 'proc4_date';
										insDate2 = $('#mod_proc4_date').val();
										
									}else if(fileInput == 'proc5'){
										procDate2 = 'proc5_date';
										insDate2 = $('#mod_proc5_date').val();
										
									}else if(fileInput == 'proc6'){
										procDate2 = 'proc6_date';
										insDate2 = $('#mod_proc6_date').val();
									}
									
									//proc1_date : $('#mod_proc1_date').val();
									console.log("procDate :::::: " + procDate2);
									console.log("insDate :::::: " + insDate2);
									
									saveDate(procDate2, insDate2);
									
								}
								
							}
						}
						$('#mod_' + procNum + '_file_name').val(data.files[0].name);
					
						data.url = '/file/repairReport/' + procCd;
						data.formData = {
							proc_date : insDate,
							file_repo : gProcNm[procCd],
							repair_num : repairNum,
							proc_manager_nm : proManager
						}
					
						data.submit();
					}
				})
			} else {
				var procCd = $(this).attr('data-cd');
				var repairNum = $('#mod_repair_num').val() || '';
				
		
				
				//var insDate = $('#mod_'+procNum+'_date').val().replace(/-/gi,'');
				var insDate = $('#mod_'+procNum+'_date').val();
				var proManager = $('#mod_'+procNum+'_manager_nm').val();
				
				if(!insDate){
					fnMessageModalAlert("알림", procNum + "번 등록일자는 필수 입니다.");
					
					return false;
				}
				if(!repairNum){
					fnMessageModalAlert("알림", '수리 접수 번호가 없습니다. 등록창을 다시 띄워 주세요.');
					$('#mod_' + procNum + '_file_name').val('');
					return false;
				}
				
				///////////////////////////////////////////////////////
				if(procNum != 'proc1'){
					var insDate2 = $('#mod_'+procNum+'_date').val();
					
				    //var insDate2_sub = insDate2.substr(0,8);
					
				    var dateArr = new Date(insDate2);
				    
					var prevNum = Number(strNum) -1 ;
					
					var prevDate = $('#mod_proc'+prevNum+'_date').val(); 
					//var prevDate_sub = prevDate.substr(0,8);
					
					var prev_dateArr = new Date(prevDate);
					
					var tot_date = Number(dateArr) - Number(prev_dateArr);
					
					var nextNum = Number(strNum) +1 ;
					var nextDate = $('#mod_proc'+nextNum+'_date').val();
					
					var next_dateArr = new Date(nextDate);
					
					var tot_date2 = Number(dateArr) - Number(next_dateArr);
					
					console.log("nextNum ?? " + nextNum);
					console.log("nextDate ?? " + nextDate);
					console.log("next_dateArr ?? " + next_dateArr);
					console.log("tot_date2 ?? " + tot_date2);
					
					
					if(strNum > prevNum){
						if(tot_date == 0 || tot_date < 0){
							fnMessageModalAlert("알림", strNum + "번 처리일자가" + prevNum +"번 처리일자 보다 과거일 수 없습니다.");
							
							return false;
						}
						
					}
					
					if(strNum < nextNum){
						if(tot_date2 == 0 || tot_date2 > 0){
							fnMessageModalAlert("알림", strNum + "번 처리일자가" + nextNum +"번 처리일자 보다 미래일 수 없습니다.");
							
							return false;
						}
						
					}
					
					if(file_upload_yn == 'Y'){
						console.log("file_upload_yn :::::: 11111111 ");
						for(var i = 1; i < 7; i++){
							console.log("file_upload_yn :::::: 22222222 ");
							var fileInput = 'proc'+ [i];
							
							var fileNb = $('#mod_'+fileInput+'_file_name').val();
							
							var procDate2 = "";
							var insDate2 = "";
							
							var insDate = $('#mod_'+procNum+'_date').val();
							
							if(fileNb != ''){
								if(fileInput == 'proc1'){
									procDate2 = 'proc1_date';
									insDate2 = $('#mod_proc1_date').val();
									
								}else if(fileInput == 'proc2'){
									procDate2 = 'proc2_date';
									insDate2 = $('#mod_proc2_date').val();
									
								}else if(fileInput == 'proc3'){
									procDate2 = 'proc3_date';
									insDate2 = $('#mod_proc3_date').val();
									
								}else if(fileInput == 'proc4'){
									procDate2 = 'proc4_date';
									insDate2 = $('#mod_proc4_date').val();
									
								}else if(fileInput == 'proc5'){
									procDate2 = 'proc5_date';
									insDate2 = $('#mod_proc5_date').val();
									
								}else if(fileInput == 'proc6'){
									procDate2 = 'proc6_date';
									insDate2 = $('#mod_proc6_date').val();
								}
								
								//proc1_date : $('#mod_proc1_date').val();
								console.log("procDate :::::: " + procDate2);
								console.log("insDate :::::: " + insDate2);
								
								saveDate(procDate2, insDate2);
								
							}
							
						}
					}
				
				}else{
					var insDate2 = $('#mod_'+procNum+'_date').val();
					
				    var dateArr = new Date(insDate2);
				    
					var nextNum = Number(strNum) +1 ;
					var nextDate = $('#mod_proc'+nextNum+'_date').val();
					
					var next_dateArr = new Date(nextDate);
					
					var tot_date2 = Number(dateArr) - Number(next_dateArr);
					
					console.log("nextNum ?? " + nextNum);
					console.log("nextDate ?? " + nextDate);
					console.log("next_dateArr ?? " + next_dateArr);
					console.log("tot_date2 ?? " + tot_date2);
					
					
					if(strNum < nextNum){
						if(tot_date2 > 0){
							fnMessageModalAlert("알림", strNum + "번 처리일자가" + nextNum +"번 처리일자 보다 미래일 수 없습니다.");
							
							return false;
						}
						
					}
					
					
					if(file_upload_yn == 'Y'){
						console.log("file_upload_yn :::::: 11111111 ");
						for(var i = 1; i < 7; i++){
							console.log("file_upload_yn :::::: 22222222 ");
							var fileInput = 'proc'+ [i];
							
							var fileNb = $('#mod_'+fileInput+'_file_name').val();
							
							var procDate2 = "";
							var insDate2 = "";
							
							var insDate = $('#mod_'+procNum+'_date').val();
							
							if(fileNb != ''){
								if(fileInput == 'proc1'){
									procDate2 = 'proc1_date';
									insDate2 = $('#mod_proc1_date').val();
									
								}else if(fileInput == 'proc2'){
									procDate2 = 'proc2_date';
									insDate2 = $('#mod_proc2_date').val();
									
								}else if(fileInput == 'proc3'){
									procDate2 = 'proc3_date';
									insDate2 = $('#mod_proc3_date').val();
									
								}else if(fileInput == 'proc4'){
									procDate2 = 'proc4_date';
									insDate2 = $('#mod_proc4_date').val();
									
								}else if(fileInput == 'proc5'){
									procDate2 = 'proc5_date';
									insDate2 = $('#mod_proc5_date').val();
									
								}else if(fileInput == 'proc6'){
									procDate2 = 'proc6_date';
									insDate2 = $('#mod_proc6_date').val();
								}
								
								//proc1_date : $('#mod_proc1_date').val();
								console.log("procDate :::::: " + procDate2);
								console.log("insDate :::::: " + insDate2);
								
								saveDate(procDate2, insDate2);
								
							}
							
						}
					}
				}
				//////////////////////////////////////////////////
				
				if(!proManager){
					fnMessageModalAlert("알림", strNum + "번 담당자를 입력해주세요.");
					return false;
				}
				
				
				// file_upload_read 에 파일이 있다면   날짜 $('#mod_'+procNum+'_date').val();를 보낸다
				// procNum 갯수만큼 돌면서 파일이 있나 확인
				// 있다면 있는 procCd값과 proc_date(insDate) 값을 보낸다
				
				if(file_upload_yn == 'Y'){
					console.log("file_upload_yn :::::: 11111111 ");
					for(var i = 1; i < 7; i++){
						console.log("file_upload_yn :::::: 22222222 ");
						var fileInput = 'proc'+ [i];
						
						var fileNb = $('#mod_'+fileInput+'_file_name').val();
						
						var procDate2 = "";
						var insDate2 = "";
						
						var insDate = $('#mod_'+procNum+'_date').val();
						
						if(fileNb != ''){
							if(fileInput == 'proc1'){
								procDate2 = 'proc1_date';
								insDate2 = $('#mod_proc1_date').val();
								
							}else if(fileInput == 'proc2'){
								procDate2 = 'proc2_date';
								insDate2 = $('#mod_proc2_date').val();
								
							}else if(fileInput == 'proc3'){
								procDate2 = 'proc3_date';
								insDate2 = $('#mod_proc3_date').val();
								
							}else if(fileInput == 'proc4'){
								procDate2 = 'proc4_date';
								insDate2 = $('#mod_proc4_date').val();
								
							}else if(fileInput == 'proc5'){
								procDate2 = 'proc5_date';
								insDate2 = $('#mod_proc5_date').val();
								
							}else if(fileInput == 'proc6'){
								procDate2 = 'proc6_date';
								insDate2 = $('#mod_proc6_date').val();
							}
							
							//proc1_date : $('#mod_proc1_date').val();
							console.log("procDate :::::: " + procDate2);
							console.log("insDate :::::: " + insDate2);
							
							saveDate(procDate2, insDate2);
							
						}
						
					}
				}
				
				$('#mod_' + procNum + '_file_name').val(data.files[0].name);
				
				data.url = '/file/repairReport/' + procCd;
				
				data.formData = {
					proc_date : insDate,
					file_repo : gProcNm[procCd],
					repair_num : repairNum,
					proc_manager_nm : proManager
				}
				
				data.submit();
			}
		},
	}).on('fileuploadadd', function(e, data) {
		
		
		console.log('fileuploadadd');
	}).on('fileuploadprocessalways', function(e, data) {
		console.log('always')
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Error", file.error);
		}
	}).on('fileuploadprogressall', function(e, data) {
		 
		$('#progress').show();
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		console.log('fileuploaddone');
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		var procNum = $(this).attr('data-num'); 
	
		$('#mod_' + procNum + 'file_name').val(data.files[0].name);
    	
    	if(procNum == 'proc6') location.reload();
    	
		$('#file_group'+ (eval(procNum.substring(4).concat( '+ 1')))).attr('disabled', false);
		$('#file_btn'+ (eval(procNum.substring(4).concat( '+ 1')))).attr('disabled', false);
    	
    	
	}).on('fileuploadfail', function(e, data) {
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}





// function fnLoadFileHandler(){
	
// 	$('.fileupload').fileupload({
// 		url : "/file/repairReport/"  + $(this).attr('data-num'),
// 		dataType : 'json',
// 		autoUpload : true,
// 		enctype : "multipart/form-data",
//  		//acceptFileTypes : /(\.|\/)(xlsx)$/i,
// 		maxFileSize : 30720000, 
// 		add: function(e, data){
// 			console.log('fileupload');
// 			if(data.files[0].size > 30720000)
// 			{
// 				fnMessageModalAlert("알림", "파일 용량이 너무 큽니다.");
// 				return;
// 			}
			
// 			console.log('######### fileupload');
			
// 			file_upload_yn = 'Y';
			
// 			console.log('######### file_upload_yn????' + file_upload_yn);
			
// 			var procNum = $(this).attr('data-num');
// 			var strNum = procNum.slice(-1);
// 			var procCd = $(this).attr('data-cd');
// 			console.log('strNum :' + strNum);
			
// 			if(procNum == 'proc6'){
// 				fnMessageModalConfirm('알림', '최종 보고서 파일 업로드를 진행 하시겠습니까?\n수리 완료 보고서 업로드 후엔 수정 하실 수 없습니다.',function(chk){
// 					if(chk){
						
				
// 						var repairNum = $('#mod_repair_num').val() || '';
						

						
				
						
// 						var insDate = $('#mod_'+procNum+'_date').val();
// 						var proManager = $('#mod_'+procNum+'_manager_nm').val();
						
// 						if(!insDate){
// 							fnMessageModalAlert("알림", procNum + "번 등록일자는 필수 입니다.");
// 							return false;
// 						}
// 						if(!repairNum){
// 							fnMessageModalAlert("알림", '수리 접수 번호가 없습니다. 등록창을 다시 띄워 주세요.');
// 							return false;
// 						}
						
// 						///////////////////////////////////////////////////////
// 						var insDate2 = $('#mod_'+procNum+'_date').val();
						
// 					    //var insDate2_sub = insDate2.substr(0,8);
						
// 					    var dateArr = new Date(insDate2);
					    
// 						var prevNum = Number(strNum) -1 ;
						
// 						var prevDate = $('#mod_proc'+prevNum+'_date').val();
// 						//var prevDate_sub = prevDate.substr(0,8);
						
// 						var prev_dateArr = new Date(prevDate);
						
// 						var tot_date = Number(dateArr) - Number(prev_dateArr);
						
						
// 						if(strNum > prevNum){
// 							if(tot_date == 0 || tot_date < 0){
// 								fnMessageModalAlert("알림", strNum + "번 처리일자가" + prevNum +"번 처리일자 보다 과거일 수 없습니다.");
								
// 								return false;
// 							}
							
// 						}
// 						//////////////////////////////////////////////////
// 						if(!proManager){
// 							fnMessageModalAlert("알림", strNum + "번 담당자를 입력해주세요.");
// 							return false;
// 						}
// 						$('#mod_' + procNum + '_file_name').val(data.files[0].name);
					
// 						data.url = '/file/repairReport/' + procCd;
// 						data.formData = {
// 							proc_date : insDate,
// 							file_repo : gProcNm[procCd],
// 							repair_num : repairNum,
// 							proc_manager_nm : proManager
// 						}
					
// 						data.submit();
// 					}
// 				})
// 			} else {
// 				var procCd = $(this).attr('data-cd');
// 				var repairNum = $('#mod_repair_num').val() || '';
				
		
				
// 				//var insDate = $('#mod_'+procNum+'_date').val().replace(/-/gi,'');
// 				var insDate = $('#mod_'+procNum+'_date').val();
// 				var proManager = $('#mod_'+procNum+'_manager_nm').val();
				
// 				if(!insDate){
// 					fnMessageModalAlert("알림", procNum + "번 등록일자는 필수 입니다.");
					
// 					return false;
// 				}
// 				if(!repairNum){
// 					fnMessageModalAlert("알림", '수리 접수 번호가 없습니다. 등록창을 다시 띄워 주세요.');
// 					$('#mod_' + procNum + '_file_name').val('');
// 					return false;
// 				}
				
// 				///////////////////////////////////////////////////////
// 				if(procNum != 'proc1'){
// 					var insDate2 = $('#mod_'+procNum+'_date').val();
					
// 				    //var insDate2_sub = insDate2.substr(0,8);
					
// 				    var dateArr = new Date(insDate2);
				    
// 					var prevNum = Number(strNum) -1 ;
					
// 					var prevDate = $('#mod_proc'+prevNum+'_date').val(); 
// 					//var prevDate_sub = prevDate.substr(0,8);
					
// 					var prev_dateArr = new Date(prevDate);
					
// 					var tot_date = Number(dateArr) - Number(prev_dateArr);
					
// 					var nextNum = Number(strNum) +1 ;
// 					var nextDate = $('#mod_proc'+nextNum+'_date').val();
					
// 					var next_dateArr = new Date(nextDate);
					
// 					var tot_date2 = Number(dateArr) - Number(next_dateArr);
					
// 					console.log("nextNum ?? " + nextNum);
// 					console.log("nextDate ?? " + nextDate);
// 					console.log("next_dateArr ?? " + next_dateArr);
// 					console.log("tot_date2 ?? " + tot_date2);
					
					
// 					if(strNum > prevNum){
// 						if(tot_date == 0 || tot_date < 0){
// 							fnMessageModalAlert("알림", strNum + "번 처리일자가" + prevNum +"번 처리일자 보다 과거일 수 없습니다.");
							
// 							return false;
// 						}
						
// 					}
					
// 					if(strNum < nextNum){
// 						if(tot_date2 == 0 || tot_date2 > 0){
// 							fnMessageModalAlert("알림", strNum + "번 처리일자가" + nextNum +"번 처리일자 보다 미래일 수 없습니다.");
							
// 							return false;
// 						}
						
// 					}
				
// 				}else{
// 					var insDate2 = $('#mod_'+procNum+'_date').val();
					
// 				    var dateArr = new Date(insDate2);
				    
// 					var nextNum = Number(strNum) +1 ;
// 					var nextDate = $('#mod_proc'+nextNum+'_date').val();
					
// 					var next_dateArr = new Date(nextDate);
					
// 					var tot_date2 = Number(dateArr) - Number(next_dateArr);
					
// 					console.log("nextNum ?? " + nextNum);
// 					console.log("nextDate ?? " + nextDate);
// 					console.log("next_dateArr ?? " + next_dateArr);
// 					console.log("tot_date2 ?? " + tot_date2);
					
					
// 					if(strNum < nextNum){
// 						if(tot_date2 > 0){
// 							fnMessageModalAlert("알림", strNum + "번 처리일자가" + nextNum +"번 처리일자 보다 미래일 수 없습니다.");
							
// 							return false;
// 						}
						
// 					}
// 				}
// 				//////////////////////////////////////////////////
				
// 				if(!proManager){
// 					fnMessageModalAlert("알림", strNum + "번 담당자를 입력해주세요.");
// 					return false;
// 				}
				
				
				
				
				
// 				$('#mod_' + procNum + '_file_name').val(data.files[0].name);
				
// 				data.url = '/file/repairReport/' + procCd;
				
// 				data.formData = {
// 					proc_date : insDate,
// 					file_repo : gProcNm[procCd],
// 					repair_num : repairNum,
// 					proc_manager_nm : proManager
// 				}
				
// 				data.submit();
// 			}
// 		},
// 	}).on('fileuploadadd', function(e, data) {
		
		
// 		console.log('fileuploadadd');
// 	}).on('fileuploadprocessalways', function(e, data) {
// 		console.log('always')
// 		var index = data.index;
// 		var file = data.files[index];
// 		if (file.error) {
// 			fnMessageModalAlert("Error", file.error);
// 		}
// 	}).on('fileuploadprogressall', function(e, data) {
		 
// 		$('#progress').show();
// 		var progress = parseInt(data.loaded / data.total * 100, 10);
// 		$('#progress .progress-bar').css('width', progress + '%');
// 	}).on('fileuploaddone', function(e, data) {
// 		console.log('fileuploaddone');
// 		setTimeout(function () {
// 			$('#progress').hide();
// 	    	$('#progress .progress-bar').css('width', '0%');
// 		}, 700);
		
// 		var procNum = $(this).attr('data-num'); 
	
// 		$('#mod_' + procNum + 'file_name').val(data.files[0].name);
    	
//     	if(procNum == 'proc6') location.reload();
    	
// 		$('#file_group'+ (eval(procNum.substring(4).concat( '+ 1')))).attr('disabled', false);
// 		$('#file_btn'+ (eval(procNum.substring(4).concat( '+ 1')))).attr('disabled', false);
    	
    	
// 	}).on('fileuploadfail', function(e, data) {
// 		setTimeout(function () {
// 			$('#progress').hide();
// 	    	$('#progress .progress-bar').css('width', '0%');
// 		}, 700);
		
// 		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
// 	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
// }





</script>

</body>
</html>