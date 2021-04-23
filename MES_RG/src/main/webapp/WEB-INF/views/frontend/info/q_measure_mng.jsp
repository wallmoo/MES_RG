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
		<jsp:param name="selected_menu_cd" value="1067" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      계측기관리
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>품질관리</a></li><li class="active">계측기관리</li>
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
						 	<button type="button" id="btn_download" class="btn btn-info btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
					     	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="changeDate();">교정일자 변경</button>
					     	<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="requestIU_modal();">등록/수정</button>
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteItem();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadData();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<label>교정일자</label>
									<div class="input-group">
									 <label>
						               <input type="radio" id="correct_yn_yn" name="correct_yn_yn" class="flat-red" value="Y"  checked="checked"> 사용  
						             </label>
						             <label style="margin-left:15px;">
						                <input type="radio" id="correct_yn_yn" name="correct_yn_yn" class="flat-red" value="N" > 미사용 
					            	 </label>
					            	 </div>
								</div>
							</div>
							
						
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>계측기명</label> <input type="text" id="instrument_nm" name="instrument_nm" placeholder="ex) 계측기명"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadData(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>관리번호</label> <input type="text" id="correct_num" name="correct_num" placeholder="ex) 관리번호"
									 class="form-control input-sm" maxlength="100" onkeypress="if(event.keyCode==13) {loadData(); return false;}" />
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
								<label>교정일자</label>
								 <input type="checkbox" id="chk_eindt" name="chk_eindt" value="1" style="margin: 0px;" onchange="chgEindt();" ><!-- checked -->
                             
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="correct_date" placeholder="yyyymmdd~yyyymmdd" onChange="loadData();">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							
						
						</div>
						<div id="tabs" style="width: 100%;"></div>
						<div id="selected-tab" style="padding: 20px 10px">
							<div id="grid_list" style="width: 100%; height: 600px;"></div>
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
				<h4 class="modal-title" id="modal_code_title">등록</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
				<input type="hidden" id="upload_mode"/>
					<input type="hidden" class="clear_field" id="mod_file_group"/>
					<input type="hidden" class="clear_field" id="mod_file_no"/>
					<input type="hidden" class="form-control input-sm pull-right" id="m_business_code"/>
					<div class="row" id="">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">관리번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_correct_num" >
							</div>
						</div>
					</div>
					<div class="row" id="">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">계측기명</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_instrument_nm" >
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">제작처</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_maker" >
							</div>
						</div>
					</div>
					
					<div class="row" id="">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">계측기번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_instrument_num" >
							</div>
						</div>
					</div>
					
					<div class="row" id="">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">기기번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_device_num" >
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">측정범위(규격)</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_standard" >
							</div>
						</div>
					</div>
					<div class="row" id="">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">사용팀</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_use_team" >
							</div>
						</div>
					</div>
					<div class="row" id="">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">담당자</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm pull-right" id="m_manager_nm" >
							</div>
						</div>
					</div>
					
					<div class="row" id="m_correct_date_r">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">최초등록일</label>
							<div class="col-sm-5">
								<div class="input-group">
								  <input type="text" class="form-control input-sm" id="m_register_date">
									  <div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
							 	</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group">
		                  <label for="rdo_mretire_yn" class="col-sm-3 control-label">교정대상 적용여부</label>
		                  <div class="col-sm-2"  style="padding-top: 7px;">
		                  	 <label style="margin-right: 10px;">
				               <input type="radio" id="m_correct_yn_yn" name="m_correct_yn_yn" class="flat-red" value="Y"  checked="checked"> 사용 
				             </label>
			               </div>
			               <div class="col-sm-2"  style="padding-top: 7px;">
				             <label>
				               <input type="radio" id="m_correct_yn_yn" name="m_correct_yn_yn" class="flat-red" value="N"> 미사용
				             </label>
		                  </div>
	               		</div>
					</div>
					
					
					
					<div class="row" id="m_correct_date_r">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">교정일자</label>
							<div class="col-sm-5">
								<div class="input-group">
								  <input type="text" class="form-control input-sm" id="m_correct_date">
									  <div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
							 	</div>
							</div>
						</div>
					</div>
					
					<div class="row" id="m_correct_cycle_r">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">교정주기</label>
							<div class="col-sm-3">
								<input type="text" class="form-control input-sm pull-right" id="m_correct_cycle" onkeypress="requestCycle();"
								onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;">
							</div>
							<label for="" class="col-sm-2 control-label" style="text-align: left; padding-right:0;">(연 단위)</label>
						</div>
					</div>
					
					<div class="row" id="m_correct_next_date_r">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">차기교정일자</label>
							<div class="col-sm-5">
								<div class="input-group">
								  <input type="text" class="form-control input-sm pull-right" id="m_correct_next_date">
							 	</div>
							</div>
						</div>
					</div>
					
					<div class="row" id="m_correct_institutions_r">
						<div class="form-group">
							<label for="" class="col-sm-3 control-label">교정기관</label>
							<div class="col-sm-5">
								<input type="text" class="form-control input-sm pull-right" id="m_correct_institutions" >
							</div>
						</div>
					</div>
					<div class="row" id="m_file_upload_r">
						<div class="form-group">
							<label class="col-sm-3 control-label">파일첨부</label>
							<div class="col-sm-7">
								<input type="text" id="m_down_file_name" name="m_down_file_name" class="form-control input-sm clear_field pull-right" readonly>
							</div>	
							<div class="col-sm-1" style="padding-left: 7px;">
								<span class="btn btn-danger btn-sm fileinput-button " style="width: 100%;" id="file_btn"> <i class="fa fa-plus"></i>
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
					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveItem();">저장</button>
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

comboValue_nm1 = new Array;
comboValue_nm2 = new Array;

$(function($) {
	tab_grid();
	
 	fnLoadCommonOption(); 	 

 	init_grid_list();
 	fnLoadFileHandler();

 	loadList();
 
})

$(":radio[name='correct_yn_yn']").on('ifChecked', function(event){
		  loadList();
	});
var tab_flag = 'tab1'   // tab1 , tab2
//tab설정
function tab_grid(){
	$('#tabs').w2tabs({
        name: 'tabs',
        active: 'tab1',
        tabs: [
            { id: 'tab1', text: '계측기관리', style: "background-color: #8bcb77;"  },
            { id: 'tab2', text: '계측기관리 이력보기', style: 'background-color:' },
 
        ],
        onClick: function (event) {
           // $('#selected-tab').html(event.target);
            // style: 'background-color:#8bcb77'
            // w2ui.grid_list.set(index, { w2ui: { "style": "color: black; background-color: #FFD8D8;" } });
      			w2ui['tabs'].set('tab1' ,  { style: "background-color:;"  });
     			w2ui['tabs'].set('tab2' ,  { style: "background-color:;"  });
 
     			tab_flag = event.target;
     			
	            if(event.target == 'tab1')
	        	{
	       			w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });
	
	       			$("#btn_update").attr('disabled', false);
	      			$("#btn_create").attr('disabled', false);
	      			$("#btn_delete").attr('disabled', false);
	      			
	      			$("#btn_update").show();
	      			$("#btn_create").show();
	      			$("#btn_delete").show();
	       			
	       			loadList();
	   
	        	}else if(event.target == 'tab2')
	        	{
	     
	
	      			w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });
	      			
	  
	      			$("#btn_update").hide();
	      			$("#btn_create").hide();
	      			$("#btn_delete").hide();
	      			
	      			/* $("#btn_update").attr('hidden', true);
	      			$("#btn_create").attr('hidden', true);
	      			$("#btn_delete").attr('hidden', true);
	      			 */
	 				
	 				loadHistory();
	       		}
				
	   			w2ui['tabs'].refresh();
        }
    });
}

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
 		
 		var minDate = getFormatDate(new Date());
		$('#macc_chndate, #m_correct_date').daterangepicker({
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
		
		$('#m_register_date').daterangepicker({
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
		
		 
		 $("#m_order_price").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
		 
		 $('#correct_date').daterangepicker({
				opens: 'right',
				locale: {
					format : 'YYYYMMDD'	,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
					showMonthAfterYear : true,
					yearSuffix : '년'
			    },
			     startDate: moment(minDate),
       endDate: moment([moment().format('YYYY'), moment().format('MM')-1, moment().format('DD'), 20, 30]).add(7, 'days') 

			}); 
}
 

//회사명 변경시 1개 이상 조회시 select box로 1개일시 input창
$("#projectBox").change(function(){
	
	var val = $("#projectBox option:selected").val(); // text();
	
	console.log("val = " + val);
	
	if(val=="") {
		return;
	}
	
});



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
			{ field:'idx', caption:'idx', size:'10%', style:'text-align:center', hidden : true },
			
			{ field:'correct_num', caption:'관리번호', size:'12%', style:'text-align:center' ,sortable: true},
			{ field:'instrument_nm', caption:'계측기명', size:'20%', style:'text-align:center' ,sortable: true},
			{ field:'maker', caption:'제작처', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'instrument_num', caption:'계측기번호', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'device_num', caption:'기기번호', size:'10%', style:'text-align:center' ,sortable: true},
		
			{ field:'standard', caption:'측정범위(규격)', size:'12%', style:'text-align:center' ,sortable: true},
			{ field:'use_team', caption:'사용팀', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'manager_nm', caption:'담당자', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'register_date', caption:'최초등록일', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'correct_cycle', caption:'교정주기', size:'8%', style:'text-align:center'
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
		               try{
		            	   var correct_cycle = w2ui.grid_list.records[index].correct_cycle; 
		            	   
		            	   console.log('correct_cycle :' + correct_cycle);
		            	   
		             	  html = correct_cycle+'년';
		               }catch(e)
		               {
		            	   
		               }
		               return html;
		           } 
			 ,sortable: true},
			{ field:'correct_date', caption:'교정일자', size:'10%', style:'text-align:center' ,sortable: true},
			{ field:'correct_next_date', caption:'차기교정일자', size:'10%', style:'text-align:center'
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
		               try{
		            	   var correct_next_date = w2ui.grid_list.records[index].correct_next_date; 
		            	   var today = getFormatDate(new Date());
		             	   var default_value = '7';
		            	   var check_value = dateDiff(correct_next_date, new Date());
		            	
		            	   console.log('default_value : '+ default_value);
		            	   console.log('check_value : '+ check_value);
		            	   
		            
		            	   if(check_value <= default_value){
		            		   html =  '<div style="background-color:#8bcb77;">'+ html  +'</div>';
		            	   }
		               }catch(e)
		               {
		            	   
		               }
		               return html;
		           } 	
			 ,sortable: true},
			{ field:'correct_institutions', caption:'교정기관', size:'16%', style:'text-align:center' ,sortable: true},
			{ field:'correct_yn', caption:'교정대상적용여부', size:'12%', style:'text-align:center'
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

	                if(html == 'N')
	            	{
	            	   return '미사용';
	            	}else if(html == 'Y')
	            	{
	            		 return '사용';
	            	}
	               return html;
		           } 		
			 ,sortable: true},
			{ field:'down_file_name', caption:'파일첨부', size:'20%', style:'text-align:left' ,sortable: true}
			], 
		records: [
		
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}

