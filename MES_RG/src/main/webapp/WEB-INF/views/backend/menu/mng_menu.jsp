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
		<jsp:param name="selected_menu_cd" value="B" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="B" />
		<jsp:param name="selected_menu_p_cd" value="1003" />
		<jsp:param name="selected_menu_cd" value="1006" />
	</jsp:include>

  <div class="content-wrapper">
    <section class="content-header">
      <h1> System Management <small>Menu Management</small> </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> System Management</a></li><li class="active">Menu Management</li>
      </ol>
    </section>

    <section class="content">
      <div class="row">
        <div class="col-md-4">
          <div class="box" style="min-height: 720px;">
            <div class="box-header with-border">
              <h3 class="box-title">Menu Information</h3>
            </div>
            <div id="" class="box-body">
            	<div class="row">
			          <div class="col-sm-3">
			          	<div class="form-group">
			          		<label>Menu Group</label>
			          	</div>
			          </div>
			          <div class="col-sm-9">
			            <div class="form-group">
		                <select id="sel_menu_div" class="form-control select2" data-placeholder="Menu Group Select" style="width: 100%;">
		                  <option value="F">Frontend Menu</option>
		                  <option value="B">Backend Menu</option>
		                </select>
		              </div>
			          </div>
			        </div>
            	<div class="row">
			          <div class="col-sm-3">
			          	<div class="form-group">
			          		<label>Menu Name</label>
			          	</div>
			          </div>
			          <div class="col-sm-9">
			            <div class="form-group">
		                <div class="input-group input-group-sm">
		                  <input type="text" id="search_menu_nm" name="search_menu_nm" class="form-control pull-right" placeholder="Menu Search">
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
							        		<div id="tree_menu" style="min-height: 550px; overflow:auto;"></div>
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
          <div class="box" style="min-height: 745px;">
            <div class="box-header with-border">
              <h3 class="box-title">Menu Information Detail</h3>
              <div class="box-tools pull-right">
                <button type="button" id="btn_menu_add" class="btn btn-warning btn-sm">Menu Add</button>
                <button type="button" id="btn_menu_save" class="btn btn-warning btn-sm">Menu Save</button>
                <button type="button" id="btn_menu_del" class="btn btn-danger btn-sm">Menu Delete</button>
              </div>
            </div>
            <div class="box-body">
              <form id="frm_menu" name="frm_menu" class="form-horizontal">
	            	<input type="hidden" id="menu_cmd" name="cmd">
	            	<input type="hidden" id="menu_type" name="menu_type">
	            	<input type="hidden" id="menu_use_yn" name="menu_use_yn" />
	            	<input type="hidden" id="cnt_child" name="cnt_child" />
	              <div class="box-body">
	                <div class="form-group">
	                  <label for="menu_p_cd" class="col-sm-2 control-label">Top Menu Code</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_p_cd" name="menu_p_cd" class="form-control" placeholder="Menu Parent Code" readonly="readonly">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_p_nm" class="col-sm-2 control-label">Top Menu Name</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_p_nm" name="menu_p_nm" class="form-control" placeholder="Menu Parent Code" readonly="readonly">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_cd" class="col-sm-2 control-label">Menu Code</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_cd" name="menu_cd" class="form-control" placeholder="Menu Code" readonly="readonly">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_div" class="col-sm-2 control-label">Menu Group</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_div" name="menu_div" class="form-control" placeholder="Menu Division" readonly="readonly">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_nm" class="col-sm-2 control-label">Menu Name</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_nm" name="menu_nm" class="form-control" placeholder="Menu Name" maxlength="50">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_nm_en" class="col-sm-2 control-label">Menu_Name(en)</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_nm_en" name="menu_nm_en" class="form-control" placeholder="Menu Name(Eng)" maxlength="50">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="sel_menu_type" class="col-sm-2 control-label">Menu Division</label>
	                  <div class="col-sm-10">
	                  	<select id="sel_menu_type" class="form-control select2" data-placeholder="메뉴구분선택" style="width: 100%;">
			                  <option value="C">CATEGORY</option>
			                  <option value="P">PAGE</option>
			                </select>
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_dscr" class="col-sm-2 control-label">Menu Descr</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_dscr" name="menu_dscr" class="form-control" placeholder="Menu Description" maxlength="100">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_order" class="col-sm-2 control-label">Menu Display</label>
	                  <div class="col-sm-10">
	                    <input type="number" id="menu_order" name="menu_order" class="form-control" placeholder="출력순서" maxlength="4" oninput="maxLengthCheck(this);" />
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_icon" class="col-sm-2 control-label">Menu Icon</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_icon" name="menu_icon" class="form-control" placeholder="Menu Icon" maxlength="100">
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="rdo_menu_use_yn" class="col-sm-2 control-label">Menu Use_Yn</label>
	                  <div class="col-sm-10">
	                  	<label>
			                  <input type="radio" name="rdo_menu_use_yn" class="flat-red" value="Y" checked> Use
			                </label>
			                <label>
			                  <input type="radio" name="rdo_menu_use_yn" class="flat-red" value="N" > No Use
			                </label>
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="menu_path" class="col-sm-2 control-label">Menu LOCATION</label>
	                  <div class="col-sm-10">
	                    <input type="input" id="menu_path" name="menu_path" class="form-control" placeholder="Menu Page Route" maxlength="250">
	                  </div>
	                </div>
	              </div>
	            </form>
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
var selected_menu_cd;
var selected_menu_nm;

