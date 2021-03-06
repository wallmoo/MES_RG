<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
   String thema = "purple"; //SessionUtil.getProperties("mes.thema");
   String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
   String memberId = SessionUtil.getMemberId(request);
   String memberNm = SessionUtil.getMemberNm(request);
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
      <jsp:param name="selected_menu_p_cd" value="1042" />
      <jsp:param name="selected_menu_cd" value="1057" />
   </jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
       	작업지시 및 실적관리
        <small>생산관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>작업지시 및 실적관리</a></li><li class="active">생산관리</li>
      </ol>
    </section>

     <section class="content">
      <div class="row" style="position: relative; height:600px;">
         <div class="row" style="position: absolute; width: 55%; height:600px; margin:0;">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">작업지시 조회</h3>
						<div class="box-tools pull-right">
						<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
				  			<button type="button" id="btn_search_csr" onclick="showPdf();" class="btn btn-info btn-sm">PDF보기</button>
							<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteItem();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
						<div class="row">
							<div class="col-sm-12">
								<div class="col-sm-6">                                                                    
									<div class="form-group">
									<label>작업지시일자</label>
										<div class="input-group">
											<input type="text" 
												class="form-control pull-right input-sm" style="" id="order_day" placeholder="yyyymmdd~yyyymmdd" onChange="loadList();">
											<div class="input-group-addon">
												<i class="fa fa-calendar"></i>
											</div>
										</div>
									</div>
								</div>	
								<div class="col-sm-3">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>진행상태</label> 
										<select id="product_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
											<option value="">전체</option>
											<option value="n">생산전</option>
											<option value="i" selected>진행중</option>
											<option value="y">생산완료</option>
										</select>
									</div>
								</div>
								
								<div class="col-sm-3">    
									<div class="form-group" style="margin-top:0px;">
									<div class="col-sm-10" style="padding-left: 0px;">
						                  <label for="" class="control-label"></label>
						             </div>
						                      
						             <label>
						               <input type="radio" id="rdo_ps_gubun" name="rdo_ps_gubun" class="flat-red form-control" value="P" checked> 생산
						             </label>
						             
						             <label>
						               <input type="radio" id="rdo_ps_gubun" name="rdo_ps_gubun" class="flat-red form-control" value="S" > 수입검사
						             </label>
						             </div>
								</div>
								
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="col-sm-3">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
										 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadlList(); return false;}" />
									</div>
								</div>	
								<div class="col-sm-3">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
										 class="form-control input-sm" 	onkeypress="if(event.keyCode==13) {loadlList(); return false;}" />
									</div>
								</div>	
								<div class="col-sm-3">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>공정명</label> 
										<select id="routing_status" name="routing_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
									
										</select>
									</div>
								</div>
								
								<div class="col-sm-3">
									<div class="form-group" style="margin-bottom: 0px;">
										<label>다음공정</label> 
										<select id="next_routing_nm" name="next_routing_nm" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onChange = "loadList();">
									
										</select>
									</div>
								</div>
								
							</div>
						</div>	
					</div>
					<div id="grid_list" style="height: 520px; margin: 15px"></div>
				</div>
				
			</div>	
            <div class="row" style="position: absolute; right: 45px; width: 42%; height:600px;">
				<div class="row">
					<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">공정관리</h3>
							<div class="box-tools pull-right">
							  <button type="button" id="btn_ban_item_view" onclick="requestView();" class="btn btn-info  btn-sm">재고확인</button>
		                      <button type="button" id="btn_start_work" class="btn btn-primary  btn-sm" onclick="changeProcess('start_work');">작업시작</button>
		                      <button type="button" id="btn_start_unoperate" onclick="changeProcess('start_unoperate');" class="btn btn-warning  btn-sm">비가동시작</button>
		                      <button type="button" id="btn_stop_unoperate" onclick="changeProcess('stop_unoperate');" class="btn btn-danger  btn-sm">비가동종료</button>
		                      <button type="button" id="btn_stop_work" onclick="changeProcess('stop_work');" class="btn btn-info  btn-sm">작업종료</button>
		                      <button type="button" id="btn_stop_product" onclick="changeProcess('stop_product');" class="btn btn-danger  btn-sm">생산종료</button>
		                      
		                   </div>	
						</div>
						<div id="grid_list2" style="height: 300px; margin: 15px""></div>
					</div>
				</div>
				<div class="row">
					<div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">비가동 내역</h3>
							
						</div>
						<div id="grid_list3" style="height: 250px; margin: 15px""></div>
					</div>
				</div>
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
					<h4 class="modal-title" id="modal_code_title">비가동종료</h4>
	        	</div>
				<div class="modal-body" id="modal_code_body">
					<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">비가동 사유</label>
									<div class="col-sm-7">
										<input type="input" id="m_unprod_comment" name="m_unprod_comment" class="form-control input-sm">
									</div>
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
						<button type="button" id="" class="btn btn-success btn-sm" onclick="stopUnOperate();">저장</button>
						<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
<div class="modal fade" id="modal_item" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:70%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_item_title">서브 반제품 조립</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="col-md-12">
						<div class="row">
							<div class="col-sm-6">
								<div class="col-sm-4">
									<div class="form-group" style="margin-right:0;">
										<label>P/N</label> <input type="text" id="m_item_code" name="m_item_code" placeholder="ex) P/N"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {requestMaterial(); return false;}"/>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group" style="margin-right:0;">
										<label>품명</label> <input type="text" id="m_item_nm" name="m_item_nm" placeholder="ex) 품명"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {requestMaterial(); return false;}"/>
									</div>
								</div>
								
								<div class="col-sm-4">
									<label></label>
									<div class="box-tools">
										<button type="button" id="btn_create" 
										class="btn btn-warning btn-sm" onclick="requestMaterial();">검색</button> 
										<button type="button" id="btn_create" 
										class="btn btn-primary btn-sm" onclick="gogoBanItem();">반제품 투입</button>
										
										<!-- <button type="button" id="btn_create" 
										class="btn btn-info btn-sm" onclick="saveProcess();">저장</button> -->
									</div>
								</div>
							</div>
							<div class="col-sm-5">
								<label style="margin-top:30px; font-size:17px;">투입 반제품 확인</label> 
								
							</div>
						<!-- 	<div class="col-sm-1" style="margin-top:30px;">
								<div class="box-tools pull-right">
									<button type="button" id="btn_minus" onclick="minus();" class="btn btn-primary btn-sm">삭제</button>
								</div>			
							</div> -->
						</div>
						</div>
					<div class="row">
						<div class="col-md-6">
							<div id="modalGrid2" style="width: 100%; height: 400px;" ></div>
						</div>
						<div class="col-md-6">
						
							<div id="modalGrid3" style="width: 100%; height: 400px;" ></div>
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
				<!-- 	<button type="button" id="" class="btn btn-success btn-sm" onclick="saveModal();">확인</button> -->
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal" onclick="saveBan();">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_info_view" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:50%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_item_title">반제품 재고 확인</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="col-md-12">
						<div class="row">
							<div class="col-sm-12">
								<div class="col-sm-4">
									<div class="form-group" style="margin-right:0;">
										<label>P/N</label> <input type="text" id="m_item_code2" name="m_item_code2" placeholder="ex) P/N"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {requestMaterial('V'); return false;}"/>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group" style="margin-right:0;">
										<label>품명</label> <input type="text" id="m_item_nm2" name="m_item_nm2" placeholder="ex) 품명"
										 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {requestMaterial('V'); return false;}"/>
									</div>
								</div>
								
								<div class="col-sm-4">
									<label></label>
									<div class="box-tools">
										<button type="button" id="btn_create" 
										class="btn btn-warning btn-sm" onclick="requestMaterial('V');">검색</button> 
									</div>
								</div>
							</div>
			
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div id="modalGrid_view" style="width: 100%; height: 400px;" ></div>
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
				<!-- 	<button type="button" id="" class="btn btn-success btn-sm" onclick="saveModal();">확인</button> -->
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>

	


<!-- 모달 커팅 -->
<div class="modal fade" id="modal_out" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">출고</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
				

			<!-- 		<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">출고일자</label>
							<div class="input-group col-sm-4">
								<input type="text" 
									class="form-control pull-right input-sm" style="" id="m_out_date" onchange="" placeholder="yyyymmdd">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
							</div>
						</div>
					</div> -->
				
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">재고수량</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_warehousing_qty" maxlength="100" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">수량</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_cnt" maxlength="100" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
						</div>
					</div>
					
				<!-- 	<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">담당자</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_out_user" maxlength=50>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-4 control-label">출고사유</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm pull-right clear_val" id="m_out_comment" maxlength=50>
							</div>
						</div>
					</div> -->
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveOut();">저장</button>
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


var comboValue_nm3 = new Array;
var comboValue_nm4 = new Array;

var memberId =  "<%=memberId%>";
var memberNm =  "<%=memberNm%>";

var check_routing_gubun = 'Y';

$(function($) {
	
	//$("#product_status option:eq(2)").prop("selected", true);

    fnLoadCommonOption();     
    fnLoadCommonOption2();
    
    //selectMachine();
    
    init_grid_list();

    init_grid_list2();
    
    init_grid_list3();
    
    
    modalGrid2();
    modalGrid3();
    
    modalGrid_view();
    
   
    
   	loadList();
   	
   
    //loadList2();
    

   	$(":radio[name='rdo_ps_gubun']").on('ifChecked', function(event){
   		  loadList();
   	});
})



// //품명,품번 자동완성
// $("#item_nm").change(_.debounce(function(event) {
	
// 	var item_nm = $("#item_nm").val();
// 	$(this).val(function(index, value) {
// 		console.log('item_nm key_up : '+ value);
		
// 		getItemInfo('nm',value);
// 		return value
// 	});
	
// },400));

// $("#item_code").change(
		
// 		_.debounce(function(event) 
// 		{
	
// 			var item_code = $("#item_code").val();
// 			$(this).val(function(index, value) {
// 				console.log('item_code key_up : '+ value);
				
