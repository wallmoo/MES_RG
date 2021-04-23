<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Set | Backend</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>

<body class="hold-transition skin-black sidebar-mini">

<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="menu_div" value="B" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="B" />
		<jsp:param name="selected_menu_p_cd" value="1003" />
		<jsp:param name="selected_menu_cd" value="1005" />
	</jsp:include>

  
  <div class="content-wrapper">
    <section class="content-header">
      <h1> 시스템관리 <small>부서/사용자관리</small> </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 시스템관리</a></li><li class="active">부서/사용자관리</li>
      </ol>
    </section>

    <section class="content">
      <div class="row">
        <div class="col-md-4">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">조직정보</h3>
              <div class="box-tools pull-right">
                <button type="button" id="btn_organ_add" class="btn btn-danger btn-sm">조직추가</button>
                <button type="button" id="btn_organ_info" class="btn btn-warning btn-sm">조직상세</button>
              </div>
            </div>
            <div id="" class="box-body">
            	<div class="row">
			          <div class="col-sm-3">
			          	<div class="form-group">
			          		<label>법인/거점</label>
			          	</div>
			          </div>
			          <div class="col-sm-9">
			            <div class="form-group">
		                <select id="sel_company" class="form-control select2" data-placeholder="회사선택" style="width: 100%;">
		                </select>
		              </div>
			          </div>
			        </div>
			        <div class="row">
			          <div class="col-sm-3">
			          	<div class="form-group">
			          		<label>조직명</label>
			          	</div>
			          </div>
			          <div class="col-sm-9">
			            <div class="form-group">
		                <div class="input-group input-group-sm">
		                  <input type="text" id="search_dept_nm" name="search_dept_nm" class="form-control pull-right" placeholder="Organ Search">
											<div class="input-group-btn">
		                    <button type="button" id="btn_search_dept_nm" class="btn btn-default"><i class="fa fa-search"></i></button>
		                  </div>
		                </div>
		              </div>
			          </div>
			        </div>
			        <div class="row">
			        	<div class="col-sm-12">
				        	<div class="box box-default">
				        		<div class="box-body">
				        			<div class="row">
							        	<div class="col-sm-12">
							        		<div id="tree_dept" style="min-height: 550px; max-height:550px; overflow:auto;"></div>
							        	</div>
						        	</div>
					        	</div>
				        	</div>
				        </div>
			        </div>
            </div>
          </div>
        </div>
        <div class="col-md-8">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">사용자정보</h3>
              <div class="box-tools pull-right">
                <div class="input-group input-group-sm" style="width: 150px;float: left;">
                  <input type="text" id="member_nm_search" name="member_nm_search" class="form-control pull-right" placeholder="Search">
									<div class="input-group-btn">
                    <button type="button" id="btn_member_search" class="btn btn-default"><i class="fa fa-search"></i></button>
                  </div>
                </div>
                |
                <button type="button" id="btn_member_add" class="btn btn-danger btn-sm">사용자추가</button>
                <button type="button" id="btn_member_info" class="btn btn-warning btn-sm">사용자상세</button>
              </div>
            </div>
            <div id="dv_grid_member" class="box-body" style="min-height: 700px;">
              <table id="grid_member"></table>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<div class="modal fade" id="modal_organ" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_code_title">조직관리</h4>
        </div>
        <div class="modal-body" id="modal_code_body">
          <div class="box box-warning box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">조직정보</h3>
              <div class="box-tools pull-right">
	              <button type="button" id="btn_organ_save" class="btn btn-success btn-sm">조직저장</button>
	              <button type="button" id="btn_organ_del" class="btn btn-danger btn-sm">조직삭제</button>
              </div>
            </div>

            <form id="frm_organ" name="frm_organ" class="form-horizontal">
            	<input type="hidden" id="o_cmd" name="cmd">
            	<input type="hidden" id="o_company_cd" name="company_cd">
            	<input type="hidden" id="o_dept_class" name="dept_class">
            	<input type="hidden" id="o_dept_type" name="dept_type">
            	<input type="hidden" id="o_dept_use_yn" name="dept_use_yn" />
            	
              <div class="box-body">
                <div class="form-group">
                  <label for="o_company_nm" class="col-sm-3 control-label">법인명</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_company_nm" name="company_nm" class="form-control" placeholder="Corperation Name" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_p_cd" class="col-sm-3 control-label">상위조직코드</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_dept_p_cd" name="dept_p_cd" class="form-control" placeholder="Dept Parent Code" maxlength="20" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_p_nm" class="col-sm-3 control-label">상위조직명</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_dept_p_nm" name="dept_p_nm" class="form-control" placeholder="Dept Parent Name" maxlength="100" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_cd" class="col-sm-3 control-label">조직코드</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_dept_cd" name="dept_cd" class="form-control" placeholder="Dept Code" maxlength="20" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_nm" class="col-sm-3 control-label">조직명</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_dept_nm" name="dept_nm" class="form-control" placeholder="Dept Name(kr)" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_nm_en" class="col-sm-3 control-label">조직명(영문)</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_dept_nm_en" name="dept_nm_en" class="form-control" placeholder="Dept Name(en)" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sel_dept_class" class="col-sm-3 control-label">조직분류</label>
                  <div class="col-sm-9">
                  	<select id="sel_dept_class" class="form-control select2" data-placeholder="조직분류선택" style="width: 100%;">
		                  <option value="C">법인</option>
		                  <option value="R">본부</option>
		                  <option value="D">부서</option>
		                  <option value="T">팀</option>
		                </select>
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_sdate" class="col-sm-3 control-label">조직시작일</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_dept_sdate" name="dept_sdate" class="form-control" placeholder="Dept Start Date" maxlength="10">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_edate" class="col-sm-3 control-label">조직종료일</label>
                  <div class="col-sm-9">
                    <input type="input" id="o_dept_edate" name="dept_edate" class="form-control" placeholder="Dept End Date" maxlength="10">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_order" class="col-sm-3 control-label">조직출력순서</label>
                  <div class="col-sm-9">
                    <input type="number" id="o_dept_order" name="dept_order" class="form-control" placeholder="출력순서" maxlength="4" oninput="maxLengthCheck(this);" />
                  </div>
                </div>
                <div class="form-group">
                  <label for="rdo_dept_use_yn" class="col-sm-3 control-label">조직사용여부</label>
                  <div class="col-sm-9">
                  	<label>
		                  <input type="radio" name="rdo_dept_use_yn" class="flat-red" value="Y" checked> 사용
		                </label>
		                <label>
		                  <input type="radio" name="rdo_dept_use_yn" class="flat-red" value="N" > 미사용
		                </label>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="modal_member" role="dialog" aria-hidden="false" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_code_title">사용자관리</h4>
        </div>
        <div class="modal-body" id="modal_code_body">
          <div class="box box-warning box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">사용자정보</h3>
              <div class="box-tools pull-right">
              	  <button type="button" id="btn_dept_chn" class="btn btn-info btn-sm" onclick="chnDeptModal();">부서변경</button>
	              <button type="button" id="btn_member_save" class="btn btn-success btn-sm">사용자저장</button>
	              <button type="button" id="btn_member_passinit" class="btn btn-danger btn-sm">사용자 패스워드초기화</button>
	              <button type="button" id="btn_member_del" class="btn btn-danger btn-sm">사용자삭제</button>
              </div>
            </div>

            <form id="frm_member" name="frm_member" class="form-horizontal">
            	<input type="hidden" id="m_cmd" name="cmd">
            	<input type="hidden" id="m_company_cd" name="company_cd">
            	<input type="hidden" id="m_use_yn" name="use_yn" />
            	<input type="hidden" id="m_position_cd" name="position_cd">
            	<input type="hidden" id="m_map_ord" name="map_ord">
            	<input type="hidden" id="fg_check_yn" name="fg_check_yn" value="N">
            	<input type="hidden" id="fg_check_yn2" name="fg_check_yn2" value="N">
            	
              <div class="box-body">
                <div class="form-group">
                  <label for="o_company_nm" class="col-sm-3 control-label">법인명</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_company_nm" name="company_nm" class="form-control" placeholder="Corperation Name" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="o_dept_cd" class="col-sm-3 control-label">조직코드</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_dept_cd" name="dept_cd" class="form-control" placeholder="Dept Code" maxlength="20" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_dept_nm" class="col-sm-3 control-label">조직명</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_dept_nm" name="dept_nm" class="form-control" placeholder="Dept Name(kr)" maxlength="100" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_member_emp_no" class="col-sm-3 control-label">사원번호</label>
                  <div class="col-sm-6">
                	<input type="hidden" id="default_member_emp_no" name="default_member_emp_no" class="form-control" placeholder="Emp No" maxlength="50">
                  	<input type="input" id="m_member_emp_no" name="member_emp_no" class="form-control" placeholder="Emp No" maxlength="50">
                  </div>
                  <div class="col-sm-3">
                  	<button type="button" id="btn_emp_check" class="btn btn-info btn-sm">사용자 중복체크</button>
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_member_id" class="col-sm-3 control-label">사용자ID</label>
                  <div class="col-sm-6">
                  	<input type="input" id="m_member_id" name="member_id" class="form-control" placeholder="Member ID" maxlength="30">
                  </div>
                  <div class="col-sm-3">
                  	<button type="button" id="btn_member_check" class="btn btn-info btn-sm">사용자ID 중복체크</button>
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_member_email" class="col-sm-3 control-label">사용자Email</label>
                  <div class="col-sm-9">
                  	<input type="input" id="m_member_email" name="member_email" class="form-control" placeholder="Member Email" maxlength="200">
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_member_nm" class="col-sm-3 control-label">사용자명</label>
                  <div class="col-sm-9">
                  	<input type="input" id="m_member_nm" name="member_nm" class="form-control" placeholder="Member Name" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_member_nm_en" class="col-sm-3 control-label">사용자명(영문)</label>
                  <div class="col-sm-9">
                  	<input type="input" id="m_member_nm_en" name="member_nm_en" class="form-control" placeholder="Member Name" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_phone_no" class="col-sm-3 control-label">사용자 연락처</label>
                  <div class="col-sm-9">
                  	<input type="input" id="m_phone_no" name="phone_no" class="form-control" placeholder="Member Cell No" maxlength="50">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sel_position_cd" class="col-sm-3 control-label">직급</label>
                  <div class="col-sm-9">
                  	<select id="sel_position_cd" class="form-control select2" data-placeholder="직급선택" style="width: 100%;">
		                </select>
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_start_dt" class="col-sm-3 control-label">입사일자</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_start_dt" name="start_dt" class="form-control" placeholder="Dept Member Start Date" maxlength="10">
                  </div>
                </div>
                <div class="form-group">
                  <label for="m_end_dt" class="col-sm-3 control-label">퇴사일자</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_end_dt" name="end_dt" class="form-control" placeholder="Dept Member End Date" maxlength="10">
                  </div>
                </div>
                <div class="form-group">
                  <label for="rdo_use_yn" class="col-sm-3 control-label">사용자활성여부</label>
                  <div class="col-sm-9">
                  	<label>
		                  <input type="radio" name="rdo_use_yn" class="flat-red" value="Y" checked> 활성
		                </label>
		                <label>
		                  <input type="radio" name="rdo_use_yn" class="flat-red" value="N" > 비활성
		                </label>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  
