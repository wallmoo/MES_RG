<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Set | Backend</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>

<body class="hold-transition skin-black sidebar-mini">

<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="B" />
		<jsp:param name="selected_menu_p_cd" value="1017" />
		<jsp:param name="selected_menu_cd" value="1018" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1> 부가정보관리 <small>공지사항관리</small> </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 부가정보관리</a></li><li class="active">공지사항관리</li>
      </ol>
    </section>

    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">마스터코드</h3>
              <div class="box-tools pull-right">
                <div class="input-group input-group-sm" style="width: 150px;float: left;">
                  <input type="text" id="mcode_search" name="mcode_search" class="form-control pull-right" placeholder="Search">
									<div class="input-group-btn">
                    <button type="button" id="btn_mcode_search" class="btn btn-default"><i class="fa fa-search"></i></button>
                  </div>
                </div>
                |
                <button type="button" id="btn_mcode_add" class="btn btn-danger btn-sm">코드추가</button>
                <button type="button" id="btn_mcode_info" class="btn btn-warning btn-sm">코드상세</button>
              </div>
            </div>
            <div id="dv_grid_mcode" class="box-body">
            	<table id="grid_mcode"></table>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  
  <div class="modal fade" id="modal_mcode" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_code_title">시스템 공통코드관리</h4>
        </div>
        <div class="modal-body" id="modal_code_body">
          <div class="box box-warning box-solid">
            <div class="box-header with-border">
              <h3 class="box-title">마스터 코드정보</h3>
              <div class="box-tools pull-right">
	              <button type="button" id="btn_mcode_save" class="btn btn-success btn-sm">코드저장</button>
	              <button type="button" id="btn_mcode_del" class="btn btn-danger btn-sm">코드삭제</button>
              </div>
            </div>

            <form id="frm_mcode" name="frm_mcode" class="form-horizontal">
            	<input type="hidden" id="m_cmd" name="cmd">
            	<input type="hidden" id="m_code_use_yn" name="code_use_yn" />
              <div class="box-body">
                <div class="form-group">
                  <label for="master_code" class="col-sm-3 control-label">마스터코드</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_master_code" name="master_code" class="form-control" placeholder="Code ID" readonly="readonly">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_nm" class="col-sm-3 control-label">코드명</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_code_nm" name="code_nm" class="form-control" placeholder="Code Name" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_nm_en" class="col-sm-3 control-label">코드명(영문)</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_code_nm_en" name="code_nm_en" class="form-control" placeholder="Code Name(Eng)" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_dscr" class="col-sm-3 control-label">코드설명</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_code_dscr" name="code_dscr" class="form-control" placeholder="Code Description" maxlength="100">
                  </div>
                </div>
                <div class="form-group">
                  <label for="code_order" class="col-sm-3 control-label">코드출력순서</label>
                  <div class="col-sm-9">
                    <input type="number" id="m_code_order" name="code_order" class="form-control" placeholder="출력순서" maxlength="4" oninput="maxLengthCheck(this);" />
                  </div>
                </div>
                <div class="form-group">
                  <label for="rdo_mcode_use_yn" class="col-sm-3 control-label">코드사용여부</label>
                  <div class="col-sm-9">
                  	<label>
		                  <input type="radio" name="rdo_mcode_use_yn" class="flat-red" value="Y" checked> 사용
		                </label>
		                <label>
		                  <input type="radio" name="rdo_mcode_use_yn" class="flat-red" value="N" > 미사용
		                </label>
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter1_val" class="col-sm-3 control-label">확장필드01</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_filter1_val" name="filter1_val" class="form-control" placeholder="Expand Filed01" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter2_val" class="col-sm-3 control-label">확장필드02</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_filter2_val" name="filter2_val" class="form-control" placeholder="Expand Filed02" maxlength="20">
                  </div>
                </div>
                <div class="form-group">
                  <label for="filter3_val" class="col-sm-3 control-label">확장필드03</label>
                  <div class="col-sm-9">
                    <input type="input" id="m_filter3_val" name="filter3_val" class="form-control" placeholder="Expand Filed03" maxlength="20">
                  </div>
                </div>
              </div>
            </form>
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
<script type="text/javascript">
$(function($) {
	fnLoadCommonOption();
	fnLoadMasterCodeGrid();
})

