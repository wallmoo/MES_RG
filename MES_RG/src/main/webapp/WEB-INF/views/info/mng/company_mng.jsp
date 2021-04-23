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
		<jsp:param name="selected_menu_p_cd" value="1012" />
		<jsp:param name="selected_menu_cd" value="1019" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        고객사 관리
        <small>기준정보관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li><li class="active">고객사 관리</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
				<!-- Progress Bar 
				 	<div id="hiddenDivLoading" style="visibility:hidden">
					다중 코드 입력 창 iframe 
					    <iframe id="iframeLoading" frameborder="0" style="z-index:-1; position:absolute; visibility:hidden"></iframe>
 					        <div id='load_List'><img src='/img/loading.gif' /></div>
						
 					</div> -->
					<!-- Progress Bar -->

					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
						   	<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertCompany();">등록</button>
					     	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="updateCompany();">수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteCompany();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>Business</label>
									 <select id="business" name="business" class="form-control" style="height: 30px;" >
									 	<option value="ALL" selected="selected">전체</option> 
									 	<option value="business1">business1</option>
									 	<option value="business2">business2</option>
									 	<option value="business3">business3</option>
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>고객사명</label> <input type="text" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="거래처명"
										maxlength="30">
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>사업장</label>
									 <select id="sj" name="sj" class="form-control" style="height: 30px;" >
										<option value="ALL" selected="selected">전체</option>
									 	<option value="sj1">sj1</option>
									 	<option value="sj2">sj2</option>
									 	<option value="sj3">sj3</option>
									 </select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>고객사코드</label> <input type="text" id="customer_code" name="customer_code" class="form-control input-sm" placeholder="고객사코드"
										maxlength="10">
								</div>
							</div>
							
							
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 620px;"></div> 
							</div>
							
						</div>
					</div>
				</div>
				<!-- <div id="grid_list" style="width: 100%; height: 620px;"></div> -->
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">Business</label>
							<div class="col-sm-7">
								<select class="form-control input-sm" id="m_business" name="m_business" >
								 	<option value="business1">business1</option>
								 	<option value="business2">business2</option>
								 	<option value="business3">business3</option>
								</select>
							</div>
						</div>
					</div>
					
					<div class="row" id="ct_codeView">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사코드</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_customer_code" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">고객사명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_customer_nm" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업장</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_land">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_address" value="">
							</div>
							
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telf">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">팩스</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_telfx">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">이메일</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_email_address">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사업자번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" id="m_business_reg_num">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveCompany();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
<!-- ./wrapper -->