<div class="modal fade" id="modal_organ_member" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">부서변경</h4>
			</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div class="box">
							<div class="box-header with-border">
								변경할 부서를 선택해주세요.&nbsp;
								<div class="box-tools pull-right" style="min-height: 40px;">
									<button type="button" class="btn btn-success btn-sm pull-right" id="" onclick="chnDeptSave();">저장</button>
								</div>
							</div>
							<div id="" class="box-body">
								<div class="row">
									<div class="col-md-12">
										<div class="box box-primary box-solid" style="min-height: 400px;">
											<div class="box-header with-border">
												<h3 class="box-title">부서정보</h3>
												<div class="box-tools pull-right">
												</div>
											</div>
											<div id="" class="box-body">
<!-- 												<div class="row"> -->
<!-- 													<div class="col-sm-3"> -->
<!-- 														<div class="form-group"> -->
<!-- 															<label>Organization</label> -->
<!-- 														</div> -->
<!-- 													</div> -->
<!-- 													<div class="col-sm-9"> -->
<!-- 														<div class="form-group"> -->
<!-- 															<div class="input-group input-group-sm"> -->
<!-- 																<input type="text" id="search_dept_nm" name="search_dept_nm" class="form-control pull-right" placeholder="Organ Search"> -->
<!-- 																<div class="input-group-btn"> -->
<!-- 																	<button type="button" id="btn_search_dept_nm" class="btn btn-default"><i class="fa fa-search"></i></button> -->
<!-- 																</div> -->
<!-- 															</div> -->
<!-- 														</div> -->
<!-- 													</div> -->
<!-- 												</div> -->
												<div class="row">
													<div class="col-sm-12">
														<div class="box box-default">
															<div class="box-body">
																<div class="row">
																	<div class="col-sm-12">
																		<div id="sub_tree_dept" style="min-height: 480px; max-height: 480px;overflow:auto;"></div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