function fnLoadCommonOption(){
	$('input[type="radio"].flat-red').iCheck({
    checkboxClass: 'icheckbox_flat-green',
    radioClass: 'iradio_flat-green',
    handle: 'radio'
  });
	
	$("#mcode_search, #dcode_search").pressEnter(function(e) {
		e.preventDefault();
		if(e.target.id == "mcode_search"){
			fnSearchMasterCodeGrid();
		} else if(e.target.id == "dcode_search"){
			var grid = $("#grid_mcode");
			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
			fnSearchDetailCodeGrid(selected_master_code);
		}
	});
	
	$( "#btn_mcode_search, #btn_dcode_search" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "mcode_search"){
			fnSearchMasterCodeGrid();
		} else if(e.target.id == "dcode_search"){
			var grid = $("#grid_mcode");
			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
			fnSearchDetailCodeGrid(selected_master_code);
		}
	});
	
	$( "#btn_mcode_add, #btn_dcode_add" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_mcode_add"){
			$("form").each(function() {  
        if(this.name == "frm_mcode") {
        	this.reset();
        	$("#m_code_order").val("9999");
        }  
     	});  
			$("#btn_mcode_del").prop("disabled", true);
			$("#m_cmd").val("insert.master_code");
			
			$("#modal_mcode").modal('show');	
		} else if(e.target.id == "btn_dcode_add"){
			
			var rowId = $("#grid_mcode").jqGrid('getGridParam',"selrow");
			if(rowId == null) {
				fnMessageModalAlert("Notification(Code)", "마스터 코드를 선택하세요.");
				return;
			}
			
			$("form").each(function() {  
        if(this.name == "frm_dcode") {
        	this.reset();
        	$("#d_code_order").val("9999");
        	$("#d_master_code").val(rowId);
        }  
     	});
			$("#btn_dcode_del").prop("disabled", true);
			$("#d_cmd").val("insert.detail_code");
			
			$("#modal_dcode").modal('show');
		}
	});
	
	$( "#btn_mcode_info, #btn_dcode_info" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_mcode_info"){
			
			var m_grid = $("#grid_mcode");
			var m_rowid = m_grid.jqGrid('getGridParam',"selrow");
			if(m_rowid == null) {
				fnMessageModalAlert("Notification(Code)", "마스터 코드를 선택하세요.");
				return;
			}
			
			$("#m_master_code").val(m_grid.jqGrid('getCell', m_rowid, 'master_code'));
			$("#m_code_nm").val(m_grid.jqGrid('getCell', m_rowid, 'code_nm'));
			$("#m_code_nm_en").val(m_grid.jqGrid('getCell', m_rowid, 'code_nm_en'));
			$("#m_code_order").val(m_grid.jqGrid('getCell', m_rowid, 'code_order'));
			$("#m_code_dscr").val(m_grid.jqGrid('getCell', m_rowid, 'code_dscr'));
			$("#m_code_use_yn").val(m_grid.jqGrid('getCell', m_rowid, 'code_use_yn'));
			$("#m_filter1_val").val(m_grid.jqGrid('getCell', m_rowid, 'filter1_val'));
			$("#m_filter2_val").val(m_grid.jqGrid('getCell', m_rowid, 'filter2_val'));
			$("#m_filter3_val").val(m_grid.jqGrid('getCell', m_rowid, 'filter3_val'));
			
			$(':radio[name="rdo_mcode_use_yn"][value="'+m_grid.jqGrid('getCell', m_rowid, 'code_use_yn')+'"]').iCheck('check');
			$(':radio[name="rdo_mcode_use_yn"]').iCheck('update');
			
			$("#m_cmd").val("update.master_code");
			$("#btn_mcode_del").prop("disabled", false);
			
			$("#modal_mcode").modal('show');
		} else if(e.target.id == "btn_dcode_info"){
			
			var d_grid = $("#grid_dcode");
			var d_rowid = d_grid.jqGrid('getGridParam',"selrow");
			if(d_rowid == null) {
				fnMessageModalAlert("Notification(Code)", "디테일 코드를 선택하세요.");
				return;
			}
			
			$("#d_master_code").val(d_grid.jqGrid('getCell', d_rowid, 'master_code'));
			$("#d_detail_code").val(d_grid.jqGrid('getCell', d_rowid, 'detail_code'));
			$("#d_code_nm").val(d_grid.jqGrid('getCell', d_rowid, 'code_nm'));
			$("#d_code_nm_en").val(d_grid.jqGrid('getCell', d_rowid, 'code_nm_en'));
			$("#d_code_order").val(d_grid.jqGrid('getCell', d_rowid, 'code_order'));
			$("#d_code_dscr").val(d_grid.jqGrid('getCell', d_rowid, 'code_dscr'));
			$("#d_code_use_yn").val(d_grid.jqGrid('getCell', d_rowid, 'code_use_yn'));
			$("#d_filter1_val").val(d_grid.jqGrid('getCell', d_rowid, 'filter1_val'));
			$("#d_filter2_val").val(d_grid.jqGrid('getCell', d_rowid, 'filter2_val'));
			$("#d_filter3_val").val(d_grid.jqGrid('getCell', d_rowid, 'filter3_val'));
			
			$(':radio[name="rdo_dcode_use_yn"][value="'+m_grid.jqGrid('getCell', d_rowid, 'code_use_yn')+'"]').iCheck('check');
			$(':radio[name="rdo_dcode_use_yn"]').iCheck('update');
			
			$("#d_cmd").val("update.detail_code");
			$("#btn_dcode_del").prop("disabled", false);
			
			$("#modal_dcode").modal('show');
		}
	});
	
	$( "#btn_mcode_save, #btn_dcode_save" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_mcode_save"){
			if($.trim($("#m_code_nm").val()).length == 0 || $.trim($("#m_code_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Code)", "코드명을 입력하세요.(영문코드포함)");
				return;
			}
			
			if($.trim($("#m_code_order").val()).length != 4) {
				fnMessageModalAlert("Notification(Code)", "코드출력순서를 4자리를 입력하세요.");
				return;
			}
			$("#m_code_use_yn").val($(':radio[name="rdo_mcode_use_yn"]:checked').val());

			fnSaveCode("frm_mcode");
		} else if(e.target.id == "btn_dcode_save"){
			
			if($.trim($("#d_code_nm").val()).length == 0 || $.trim($("#d_code_nm_en").val()).length == 0) {
				fnMessageModalAlert("Notification(Code)", "코드명을 입력하세요.(영문코드포함)");
				return;
			}
			
			if($.trim($("#d_code_order").val()).length != 4) {
				fnMessageModalAlert("Notification(Code)", "코드출력순서를 4자리를 입력하세요.");
				return;
			}
			$("#d_code_use_yn").val($(':radio[name="rdo_dcode_use_yn"]:checked').val());
			fnSaveCode("frm_dcode");
		}
	});	
	
	$( "#btn_mcode_del, #btn_dcode_del" ).on('click', function(e) {
		e.preventDefault();
		
		if(e.target.id == "btn_mcode_del"){
			fnMessageModalConfirm("Confirm(Code)", "마스터코드를 삭제하시겠습니까?<br/>[주의] 삭제된 데이터는 복구되지 않습니다.<br/>[주의] 마스터 하위코드들도 삭제처리 됩니다.", function(result){
				if(result) {
					$("#m_cmd").val("delete.master_code");
					fnDeleteCode("frm_mcode");
				}
			});
			
		} else if(e.target.id == "btn_dcode_del"){
			fnMessageModalConfirm("Confirm(Code)", "디테일코드를 삭제하시겠습니까?<br/>[주의] 삭제된 데이터는 복구되지 않습니다.", function(result){
				if(result) {
					$("#d_cmd").val("delete.detail_code");
					fnDeleteCode("frm_dcode");
				}
			});
		}
	});	
}