//-------------------------------------------------------------------------------------------------------------------
function dateDiff(_date1, _date2) {
    var diffDate_1 = _date1 instanceof Date ? _date1 :new Date(_date1);
    var diffDate_2 = _date2 instanceof Date ? _date2 :new Date(_date2);
 
    diffDate_1 =new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
    diffDate_2 =new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());
 
    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
    diff = Math.ceil(diff / (1000 * 3600 * 24));
 
    return diff;
}


//등록/수정 모달 생성
function requestIU_modal()
{
	file_upload_yn = 'N';
	
	
	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		insertItem();
	}else  if( key.length==1 ) {	
		updateItem();	
	}
}
var isRev = false;


//등록
function insertItem() {
	
	console.log('insertItem()');

	w2ui.grid_list.selectNone();

	$("#modal_code_title").text('등록');
	$("#ct_codeView").css('display', 'none');
	
	$("#m_correct_num").val('');
	$("#m_instrument_nm").val('');
	$("#m_maker").val('');
	
	$("#m_instrument_num").val('');
	$("#m_device_num").val('');
	
	$("#m_standard").val('');
	
	$("#m_use_team").val('');
	$("#m_manager_nm").val('');
	$("#m_register_date").val('');
	
	$("#m_correct_cycle").val('1');
	//$("#m_correct_next_date").val(next_date);
	$("#m_correct_institutions").val('');
	$("#m_down_file_name").val('');
	 			
	$("#m_correct_next_date").attr('disabled', true);
	
	$("#m_correct_num").attr('disabled', false);
	$("#m_instrument_nm").attr('disabled', false);
	$("#m_maker").attr('disabled', false);
	$("#m_standard").attr('disabled', false);
	$("#m_correct_institutions").attr('disabled', false);
	
	
	var cycle = $("#m_correct_cycle").val();
    
    var writeCycle = Number(cycle) * Number('365');
    
    var date = $("#m_correct_date").val();
    
    var next_date =  moment(date).add(writeCycle, "d").format("YYYY-MM-DD");
    
    console.log("cycle :" + cycle);
    console.log("date :" + date);
    console.log("next_date :" + next_date);
    
    $("#m_correct_next_date").val(next_date);
	
	
    $("#m_correct_cycle").on("propertychange change keyup paste input", function() {
		    var cycle = $(this).val();
		    var writeCycle = Number(cycle) * Number('365');
		    
		    var date = $("#m_correct_date").val();
		    
		    var next_date =  moment(date).add(writeCycle, "d").format("YYYY-MM-DD");
		    
		    console.log("cycle :" + cycle);
		    console.log("date :" + date);
		    console.log("next_date :" + next_date);
		    
		
			$("#m_correct_next_date").val(next_date);
		
		});
    
	$("#modal_info").modal('show');

}
//수정
function updateItem() {
	console.log('updateItem()');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	 if( key.length==1 ) {
		// update
		$("#modal_code_title").text('수정');
		
		
		$("#m_correct_num").val(data.correct_num);
		$("#m_instrument_nm").val(data.instrument_nm);
		$("#m_maker").val(data.maker);
		
		
		$("#m_instrument_num").val(data.instrument_num);
		$("#m_device_num").val(data.device_num);
		
		$("#m_standard").val(data.standard);
		
		$("#m_use_team").val(data.use_team);
		$("#m_manager_nm").val(data.manager_nm);
		$("#m_register_date").val(data.register_date);
		
		$("#m_standard").val(data.standard);
		$("#m_correct_cycle").val(data.correct_cycle);
		$("#m_correct_date").val(data.correct_date);
		$("#m_correct_next_date").val(data.correct_next_date);
		$("#m_correct_institutions").val(data.correct_institutions);
		
		$("#m_down_file_name").val(data.file_name);
		 			
		$("#m_correct_next_date").attr('disabled', true);
		
		$("#m_correct_num").attr('disabled', true);
		$("#m_instrument_nm").attr('disabled', true);
		$("#m_maker").attr('disabled', true);
		$("#m_standard").attr('disabled', false);
		$("#m_correct_institutions").attr('disabled', false);
		
		
		$("#modal_info").modal('show');
	}
	 
}