var selected_dept_cd, selected_parent_dept_cd;
var selected_dept_nm, selected_parent_dept_nm;
var selected_dept_is_leaf = true;

$(function($) {
	fnPageLoadOption();
	fnLoadOrganTreeOption();
	fnLoadOrganTree();
	
	fnLoadOrganMemberGrid();
});

function fnPageLoadOption(){
	$('input[type="radio"].flat-red').iCheck({
    checkboxClass: 'icheckbox_flat-green',
    radioClass: 'iradio_flat-green',
    handle: 'radio'
  });
	
	getSelectCompany($("#sel_company"), false);
	getSelectPosition($("#sel_position_cd"));
	
	$("#sel_company, #sel_dept_class").select2({
		minimumResultsForSearch: Infinity
	}).on("change", function(e) {
		if(e.target.id == "sel_company") {
			$('#tree_dept').jstree("destroy").empty();
			fnLoadOrganTree();	
		}
  });
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_member", false);
	}).trigger('resize');
	
	$("#o_dept_sdate, #o_dept_edate, #m_start_dt, #m_end_dt").datepicker({
		language: "kr",
		todayHighlight: true,
		format: "yyyy.mm.dd",
		autoclose: true
  });
	
	$( "#btn_organ_add, #btn_organ_info" ).on('click', function(e) {
		e.preventDefault();
		
		if(selected_dept_cd == undefined) {
			fnMessageModalAlert("Notification(Organ)", "선택된 부서정보가 없습니다. 조직정보에서 해당 부서를 선택하세요.");
			return;
		}
		
		if(e.target.id == "btn_organ_add"){
			$("form").each(function() {  
        if(this.name == "frm_organ") {
        	this.reset();
        	$("#o_dept_order").val("9999");
        }  
     	});
			$("#btn_organ_del").prop("disabled", true);
			$("#o_cmd").val("I");
			
			$("#o_dept_p_cd").val(selected_dept_cd);
			$("#o_dept_p_nm").val(selected_dept_nm);
			
			var data = $('#sel_company').select2('data')
			$("#o_company_cd").val(data[0].id);
    	$("#o_company_nm").val(data[0].text);
    	$("#sel_dept_class").val("T").trigger('change');
    	
			$("#modal_organ").modal('show');
			
		} else if(e.target.id == "btn_organ_info"){
			
			$("#btn_organ_del").prop("disabled", false);
			$("#o_cmd").val("U");
			fnLoadOrganInfo();
			
			$("#modal_organ").modal('show');
		}
	});
	
	$( "#btn_member_add, #btn_member_info" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_member_add"){
			$("form").each(function() {  
        if(this.name == "frm_member") {
        	this.reset();
        }
     	});
// 			$("#m_member_emp_no").attr("readonly", false);
			 
			$("#fg_check_yn").val("N");
			$("#fg_check_yn2").val("N");
			$("#btn_member_check").show();
// 			$("#btn_emp_check").show();
			$("#btn_member_del").prop("disabled", true);
			$("#m_cmd").val("I");
			$("#m_dept_cd").val(selected_dept_cd);
			$("#m_dept_nm").val(selected_dept_nm);
			var data = $('#sel_company').select2('data');
			$("#m_company_cd").val(data[0].id);
    	$("#m_company_nm").val(data[0].text);
    	$("#m_member_id").attr("readonly", false);
			$("#sel_position_cd").val("00").trigger('change');

			$("#btn_dept_chn").hide();
			$("#modal_member").modal('show');
		} else if(e.target.id == "btn_member_info") {
			
			$("#fg_check_yn").val("Y");
			$("#fg_check_yn2").val("N");
			
			$("#btn_member_check").hide();
// 			$("#btn_emp_check").hide();
			$("#m_member_id").attr("readonly", true);
// 			$("#m_member_emp_no").attr("readonly", true);
			
			var member_emp_no = $("#grid_member").jqGrid('getGridParam',"selrow");
			if(member_emp_no != null){
				$("#btn_member_del").prop("disabled", false);
				$("#m_cmd").val("U");
				fnLoadMemberInfo();
				
				$("#btn_dept_chn").show();
				$("#modal_member").modal('show');	
			} else {
				fnMessageModalAlert("Notification(Organ)", "선택된 사용자정보가 없습니다. 사용자정보에서 사용자를 선택하세요.");
			}
		}
	});	
	
	$( "#btn_organ_save, #btn_member_save" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_organ_save"){
			
			if($.trim($("#o_dept_nm").val()).length == 0 || $.trim($("#o_dept_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Organ)", "조직명을 입력하세요.(영문명 포함)");
				return;
			}
			
			if($.trim($("#o_dept_order").val()).length != 4) {
				fnMessageModalAlert("Notification(Organ)", "조직출력순서를 4자리를 입력하세요.");
				return;
			}
			
			if($.trim(replaceAll($("#o_dept_sdate").val(), ".", "")).length != 8) {
				fnMessageModalAlert("Notification(Organ)", "조직의 시작일자를 선택하세요.");
				return;
			}
			
			$("#o_dept_class").val($('#sel_dept_class').val());
			$("#o_dept_use_yn").val($(':radio[name="rdo_dept_use_yn"]:checked').val());

			fnSaveOrgan();
		} else if(e.target.id == "btn_member_save"){
			
			if($.trim($("#m_member_emp_no").val()).length == 0) {
				fnMessageModalAlert("Notification(Organ)", "사원번호를 입력하세요.");
				return;
			}
			
			if($.trim($("#m_member_id").val()).length == 0) {
				fnMessageModalAlert("Notification(Organ)", "사원ID를 입력하세요.");
				return;
			}
			
			if($.trim($("#m_member_nm").val()).length == 0 || $.trim($("#m_member_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Organ)", "사원명을 입력하세요.(영문명포함)");
				return;
			}
			
			if($.trim($("#m_member_email").val()).length == 0) {
				fnMessageModalAlert("Notification(Organ)", "사원Email를 입력하세요.");
				return;
			}
			
			if($.trim(replaceAll($("#m_start_dt").val(), ".", "")).length != 8) {
				fnMessageModalAlert("Notification(Organ)", "조직사용자의 시작일자를 선택하세요.");
				return;
			}
			
			if($("#fg_check_yn").val() == "N") {
				fnMessageModalAlert("Notification(Organ)", "사용자ID 중복체크를 확인하세요.");
				return;
			}
			
			if($("#fg_check_yn2").val() == "N") {
				fnMessageModalAlert("Notification(Organ)", "사용자 사원번호 중복체크를 확인하세요.");
				return;
			}
			
			
			$("#m_use_yn").val($(':radio[name="rdo_use_yn"]:checked').val());
			$("#m_position_cd").val($("#sel_position_cd").val());
			$("#m_map_ord").val("1");
			
			fnSaveMember();
		}
	});
	
	$( "#btn_organ_del, #btn_member_del" ).on('click', function(e) {
		e.preventDefault();
		
		if(e.target.id == "btn_organ_del"){
			
			if(selected_dept_is_leaf) {
				fnMessageModalAlert("Notification(Organ)", "하위조직이 있으면 삭제할 수 없습니다.");
				return;
			}
			if($("#grid_member").getGridParam("reccount") > 0) {
				fnMessageModalAlert("Notification(Organ)", "해당부서의 사용자가 있는 경우, 삭제할 수 없습니다.");
				return;
			}
			
			fnMessageModalConfirm("Confirm(Organ)", "조직정보를 삭제하시겠습니까?<br/>[주의] 삭제된 데이터는 복구되지 않습니다.", function(result){
				if(result) {
					$("#o_cmd").val("D");
					fnDeleteOrgan();
				}
			});
			
		} else if(e.target.id == "btn_member_del"){
			fnMessageModalConfirm("Confirm(Organ)", "사용자정보를 삭제하시겠습니까?<br/>[주의] 삭제된 데이터는 복구되지 않습니다.", function(result){
				if(result) {
					$("#m_cmd").val("D");
					fnDeleteMember();
				}
			});
		}
	});	
	
	
	$( "#btn_emp_check" ).on('click', function(e) {
		e.preventDefault();
		if($.trim($("#m_member_emp_no").val()).length == 0) {
			fnMessageModalAlert("Notification(Organ)", "사원번호를 입력하세요.");
			return;
		}
		
		if($.trim($("#m_member_emp_no").val()).length < 3) {
			fnMessageModalAlert("Notification(Organ)", "사원번호는 3자리이상을 입력하세요.");
			return;
		}
		fnCheckEmpId();
	});	
	
	$( "#btn_member_check" ).on('click', function(e) {
		e.preventDefault();
		if($.trim($("#m_member_id").val()).length == 0) {
			fnMessageModalAlert("Notification(Organ)", "사원ID를 입력하세요.");
			return;
		}
		
		if($.trim($("#m_member_id").val()).length < 3) {
			fnMessageModalAlert("Notification(Organ)", "사원ID는 3자리이상을 입력하세요.");
			return;
		}
		fnCheckMemberId();
	});	
	
	$( "#btn_member_passinit" ).on('click', function(e) {
		e.preventDefault();
		var member_emp_no = $("#grid_member").jqGrid('getGridParam',"selrow");
		if(member_emp_no != null){
			fnMessageModalConfirm("Confirm(Organ)", "사용자의 패스워드 정보를 초기화하시겠습니까?", function(result){
				if(result) {
					fnInitMemberPwd();
				}
			});	
		} else {
			fnMessageModalAlert("Notification(Organ)", "선택된 사용자정보가 없습니다. 사용자정보에서 사용자를 선택하세요.");
		}
	});	
	
	$("#member_nm_search").pressEnter(function(e) {
		e.preventDefault();
		fnSearchOrganMemberGrid(null);
	});	
	
	$( "#btn_member_search" ).on('click', function(e) {
		e.preventDefault();
		fnSearchOrganMemberGrid(null);
	});
}

