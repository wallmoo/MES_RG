<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.vieworks.vlicense.util.*"%>
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
		<jsp:param name="selected_menu_p_cd" value="1003" />
		<jsp:param name="selected_menu_cd" value="1057" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1> 시스템관리 <small>로그관리</small> </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 시스템관리</a></li><li class="active">로그관리</li>
      </ol>
    </section>

    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">연동로그정보</h3>
              <div class="box-tools">
              	<button id="btn_log_status_export" class="btn btn-default btn-sm pull">Export</button>
              	<button id="btn_log_status_search" class="btn btn-default btn-sm pull">조회</button>
              </div>
            </div>
            <div id="dv_grid_log_status" class="box-body">
            	<div class="box-tools" style="padding-bottom: 5px;">
              	<div class="row">
              		<div class="col-md-3">
              			<label>| Action 일자</label><br/>
              			<input type="text" class="form-control pull-right" id="log_date">
              		</div>
					<div class="col-md-3">
						<label>| Action 구분</label><br/>
						<select id="sel_batch_type" name="sel_batch_type" class="form-control select2" data-placeholder="Action 구분선택...">
							<option value="">전체</option>
							<option value="PR">생산</option>
							<option value="HR">인사연동</option>
							<option value="MA">SAP 마스터</option>
							<option value="I/F">SAP I/F</option>
						</select>
					</div>
					<div class="col-md-3">
						<label>| Action 주체</label><br/>
							<select id="sel_batch_action" name="sel_batch_action" class="form-control select2" data-placeholder="Action 주체선택...">
								<option value="">전체</option>
								<option value="S">시스템</option>
								<option value="U">사용자</option>
							</select>
					</div>
									
					<div class="col-md-3">
						<label>| Action Status</label><br/>
						<select id="sel_batch_result" name="sel_batch_result" class="form-control select2" data-placeholder="Status선택...">
							<option value="">전체</option>
							<option value="S">성공</option>
							<option value="F">실패</option>
						</select>
					</div>
				</div>
				
				<div class="row">
              		<div class="col-md-3">
              			<label>| Source</label><br/>
              			<input type="text" class="form-control pull-right" id="log_source">
              		</div>
					<div class="col-md-3">
						<label>| Target</label><br/>
						<input type="text" class="form-control pull-right" id="log_target">
					</div>
				</div>
				
				
              </div>
            	<table id="grid_log_status"></table>
            	<div id="pager_grid_log_status" ></div>
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
</div>
<script type="text/javascript">
$(function($) {
	fnLoadCommonOption();
	fnLoadLogStatusGrid();
})