//교정일자 변경
function changeDate() {
	console.log('changeDate()');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	 if( key.length==1 ) {
		// update
		$("#modal_code_title").text('교정일자 변경');
		
		
		$("#m_correct_num").val(data.correct_num);
		$("#m_instrument_nm").val(data.instrument_nm);
		$("#m_maker").val(data.maker);
		$("#m_instrument_num").val(data.instrument_num);
		$("#m_device_num").val(data.device_num);
		
		$("#m_standard").val(data.standard);
		
		$("#m_use_team").val(data.use_team);
		$("#m_manager_nm").val(data.manager_nm);
		$("#m_register_date").val(data.register_date);
		$("#m_correct_cycle").val(data.correct_cycle);
		$("#m_correct_next_date").val(data.correct_next_date);
		$("#m_correct_institutions").val(data.correct_institutions);
		$("#m_correct_date").val(data.correct_date);
		$("#m_correct_next_date").attr('disabled', true);
		$("#m_correct_num").attr('disabled', true);
		$("#m_instrument_nm").attr('disabled', true);
		$("#m_maker").attr('disabled', true);
		$("#m_standard").attr('disabled', true);
		$("#m_correct_institutions").attr('disabled', true);
		
		$("#modal_info").modal('show');
	} else {
		fnMessageModalAlert("알림", "변경하고자 하는 교정일자 항목을 1개 선택하여야 합니다."); // Notification
	}
	
	 
}