function fnLoadOrganTreeOption() {
	var to = false;
	$('#search_dept_nm').keyup(function () {
		if(to) { clearTimeout(to); }
		to = setTimeout(function () {
			var v = $('#search_dept_nm').val();
			$('#tree_dept').jstree(true).search(v);
		}, 250);
	});
}

function fnLoadOrganTree(){
	var tree_url = "/backend/mng_organ/data_organ_tree";
	tree_url += '?dept_p_cd=-1';
	tree_url += '&company_cd=' + encodeURIComponent($("#sel_company").val());
	tree_url += '&dept_use_yn=' + encodeURIComponent("Y");
	
	$('#tree_dept').jstree({
		'core' : {
			'animation' : 0,
	    	'check_callback' : true,
		  	'data' : {
		    'url' : tree_url,
		    'method' : "post",
		    'data' : function (node) {
		    	return { 'id' : node.id };
		    }
		  }, 
		  themes : {
				'responsive' : false,
				'stripes' : true,
				"theme": "default",
        		"icons": true,
				'dots': true
			},
			"multiple": false
		},
    plugins : ["search", "types", "themes", "ui", "unique"]
	}).on("select_node.jstree", function(evt, data){
		
		selected_dept_cd = data.node.id;
	  selected_dept_nm = data.node.text;
	  
	  var p_node = $('#tree_dept').jstree(true).get_node(data.node.parent);
	  selected_parent_dept_cd = p_node.id;
	  selected_parent_dept_nm = p_node.text;
	  
	  fnSearchOrganMemberGrid(selected_dept_cd);
	  
  }).on('loaded.jstree', function() {
  	var i = 0;
    $.each($("#tree_dept").jstree()._model.data, function (value, index) {
			if (i == 0) {
      	$("#tree_dept").jstree(true).select_node(value, false, false);
        $("#tree_dept").jstree(true).open_node(value);
        return false;
      }  
      i++;
    });
  }).on('activate_node.jstree', function(e, data) {
	  if(!data.instance.is_leaf(data.node)) {
	  	selected_dept_is_leaf = true;
	  } else {
	  	selected_dept_is_leaf = false; 
	  }
	});
}