function fnLoadMasterCodeGrid(){
	var page_url = "/backend/code/data_codegrid";
	page_url += "?code_nm=" + encodeURIComponent($("#mcode_search").val());
	
	$("#grid_mcode").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['MCode','코드명', '코드명(En)','출력순서', '사용여부', '설명', '', '', ''],
		colModel:[
			{name:'master_code',index:'master_code', width:50, sorttype:"text", sortable:true, key: true},
			{name:'code_nm',index:'code_nm', sorttype:"text", sortable:true},
			{name:'code_nm_en',index:'code_nm_en', sorttype:"text", sortable:true, hidden:true},
			{name:'code_order',index:'code_order', width:90, sorttype:"int", sortable:true},
			{name:'code_use_yn',index:'code_use_yn', width:40},
			{name:'code_dscr',index:'code_dscr', width:150},
			{name:'filter1_val',index:'filter1_val', hidden:true},
			{name:'filter2_val',index:'filter2_val', hidden:true},
			{name:'filter3_val',index:'filter3_val', hidden:true}
		],
		rowNum:-1,
		viewrecords : true,
    autowidth : true,
    shrinkToFit: true, 
    multiselect : false,
    height: 550,
		altRows: true,
		rownumbers: true, 
    rownumWidth: 25, 
		onSelectRow: function(rowid, selected) {
			if(rowid != null) {
				fnSearchDetailCodeGrid(rowid);
			}					
		},
		loadComplete : function() {
		}
	});
}