//교정대상 적용여부 미사용
$(":radio[name='m_correct_yn_yn']").on('ifChecked', function(event){
//  console.log("rdo_safety_stock_yn = " + $(":radio[name='rdo_safety_stock_yn']:checked").val());
 
 var radioV = $(":radio[name='m_correct_yn_yn']:checked").val();
 
 console.log("radioV 버튼은?" + radioV);
 
 var correct_date = document.getElementById("m_correct_date_r");
 
 if ( radioV == "N" ) {	
	 $("#m_correct_date_r").hide();
	 $("#m_correct_cycle_r").hide();
	 $("#m_correct_next_date_r").hide();
	 $("#m_correct_institutions_r").hide();
	 $("#m_file_upload_r").hide();
 } else {
	 $("#m_correct_date_r").show();
	 $("#m_correct_cycle_r").show();
	 $("#m_correct_next_date_r").show();
	 $("#m_correct_institutions_r").show();
 }
});

//화면내 교정일자 미사용일경우 히든처리
$(":radio[name='correct_yn_yn']").on('ifChecked', function(event){
//  console.log("rdo_safety_stock_yn = " + $(":radio[name='rdo_safety_stock_yn']:checked").val());
 
 var radioV = $(":radio[name='correct_yn_yn']:checked").val();
 
 console.log("radioV 버튼은?" + radioV);
 
 var correct_date = document.getElementById("m_correct_date_r");
 
 if ( radioV == "N" ) {	
	 $("#correct_date").attr('disabled', true);
	 
 } else {
	 $("#correct_date").attr('disabled', false);
 }
});