// 				getItemInfo('cd',value);
// 				return value
// 			});
	
// },400));

// function getItemInfo(type, value)
// {
// 	console.log('getItemInfo() : ' + value);
// 	var result = "";
// 	if(type == 'cd')
// 	{
// 		$.each(gridDataArr, function(idx, row){
			
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
		
// 		$.each(gridDataArr, function(idx, row){
			
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

// init component
function fnLoadCommonOption() {
    console.log('fnLoadCommonOption()');
    
       $('input[type="radio"].flat-red').iCheck({
          checkboxClass: 'icheckbox_flat-green',
          radioClass: 'iradio_flat-green',
          handle: 'radio'
       });
       
       
       var minDate = getFormatDate(new Date());
      $('#macc_chndate, #m_delivery_day, #m_order_day').daterangepicker({
         opens: 'right', 
         singleDatePicker: true,
         locale: {
            format: 'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
            showMonthAfterYear: true,
            yearSuffix: '년',
            orientation: "top left"
         },
         startDate : moment(minDate)
      });
      
       $('#c_prod_day').daterangepicker({
            opens: 'right',
            locale: {
               format : 'YYYYMMDD'   ,
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
}
function fnLoadCommonOption2() {
 	console.log('fnLoadCommonOption2()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
 		 $('#order_day').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'    
			    },
			    startDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(-2, 'month'),
          endDate: moment(minDate)
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
		 { field:'pdf_file_path', caption:'pdf파일path', style:'text-align:center', hidden : true},
		 { field:'pdf_file_name', caption:'pdf파일name', style:'text-align:center', hidden : true},
		 { field:'pdf_file_ext', caption:'pdf파일ext', style:'text-align:center', hidden : true},
		 { field:'pdf_file_size', caption:'pdf파일size', style:'text-align:center', hidden : true},         
		 { field:'down_pdf_file_name', caption:'pdf파일', style:'text-align:left', hidden:true},
	
         { field:'product_po', caption:'작업지시 번호', size:'16%', style:'text-align:center', sortable : true}, // 80px
         { field:'product_status_info', caption:'진행상태', size:'10%', style:'text-align:center', sortable : true
        	 ,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'n')
	            	{
	            	   return '생산전';
	            	}else if(html == 'i')
	            	{
	            		 return '작업시작';
	            	}
	            	else if(html == 'us')
	            	{
	            		 return '비가동시작';
	            	}
	            	else if(html == 'ue')
	            	{
	            		 return '비가동종료';
	            	}
	            	else if(html == 'e')
	            	{
	            		 return '작업종료';
	            	}
	            	else if(html == 'y')
	            	{
	            		 return '생산완료';
	            	}else if(html == 'h')
	            	{
	            		 html =  '<div style="background-color:#000000; color:#ffffff;">'+ 'HOLD'  +'</div>';
	            	}
	            	else if(html == 'nh')
	            	{
	            		 return '작업대기';
	            	}
	               return html;
	           } 	 
         
         }, 
         { field:'routing_code', caption:'공정코드', size:'10%', style:'text-align:center', hidden : true},
         { field:'routing_nm', caption:'공정명', size:'10%', style:'text-align:center', sortable : true
//         	 ,render: function (record, index, col_index) {
// 					var html = this.getCellValue(index, col_index);
// 					var routing_code = w2ui.grid_list.records[index].routing_code; 
	               
// 					html = html + ' ('+ routing_code+')';
// 	               return html;
// 	           } 	
         },
         { field:'next_routing_code', caption:'공정코드', size:'10%', style:'text-align:center', hidden : true},
         { field:'next_routing_nm', caption:'다음공정', size:'10%', style:'text-align:center', sortable : true
        	/*  ,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
					var next_routing_code = w2ui.grid_list.records[index].next_routing_code; 
	               
					html = html + ' ('+ next_routing_code+')';
	               return html;
	           } 	 */
  	
         },
         { field:'product_req_date', caption:'작업지시일자', size:'12%', style:'text-align:center', sortable : true},
         { field:'item_code', caption:'P/N', size:'15%', style:'text-align:center', sortable : true}, // 200px
         { field:'item_nm', caption:'품명', size:'15%', style:'text-align:center', sortable : true}, // 120px
         // 120px
         { field:'product_menge', caption:'수량', size:'7%', style:'text-align:center', sortable : true},
    	 { field:'file_link', caption:'pdf파일', size:'10%', style:'text-align:left', hidden : true},
    	 { field:'one_yn', caption:'원자재불출여부', size:'10%', style:'text-align:left', hidden : true}
		 
         ], 
     
      records: [],  
      onSelect: function (event) {
    	  event.onComplete = function () {
				console.log("onSelect");
				loadList2();
				loadList3();
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list2'].clear();		
				w2ui['grid_list2'].refresh();
				
				w2ui['grid_list3'].clear();		
				w2ui['grid_list3'].refresh();
			}
		},
      onReload: function(event) {
         //loadList();
      },
      onClick: function (event) {}
   });
   //loadList();
}

