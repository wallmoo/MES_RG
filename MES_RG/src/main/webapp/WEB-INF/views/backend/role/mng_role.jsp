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
		<jsp:param name="menu_div" value="B" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="B" />
		<jsp:param name="selected_menu_p_cd" value="1003" />
		<jsp:param name="selected_menu_cd" value="1007" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1> System Management <small>Role Management</small> </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> System Management</a></li><li class="active">Role Management</li>
      </ol>
    </section>

    <section class="content">
    	<div class="row">
        <div class="col-md-3">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">Role Information</h3>
            </div>
            <div class="box-body">
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
              <h3 class="box-title">Role User Information</h3>
              <div class="box-tools pull-right">
                <div class="input-group input-group-sm" style="width: 150px;float: left;">
                  <input type="text" id="role_member_nm_search" name="role_member_nm_search" class="form-control pull-right" placeholder="Search">
									<div class="input-group-btn">
                    <button type="button" id="btn_role_member_search" class="btn btn-default"><i class="fa fa-search"></i></button>
                  </div>
                </div>
                |
                <button type="button" id="btn_member_role_add" class="btn btn-danger btn-sm">User Role Add</button>
              </div>
            </div>
            <div class="box-body">
            	<div class="row">
		            <div id="dv_grid_role_member" class="col-sm-12">
		              <table id="grid_role_member"></table>
		              <div id="grid_role_member_pager"></div>
		            </div>
            	</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  
  <div class="modal fade" id="modal_organ_member" data-backdrop="static">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
         	<h4 class="modal-title" id="modal_code_title">Organization Chart User Information</h4>
        </div>
        <div class="modal-body" id="modal_code_body">
        	<div class="row">
        		<div class="col-md-12">
        			<div class="box">
        				<div class="box-header with-border">
        					&nbsp;
        					<div class="box-tools pull-right" style="min-height: 40px;">
        						<button type="button" class="btn btn-danger btn-sm pull-right" id="btn_role_member_save" >User Add</button>
		              </div>
        				</div>
        				<div id="" class="box-body">
        					<div class="row">
				        		<div class="col-md-6">
				        			<div class="box box-primary box-solid" style="min-height: 630px;">
						            <div class="box-header with-border">
						              <h3 class="box-title">Organization Information</h3>
						              <div class="box-tools pull-right">
						              </div>
						            </div>
						            <div id="" class="box-body">
						            	<div class="row">
									          <div class="col-sm-3">
									          	<div class="form-group">
									          		<label>Plant</label>
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
									          		<label>Organization</label>
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
													        		<div id="tree_dept" style="min-height: 480px; max-height: 480px;overflow:auto;"></div>
													        	</div>
												        	</div>
											        	</div>
										        	</div>
										        </div>
									        </div>
						            </div>
						          </div>
				        		</div>
				        		<div class="col-md-6">
				        			<div class="box box-primary box-solid" style="min-height: 620px;">
						            <div class="box-header with-border">
						              <h3 class="box-title">User Information</h3>
						              <div class="box-tools pull-right">
						                <div class="input-group input-group-sm" style="width: 150px;float: left;">
						                  <input type="text" id="member_nm_search" name="member_nm_search" class="form-control pull-right" placeholder="Search">
															<div class="input-group-btn">
						                    <button type="button" id="btn_member_search" class="btn btn-default"><i class="fa fa-search"></i></button>
						                  </div>
						                </div>
						              </div>
						            </div>
						            <div id="dv_grid_member" class="box-body" style="min-height: 600px;">
						              <table id="grid_member"></table>
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
	fnLoadRoleUserGrid();
})

