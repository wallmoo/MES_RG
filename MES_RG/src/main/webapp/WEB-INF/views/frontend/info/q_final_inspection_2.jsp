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
		<jsp:param name="selected_menu_cd" value="1078" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	최종검사이력조회
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>품질관리</a></li><li class="active">최종검사이력조회</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row" style="position: relative; height:600px;">
			<div class="row" style="position: absolute; width: 60%; height:600px; margin:0;">
				<section class="col-lg-12">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">공정 검사 대상</h3>
							<div class="box-tools pull-right">
								<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
<!-- 								<button type="button" id="btn_update" class="btn btn-danger btn-sm" onclick="modalPrint();">성적서 발행</button> -->
								<button type="button" id="" class="btn btn-danger btn-sm" onclick="printRpt();">성적서발행</button>
								<button type="button" id="" class="btn btn-info btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
							</div>
						</div>
						
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>작업지시번호</label> <input type="text" id="m_product_po" name="m_product_po" placeholder="ex) 작업지시번호"
									 class="form-control input-sm cond_1" maxlength="100" />
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>P/N</label> <input type="text" id="m_item_code" name="m_item_code" placeholder="ex) P/N"
									 class="form-control input-sm cond_1" maxlength="100" />
								</div>
							</div>	
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>품명</label> <input type="text" id="m_item_nm" name="m_item_nm" placeholder="ex) 품명"
									 class="form-control input-sm cond_1" maxlength="100" />
								</div>
							</div>	
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">	
							<div class="col-sm-4">
								<div class="form-group">
								<label>생산요청일자</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm cond_2" style="" id="m_product_req_date" placeholder="yyyymmdd~yyyymmdd">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group">
								<label>진행상태</label>
									<select id="m_flag" name="m_flag" class="form-control select2 input-sm cond_2" data-placeholder="">
										<option value="">전체</option>
										<option value="검사전">검사전</option>
										<option value="검사진행중">검사진행중</option>
										<option value="검사완료">검사완료</option>
										<option value="품질검사항목없음">품질검사항목없음</option>
									</select>
								</div>
							</div>
							
							<div class="col-sm-4" id="imgRadioHd">    
								<div class="col-sm-12" style="padding-left: 0px;">
					                  <label for="rdo_img_yn" class="control-label">이미지 첨부 여부</label>
					             </div>
					             
					             <label>
					               <input type="radio" name="rdo_img_yn" class="flat-red form-control" value="Y" checked="checked"> Y
					             </label>
					             
					             <label>
					               <input type="radio" name="rdo_img_yn" class="flat-red form-control" value="N" > N
					             </label>
					             
							</div>
						</div>
						<div id="grid_list" style="height: 470px; margin: 15px"></div>
					</div>
					
				</div>	
				
				<div class="row" style="position: absolute; right: 45px; width: 37%; height:600px;">
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">공정 검사 결과</h3>
							</div>
							<div id="grid_chk" style="height: 270px; margin: 15px""></div>
						</div>
					</div>
					<div class="row">
						<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
							<!-- Progress Bar -->
							<div class="box-header with-border" style=" background-color: #DB8EB5;">
								<h3 class="box-title">작업 실적</h3>
								
<!-- 								<div class="box-tools pull-right"> -->
<!-- 									<button type="button" id="" class="btn btn-info btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>  -->
<!-- 								</div> -->
							</div>
							<div id="grid_inpt" style="height: 250px; margin: 15px""></div>
						</div>
					</div>
				</div>
			</div>
			</section>
		</div>
	</section>
	
	
	<!-- modal_print -->
	<div class="modal fade" id="modal_print" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width: 100%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_print_title">인쇄</h4>
        	</div>
			<div class="modal-body" id="modal_print_body">
				<form id="frm_cover" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-10" id="printDiv">
							<div id="grid_print_1" class="text-center" style="width: 100%; "></div> <!-- height: 620px; -->
						</div>
						<div class="col-md-1"></div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-primary btn-sm" onclick="print();">인쇄</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal" onclick="closePt();">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
	
<!-- modal_end -->
	
    <!-- /.content -->
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

<%@include file="./q_final_inspection_1_doc.jsp"%>
<script src="/res/plugins/jquery-printme.js"></script>

<script type="text/javascript">

// $('#m_gubun').change(function(){
// 	loadInpt();
// });
var imggubun = "";
var onSelectKey = "";
var startValue_combo = "";
comboValue_no = new Array;
comboValue_cd = new Array;
comboValue_nm = new Array;

$(function($) {
	radioCheck();
 	fnLoadCommonOption(); 	 

//  	$("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2");
 	
 	init_grid_list();
 	init_grid_list2();
 	init_grid_list3();
 	
 	loadList();
 	
 	$(".cond_1").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	
 	$('.cond_2').on("change",function(event){ 
		loadList();
 	}); 
});

function radioCheck() {
	console.log("radioCheck()");
	
	$('input[type="radio"].flat-red').iCheck({
		checkboxClass: 'icheckbox_flat-green',
		radioClass: 'iradio_flat-green',
		handle: 'radio'
	});
	
	$(":radio[name='rdo_img_yn']").on('ifChecked', function(event){
		 var ssss = $(":radio[name='rdo_img_yn']:checked").val();
		  
		$("#printDiv").empty(); // 동적 생성 초기화
			var div = $("<div>");
			div.addClass('text-center');
			div.attr("style", "width: 100%;");
			div.attr("id", "grid_print_1");
			
			$("#printDiv").append( div );	

		  if( ssss == "Y" ) { // 이미지 o
// 			  $("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2_1");
		  }  else { // 이미지 x
// 			  $("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2");
		  }
		  
//	 	  loadList();
		  
	});
}

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		var minDate = getFormatDate(new Date());
 		$('#m_product_req_date').daterangepicker({
			opens: 'right',
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		    startDate : moment(new Date()).add('days', -60),
			endDate : moment(new Date()).add('days', 60)
		}); 
		 
		 
		 $("#m_order_price").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
}
 

//회사명 변경시 1개 이상 조회시 select box로 1개일시 input창
$("#projectBox").change(function(){
	
	var val = $("#projectBox option:selected").val(); // text();
	
// 	console.log("val = " + val);
	
	if(val=="") {
		return;
	}
	
});