function fnLoadCommonOption(){
	
	
	$("#sel_batch_type, #sel_batch_action, #sel_batch_result").SumoSelect({
		search: false, 
		searchText: 'Search...',
		selectAll: false,
		forceCustomRendering: true
	});
	// date range picker??
	$('#log_date').daterangepicker({
		locale: {
      format: 'YYYY.MM.DD'
    },
    startDate: getTodayDate(),
    endDate: getTodayDate()
	});
	
	$( "#btn_log_status_search" ).on('click', function(e) {
		e.preventDefault();
		fnSearchLogStatusGrid();
	});
	
	$( "#btn_log_status_export" ).on('click', function(e) {
		e.preventDefault();
		fnExportExcel();
	});
}
// Auto Load logStatusGrid
function fnLoadLogStatusGrid(){
	var page_url = "/backend/log/data_log_status_grid";
	page_url += "?batch_type=" + encodeURIComponent($("#sel_batch_type").val());
	page_url += "&batch_action=" + encodeURIComponent($("#sel_batch_action").val());
	page_url += "&batch_result=" + encodeURIComponent($("#sel_batch_result").val());
	page_url += "&batch_start_dt=" + encodeURIComponent($('#log_date').data('daterangepicker').startDate.format('YYYYMMDD'));
	page_url += "&batch_end_dt=" + encodeURIComponent($('#log_date').data('daterangepicker').endDate.format('YYYYMMDD'));
	
	$("#grid_log_status").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['로그번호','Action Type','Action 주체', 'Action 처리자','Source', 'Target', '시작일시','종료일시', 'INSERT수', 'UPDATE수', '결과', '설명'],
		colModel:[
			{name:'batch_log_no',index:'batch_log_no', width:60, key:true},
			{name:'batch_type',index:'batch_type',width:80},
			{name:'batch_action',index:'batch_action',width:70},
			{name:'update_nm',index:'update_nm',width:80},
			{name:'batch_source_ds',index:'batch_action',width:180},
			{name:'batch_target_ds',index:'batch_action',width:180},
			{name:'batch_start_dt',index:'batch_start_dt',width:130},
			{name:'batch_end_dt',index:'batch_end_dt',width:130},
			{name:'batch_process_icnt',index:'batch_process_icnt', width:80, hidden:true},
			{name:'batch_process_icnt',index:'batch_process_ucnt', width:80, hidden:true},
			{name:'batch_result',index:'batch_result', width:80},
			{name:'batch_description',index:'batch_description', width:300}
		],
		rowNum:20,
		rowList : [ 20, 50, 100 ],
		pager : "#pager_grid_log_status",
		viewrecords : true,
	    autowidth : true,
	    shrinkToFit: true, 
	    multiselect : false,
	    loadonce : true,
	    height: 550,
		altRows: true,
		rownumbers: true, 
	    rownumWidth: 25,
	    onSelectRow: function(rowid, selected) {
			if(rowid != null) {
// 				fnSearchDetailCodeGrid(rowid);
			}					
		},
		loadComplete : function() {
		}
	});
}
// Search LogStatusGrid
function fnSearchLogStatusGrid(){
	var page_url = "/backend/log/data_log_status_grid";
	page_url += "?batch_type=" + encodeURIComponent($("#sel_batch_type").val());
	page_url += "&batch_action=" + encodeURIComponent($("#sel_batch_action").val());
	page_url += "&batch_result=" + encodeURIComponent($("#sel_batch_result").val());
	page_url += "&batch_start_dt=" + encodeURIComponent($('#log_date').data('daterangepicker').startDate.format('YYYYMMDD'));
	page_url += "&batch_end_dt=" + encodeURIComponent($('#log_date').data('daterangepicker').endDate.format('YYYYMMDD'));
	page_url += "&batch_source_ds=" + encodeURIComponent($('#log_source').val());
	page_url += "&batch_target_ds=" + encodeURIComponent($('#log_target').val());
	
	
	$("#grid_log_status").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_log_status").setGridParam({ page: 1 }).trigger("reloadGrid");
}

function fnExportExcel(){
	
	var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
	var is_rownum = $("#grid_log_status").jqGrid('getGridParam','rownumbers');
	var colNames = $("#grid_log_status").jqGrid('getGridParam','colNames');
	var colModels = $("#grid_log_status").jqGrid('getGridParam','colModel');
	if(colModels != null && colModels.length > 0){
		for(var i=0; i<colModels.length; i++){
			if(i==0 && is_rownum) {
				param_col_name = "No"
				param_col_id = "rownum";
				param_col_align = "center";
				param_col_width = "80";
			} else if(i==0 && !colModels[i].hidden){
				param_col_name = colNames[i];
				param_col_id = colModels[i].name;
				param_col_align = (colModels[i].align==undefined?"left":colModels[i].align);
				param_col_width = (colModels[i].width==undefined?"80":colModels[i].width);
			} else if(!colModels[i].hidden){
				param_col_name += "," + colNames[i];
				param_col_id += "," + colModels[i].name;
				param_col_align += "," + (colModels[i].align==undefined?"left":colModels[i].align);
				param_col_width += "," + (colModels[i].width==undefined?"80":colModels[i].width);
			}
		}
	}
	var export_url = "/export/export_server_jqgrid";
	var export_data = "file_name="+encodeURIComponent("TEST.xlsx");
	export_data += "&sheet_title="+encodeURIComponent("TEST");
	export_data += "&sheet_name="+encodeURIComponent("TEST");
	export_data += "&header_col_names="+encodeURIComponent(param_col_name);
	export_data += "&header_col_names="+encodeURIComponent(param_col_name);
	export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
	export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
	export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
	export_data += "&cmd="+encodeURIComponent("report01");
	
	$.ajax({
	  url:export_url,
	  data:export_data,
	  type:'POST',
	  dataType: 'json',
	  success: function( data ) {
	  	if(data.status == 200) {
	  		var file_path = data.file_path;
	  		var file_name = data.file_name;
	  		var protocol = jQuery(location).attr('protocol');
  			var host = jQuery(location).attr('host');
  			var link_url = "/file/attach_download";
  			link_url += "?file_path="+encodeURIComponent(file_path);
  			link_url += "&file_name="+encodeURIComponent(file_name);
  			
  			$(location).attr('href', link_url);
	  	}
	  },
		complete: function () {
		}
	});
}
</script>
</body>
</html>