function fnLoadOrganInfo() {
	
	var tree_url = "/backend/mng_organ/data_ogran_info";
	var param = 'dept_cd=' + encodeURIComponent(selected_dept_cd);
	param += '&company_cd=' + encodeURIComponent($("#sel_company").val());
	
	$.ajax({
		url : tree_url,
		data : param,
		type : "POST",
		dataType : 'json',
		success : function(data) {
			var organ_data = data.data;
			$("#o_company_cd").val(organ_data.company_cd);
    	$("#o_company_nm").val(organ_data.company_nm);
    	$("#o_dept_class").val(organ_data.dept_class);
    	$("#o_dept_type").val(organ_data.dept_type);
    	$("#o_dept_use_yn").val(organ_data.dept_use_yn);
    	
    	$("#o_dept_p_cd").val(organ_data.dept_p_cd);
    	$("#o_dept_p_nm").val(organ_data.dept_p_nm);
    	$("#o_dept_cd").val(organ_data.dept_cd);
    	$("#o_dept_nm").val(organ_data.dept_nm);
    	$("#o_dept_nm_en").val(organ_data.dept_nm_en);
    	$("#o_dept_order").val(organ_data.dept_order);
    	
    	$("#sel_dept_class").val(organ_data.dept_class).trigger('change');
    	
    	$("#o_dept_sdate").datepicker("setDate", strWithYYMMDD(organ_data.dept_sdate));
    	$("#o_dept_edate").datepicker("setDate", strWithYYMMDD(organ_data.dept_edate));
    	
    	$(':radio[name="rdo_dept_use_yn"][value="'+ organ_data.dept_use_yn +'"]').iCheck('check');
			$(':radio[name="rdo_dept_use_yn"]').iCheck('update');
		}
	});
}

