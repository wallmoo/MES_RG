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
		<jsp:param name="selected_menu_p_cd" value="1014" />
		<jsp:param name="selected_menu_cd" value="1034" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			파일 이력관리 <small> 파일 관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>파일 관리 </a></li>
			<li class="active">파일 이력관리</li>
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
												<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning  btn-sm">조회</button>	 
											</div>
										</div>
										<div class="box-body">
											<div class="row">
												<div class="form-group">
													<!-- <div class="col-sm-2">
														<label>비즈니스</label> <select  id="m_business_code" name="m_business_code" class="form-control input-sm business_code" ></select>
													</div> -->
													<div class="col-sm-2">
														<label>관리 부서(Level 1)</label> <select  id="file_class_code" name="file_class_code" class="form-control input-sm file_class_code"  onchange="loadList();"></select>
													</div>
													<div class="col-sm-2">
														<label>파일 구분(Level 2)</label> <select  id="file_type_code" name="file_type_code" class="form-control input-sm file_type_code" onchange="loadList();"></select>
													</div>
													<div class="col-sm-2">
														<label>작성자</label> <input type="text" id="creator_nm" name="creator_nm" class="form-control input-sm" placeholder="작성자" onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>문서 번호</label> <input type="text" id="input_rev_no" name="input_rev_no" class="form-control input-sm" placeholder="문서 번호" onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
													<div class="col-sm-2">
														<label>파일 제목</label> <input type="text" id="input_file_name" name="input_file_name" class="form-control input-sm" placeholder="파일 제목" onkeypress="if(event.keyCode==13) {loadList(); return false;}">
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
$(function($) {
	/* fnBusiness('m_');
	if($('#m_business_code').val()){
		fnFileClass($('#m_business_code').val());
	} */
	fnFileClass(null, '#file_class_code', null, '--전체--','');
 	loadGrid();
 	loadList();
})

/* $('#m_business_code').change(function(){
	fnFileClass($(this).val(), '#file_class_code');
	$('#file_class_code').change();
}); */
$('#file_class_code').change(function(){
	fnFileType($(this).val(), '#file_type_code', null, '--전체--','' );
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
        },
        columns: [                
        	/* { field:'business_code', caption:'비즈니스코드', style:'text-align:center', hidden : true}, */
        	{ field:'file_class_code', caption:'부서코드', style:'text-align:center', hidden : true},
        	{ field:'file_type_code', caption:'구분코드', style:'text-align:center', hidden : true},
        	{ field:'file_path', caption:'파일path', style:'text-align:center', hidden : true},
        	{ field:'file_name', caption:'파일', style:'text-align:center', hidden : true},
        	
/* 			{ field:'business_nm', caption:'비즈니스', style:'text-align:center'}, */
			{ field:'file_class', caption:'관리 부서', style:'text-align:center',size : 40, sortable: true},
			{ field:'file_type', caption:'파일 구분', style:'text-align:center',size : 80, sortable: true},
			{ field:'creator_nm', caption:'작성자', style:'text-align:center',size : 40, sortable: true},
			{ field:'input_date', caption:'개정일', style:'text-align:center',size : 50, sortable: true},
			{ field:'input_rev_no', caption:'문서 번호', style:'text-align:center',size : 70, sortable: true},
			{ field:'input_file_name', caption:'파일 제목', style:'text-align:center', sortable: true},
			{ field:'file_rev_no', caption:'Rev.No', style:'text-align:center',size : 40, sortable: true},
			{ field:'file_comment', caption:'개정이력', style:'text-align:center', sortable: true},
			
			{ field:'down_file', caption:'첨부 파일명', style:'text-align:left', sortable: true}
			], 
		sortData: [{field: 'file_class', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
}

function loadList() {
	var page_url = "/file/file_select";
	var postData = {
/* 		business_code : $('#m_business_code').val() || "", */
		file_class_code : $('#file_class_code').val() || "",
		file_type_code : $('#file_type_code').val() || "",
		input_file_name : $('#input_file_name').val() || "",
		creator_nm : $('#creator_nm').val() || "",
		input_rev_no : $('#input_rev_no').val() || ""
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
					
					if(row.input_file_name) comboValue_nm1.push(row.input_file_name);
					if(row.creator_nm) comboValue_nm2.push(row.creator_nm);
					if(row.input_rev_no) comboValue_nm3.push(row.input_rev_no);
					
					row.down_file = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
					
				})
				w2ui.grid_list.records = rowArr;
				if (startValue_combo == "") {
					$('#input_file_name').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					$('#creator_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
					$('#input_rev_no').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
				}
				
			} else {
				w2ui.grid_list.clear();
			}
			
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			
		}, complete: function(){
			startValue_combo = ":)";
			
			document.getElementById("creator_nm").style.removeProperty("height");
			document.getElementById("input_rev_no").style.removeProperty("height");
			document.getElementById("input_file_name").style.removeProperty("height");
		}
	})
}

//set select box

//business
/* 
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
	    	if(data.status == "200" && (data.rows).length>0 /* 1 \*\/ ) {
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
	    	
	    }
	});
	
} */

function fnFileClass(val, comp,  initSelect,  initTxt, initVal, fixYn){
	var $target ;
	if(!comp) $target = $('.file_class_code');
	else $target = $(comp);
	
	$target.html('');
	var strUrl = "/file/selectFileClass";
	var postData = "";
/* 	if(val) postData = "business_code=" + encodeURIComponent(val); */
 	postData = "del_yn=N";
	var op = "";
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200"){
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
	postData += "del_yn=" + encodeURIComponent("N");
	if(val) postData = "&file_class_code=" + encodeURIComponent(val);
	console.log(postData);
	var op = "";
	$.ajax({
		url: strUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		 async : false,
		success : function(data){
			if(data.status == "200" ){
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


</script>

</body>
</html>