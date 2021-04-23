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
		<jsp:param name="selected_menu_p_cd" value="1043" />
		<jsp:param name="selected_menu_cd" value="1083" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	자주(외주)검사 불량현황
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>품질관리</a></li><li class="active">자주(외주)검사 불량현황</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
					     	<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="requestIU_modal();">등록/수정</button>
					     	<!-- <button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteItem();">삭제</button> -->
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
						
							<div class="col-sm-2">
								<div class="form-group">
								<label>발생일자</label>
									
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="receipt_date" placeholder="yyyymmdd~yyyymmdd" onchange="loadList();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>	
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>진행 상태</label>
									<select id="current_status" name="current_status" class="form-control" style="height: 30px;" onchange="loadList();">
									 	<option value="">전체</option>
									 	<option value="B">진행전</option>
									 	<option value="A">완료</option>
									</select>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>구분</label> 
									<select id="gubun" class="form-control input-sm" name="gubun" onChange = "loadList();">
										<option value="사내">사내</option>
										<option value="외주">외주</option>
									</select>
								</div>
							</div>		
									
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
						</div>
						<div id="grid_list" style="width: 100%; height: 600px;"></div>
					</div>
				</div>
					
				
				
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>


 
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
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">접수번호</label>
							<div class="col-sm-8" style="padding:0;">
								<input type="text" class="form-control input-sm pull-left" id="m_fail_num" >
							</div>
						</div>	
					</div>
					<div class="row">
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">불량유형</label>
							<div class="col-sm-8" style="padding:0;">
							<select id="m_fail_type_code" class="form-control input-sm" name="m_fail_type_code" >
								
							</select>
						</div>	
						</div>	
					</div>
					<div class="row">
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">부적합내용</label>
							<div class="col-sm-8" style="padding:0;">
								<input type="text" class="form-control input-sm pull-right" id="m_reason" >
							</div>
						</div>	
					</div>
					<div class="row">
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">부적합원인</label>
							<div class="col-sm-8" style="padding:0;">
								<input type="text" class="form-control input-sm pull-right" id="m_cause" >
							</div>
						</div>	
					</div>
					<div class="row">
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">개선대책</label>
							<div class="col-sm-8" style="padding:0;">
								<input type="text" class="form-control input-sm pull-right" id="m_comment1" >
							</div>	
						</div>	
					</div>
					<div class="row">
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">처리내역</label>
							<div class="col-sm-8" style="padding:0;">
								<input type="text" class="form-control input-sm pull-right" id="m_comment2" >
							</div>	
						</div>	
					</div>
					<div class="row">
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">처리완료일</label>
							<div class="col-sm-8" style="padding:0;">
								<div class="input-group">
								   <input type="text" class="form-control input-sm" id="m_complete_date">
									  <div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
							 	</div>
							</div>
						</div>	
					</div>
					<div class="row">
						<div  class="form-group" style="padding:0;">
							<label for="" class="col-sm-3 control-label pull-left">개선대책적용일</label>
							<div class="col-sm-8" style="padding:0;">
								<div class="input-group">
								   <input type="text" class="form-control input-sm" id="m_comment_date">
									  <div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
							 	</div>
							</div>
						</div>	
					</div>
					
					<div class="row" id="m_file_upload_r">
						<div class="form-group">
							<label class="col-sm-3 control-label">부적합 보고서</label>
							<div class="col-sm-7" style="padding:0;">
								<input type="text" id="m_down_one_file_name" name="m_down_one_file_name" class="form-control input-sm clear_field pull-right" readonly>
							</div>	
							<div class="col-sm-1" style="padding-left: 7px;">
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn" onclick="type('one');"> <i class="fa fa-plus"></i>
									<input id="file_group" type="file" class="fileupload file_info" name="file[]">
								</span>
							</div>
						</div>
					</div>
					<div class="row" id="m_file_upload_r2">
						<div class="form-group">
							<label class="col-sm-3 control-label">개선대책서</label>
							<div class="col-sm-7" style="padding:0;">
								<input type="text" id="m_down_two_file_name" name="m_down_two_file_name" class="form-control input-sm clear_field pull-right" readonly>
							</div>	
							<div class="col-sm-1" style="padding-left: 7px;">
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn" onclick="type('two');"> <i class="fa fa-plus"></i>
									<input id="file_group" type="file" class="fileupload file_info" name="file[]">
								</span>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveProcess();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