function fnLoadCommonOption(){
	
	$(window).bind('resize', function() {
		resizeJqGrid("grid_role", false);
		resizeJqGrid("grid_role_member", false);
		// resizeJqGrid("grid_member", false);
	}).trigger('resize');
	
	$("#role_member_nm_search").pressEnter(function(e) {
		e.preventDefault();
		fnSearchRoleUserGrid(null);
	});	
	
	$( "#btn_role_member_search" ).on('click', function(e) {
		e.preventDefault();
		fnSearchRoleUserGrid(null);
	});
	
	$("#member_nm_search").pressEnter(function(e) {
		e.preventDefault();
		fnSearchOrganMemberGrid(null);
	});
	
	$( "#btn_member_search" ).on('click', function(e) {
		e.preventDefault();
		fnSearchOrganMemberGrid(null);
	});
	
	$( "#btn_member_role_add" ).on('click', function(e) {
		e.preventDefault();
		var role_cd = $("#grid_role").jqGrid('getGridParam',"selrow");
		if(role_cd != null){
			$("#member_nm_search").val("");
			
			$('#tree_dept').jstree("destroy").empty();
			fnLoadOrganTree();
			fnSearchOrganMemberGrid();
			
			$("#modal_organ_member").modal('show');	

		} else {
			fnMessageModalAlert("Notification(Role)", "선택된 Role정보가 없습니다. 역할정보에서 Role정보를 선택하세요.");
		}
	});
	
	$( "#btn_role_member_save" ).on('click', function(e) {
		e.preventDefault();
		var sel_member_id = $("#grid_member").jqGrid('getGridParam',"selrow");
		if(sel_member_id != null){
			fnMessageModalConfirm("Confirm(Role)", "선택한 사용자에게 역할을 부여하시겠습니까?<br/>[주의] 권한노출될 우려가 있으니 신중히 선택하세요.", function(result){
				if(result) {
					fnSaveRoleMember();
				}
			});
			
		} else {
			fnMessageModalAlert("Notification(Role)", "선택된 사용자정보가 없습니다. 사용자정보에서 사용자를 선택하세요.");
		}
	});
	
	getSelectCompany($("#sel_company"), false);
	
	$("#sel_company").select2({
		minimumResultsForSearch: Infinity
	}).on("change", function(e) {
		if(e.target.id == "sel_company") {
			$('#tree_dept').jstree("destroy").empty();
			fnLoadOrganTree();	
		}
  });
	
	fnLoadOrganTreeOption();
	fnLoadOrganTree();
	fnLoadOrganMemberGrid();
}

function fnLoadRoleGrid(){
	var page_url = "/backend/code/data_codegrid";
	page_url += "?master_code=" + encodeURIComponent("MC1003");
	
	$("#grid_role").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['DCode', 'RoleCd','Role Name','Role Code(En)','Code_Order', 'Use_Yn', 'Descr', 'filter2', 'filter3'],
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
		rowNum:1000,
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
				fnSearchRoleUserGrid(selected_role_cd);
			}					
		},
		loadComplete : function() {
			
		}
	});
}

function fnLoadRoleUserGrid(){
	var page_url = "/backend/role/data_role_member_grid";
	page_url += "?role_cd=" + encodeURIComponent((selected_role_cd==undefined?"N/A":selected_role_cd));
	page_url += "&member_nm=" + encodeURIComponent($.trim($("#role_member_nm_search").val()));
	
	$("#grid_role_member").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['RoleCd', 'Role Name', 'Plant Code', 'Plant', 'Department Name', 'User No','User Id','User_Name','Email','Phone','Position','Use_Yn'],
		colModel:[
			{name:'role_cd',index:'role_cd', width:70, sorttype:"text", sortable:true, hidden:true},
			{name:'role_nm',index:'role_nm', width:90, sorttype:"text", sortable:true},
			{name:'company_cd',index:'company_cd', width:80, sorttype:"text", sortable:true, hidden:true},
			{name:'company_nm',index:'company_nm', width:150, sorttype:"text", sortable:true},
			{name:'dept_nm',index:'dept_nm', width:120, sorttype:"text", sortable:true},			
			{name:'member_emp_no',index:'member_emp_no', width:70, sorttype:"text", sortable:true, key: true},
			{name:'member_id',index:'member_id', width:100, sorttype:"text", sortable:true},
			{name:'member_nm',index:'member_nm', width:90, sorttype:"text", sortable:true},
			{name:'member_email',index:'member_email', width:200, sorttype:"text", sortable:true},
			{name:'phone_no',index:'phone_no', width:120, sorttype:"text", sortable:true},
			{name:'position_nm',index:'position_nm', width:100, sorttype:"text", sortable:true},
			{name:'use_yn',index:'use_yn', width:80, sorttype:"text", sortable:true}
		],
		rowNum:20,
		rowList : [ 20, 50, 100 ],
    pager : "#grid_role_member_pager",
    viewrecords : true,
    loadonce: true,
    autowidth : true,
    shrinkToFit: true, 
    multiselect : false,
    height: 550,
		altRows: true,
		rownumbers: true, 
    rownumWidth: 25,
    sortname: 'b.member_nm',
    sortorder: 'asc',
    jsonReader : {
    	root : "list_data",
      records : "records",
      repeatitems : false,
      id : "member_emp_no"
    },
    loadComplete : function() {
		}
	});
}