function init_grid_list2(){
	
	var out_gubun = [
	                 { id:"외주", text:"외주", code:"Y", recid : 0}
	               , { id:"사내", text:"사내", code:"N", recid : 1}
	               
	           ];
	
	
   var rowArr = [];
   
   
// 	out_gubun = new Array();
   
//    var obj = new Objecet();
//    obj.id = 'Y';
//    obj.text = '외주';
//    out_gubun.push(obj);
//    var obj2 = new Objecet();
//    obj2.id = 'N';
//    obj2.text = '사내';
//    out_gubun.push(obj2); 
   
   $('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
         selectColumn: true,
         lineNumbers : true,
         footer: true
        },
        multiSelect: false,
        columns: [   

                  { field:'outsourcing_gubun', caption:'구분', size:'40px', style:'text-align:center',sortable :true
                	  ,render: function (record, index, col_index) {
	                        var html = this.getCellValue(index, col_index);
	
	                      	var machine_gubun = w2ui.grid_list2.records[index].machine_gubun; 
	                      	console.log("machine_gubun:::"+machine_gubun)
	                    	var routing_code = w2ui.grid_list2.records[index].routing_code; 
	                           
	                    	var result = '';


	                    
                        	if(machine_gubun == 'Y')
                        	{
                        		 result = '장비';		
                        	}

                        	if(routing_code.indexOf('-') != -1){
	                    		 
	                    		 result = '자주';
	                    	}	
                        
                          	if(routing_code.indexOf('F') != -1){
	                    		 
	                    		 result = '최종';
	                    	}	
                        	if(html == 'Y')
	                        {
	                    		result = '외주';
	                        }
                        	
                        	if(routing_code.indexOf('Z') != -1){
	                    		 
	                    		 result = '자주';
	                    	}	
	                        
	                    	return result;
	                    	
	                    	
               
                       }          
                  
                  },
                  { field:'outsourcing_gubun', caption:'외주선택', size:'60px', style:'text-align:center' ,sortable :true
                	  ,render: function (record, index, col_index) {
	                        var html = this.getCellValue(index, col_index);
	
	                    	var result = '';
	
                      	if(html == 'Y')
	                        {
	                    		result = '외주';
	                        }
                      	if(html == 'N')
                        {
                    		result = '사내';
                        }
	                        
	                    	return result;
             
                     }       
                  },
                  { field:'routing_code', caption:'공정코드', size:'0%', style:'text-align:center',hidden : true},
                  { field:'routing_nm', caption:'공정명', size:'87px', style:'text-align:center',sortable :true},
                  { field:'routing_gubun', caption:'공정구분', size:'0%', style:'text-align:center', hidden : true},
                  { field:'machine_code', caption:'공정장비코드', size:'69px', style:'text-align:center',sortable :true},
                  { field:'machine_nm', caption:'공정장비', size:'0%', style:'text-align:center', hidden : true},
          
                  { field:'status', caption:'상태', size:'58px', style:'text-align:center',sortable :true
                       ,render: function (record, index, col_index) {
                        var html = this.getCellValue(index, col_index);

                            if(html == 'n')
                           {
                              return '대기';
                           }else if(html == 'i')
                           {
                               return '작업시작';
                           }else if(html == 'us')
                           {
                               return '비가동시작';
                           }else if(html == 'ue')
                           {
                               return '비가동종료';
                           }else if(html == 'e')
                           {
                               return '작업종료';
                           }else if(html == 'y')
                           {
                               return '생산종료';
                           }else if(html == 'h')
                           {
                        	   
                        	   html =  '<div style="background-color:#000000; color:#ffffff;">'+ 'HOLD'  +'</div>';
                               
                           }else if(html == 'nh')
	       	            	{
	       	            		 return '작업대기';
	       	            	}
                           return html;
                       }          
                  }, 
                  { field:'member_nm', caption:'작업자', size:'55px', style:'text-align:center' , editable: { type: 'text' },sortable :true},
                  { field:'prod_str_time', caption:'시작', size:'95px', style:'text-align:center',sortable :true},
                  { field:'prod_end_time', caption:'종료', size:'95px', style:'text-align:center',sortable :true},
                  { field:'process_time', caption:'소요시간', size:'70px', style:'text-align:center',sortable :true},
                  { field:'prod_menge', caption:'소요시간', size:'0%', style:'text-align:center', hidden:true},
                  { field:'prod_fail_menge', caption:'소요시간', size:'70px', style:'text-align:center', hidden:true},
                  { field:'warehouse_gubun', caption:'구분YN', size:'0%', style:'text-align:center', hidden:true},
                  { field:'machine_gubun', caption:'설비라우팅구분YN', size:'0%', style:'text-align:center', hidden:true}
       

     
         ], 
    
      records: [
    
                
      ],   //
      
      
      onSelect: function (event) {
    	  event.onComplete = function () {
				console.log("onSelect");
				var eventColumn = event.column;
				var key = w2ui.grid_list2.getSelection();

				var current_recid = key[0];
				
				var last_recid = w2ui.grid_list2.records.length;
			
				var data = w2ui.grid_list2.get(current_recid);
				var status = data.status;
				var routing_gubun = data.routing_gubun;
				var routing_code = data.routing_code;
				var machine_gubun = data.machine_gubun;
				var outsourcing_gubun = data.outsourcing_gubun;
				console.log('eventColumn : ' + eventColumn);
				console.log('routing_gubun : ' + routing_gubun);
				console.log('machine_gubun : ' + machine_gubun);
				
			   	if(machine_gubun== check_routing_gubun) {
	               console.log("eventColumn");
	           
	             	// 여기서도 나중에  상태 체크해서 장비 안뜨게 하자 
	              	if(status == 'n')
	            	 //  if(true)
	            	{
	                    selectMachine(routing_gubun);
	               		var re_machineArr = new Array();
	               		
	               		var outArr = new Array();
	               		/* for(var i = 0; i< machineArr.length; i++){
	               			
	               			var row = machineArr[i];
	               		
	               			if(routing_gubun == row.matching_routing_code || routing_gubun == row.sub_matching_routing_code)
	               			{
			               		var machineObj = new Object();
								
				
								machineObj.id = row.code;
								machineObj.code = row.machine_code;
								
								// 코드로 보여달라고 했음.
								machineObj.text = row.code;
								re_machineArr.push(machineObj);
	               			}
	               		} */
	               		 for(var i = 0; i< machineArr.length; i++){
               			
		               			var row = machineArr[i];
			               		var machineObj = new Object();
							
			
								machineObj.id = row.code;
								machineObj.code = row.machine_code;
								
								// 코드로 보여달라고 했음.
								machineObj.text = row.code;
								re_machineArr.push(machineObj);
	               				
               			} 
	               		
	               		
	               		for(var r = 0; r< out_gubun.length; r++){
	               			
	               			var row = out_gubun[r];
		               		var outObj = new Object();
						
		
		               		outObj.id = row.text;
		               		outObj.text = row.text;
		               		outObj.code = row.code;
							
		               		outArr.push(outObj);
               				
           				}
	               		
	               	 	w2ui['grid_list2'].columns[5].editable = { type: 'select', items: [ {  id: '', text: ''  } ].concat(re_machineArr) };
	            	}else
	            	{
	            		w2ui['grid_list2'].columns[5].editable = false;
	            	}
	               
	            
	            }
			   	else
			   	{
			   		w2ui['grid_list2'].columns[3].editable = false;
			   	}
			   	
			  	if( eventColumn == 6) {
	               console.log("eventColumn");
	               
	               	if(status == 'ue' || status == 'e' || status == 'y')
	            	{
	               	 
	               		w2ui['grid_list2'].columns[6].editable = false;
	            	}else
	            	{
	            		w2ui['grid_list2'].columns[6].editable = { type: 'text'};
	            	}
	               
	            }
			   	else
			   	{
			   		w2ui['grid_list2'].columns[6].editable = false;
			   	}
			  	

			  	console.log("routing_code 는 ????" + routing_code);
			  	
			  	var finding = "-1";
			  	
			  	if(routing_code.indexOf(finding) != -1 || routing_code.indexOf('F') != -1 || routing_code.indexOf('Q') != -1 || routing_code.indexOf('P') != -1){
			  		w2ui['grid_list2'].columns[1].editable = false;
			  	}else{
			  		
			  		
		               console.log("eventColumn 외주처리 ---------");
		               
		               	if(status == 'n')
		            	{
		               	 
		               		w2ui['grid_list2'].columns[1].editable = { type: 'select', items: [ {  id: '', text: ''  } ].concat(out_gubun) };
		            	}else
		            	{
		            		w2ui['grid_list2'].columns[1].editable = false;
		            	}
		               	
		               	
			  	}
			  	
			  	///////////////////////////////////////////////////////////////
				$('#btn_start_work').attr('disabled', true);
				$('#btn_start_unoperate').attr('disabled', true);
				$('#btn_stop_unoperate').attr('disabled', true);
				$('#btn_stop_work').attr('disabled', true);
				
				$('#btn_stop_product').attr('disabled', true);
				
				$('#btn_ban_item_view').attr('disabled', false);
				
				
				
				if(status == 'n')
				{				
					if(current_recid == 1 )
					{
						$('#btn_start_work').attr('disabled', false);
						//$('#btn_ban_item_view').attr('disabled', false);
					}else
					{
						var prev_recid = Number(current_recid) - 1;
						var prev_data = w2ui.grid_list2.get(prev_recid);
						
						var prev_status = prev_data.status;
						
						if(prev_status == 'e')
						{
							$('#btn_start_work').attr('disabled', false);
							//$('#btn_ban_item_view').attr('disabled', false);
							
						}
					}	
					
					
					console.log('routing_code : ' + routing_code);
				/* 	if(routing_code.indexOf('-') != -1){
		
						$('#btn_start_work').attr('disabled', true);
			
					} */
					if(outsourcing_gubun == 'Y'){
						
						$('#btn_start_work').attr('disabled', true);
						$('#btn_ban_item_view').attr('disabled', true);
					} 
				
					
				}else if(status == 'i')
				{
					
					if(current_recid == 1 )
					{
						$('#btn_start_unoperate').attr('disabled', false);
						$('#btn_stop_work').attr('disabled', false);
						//$('#btn_ban_item_view').attr('disabled', false);
					}else
					{
						var prev_recid = Number(current_recid) - 1;
						var prev_data = w2ui.grid_list2.get(prev_recid);
						
						var prev_status = prev_data.status;
						
						if(prev_status == 'e')
						{
							$('#btn_start_unoperate').attr('disabled', false);
							$('#btn_stop_work').attr('disabled', false);
							//$('#btn_ban_item_view').attr('disabled', false);
							
						}
					}
					
				}else if(status == 'us')
				{
					
					if(current_recid == 1 )
					{
						$('#btn_stop_unoperate').attr('disabled', false);
						//$('#btn_ban_item_view').attr('disabled', false);
					}else
					{
						var prev_recid = Number(current_recid) - 1;
						var prev_data = w2ui.grid_list2.get(prev_recid);
						
						var prev_status = prev_data.status;
						
						if(prev_status == 'e')
						{
							$('#btn_stop_unoperate').attr('disabled', false);	
							//$('#btn_ban_item_view').attr('disabled', false);
						}
					}
					
				}else if(status == 'ue')
				{
					if(current_recid == 1 )
					{
						$('#btn_start_unoperate').attr('disabled', false);
						$('#btn_stop_work').attr('disabled', false);
						//$('#btn_ban_item_view').attr('disabled', false);
					}else
					{
						var prev_recid = Number(current_recid) - 1;
						var prev_data = w2ui.grid_list2.get(prev_recid);
						
						var prev_status = prev_data.status;
						
						if(prev_status == 'e')
						{
							$('#btn_start_unoperate').attr('disabled', false);
							$('#btn_stop_work').attr('disabled', false);
							//$('#btn_ban_item_view').attr('disabled', false);
							
						}
					}
				}else if(status == 'e')
				{					
					if(current_recid == last_recid)
					{
						$('#btn_stop_product').attr('disabled', false);
						//$('#btn_ban_item_view').attr('disabled', false);
					}
				}else if(status == 'y')
				{
					$('#btn_start_work').attr('disabled', false);
					//$('#btn_ban_item_view').attr('disabled', false);
				}
				
				if(routing_code.indexOf('-') != -1){
					
					w2ui['grid_list2'].columns[5].editable = false;
					
					$('#btn_start_work').attr('disabled', true);
					$('#btn_start_unoperate').attr('disabled', true);
					$('#btn_stop_unoperate').attr('disabled', true);
					$('#btn_stop_work').attr('disabled', true);
					
					$('#btn_stop_product').attr('disabled', true);
					//$('#btn_ban_item_view').attr('disabled', false);
				}
				
				// f가 포함되어있으면, 
				if(routing_code.indexOf('F') != -1) {	
					
					w2ui['grid_list2'].columns[5].editable = false;
					
					$('#btn_start_work').attr('disabled', true);
					$('#btn_start_unoperate').attr('disabled', true);
					$('#btn_stop_unoperate').attr('disabled', true);
					$('#btn_stop_work').attr('disabled', true);
					
					$('#btn_stop_product').attr('disabled', true);
					//$('#btn_ban_item_view').attr('disabled', false);
				}
				
				// Q가 포함되어있으면, 
				if(routing_code.indexOf('Q') != -1) {
					
					w2ui['grid_list2'].columns[5].editable = false;
					
					$('#btn_start_work').attr('disabled', true);
					$('#btn_start_unoperate').attr('disabled', true);
					$('#btn_stop_unoperate').attr('disabled', true);
					$('#btn_stop_work').attr('disabled', true);
					
					$('#btn_stop_product').attr('disabled', true);
				}
				
				// Z가 포함되어있으면, 
				if(routing_code.indexOf('Z') != -1) {	
					
					w2ui['grid_list2'].columns[5].editable = false;
					
					$('#btn_start_work').attr('disabled', true);
					$('#btn_start_unoperate').attr('disabled', true);
					$('#btn_stop_unoperate').attr('disabled', true);
					$('#btn_stop_work').attr('disabled', true);
					
					$('#btn_stop_product').attr('disabled', true);
					
					//$('#btn_ban_item_view').attr('disabled', false);
				}
				
				
				if(status == 'h'){
					$('#btn_ban_item_view').attr('disabled', true);
					$('#btn_start_work').attr('disabled', true);
					$('#btn_start_unoperate').attr('disabled', true);
					$('#btn_stop_unoperate').attr('disabled', true);
					$('#btn_stop_work').attr('disabled', true);
					
					$('#btn_stop_product').attr('disabled', true);
				}
				
				//  P201103219_5
				if(status == 'nh'){
					$('#btn_ban_item_view').attr('disabled', true);
					$('#btn_start_work').attr('disabled', false);
					
					$('#btn_start_unoperate').attr('disabled', true);
					$('#btn_stop_unoperate').attr('disabled', true);
					$('#btn_stop_work').attr('disabled', true);
					
					$('#btn_stop_product').attr('disabled', true);
				}
				/* if(routing_code.indexOf('X') != -1) {
					
					i['grid_list2'].columns[4]mns[4].editable = false;
					
				} */
		 		/*  $('#btn_start_work').attr('disabled', false);
				$('#btn_start_unoperate').attr('disabled', false);
				$('#btn_stop_unoperate').attr('disabled', false);
				$('#btn_stop_work').attr('disabled', false);
				
				$('#btn_stop_product').attr('disabled', false);  */
				
			}
		},
		
		onChange: function (event) {
	    	  event.onComplete = function () {
	    		  
	    		  var eventColumn = event.column;
	    		  var outArr = new Array();
	    		  
	    		  for(var r = 0; r< out_gubun.length; r++){
             			
             			var row = out_gubun[r];
	               		var outObj = new Object();
	
	               		outObj.id = row.text;
	               		outObj.text = row.text;
	               		outObj.code = row.code;
	               		outObj.recir = row.recid;
	               		
	               		outArr.push(outObj);
						
	               	   console.log("outObj.id는???--------222222" + r + "번째 " + row.id);
	               	   
	  	    		  console.log("outObj.text는???--------222222" + out_gubun[r].text);
	  	    		  console.log("outObj.code는???--------222222" + out_gubun[r].code);
	  	    		console.log("outObj.code는???--------222222" + row.recid);
         				
     				}
	    		  
  	    		  console.log("outObj.text는???--------3333" + row.text);
  	    		  console.log("outObj.code는???--------3333" + row.code);
  	    		console.log("outObj.recid는???--------3333" + row.recid);
	    		  
	    		  
	    		  w2ui.grid_list2.save();
	    		 
	    		  if(eventColumn == 1) {
	    			  
				  		var key2 = event.recid; 
				  		var get = w2ui['grid_list2'].get(key2);
				  		
				  		var routing_code = get.routing_code;
				  		
				  		var get_outsourcing_select = "";
						var rdss  = w2ui.grid_list2.records;
						
						var key3 = w2ui.grid_list.getSelection();
						var data3 = w2ui.grid_list.get(key3[0]);
						var product_po = data3.product_po;
						var item_code = data3.item_code;
						
						$.each(rdss, function(idx, row){
							if(key2 == row.recid) {
								console.log("탓당11111111");
								get_outsourcing_select = w2ui.grid_list2.records[idx].outsourcing_gubun; //w2ui['modalGrid'].get(key).routing_gubun;
								
							}
						});
						
						console.log("get_outsourcing_select 는??" + get_outsourcing_select);
						
						var final_outgubun = "";
						
						$.each(outArr, function(idx, row){	
							
							if(get_outsourcing_select == "외주") {
								console.log("탓당2222222");
								final_outgubun = "Y"
							}else{
								console.log("탓당3333333");
								final_outgubun = "N"
							}
						});
						
						console.log("final_outgubun 는??" + final_outgubun);
						
						console.log("routing_code 는??" + routing_code);
						console.log("product_po 는??" + product_po);
						
						updateOutsourcing(final_outgubun, product_po, routing_code);
						
						
				  	}
	    		  
	    	  }
	      },
      onReload: function(event) {
         //loadList();
      },
      onClick: function (event) {}
   });

}