var startValue_combo4 = "";

comboValue_nm1 = new Array;


$(function($) {

 	fnLoadCommonOption(); 
 	
 	fnCdD('m_fail_type_code', 'MC1026');

 	init_grid_list();
 	
 	fnLoadFileHandler2();
 	
 	loadList();
 	
})

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
		$('#m_complete_date, #m_comment_date').daterangepicker({
			opens: 'right', 
			singleDatePicker: true,
			locale: {
				format: 'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear: true,
				yearSuffix: '년',
			
			},
			startDate : moment(minDate)
		});
		
		 $('#order_day, #c_prod_day').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
		 	     endDate: '2020-08-31' 
			}); 
		 
		 
		 $("#m_order_price").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
		 
		 $('#claim_date, #receipt_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			    startDate: moment(minDate).add(-30, 'days'),
    endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(7, 'days')

			}); 
}
 

function fnCdD(val, val2){
	console.log("fnCdD("+val+")");
	
	initOptions($('#'+val)); // select 박스 초기화
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent(val2);
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
  //	 	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
				$.each(rowArr, function(idx, row){
					
					$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					
				});
				
	 			$("#"+val+" option:eq(0)").prop("selected", true);	
	 			if( val == "business" ) {
	 				$("#"+val+" option:eq(1)").prop("selected", true);	
	 			}
	 			
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
	
}



function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [        
		                  
			{ field:'file_path', caption:'파일path', style:'text-align:center', hidden : true},
			{ field:'file_name', caption:'파일name', style:'text-align:center', hidden : true},
			{ field:'file_ext', caption:'파일ext', style:'text-align:center', hidden : true},
			{ field:'file_size', caption:'파일size', style:'text-align:center', hidden : true},
			
			{ field:'t_file_path', caption:'파일path', style:'text-align:center', hidden : true},
			{ field:'t_file_name', caption:'파일name', style:'text-align:center', hidden : true},
			{ field:'t_file_ext', caption:'파일ext', style:'text-align:center', hidden : true},
			{ field:'t_file_size', caption:'파일size', style:'text-align:center', hidden : true},     
			{ field:'product_po', caption:'접수번호', size:'10%', style:'text-align:center', hidden : true},
			{ field:'routing_code', caption:'접수번호', size:'10%', style:'text-align:center', hidden : true},
			{ field:'routing_nm', caption:'접수번호', size:'10%', style:'text-align:center' , hidden : true},
               
			{ field:'fail_num', caption:'접수번호', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'gubun', caption:'구분', size:'10%', style:'text-align:center', hidden : false,sortable :true},
			{ field:'dis_routing_nm', caption:'발생공정(업체)', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'creator', caption:'작업자', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'receipt_date', caption:'발생일자', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'customer_nm', caption:'고객사명', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'customer_code', caption:'고객사코드', size:'10%',  style:'text-align:center',hidden:true},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'prod_menge', caption:'검사수량', size:'10%', style:'text-align:center' ,sortable: true, hidden:true},
			{ field:'prod_fail_menge', caption:'불량수량', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'fail_type_nm', caption:'불량유형', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'reason', caption:'부적합내용', size:'25%', style:'text-align:center' ,sortable: true},
			{ field:'cause', caption:'부적합원인', size:'25%', style:'text-align:center' ,sortable: true},
			{ field:'comment1', caption:'개선대책', size:'25%', style:'text-align:center' ,sortable: true},
			{ field:'comment2', caption:'처리내역', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'complete_date', caption:'처리완료일', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'updater', caption:'조치자', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'comment_date', caption:'개선대책(적용일)', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'down_file_name', caption:'부적합보고서', size:'20%', style:'text-align:left' ,sortable: true},
			{ field:'down_file_name2', caption:'개선대책서', size:'20%', style:'text-align:left' ,sortable: true}
			], 
	
		records: [
		
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}

