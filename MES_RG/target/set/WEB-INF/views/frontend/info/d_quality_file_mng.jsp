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
		<jsp:param name="selected_menu_p_cd" value="1043" />
		<jsp:param name="selected_menu_cd" value="1080" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			품질 측정 포인트 이미지 등록 <small> 도면 관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>도면 관리</a></li>
			<li class="active">품질 측정 포인트 이미지 등록</li>
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
												<button type="button"   onclick="openMod('upd');" class="btn btn-primary btn-sm"  >수정</button>
												<button type="button"   onclick="loadList();" class="btn btn-warning  btn-sm"  >조회</button>	 
											</div>
										</div>
										<div class="box-body">
											<div class="row">
												<div class="form-group">
													<div class="col-sm-4">
														<label>P/N</label> <input type="text" id="item_code"  class="form-control input-sm" placeholder="P/N"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-4">
														<label>품명</label> <input type="text" id="item_nm"  class="form-control input-sm" placeholder="품명"
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
					<input type="hidden" id="upload_mode"/>

					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">P/N</label>
						<div class="col-sm-8">
							<input type="text" class="form-control input-sm pull-right" id="m_item_code" >
						</div>
					</div>
					<div class="form-group row">
						<label for="" class="col-sm-3 control-label ">품명</label>
						<div class="col-sm-8">
							<input type="text" class="form-control input-sm pull-right" id="m_item_nm" >
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


$(function($) {
	
	requestItem();
	loadGrid();
 	fnLoadFileHandler();
 	
 	loadList();
 	
})

// //품명,품번 자동완성
// $("#item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('item_nm key_up : '+ value);
		
// 		getItemInfo2('nm',value);
// 		return value
// 	});
	
// },400));

// $("#item_code").change(
		
// 		_.debounce(function(event) 
// 		{
	
// 			var item_code = $("#item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('item_code key_up : '+ value);
				
// 				getItemInfo2('cd',value);
// 				return value
// 			});
	
// },400));

// function getItemInfo2(type, value)
// {
// 	console.log('getItemInfo() : ' + value);
// 	var result = "";
// 	if(type == 'cd')
// 	{
// 		$.each(rowArr, function(idx, row){
			
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
		
// 		$.each(rowArr, function(idx, row){
			
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

$('#close_mod').on('click',function(){
	location.reload();
})

var curFile = null;

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
        multiSelect: false,
        columns: [                
        	{ field:'item_code', caption:'P/N', style:'text-align:center', sortable: true},
        	{ field:'item_nm', caption:'품명', style:'text-align:center', sortable: true}	,
			{ field:'down_file', caption:'첨부 파일명', style:'text-align:left', sortable: true}
			], 
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function(){
				var key = w2ui.grid_list.getSelection();
				var data = w2ui.grid_list.get(key[0]);
			}
			 
		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
		}
	});
}
// $("#item_nm").change(_.debounce(function(event) {
	
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
	
	
	
// 	function getItemInfo(type, value)
// 	{
		
// 		console.log('getItemInfo() : ' + value);
// 		var result = "";
// 		if(type == 'cd')
// 		{
// 			$.each(gridDataArr, function(idx, row){
				
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
			
// 			$.each(gridDataArr, function(idx, row){
				
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
var gridDataArr;
// select main list
function loadList() {
	var page_url = "/frontend/qualityfile/selectQualityFile";
	
	var item_code = $('#item_code').val();
	var item_nm = $('#item_nm').val();
	var postData = {

			item_code : item_code,
			item_nm : item_nm

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
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
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
			
			
		}, complete: function(){
			
			w2ui.grid_list.selectNone();
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
	
			
			
		}
	})
}