function closePt() {
	var key = w2ui.grid_list.getSelection();
	onSelectKey = key[0]; 
	loadList();
	
	w2ui.grid_list.select(key[0]);
}

function openImgView(code) {
	
	$("#grid_print_1").find("#td_img").empty();
	
	var url = "";
	var page_url = "/frontend/insp/getPnImg";
	var postData = "item_code=" + encodeURIComponent( code );
		
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		async : false, // 다 끝나고 다음 처리 해!
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
// 				url = "http://localhost:8080/doc/"
				url = window.location.href.substring(0, window.location.href.length - window.location.pathname.length) + '/doc/';
				var path = data.rows[0].file_path;
				url = url + path; 			
				
				var imgObj = new Image();
				imgObj.src = url;

				$("#grid_print_1").find("#td_img").append("<img src='"+ imgObj.src +"' style='max-width: 65%;"+"height: auto;' />");
// 				$("#grid_print_1").find("#td_img").append("<img src='"+ imgObj.src +"' />");
				
				// style='background-size: contain; overflow: hidden; display: flex;  align-items: center; justify-content: center;' />"); 
				// style='overflow: hidden; display: flex;  align-items: center; justify-content: center;' />"); 
				
			} else if (data.status == 200 && (data.rows).length == 0) {
				fnMessageModalAlert("알림", "해당 자재에 등록된 이미지 파일이 없습니다.");
				imggubun = "X";
				return;
			} else {
				fnMessageModalAlert("알림", "에러가 발생했습니다.");
				return;
			}
		},
		complete : function() {
			
		}
	});

}

function modalPrint(){
// 	console.log("modalPrint()");
	var key = w2ui.grid_list.getSelection();
	if( key.length==1 ) {
		var nxtIdx = 1;
		
		// 값 불러오고 완료 후에 붙여주기.
		var datas = w2ui.grid_list.get(key[0]);
		
// 		$("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2");
		
		var ssss = $(":radio[name='rdo_img_yn']:checked").val();
// 		console.log("ssss = " + ssss );
		
		imggubun = "";

		if( ssss == "Y" ) { // 이미지 o
			openImgView(datas.item_code);
		}
		
		if(imggubun == "X") {
			return;
		}
		
		var page_url = "/info/print/selectPrintFI";
		var postData = "product_po=" + encodeURIComponent(datas.product_po)
				+ "&routing_code=" + encodeURIComponent(datas.routing_code);

		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData, 
			dataType : 'json',
			async : false, // 다 끝나고 다음 처리 해!
			success : function(data) {
				if (data.status == 200 && (data.rows).length > 0) {
					rowArr = data.rows;
					$("#pt_s_prod_end_time").text( rowArr[0].s_prod_end_time );
					$("#pt_e_prod_end_time").text( rowArr[0].e_prod_end_time );
					
					$("#pt_product_po").text( rowArr[0].product_po );
					$("#pt_mill_sheet_no").text( rowArr[0].mill_sheet_no );
					$("#pt_prod_end_time").text( rowArr[0].prod_end_time );
					
					$("#pt_item_code").text( rowArr[0].item_code );
					$("#pt_item_nm").text( rowArr[0].item_nm );
					$("#pt_member_nm").text( rowArr[0].member_nm );
					$("#pt_sn").text( rowArr[0].sn );
					$("#pt_customer_nm").text( rowArr[0].customer_nm );
					

					$("#pt_site").text( "" ); // key in
					$("#pt_prod_menge").text( rowArr[0].prod_menge );
					$("#pt_prod_fail_menge").text( rowArr[0].prod_fail_menge );
					$("#pt_f_prod_menge").text( rowArr[0].f_prod_menge );
					
					for(var i=0; i<rowArr.length; i++) {
							
						if( ssss == "N" ) { // 이미지 x
							if(i <= 7) {
								$("#grid_print_"+nxtIdx ).find( "#pt_inspection_item_"+(i+1) ).text( rowArr[i].inspection_item );
								$("#grid_print_"+nxtIdx ).find( "#pt_inspection_tool_"+(i+1) ).text( rowArr[i].inspection_tool );
								$("#grid_print_"+nxtIdx ).find( "#pt_code_nm_"+(i+1) ).text( rowArr[i].code_nm );
								$("#grid_print_"+nxtIdx ).find( "#pt_point_"+(i+1) ).text( rowArr[i].inspection_point );
								$("#grid_print_"+nxtIdx ).find( "#pt_spec_"+(i+1) ).text( rowArr[i].spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_min_spec_"+(i+1) ).text( rowArr[i].min_spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_max_spec_"+(i+1) ).text( rowArr[i].max_spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_insp_val_"+(i+1) ).text( rowArr[i].insp_val );
								$("#grid_print_"+nxtIdx ).find( "#pt_insp_rst_"+(i+1) ).text( rowArr[i].insp_rst );
								$("#grid_print_"+nxtIdx ).find( "#pt_comment_"+(i+1) ).text( rowArr[i].comment );
								
								if( rowArr.length != 1 ) {
									$(".pt_hidden").css('visibility', 'hidden');
								} else {
									$(".pt_hidden").css('visibility', '');
								}
							} 
							
							if(i > 7) {
	// 							console.log( "i = " + i + ", (parseInt(i)%8) = " + (parseInt(i)%8) );
								// 8 개 맞추면 0 // 오버하면 1이니.. 이거 1이면 다음 페이지 하나 더 만들어주자 ㅇㅇ
								if ( i == 8  /* 8장 넘으면. */ || (parseInt(i-7)%14) == 1 ){ // 처음 8일때는 (i+1)%8) == 1 >> 현재는 > (parseInt(i-7)%14) == 1 
									nxtIdx++;
									
									var div = $("<div>");
									div.addClass('text-center');
									div.attr("style", "width: 100%; margin-top:40px; display: none;");
									div.attr("id", "grid_print_"+nxtIdx);
									
									$("#printDiv").append( div );
									
// 									$("#grid_print_"+(nxtIdx) ).load("/frontend/location/info/q_fn_insp_doc3");
									
									$(".pt_hidden").css('visibility', 'hidden'); // $("#grid_print_"+nxtIdx ).find(".pt_hidden").css('visibility', 'hidden');
									
								}
								
							} 
							
						 }  else { // 이미지 o
							 if ( i == 0 || (parseInt(i+1)%14) == 1 ){ // 처음 8일때는 (i+1)%8) == 1 >> 현재는 > (parseInt(i-7)%14) == 1 
									nxtIdx++;
									
									var div = $("<div>");
									div.addClass('text-center');
									div.attr("style", "width: 100%; margin-top:40px; display: none;");
									div.attr("id", "grid_print_"+nxtIdx);
									
									$("#printDiv").append( div );
									
// 									$("#grid_print_"+(nxtIdx) ).load("/frontend/location/info/q_fn_insp_doc3");
									
									$(".pt_hidden").css('visibility', 'hidden'); // $("#grid_print_"+nxtIdx ).find(".pt_hidden").css('visibility', 'hidden');
									
								}
							 
						  }
					}

				} else if (data.status == 200 && (data.rows).length == 0) {
					$("#pt_product_po").text( datas.product_po );
					$("#pt_item_code").text( datas.item_code );
					$("#pt_item_nm").text( datas.item_nm );
				}
			},
			complete : function() {
				$("#grid_print_" + nxtIdx ).find(".pt_hidden").css('visibility', 'hidden');
				$("#grid_print_" + nxtIdx ).find("#pt_stp_date").text( getFormatDate(new Date()) );
				
				$("#tableT").css("text-align", "center");
				$("#modal_print").modal('show');
			}
		});
		
// 		$("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2");
// 		$("#modal_print").modal('show');
		
		
	} else {
		fnMessageModalAlert("알림", "발행하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
	}
}