$(function($) {
	fnPageLoadOption();
	fnLoadMenuTreeOption();
	fnLoadMenuTree();
});

function fnPageLoadOption(){
	$('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
    checkboxClass: 'icheckbox_flat-green',
    radioClass: 'iradio_flat-green'
  });
	
	$("#sel_menu_div").select2({
		minimumResultsForSearch: Infinity
	}).on("change", function(e) {
    $('#tree_menu').jstree("destroy").empty();
    fnLoadMenuTree();
  });	
	
	$("#sel_menu_type").select2({
		minimumResultsForSearch: Infinity
	});
	
	$("#frm_menu input, #frm_menu select, #frm_menu radio").attr('disabled',true);
	$("#btn_menu_add").attr('disabled',true);
	$("#btn_menu_save").attr('disabled',true);
	$("#btn_menu_del").attr('disabled',true);
	
	$( "#btn_menu_add, #btn_menu_save, #btn_menu_del" ).on('click', function(e) {
		e.preventDefault();
		if(e.target.id == "btn_menu_add"){
			$("#frm_menu input, #frm_menu select, #frm_menu radio").attr('disabled',false);
			$("#frm_menu")[0].reset();
			
			$("#menu_cmd").val("I");
			$("#menu_p_cd").val(selected_menu_cd);
			$("#menu_p_nm").val(selected_menu_nm);
			$("#menu_div").val($("#sel_menu_div").val());
			
		} else if(e.target.id == "btn_menu_save"){
			$("#frm_menu input, #frm_menu select, #frm_menu radio").attr('disabled',false);
			fnSaveMenu();
		} else if(e.target.id == "btn_menu_del"){
			if($.trim($("#menu_cd").val()).length == 0) {
				fnMessageModalAlert("Notification(Menu)", "메뉴를 선택하신후 삭제처리를 할 수 있습니다.");
				return;
			}
			
			if($("#cnt_child").val() > 0) {
				fnMessageModalAlert("Notification(Menu)", "하위메뉴가 존재하면, 삭제하실 수 없습니다.");
				return;
			}
			
			fnMessageModalConfirm("Confirm(Code)", "선택한 메뉴를 삭제하시겠습니까?<br/>[주의] 삭제된 데이터는 복구되지 않습니다.", function(result){
				if(result) {
					$("#menu_cmd").val("D");
					fnDeleteMenu();
				}
			});
		}
	});
}

function fnLoadMenuTreeOption(){
	var to = false;
	$('#search_menu_nm').keyup(function () {
		if(to) { clearTimeout(to); }
		to = setTimeout(function () {
			var v = $('#search_menu_nm').val();
			$('#tree_menu').jstree(true).search(v);
		}, 250);
	});
}

function fnLoadMenuTree(){
	var tree_url = "/backend/mng_menu/data_menu_tree";
	tree_url += '?menu_p_cd=-1';
	tree_url += '&menu_div='+encodeURIComponent($("#sel_menu_div").val());
	
	$('#tree_menu').jstree({
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
		
		selected_menu_cd = data.node.id;
	  selected_menu_nm = data.node.text;
	  
	  $("#frm_menu input, #frm_menu select, #frm_menu radio").attr('disabled',false);
	  $("#btn_menu_add").attr('disabled',false);
		$("#btn_menu_save").attr('disabled',false);
		$("#btn_menu_del").attr('disabled',false);
	  
	  fnLoadMenuInfo();
  }).on('loaded.jstree', function() {
  	var i = 0;
    $.each($("#tree_menu").jstree()._model.data, function (value, index) {
			if (i == 0) {
      	$("#tree_menu").jstree(true).select_node(value, false, false);
        $("#tree_menu").jstree(true).open_node(value);
        return false;
      }  
      i++;
    });
  });
}