function fnLoadOrganMemberGrid(){
	var page_url = "/backend/mng_organ/data_member_grid";
	page_url += "?dept_cd=" + encodeURIComponent((selected_dept_cd==undefined?"N/A":selected_dept_cd));
	page_url += "&company_cd=" + encodeURIComponent($("#sel_company").val());
		
	$("#grid_member").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['법인CD','법인명','부서CD','부서명','사원No','MemberID','사원명','이메일','연락처','직급','상태'],
		colModel:[
			{name:'company_cd',index:'company_cd', width:10, sorttype:"text", sortable:true, hidden:true},
			{name:'company_nm',index:'company_nm', width:150, sorttype:"text", sortable:true},
			{name:'dept_cd',index:'dept_cd', width:10, sorttype:"text", sortable:true, hidden:true},
			{name:'dept_nm',index:'dept_nm', width:120, sorttype:"text", sortable:true},
			{name:'member_emp_no',index:'member_emp_no', width:70, sorttype:"text", sortable:true, key: true},
			{name:'member_id',index:'member_id', width:100, sorttype:"text", sortable:true},
			{name:'member_nm',index:'member_nm', width:90, sorttype:"text", sortable:true},
			{name:'member_email',index:'member_email', width:200, sorttype:"text", sortable:true},
			{name:'phone_no',index:'phone_no', width:120, sorttype:"text", sortable:true},
			{name:'position_nm',index:'position_nm', width:120, sorttype:"text", sortable:true},
			{name:'use_yn',index:'use_yn', width:80, sorttype:"text", sortable:true}
		],
		rowNum:10000,
		viewrecords : true,
    autowidth : true,
    shrinkToFit: true, 
    multiselect : false,
    height: 550,
		altRows: true,
		rownumbers: true, 
    rownumWidth: 25,
    sortable: true,
    sortname: "member_nm",
		loadComplete : function() {
		}
	});
}

function fnSearchOrganMemberGrid(p_dept_cd){
	var page_url = "/backend/mng_organ/data_member_grid";
	page_url += "?dept_cd=" + encodeURIComponent((p_dept_cd == undefined?"":p_dept_cd));
	page_url += "&company_cd=" + encodeURIComponent($("#sel_company").val());
	page_url += "&member_nm=" + encodeURIComponent($('#member_nm_search').val());
	
	$("#grid_member").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_member").trigger("reloadGrid");
}

function fnLoadMemberInfo() {
	
	var grid = $("#grid_member");
	var member_emp_no = grid.jqGrid('getGridParam',"selrow");
	
	var tree_url = "/backend/mng_organ/data_member_info";
	var param = 'member_emp_no=' + encodeURIComponent(member_emp_no);
	param += '&company_cd=' + encodeURIComponent($("#sel_company").val());
	
	$.ajax({
		url : tree_url,
		data : param,
		type : "POST",
		dataType : 'json',
		success : function(data) {
			var member_data = data.data;
			
			$("#m_company_cd").val(member_data.company_cd);
    	$("#m_company_nm").val(member_data.company_nm);
    	$("#m_use_yn").val(member_data.use_yn);
    	
    	$("#m_dept_cd").val(member_data.dept_cd);
    	$("#m_dept_nm").val(member_data.dept_nm);
    	
    	
    	$("#default_member_emp_no").val(member_data.member_emp_no);
    	$("#m_member_emp_no").val(member_data.member_emp_no);
    	$("#m_member_id").val(member_data.member_id);
    	$("#m_member_nm").val(member_data.member_nm);
    	$("#m_member_nm_en").val(member_data.member_nm_en);
    	$("#m_phone_no").val(member_data.phone_no);
    	$("#m_member_email").val(member_data.member_email);
    	
    	$("#sel_position_cd").val(member_data.position_cd).trigger('change');
    	$("#m_start_dt").datepicker("setDate", strWithYYMMDD(member_data.start_dt));
    	$("#m_end_dt").datepicker("setDate", strWithYYMMDD(member_data.end_dt));
    	
    	$(':radio[name="rdo_use_yn"][value="'+ member_data.use_yn +'"]').iCheck('check');
			$(':radio[name="rdo_use_yn"]').iCheck('update');
		}
	});
}