function print() {
	console.log("print()");
	var key = w2ui.grid_list.getSelection();
// 		$("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2");
		
		var nxtIdx = 1;
		
		// 값 불러오고 완료 후에 붙여주기.
		var datas = w2ui.grid_list.get(key[0]);
		
		var page_url = "/info/print/selectPrintFI";
		var postData = "product_po=" + encodeURIComponent(datas.product_po)
				+ "&routing_code=" + encodeURIComponent(datas.routing_code);

		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData, 
			dataType : 'json',
			async : false, // 다 끝나고 다음 처리 해!
			success : function(data) {
				if (data.status == 200 && (data.rows).length > 0) {
					
					rowArr = data.rows;
					$("#pt_s_prod_end_time").text( rowArr[0].s_prod_end_time );
					$("#pt_e_prod_end_time").text( rowArr[0].e_prod_end_time );
					
					$("#pt_product_po").text( rowArr[0].product_po );
					$("#pt_mill_sheet_no").text( rowArr[0].mill_sheet_no );
					$("#pt_prod_end_time").text( rowArr[0].prod_end_time );
					
					$("#pt_item_code").text( rowArr[0].item_code );
					$("#pt_item_nm").text( rowArr[0].item_nm );
					$("#pt_member_nm").text( rowArr[0].member_nm );
					$("#pt_sn").text( rowArr[0].sn );
					$("#pt_customer_nm").text( rowArr[0].customer_nm );
					

					$("#pt_site").text( "" ); // key in
					$("#pt_prod_menge").text( rowArr[0].prod_menge );
					$("#pt_prod_fail_menge").text( rowArr[0].prod_fail_menge );
					$("#pt_f_prod_menge").text( rowArr[0].f_prod_menge );
					
					for(var i=0; i<rowArr.length; i++) {
						
						var ssss = $(":radio[name='rdo_img_yn']:checked").val();
// 						console.log("ssss = " + ssss );
							
						if( ssss == "N" ) { // 이미지 x
							if(i <= 7) {
								$("#grid_print_"+nxtIdx ).find( "#pt_inspection_item_"+(i+1) ).text( rowArr[i].inspection_item );
								$("#grid_print_"+nxtIdx ).find( "#pt_inspection_tool_"+(i+1) ).text( rowArr[i].inspection_tool );
								$("#grid_print_"+nxtIdx ).find( "#pt_code_nm_"+(i+1) ).text( rowArr[i].code_nm );
								$("#grid_print_"+nxtIdx ).find( "#pt_point_"+(i+1) ).text( rowArr[i].inspection_point );
								$("#grid_print_"+nxtIdx ).find( "#pt_spec_"+(i+1) ).text( rowArr[i].spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_min_spec_"+(i+1) ).text( rowArr[i].min_spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_max_spec_"+(i+1) ).text( rowArr[i].max_spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_insp_val_"+(i+1) ).text( rowArr[i].insp_val );
								$("#grid_print_"+nxtIdx ).find( "#pt_insp_rst_"+(i+1) ).text( rowArr[i].insp_rst );
								$("#grid_print_"+nxtIdx ).find( "#pt_comment_"+(i+1) ).text( rowArr[i].comment );
							} 
							
							if(i > 7) {
	// 							console.log("i > 7 i = " + i );
								var idxVV = 1;
								
								if ( i == 8  /* 8장 넘으면. */ || (parseInt(i-7)%14) == 1 ){  // 처음 8일때는 (i+1)%8) == 1 >> 현재는 > (parseInt(i-7)%14) == 1 
									nxtIdx++;
									
									$("#grid_print_"+nxtIdx ).css('display', '');
									$("#grid_print_"+nxtIdx ).find(".pt_hidden").css('visibility', 'hidden');
								}
								
								idxVV = (parseInt(i-7)%14); // 8
								if(idxVV == 0) {
// 									console.log("parseInt(i)%14");
									idxVV = 14;
								}
								
								$("#grid_print_"+nxtIdx ).find( "#pt_inspection_item_"+idxVV ).text( rowArr[i].inspection_item );
								$("#grid_print_"+nxtIdx ).find( "#pt_inspection_tool_"+idxVV ).text( rowArr[i].inspection_tool );
								$("#grid_print_"+nxtIdx ).find( "#pt_code_nm_"+idxVV ).text( rowArr[i].code_nm );
								$("#grid_print_"+nxtIdx ).find( "#pt_point_"+idxVV ).text( rowArr[i].inspection_point );
								$("#grid_print_"+nxtIdx ).find( "#pt_spec_"+idxVV ).text( rowArr[i].spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_min_spec_"+idxVV ).text( rowArr[i].min_spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_max_spec_"+idxVV ).text( rowArr[i].max_spec );
								$("#grid_print_"+nxtIdx ).find( "#pt_insp_val_"+idxVV ).text( rowArr[i].insp_val );
								$("#grid_print_"+nxtIdx ).find( "#pt_insp_rst_"+idxVV ).text( rowArr[i].insp_rst );
								$("#grid_print_"+nxtIdx ).find( "#pt_comment_"+idxVV ).text( rowArr[i].comment );
							} 
						} else { // 이미지 o

// 							console.log("i > 7 i = " + i );
							var idxVV = 1;
							
							if ( i == 0 || (parseInt(i+1)%14) == 1 ){  // 처음 8일때는 (i+1)%8) == 1 >> 현재는 > (parseInt(i-7)%14) == 1 
								nxtIdx++;
								
								$("#grid_print_"+nxtIdx ).css('display', '');
								$("#grid_print_"+nxtIdx ).find(".pt_hidden").css('visibility', 'hidden');
							}
							
							idxVV = (parseInt(i+1)%14); // 8
							if(idxVV == 0) {
// 								console.log("parseInt(i)%14");
								idxVV = 14;
							}
							
							$("#grid_print_"+nxtIdx ).find( "#pt_inspection_item_"+idxVV ).text( rowArr[i].inspection_item );
							$("#grid_print_"+nxtIdx ).find( "#pt_inspection_tool_"+idxVV ).text( rowArr[i].inspection_tool );
							$("#grid_print_"+nxtIdx ).find( "#pt_code_nm_"+idxVV ).text( rowArr[i].code_nm );
							$("#grid_print_"+nxtIdx ).find( "#pt_point_"+idxVV ).text( rowArr[i].inspection_point );
							$("#grid_print_"+nxtIdx ).find( "#pt_spec_"+idxVV ).text( rowArr[i].spec );
							$("#grid_print_"+nxtIdx ).find( "#pt_min_spec_"+idxVV ).text( rowArr[i].min_spec );
							$("#grid_print_"+nxtIdx ).find( "#pt_max_spec_"+idxVV ).text( rowArr[i].max_spec );
							$("#grid_print_"+nxtIdx ).find( "#pt_insp_val_"+idxVV ).text( rowArr[i].insp_val );
							$("#grid_print_"+nxtIdx ).find( "#pt_insp_rst_"+idxVV ).text( rowArr[i].insp_rst );
							$("#grid_print_"+nxtIdx ).find( "#pt_comment_"+idxVV ).text( rowArr[i].comment );
						}
						
						
					}
					console.log((data.rows).length+"개");
				} else if (data.status == 200 && (data.rows).length == 0) {
					$("#pt_product_po").text( datas.product_po );
					$("#pt_item_code").text( datas.item_code );
					$("#pt_item_nm").text( datas.item_nm );
				}
			},
			complete : function() {
				
				$("#grid_print_" + nxtIdx ).find(".pt_hidden").css('visibility', '');
				$("#grid_print_" + nxtIdx ).find("#pt_stp_date").text( getFormatDate(new Date()) );
				
				$("#tableT").css("text-align", "center");
				
				console.log("인쇄 " +nxtIdx+ "장");
			}
		});
	
	
	
	$("#printDiv").printMe(
		{	"path": ["/res/bootstrap/css/printme.css"]}
	);
	
}


