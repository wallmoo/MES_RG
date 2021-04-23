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
		<jsp:param name="selected_menu_p_cd" value="1003" />
		<jsp:param name="selected_menu_cd" value="1008" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1> System Management <small>Acl Management</small> </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> System Management</a></li><li class="active">Acl Management</li>
      </ol>
    </section>

    <section class="content">
      <div class="row">
        <div class="col-md-3">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">역할정보</h3>
            </div>
            <div id="" class="box-body">
            	<div class="row">
			        	<div id="dv_grid_role" class="col-sm-12">
			        		<table id="grid_role"></table>
			        	</div>
			        </div>
            </div>
          </div>
        </div>
        <div class="col-md-9">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">Menu Access Information</h3>
              <div class="box-tools pull-right">
                <div class="form-group" style="width: 60px; padding-top:3px; float: left;">
		          		<label>Menu: </label>
		          	</div>
                <div class="input-group input-group-sm" style="width: 150px;float: left;">
                  <select id="sel_menu_div" class="form-control select2" data-placeholder="메뉴분류선택" style="width: 100%;">
	                  <option value="F">Frontend Menu</option>
	                  <option value="B">Backend Menu</option>
	                </select>
                </div>
                |
                <button type="button" id="btn_acl_save" class="btn btn-danger btn-sm">Menu Access Save</button>
              </div>
            </div>
            <div id="dv_grid_menu_acl" class="box-body">
              <table id="grid_menu_acl"></table>
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
var selected_role_cd;
var selected_role_nm;

$(function($) {
	fnLoadCommonOption();
	fnLoadRoleGrid();
	fnLoadRoleMenuGrid();
})

function fnLoadCommonOption(){
	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
		resizeJqGrid("grid_menu_acl", false);
	}).trigger('resize');
	
	$("#sel_menu_div").select2({
		minimumResultsForSearch: Infinity
	}).on("change", function(e) {
		fnSearchRoleMenuGrid();
  });
	
	$( "#btn_acl_save" ).on('click', function(e) {
		e.preventDefault();
		
		var rolegrid = $("#grid_role");
		var selected_role_cd = rolegrid.jqGrid('getGridParam',"selrow");
		if(selected_role_cd != null) {
			fnMessageModalConfirm("Confirm(Acl)", "선택하신 역할과 메뉴권한 설정정보를 저장하시겠습니까?", function(result){
				if(result) {
					fnSaveAcl();
				}
			});	
		} else {
			fnMessageModalAlert("Notification(Acl)", "역할정보에서 역할을 선택하세요.");
		}
	});
}

function fnLoadRoleGrid(){
	var page_url = "/backend/code/data_codegrid";
	page_url += "?master_code=" + encodeURIComponent("MC1003");
	
	$("#grid_role").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['DCode', 'RoleCd','Role Name','Code(En)','Code_Order', 'Use_Yn', 'Descr', 'filter2', 'filter3'],
		colModel:[
			{name:'detail_code',index:'detail_code', width:50, sorttype:"text", sortable:true, hidden:true, key:true},
			{name:'filter1_val',index:'filter1_val', width:50, sorttype:"text", sortable:true},
			{name:'code_nm',index:'code_nm', sorttype:"text", sortable:true},
			{name:'code_nm_en',index:'code_nm_en', sorttype:"text", sortable:true, hidden:true},
			{name:'code_order',index:'code_order', width:90, sorttype:"int", sortable:true},
			{name:'code_use_yn',index:'code_use_yn', width:40},
			{name:'code_dscr',index:'code_dscr', width:150, sortable:false, hidden:true},
			{name:'filter2_val',index:'filter2_val', width:60, hidden:true},
			{name:'filter3_val',index:'filter3_val', width:60, hidden:true}
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
    autoencode: true,
    loadonce: true,
    sortable: true,
    sortname: "detail_code",
    onSelectRow: function(rowid, selected) {
			if(rowid != null) {
				
				selected_role_cd = $("#grid_role").jqGrid('getRowData', rowid).filter1_val;
				selected_role_nm = $("#grid_role").jqGrid('getRowData', rowid).code_nm;
				
				fnSearchRoleMenuGrid();
			}					
		},
		loadComplete : function() {
		}
	});
}

