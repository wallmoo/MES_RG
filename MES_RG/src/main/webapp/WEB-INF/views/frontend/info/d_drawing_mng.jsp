<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%

// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
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
		<jsp:param name="selected_menu_cd" value="1048" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      도면 이력관리
        <small>도면관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 도면 관리</a></li><li class="active">도면 이력관리</li>
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
														<label>업체명</label> <input type="text" id="drw_nm"  class="form-control input-sm" placeholder="업체명">
													</div>
													<div class="col-sm-2">
														<label>적용</label> <input type="text" id="drw_no"  class="form-control input-sm" placeholder="적용 ">
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
						<label for="" class="col-sm-3 control-label ">파일 분류명</label>
						<div class="col-sm-8">
							<input type="text" maxlength="100"  class="form-control input-sm pull-right clear_field" id="sm_file_class_cn" >
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
comboValue_nm_1 = new Array;
comboValue_nm_2 = new Array;
comboValue_nm_3 = new Array;
comboValue_nm_4 = new Array;


var startValue = "";

$(function($) {
	fnBusiness('m_');
	fnBusiness("mod_");
 	loadGrid();
 	loadList();
 	fnLoadFileHandler();
 	
 	
 	
})

$('#m_business_code').change(function(){
	console.log('1');
	fnFileClass($(this).val(), '#file_class_code');
	$('#file_class_code').change();
});
$('#file_class_code').change(function(){
	fnFileType($(this).val(), '#file_type_code');
})
$('#mod_business_code').change(function(){
	console.log('2');
	fnFileClass($(this).val(), '#mod_file_class_code');
	$('#mod_file_class_code').change();
});
$('#mod_file_class_code').change(function(){
	fnFileType($(this).val(), '#mod_file_type_code');
})
$('#revision_btn').on('click', function(){
	$('.upd_info').attr('disabled', false);
	isRev = true;
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
        	
			{ field:'business_nm', caption:'비즈니스', style:'text-align:center', hidden:true},
			{ field:'customer_nm', caption:'고객사', style:'text-align:center', hidden:true},
			
			{ field:'item_code', caption:'P/N', size:'12%', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', size:'25%', style:'text-align:center', sortable: true},
			{ field:'drw_nm', caption:'업체명', size:'12%', style:'text-align:center', sortable: true},	
			{ field:'drw_no', caption:'적용', size:'10%', style:'text-align:center', sortable: true},
			{ field:'file_rev_no', caption:'Rev.No', size:'12%',style:'text-align:center', sortable: true},
			{ field:'file_comment', caption:'개정이력', size:'15%', style:'text-align:center', sortable: true},
			{ field:'date_created', caption:'개정일', size:'12%', style:'text-align:center', sortable: true},
			{ field:'down_cad_file_name', caption:'cad파일', size:'25%', style:'text-align:left', sortable: true},
			{ field:'down_pdf_file_name', caption:'pdf파일', size:'25%', style:'text-align:left', sortable: true}
			], 
		sortData: [{field: 'item_code', direction: 'ASC'}],
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


// connect server
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



var materialArr = new Array;
// select main list
function loadList() {
	
	
	var item_code = $("#item_code").val() || '';
	var item_nm = $("#item_nm").val() || '';
	var drw_nm = $("#drw_nm").val() || '';
	var drw_no = $("#drw_no").val() || '';
	
	
	
	if( startValue != ''){
		
		
		if( item_code == '' && item_nm == '' && drw_nm == '' && drw_no == '' ){
			
			fnMessageModalAlert("알림", "검색조건을 입력해 주세요.");
			
		}
		
		
	}
	
	var item_code2 = $("#item_code").val();
	console.log("item_code2??"+ item_code2);
	
	
	var page_url = "/frontend/drwfile/selectDrwFile";
	var postData = {
		customer_nm : $('#customer_nm').val() || "",
		item_nm : $('#item_nm').val() || "",
		item_code : $('#item_code').val() || "",
		drw_nm : $('#drw_nm').val() || "",
		drw_no : $('#drw_no').val() || "",
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
						comboValue_nm_1.push(row.item_code);
						comboValue_nm_2.push(row.item_nm);
						comboValue_nm_3.push(row.drw_nm);
						comboValue_nm_4.push(row.drw_no);
					}
				})
				
	
				if( item_code == '' && item_nm == '' && drw_nm == '' && drw_no == '' ){
					
					
					
				}else{
					w2ui.grid_list.records = rowArr;
				}
				
				
				
					
				
			} else {
				w2ui.grid_list.clear();
			}
			
			w2ui.grid_list.refresh();
			w2ui.grid_list.unlock();
			
			$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm_1,false) ,match : 'contains' });
			$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm_2,false) ,match : 'contains' });
			$('#drw_nm').w2field('combo', { items: _.uniq(comboValue_nm_3,false) ,match : 'contains' });
			$('#drw_no').w2field('combo', { items: _.uniq(comboValue_nm_4,false) ,match : 'contains' });
			
			
			
		}, complete: function(){
			w2ui.grid_list.selectNone();
			startValue_combo = ":)";
	
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			document.getElementById("drw_nm").style.removeProperty("height");
			document.getElementById("drw_no").style.removeProperty("height");
			
			startValue = "::)";
			
			
		}
	})
	
	
}