//외주, 사내 처리
function updateOutsourcing(final_outgubun, product_po, routing_code){
	console.log("updateOutsourcing()");

	var page_url = "/frontend/consumable/updateOutsourcing";
	
	var postData = "outsourcing_gubun=" + encodeURIComponent(final_outgubun)
					+"&product_po=" + encodeURIComponent(product_po)
					+"&routing_code=" + encodeURIComponent(routing_code);
	


	$.ajax({
		url : page_url,
		type : 'POST',
        data: postData, 
		dataType : 'json',
		async : false,
		success : function(data) {
			
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				
			} else {
			
			}

		},complete: function () {
			
		}
	});
	
	loadList2(product_po);
}






function init_grid_list3(){
	var rowArr = [];
	   
	   $('#grid_list3').w2grid({ 
	        name: 'grid_list3',	
	        show: {
	           selectColumn: false,
	         lineNumbers : true,
	            footer: true
	        },
	        multiSelect: true,
	        columns: [                

	           // 120px
	            { field:'routing_code', caption:'공정코드', size:'12%', style:'text-align:center',sortable :true},
	            { field:'routing_nm', caption:'공정명', size:'15%', style:'text-align:center',sortable :true},
	            { field:'type', caption:'상태', size:'10%', style:'text-align:center',sortable :true
	            	,render: function (record, index, col_index) {
                        var html = this.getCellValue(index, col_index);

                            if(html == 'U')
                           {
                              return '비가동';
                           }else if(html == 'H')
                           {
                               return 'HOLD';
                           }
                           return html;
                       }     
	            },
	            { field:'member_nm', caption:'작업자', size:'10%', style:'text-align:center',sortable :true},
	            { field:'unprod_str_time', caption:'시작', size:'15%', style:'text-align:center',sortable :true},
	            { field:'unprod_end_time', caption:'종료', size:'15%', style:'text-align:center',sortable :true},
	            { field:'process_time', caption:'소요시간', size:'15%', style:'text-align:center',sortable :true},
	            { field:'unprod_comment', caption:'commet', size:'25%', style:'text-align:center',sortable :true}
	         // 120px
	         ], 
	      
	      records: [
	      ],   //
	      onReload: function(event) {
	         //loadList();
	      },
	      onClick: function (event) {}
	   });


}

//-------------------------------------------------------------------------------------------------------------------

/* function loadList_direct()
{
	
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	
	console.log('item_nm : ' + item_nm);
	console.log('item_code : ' + item_code);
	if((item_nm != null && item_nm != '') || (item_code != null && item_code != '') )
	{
		selectRoutingStatus();
	}else
	{
		initOptions( $('#routing_status') );
		//$("#routing_status option:eq(0)").prop("selected", true);	
	}
	loadList();
} */


var startValue_combo = "";

var comboValue_nm1 = new Array;
var comboValue_nm2 = new Array;

var comboValue_nm5 ; //공정명 selectBox 
var comboValue_nm6 ;

var routingArr = [];
var next_routingArr = [];
// 왼쪽 리스트 조회

var routing_select_cd = '';
var next_routing_select_cd = '';
var gridDataArr;