function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
            footer: true
        },
        columns: [                
			{ field:'product_po', caption:'작업지시 번호', size:'15%', style:'text-align:center', sortable: true},
			{ field:'item_code', caption:'P/N', size:'15%', style:'text-align:center', sortable: true},
			{ field:'item_nm', caption:'품명', size:'15%', style:'text-align:center', sortable: true},
			{ field:'', caption:'LOTNo.', size:'10%', style:'text-align:center', hidden:true},
			{ field:'product_menge', caption:'수량', size:'8%', style:'text-align:center', sortable: true},
			{ field:'ok_menge', caption:'합격수량', size:'11%', style:'text-align:center', sortable: true},
			{ field:'prod_fail_menge', caption:'불량수량', size:'11%', style:'text-align:center', sortable: true},
			{ field:'ng_rate', caption:'불량율', size:'10%', style:'text-align:center', sortable: true, 
				render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
					return html + "%";	
              	}
			},
			{ field:'product_req_date', caption:'생산요청일자', size:'14%', style:'text-align:center', sortable: true},
			{ field:'end_time', caption:'검사완료일자', size:'14%', style:'text-align:center', sortable: true, 
				render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
					if(html) {
		       	     return moment(html).format('YYYY-MM-DD');
					} else {
	       			 return "";	
					}
              	}
			},
			{ field:'', caption:'검사 방법', size:'10%', style:'text-align:center', hidden:true},
			{ field:'routing_code', caption:'공정코드', size:'11%', style:'text-align:center', sortable: true},
			{ field:'routing_nm', caption:'공정명', size:'11%', style:'text-align:center', sortable: true},
			{ field:'flag', caption:'진행상태', size:'10%', style:'text-align:center', sortable: true},
			{ field:'file_path', caption:'file_path', size:'10%', style:'text-align:center', hidden:true, 
				render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
					if(html) {
		       	     return "Y";	
					} else {
	       			 return "N";	
					}
              	}
			}
			
			], 
		records: [
		],
		onReload: function(event) {
		},
		onSelect: function (event) {
			event.onComplete = function () {
				var key = w2ui.grid_list.getSelection();
				var data = w2ui.grid_list.get(key[0]);
				if( onSelectKey ) {
					key = onSelectKey;
					data = w2ui.grid_list.get(key);
				}
				
				var file_path = data.file_path; // w2ui.grid_list.get(event.recid)
// 				console.log("file_path = " + file_path);
				if(file_path) {
// 					$("#imgRadioHd").css('display', '');
					$(":radio[name='rdo_img_yn']").attr('disabled', false);
										
					radioCheck();
					$('input:radio[name="rdo_img_yn"]:input[value="Y"]').iCheck('check');
			 		$(':radio[name="rdo_img_yn"]').iCheck('update');
	
				} else{
// 					$("#imgRadioHd").css('display', 'none');
					$(":radio[name='rdo_img_yn']").attr('disabled', true);
					
					$('input:radio[name="rdo_img_yn"]:input[value="N"]').iCheck('check');
			 		$(':radio[name="rdo_img_yn"]').iCheck('update');
			 	}
				
				var item_code = data.item_code;
				var routing_code = data.routing_code;
				var product_po = data.product_po;
				
				var item_nm = data.item_nm;
				var product_req_date = data.product_req_date;
				var routing_nm = data.routing_nm;
				
				loadChk(item_code, routing_code, product_po);
				
				$("#printDiv").empty(); // 동적 생성 초기화
				var div = $("<div>");
				div.addClass('text-center');
				div.attr("style", "width: 100%;");
				div.attr("id", "grid_print_1");
				
				$("#printDiv").append( div );
				
				 var ssss = $(":radio[name='rdo_img_yn']:checked").val();
				
				 if(file_path && ssss == "Y" ) { // 이미지 o
// 					 $("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2_1");
				 }  else { // 이미지 x
// 					 $("#grid_print_1").load("/frontend/location/info/q_fn_insp_doc2");
				 }
				 onSelectKey = "";
			}
		},
		onUnselect: function (event) {
			w2ui['grid_chk'].clear();
			w2ui['grid_inpt'].clear();
		}
	});

}

