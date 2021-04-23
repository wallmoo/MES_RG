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
  <title>SET | </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true"> 
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1042" />
		<jsp:param name="selected_menu_cd" value="1062" />
	</jsp:include>

	<div class="content-wrapper">
			<section class="content-header">
				<h1>
					공구이력관리
					<small>생산관리</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i>공구이력관리</a></li>
					<li class="active">생산관리</li>
				</ol>
			</section>
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">조회조건</h3>
							<div class="box-tools pull-right">
								<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
								<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertMng();">등록</button>
						     	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="updateMng();">수정</button>
						     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteMng();">삭제</button>
								
								
								<button type="button" id="btn_search"
									class="btn btn-warning  btn-sm" onclick="loadList();">조회</button>
							</div>
						</div>
						<div id="" class="box-body">
							<div class="row">
								<div class="col-sm-2">
									<div class="form-group">
									<label>작업일자</label>
										<div class="input-group">
											<input type="text" 
												class="form-control pull-right input-sm" style="" id="replacement_date" placeholder="yyyymmdd~yyyymmdd">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 설비유형</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="machine_class" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
												<!-- <option value="drw">진행전</option>
												<option value="ex">진행</option>
												<option value="ord">완료</option> -->
											</select>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 설비명</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<select id="machine" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;">
												<option value="ALL">전체</option>
												<!-- <option value="drw">진행전</option>
												<option value="ex">진행</option>
												<option value="ord">완료</option> -->
											</select>
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 작업종류</label>
										<div class="form-group" style="margin-bottom: 0px;">
<!-- 											<input type="input" id="replacement_gubun" name="replacement_gubun" class="form-control input-sm" placeholder=""> -->
												<select id="replacement_gubun" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;"></select>
										</div>
									</div>
								</div>	
								<div class="col-sm-2">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>| 작업자</label>
										<div class="form-group" style="margin-bottom: 0px;">
											<input type="input" id="replacement_worker" name="replacement_worker" class="form-control input-sm" placeholder=""
											onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
										</div>
									</div>
								</div>					
							</div>
							<div id="grid_list" style="width: 100%; height: 620px;"></div>
							
						</div>
					</div>
					
				</div>
			</div>
		</section>
	</div>
</div>
  	<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>


<!--  modal area1 -->
<div class="modal fade" id="modal_detail" data-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title"> 작업표준서 관리 </h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">작업표준서 목록</h3>
									<div class="box-tools pull-right">
										<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnSearchItnbrGrid();">조회</button>
									</div>
								</div>
								<div class="box-body">
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">파일그룹IDX</label>
										<div class="col-sm-7">
											<input type="input" id="s_idx" name="s_idx" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">파일명</label>
										<div class="col-sm-7">
											<input type="input" id="s_filename" name="s_filename" class="form-control input-sm" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="col-sm-3 control-label">등록자</label>
										<div class="col-sm-7">
											<input type="input" id="s_creator" name="s_creator" class="form-control input-sm" placeholder="">
										</div>
									</div>
								</div>
								<div id="dv_grid_itnbrlist" class="box-body">
									<table id="grid_itnbrlist"></table>
									<div id="grid_itnbrlist_pager"></div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="box" style="margin-bottom: 0px;">
								<div class="box-header with-border">
									<h3 class="box-title">등록 자재 목록</h3>
									<div class="box-tools pull-right">
										<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnAddMatnr();">자재등록</button>
										<button type="button" id="" class="btn btn-sm btn-primary" onclick="fnDelMatnr();">자재삭제</button>
									</div>
								</div>
								<div class="box-body">
										<div id="dv_grid_addItnbr_list">
										<table id="grid_addItnbr_list"></table>
									</div>
								</div>
							</div>
						</div>
					</div><!-- end row -->
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button" id="" class="btn btn-sm btn-success" onclick="confirmReqeust();">요청</button>
					<button type="button" id="" class="btn btn-sm btn-default" onclick="modal_detail_close();">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- modal area3 -->  
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
					<!-- <div class="row">
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
					</div> -->
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">작업일자</label>
							<div class="col-sm-5">
								<div class="input-group">
								  <input type="text" class="form-control input-sm" id="m_replacement_date">
									  <div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
							 	</div>
							</div>
						</div>
					</div>
					
					<div class="row" >
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">설비유형</label>
							<div class="col-sm-7">
								<select class="form-control input-sm" id="m_machine_class" name="m_machine_class" > </select>
							</div>
						</div>
					</div>
					
					<div class="row" id="">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">설비명</label>
							<div class="col-sm-7">
								<select class="form-control input-sm" id="m_machine" name="m_machine" > </select>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">작업종류</label>
							<div class="col-sm-7">
								<select class="form-control input-sm" id="m_replacement_gubun" name="m_replacement_gubun" > </select>
								
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">작업내용</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_replacement_comment" maxlength="200" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">치공구코드</label>
							<div class="col-sm-7">