function loadList()
{
	
	console.log("loadList()");
	
	try{
		w2ui['grid_list'].clear();
		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
	}catch(e){
		
	}
	
	var order_day = $("#order_day").val();
	order_day = order_day.replace(/-/gi, ""); 
	var product_status = $("#product_status").val();
	var item_nm =   $("#item_nm").val();
	var item_code =   $("#item_code").val();
	
	var routing_code = $('#routing_status').val();
	var next_routing_code = $('#next_routing_nm').val();
	var search_type = $(":radio[name='rdo_ps_gubun']:checked").val();
	if(routing_code == null)
	{
		routing_code = '';	
	} 
	
	routing_select_cd = routing_code;
	
	if(next_routing_code == null)
	{
		next_routing_code = '';	
	} 
	
	next_routing_select_cd = next_routing_code;
	
	var page_url = "/frontend/consumable/selectProduct";
	
	//w2ui['grid_list'].lock('loading...', false);
	var postData = "product_req_date=" + encodeURIComponent(order_day)
		+"&item_nm=" + encodeURIComponent(item_nm)
		+ "&item_code=" + encodeURIComponent(item_code)
		+ "&routing_code=" + encodeURIComponent(routing_code)
		+ "&next_routing_code=" + encodeURIComponent(next_routing_code)
		+ "&search_type=" + encodeURIComponent(search_type)
		+ "&product_status=" + encodeURIComponent(product_status);
	
	
	
	//w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',			
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				var routingCDArr = [];
				var routingNMArr = [];
				
				var next_routingCDArr = [];
				var next_routingNMArr = [];
				
				
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
					}
					
					row.product_menge = Number(row.product_menge);
					
					//var item_code = 'S00-664178-00';
					row.file_link = '<a href="/common/product_pdfViewer?item_code='+item_code+'" target="_blank"><i class="fa fa-file"></i> '+'PDF 보기 '+'</a>';
					
					//공정명 셀렉
					if(routing_select_cd == null || routing_select_cd == ''){
						if(row.routing_code) {
							var routingObj = {};
							routingObj.routing_code = row.routing_code;
							routingObj.routing_nm = row.routing_nm;
							routingArr.push(routingObj);
						}
						if(row.routing_code)routingCDArr.push(row.routing_code);
						if(row.routing_nm)routingNMArr.push(row.routing_nm);
					}else 
					{
						if(idx == 0 ){
				/* 			var routingObj = {};
							routingObj.routing_code = routing_select_cd;
							routingObj.routing_nm = getRoutingNm(routing_select_cd);
							routingArr.push(routingObj); */
							
							routingCDArr.push(routing_select_cd);
							routingNMArr.push(getRoutingNm(routing_select_cd));
						}
					}
					
					//다음공정 셀렉
					if(next_routing_select_cd == null || next_routing_select_cd == ''){
						if(row.next_routing_code) {
							var next_routingObj = {};
							next_routingObj.next_routing_code = row.next_routing_code;
							next_routingObj.next_routing_nm = row.next_routing_nm;
							next_routingArr.push(next_routingObj);
						}
						if(row.next_routing_code)next_routingCDArr.push(row.next_routing_code);
						if(row.next_routing_nm)next_routingNMArr.push(row.next_routing_nm);
					}else 
					{
						if(idx == 0 ){
				/* 			var routingObj = {};
							routingObj.routing_code = routing_select_cd;
							routingObj.routing_nm = getRoutingNm(routing_select_cd);
							routingArr.push(routingObj); */
							
							next_routingCDArr.push(next_routing_select_cd);
							next_routingNMArr.push(getNext_RoutingNm(next_routing_select_cd));
						}
					}
				});
	
				
				
				//공정명 셀렉
				var routingCDArr =  _.uniq(routingCDArr);
				var routingNMArr =  _.uniq(routingNMArr);

				console.log('routingArr : ' + routingArr.length);
				console.log('routingCDArr : ' + routingCDArr.length);
				console.log('routingNMArr : ' + routingNMArr.length);
				
 				initOptions($('#routing_status'));  

				$.each(routingCDArr, function(idx, row){
					
					$("#routing_status").append("<option value=" + row + ">" + getRoutingNm(row) + "</option>");
					
					var lb = document.getElementById('routing_status'); 
						arrTexts = new Array(); 
				        arrValues = new Array(); 
				        arrOldTexts = new Array(); 			       
				        console.log("lb:"+lb.length);
				       for(i=0; i<lb.length; i++)				       
				       { 
				           arrTexts[i] = lb.options[i].text; 
				           arrValues[i] = lb.options[i].value; 
				           arrOldTexts[i] = lb.options[i].text; 
				       } 
				       console.log('정렬전:'+arrTexts);
				       
				       arrTexts.sort();
				       console.log('정렬:'+arrTexts.sort());

				       for(i=0; i<lb.length; i++) 
				       { 
				           lb.options[i].text = arrTexts[i]; 
				           
				           for(j=0; j<lb.length; j++) 
				           { 
				               if (arrTexts[i] == arrOldTexts[j]) 
				               { 
				                   lb.options[i].value = arrValues[j]; 
				                   j = lb.length; 
				               } 
				           } 
				       } 
	
				});
				
				//다음공정 셀렉
				var next_routingCDArr =  _.uniq(next_routingCDArr);
				var next_routingNMArr =  _.uniq(next_routingNMArr);

				console.log('next_routingArr : ' + next_routingArr.length);
				console.log('next_routingCDArr : ' + next_routingCDArr.length);
				console.log('next_routingNMArr : ' + next_routingNMArr.length);
				
				initOptions($('#next_routing_nm'));  

				$.each(next_routingCDArr, function(idx, row){
					
				    $("#next_routing_nm").append("<option value=" + row + ">" + getNext_RoutingNm(row) + "</option>");
	
					var lb = document.getElementById('next_routing_nm'); 
				       arrTexts = new Array(); 
				       arrValues = new Array(); 
				       arrOldTexts = new Array(); 
				       
				       for(i=0; i<lb.length; i++)
				       				    	  
				       { 
				           arrTexts[i] = lb.options[i].text; 
				           arrValues[i] = lb.options[i].value;  
				           arrOldTexts[i] = lb.options[i].text; 
				       } 
				       
				       arrTexts.sort(); 

				       for(i=0; i<lb.length; i++) 
				       { 
				           lb.options[i].text = arrTexts[i]; 
				           
				           for(j=0; j<lb.length; j++) 
				           { 
				               if (arrTexts[i] == arrOldTexts[j]) 
				               { 
				                   lb.options[i].value = arrValues[j]; 
				                   j = lb.length; 
				               } 
				           } 
				       } 
	
				});
				
				//전체넣기
				$("#routing_status").prepend("<option value="+ ">" + "전체" + "</option"+">");
				$("#routing_status option:eq(0)").prop("selected", true);
				
				$("#next_routing_nm").prepend("<option value="+ ">" + "전체" + "</option"+">");
				$("#next_routing_nm option:eq(0)").prop("selected", true);
				
				
				w2ui['grid_list'].records = rowArr;
				
				console.log('#routing_select_cd : ' + routing_select_cd);
				console.log('#next_routing_select_cd : ' + next_routing_select_cd);
				
				if(routing_select_cd != null && routing_select_cd != ''){
					
					console.log('###########타따##########');
					
					$("#routing_status option:eq(1)").prop("selected", true);	
				}

				if(next_routing_select_cd != null && next_routing_select_cd != ''){
					
					console.log('###########다음공정 타따##########');
					
					$("#next_routing_nm option:eq(1)").prop("selected", true);	
				}
				
				
				$('#item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
				$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
				
				var key = w2ui.grid_list.getSelection();
				
				if(key.length > 0)
				{
					loadList2();
					loadList3();
				}
			
			}
			else
			{
				w2ui['grid_list'].clear();
			}
			
		
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();

			//changeGridUI(gridDataArr);
		
		},complete: function () {
			startValue_combo = ":)";
			document.getElementById("item_code").style.removeProperty("height");
			document.getElementById("item_nm").style.removeProperty("height");
			
			
			
		}
		
	
	});
	
	
}

function getRoutingNm(routing_code)
{
	var result = '';
	for(var i = 0 ; i<routingArr.length; i++ )
	{
		if(routingArr[i].routing_code == routing_code ) result = routingArr[i].routing_nm;

	}
	return result;
}

function getNext_RoutingNm(next_routing_code)
{
	var result = '';
	for(var i = 0 ; i<next_routingArr.length; i++ )
	{
		if(next_routingArr[i].next_routing_code == next_routing_code ) result = next_routingArr[i].next_routing_nm;

	}
	return result;
}


function showPdf(){
	console.log("showPdf()");

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	var item_code = data.item_code;
	
	// 현재 도면이 있는 item_code가 없어서 강제로 셋팅 
	//item_code = 'S00-664178-00';
	
	var page_url = "/common/product_pdfViewer";
	var postData = page_url + "?item_code=" + encodeURIComponent(item_code);
			
	//$(location).attr('href', postData);

	
	window.open(postData);
	

}

//-------------------------------------------------------------------------------------------------------------------

var currentRow = 0;
var currentProcess = '';
function changeProcess(value)
{
	var key = w2ui.grid_list2.getSelection();
	
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "항목을 선택해주세요."); // Notification
		return;
	}
	
	var data = w2ui.grid_list2.get(key[0]);	
	var recid = key[0];
	var current_status = data.status;
	
	
	var routing_code = data.routing_code;
	if(value == 'start_work')
	{
		//routing_code = 'X';
		
		
		 if(routing_code.substring(0,1) == 'X'){
		
			
			plusItem();
			return;
		}
		startWork();

		
	
		
		
	}else if(value == 'stop_work')
	{
		stopWork();
		
	}else if(value == 'start_unoperate')
	{
		startUnOperate();
		
	}else if(value == 'stop_unoperate')
	{
		//stopUnOperate();
		// 사유 때문에 모달을 띄워야함
		stopUnOperate_modal();
		
	}else if(value == 'stop_product')
	{
		stopProduct();
		
	}
	
}

function initProcessBtn()
{
	$('#btn_start_work').attr('disabled', true);
	$('#btn_start_unoperate').attr('disabled', true);
	$('#btn_stop_unoperate').attr('disabled', true);
	$('#btn_stop_work').attr('disabled', true);
	
	$('#btn_stop_product').attr('disabled', true);
}


function saveBan()
{
	startWork();
}

function getMachineCode(machine_nm)
{
	
	console.log('machine_nm : ' + machine_nm);
	var result = '';
	for (var p in machineArr) {
		if (machineArr[p].id == machine_nm) result = machineArr[p].code;

	}
	
	return result;
}
function getMachineNm(machine_code)
{
	
	console.log('machine_code : ' + machine_code);
	var result = '';
	for (var p in machineArr) {
		if (machineArr[p].id == machine_code) result = machineArr[p].machine_nm;

	}
	
	return result;
}


function startWork()
{
	
	var key = w2ui.grid_list2.getSelection();	
	var recid = key[0];
	var data = w2ui.grid_list2.get(recid);	
	
	if(data.status == 'nh')
	{
		updateHoldWaitingEnd(data.product_po, data.routing_code, data.machine_code);
	}else
	{ // n 일때 
		startWork_real();
	}
}

function updateHoldWaitingEnd(product_po,routing_code,machine_code)
{

	var strUrl = "/info/machine/updateHoldWaitingEnd";
	
	var postData = "product_po=" + encodeURIComponent(product_po)
	+ "&routing_code=" + encodeURIComponent(routing_code)
	+ "&machine_code=" + encodeURIComponent(machine_code);
	
	$.ajax({
		 url: strUrl,
		 type: "POST",
		 dataType : 'json', 
		 data : postData, 
		 async : false,
		 success:function(data, textStatus, jqXHR){
		 	
		 	if(data.status == 777)
			{
				fnMessageModalAlert("알림", "이미 사용중인 장비 입니다.");	// Notification(MES)
			}
			else
			{
				initProcessBtn();
				$('#btn_start_unoperate').attr('disabled', false);
				$('#btn_stop_work').attr('disabled', false);
			}
		 },
		 error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
		 },
		 complete: function() {
		 }
	}); 
	
	
}
// 작업시작
function startWork_real()
{
	console.log('startWork');
	
	currentProcess = 'start_work';



	var key = w2ui.grid_list2.getSelection();	
	var recid = key[0];
	
	var status = 'i';
	var data = w2ui.grid_list2.get(recid);	
	var routing_gubun = data.routing_gubun;
	var routing_code = data.routing_code;
	var machine_code = data.machine_code;
	var machine_nm = data.machine_nm;
	
	var member_nm = data.member_nm;
	var unprod_comment = '';
	
	var machine_gubun = data.machine_gubun;
	
	console.log('routing_gubun : ' + routing_gubun);
	console.log('machine_gubun : ' + machine_gubun);
	console.log('check_routing_gubun : ' + check_routing_gubun);
	console.log('machine_nm : [' + machine_nm + ']');
	
	machine_nm = getMachineNm(machine_code);
	
	
	var prod_menge = 0;
	var prod_fail_menge = 0;
	
	
 	if(recid == 1){
		

		key = w2ui.grid_list.getSelection();
		data = w2ui.grid_list.get(key[0]);
		
		
		if(routing_code.substring(0,1) == 'X'){
			
		}else 
		{
			
			
			console.log('data.one_yn : ' + data.one_yn);
			
			if(data.one_yn == 'Y')
			{
				if('OK' != checkWarehouseRaw(data.product_po)){
					fnMessageModalAlert("알림", "원자재 출고 후 작업시작 가능합니다.");
					return;
				}
		
			} else
			{
				
			}
		} 
		
		
	/* 	if('OK' != checkWarehouseRaw(data.product_po))
		{
			fnMessageModalAlert("알림", "원자재 출고 후 작업시작 가능합니다.");
			return;
		} 자료전환으로 잠시 주석 처리 */
		
		prod_menge = data.product_menge;
		prod_fail_menge = 0;
		console.log('-------------------prod_menge :' +prod_menge);
	}else 
	{ 
		key = w2ui.grid_list2.getSelection();
		
		data = w2ui.grid_list2.get(Number(key[0]) - 1);
		
		prod_menge = data.prod_menge;
		prod_fail_menge = data.prod_fail_menge;
		console.log('-------------------prod_menge222222222 :' +prod_menge);
	}
	
	
	
	 if(machine_gubun == check_routing_gubun){
		if(machine_code == ''){
			fnMessageModalAlert("알림", "공정장비를 선택해주세요.");	// Notification(MES)
			return;
			
		}else {
			updateStartWorkProcess(status, machine_code, member_nm, unprod_comment, prod_menge, prod_fail_menge);
			initProcessBtn();
			$('#btn_start_unoperate').attr('disabled', false);
			$('#btn_stop_work').attr('disabled', false);
		}
	}else {
		updateStartWorkProcess(status, machine_code, member_nm, unprod_comment, prod_menge , prod_fail_menge);
		initProcessBtn();
		$('#btn_start_unoperate').attr('disabled', false);
		$('#btn_stop_work').attr('disabled', false);
	} 
	
	
}