function init_grid_list2(){
	
	$('#grid_chk').w2grid({ 
        name: 'grid_chk',
        show: {
            footer: true
        },
        multiSelect: true,
        columns: [                
				{ field:'recid', caption:'NO', size:'5%', style:'text-align:center'},
              	{ field:'inspection_seq', caption:'inspection_seq', size:'5%', style:'text-align:center', hidden:true},
    			{ field:'routing_nm', caption:'공정명', size:'10%', style:'text-align:center'},
    			{ field:'inspection_time', caption:'작업시간(LOT)', size:'10%', style:'text-align:center', hidden:true},
    			{ field:'product_menge', caption:'투입수량', size:'10%', style:'text-align:center'},
    			{ field:'worker', caption:'작업자', size:'10%', style:'text-align:center', editable : { type: 'text'}},
    			{ field:'inspection_item', caption:'검사항목', size:'10%', style:'text-align:center'},
    			{ field:'spec', caption:'SPEC(mm)', size:'10%', style:'text-align:center'},
    			{ field:'dfct_cnt', caption:'불량수량', size:'10%', style:'text-align:center'},
    			{ field:'comment', caption:'불량내용', size:'10%', style:'text-align:center', editable : { type: 'text'}},
    			{ field:'end_time', caption:'검사종료시간', size:'15%', style:'text-align:center'}
			], 
		records: [
		],	//
		onReload: function(event) {
		},
		onClick: function (event) {
		},
		onSelect: function (event) {
			event.onComplete = function () {
				loadInpt();
			}
		},
		onUnselect: function (event) {
			w2ui['grid_inpt'].clear();
		}
	});

}
function init_grid_list3(){
	var rowArr = [];
	
	$('#grid_inpt').w2grid({ 
        name: 'grid_inpt',
        show: {
        	lineNumbers: true,
            footer: true
        },
        multiSelect: false,
        columns: [                

			{ field:'inspection_item', caption:'검사 항목 ', size:'10%', style:'text-align:center'}, // 120px
			{ field:'sample_type', caption:'샘플타입', size:'10%', style:'text-align:center', hidden:true},
			{ field:'spec', caption:'검사기준', size:'10%', style:'text-align:center'},
			{ field:'min_spec', caption:'규격(LSL)', size:'10%', style:'text-align:center'},
			{ field:'max_spec', caption:'규격(USL)', size:'10%', style:'text-align:center'},
			{ field:'insp_val', caption:'측정 data', size:'10%', style:'text-align:center'},
			{ field:'insp_rst', caption:'측정결과', size:'10%', style:'text-align:center'}
			

			], 
		records: [
		          
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}
// $("#m_item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#m_item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('item_nm key_up : '+ value);
		
// 		getItemInfo('nm',value);
// 		return value
// 	});
	
// 	},400));
	
// 	$("#m_item_code").change(
			
// 			_.debounce(function(event) 
// 			{
		
// 				var item_code = $("#m_item_code").val();
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
// 					$("#m_item_nm").val(result);
// 				}
// 			});

// 			if(result == ''){
// 				$("#m_item_nm").val('');
// 			}
			
// 		}else if(type == 'nm')
// 		{
			
// 			$.each(gridDataArr, function(idx, row){
				
// 				if(value == row.item_nm)
// 				{
// 					console.log('row.item_code : ' + row.item_code);
// 					result = row.item_code;
// 					$("#m_item_code").val(result);
// 				}
// 			});
// 			if(result == ''){
// 				$("#m_item_code").val('');
// 			}
			
// 		}

		
		
// 	}

//-------------------------------------------------------------------------------------------------------------------
var gridDataArr;
comboValue_no = new Array;
comboValue_cd = new Array;
comboValue_nm = new Array;

//왼쪽 리스트 조회
function loadList()
{
	w2ui['grid_list'].clear();
	w2ui['grid_chk'].clear();
	w2ui['grid_inpt'].clear();
	
	var page_url = "/frontend/insp/selcInspMain_final";
	var postData = "product_po=" + encodeURIComponent($("#m_product_po").val())
			+ "&item_code=" + encodeURIComponent($("#m_item_code").val())
			+ "&item_nm=" + encodeURIComponent($("#m_item_nm").val())
			+ "&flag=" + encodeURIComponent($("#m_flag").val())
			+ "&product_req_date=" + encodeURIComponent($("#m_product_req_date").val());

	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		async : false, // 다 끝나고 다음 처리 해!
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {

				rowArr = data.rows;
				$.each(rowArr, function(idx, row) {
					row.recid = idx + 1;
					row.ok_menge = Number(row.product_menge) - Number(row.prod_fail_menge)
					row.ng_rate = Math.floor(((Number(row.prod_fail_menge)/Number(row.product_menge))*100)*100)/100;
					
					row.product_menge = Number(row.product_menge);
					row.ok_menge = Number(row.ok_menge);
					row.prod_fail_menge = Number(row.prod_fail_menge);
					if (startValue_combo == "") {						
						gridDataArr = rowArr;
						comboValue_no.push(row.product_po);
						comboValue_cd.push(row.item_code);
						comboValue_nm.push(row.item_nm);
					}
				});
				w2ui['grid_list'].records = rowArr;
// 				if (startValue_combo == "") {
					
// 				}
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_list'].clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			$('#m_product_po').w2field('combo', { items: _.uniq(comboValue_no,false), match : 'contains' });
			$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
			$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
		},
		complete : function() {
			startValue_combo = ":)";
	
			document.getElementById("m_product_po").style.removeProperty("height");
			document.getElementById("m_item_code").style.removeProperty("height");
			document.getElementById("m_item_nm").style.removeProperty("height");
		}
	});
	
}

//-------------------------------------------------------------------------------------------------------------------

function loadChk(item_code, routing_code, product_po)
{
	w2ui['grid_chk'].clear();
	w2ui['grid_inpt'].clear();
	
	var page_url = "/frontend/insp/selcInspChkSht";
	var postData = "item_code=" + encodeURIComponent(item_code)
			+ "&product_po=" + encodeURIComponent(product_po)
			+ "&routing_code=" + encodeURIComponent(routing_code);

	w2ui['grid_chk'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row) {
					row.recid = idx + 1;
				});
				w2ui['grid_chk'].records = rowArr;
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_chk'].clear();
			} else {
				w2ui['grid_list'].clear();
				w2ui['grid_chk'].clear();
				w2ui['grid_inpt'].clear();
			}
			w2ui['grid_chk'].refresh();
			w2ui['grid_chk'].unlock();
		},
		complete : function() {
		}
	});
	
}