<!-- 								<input type="text" class="form-control input-sm pull-right" id="m_item_code" readonly="readonly"> -->
									<input type="text" class="form-control input-sm pull-right clear_val" id="m_item_code">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">치공구명</label>
							<div class="col-sm-7">
<!-- 								<input type="text" class="form-control input-sm pull-right" id="m_item_nm" > -->
<!-- 									<select class="form-control input-sm" id="m_item_nm" name="m_item_nm" > </select> -->
									<input type="text" class="form-control input-sm pull-right clear_val" id="m_item_nm">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">정지시간(MIN)</label>
							<div class="col-sm-5">
								<input type="text" class="form-control input-sm pull-right" id="m_replacement_time" maxlength="30" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">작업자</label>
							<div class="col-sm-5">
								<input type="text" class="form-control input-sm pull-right" id="m_replacement_worker" maxlength="30" >
							</div>
						</div>
					</div>
					
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveMng();">저장</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

var startValue_combo = "";
comboValueG = new Array;
comboValueP = new Array;

comboValueItC = new Array;
comboValueItN = new Array;

var materialArr = new Array;

var nowDate = "";

$(function($) {
	fnLoadCommonOption();
	nowDate = $("#m_replacement_date").val();
	
	fnCdD('machine_class', 'MC1021'/* , 'm_' */); // m_만 있으면 m_ 만 다시 받는거
	fnCdD('replacement_gubun', 'MC1025'/* , 'm_' */);
	fnMaterial('m_item_code', 'm_item_nm');
// 	fnMachine("machine");
	$("#machine").attr('disabled', true);
	init_grid_list();
	loadList();
})

$("#machine_class").change(function(){
	if( $("#machine_class option:selected").val() != 'ALL') {
		$("#machine").attr('disabled', false);
		fnMachine("machine");
		loadList();
	} else {
		$("#machine").attr('disabled', true);
		$("#machine option:eq(0)").prop("selected", true);	
		loadList();
	}
});

$("#m_machine_class").change(function(){
	fnMachine("m_machine");
});
	
$("#machine").change(function(){		
	loadList();
});

$("#replacement_gubun").change(function(){		
	loadList();
});

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

/* $("#m_item_nm").change(function(){		
	$("#m_item_code").val( $("#m_item_nm option:selected").val() );	 
}); */
	

function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
		$('#m_replacement_date').daterangepicker({
			opens: 'right', 
			singleDatePicker: true,
			locale: {
				format: 'YYYYMMDD', // inputbox 에 '2011-04-29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
			startDate : moment(minDate)
		});
		
		 $('#replacement_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			    startDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(-7, 'days'),
				endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(0, 'days')
			}); 
		 
		 
		 $("#m_replacement_time").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
}
 
function fnMachine(val) {
	console.log("fnMachine");
	
	initOptions($('#'+val)); // select 박스 초기화
	
	var sub = val.substr(0,2);	
	
	var strUrl = "/info/machine/selectMachine";
	var postData = "";
	
	if(sub.indexOf("m_") == -1) {
		postData += "machine_class_code=" + encodeURIComponent( $("#machine_class").val() );
	} else {
		postData += "machine_class_code=" + encodeURIComponent( $("#m_machine_class").val() );
	}
	
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
	    		
//     			$( "#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
					  
	    		if(sub.indexOf("m_") == -1) // val
	    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
	    		$.each(rowArr, function(idx, row){
					$( "#"+val ).append("<option value=" + row.machine_code + ">" + row.machine_nm + "</option>");
				});
				
	    		$("#"+val+" option:eq(0)").prop("selected", true);	
	 		} 
	    },
	    error: function(jqXHR, textStatus, errorThrown){
	    },
	    complete: function() {
	    }
	});
	
} 
 