// 작업종료
function stopWork()
{
	

	console.log('stopWork');
	
	currentProcess = 'stop_work';
	
	var key = w2ui.grid_list2.getSelection();	
	var recid = key[0];
	var status = 'e';
	
	var data = w2ui.grid_list2.get(key[0]);	
	var machine_code = data.machine_code;
	var member_nm = data.member_nm;

	var unprod_comment = '';
	
	
/* 	if(member_nm == ''){
		fnMessageModalAlert("알림", "작업자를 작성해주세요.");	// Notification(MES)
		
	}else {
		
		updateProductOperationProcess(status, machine_code, member_nm, unprod_comment);
	} */

	member_nm = memberNm;
	updateProductOperationProcess(status, machine_code, member_nm, unprod_comment);
	
	initProcessBtn();
	var last_recid = w2ui.grid_list2.records.length;
	if(recid == last_recid)
	{
		$('#btn_stop_product').attr('disabled', false);
	}
	
}

// 비가동 시작
function startUnOperate()
{
	console.log('startUnOperate()');
	
	currentProcess = 'start_unoperate';
	
	var key = w2ui.grid_list2.getSelection();	
	var recid = key[0];
	var status = 'us';
	
	var data = w2ui.grid_list2.get(key[0]);	
	var machine_code = data.machine_code;
	var member_nm = data.member_nm;
	var unprod_comment = '';
	updateProductOperationProcess(status, machine_code, member_nm, unprod_comment);
	
	initProcessBtn();
	$('#btn_stop_unoperate').attr('disabled', false);

	
}

//비가동 종료 모달
function stopUnOperate_modal()
{
	
	console.log('stopUnOperate_modal()');
	var key = w2ui.grid_list2.getSelection();	
	var data = w2ui.grid_list2.get(key[0]);	

	var member_nm = data.member_nm;
/* 	if(member_nm == ''){
		fnMessageModalAlert("알림", "작업자를 작성해주세요.");	// Notification(MES)
		return;
	} */


	$("#ct_codeView").css('display', 'none');
	$("#m_unprod_comment").val('');
	 			
	$("#modal_info").modal('show');

}

// 비가동 종료
function stopUnOperate()
{
	console.log('stopUnOperate()');
	currentProcess = 'stop_unoperate';
	$("#modal_info").modal('hide');
	var key = w2ui.grid_list2.getSelection();	
	var recid = key[0];
	var status = 'ue';

	
	var data = w2ui.grid_list2.get(key[0]);	
	var machine_code = data.machine_code;
	var member_nm = memberNm;
	var unprod_comment = 	$("#m_unprod_comment").val();
	updateProductOperationProcess(status, machine_code, member_nm, unprod_comment);
	
	
	initProcessBtn();
	$('#btn_start_unoperate').attr('disabled', false);
	$('#btn_stop_work').attr('disabled', false);
}

// 생산 종료
function stopProduct()
{
	console.log('stopProduct()');
	
	currentProcess = 'stop_product';
	
	var key = w2ui.grid_list2.getSelection();	
	var recid = key[0];
	var status = 'y';
	var data = w2ui.grid_list2.get(key[0]);	
	var machine_code = '';
	var member_nm = '';
	var unprod_comment = '';
	
	updateProductOperationProcess(status, machine_code, member_nm, unprod_comment);
	
	initProcessBtn();
}


// 오른쪽 리스트 조회 
function loadList2()
{
	console.log("loadList2()");

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	var product_po = data.product_po;
	
	var product_menge = data.product_menge;
	
	var page_url = "/frontend/consumable/selectProductOperation";
	
	//w2ui['grid_list'].lock('loading...', false);
	var postData = "product_po=" + encodeURIComponent(product_po);
		
	
	console.log('product_menge loadList:' + product_menge);
	

	//w2ui['grid_list'].lock('loading...', true);
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
			

				w2ui['grid_list2'].records = rowArr;
			
			
			}
			else
			{
				w2ui['grid_list2'].clear();
			}
			
		
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
			//changeGridUI(gridDataArr);

			
		},complete: function () {
			/* startValue_combo = ":)"; */
		}
	});
}

//오른쪽 하단 리스트 조회
function loadList3()
{
	   console.log("loadList3()");

	   var key = w2ui.grid_list.getSelection();
	   var data = w2ui.grid_list.get(key[0]);
	   var product_po = data.product_po;
	   
	   var page_url = "/frontend/consumable/selectProductUnOperation";
	   
	   //w2ui['grid_list'].lock('loading...', false);
	   var postData = "product_po=" + encodeURIComponent(product_po);
	      
	   

	   //w2ui['grid_list'].lock('loading...', true);
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
	            
	            w2ui['grid_list3'].records = rowArr;
	         	         
	         }
	         else
	         {
	            w2ui['grid_list3'].clear();
	         }
	         	      
	         w2ui['grid_list3'].refresh();
	         w2ui['grid_list3'].unlock();
	         
	         //changeGridUI(gridDataArr);
	         
	      },complete: function () {
	         /* startValue_combo = ":)"; */
	      }
	   });

}
/* function updateProductOperationProcess(recid, status)
{ 
	var sta = status;
	
	console.log('sta: '+ sta);
	//w2ui['grid_list2'].set({recid : recid, status : status});
	w2ui['grid_list2'].set(recid, {status : sta});
	
	
	w2ui['grid_list2'].refresh();
	//loadList2();
	
	console.log('status: '+ status);
} */



 
// 공정관리 Process저장
function updateProductOperationProcess(status, machine_code, member_nm, unprod_comment)
{
	console.log("updateProductOperationProcess()");

	var key = w2ui.grid_list2.getSelection();
	var data = w2ui.grid_list2.get(key[0]);
	var product_po = data.product_po;
	var routing_code = data.routing_code;
	var routing_gubun = data.routing_gubun;
	var warehouse_gubun = data.warehouse_gubun;
	
	console.log('##################send params ');
	console.log('product_po : ' +  product_po);
	console.log('routing_code : ' +  routing_code);
	console.log('status : ' +  status);
	console.log('machine_code : ' +  machine_code);
	console.log('member_nm : ' +  member_nm);
	console.log('unprod_comment : ' +  unprod_comment);
	
	var page_url = "/frontend/consumable/updateProductOperationProcess";

	var postData = "product_po=" + encodeURIComponent(product_po)
	+"&routing_code=" + encodeURIComponent(routing_code)
	+"&warehouse_gubun=" + encodeURIComponent(warehouse_gubun)
	+"&status=" + encodeURIComponent(status)
	+"&member_nm=" + encodeURIComponent(member_nm);
	postData = postData + "&machine_code=" + encodeURIComponent(machine_code);
	postData = postData + "&unprod_comment=" + encodeURIComponent(unprod_comment);
	/* if(routing_gubun == 'MD1253'){
		postData = postData + "&machine_code=" + encodeURIComponent(machine_code);
	}
	if(status == 'us'){
		postData = postData + "&unprod_comment=" + encodeURIComponent(unprod_comment);
	} */

	FunLoadingBarStart();
	$.ajax({
		url : page_url,
		type : 'POST',
	 	data : postData, 
		dataType : 'json',
		async : true,	
		success : function( data ) {
			if(data.status == 200) {
	
					//loadList();
					loadList2();
					loadList3();
			
			}
			else if(data.status == 777)
			{
				fnMessageModalAlert("알림", "이미 사용중인 장비 입니다.");	// Notification(MES)
			}
			else
			{
	
			}
			
			
		},complete: function () {
			FunLoadingBarEnd();
		}
	});
	
	/**
	product_po , routing_code
	
	
	
	status == i 

	product_tbl -> status = i; 
	product_operation_tbl - > 
	status = i;
	machine_code;
	member_nm;
	
	
	
	status = us
	
	member_nm;
	status = us;
	
	
	status = ue
	
	member_nm;
	status = ue;
	unprod_comment;
	
	
	status = e
	
	member_nm;
	status = e;
	

*/
} 