//조회
function loadList()
{
	console.log('loadList()');
	
	//셀렉트 박스에 onchange가 붙어 있어 grid_list가 정의 되기 전에 loadList()가 실행됨..그리드 미정의 상태에서 데이터로드가 수행되면 예외처리되도록 설정
	try{
		var chk = w2ui['grid_list'].records.length	;
		
		w2ui['grid_list'].clear();
		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
		
	}catch(e)
	{
		return;
	}
	

	var chk_eindt = $("input:checkbox[id='chk_eindt']").is(":checked")
	console.log('chk_eindt : ' + chk_eindt);
	
	var receipt_date = $("#receipt_date").val();
	var item_code = $('#item_code').val();
	var current_status = $("#current_status option:selected").val();
	var gubun = $("#gubun option:selected").val();
	
	if(chk_eindt == 'false' || chk_eindt == false)
	{
		claim_date = '';
	}
	var page_url = "/frontend/quality/selectSelfInspFail";
	
	var postData = "receipt_date=" + encodeURIComponent(receipt_date)
				+ "&item_code=" + encodeURIComponent(item_code)
				+ "&current_status=" + encodeURIComponent(current_status)
				+ "&gubun=" + encodeURIComponent(gubun);
	try{
		
		w2ui.grid_list.selectNone();
		//w2ui['grid_list'].lock('loading...', true);
	}catch(e)
	{
		
	}
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		async : false,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					if(row.item_code)comboValue_nm1.push(row.item_code);
					
					if(row.file_name != null && row.file_name != '' && row.file_name != 'null'){
						row.down_file_name = '<a href="/file/attach_download?file_path=' + encodeURIComponent(row.file_path) +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.file_name+ '</i>';
					}
					else
					{
						row.down_file_name = '';
					}
					if(row.t_file_name != null && row.t_file_name != '' && row.t_file_name != 'null'){
						row.down_file_name2 = '<a href="/file/attach_download?file_path=' + encodeURIComponent(row.t_file_path) +'&file_name=' + encodeURIComponent(row.t_file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.t_file_name+ '</i>';
					}else{
						row.down_file_name2 = '';
						
					}
					row.prod_fail_menge = Number(row.prod_fail_menge);
					
				});
				
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo4 == "") {
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					startValue_combo4 = ":)";
				}
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			
			

		},complete: function () {
			
	
			document.getElementById("item_code").style.removeProperty("height");
			
		}
	});
}

//-------------------------------------------------------------------------------------------------------------------