function fnSaveOrgan(){
	var postData = $("#frm_organ").serializeArray();
  var formURL = "/backend/mng_organ/save_dept";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		fnMessageModalAlert("Notification(Organ)", "입력하신 조직정보를 저장하였습니다.");
      		$('#tree_dept').jstree("destroy").empty();
    			fnLoadOrganTree();
					$("#modal_organ").modal('hide');
      	} else {
      		fnMessageModalAlert("Notification(Organ)", "입력하신 조직정보를 저장하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Organ)", "입력하신 조직정보를 저장하는데 에러가 발생하였습니다.");	
      }
  });
}

function fnDeleteOrgan(){
	var postData = $("#frm_organ").serializeArray();
  var formURL = "/backend/mng_organ/del_dept";
  
  $.ajax({
    url : formURL,
    type: "POST",
    data : postData,
    success:function(data, textStatus, jqXHR){
    	if(data.status == "200") {
    		fnMessageModalAlert("Notification(Organ)", "선택한 조직정보를 삭제하였습니다.");
    		$('#tree_dept').jstree("destroy").empty();
  			fnLoadOrganTree();
				$("#modal_organ").modal('hide');
    	} else {
    		fnMessageModalAlert("Notification(Organ)", "선택한 조직정보를 삭제하는데 에러가 발생하였습니다.");	
    	}
    },
    error: function(jqXHR, textStatus, errorThrown){
      fnMessageModalAlert("Notification(Organ)", "선택한 조직정보를 삭제하는데 에러가 발생하였습니다.");	
    }
	});
}

function fnSaveMember(){
	var postData = $("#frm_member").serializeArray();
  var formURL = "/backend/mng_organ/save_member";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		fnMessageModalAlert("Notification(Organ)", "입력하신 사용자정보를 저장하였습니다.");
      		fnSearchOrganMemberGrid(selected_dept_cd);
      		$("#modal_member").modal('hide');
      	} else {
      		fnMessageModalAlert("Notification(Organ)", "입력하신 사용자정보를 저장하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Organ)", "입력하신 사용자정보를 저장하는데 에러가 발생하였습니다.");	
      }
  });
}

function fnDeleteMember(){
	var postData = $("#frm_member").serializeArray();
  var formURL = "/backend/mng_organ/del_member";
  
  $.ajax({
    url : formURL,
    type: "POST",
    data : postData,
    success:function(data, textStatus, jqXHR){
    	if(data.status == "200") {
    		fnMessageModalAlert("Notification(Organ)", "선택한 사용자정보를 삭제하였습니다.");
    		fnSearchOrganMemberGrid(selected_dept_cd);
				$("#modal_member").modal('hide');
    	} else {
    		fnMessageModalAlert("Notification(Organ)", "선택한 사용자정보를 삭제하는데 에러가 발생하였습니다.");	
    	}
    },
    error: function(jqXHR, textStatus, errorThrown){
      fnMessageModalAlert("Notification(Organ)", "선택한 사용자정보를 삭제하는데 에러가 발생하였습니다.");	
    }
	});
}

function fnCheckEmpId() {
	var member_emp_no = $.trim($("#m_member_emp_no").val());
	var member_id = $.trim($("#m_member_id").val());
	var postData = "member_emp_no="+encodeURIComponent(member_emp_no)
		+ "&member_id="+encodeURIComponent(member_id);
  var formURL = "/backend/mng_organ/check_member_emp_no";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		if(data.cnt > 0) {
      			$("#fg_check_yn2").val("N");
      			fnMessageModalAlert("Notification(Organ)", "입력하신 사용자 사원번호는 사용할 수 없습니다.(이미 사용중)");
      		} else {
      			$("#fg_check_yn2").val("Y");
      			fnMessageModalAlert("Notification(Organ)", "입력하신 사용자 사원번호는 사용할 수 있습니다.");
      		}
      	} else {
      		fnMessageModalAlert("Notification(Organ)", "입력하신 사용자 사원번호 중복여부를 확인하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Organ)", "입력하신 사용자 사원번호 중복여부를 확인하는데 에러가 발생하였습니다.");	
      }
  });
}

function fnCheckMemberId(){
	var member_id = $.trim($("#m_member_id").val());
	var postData = "member_id="+encodeURIComponent(member_id);
  var formURL = "/backend/mng_organ/check_member_id";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		if(data.cnt > 0) {
      			$("#fg_check_yn").val("N");
      			fnMessageModalAlert("Notification(Organ)", "입력하신 사용자ID는 사용할 수 없습니다.(이미 사용중)");
      		} else {
      			$("#fg_check_yn").val("Y");
      			fnMessageModalAlert("Notification(Organ)", "입력하신 사용자ID는 사용할 수 있습니다.");
      		}
      	} else {
      		fnMessageModalAlert("Notification(Organ)", "입력하신 사용자ID 중복여부를 확인하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Organ)", "입력하신 사용자ID 중복여부를 확인하는데 에러가 발생하였습니다.");	
      }
  });
}

function fnInitMemberPwd(){
	var postData = $("#frm_member").serializeArray();
  var formURL = "/backend/mng_organ/init_member_pwd";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		fnMessageModalAlert("Notification(Organ)", "사용자 패스워드정보가 초기화했습니다.");
      		$("#modal_member").modal('hide');
      	} else {
      		fnMessageModalAlert("Notification(Organ)", "사용자 패스워드정보가 초기화하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Organ)", "사용자 패스워드정보가 초기화하는데 에러가 발생하였습니다.");	
      }
  });
}