function fnLoadRoleMenuGrid(){
	var page_url = "/backend/role/data_role_menu_grid";
	page_url += "?role_cd=" + encodeURIComponent((selected_role_cd==undefined?"N/A":selected_role_cd));
	page_url += '&menu_div='+encodeURIComponent($("#sel_menu_div").val());
	page_url += '&menu_use_yn='+encodeURIComponent("Y");
	
	$("#grid_menu_acl").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['RoleCd', 'Role Name', 'Menu Cd', 'Menu Name', 'Management', 'Write_yn','Read_yn','Top Menu CD','메뉴LVL','메뉴하위여부','확장'],
		colModel:[
			{name:'role_cd',index:'role_cd', width:70, sortable:false, hidden:true},
			{name:'role_nm',index:'role_nm', width:90, sortable:false, hidden:true},
			{name:'menu_cd',index:'menu_cd', width:80, sortable:false, hidden:true, key: true},
			{name:'menu_nm',index:'menu_nm', width:300, sortable:false},
			{name:'mng_yn',index:'mng_yn', width:70, sortable:false, editable:true, edittype: 'checkbox', editoptions: {value:"Y:N"}, align:'center'},			
			{name:'write_yn',index:'write_yn', width:70, sortable:false, editable:true, edittype: 'checkbox', editoptions: {value:"Y:N"}, align:'center'},
			{name:'read_yn',index:'read_yn', width:70, sortable:false, editable:true, edittype: 'checkbox', editoptions: {value:"Y:N"}, align:'center'},
			{name:'menu_p_cd',index:'menu_p_cd', width:0, hidden:true},
			{name:'lvl',index:'lvl', width:0, hidden:true},
			{name:'isLeaf',index:'isLeaf', width:0, hidden:true},
			{name:'expanded',index:'expanded', width:0, hidden:true}
		],
		rowNum:10000,
		gridview: true,
		viewrecords: true,
		autowidth : true,
    shrinkToFit: true, 
    multiselect : false,
    height: 550,
    loadonce: true,
    altRows: true,
    loadui: "disable",
    treeGridModel: 'adjacency',
    treeGrid:true,
    ExpandColumn:'menu_nm',
    ExpandColClick: true,
    tree_root_level: 0,
    jsonReader:{
    	repeatitems: false,
      id: "menu_cd",
      root: "rows",
      page: function(obj) { return 1; },
      total: function(obj) { return 1; },
      records: function(obj) { return (obj["rows"] != null?obj["rows"].length : 0); }
    },
    treeReader: {
      level_field: "lvl",
      parent_id_field: "menu_p_cd",
      leaf_field: "isLeaf",
      expanded_field: "expanded"
    },
    gridComplete: function() {
    	
    },
    loadComplete : function() {
    	var ids = $(this).jqGrid('getDataIDs');
      for (var i = 0; i < ids.length; i++) {
      	$(this).jqGrid('editRow',ids[i], {
      		keys:true
      	});
      }
      
      var t = setTimeout(function(){
      	$("#grid_menu_acl").closest(".ui-jqgrid-bdiv").scrollTop(0);
      }, 50);
		}
	});
}

function fnSearchRoleMenuGrid(){
	var page_url = "/backend/role/data_role_menu_grid";
	page_url += "?role_cd=" + encodeURIComponent((selected_role_cd==undefined?"N/A":selected_role_cd));
	page_url += '&menu_div='+encodeURIComponent($("#sel_menu_div").val());
	page_url += '&menu_use_yn='+encodeURIComponent("Y");
	
	$("#grid_menu_acl").jqGrid('setGridParam',{url: page_url,datatype: 'json',treeGrid:true});
	$("#grid_menu_acl").trigger("reloadGrid");
}

function fnSaveAcl(){
	var gridData = $('#grid_menu_acl').jqGrid('getRowData');
  for (var i = 0; i < gridData.length; i++) {     
    $('#grid_menu_acl').jqGrid('saveRow', gridData[i]['menu_cd'], false, 'clientArray');    
  }    
  gridData = $('#grid_menu_acl').jqGrid('getRowData');
  
	var menu_cds = "", mng_yns="", write_yns="", read_yns="";
	for (var i = 0; i < gridData.length; i++) {
		menu_cds += gridData[i].menu_cd + ",";
		mng_yns += gridData[i].mng_yn + ",";
		write_yns += gridData[i].write_yn + ",";
		read_yns += gridData[i].read_yn + ",";
  }
	
	var page_url = "/backend/role/save_menu_acl";
	var postData = "role_cd=" + encodeURIComponent(selected_role_cd);
	postData += '&menu_div='+encodeURIComponent($("#sel_menu_div").val());
	postData += "&menu_cds=" + encodeURIComponent(menu_cds.substring(0, menu_cds.length-1));
	postData += "&mng_yns=" + encodeURIComponent(mng_yns.substring(0, mng_yns.length-1));
	postData += "&write_yns=" + encodeURIComponent(write_yns.substring(0, write_yns.length-1));
	postData += "&read_yns=" + encodeURIComponent(read_yns.substring(0, read_yns.length-1));
	
	$.ajax({
    url: page_url,
    data: postData,
    type: "POST",
    success:function(data, textStatus, jqXHR){
    	if(data.status == "200") {
    		fnMessageModalAlert("Notification(Acl)", "역할별 메뉴권한정보를 저장하였습니다.");
    		fnSearchRoleMenuGrid();
    	} else {
    		fnMessageModalAlert("Notification(Acl)", "역할별 메뉴권한정보를 저장하는데 에러가 발생하였습니다.");	
    	}
    },
    error: function(jqXHR, textStatus, errorThrown){
    	fnMessageModalAlert("Notification(Acl)", "역할별 메뉴권한정보를 저장하는데 에러가 발생하였습니다.");	
    },
    complete: function() {
    }
	});
}
</script>
</body>
</html>