//-------------------------------------------------------------------------------------------------------------------

//오른쪽 하단 리스트 조회
function loadInpt()
{
	w2ui['grid_inpt'].clear();

	var selIdxArr = w2ui.grid_chk.getSelection();	//$('#p_slot').html();
	var product_po = w2ui.grid_chk.get(selIdxArr[0]).product_po;
	var item_code = w2ui.grid_chk.get(selIdxArr[0]).item_code;
	var routing_code = w2ui.grid_chk.get(selIdxArr[0]).routing_code;
	var inspection_seq = w2ui.grid_chk.get(selIdxArr[0]).inspection_seq;
	var product_menge = w2ui.grid_chk.get(selIdxArr[0]).product_menge;
	
	var spec = w2ui.grid_chk.get(selIdxArr[0]).spec;
	var min_spec = w2ui.grid_chk.get(selIdxArr[0]).min_spec;
	var max_spec = w2ui.grid_chk.get(selIdxArr[0]).max_spec;
	var inspection_gubun = w2ui.grid_chk.get(selIdxArr[0]).inspection_gubun;
	
	var page_url = "/frontend/insp/selcInspRstVal";
	var postData = "product_po=" + encodeURIComponent(product_po)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&routing_code=" + encodeURIComponent(routing_code)
			+ "&inspection_seq=" + encodeURIComponent(inspection_seq)
			+ "&sample_type=" + encodeURIComponent('c');
	w2ui['grid_inpt'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				var r_insp_case = '';
				rowArr = data.rows;
				$.each(rowArr, function(idx, row) {
					row.recid = idx + 1;
					row.inspection_item = w2ui.grid_chk.get(w2ui.grid_chk.getSelection()[0]).inspection_item;;
					
				});
				w2ui['grid_inpt'].records = rowArr;
				w2ui['grid_inpt'].refresh();
				w2ui['grid_inpt'].unlock();
				
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_inpt'].clear();
			} else {
				w2ui['grid_inpt'].clear();
				fnMessageModalAlert('알림', '데이터를 불러오는데 실패했습니다.');
			}
			
		},
		complete : function() {
			w2ui['grid_inpt'].refresh();
			w2ui['grid_inpt'].unlock();
		}
	});
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

function excelFileDownload()
{
	
	var key = w2ui.grid_list.getSelection();
	
	if(key.length!=1){
		fnMessageModalAlert("알림", "선택된 항목이 없습니다.");
		return;
	}
	
		
	var eData = w2ui.grid_list.get(key[0]);
	
	
		
	var gridCols = w2ui['grid_inpt'].columns;
	var gridData = w2ui['grid_inpt'].records;

	var fileName = '최종검사이력_작업실적.xlsx';
	var sheetTitle = '작업실적';
	var sheetName = '작업실적';
	
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

	FunLoadingBarStart();
	var export_url = "/export/export_fnsh_insp";
	var export_data = "product_po="+encodeURIComponent(eData.product_po);
		export_data += "&routing_code="+encodeURIComponent(eData.routing_code);
	
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
			FunLoadingBarEnd();
		}
	});
}