// delete class
function delClass(){
	var recids = w2ui.mgrid_list1.getSelection();
	var rData ;
 	var classData = [];
	$.each(recids, function(idx, recid){
		rData = w2ui.mgrid_list1.get(recid);
		rData.del_yn = 'Y';
		classData.push(rData);
	})
	console.table (classData);
	var pageUrl = "/file/delFileClass";
	var p = "param=" + encodeURIComponent(JSON.stringify(classData));
	
	$.ajax({
		url : pageUrl,
		type: 'POST',
		data : p,
		dataType : 'json',
		success : function(data){
			if(data.status == 200){
				fnMessageModalAlert("결과", "파일 분류 삭제를 완료 하였습니다.");	// Notification(MES)
				w2ui.mgrid_list1.selectNone();
				$('#hid_file_class_code').val();
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


//delete type
function delType(){
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
				fnMessageModalAlert("결과", "파일 종류 삭제를 완료 하였습니다.");	// Notification(MES)
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

// ins file info
function insFile() {
	
	var businessCode =$('#mod_business_code').val();
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
						business_code : businessCode,
						file_class_code : fileClassCode,
						file_class : fileClass,
						file_type_code : fileTypeCode,
						file_type : fileType,
						file_rev_no : revno,
						file_comment : fileComment
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
	var recids = w2ui.grid_list.getSelection();
	var rData;
	var fileData = [];
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {
	
		$.each(recids, function(idx, recid){
			rData = w2ui.grid_list.get(recid);
			fileData.push(rData);
		})
		
		var data = w2ui.grid_list.get(key[0]);
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
					
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
				})
		
			}
		});
	}
}

//set select box

//business
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
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
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
	    		fnFileClass($('#'+val+'business_code').val(), '#'+ (val== 'm_' ? '' : val)+'file_class_code');
	    	}
	    }
	});
	
}

function fnFileClass(val, comp,  initSelect,  initTxt, initVal, fixYn){
	var $target ;
	if(!comp) $target = $('.file_class_code');
	else $target = $(comp);
	
	$target.html('');
	var strUrl = "/file/selectFileClass";
	var postData = "";
	if(val) postData = "business_code=" + encodeURIComponent(val);
	var op = "";
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200" && (data.rows).length > 0){
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
	if(val) postData = "file_class_code=" + encodeURIComponent(val);
	var op = "";
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200" && (data.rows).length > 0){
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
	console.log(pName);
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
			setUploadFileParma(data, data.files[0].name);
		},
	}).on('fileuploadadd', function(e, data) {
	}).on('fileuploadprocessalways', function(e, data) {
		console.log('always')
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
    	
    	$('#t_' + e.target.id).val(data.files[0].name);
    	$('#a_' + e.target.id).val(data.result.file_group);
    	
    	$('#ins_mod').modal('hide');
    	loadList();
    	
	}).on('fileuploadfail', function(e, data) {
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).on('fileuploadsubmit', function(e, data){
		console.log('fileuploadsubmit')
		var $this = $(this);
		//data.formData = {};
		//data.url = result.url;
		var businessCode = $('#mod_business_code').val();
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
		
		data.formData = {
			business_code : businessCode,
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
			file_no : fileNo
		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}


function chkSubmit(item, msg){
	if(item.val().replace(/\s/g,"")==""){
		fnMessageModalAlert("알림", msg+ " 입력해 주세요.");
		item.val("");
		item.focus();
		return false;
	} else {
		return true;
	}
}

</script>

</body>
</html>