function updateStartWorkProcess(status, machine_code, member_nm, unprod_comment, prod_menge, prod_fail_menge)
{
	console.log("updateStartWorkProcess()");

	var key = w2ui.grid_list2.getSelection();
	var data = w2ui.grid_list2.get(key[0]);
	var product_po = data.product_po;
	var routing_code = data.routing_code;
	var routing_gubun = data.routing_gubun;
	var warehouse_gubun = data.warehouse_gubun;
	
	console.log('##################send params ');
	console.log('product_po : ' +  product_po);
	console.log('routing_code : ' +  routing_code);
	console.log('status : ' +  status);
	console.log('machine_code : ' +  machine_code);
	console.log('member_nm : ' +  member_nm);
	console.log('unprod_comment : ' +  unprod_comment);
	console.log('prod_menge : ' +  prod_menge);
	console.log('prod_fail_menge : ' +  prod_fail_menge);
	
	var page_url = "/frontend/consumable/updateProductOperationProcess";

	var postData = "product_po=" + encodeURIComponent(product_po)
	+"&routing_code=" + encodeURIComponent(routing_code)
	+"&warehouse_gubun=" + encodeURIComponent(warehouse_gubun)
	+"&status=" + encodeURIComponent(status)
	+"&prod_menge=" + encodeURIComponent(prod_menge)
	+"&prod_fail_menge=" + encodeURIComponent(prod_fail_menge)
	+"&member_nm=" + encodeURIComponent(member_nm);
	postData = postData + "&machine_code=" + encodeURIComponent(machine_code);
	postData = postData + "&unprod_comment=" + encodeURIComponent(unprod_comment);
	/* if(routing_gubun == 'MD1253'){
		postData = postData + "&machine_code=" + encodeURIComponent(machine_code);
	}
	if(status == 'us'){
		postData = postData + "&unprod_comment=" + encodeURIComponent(unprod_comment);
	} */

	FunLoadingBarStart();
	$.ajax({
		url : page_url,
		type : 'POST',
	 	data : postData, 
		dataType : 'json',
		async : true,	
		success : function( data ) {
			if(data.status == 200) {
	
					//loadList();
					loadList2();
					loadList3();
			
			}
			else if(data.status == 777)
			{
				fnMessageModalAlert("알림", "이미 사용중인 장비 입니다.");	// Notification(MES)
			}
			else
			{
				
			}
				
			
			
		},complete: function () {
			FunLoadingBarEnd();
		}
	});
	
	/**
	product_po , routing_code
	
	
	
	status == i 

	product_tbl -> status = i; 
	product_operation_tbl - > 
	status = i;
	machine_code;
	member_nm;
	
	
	
	status = us
	
	member_nm;
	status = us;
	
	
	status = ue
	
	member_nm;
	status = ue;
	unprod_comment;
	
	
	status = e
	
	member_nm;
	status = e;
	

*/
} 

var machineArr = new Array();
function selectMachine(check_routing_code){
	console.log("selectMachine()  ");

	var page_url = "/info/machine/selectMachine_waiting";
	var postData = "matching_routing_code=" + encodeURIComponent(check_routing_code)
	+ "&sub_matching_routing_code=" + encodeURIComponent(check_routing_code);
	


	$.ajax({
		url : page_url,
		type : 'POST',
        data: postData, 
		dataType : 'json',
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				machineArr = new Array();
				$.each(rowArr, function(idx, row){
				
					var machineObj = new Object();
					
					console.log('row.machine_code : ' + row.machine_code);
					console.log('row.machine_nm : ' + row.machine_nm);
					machineObj.id = row.machine_nm;
					machineObj.code = row.machine_code;
					machineObj.matching_routing_code = row.matching_routing_code;
					machineObj.sub_matching_routing_code = row.sub_matching_routing_code;
					machineObj.text = row.machine_nm;
					machineObj.machine_nm = row.machine_nm;
					machineArr.push(machineObj);
				});
				
			} else {
			
			}

		},complete: function () {}
	});
	
}

// function selectRoutingStatus(){
// 	console.log("selectRoutingStatus");
	
// 	initOptions($('#routing_status')); 
	
	
// 	var key = w2ui.grid_list2.getSelection();
// 	var data = w2ui.grid_list2.get(key[0]);
	
// 	var key2 = w2ui.grid_list.getSelection();
// 	var data2 = w2ui.grid_list.get(key2[0]);

// 	//var item_code = data.item_code;

	
// 	var item_code = $('#item_code').val();
	
	
// 	var strUrl = "/info/process/selectRouting_master";
// 	var postData = "item_code=" + encodeURIComponent(item_code);
	
// 	$.ajax({
// 	        url: strUrl,
// 	        type: "POST",
// 	        data: postData, 
// 	        dataType: 'json', 
// 	        async : false, 
// 			success : function( data ) {
// 				if(data.status == 200 && (data.rows).length>0 ) {
// 					rowArr = data.rows;    		
// 		    		console.log('///////////////////////SSSSSS////////////////');
// 		    		$("#routing_status").append("<option value="+ ">" + "전체" + "</option>");
// 					$.each(rowArr, function(idx, row){
						
						
// 						$("#routing_status").append("<option value=" + row.routing_code + ">" + row.routing_nm + "</option>");
// 					});
					
// 		 			/* $("#routing_status option:eq(0)").prop("selected", true);	
// 		 		    if("#routing_status") {
// 		 				$("#routing_status option:eq(1)").prop("selected", true);	
// 		 			}  */
		 			
// 		    	} else
// 		    	{
// 		    		console.log('///////////////////////data.status : ' + data.status);
// 		    	}
		    	
// 		    },
// 	       error: function(jqXHR, textStatus, errorThrown){
// 	             //fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");   
// 	       },
// 	       complete: function() {
// 	//           s_checkBox(vavaa);
	          
// 	       }
// 	   });
	
// }


//-------------------------------------------------------------------------------------------------------------------



// 원자재 출고 했는지 확인
function checkWarehouseRaw(product_po)
{
	
	var result = 'NO';
	console.log("checkWarehouseRaw()");
	   
	var page_url = "/frontend/consumable/selectWarehouseRaw";
	/* if(product_po.indexOf('_') != -1){
		product_po = product_po.split('_')[0];
	} */
	

	var postData = "product_po=" + encodeURIComponent(product_po);
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',	
		async : false,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;			
				
				if(rowArr.length > 0)
				{
					result = 'OK';
				}
			}
			else
			{

			}
			
			
		},complete: function () {
		
		}
			
	});
	
	return result;
	
	
}












function plusItem() {
	console.log('plusItem()');

	$("#m_item_code").val('');
	$("#m_item_nm").val('');
	
	$("#ct_codeView").css('display', 'none');
	
	w2ui['modalGrid2'].clear();
	w2ui['modalGrid2'].refresh();
	
	w2ui['modalGrid3'].clear();
	w2ui['modalGrid3'].refresh();
	
	requestMaterial();
	loadRightList();

	setTimeout(function(){
	      w2ui['modalGrid2'].resize();
	      w2ui['modalGrid2'].refresh();
	      
	      w2ui['modalGrid3'].resize();
	      w2ui['modalGrid3'].refresh();
	   }, 200);
	
	$("#modal_item").modal('show');

}












function modalGrid2() {
	console.log("modalGrid2()");
	
	var rowArr = [];
	
	$('#modalGrid2').w2grid({ 
        name: 'modalGrid2',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: true
           
        },
        multiSelect: true,
        summary: true,
        columns: [     
                  
				{ field:'business_code', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
				{ field:'business_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				{ field:'warehouse_code', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				{ field:'warehouse_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				
				
				{ field:'item_spec', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
				{ field:'item_type_code', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
				{ field:'item_type_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				{ field:'item_code', caption:'P/N', size:'20%', style:'text-align:center'}, // 120px
				{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center'},
				{ field:'warehousing_price', caption:'단가', size:'10%', style:'text-align:center', hidden : true},
				{ field:'warehousing_qty', caption:'수량', size:'10%', style:'text-align:center', hidden : false},
				{ field:'meins', caption:'단위', size:'10%', style:'text-align:center', hidden : true},
				

			], 

		records: [
		          
			],
		
		onSelect: function (event) {
// 			event.onComplete = function () {
// 				console.log("onSelect");
				
// 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
			}
		},
		onClick: function (event) {
// 			event.onComplete = function () {
// 				console.log("onClick");
// 			}
		}, onChange: function(event) {
			
			event.onComplete = function () {
				
				/* var eventColumn = event.column;
				console.log(event);
				w2ui.modalGrid2.save(); */
				
			}
		}	
	});
}

function modalGrid3() {
	console.log("modalGrid3()");
	
	var rowArr = [];
	
	$('#modalGrid3').w2grid({ 
        name: 'modalGrid3',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: true
           
        },
        multiSelect: false,
        columns: [    
	
                  
				{field: 'item_code', caption: 'P/N', size:'30%', style:'text-align:center'},
				{field: 'item_nm', caption: '품명', size:'30%', style:'text-align:center'  }
			], 

		records: [
		          
			],
		
		onSelect: function (event) {
// 			event.onComplete = function () {
// 				console.log("onSelect");
				
// 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
			}
		},
		onClick: function (event) {
// 			event.onComplete = function () {
// 				console.log("onClick");
// 			}
		}, onChange: function(event) {
			
			event.onComplete = function () {
				
			}
		}	
	});
	
}

function modalGrid_view() {
	console.log("modalGrid_view()");
	
	var rowArr = [];
	
	$('#modalGrid_view').w2grid({ 
        name: 'modalGrid_view',
        show: {
        	lineNumbers : true,
            footer: true, 
            selectColumn: true
           
        },
        multiSelect: true,
        summary: true,
        columns: [     
                  
				{ field:'business_code', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
				{ field:'business_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				{ field:'warehouse_code', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				{ field:'warehouse_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				
				
				{ field:'item_spec', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
				{ field:'item_type_code', caption:'자재유형', size:'10%', style:'text-align:center', hidden : true},
				{ field:'item_type_nm', caption:'자재유형', size:'10%', style:'text-align:center' , hidden : true},
				{ field:'item_code', caption:'P/N', size:'20%', style:'text-align:center'}, // 120px
				{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center'},
				{ field:'warehousing_price', caption:'단가', size:'10%', style:'text-align:center', hidden : true},
				{ field:'warehousing_qty', caption:'수량', size:'10%', style:'text-align:center', hidden : false},
				{ field:'meins', caption:'단위', size:'10%', style:'text-align:center', hidden : true},
				

			], 

		records: [
		          
			],
		
		onSelect: function (event) {
// 			event.onComplete = function () {
// 				console.log("onSelect");
				
// 			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
			}
		},
		onClick: function (event) {
// 			event.onComplete = function () {
// 				console.log("onClick");
// 			}
		}, onChange: function(event) {
			
			event.onComplete = function () {
				
				/* var eventColumn = event.column;
				console.log(event);
				w2ui.modalGrid2.save(); */
				
			}
		}	
	});
}




//제품 조회 
function requestMaterial(type)
{
	console.log("requestMaterial()");
	   
	var item_code = $("#m_item_code").val();
	var item_nm = $("#m_item_nm").val();
	if(type == 'V'){
		
		 item_code = $("#m_item_code2").val();
		 item_nm = $("#m_item_nm2").val();
	}


	var page_url = "/frontend/warehouse/selectMaterialBan";
	var postData = "item_code=" + encodeURIComponent(item_code)
	+"&item_nm=" + encodeURIComponent(item_nm)
	+"&item_type_code=" + encodeURIComponent('MD1249');
	
	w2ui['modalGrid2'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data : postData, 
		async : true,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					if(row.item_code)comboValue_nm3.push(row.item_code);
					if(row.item_nm)comboValue_nm4.push(row.item_nm);
	
				});
				
				w2ui['modalGrid2'].records = rowArr;
				w2ui['modalGrid_view'].records = rowArr;
			
			
			}else
			{
				w2ui['modalGrid2'].clear();
				w2ui['modalGrid_view'].clear();
				
			}
			w2ui['modalGrid2'].refresh();
			w2ui['modalGrid2'].unlock();
			
			w2ui['modalGrid_view'].refresh();
			w2ui['modalGrid_view'].unlock();
			
			$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			
			$('#m_item_code2').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
			$('#m_item_nm2').w2field('combo', { items: _.uniq(comboValue_nm4,false) ,match : 'contains' });
			
			try{
				//w2ui['grid_list2'].clear();
			}catch(e)
			{
				
			}
			
		},complete: function () {
			document.getElementById("m_item_code").style.removeProperty("height");
			document.getElementById("m_item_nm").style.removeProperty("height");
			
			document.getElementById("m_item_code2").style.removeProperty("height");
			document.getElementById("m_item_nm2").style.removeProperty("height");
		}
	});
}