//등록/수정 모달 생성
function requestIU_modal()
{
	
	file_upload_yn = 'N';
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "항목을 1개 선택해주세요.");
	}else  if( key.length==1 ) {	
		updateItem();	
	}
}
var isRev = false;
//등록
function insertItem() {
	console.log('insertItem()');

	w2ui.grid_list.selectNone();
	
	var minDate = getFormatDate(new Date());

	$("#modal_code_title").text('등록');
	
	$("#m_file_upload_r").val('');
	$("#m_file_upload_r2").val('');
	
	$("#m_fail_num").val('');
	$("#m_reason").val('');
	$("#m_cause").val('');
	$("#m_comment1").val('');
	$("#m_comment2").val('');
	$("#m_fail_type_code option:eq(0)").prop("selected", true);	 
	
	$("#m_complete_date").val(minDate);
	$("#m_comment_date").val(minDate);
	
	var fail_num = $("#m_fail_num").attr('disabled', true);
	 			
	$("#modal_info").modal('show');

}
//수정
function updateItem() {
	console.log('updateItem()');
	
	curFile = null;
	isRev = true;
	
	var minDate = getFormatDate(new Date());
	
	 var key = w2ui.grid_list.getSelection();
	 if( key.length==1 ) {
		// update
		$("#modal_code_title").text('등록/수정');
		var key = w2ui.grid_list.getSelection();
		var data = w2ui.grid_list.get(key[0]);
		
		$("#m_fail_num").val(data.fail_num);
		
		$("#m_reason").val(data.reason);
		$("#m_cause").val(data.cause);
		$("#m_comment1").val(data.comment1);
		$("#m_comment2").val(data.comment2);
		
		$("#m_claim_type").val(data.claim_type);
		
		var complete_date = data.complete_date;
		var comment_date = data.comment_date;
		
		var fail_type_code = data.fail_type_code;
		
		console.log('complete_date???' + complete_date);
		
		
		
		if(complete_date == '' || complete_date == null || complete_date == 'null'){
			$("#m_complete_date").val(minDate);
		}else {
			$("#m_complete_date").val(data.complete_date);
		}
		
		if(comment_date == '' || comment_date == null || comment_date == 'null'){
			$("#m_comment_date").val(minDate);
		}else {
			$("#m_comment_date").val(data.comment_date);
		}
		if(fail_type_code == '' || fail_type_code == null || fail_type_code == 'null'){
			$("#m_fail_type_code option:eq(0)").prop("selected", true);	
		}else {
			$("#m_fail_type_code").val(data.fail_type_code);
		}

		
		console.log('claim_type?' + data.claim_type);
		
		if(data.file_name == null || data.file_name == 'null')
		{
			$("#m_down_one_file_name").val('');
		}else{
			$("#m_down_one_file_name").val(data.file_name);
		}
		if(data.t_file_name == null || data.t_file_name == 'null')
		{
			$("#m_down_two_file_name").val('');
		}else{
			$("#m_down_two_file_name").val(data.t_file_name);
		}
		$("#m_fail_num").attr('disabled', true);
		
		$("#modal_info").modal('show');
	} 
	
}

function getClaimNum()
{
	var key = w2ui.grid_list.getSelection();

	var fail_num = '';
	if( key.length==1 ) {	
		var data = w2ui.grid_list.get(key[0]);
		fail_num = data.fail_num;
	}
	
	return fail_num;
}

//저장전 관리번호 가져오는부분
function saveProcess()
{
	console.log("saveProcess()");
	
	var key = w2ui.grid_list.getSelection();

	var fail_num = '';
	var receipt_date = '';
	if( key.length==1 ) {	
		var data = w2ui.grid_list.get(key[0]);
		fail_num = data.fail_num;
		receipt_date = data.receipt_date;
	}
	
	
	saveItem(fail_num,receipt_date);


}