function fnLoadMenuInfo(){
	var tree_url = "/backend/mng_menu/data_menu_info";
	var param = 'menu_cd=' + encodeURIComponent(selected_menu_cd);
	param += '&menu_div=' + encodeURIComponent($("#sel_menu_div").val());
	
	$.ajax({
		url : tree_url,
		data : param,
		type : "POST",
		dataType : 'json',
		success : function(data) {
			var menu_data = data.data;
			$("#menu_cmd").val("U");
			$("#menu_p_cd").val(menu_data.menu_p_cd);
			$("#menu_p_nm").val(menu_data.menu_p_nm);
			$("#menu_div").val(menu_data.menu_div);
			$("#menu_type").val(menu_data.menu_type);
			$("#menu_cd").val(menu_data.menu_cd);
			$("#menu_nm").val(menu_data.menu_nm);
			$("#menu_nm_en").val(menu_data.menu_nm_en);
			$("#menu_dscr").val(menu_data.menu_dscr);
			$("#menu_order").val(menu_data.menu_order);
			$("#menu_icon").val(menu_data.menu_icon);
			$("#menu_path").val(menu_data.menu_path);
			$("#menu_use_yn").val(menu_data.menu_use_yn);
			$("#sel_menu_type").val(menu_data.menu_type).trigger('change');
			$(':radio[name="rdo_menu_use_yn"][value="'+menu_data.menu_use_yn+'"]').iCheck('check');
			$(':radio[name="rdo_menu_use_yn"]').iCheck('update');
			$("#cnt_child").val(menu_data.cnt_child);
			
		}
	});
}

function fnSaveMenu(){
	if($.trim($("#menu_nm").val()).length == 0 || $.trim($("#menu_nm_en").val()).length == 0) {
		fnMessageModalAlert("Notification(Menu)", "메뉴명을 입력하세요.(영문명포함)");
		return;
	}
	
	if($.trim($("#menu_order").val()).length != 4) {
		fnMessageModalAlert("Notification(Menu)", "메뉴출력순서를 4자리를 입력하세요.");
		return;
	}
	$("#menu_type").val($("#sel_menu_type").val());
	$("#menu_use_yn").val($(':radio[name="rdo_menu_use_yn"]:checked').val());
	
	var postData = $("#frm_menu").serializeArray();
  var formURL = "/backend/menu/save_menu";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		fnMessageModalAlert("Notification(Menu)", "입력하신 메뉴를 저장하였습니다.");
      		$('#tree_menu').jstree("destroy").empty();
          fnLoadMenuTree();
          
          $("#frm_menu input, #frm_menu select, #frm_menu radio").attr('disabled',false);
    			$("#frm_menu")[0].reset();
      	} else {
      		fnMessageModalAlert("Notification(Menu)", "메뉴를 저장하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("Notification(Menu)", "메뉴를 저장하는데 에러가 발생하였습니다.");	
      }
  });
}

function fnDeleteMenu(){
	
	var postData = $("#frm_menu").serializeArray();
  var formURL = "/backend/menu/del_menu";
  
  $.ajax({
    url : formURL,
    type: "POST",
    data : postData,
    success:function(data, textStatus, jqXHR){
    	if(data.status == "200") {
    		fnMessageModalAlert("Notification(Menu)", "메뉴를 삭제하였습니다.");
    		$('#tree_menu').jstree("destroy").empty();
        fnLoadMenuTree();
        
        $("#frm_menu input, #frm_menu select, #frm_menu radio").attr('disabled',false);
  			$("#frm_menu")[0].reset();
    	} else {
    		fnMessageModalAlert("Notification(Menu)", "메뉴를 삭제하는데 에러가 발생하였습니다.");	
    	}
    },
    error: function(jqXHR, textStatus, errorThrown){
      fnMessageModalAlert("Notification(Menu)", "메뉴를 삭제하는데 에러가 발생하였습니다.");	
    }
  });
}
</script>
</body>
</html>