function fnSearchRoleUserGrid(p_role_cd){
	var page_url = "/backend/role/data_role_member_grid";
	page_url += "?role_cd=" + encodeURIComponent((p_role_cd==undefined?"":p_role_cd));
	page_url += "&member_nm=" + encodeURIComponent($.trim($("#role_member_nm_search").val()));
	
	$("#grid_role_member").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
	$("#grid_role_member").setGridParam({ page: 1 }).trigger("reloadGrid");
}

var selected_dept_cd = "";
var selected_dept_nm = "";

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

function fnLoadOrganMemberGrid(){
	var page_url = "/backend/mng_organ/data_member_grid";
	page_url += "?dept_cd=" + encodeURIComponent((selected_dept_cd==undefined?"N/A":selected_dept_cd));
	page_url += "&company_cd=" + encodeURIComponent($("#sel_company").val());
		
	$("#grid_member").jqGrid({
		url:page_url,
		datatype: "json",
		colNames:['Plant CD','Plant','Department CD','Department','User No','User No','User Name','Email','Phone','Position','Use_yn'],
		colModel:[
			{name:'company_cd',index:'company_cd', width:10, sorttype:"text", sortable:true, hidden:true},
			{name:'company_nm',index:'company_nm', width:120, sorttype:"text", sortable:true, hidden:true},
			{name:'dept_cd',index:'dept_cd', width:10, sorttype:"text", sortable:true, hidden:true},
			{name:'dept_nm_en',index:'dept_nm_en', width:120, sorttype:"text", sortable:true, hidden:true},
			{name:'member_emp_no',index:'member_emp_no', width:70, sorttype:"text", sortable:true, key: true, hidden:true},
			{name:'member_id',index:'member_id', width:100, sorttype:"text", sortable:true},
			{name:'member_nm_en',index:'member_nm_en', width:120, sorttype:"text", sortable:true},
			{name:'member_email',index:'member_email', width:200, sorttype:"text", sortable:true, hidden:true},
			{name:'phone_no',index:'phone_no', width:90, sorttype:"text", sortable:true, hidden:true},
			{name:'position_nm',index:'position_nm', width:80, sorttype:"text", sortable:true},
			{name:'use_yn',index:'use_yn', width:60, sorttype:"text", sortable:true}
		],
		rowNum:10000,
		viewrecords: true,
		width:390,
		fixed: true,
    shrinkToFit: true, 
    multiselect : false,
    height: 550,
		altRows: true,
		rownumbers: true, 
    rownumWidth: 25,
    sortable: true,
    sortname: "member_nm_en",
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

function fnSaveRoleMember(){
	var sel_member_emp_no = $("#grid_member").jqGrid('getGridParam',"selrow");
	var postData = "role_cd=" + encodeURIComponent(selected_role_cd);
	postData += "&member_emp_no=" + encodeURIComponent(sel_member_emp_no);
  var formURL = "/backend/role/save_role";
  
  $.ajax({
      url: formURL,
      type: "POST",
      data: postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		fnMessageModalAlert("Notification(Role)", "선택하신 사용자에게 Role을 부여햇습니다.");
      		fnSearchRoleUserGrid(selected_role_cd);
      		$("#modal_organ_member").modal('hide');
      	} else {
      		fnMessageModalAlert("Notification(Menu)", "선택하신 사용자에게 Role을 부여하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Menu)", "선택하신 사용자에게 Role을 부여하는데 에러가 발생하였습니다.");	
      }
  });
}
</script>

</body>
</html>