//저장
function saveItem(fail_num, receipt_date) {
	console.log('saveItem()');
	console.log('receipt_date : ' + receipt_date);


	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	if(!chkSubmit($("#m_reason"), "부적합내용을")) return;
	if(!chkSubmit($("#m_cause"), "부적합원인을")) return;
	if(!chkSubmit($("#m_comment1"), "개선대책을")) return;
	if(!chkSubmit($("#m_comment2"), "처리내역을")) return;
	
	var down_file_name = $("#m_down_one_file_name").val();
	var down_file_name2 = $("#m_down_two_file_name").val();
	
	if( key.length==1 ){
		if (file_upload_yn == 'N'){
			
			var fail_num = $("#m_fail_num").val();
			var fail_type_code = $("#m_fail_type_code option:selected").val();
			var reason = $("#m_reason").val();
			var cause = $("#m_cause").val();
			var comment1 = $("#m_comment1").val();
			var comment2 = $("#m_comment2").val();
			
			var complete_date = $("#m_complete_date").val();
			var comment_date = $("#m_comment_date").val();
			
			var product_po = data.product_po;
			var routing_code = data.routing_code;
			
			$("#modal_info").modal('hide');
			
			
			var strUrl = "/frontend/quality/saveSelfInspFail2";
			var postData = "fail_num=" + encodeURIComponent(fail_num)
					+ "&fail_type_code=" + encodeURIComponent(fail_type_code)
					+ "&reason=" + encodeURIComponent(reason)
					+ "&cause=" + encodeURIComponent(cause)
					+ "&comment1=" + encodeURIComponent(comment1)
					+ "&comment2=" + encodeURIComponent(comment2)
					+ "&complete_date=" + encodeURIComponent(complete_date)
					+ "&comment_date=" + encodeURIComponent(comment_date)
					+ "&product_po=" + encodeURIComponent(product_po)
					+ "&routing_code=" + encodeURIComponent(routing_code);
			
			FunLoadingBarStart();
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
			    	FunLoadingBarEnd();
			    }
			});
			
		}else {
			
			var file_path ='';
			var file_name ='';
			var file_ext ='';
			var file_size ='';
			
			var t_file_path ='';
			var t_file_name ='';
			var t_file_ext ='';
			var t_file_size ='';
			
			var fail_num = $("#m_fail_num").val();
			var fail_type_code = $("#m_fail_type_code option:selected").val();
			var reason = $("#m_reason").val();
			var cause = $("#m_cause").val();
			var comment1 = $("#m_comment1").val();
			var comment2 = $("#m_comment2").val();
			
			var complete_date = $("#m_complete_date").val();
			var comment_date = $("#m_comment_date").val();
			
			var product_po = data.product_po;
			var routing_code = data.routing_code;
			
			fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
				if(chk){
					
					if(curFile){
						curFile.submit();
					} else {
						if(!isRev){
							var pageUrl = '/frontend/quality/saveSelfInspFail';
							var postData = {
									
									fail_num : fail_num,
									fail_type_code : fail_type_code,
									reason : reason,
									cause : cause,
									comment1 : comment1,
									comment2 : comment2,
									complete_date : complete_date,
									comment_date : comment_date,
									comment2 : comment2,
									
									product_po : product_po,
									routing_code : routing_code,
									
									file_path : file_path,
							 		file_name : file_name,
							 		file_ext : file_ext,
							 		file_size : file_size,
							 		
							 		t_file_path : t_file_path,
							 		t_file_name : t_file_name, 
							 		t_file_ext : t_file_ext,
							 		t_file_size : t_file_size,
									
									typeString: typeString
							}
							FunLoadingBarStart();
							$.ajax({
								url : pageUrl,
								type : 'POST',
								data : postData,
								dataType : 'json',
								success : function(data){
									if(data.status = 200){
										fnMessageModalAlert("결과", "업로드를 완료 하였습니다.");	// Notification(MES)
										$('#modal_info2').modal('hide');
									}
								},
								error : function(jqXHR, textStatus, errorThrown){
									fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
								}, complete : function(){
									FunLoadingBarEnd();
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
	}
}

//삭제

function deleteItem() {
	console.log('deleteItem()');

	
	/* 삭제하면 del_yn은 Y로 바뀌는데 그리드에서 삭제가 안대여 */
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui.grid_list.get(key[0]);
		var fail_num = data.fail_num;
		
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				
				var strUrl = "/frontend/quality/deleteClaim";
				var postData = "fail_num=" + encodeURIComponent(fail_num);
				
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

function chgEindt()
{
	console.log('chgEindt()');
	loadList();
}



var curFile = null;

//여기서부터 완료 첨부파일
var typeString = '';
function setUploadFileParma(pInfo, pName, pType){
	console.log(pName);
	if(curFile == null){

		curFile = pInfo;
		typeString = pType;
		console.log('typeString : ' + typeString);
	}else
	{
		if ( curFile.files[0].name != pName) {
			curFile.files[1] = pInfo.files[0];
			typeString = typeString + '#' + pType ;
			console.log('typeString : ' + typeString);
		}else
		{
			curFile = null;
		
			curFile = pInfo;	
			typeString = pType;
		}
	}

}


var file_upload_yn = 'N';
function fnLoadFileHandler2(){
	
	$('.fileupload').fileupload({
		url : "/frontend/quality/saveSelfInspFail",
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
			console.log('######### fileupload');
			
			file_upload_yn = 'Y';
			var file_name = data.files[0].name;
			$('#m_down_'+currentType+'_file_name').val(file_name);
		/* 	 if(!$('#mod_input_file_name').val()) $('#mod_input_file_name').val(data.files[0].name); */
			setUploadFileParma(data, data.files[0].name,currentType);
		},
	}).on('fileuploadadd', function(e, data) {
		console.log('######### fileuploadadd');
	}).on('fileuploadprocessalways', function(e, data) {
		
		console.log('######### fileuploadprocessalways');
		var index = data.index;
		var file = data.files[index];
		if (file.error) {
			fnMessageModalAlert("Error", file.error);
		} else {
			setUploadFileParma(data, file.name);
		}
	}).on('fileuploadprogressall', function(e, data) {
		console.log('######### fileuploadprogressall');
		$('#progress').show();
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .progress-bar').css('width', progress + '%');
	}).on('fileuploaddone', function(e, data) {
		console.log('######### fileuploaddone');
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
    	
    	/* $('#t_' + e.target.id).val(data.files[0].name);
    	$('#a_' + e.target.id).val(data.result.file_group); */
    	
    	$('#modal_info').modal('hide');
 
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
    	loadList();
 
    	
    	
	}).on('fileuploadfail', function(e, data) {
		
		console.log('######### fileuploadfail');
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).on('fileuploadsubmit', function(e, data){
		
		console.log('######### fileuploadsubmit');
		var $this = $(this);
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		var fail_num = $("#m_fail_num").val();
		var fail_type_code = $("#m_fail_type_code option:selected").val();
		var reason = $("#m_reason").val();
		var cause = $("#m_cause").val();
		var comment1 = $("#m_comment1").val();
		var comment2 = $("#m_comment2").val();
		
		var complete_date = $("#m_complete_date").val();
		var comment_date = $("#m_comment_date").val();
		
		var product_po = pdata.product_po;
		var routing_code = pdata.routing_code;
		
		var file_path ='';
		var file_name = $('#m_down_one_file_name').val();
		var file_ext ='';
		var file_size ='';
		
		var t_file_path ='';
		var t_file_name = $('#m_down_two_file_name').val();
		var t_file_ext ='';
		var t_file_size ='';
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		if( recids.length==1){
			
			
			file_path = pdata.file_path;
			file_name = pdata.file_name;
			file_ext = pdata.file_ext;
			file_size = pdata.file_size;
			
			t_file_path = pdata.t_file_path;
			t_file_name = pdata.t_file_name;
			t_file_ext = pdata.t_file_ext;
			t_file_size = pdata.t_file_size;
		}
		
		data.formData = {
				
				fail_num : fail_num,
				fail_type_code : fail_type_code,
				reason : reason,
				cause : cause,
				comment1 : comment1,
				comment2 : comment2,
				complete_date : complete_date,
				comment_date : comment_date,
				comment2 : comment2,
				
				product_po : product_po,
				routing_code : routing_code,
				
				file_path : file_path,
		 		file_name : file_name,
		 		file_ext : file_ext,
		 		file_size : file_size,
		 		
		 		
		 		t_file_path : t_file_path,
		 		t_file_name : t_file_name, 
		 		t_file_ext : t_file_ext,
		 		t_file_size : t_file_size,
		 		typeString : typeString

		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}

var currentType = '';
function type(type)
{
	currentType = type;
	console.log('type : ' + type);
}
//-------------------------------------------------------------------------------------------------------------------


function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}	


//미 입력시
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