function fnMaterial(val, val2) {
	console.log("fnMaterial");
	
// 	initOptions($('#m_'+val2));
	
	var strUrl = "/info/material/selectMaterial";
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
// 	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		materialArr = rowArr;
	    		
	    		$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					comboValueItN.push(row.item_nm);
					comboValueItC.push(row.item_code);					
				});
	    		
	    		$('#m_item_nm').w2field('combo', { items: _.uniq(comboValueItN,false) ,match : 'contains' });				
				$('#m_item_code').w2field('combo', { items: _.uniq(comboValueItC,false) ,match : 'contains' });
				
	    		/* $.each(rowArr, function(idx, row){
	    			if( row.item_type_code == "MD1246" || row.item_type_code == "MD1250" ) {
						$("#"+val2 ).append("<option value=" + row.item_code + ">" + row.item_nm + "</option>");
	    			}
				});

 				$("#"+val2+" option:eq(0)").prop("selected", true);
 				$("#"+val).val( $("#"+val2+" option:selected").val() ); */
	    		
	    		/* comboValueItC = new Array;
	    		comboValueItN = new Array;
	    		
	    		$.each(rowArr, function(idx, row){
					if( row.item_type_code == "MD1246" || row.item_type_code == "MD1250" ) {
						comboValueItC.push(row.item_code);
						comboValueItN.push(row.item_nm);
					}
				});
				
	    		$("#"+val).w2field('combo', { items: _.uniq(comboValueItC, false), match : 'contains' });
				$("#"+val2).w2field('combo', { items: _.uniq(comboValueItN, false) ,match : 'contains' }); */
	    	}  
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() { }
	});
} 
 
function fnCdD(val, val2, val3){
	console.log("fnCdD("+val3+")");
	
	if(val3 == 'm_') {
		initOptions($('#m_'+val));
	} else {
		initOptions($('#'+val)); // select 박스 초기화
		initOptions($('#m_'+val));
	}
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent(val2);
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;

	    		//  if(valsub != "m_")
	    		if (val3 != 'm_') {	// if(sub.indexOf("m_") == -1) // val
	    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
	    		}
	    		
				$.each(rowArr, function(idx, row){
					if( val3 == 'm_' ) {
						$("#m_"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					} else {
						$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						$("#m_"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					}
				});
				
	 			if( val3 == 'm_' ) {
	 				$("#m_"+val+" option:eq(0)").prop("selected", true);	
	 				fnMachine("m_machine");
	 			} else {
	 				$("#m_"+val+" option:eq(0)").prop("selected", true);	
	 				$("#"+val+" option:eq(0)").prop("selected", true);	
	 				fnMachine("m_machine");
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
        multiSelect: true,
        columns: [                

			{ field:'replacement_his', caption:'공구이력순번', size:'10%', style:'text-align:center', hidden: true}, // 120px
			{ field:'replacement_date', caption:'작업일자', size:'10%', style:'text-align:center'}, // 200px
			{ field:'machine_class_code', caption:'설비유형 코드', size:'10%', style:'text-align:center', hidden: true}, // 120px
			{ field:'machine_class_nm', caption:'설비유형', size:'10%', style:'text-align:center'}, // 120px
			{ field:'machine_code', caption:'설비코드', size:'10%', style:'text-align:center'}, // 120px
			{ field:'machine_nm', caption:'설비명', size:'10%', style:'text-align:center'}, // 120px
			{ field:'replacement_gubun', caption:'작업종류', size:'10%', style:'text-align:center', hidden: true}, // 120px
			{ field:'replacement_gubun_nm', caption:'작업종류', size:'10%', style:'text-align:center'}, // 120px
			{ field:'replacement_comment', caption:'작업내용', size:'40%', style:'text-align:center'},
		
			{ field:'item_code', caption:'치공구 코드', size:'20%', style:'text-align:center', hidden: true},
			{ field:'item_nm', caption:'치공구내역', size:'20%', style:'text-align:center'},
// 			{ field:'price_out', caption:'작업기간', size:'10%', style:'text-align:center'}, // right // 120px
			{ field:'replacement_time', caption:'정지시간(MIN)', size:'15%', style:'text-align:center'},
			{ field:'replacement_worker', caption:'작업자', size:'10%', style:'text-align:center'} // 120px
			], 
		sortData: [{field: 'vendor_code', direction: 'ASC'}],
		records: [ ],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}, 
		onSelect: function (event) {
			event.onComplete = function(){
			}
		}
		
	});
}
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