function changCycle()
{
	
	console.log("changCycle()");
}

//교정주기
function requestCycle() {

    console.log("requestCycle()");
    
    var cycle = $("#m_correct_cycle").val();
    
    var writeCycle = Number(cycle) * Number('365');
    
    var date = $("#m_correct_date").val();
    
    var next_date =  moment(date).add(writeCycle, "d").format("YYYY-MM-DD");
    
    console.log("cycle :" + cycle);
    console.log("date :" + date);
    console.log("next_date :" + next_date);
    
    $("#m_correct_next_date").val(next_date);
}

function saveProcess(){
	console.log("saveProcess()");
	
	var correct_yn = $(":radio[name='m_correct_yn_yn']:checked").val();
	
	if(correct_yn == 'Y'){
		insFile();
	}else{
		saveItem();
	}
	
}

//저장
function saveItem() {
	
	console.log('saveItem()');
	var pageUrl = "";
	var correct_yn = $(":radio[name='m_correct_yn_yn']:checked").val();
	
	
	if( correct_yn == 'N'){
		
	var correct_num = $("#m_correct_num").val();
	var instrument_nm = $("#m_instrument_nm").val();
	var maker = $("#m_maker").val();
	var instrument_num = $("#m_instrument_num").val();
	var device_num = $("#m_device_num").val();
	var standard = $("#m_standard").val();
	var use_team = $("#m_use_team").val();
	var manager_nm = $("#m_manager_nm").val();
	var register_date = $("#m_register_date").val();
	var key = w2ui.grid_list.getSelection();
	
	

	$("#modal_info").modal('hide');
	
	var strUrl = "/frontend/quality/saveInstrument";
	
	var postData = "correct_num=" + encodeURIComponent(correct_num)
			+ "&instrument_nm=" + encodeURIComponent(instrument_nm)
			+ "&maker=" + encodeURIComponent(maker)
			+ "&instrument_num=" + encodeURIComponent(instrument_num)
			+ "&device_num=" + encodeURIComponent(device_num)
			+ "&standard=" + encodeURIComponent(standard)
			+ "&use_team=" + encodeURIComponent(use_team)
			+ "&manager_nm=" + encodeURIComponent(manager_nm)
			+ "&register_date=" + encodeURIComponent(register_date)
			+ "&correct_yn=" + encodeURIComponent(correct_yn);
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
	}else{
		
		var correct_num = $("#m_correct_num").val();
		var instrument_nm = $("#m_instrument_nm").val();
		var maker = $("#m_maker").val();
		var instrument_num = $("#m_instrument_num").val();
		var device_num = $("#m_device_num").val();
		var standard = $("#m_standard").val();
		var use_team = $("#m_use_team").val();
		var manager_nm = $("#m_manager_nm").val();
		var register_date = $("#m_register_date").val();
		var correct_date =  $('#m_correct_date').val();
		var correct_institutions = $("#m_correct_institutions").val();
		var correct_cycle = $("#m_correct_cycle").val();
		var correct_next_date =  $('#m_correct_next_date').val();
		var down_file_name = $("#m_down_file_name").val();
		
		if(file_upload_yn == 'N'){	
			$("#modal_info").modal('hide');
			console.log('file_upload_yn??'+file_upload_yn);
			
			var strUrl = "/frontend/quality/saveInstrument2";
			
			var postData = "correct_num=" + encodeURIComponent(correct_num)
					+ "&instrument_nm=" + encodeURIComponent(instrument_nm)
					+ "&maker=" + encodeURIComponent(maker)
					+ "&instrument_num=" + encodeURIComponent(instrument_num)
					+ "&device_num=" + encodeURIComponent(device_num)
					+ "&standard=" + encodeURIComponent(standard)
					+ "&use_team=" + encodeURIComponent(use_team)
					+ "&manager_nm=" + encodeURIComponent(manager_nm)
					+ "&register_date=" + encodeURIComponent(register_date)
					+ "&correct_date=" + encodeURIComponent(correct_date)
					+ "&correct_institutions=" + encodeURIComponent(correct_institutions)
					+ "&correct_cycle=" + encodeURIComponent(correct_cycle)
					+ "&correct_next_date=" + encodeURIComponent(correct_next_date)
					+ "&correct_yn=" + encodeURIComponent(correct_yn);
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
			
			
		}else{
			
			fnMessageModalConfirm('알림', '파일 업로드를 진행 하시겠습니까?',function(chk){
				if(chk){
					
					if(curFile){
						curFile.submit();
					} else {
						if((down_file_name != '') && isRev){
							var pageUrl = '/frontend/quality/insInstrument';
							var postData = {
									correct_num : correct_num,
									instrument_nm : instrument_nm,
									maker : maker,
									instrument_num : instrument_num,
									device_num : device_num,
									standard : standard,
									use_team : use_team,
									manager_nm : manager_nm,
									register_date : register_date,
									correct_yn : correct_yn,
									correct_date : correct_date,
									correct_cycle : correct_cycle,
									correct_next_date : correct_next_date,
									down_file_name : down_file_name,
									correct_institutions : correct_institutions
								
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
										$('#modal_info').modal('hide');
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

	var key = w2ui.grid_list.getSelection();
	if( key.length==0 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else if( key.length>1 ) {
		fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
		return;
	} else {

		var data = w2ui.grid_list.get(key[0]);
		var correct_num = data.correct_num;
		var instrument_nm = data.instrument_nm;
		var maker = data.maker;
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				
				var strUrl = "/frontend/quality/deleteInstrument";
				var postData = "correct_num=" + encodeURIComponent(correct_num);
				
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
var curFile = null;
function loadData()
{
	console.log('loadData()');
    if(tab_flag == 'tab1')
	{
		
		w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });

		$("#btn_update").attr('disabled', false);
		$("#btn_create").attr('disabled', false);
		$("#btn_delete").attr('disabled', false);
		
		loadList();

	}else if(tab_flag == 'tab2')
	{

		w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });
		$("#btn_update").attr('disabled', true);
		$("#btn_create").attr('disabled', true);
		$("#btn_delete").attr('disabled', true);
		
		
		loadHistory();
	}
}

function chgEindt()
{
	console.log('chgEindt()');
	loadList();
}
//조회
function loadList()
{
	console.log('loadList()');
	
	try{
		w2ui['grid_list'].clear();
	}catch(e)
	{
		
	}

	var chk_eindt = $("input:checkbox[id='chk_eindt']").is(":checked")
	console.log('chk_eindt : ' + chk_eindt);
	
	var correct_date = $("#correct_date").val();
	correct_date = correct_date.replace(/-/gi, "");
	
	if(chk_eindt == 'false' || chk_eindt == false)
	{
		correct_date = '';
	}
	var instrument_nm = $('#instrument_nm').val();
	var correct_num = $('#correct_num').val();
	
	var correct_yn_yn = $(":radio[name='correct_yn_yn']:checked").val();
	
	var page_url = "/frontend/quality/selectInstrument";
	
	var postData = '';
	
	if(correct_yn_yn == 'Y'){
		postData = "correct_date=" + encodeURIComponent(correct_date)
					+ "&correct_yn=" + encodeURIComponent(correct_yn_yn)
					+ "&instrument_nm=" + encodeURIComponent(instrument_nm)
					+ "&correct_num=" + encodeURIComponent(correct_num);
		}else {
			postData = "correct_yn=" + encodeURIComponent(correct_yn_yn)
					+ "&instrument_nm=" + encodeURIComponent(instrument_nm)
					+ "&correct_num=" + encodeURIComponent(correct_num);
		}
	
	
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
					
					if(row.instrument_nm)comboValue_nm1.push(row.instrument_nm);
					if(row.correct_num)comboValue_nm2.push(row.correct_num);
					
					if(row.file_path == '' || row.file_path == 'null' || row.file_path == null )
					{
						
					}else{
					row.down_file_name = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name='
									+ encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
				
					}
				});
				
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#instrument_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					$('#correct_num').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
					startValue_combo = ":)";
				}
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();

		},complete: function () {
				
			document.getElementById("instrument_nm").style.removeProperty("height");
			document.getElementById("correct_num").style.removeProperty("height");
		}
	});
}

//이력보기
function loadHistory()
{
	console.log('loadHistory()');
	try{
		w2ui['grid_list'].clear();
	}catch(e)
	{
		
	}
	
	var chk_eindt = $("input:checkbox[id='chk_eindt']").is(":checked")
	console.log('chk_eindt : ' + chk_eindt);
	
	var correct_date = $("#correct_date").val();
	correct_date = correct_date.replace(/-/gi, "");
	
	if(chk_eindt == 'false' || chk_eindt == false)
	{
		correct_date = '';
	}
	var instrument_nm = $('#instrument_nm').val();
	var correct_num = $('#correct_num').val();
	
	var correct_yn_yn = $(":radio[name='correct_yn_yn']:checked").val();
	
	var page_url = "/frontend/quality/selectInstrumentHis";
	
	var postData = '';
	
	if(correct_yn_yn == 'Y'){
		postData = "correct_date=" + encodeURIComponent(correct_date)
					+ "&correct_yn=" + encodeURIComponent(correct_yn_yn)
					+ "&instrument_nm=" + encodeURIComponent(instrument_nm)
					+ "&correct_num=" + encodeURIComponent(correct_num);
		}else {
			postData = "correct_yn=" + encodeURIComponent(correct_yn_yn)
					+ "&instrument_nm=" + encodeURIComponent(instrument_nm)
					+ "&correct_num=" + encodeURIComponent(correct_num);
		}
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
					
					if(row.instrument_nm)comboValue_nm1.push(row.instrument_nm);
					if(row.correct_num)comboValue_nm2.push(row.correct_num);
					
					if(row.file_path == '' || row.file_path == 'null' || row.file_path == null )
					{
						
					}else{
					row.down_file_name = '<a href="/file/attach_download?file_path=' + row.file_path +'&file_name='
									+ encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
				
					}
				});
				
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#instrument_nm').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					$('#correct_num').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
					startValue_combo = ":)";
				}
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			

		},complete: function () {
			document.getElementById("instrument_nm").style.removeProperty("height");
			document.getElementById("correct_num").style.removeProperty("height");
		}
	});
}