<script type="text/javascript">
	$(function($) {
	 	fnLoadCommonOption(); 	 
	 	fnLoadCompanyGrid()
	})
	
	function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		
		$('#request_date_range').daterangepicker({
			opens: 'right', 
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011/04/29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
		});
	}
	
	$("#business").change(function(){
		loadList();
	});
	
	$("#sj").change(function(){
		loadList();
	});
	
	function fnLoadCompanyGrid(){
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
				{ field:'business_code', caption:'Business Code', size:'10%', style:'text-align:center', hidden: true}, 
				{ field:'business_nm', caption:'Business', size:'10%', style:'text-align:center' }, 
				{ field:'customer_code', caption:'고객사코드', size:'10%', style:'text-align:center' }, 
				{ field:'customer_nm', caption:'고객사명', size:'10%', style:'text-align:center'}, 
				{ field:'land', caption:'사업장', size:'7%', style:'text-align:center'}, 
				{ field:'address', caption:'주소', size:'15%', style:'text-align:center'},
				{ field:'telf', caption:'전화번호', size:'10%', style:'text-align:center'}, 
				{ field:'telfx', caption:'팩스', size:'10%', style:'text-align:center'}, 
				{ field:'email_address', caption:'이메일', size:'12%', style:'text-align:center'},
				{ field:'business_reg_num', caption:'사업자번호', size:'7%', style:'text-align:center'}
				], 
			sortData: [{field: 'customer_code', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	
	function loadList() {
		return;

		var page_url = "/frontend/info/selectCompany_mng";
		var postData = "customer_code=" + encodeURIComponent($("#customer_code").val())
			 + "&customer_nm=" + encodeURIComponent($("#customer_nm").val());
		
		if( $("#business option:selected").val() != "ALL") {
			postData += "&business=" + encodeURIComponent($("#business option:selected").val());
		} else {
			postData += "&business=" + encodeURIComponent("");
		}
		
		if( $("#sj option:selected").val() != "ALL") {
			postData += "&sj=" + encodeURIComponent($("#sj option:selected").val());
		} else {
			postData += "&sj=" + encodeURIComponent("");
		}
	
		w2ui['grid_list'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
					});
					w2ui['grid_list'].records = rowArr;
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {}
		});
		
	}
	
	// modal 띄우기 
	function insertCompany() {
		console.log('insertCompany()');
	
		/* $("#modal_info > .input-sm").val(''); */
		w2ui.grid_list.selectNone();
		// insert
		$("#modal_code_title").text('등록');
//  		$("#m_customer_code").attr('disabled',false);
 		$("#ct_codeView").css('display', 'none');
 		
 		$("#m_customer_code").val('');
		$("#m_customer_nm").val('');
		$("#m_address").val('');
		$("#m_land").val('');
		$("#m_telf").val('');
		$("#m_telfx").val('');
		$("#m_email_address").val('');
		$("#m_business_reg_num").val('');

		$("#m_business option:eq(0)").prop("selected", true);	 			
	
		$("#modal_info").modal('show');
	
	}
	
	function updateCompany() {
		console.log('updateCompany()');
		
		/* $("#modal_info > .input-sm").val(''); */
		
		var key = w2ui.grid_list.getSelection();
		if( key.length==1 ) {
			// update
			$("#modal_code_title").text('수정');
			var data = w2ui.grid_list.get(key[0]);
			$("#m_customer_code").attr('disabled',true);
			$("#ct_codeView").css('display', '');
			
			$("#m_customer_code").val(data.customer_code);
			$("#m_customer_nm").val(data.customer_nm);
			$("#m_address").val(data.address);
			$("#m_land").val(data.land);
			$("#m_telf").val(data.telf);
			$("#m_telfx").val(data.telfx);
			$("#m_email_address").val(data.email_address);
			$("#m_business_reg_num").val(data.business_reg_num);
			$("#m_business").val(data.business).prop("selected", true);
			
			$("#modal_info").modal('show');
		} else {
			fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		}
		
	}
	
	function saveCompany() {
		console.log('saveCompany()');
		
		var customer_code = $("#m_customer_code").val();
		var customer_nm = $("#m_customer_nm").val();
		var address = $("#m_address").val();
		var land = $("#m_land").val();
		var telf = $("#m_telf").val();
		var telfx = $("#m_telfx").val();
		var email_address = $("#m_email_address").val();
		var business_reg_num = $("#m_business_reg_num").val();
		var business_code = $("#m_business option:selected").val();
		var business_nm = $("#m_business option:selected").text();
		
		var key = w2ui.grid_list.getSelection();
		
		if( key.length==0 ) {
			flag = "I";	
		} else if (key.length == 1){
			flag = "U";
		}
		
		if(flag=="I" && !chkSubmit($("#m_customer_nm"), "고객사명을")) return;
		
		if(flag=="I" && !chkSubmit($("#m_land"), "사업장을")) return;
		
		if(flag=="I" && !chkSubmit($("#m_address"), "주소를")) return; 
		
		if(flag=="I" && !chkSubmit($("#m_telf"), "전화번호를")) return;
		
		if(flag=="I" && !chkSubmit($("#m_telfx"), "팩스를")) return;
		
		if(flag=="I" && !chkSubmit($("#m_email_address"), "이메일을")) return;
		
		if(flag=="I" && !chkSubmit($("#m_business_reg_num"), "사업자번호를")) return;
		
		// var flag = nullToBlank(customer_code)==''?"I":"U";
		console.log("flag = " + flag);
		
		console.log( "customer_code = " + $("#m_customer_code").val() );
		console.log( "customer_nm = " +$("#m_customer_nm").val() );
		console.log( "address = " +$("#m_address").val() );
		console.log( "land = " +$("#m_land").val() );
		console.log( "telf = " +$("#m_telf").val() );
		console.log( "telfx = " +$("#m_telfx").val() );
		console.log( "email_address = " +$("#m_email_address").val() );
		console.log( "business_reg_num = " +$("#m_business_reg_num").val() );
		console.log( "business code = " +$("#m_business option:selected").val() );
		console.log( "business name = " +$("#m_business option:selected").text() );
		
		$("#modal_info").modal('hide');
		
		var strUrl = "/frontend/info/saveCompany";
		var postData = "flag=" + flag
				if(flag=="U") {
					postData += "&customer_code=" + encodeURIComponent(customer_code);
				}
			postData += "&customer_nm=" + encodeURIComponent(customer_nm)
				+ "&business_code=" + encodeURIComponent(business_code)
				+ "&business_nm=" + encodeURIComponent(business_nm)
				+ "&land=" + encodeURIComponent(land)
				+ "&address=" + encodeURIComponent(address)
				+ "&telf=" + encodeURIComponent(telf)
				+ "&telfx=" + encodeURIComponent(telfx)
				+ "&email_address=" + encodeURIComponent(email_address)
				+ "&business_reg_num=" + encodeURIComponent(business_reg_num);
				 
		// escape(
		
		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    success:function(data, textStatus, jqXHR){
		    	if(data.status == "200") {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
			    	loadList();
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    },
		    complete: function() {
		    }
		});
	}
	
	function deleteCompany() {
		console.log('deleteCompany()');
	
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {
 
			var data = w2ui.grid_list.get(key[0]);
			var code = data.customer_code;
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("code = " + code);
					
					var strUrl = "/frontend/info/deleteCompany";
					var postData = "customer_code=" + code;
					
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
						 }
					});
					
				}
			});
		} 
	}
	
	//엑셀 1024
	function excelFileDownload()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;

		var fileName = 'company_mng.xlsx';
		var sheetTitle = '고객사 관리';
		var sheetName = '고객사 관리';
		
		var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
		var is_rownum = true;
		
		if(gridCols != null && gridCols.length > 0){
			for(var i=0; i<gridCols.length; i++){
	 			if(!gridCols[i].hidden){
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width==undefined?"10":(gridCols[i].width).replace('px','')) + ",";
	 			}
			}
			param_col_name = param_col_name.substr(0, param_col_name.length -1);
			param_col_id = param_col_id.substr(0, param_col_id.length -1);
			param_col_align = param_col_align.substr(0, param_col_align.length -1);
			param_col_width = param_col_width.substr(0, param_col_width.length -1);
		}


		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name="+encodeURIComponent(fileName);
			export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
			export_data += "&sheet_name="+encodeURIComponent(sheetName);
			export_data += "&header_col_names="+encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
			export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));
		
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
			complete: function () {}
		});
	}
	
	// 미 입력시
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