function openMod(mode){
	
	curFile = null;

	$('#m_item_code').attr('disabled', false);
	$('#m_item_nm').attr('disabled', false);
	$('#mod_file_name').attr('disabled', false);
	
	$('#upload_mode').val(mode);

	
	if('upd' == mode){

		$('#m_item_code').attr('disabled', true);
		$('#m_item_nm').attr('disabled', true);
		$('#mod_file_name').attr('disabled', true);

		var recids = w2ui.grid_list.getSelection();
		if(recids.length != 1){
			fnMessageModalAlert("알림", "수정 하실 파일 정보를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
			return false;
		}
		
		var pdata = w2ui.grid_list.get(recids[0]);
		
		$('#m_item_code').val(pdata.item_code);
		$('#m_item_nm').val(pdata.item_nm);
		
		if(pdata.file_name == null || pdata.file_name == 'null')
		{
			$("#mod_file_name").val('');
		}else{
			$("#mod_file_name").val(pdata.file_name);
		}
		
	} else if('ins' == mode){
		$('#m_item_code').val('');
		$('#m_item_nm').val('');
		$('#mod_input_file_name').val('');
	}
	
	$('#ins_mod').modal('show');
}


function insFile() {
	
	var item_code = $('#m_item_code').val() || '';
	var item_nm = $('#m_item_nm').val() || '';
	var file_name = $('#mod_file_name').val() || '';

	if(item_nm == '' || item_nm == null){
		fnMessageModalAlert("알림", "품명을 입력해주세요.");
		return;
	}
	
	if(item_code == '' || item_code == null){
		fnMessageModalAlert("알림", "없는 제품입니다. 등록 후 이용해주세요");
		return;
	}
	
	fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
		if(chk){
			
			if(curFile){
				curFile.submit();
			} else 
			{
	
				fnMessageModalAlert("결과", "파일을 등록해주세요.");	// Notification(MES)
			}
				
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


function setUploadFileParma(pInfo, pName){
	curFile = pInfo;
}

function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/frontend/qualityfile/quality_file_upload",
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


		var item_code = $('#m_item_code').val();
		var item_nm = $('#m_item_nm').val();
		var file_name = $('#mod_file_name').val();
		var mode = $('#upload_mode').val();
		data.formData = {
			
			item_code : item_code,
			item_nm : item_nm,
			file_name : file_name,
			mode : mode
		
			
		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}


var startValue_combo2 = "";
var comboValue_nm_m = new Array;
var comboValue_cd_m = new Array;
var materialArr = new Array;

//모달 제품
function requestItem(){
	var page_url = "/info/material/selectMaterial2";
	var postData = 'item_type_code=MD1248'
	+'&item_type_codeT=MD1247';
	
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
						comboValue_nm_m.push(row.item_nm);
						comboValue_cd_m.push(row.item_code);
						
					}
				});
			
				
				if (startValue_combo2 == "") {
					
					
					$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm_m,false) ,match : 'contains' });				
					$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_cd_m,false) ,match : 'contains' });
					startValue_combo2 = ":)";
				}
			} else {
				
			}

		}, complete : function() {
			document.getElementById("m_item_nm").style.removeProperty("height");
			document.getElementById("m_item_code").style.removeProperty("height");
		}
	});
}

 //품명,품번 자동완성
 $("#m_item_nm").change(_.debounce(function(event) {
	
 	var item_nm = $("#m_item_nm").val();
 	$(this).val(function(index, value) {
 		console.log('m_item_nm key_up : '+ value);
		
 		getItemInfo('nm',value);
 		return value
 	});
	
 },400));
 $("#m_item_code").change(
		
		_.debounce(function(event) 
 		{
	
 			var item_code = $("#m_item_code").val();
 			$(this).val(function(index, value) {
 				console.log('item_code key_up : '+ value);
				
 				getItemInfo('cd',value);
 				return value
 			});
	
 },400));

 function getItemInfo(type, value)
 {
	
 	console.log('getItemInfo() : ' + value);
 	var result = "";
 	if(type == 'cd')
 	{
 		$.each(materialArr, function(idx, row){
			
 			if(value == row.item_code)
 			{
 				console.log('row.item_nm : ' + row.item_nm);
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
 				console.log('row.item_code : ' + row.item_code);
 				result = row.item_code;
 				$("#m_item_code").val(result);
 			}
 		});
 		if(result == ''){
 			$("#m_item_code").val('');
 		}
		
 	}	
 }



</script>

</body>
</html>