function gogoBanItem()
{
	console.log('gogoBanItem()');
	
	requestOut();
}


function loadRightList()
{
	console.log('loadRightList()');
	var key = w2ui.grid_list2.getSelection();
	var data = w2ui.grid_list2.get(key[0]);
	var product_po = data.product_po;

	w2ui['modalGrid3'].clear();
		
	var page_url = "/frontend/warehouse/selectWarehouseOut";
	
	//w2ui['grid_list'].lock('loading...', false);
	var postData = "product_po=" + encodeURIComponent(product_po);
 		/* + "&item_type_code=" + encodeURIComponent('MD1249'); */
	
	try{
		
		w2ui.modalGrid3.selectNone();
		w2ui['modalGrid3'].lock('loading...', true);
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
					
			
					
		
				});
				
				w2ui['modalGrid3'].records = rowArr;
			
			
			}else
			{
				w2ui['modalGrid3'].clear();
				
			}
			w2ui['modalGrid3'].refresh();
			w2ui['modalGrid3'].unlock();

			
		},complete: function () {
			
		}
	});
}





function requestOut()
{
	console.log('requestOut()');
	
	
	var key = w2ui.modalGrid2.getSelection();
	if( key.length==1 ) {
		var data = w2ui.modalGrid2.get(key[0]);
		
 		$('#m_cnt').val('');
		/* $('#m_out_user').val('');
		$('#m_out_comment').val('');  */
		$('#m_warehousing_qty').val(data.warehousing_qty);
		$('#m_warehousing_qty').attr('disabled', true);
		$("#modal_out").modal('show');
		
	

	} else {
		fnMessageModalAlert("알림", "출고하실 항목을 선택해주세요."); // Notification
	}
}


function saveOut()
{	
	var out_date = $('#m_out_date').val();
	var cnt = $('#m_cnt').val();
	var out_user = $('#m_out_user').val();
	var out_comment = $('#m_out_comment').val();
	
	
	var warehousing_qty_origin = $('#m_warehousing_qty').val();
	var warehousing_qty  = cnt.replace(/(^0+)/, "");
	
	
	var m_key = w2ui.grid_list.getSelection();
	var m_data = w2ui.grid_list.get(m_key[0]);
	
	var key = w2ui.modalGrid2.getSelection();
	var data = w2ui.modalGrid2.get(key[0]);
	
	var product_po = m_data.product_po;
	var item_code = data.item_code;
	var item_nm = data.item_nm;
	
	var business_code = data.business_code;
	var business_nm = data.business_nm;
	var warehouse_code = data.warehouse_code;
	var warehouse_nm = data.warehouse_nm;
	var item_spec = data.item_spec;
	var item_type_code = data.item_type_code;
	var item_type_nm = data.item_type_nm;
	var meins = data.meins;
	var warehousing_price = data.warehousing_price;
	
	
	if(!chkSubmit($("#m_cnt"), "수량을")) return;
	
	if(Number(warehousing_qty) > Number(warehousing_qty_origin) )
	{
	    fnMessageModalAlert("알림", "출고수량은 재고수량보다 많을 수 없습니다.");
	    return;
	}
	
	out_user = memberNm;
	out_date = getFormatDate(new Date());
	out_date = out_date.replace(/-/gi, "");
	out_comment = '';
	
	
	console.log('product_po : ' + product_po);
	console.log('item_code : ' + item_code);
	console.log('item_nm : ' + item_nm);
	console.log('business_code : ' + business_code);
	console.log('business_nm : ' + business_nm);
	console.log('warehouse_nm : ' + warehouse_nm);
	console.log('warehouse_code : ' + warehouse_code);

	console.log('item_spec : ' + item_spec);
	console.log('item_type_code : ' + item_type_code);
	console.log('item_type_nm : ' + item_type_nm);
	console.log('meins : ' + meins);
	console.log('warehousing_price : ' + warehousing_price);
	
	console.log('out_user : ' + out_user);
	console.log('out_date : ' + out_date);
	console.log('out_comment : ' + out_comment);
	

	var strUrl = "/frontend/consumable/saveWarehouseOut";
  	var postData = "business_code=" +  encodeURIComponent(business_code)
	 + "&business_nm=" +  encodeURIComponent(business_nm)
	+ "&warehouse_code=" +  encodeURIComponent(warehouse_code)
	+ "&warehouse_nm=" +  encodeURIComponent(warehouse_nm)
	+ "&item_code=" +  encodeURIComponent(item_code)
	+ "&item_nm=" +  encodeURIComponent(item_nm)
	+ "&item_spec=" +  encodeURIComponent(item_spec)
  	+ "&item_type_code=" +  encodeURIComponent(item_type_code)
  	+ "&item_type_nm=" +  encodeURIComponent(item_type_nm)	 
  	+ "&meins=" +  encodeURIComponent(meins)
  	+ "&warehousing_price=" +  encodeURIComponent(warehousing_price)
  	 + "&out_date=" +  encodeURIComponent(out_date)
   	+ "&warehousing_qty=" +  encodeURIComponent(warehousing_qty)
   	+ "&out_user=" +  encodeURIComponent(out_user)
   	  + "&product_po=" +  encodeURIComponent(product_po)
   	+ "&out_comment=" +  encodeURIComponent(out_comment);
   
	FunLoadingBarStart();     
   $.ajax({
       url : strUrl,
       type : "POST", 
       dataType : 'json', 
       data : postData, 
      //async : false,   
       success:function(data, textStatus, jqXHR){
          if(data.status == "200") {
             fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
             
             $("#modal_out").modal('hide');
             w2ui['modalGrid2'].selectNone();
             startWork();
             loadRightList();
      
          }
       },
       error: function(jqXHR, textStatus, errorThrown){
             fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");   // Notification(MES)
       },
       complete: function() {
         $("#modal_out").modal('hide');
     	FunLoadingBarEnd();
       }
   });
}










//삭제
function deleteItem() {
	console.log('deleteItem()');

	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 선택하여야 합니다."); // Notification
		return;
	} else {
		
		var data = w2ui.grid_list.get(key[0]);
		var product_po = data.product_po;
		fnMessageModalConfirm("알림", "선택한 항목을 삭제하시겠습니까?", function(result) {
			if(result) {
				w2ui.grid_list.selectNone();
				
				var strUrl = "/frontend/consumable/deleteProduct";
				var postData = "product_po=" + encodeURIComponent(product_po);
				
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



$("#item_code").change(_.debounce(function(event) {
	
	loadList();
	
	
	
},100));

$("#item_nm").change(_.debounce(function(event) {
	
	loadList();
	
},100));







function requestView() {
	console.log('requestView()');

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	var input_item_code = data.item_code;
	$("#m_item_code2").val('SUB-'+input_item_code);
	$("#m_item_nm2").val('');
	
	$("#ct_codeView").css('display', 'none');
	
	w2ui['modalGrid_view'].clear();
	w2ui['modalGrid_view'].refresh();

	
	requestMaterial('V');

	setTimeout(function(){
	      w2ui['modalGrid_view'].resize();
	      w2ui['modalGrid_view'].refresh();   
	 
	   }, 200);
	
	$("#modal_info_view").modal('show');

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
//       .append('<option value="All">-----</option>')
    .val();
}

function excelFileDownload()
{
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var nm = "작업지시 조회";
	
	
	var fileName = nm + '.xlsx';
	var sheetTitle = nm;
	var sheetName = nm;
	
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