function loadInspData()
{
	var selIdxArr = w2ui.grid_list.getSelection()[0];
	
	var product_po = w2ui.grid_list.get(selIdxArr).product_po;
	var item_code = w2ui.grid_list.get(selIdxArr).item_code;
	var routing_code = w2ui.grid_list.get(selIdxArr).routing_code;
	var product_menge = w2ui.grid_list.get(selIdxArr).product_menge;
	
	
	var page_url = "/insp/selcInspValue";
	var postData = "product_po=" + encodeURIComponent(product_po)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&routing_code=" + encodeURIComponent(routing_code)
			+ "&product_menge=" + encodeURIComponent(product_menge)
			+ "&sample_type=" + encodeURIComponent("c");
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				rowArr = data.rows;
				
				//검사항묵 정보
				var inspInfo = _.uniqBy(rowArr, 'inspection_seq');
				//생산수량
				var menge = _.uniqBy(rowArr, 'val_seq').length;
				
				//값이 들어갈 배역 세팅
				var arr = new Array();
				
				for(var i=0 ; i<menge; i++)
				{
					var obj = new Object();
					
					obj.insp_info = i+1;
					
					for(var j=0 ; j<inspInfo.length; j++)
					{
						obj["col_"+(j+1)] = '';
						obj["col_"+(j+1)+"_rst"] = '';
						obj["col_"+(j+1)+"_c_insp_ng_cnt"] = '';
					}
					arr.push(obj);
				}
				
				//값 입력
				var arrSeq = 0;
				var valSeq = 0;
				
				for(var i=0 ; i<rowArr.length; i++)
				{
					arr[arrSeq]["col_"+(valSeq+1)] = rowArr[i].insp_val;
					arr[arrSeq]["col_"+(valSeq+1)+"_rst"] = rowArr[i].insp_rst;
					arr[arrSeq]["col_"+(valSeq+1)+"_c_insp_ng_cnt"] = rowArr[i].insp_cnt_c;
					
					arrSeq++;
					
					if(arrSeq == menge)
					{
						arrSeq = 0;
						valSeq++;
					}				
				}
				
				$.each(arr, function(idx, row) {
					row.recid = idx + 1;
				
					var ngFlag = 0;
					var rstFlag = 0;
					var emptyFlag = 0;
					
					for(var i=0 ; i<inspInfo.length; i++)
					{
						if(row["col_"+(i+1)+"_c_insp_ng_cnt"] > 0)
						{
							rstFlag++;	
						}
						
						if(row["col_"+(i+1)+"_rst"].length == 0)
						{
							emptyFlag++;	
						}
					}
					
					if(emptyFlag == inspInfo.length)
					{
						row.insp_rst = '';
					} else {
						if(rstFlag > 0)
						{
							row.insp_rst = 'NG';
						} else {
							row.insp_rst = 'OK';
						}	
					}
						
					for(var i=0 ; i<inspInfo.length; i++)
					{
						if(row["col_"+(i+1)+"_c_insp_ng_cnt"] > 0)
						{
							row["edit_mode_" + (i+1)] = 'NG'
							if(row["col_"+(i+1)+"_rst"] == 'NG' && row["col_"+(i+1)].length > 0)
								row["edit_mode_" + (i+1)] = 'OK'	
						} else {
							row["edit_mode_" + (i+1)] = 'OK'
						}
					}
				});
				
				var arrHeader = new Array();
							
				var obj = new Object();
				obj.insp_info = "";
				obj.insp_rst = "";
				for(var j=0 ; j<inspInfo.length; j++)
				{
					obj["col_"+(j+1)] = inspInfo[j].inspection_item;
					obj["col_"+(j+1)+"_rst"] = '';
					obj["col_"+(j+1)+"_c_insp_ng_cnt"] = '';
					obj["edit_mode"+(j+1)] = '';
				}
				obj["insp_rst"] = '측정결과';
				arrHeader.push(obj);
				
				obj = new Object();
				obj.insp_info = "Inspection Point";
				obj.insp_rst = "";
				for(var j=0 ; j<inspInfo.length; j++)
				{
					obj["col_"+(j+1)] = inspInfo[j].inspection_point;
					obj["col_"+(j+1)+"_rst"] = '';
					obj["col_"+(j+1)+"_c_insp_ng_cnt"] = '';
					obj["edit_mode"+(j+1)] = '';
				}
				arrHeader.push(obj);
				
				obj = new Object();
				obj.insp_info = "SPEC";
				obj.insp_rst = "";
				for(var j=0 ; j<inspInfo.length; j++)
				{
					obj["col_"+(j+1)] = inspInfo[j].spec;
					obj["col_"+(j+1)+"_rst"] = '';
					obj["col_"+(j+1)+"_c_insp_ng_cnt"] = '';
					obj["edit_mode"+(j+1)] = '';
				}
				arrHeader.push(obj);
				
				obj = new Object();
				obj.insp_info = "LSL";
				obj.insp_rst = "";
				for(var j=0 ; j<inspInfo.length; j++)
				{
					obj["col_"+(j+1)] = inspInfo[j].min_spec;
					obj["col_"+(j+1)+"_rst"] = '';
					obj["col_"+(j+1)+"_c_insp_ng_cnt"] = '';
					obj["edit_mode"+(j+1)] = '';
				}
				arrHeader.push(obj);
				obj = new Object();
				obj.insp_info = "USL";
				obj.insp_rst = "";
				for(var j=0 ; j<inspInfo.length; j++)
				{
					obj["col_"+(j+1)] = inspInfo[j].max_spec;
					obj["col_"+(j+1)+"_rst"] = '';
					obj["col_"+(j+1)+"_c_insp_ng_cnt"] = '';
					obj["edit_mode"+(j+1)] = '';
				}
				arrHeader.push(obj); 
				
				var t_arr = arrHeader.concat(arr);
				
				
				$.each(t_arr, function(idx, row) {
					row.recid = idx + 1;
					
					if(idx == 0 || idx == 1 || idx == 2 || idx == 3 || idx == 4){
						var obj = new Object();
						obj.style = "background-color: #e9e9e9;font-weight: bold;";
						
						row.w2ui = obj;	
					}
				});
				
				drawRprt(inspInfo, t_arr);
				
			}	
		}, complete : function() {
					
		}
	});
}