function fnSearchMasterCodeGrid(){
	var page_url = "/backend/code/data_codegrid";
	page_url += "?code_nm=" + encodeURIComponent($("#mcode_search").val());
	
	$("#grid_mcode").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_mcode").trigger("reloadGrid");
}

function fnSaveCode(frm_name){
	var postData = $("#"+frm_name).serializeArray();
  var formURL = "/backend/code/save_code";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		fnMessageModalAlert("Notification(Code)", "입력하신 코드를 저장하였습니다.");
      		if(data.division == "master") {
      			fnSearchMasterCodeGrid();	
      			$("#modal_mcode").modal('hide');
      		} else {
      			var grid = $("#grid_mcode");
      			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
      			fnSearchDetailCodeGrid(selected_master_code);
      			$("#modal_dcode").modal('hide');
      		}
      	} else {
      		fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Code)", "코드를 저장하는데 에러가 발생하였습니다.");	
      }
  });
}

function fnDeleteCode(frm_name){
	var postData = $("#"+frm_name).serializeArray();
  var formURL = "/backend/code/del_code";
  
  $.ajax({
    url : formURL,
    type: "POST",
    data : postData,
    success:function(data, textStatus, jqXHR){
    	if(data.status == "200") {
    		fnMessageModalAlert("Notification(Code)", "코드를 삭제하였습니다.");
    		if(data.division == "master") {
    			fnSearchMasterCodeGrid();
    			$("#modal_mcode").modal('hide');
    		} else {
    			var grid = $("#grid_mcode");
    			var selected_master_code = grid.jqGrid('getGridParam',"selrow");
    			fnSearchDetailCodeGrid(selected_master_code);
    			$("#modal_dcode").modal('hide');
    		}
    	} else {
    		fnMessageModalAlert("Notification(Code)", "코드를 삭제하는데 에러가 발생하였습니다.");	
    	}
    },
    error: function(jqXHR, textStatus, errorThrown){
      fnMessageModalAlert("Notification(Code)", "코드를 삭제하는데 에러가 발생하였습니다.");	
    }
  });
}
</script>
</body>
</html>