function getSelectPosition(obj){
	obj.empty();
	
	var sel_url = "/backend/code/data_codegrid";
	sel_url += "?master_code=" + encodeURIComponent("MC1005");
	
	$.ajax({
    url:sel_url,
    type:'POST',
    dataType: 'json',
    async: false, 
    success: function( data ) {
    	var rows = data.rows;
    	for(var i=0; i<rows.length; i++) {
    		if(i==0) {
    			obj.append($('<option>').text(data.rows[i].code_nm).attr('value', data.rows[i].filter1_val).attr('selected', 'selected'));
    		} else {
    			obj.append($('<option>').text(data.rows[i].code_nm).attr('value', data.rows[i].filter1_val));	
    		}
    	}
    	
    	obj.select2({
    		minimumResultsForSearch: Infinity
			});
    }
	});
}

function fnLoadSubOrganTree(){
	var tree_url = "/backend/mng_organ/data_organ_tree";
	tree_url += '?dept_p_cd=-1';
	tree_url += '&company_cd=' + encodeURIComponent($("#sel_company").val());
	tree_url += '&dept_use_yn=' + encodeURIComponent("Y");
	
	$('#sub_tree_dept').jstree({
		'core' : {
			'animation' : 0,
	    	'check_callback' : true,
		  	'data' : {
		    'url' : tree_url,
		    'method' : "post",
		    'data' : function (node) {
		    	return { 'id' : node.id };
		    }
		  }, 
		  themes : {
				'responsive' : false,
				'stripes' : true,
				"theme": "default",
        		"icons": true,
				'dots': true
			},
			"multiple": false
		},
    plugins : ["search", "types", "themes", "ui", "unique"]
	}).on("select_node.jstree", function(evt, data){
		
// 		selected_dept_cd = data.node.id;
// 	  selected_dept_nm = data.node.text;
	  
// 	  fnSearchOrganMemberGrid(selected_dept_cd);
	  
  }).on('loaded.jstree', function() {
  	var i = 0;
    $.each($("#sub_tree_dept").jstree()._model.data, function (value, index) {
			if (i == 0) {
      	$("#sub_tree_dept").jstree(true).select_node(value, false, false);
        $("#sub_tree_dept").jstree(true).open_node(value);
        return false;
      }  
      i++;
    });
  }).on('activate_node.jstree', function(e, data) {
// 	  if(!data.instance.is_leaf(data.node)) {
// 	  	selected_dept_is_leaf = true;
// 	  } else {
// 	  	selected_dept_is_leaf = false; 
// 	  }
	});
}

function chnDeptModal()
{	
	$('#sub_tree_dept').jstree("destroy").empty();
	fnLoadSubOrganTree();
	
	$("#modal_organ_member").modal('show');	
}

function chnDeptSave()
{
	var org_dept_cd = $("#m_dept_cd").val();
	var org_dept_nm = $("#m_dept_nm").val();
	var member_emp_no = $("#m_member_emp_no").val();
	var member_id = $("#m_member_id").val();
	var member_nm = $("#m_member_nm").val();
	var selc_dept_cd = $('#sub_tree_dept').jstree("get_selected",true)[0].id;
	var selc_dept_nm = $('#sub_tree_dept').jstree("get_selected",true)[0].text;
	
	if(member_emp_no.length == 0 || selc_dept_cd.length == 0 || org_dept_cd.length == 0)
	{
		fnMessageModalAlert("Notification(Organ)", "처음부터 다시 진행해주세요.");
		return;
	}
		
	fnMessageModalConfirm("Confirm(Organ)", "해당 사용자의 조직정보를 변경하시겠습니까?<br/><br/># 사용자 : "+member_nm+"("+member_id+")<br/># 현재 부서 : "+org_dept_nm+" → 변경 부서 : "+selc_dept_nm, function(result){
		if(result) {
			var page_url = "/backend/mng_organ/chnDeptSave";
			var postData = "org_dept_cd=" + encodeURIComponent(org_dept_cd);
			postData += "&selc_dept_cd=" + encodeURIComponent(selc_dept_cd);
			postData += "&member_emp_no=" + encodeURIComponent(member_emp_no);

			$.ajax({
				url : page_url,
				type : 'POST',
				data: postData,
				dataType : 'json',
				success: function(data, textStatus, jqXHR) {
					if (data.status == "200") {
						$("#modal_member").modal('hide');
						$("#modal_organ_member").modal('hide');
						
						fnMessageModalAlert("Notification(Organ)", "저장을 완료했습니다.");
						
						$('#tree_dept').jstree("close_all");
						$('#tree_dept').jstree("deselect_all");
					    $('#tree_dept').jstree(true).select_node(selc_dept_cd);
					    $('#tree_dept').jstree("open_node", selc_dept_cd);
					    
					    	
					} else {
						fnMessageModalAlert("Notification(Organ)", "저장을 실패했습니다.");
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					fnMessageModalAlert("Notification(Organ)", "저장을 실패했습니다.");
				},	
				complete: function () {	
				}
			});   

		}
	});
}
</script>
</body>
</html>