//-------------------------------------------------------------------------------------------------------------------

//등록
function insertMng() {
	console.log('insertMng()');

	w2ui.grid_list.selectNone();

	$("#modal_code_title").text('등록');

	fnCdD('machine_class', 'MC1021', 'm_' ); // m_만 있으면 m_ 만 다시 받는거
	fnCdD('replacement_gubun', 'MC1025', 'm_' );
 	fnMaterial('m_item_code', 'm_item_nm');
	$("#m_replacement_date").val(nowDate);
	$("#m_replacement_comment").val("");
	$("#m_replacement_time").val("");
	$("#m_replacement_worker").val("");
	
	$("#m_item_code").val("");
	$("#m_item_nm").val("");
	
	 			
	$("#modal_info").modal('show');

}
//수정
function updateMng() {
	console.log('updateMng()');
	var key = w2ui.grid_list.getSelection();
	
	 if( key.length==1 ) {
		// update
		$("#modal_code_title").text('수정');
		
		var data = w2ui.grid_list.get(key[0]);
// 		$("#m_customer_code").attr('disabled',true);
		fnCdD('machine_class', 'MC1021', 'm_' ); // m_만 있으면 m_ 만 다시 받는거
		$("#m_machine_class").val(data.machine_class_code).prop("selected", true);
		
		fnCdD('replacement_gubun', 'MC1025', 'm_' );
		fnMaterial('m_item_code', 'm_item_nm');

		$("#m_replacement_date").val(data.replacement_date);
		$("#m_replacement_comment").val(data.replacement_comment);
		$("#m_replacement_time").val(data.replacement_time);
		$("#m_replacement_worker").val(data.replacement_worker);
		
		$("#m_machine").val(data.machine_code).prop("selected", true);
		$("#m_replacement_gubun").val(data.replacement_gubun).prop("selected", true);
// 		$("#m_item_code").val(data.item_code);
// 		$("#m_item_nm").val(data.item_code).prop("selected", true);

		$("#m_item_code").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).item_code);
		$("#m_item_nm").val(w2ui.grid_list.get(w2ui.grid_list.getSelection()*1).item_nm);
		
		
		$("#modal_info").modal('show');
	} else {
		fnMessageModalAlert("알림", "수정하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
	}
	
}
//저장
function saveMng() {
	console.log('saveMng()');

	if(/* flag=="I" && */ !chkSubmit($("#m_replacement_comment"), "작업내용을")) return;
	if(/* flag=="I" && */ !chkSubmit($("#m_item_code"), "치공구코드를")) return;
	if(/* flag=="I" && */ !chkSubmit($("#m_item_nm"), "치공구명을")) return;
	
	var replacement_date = $("#m_replacement_date").val() || '';
	var replacement_comment = $("#m_replacement_comment").val()|| '';
	var replacement_time = $("#m_replacement_time").val()|| '';
	var replacement_worker = $("#m_replacement_worker").val()|| '';
	var machine_class_code = $("#m_machine_class option:selected").val()|| '';
	var machine_class_nm = $("#m_machine_class option:selected").text()|| '';
	var machine_code = $("#m_machine option:selected").val()|| '';
	var machine_nm = $("#m_machine option:selected").text()|| '';
	var replacement_gubun = $("#m_replacement_gubun option:selected").val()|| '';
// 	var item_code = $("#m_item_nm option:selected").val()|| '';
// 	var item_nm = $("#m_item_nm option:selected").text()|| '';
	var item_nm = $('#m_item_nm').val();
	var item_code = $('#m_item_code').val();
	
	var replacement_his = "";
	
	var key = w2ui.grid_list.getSelection();
	
	if( key.length==0 ) {
		flag = "I";	
	} else if (key.length == 1){
		flag = "U";
		var data = w2ui.grid_list.get(key[0]);
		replacement_his = data.replacement_his;
	}
		
	console.log("flag = " + flag);
	
	$("#modal_info").modal('hide');
	
	var strUrl = "/info/trhis/saveTool_replacement_his";
	var postData = "flag=" + flag;
			if(flag=="U") {
				postData += "&replacement_his=" + encodeURIComponent(replacement_his);
			}
	postData += "&replacement_date=" + encodeURIComponent(replacement_date);
	postData += "&replacement_comment=" + encodeURIComponent(replacement_comment);
	postData += "&replacement_time=" + encodeURIComponent(replacement_time);
	postData += "&replacement_worker=" + encodeURIComponent(replacement_worker);
	postData += "&machine_class_code=" + encodeURIComponent(machine_class_code);
	postData += "&machine_class_nm=" + encodeURIComponent(machine_class_nm);
	postData += "&machine_code=" + encodeURIComponent(machine_code);
	postData += "&machine_nm=" + encodeURIComponent(machine_nm);
	postData += "&replacement_gubun=" + encodeURIComponent(replacement_gubun);
	postData += "&item_code=" + encodeURIComponent(item_code);
	postData += "&item_nm=" + encodeURIComponent(item_nm);
	
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

//삭제
function deleteMng() {
	console.log('deleteMng()');

	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui.grid_list.get(key[0]);
		var replacement_his = data.replacement_his;
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				var strUrl = "/info/trhis/deleteTool_replacement_his";
				var postData = "replacement_his=" + replacement_his;
				
				$.ajax({
					 url: strUrl,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
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

//조회
function loadList()
{
	console.log("loadList");
   try{
	   w2ui['grid_list'].selectNone();
	   w2ui['grid_list1'].clear();
	   w2ui['grid_list2'].clear();
   }catch (e) 
   {
      
   }
	var replacement_gubun = $("#replacement_gubun").val();
	var replacement_worker = $("#replacement_worker").val();
	var replacement_date = $("#replacement_date").val();
	var machine_class = $("#machine_class option:selected").val();
	var machine = $("#machine option:selected").val();
	
	
	var page_url = "/info/trhis/selectTool_replacement_his"; // selectCsPr1 X
	var postData = "replacement_worker=" + encodeURIComponent(replacement_worker);
	postData += "&replacement_date=" + encodeURIComponent(replacement_date);
			
	if( replacement_gubun == "ALL") {
		postData += "&replacement_gubun=" + "";
	} else {
		postData += "&replacement_gubun=" + encodeURIComponent(replacement_gubun);
	}
	
	if( machine_class == "ALL") {
		postData += "&machine_class_code=" + "";
		postData += "&machine_code=" + "";
	} else {
		if( machine == "ALL") {
			postData += "&machine_class_code=" + encodeURIComponent( machine_class ); // where machin_code in (서브쿼리) +  으로
			postData += "&machine_code=" + "";
		} else {
			postData += "&machine_code=" + encodeURIComponent( machine );
			postData += "&machine_class_code=" + "";
		}
	}
	
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			console.log("data.status = " + data.status);
			if(data.status == 200 && (data.rows).length>0 ) {
				comboValueG = new Array;
				comboValueP = new Array;
				
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if (startValue_combo == "") {
						comboValueG.push(row.replacement_gubun);
						comboValueP.push(row.replacement_worker);
					}
				});
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#replacement_gubun').w2field('combo', { items: _.uniq(comboValueG,false), match : 'contains' });
					$('#replacement_worker').w2field('combo', { items: _.uniq(comboValueP,false) ,match : 'contains' });
				}
			} else {
				w2ui.grid_list.clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		},complete: function () {
			startValue_combo = ":)";
				
			/* 
				
			w2ui.grid_list.refresh();
		    $('#grid_list').w2render('grid_list'); */
		    
		   
		}
	});
		
}


//엑셀 1024
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '공구이력관리.xlsx';
	var sheetTitle = '공구이력관리';
	var sheetName = '공구이력관리';
	
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

</script>
</body>
</html>