function drawRprt(inspInfo, t_arr)
{
	var my_tbody = document.getElementById('my0-tbody_2');
	
	var r_data = new Array();
	
	var insp_cnt = inspInfo.length;
	
	for(var i=0 ; i<t_arr.length; i++) {
		var oRow = my_tbody.insertRow();
		
		var objArr = new Array();
		
		for(var j=0 ; j<insp_cnt+2; j++)
		{
			var tmpCell = oRow.insertCell();
			tmpCell.id = "rCell"+(j+1);
			tmpCell.style["text-align"] = "center";
			
			if(j == 0)
			{
				tmpCell.style["width"] = '10%';
			} 
			else if(j == insp_cnt+1)
			{
				tmpCell.style["width"] = '10%';
			}
			else {
				tmpCell.style["width"] = (80/insp_cnt) + "%";	
			}			
			
			if(i>=0 && i<=4)
			{
				if(i==0)
					tmpCell.style["font-weight"] = "bold";
					
				tmpCell.style["background-color"] = "#d3d3d39e";
			}
			if(j == 0)
			{
				tmpCell.style["background-color"] = "#d3d3d39e";
				tmpCell.style["font-weight"] = "bold";
			}
			
			objArr.push(tmpCell);
		}
		
		for(j=0 ; j<insp_cnt+2; j++)
		{	
			if(j==0)
				objArr[j].innerHTML=  "<font style='font-size: 10px; text-align: center;'><small>" + t_arr[i].insp_info +"</small></font>";
			else if(j == insp_cnt+1)
				objArr[j].innerHTML=  "<font style='font-size: 10px; text-align: center;'><small>" + t_arr[i].insp_rst +"</small></font>";
			else
				objArr[j].innerHTML=  "<font style='font-size: 10px; text-align: center;'><small>" + t_arr[i]["col_"+j] +"</small></font>";
		}
	}
	
	
	$('#my0-tbody_0 table,#my0-tbody_0 th, #my0-tbody_0 td').css('border','0.5px solid black');
	$('#my0-tbody_0 table,#my0-tbody_0 th, #my0-tbody_0 td').css('border-collapse','collapse');
	
	$('#my0-tbody_1 table,#my0-tbody_1 th, #my0-tbody_1 td').css('border','0.5px solid black');
	$('#my0-tbody_1 table,#my0-tbody_1 th, #my0-tbody_1 td').css('border-collapse','collapse');
	
	$('#my0-tbody_2 table,#my0-tbody_2 th, #my0-tbody_2 td').css('border','0.5px solid black');
	$('#my0-tbody_2 table,#my0-tbody_2 th, #my0-tbody_2 td').css('border-collapse','collapse');
	
	$('#my0-tbody_3 table,#my0-tbody_3 th, #my0-tbody_3 td').css('border','0.5px solid black');
	$('#my0-tbody_3 table,#my0-tbody_3 th, #my0-tbody_3 td').css('border-collapse','collapse');
	
	$('#my0-tbody_0 tr').css('height','25px');
	$('#my0-tbody_0 td').css('text-align','center');
	$('#my0-tbody_0 td').css('font-size','10px');
	$('#rpt_title').css('font-size','20px');
	
	$('.ctt-nm').css('background-color','#d3d3d39e');
	
	
	
	setTimeout(function () {
		$("#doctest").printMe(
			{"path": ["/res/plugins/final_rpt_printme.css"]}
		);	

		for(var i=0 ; i<t_arr.length-1; i++) {
			document.getElementById("my0-tbody_2").deleteRow(1);	
		}	
		document.getElementById("my0-tbody_2").deleteRow(0);
		
		FunLoadingBarEnd();	
	}, 1000);

}

function printRpt()
{
	$("#pt_s_prod_end_time").text("");
	$("#pt_e_prod_end_time").text("");
	$("#pt_product_po").text("");
	$("#pt_mill_sheet_no").text("");
	$("#pt_prod_end_time").text("");
	$("#pt_item_code").text("");
	$("#pt_item_nm").text("");
	$("#pt_member_nm").text("");
	$("#pt_sn").text("");
	$("#pt_customer_nm").text("");
	$("#pt_site").text("");
	$("#pt_prod_menge").text("");
	$("#pt_prod_fail_menge").text("");
	$("#pt_f_prod_menge").text("");
	$("#pt_comment").text("");
	$("#pt_stp_date").text("");
	$("#my0-tbody_1").empty();
	
	var key = w2ui.grid_list.getSelection();
	
	if(key.length!=1){
		fnMessageModalAlert("알림", "발행하고자 하는 항목을 1개 선택하여야 합니다.");
		return;
	}
	
	if( key.length==1 ) {
		
		var datas = w2ui.grid_list.get(key[0]);
		
		var img_yn = $(":radio[name='rdo_img_yn']:checked").val();
				
		var page_url = "/insp/selectPrtInfo";
		var postData = "product_po=" + encodeURIComponent(datas.product_po)
				+ "&routing_code=" + encodeURIComponent(datas.routing_code);
		
		FunLoadingBarStart();
		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData, 
			dataType : 'json',
			success : function(data) {
				if (data.status == 200 && (data.rows).length > 0) {
					
					loadInspData();
					
					rowArr = data.rows;
					
					$("#pt_s_prod_end_time").text( rowArr[0].s_prod_end_time );
					$("#pt_e_prod_end_time").text( rowArr[0].e_prod_end_time );
					
					$("#pt_product_po").text( rowArr[0].product_po );
					$("#pt_mill_sheet_no").text( rowArr[0].mill_sheet_no );
					$("#pt_prod_end_time").text( rowArr[0].prod_end_time );
					
					$("#pt_item_code").text( rowArr[0].item_code );
					$("#pt_item_nm").text( rowArr[0].item_nm );
					$("#pt_member_nm").text( rowArr[0].member_nm );
					$("#pt_sn").text( rowArr[0].sn );
					$("#pt_customer_nm").text( rowArr[0].customer_nm );
					

					$("#pt_site").text( "" ); // key in
					$("#pt_prod_menge").text( rowArr[0].prod_menge );
					$("#pt_prod_fail_menge").text( rowArr[0].prod_fail_menge );
					$("#pt_f_prod_menge").text( rowArr[0].f_prod_menge );
					
					$("#pt_comment").text( rowArr[0].comment );
					$("#pt_stp_date").text( getFormatDate(new Date()) );
					
					
					
					
					
					if(img_yn == 'Y')
					{
						$("#img_tbl").css("display","");
						$("#insp_val_area").addClass('endline');
						
						$("#my0-tbody_1").append(
						 '<tr>'
						+	'<td style="text-align:center; height:450px;">'
						+		'<img src="" style="max-height:450px;max-width:850px; padding:10px;" id="insp_img">'
						+	'</td>'
						+'</tr>');
					} else{
						
						$("#img_tbl").css("display","none");
						$("#insp_val_area").removeClass('endline');
					} 
				
					
					
					var url = window.location.href.substring(0, window.location.href.length - window.location.pathname.length) + '/doc/';
					var path = datas.file_path;
					url = url + path; 			
					
					var image = document.getElementById('insp_img'); 
					image.src = url;
					
					
				}
			}
		});
	}
}
</script>

</body>
</html>