//-------------------------------------------------------------------------------------------------------------------


//엑셀 다운로드
function excelFileDownload()
{
	console.log("excelFileDownload()");
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;

	var fileName = '계측기관리.xlsx';
	var sheetTitle = '계측기관리';
	var sheetName = '계측기관리';
	
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


function setUploadFileParma(pInfo, pName){
	curFile = pInfo;
}

var file_upload_yn = 'N';

function fnLoadFileHandler(){
	
	$('.fileupload').fileupload({
		url : "/frontend/quality/insInstrument",
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
			
			$('#m_down_file_name').val(data.files[0].name);
		/* 	 if(!$('#mod_input_file_name').val()) $('#mod_input_file_name').val(data.files[0].name); */
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
    	
    	/* $('#t_' + e.target.id).val(data.files[0].name);
    	$('#a_' + e.target.id).val(data.result.file_group); */
    	
    	$('#modal_info').modal('hide');
 
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
    	loadList();
 
    	
    	
	}).on('fileuploadfail', function(e, data) {
		setTimeout(function () {
			$('#progress').hide();
	    	$('#progress .progress-bar').css('width', '0%');
		}, 700);
		
		fnMessageModalAlert("알림", "파일 업로드를 실패했습니다.");
		
	}).on('fileuploadsubmit', function(e, data){
		var $this = $(this);
		
		var recids = w2ui.grid_list.getSelection();
		var pdata = w2ui.grid_list.get(recids[0]);
		
		var correct_num = $("#m_correct_num").val();
		var instrument_nm = $("#m_instrument_nm").val();
		var maker = $("#m_maker").val();
		var instrument_num = $("#m_instrument_num").val();
		var device_num = $("#m_device_num").val();
		var standard = $("#m_standard").val();
		var use_team = $("#m_use_team").val();
		var manager_nm = $("#m_manager_nm").val();
		var register_date = $("#m_register_date").val();
		var correct_date =  $('#m_correct_date').val();
		var correct_institutions = $("#m_correct_institutions").val();
		var correct_cycle = $("#m_correct_cycle").val();
		var correct_next_date =  $('#m_correct_next_date').val();

		var correct_yn = $(":radio[name='m_correct_yn_yn']:checked").val();

		
		
		data.formData = {
				
				correct_num : correct_num,
				instrument_nm : instrument_nm,
				maker : maker,
				instrument_num : instrument_num,
				device_num : device_num,
				standard : standard,
				use_team : use_team,
				manager_nm : manager_nm,
				register_date : register_date,
				correct_yn : correct_yn,
				correct_date : correct_date,
				correct_cycle : correct_cycle,
				correct_next_date : correct_next_date,
				correct_institutions : correct_institutions


		}
		
		
		$this.fileupload('send', data);
		return false;
	}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
}



function delFile(){
	fnMessageModalConfirm('알림', '파일 삭제를 진행 하시겠습니까?',function(chk){
		if(chk ){
			var recids = w2ui.grid_list.getSelection();
			var rData;
			var fileData = [];
			
			$.each(recids, function(idx, recid){
				rData = w2ui.grid_list.get(recid);
				fileData.push(rData);
			})
			var p = "param=" + encodeURIComponent(JSON.stringify(fileData));
			var pageUrl = "/file/delFileInfo";
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
	})
	
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