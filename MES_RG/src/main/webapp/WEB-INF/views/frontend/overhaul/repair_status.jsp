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
	
	<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
	<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
	<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>


</head>


<body class="hold-transition skin-<%= thema %> sidebar-mini"><!-- <.%=thema%.> -->
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1017" />
		<jsp:param name="selected_menu_cd" value="1075" />
	</jsp:include>
	
	

 <div class="content-wrapper">
	<section class="content-header">
		<h1>
			수리현황 분석 <small>Overhaul</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Overhaul </a></li>
			<li class="active">수리현황 분석</li>
		</ol>
	</section>

	<!-- 내용  -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="gridLoad" onclick="loadData();" class="btn btn-warning btn-sm">검색</button>
						</div>
					</div>

					<div class="box-body">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
								<label>출고일자</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="repair_day" placeholder="yyyymmdd~yyyymmdd" onChange="">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>접수번호</label> <input type="text" id="repair_num" name="repair_num" placeholder="ex) 접수번호"
									 class="form-control input-sm" maxlength="100" />
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>P/N</label> <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" maxlength="100" 
									 onkeypress="if(event.keyCode==13) {getItemInfo(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>품명</label> <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" maxlength="100" 
									 onkeypress="if(event.keyCode==13) {getItemInfo(); return false;}"/>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>FROM공정</label>
									<select id="from_fair" name="from_fair" class="form-control" style="height: 30px;" onchange="changeData();">
									 
									</select>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									<label>TO공정</label>
									<select id="to_fair" name="to_fair" class="form-control" style="height: 30px;">
									
									</select>
								</div>
							</div>
							
						</div>
						<div class="row" style="margin-bottom: 10px">
							<div class="col-md-12 text-center">
								<div id="table_chart1"
									style="width: 100%; height: 300px; text-align: center;"></div>
							</div>
						</div>
		
						<div class="row">
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 300px; "></div>
							</div>
						</div>
					</div>
				</div>
			</div> <!-- 공정그룹 목록 -->
		</div><!-- 젤 앞의  row -->
	</section>
</div> <!-- content-wrapper -->
	<!-- 내용 End --> 

	<!-- modal -->
<div class="modal fade" id="ins_mod" data-backdrop="static">
	<div class="modal-dialog modal-lg" style="width: 1250px;">
		<div class="modal-content">
			<div class="modal-header">
				<div class="col-md-3" style="padding: 0px;">
					<h4 class="modal-title" >검사보고서 </h4>
				</div>
				<div class="col-md-9" style="padding-top: 4px;">
					<div class="progress" style="margin:0px; display: none;">
						<div class="progress-bar progress-bar-warning"></div>
					</div>
				</div>
        	</div>
			<div class="modal-body" >
				<form name="frm_insertInfo" class="form-horizontal">
					<input type="hidden" class="clear_field" id="mod_repair_num"/>
					<div class="form-group row" style="margin-bottom: 100px; margin-top: 45px;">
						<div class="col-sm-4">
							<div class="row" >
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE; margin-bottom: 10px; margin-left: 30px;">1. 입고</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status1"  disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
								
									
									<input type="text" class="fileupload form-control clear_field dp_component_d"
												id="mod_proc1_date">
				
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="fileupload form-control clear_field" id="mod_proc1_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc1_file_name" name="mod_proc1_file_name" class="fileupload form-control input-sm clear_field" readonly>
									<input type="hidden" id="mod_proc1_file_group" name="mod_proc1_file_group" class="fileupload form-control input-sm clear_field">
								</div>
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">2. 세정</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status2" disabled="disabled"  />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
							
										<input type="text" class="fileupload form-control clear_field dp_component_d"
												id="mod_proc2_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="fileupload form-control clear_field" id="mod_proc2_manager_nm" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc2_file_name" name="mod_proc2_file_name" class="fileupload form-control input-sm clear_field" readonly>
									<input type="hidden" id="mod_proc2_file_group" name="mod_proc2_file_group" class="fileupload form-control input-sm clear_field">
								</div>
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label "  style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">3. 반조립</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="fileupload form-control clear_field" id="mod_status3"  disabled="disabled"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
					
										<input type="text" class="fileupload form-control clear_field dp_component_d"
												id="mod_proc3_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="fileupload form-control clear_field" id="mod_proc3_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc3_file_name" name="mod_proc3_file_name" class="fileupload form-control input-sm clear_field" readonly>
									<input type="hidden" id="mod_proc3_file_group" name="mod_proc3_file_group" class="fileupload form-control input-sm clear_field">
								</div>
								
							</div>
							
						</div>
					</div>
					
					
					<div class="form-group row">
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">4. 중간검사</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status4" disabled="disabled" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
						
												<input type="text" class="fileupload form-control clear_field dp_component_d"
												id="mod_proc4_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="fileupload form-control clear_field" id="mod_proc4_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc4_file_name" name="mod_proc4_file_name" class="fileupload form-control input-sm clear_field" readonly>
									<input type="hidden" id="mod_proc4_file_group" name="mod_proc4_file_group" class="fileupload form-control input-sm clear_field">
								</div>
								
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">5. 최종</label>
							</div> 
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="form-control clear_field" id="mod_status5" disabled="disabled" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
							
										<input type="text" class="fileupload form-control clear_field dp_component_d"
												id="mod_proc5_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="fileupload form-control clear_field" id="mod_proc5_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc5_file_name" name="mod_proc5_file_name" class="fileupload form-control input-sm clear_field" readonly>
									<input type="hidden" id="mod_proc5_file_group" name="mod_proc5_file_group" class="fileupload form-control input-sm clear_field">
								</div>
								
							</div>
							
						</div>
						<div class="col-sm-4">
							<div class="row">
								<label for="" class="col-sm-10 control-label " style="text-align: center; background-color: #A6DEFE;  margin-bottom: 10px; margin-left: 30px;">6. 수리완료보고서</label>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">상태</label>
								<div class="col-sm-8">
									<input class="fileupload form-control clear_field" id="mod_status6" disabled="disabled" />
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">처리일자</label>
								<div class="col-sm-8">
						
										<input type="text" class="fileupload form-control clear_field dp_component_d"
												id="mod_proc6_date">
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">담당자</label>
								<div class="col-sm-7">
									<input class="fileupload form-control clear_field" id="mod_proc6_manager_nm"/>
								</div>
							</div>
							<div class="row">
								<label for="" class="col-sm-3 control-label ">첨부파일</label>
								<div class="col-sm-7">
									<input type="text" id="mod_proc6_file_name" name="mod_proc6_file_name" class="fileupload form-control input-sm clear_field" readonly>
									<input type="hidden" id="mod_proc6_file_group" name="mod_proc6_file_group" class="fileupload form-control input-sm clear_field">
								</div>
								
							</div>
							
						</div>
					</div>
					
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<button type="button"  class="btn btn-default btn-sm" id="close_mod" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
	<!-- modal End -->

	<jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>

	<jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>

</div>

<script src="/res/plugins/pagination.js"></script>
<script src="/res/plugins/pagination1.js"></script>
<script type="text/javascript">
	var page = 1; 		// 화면에서 사용할 page
	var pageNum = 0; 	// 서버에 넘겨줄 page -> mysql 은 0 부터 시작
	var rowPerPage = 20;
	var rowLength = 0;
	var totalPage = 0;
	var cntRowPagination = 5;	// << 1 2 3 4 5 >>

	var chartData = [];
	var layoutStr = "";
	
	var from_fairArr = new Array();
	
	/* comboValue_nm1 = new Array;

	var startValue_combo2 = ""; */
			//-------------------------------------------------------------------------------------------------------------------
	$(function($) {
/* 
		rMateChartH5.create("chart1", "table_chart1", "", "100%", "100%");
		$('#table_chart1').css("display", "none");
 */
 
		fnCdD('from_fair', 'MC1019');
 		fnCdD('to_fair', 'MC1019');
 
 
		fnLoadCommonOption(); // 달력
		settingLayout();
		initGridList(); // 첫 그리드
		
		// KPI 매출, 구매는 '년 콤보 10년 ' -> 미출하, 주문에 대해서 누적그래프 표시
		//연목표 / 균등분할 / 합계
        // ERROR 2020-12-15
        // E11466440XP    CYCLE 확인 
        
        
        
		//loadList();
		
		requestItem();

	})
	
	var layoutStr = '';
function settingLayout()
{
	
	
	makeLayout();
	
	rMateChartH5.create("chart1", "table_chart1", "", "100%", "100%");
	rMateChartH5.calls("chart1", { "setLayout" : layoutStr, "setData" : new Array() });
	$('#progress_Loading').css("display", "none");
	$('#table_chart1').css("display", "");	
	

}

	//-------------------------------------------------------------------------------------------------------------------
	// 달력
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
		
		 
		 $("#m_order_price").keyup(function(event) {
				if(event.which >= 37 && event.which <= 40) return;
				$(this).val(function(index, value) {
					return value
					.replace(/\D/g, "")
					//.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				});
			});
		 
		 
		// minDate = '20200701';
		 
		 
		 
		 $('#repair_day').daterangepicker({
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
	
	function loadGrid() {
		var item_code = $('#item_code').val();
		var item_nm = $('#item_nm').val();
		console.log("item_code : " + item_code);
		console.log("item_nm : " + item_nm);

	
		
		
		if(item_code != '' || item_nm != '')
		{
			
			loadList();
		}else
			{
			fnMessageModalAlert("알림", "P/N 또는 품명을 입력해주세요.");
			}

		
	}
 
			
	function getFailPer(name)
	{
		var val0 = w2ui.grid_list.get(1)[name];
		var val1 = w2ui.grid_list.get(2)[name];
		
		if(val0 == 0)
			{
			return 0;
			}
		
		var q_v = val1 / val0 * 1000000;
		var result = parseInt(q_v);
		
		
		return result;
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
		    		
		    		//from_fairArr = rowArr;
		    		from_fairArr = new Array();
		    		var obj = new Object();
		    		obj.detail_code = '-0';
		    		obj.code_nm = '입고일자';
		    		from_fairArr.push(obj);
		    		
		    		for(var i = 0; i<rowArr.length; i++)
		    		{
		    			from_fairArr.push(rowArr[i]);
		    		}
		    		
		    		var obj2 = new Object();
		    		obj2.detail_code = '-7';
		    		obj2.code_nm = '출고일자';
		    		from_fairArr.push(obj2);
		    		
		    		var sub = val.substr(0,2);
		    		
		    		//  if(valsub != "m_")
		    /* 		if(sub.indexOf("m_") == -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>"); */
		    		
					$.each(from_fairArr, function(idx, row){
						if(val == 'from_fair'){
							
						
							if(from_fairArr.length - 1 != idx){
								$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
							}
							
						}else if(val == 'to_fair'){
							if(idx > 0){
							$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
							}
						}
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);
		 			
		 			$("#to_fair option:eq(6)").prop("selected", true);
		 		
	
		
		 			
		 			
		    	} 
		    	
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
		    },
		    complete: function() {
		    	
		    }
		});
		
	}
	
	function fnFileType(val, comp, initSelect,  initTxt, initVal, fixYn){
		
		var $target;
		
		if(!comp) $target = $('.file_type_code');
		else $target = $(comp);
		
		$target.html('');
		
		var strUrl = "/file/selectFileType";
		var postData = "";
		postData = "del_yn=" + encodeURIComponent("N");
		if(val) postData += "&file_class_code=" + encodeURIComponent(val);
		
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
	//-------------------------------------------------------------------------------------------------------------------
	// 첫 그리드
	function initGridList() {
		console.log('initGridList()');
		var rowArr = [];

		// project_manager
		$('#grid_list').w2grid({
	        name: 'grid_list',
	        show: { footer: true }, // , selectColumn: true
	        columnGroups: [
	                      /*  { caption: '생산지시번호', master: true },
	                       { caption: '주야', span: 1  } */
	                   ],
	        multiSelect: false,
	        columns: [
	                  //33
					{ field: 'repair_num', caption: '접수번호', size: '20%', sortable: true, attr: 'align=center', resizable: true },
					{ field: 'item_code', caption: 'P/N', size: '20%', sortable: true, attr: 'align=center', resizable: true},
					{ field: 'item_nm', caption: '품명', size: '20%', sortable: true, attr: 'align=center', resizable: true},
					{ field: 'sernr', caption:'S/N', size: '20%', style:'text-align:center', sortable: true},
					{ field: 'from_ym', caption: 'from', size: '20%', sortable: true, attr: 'align=center', resizable: true, hidden:true},
					{ field: 'from_date', caption: '입고일자', size: '20%', sortable: true, attr: 'align=center', resizable: true},
					{ field: 'timef_0', caption: '일자-입고검사', size: '25%', sortable: true, attr: 'align=center', resizable: true}, 		
					{ field: 'timef_1', caption: '입고검사-세정', size: '25%', sortable: true, attr: 'align=center', resizable: true
						/* ,render: function (record, index, col_index) {
							var val = this.getCellValue(index, col_index);
							if(record.gb == '달성률(%)'){
								return val + '%';
							}else if(record.gb == '부적합률(PPM)'){
								return getFailPer('c5');
							}else{
								return w2utils.formatNumber(Number(val));
							}
			            } */
					},
					{ field: 'timef_2', caption: '세정-반조립', size: '25%', sortable: true, attr: 'align=center', resizable: true}, 		//v
					{ field: 'timef_3', caption: '반조립-중간검사', size: '25%', sortable: true, attr: 'align=center', resizable: true},
					{ field: 'timef_4', caption: '중간검사-최종검사', size: '25%', sortable: true, attr: 'align=center', resizable: true},
					{ field: 'timef_5', caption: '최종검사-수리완료보고서', size: '30%', sortable: true, attr: 'align=center', resizable: true},
					{ field: 'timef_6', caption: '수리완료보고서-출고', size: '30%', sortable: true, attr: 'align=center', resizable: true},
					{ field: 'total', caption: '합계', size: '20%', sortable: true, attr: 'align=center', resizable: true}
		    ],
	        sortData: [
			],
			total : 0,
			recordHeight : 30,
			onReload: function(event) {},
			onClick: function (event) {
			},
			onDblClick: function (event) {
			},
			
			onSelect: function (event) {
				event.onComplete = function () {
					console.log("onSelect_g");
					
					var key = w2ui.grid_list.getSelection();
					var data = w2ui.grid_list.get(key[0]);
					
					var repair_num = data.repair_num;
					
					if(repair_num == '' || repair_num == null || repair_num == 'null'){
						
						console.log("없따!");
						w2ui['grid_list'].refresh();
					}
				
					loadModal(repair_num);
				}
			},
	    });

		// 차트 값 넣기
		//loadList();

	}
	

	
	
	function changeData()
	{
		console.log("changeData()");
		
		var from_fair = $('#from_fair').val();
		
		var from_idx = from_fair.slice(-1);
		
		console.log('from_idx : ' + from_idx);
		
		initOptions( $('#to_fair') );
		
		$.each(from_fairArr, function(idx, row){	 
			 if(idx > from_idx){
				$("#to_fair").append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
			 }
		});

		$("#to_fair option:eq(0)").prop("selected", true);	 
		
		
		
		// loadList();
		
	}
	
	
	var textArr = new Array();
	
	var gridDataArr;
	//-------------------------------------------------------------------------------------------------------------------
	function loadList(){
		console.log("loadList()");
		
		var item_code = $('#item_code').val();
		var item_nm = $('#item_nm').val();
		
        if( item_code.length < 1 ){
			
			item_nm ='';
			
		}else if( item_nm.length < 1 ){ 
			
			item_code='';
		}
		 
		if(item_code == '' && item_nm == '')
		{
			fnMessageModalAlert("알림", "검색조건을 입력해주세요.");
			return;
		} 
		
		comboValue_nm1 = new Array;

		var startValue_combo2 = ""; 
		
		maxData1 = '0';
		var from_date = $("#repair_day").val();
		from_date = from_date.replace(/-/gi, "");
		
		var item_code = $('#item_code').val();
		var item_nm = $('#item_nm').val();
		var repair_num = $('#repair_num').val();
		
		
		/* if(item_code != '' || item_nm != '')
		{
		}else
		{
			fnMessageModalAlert("알림", "P/N 또는 품명을 입력해주세요.");
			return;
		} */

		var page_url = '';
		var postData = '';

		page_url = "/frontend/repair/selectRepairAnalysis";
		postData = {
				
				item_code : item_code,
				from_date : from_date,
				repair_num : repair_num,
				item_nm : item_nm
		};

		//w2ui['grid_list'].lock('loading...', true);

		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			data: postData,
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					gridDataArr = new Array();
					var grapArr = [{},{},{},{},{},{},{}];
					
					var timeArr = [0,0,0,0,0,0,0];

					var item_cnt = rowArr.length;
					
					var from_fair = $('#from_fair').val();
					var to_fair = $('#to_fair').val();
					
					var from_idx = from_fair.slice(-1);
					var to_idx = to_fair.slice(-1);

					console.log("from_idx : " + from_idx);
					console.log("to_idx : " + to_idx);
					
					
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						
						if(row.repair_num)comboValue_nm1.push(row.repair_num);
						//var grapObj = new Object();
						//grapObj.from_date = row.from_date;		
						
						
						if (startValue_combo2 == "") {
						
							gridDataArr = rowArr;
							
							comboValue_nm1.push(row.repair_num);
 						}
						
				        //2 3 
						
						for(var i = 0; i < from_idx; i++ )
						{						
							var value = 'time_' + i;
							row[value] = '';
							
							var value2 = 'timef_' + i;
							row[value2] = '';
						}
						
						for(var i = to_idx; i<7; i++ )
						{						
							var value = 'time_' + i;
							
							row[value] = '';
							
							var value2 = 'timef_' + i;
							row[value2] = '';
						}
					 	//----------- 공통 토탈 계산 --------------//
					 	
					 	var tot = 0;
						for(var i = 0; i<7; i++ )
						{
							var value = 'time_' + i;
							var min = row[value];	
							if(min == '')
							{
								min = 0;
							}
							tot = Number(tot) +  Number(min);
						}
						
						row.total = timeConvert(tot);	
						//grapObj.total  = Number(tot) / 60;
						
						
					 	//----------- 토탈의 맥스값 가져오기 --------------//
					 	/* try{
						 	if( parseInt(maxData1) < parseInt(grapObj.total) ){
						    	maxData1 = grapObj.total;
						    }
						}catch(e)
						{
						
						}  */
						
						//grapArr.push(grapObj); 

						// 그래프 데이터 셋팅
						for(var i = 0; i< timeArr.length; i++)
						{
							var value = 'time_' + (i);
							timeArr[i] = Number(timeArr[i]) + Number(row[value]); 
							
							if(idx == Number(rowArr.length - 1))
							{
								timeArr[i] = timeConvert_num( Number(timeArr[i]) / Number(item_cnt) );
							}
						}
					});
					
					w2ui['grid_list'].records = rowArr;
					
					if (startValue_combo2 == "") {
						$('#repair_num').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					}
						
			
					console.log('from_fairArr : '+ from_fairArr.length);
					console.log('from_idx : '+ from_idx);
					console.log('to_idx : '+ to_idx);
		
				 	/* for(var i = from_idx; i < to_idx; i++)
					{					
						var grapObj = new Object();
						console.log('TEST : ' + from_fairArr[i].code_nm );
						var new_index = Number(i) + 1;
						console.log('new_index : ' + new_index );
						grapObj.process = from_fairArr[i].code_nm + '-' +  from_fairArr[new_index].code_nm;
						grapObj.total = timeArr[i];
						grapArr.push(grapObj);
					}   */
					
					
					grapArr = new Array();
					textArr = ['','','','','','',''];
					 for(var i = from_idx; i < to_idx; i++)
					{					
						var grapObj = new Object();
	
						var new_index = Number(i) + 1;				
							
						var process = from_fairArr[i].code_nm + '-' +  from_fairArr[new_index].code_nm;

						textArr[i] = process;
						//process = Number(i+1) * 10000;
						process = Number(i) + 1;
						
						$.each(rowArr, function(idx, row){
						
							var value = 'time_' + i;
							var val = row[value];						
							var total = timeConvert_num(Number(val));
							
							grapObj = new Object();
	
							grapObj.country = '';
							//grapObj.process = Number(process)+Number(idx);
							grapObj.process = process;
							
							grapObj.value = total;
							grapArr.push(grapObj);
						
						});
						
					}  
		
					try{
						for(var i = 0; i < grapArr.length; i++)
						{
							if( parseInt(maxData1) < parseInt(grapArr[i].total) ){
						    	maxData1 = grapArr[i].total;
						    }
						}	 
					}catch(e)
					{
					
					} 
		
					
					console.log(grapArr);
					makeLayout();
					rMateChartH5.calls("chart1", { "setLayout" : layoutStr, "setData" : grapArr});

					
					
				} else {
					w2ui['grid_list'].clear();
					settingLayout();
					rMateChartH5.call("chart1", "hasNoData", true);
				}

				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {
				startValue_combo2 = ":)";
				
				document.getElementById("repair_num").style.removeProperty("height");
			}
		});

		//page_url = "/frontend/info/selectTrend_grap";

		// 차트 레이아웃 + 차트 생성
		/* rMateChartH5.create("chart1", "table_chart1", "", "100%", "100%");
		makeLayout();
		$('#table_chart1').css("display", "");

		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			data: postData,
			success : function( data ) {
				if(data.status == 200 && (data.rows).length > 0 ) {
					//첫번재 그래프
					rMateChartH5.calls("chart1", { "setLayout" : layoutStr, "setData" : data.rows});
				} else {
					rMateChartH5.calls("chart1", { "setLayout" : layoutStr, "setData" : data.rows});
					rMateChartH5.call("chart1", "hasNoData", true);
				}
			},complete: function () {}
		}); */

	}
	
	function insReport() {
		console.log("insReport()");
		$('.clear_field').val('');
	 	var minDate = getFormatDate(new Date());
		$('.dp_component_d').daterangepicker(
				{
					opens : 'right',
					singleDatePicker : true,
				     timePicker: true,
				      timePicker24Hour:true,
					locale : {
						format : 'YYYY-MM-DD HH:mm:00', //'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
						showMonthAfterYear : true,
						yearSuffix : '년',
						orientation : "top left"
					},
						startDate : moment(minDate).format('YYYY-MM-DD HH:mm:00')
					
				}); 

		$('.fileupload').attr('disabled', true);

		var recids = w2ui.grid_list.getSelection();
		
			
			var pData = infoArr[0];
			
			var keys = Object.keys(pData);

			$.each(keys, function(idx, key){
				
				if(key.includes('file_group')){
					var kidx = key.substring(4,5) - 1;
					var repair_class_code = pData.repair_class_code;
					
				   	/* 
					if( repair_class_code == 'MD1578'){
						$('#file_group'+(kidx+1)).attr('disabled', false);
						$('#file_btn'+(kidx+1)).attr('disabled', false);
						
					}else if(kidx != 0 && !pData['proc' + kidx + '_file_group']){
						$('#file_group'+(kidx+1)).attr('disabled', true);
						$('#file_btn'+(kidx+1)).attr('disabled', true);
					} */
					 
					var managerNm = pData['proc' + kidx + '_manager_nm'];
					console.log('managerNm : ' + managerNm);
					$('#mod_proc' + kidx + '_manager_nm').val(managerNm);
				}
		 		
				
				if(pData[key]) $('#mod_'+key).val(pData[key]);
			})
			
			$('#ins_mod').modal('show');
			
			//w2ui.grid_list.selectNone();

		
	}
	
	
	var infoArr = new Array();
	function loadModal(repair_num){
		
		
	
		   var pageUrl = '/frontend/repair/selectrepairReqR';
		   
		   var postData = {
				   repair_num : repair_num || ''
		   }
			
			$.ajax({
				url : pageUrl,
				type : "POST",
				data : postData,
				dataType : 'json',
				success : function(data){
					if(data.status == 200 && (data.rows).length > 0){
						rowArr = data.rows;
						infoArr = rowArr;
						$.each(rowArr, function(idx, row){
							row.recid = idx + 1;
							
							'<a href="/file/attach_download?file_path=' + row.file_path +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.file_name+ '</i>'
							
							if(!row.proc1_file_group) row.status1 = '등록전';
							else {
								row.status1 = "등록후";
								row.proc1_file_down = '<a href="/file/attach_download?file_path=' + row.proc1_file_path +'&file_name=' + encodeURIComponent(row.proc1_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc1_file_name+ '</i>'
							}
							
							if(!row.proc2_file_group) row.status2 = '등록전';
							else {
								row.status2 = "등록후";
								row.proc2_file_down = '<a href="/file/attach_download?file_path=' + row.proc2_file_path +'&file_name=' + encodeURIComponent(row.proc2_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc2_file_name+ '</i>'
							}
							
							if(!row.proc3_file_group) row.status3 = '등록전';
							else {
								row.status3 = "등록후";
								row.proc3_file_down = '<a href="/file/attach_download?file_path=' + row.proc3_file_path +'&file_name=' + encodeURIComponent(row.proc3_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc3_file_name+ '</i>'
							}
							
							if(!row.proc4_file_group) row.status4 = '등록전';
							else {
								row.status4 = "등록후";
								row.proc4_file_down = '<a href="/file/attach_download?file_path=' + row.proc4_file_path +'&file_name=' + encodeURIComponent(row.proc4_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc4_file_name+ '</i>'
							}
							
							if(!row.proc5_file_group) row.status5 = '등록전';
							else {
								row.status5 = "등록후";
								row.proc5_file_down = '<a href="/file/attach_download?file_path=' + row.proc5_file_path +'&file_name=' + encodeURIComponent(row.proc5_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc5_file_name+ '</i>'
							}
							
							if(!row.proc6_file_group) row.status6 = '등록전';
							else {
								row.status6 = "등록후";
								row.proc6_file_down = '<a href="/file/attach_download?file_path=' + row.proc6_file_path +'&file_name=' + encodeURIComponent(row.proc6_file_name) + '" target="_blanck"><i class="fa fa-file">'+ row.proc6_file_name+ '</i>'
							}
						});
					
						
						
					} else {
					}
					
				}, complete : function(){
					insReport();
				}
			})
	}
	
	
	
	//-------------------------------------------------------------------------------------------------------------------
	
var maxData1 = '0';
	
	/*
function makeLayout() {
	var aadd1 = "";
	var ad1 = "";

 	var arr = new Array();
	arr.push(maxData1);   		
	var max = 0;
			
	for(var i =0; i<arr.length; i ++)
	{
		if(Number(max) < Number(arr[i]))
		{
			max = arr[i];
		}
	}

	if(parseInt(max) > 24 ) {
	
		console.log("maxData1 = " + maxData1 + ", Math.round(maxData1) = " + Math.round( (parseInt(max)+30)/10) * 10 );
		aadd1 = (Math.round( (parseInt(max)+30)/10) * 10)+"";
		ad1 = (aadd1/5);
	} else {
		aadd1 = '30';
		ad1 = "5";
	} 

	
	layoutStr =
        '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
             +'<Options>'
             +'<Caption text="-"/>'
                 +'<SubCaption text="" textAlign="center" />'
                  +'<Legend useVisibleCheck="true"/>'
              +'</Options>'
              +'<NumberFormatter id="nft" precision="2"/>'
            +'<Line2DChart showDataTips="true" paddingTop="0" dataTipFormatter="{nft}">'
                +'<horizontalAxis>'
                      +'<CategoryAxis categoryField="process" padding="0.2"/>'
                   +'</horizontalAxis>'
                 +'<verticalAxis>'
            	 +'<LinearAxis id="hAxis"  maximum="'+aadd1+'" interval="'+ad1+'" labelJsFunction="labelFunc"/>' //  formatter="{numFmt1}"
                   +'</verticalAxis>'
                   +'<series>'

                     +'<Line2DSeries yField="total" displayName="공정" itemRenderer="CircleItemRenderer">'
         
                          +'<showDataEffect>'
                          	+ '<SeriesClip duration="1000"/>'
                          +'</showDataEffect>'
                     +'</Line2DSeries>'
                   +'</series>'

             +'</Line2DChart>'
        +'</rMateChart>';

} */
/* function axisLabelFunc(id, value){
	
	console.log('value : ' + value);
	var text = value +'';
	console.log('text.slice(-1) : ' + text.slice(-1));
	if(text.slice(-1) == '0')
	{
		return  textArr[Number(text.slice(0,1)) - 1];
	}else
	{
		return '';
	}
} */
function axisLabelFunc(id, value){
	
	
	var result = textArr[Number(value) - 1];
 	if(result == undefined || result == 'undefined' || result == '' || result == 'null'  || result == null )
	{
		return '';
	} 
	return  result;
	
}
	 
	 
function dataTipFunc(seriesId, seriesName, index, xName, yName, data, values) {
	 return "" + data["value"] + " 시간";
}
	 
//chart - 2
function makeLayout() {
	
	var min = 0;
	var max = 1000;
	 layoutStr =
        '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
              +'<Options>'
                 +'<Caption text="-" />'
                   +'<SubCaption text="마우스 드래그로 영역을 설정하면 확대/축소를 할 수 있습니다."/>'
               +'</Options>'
            /*
                 Plot2D 차트 생성시에 필요한 Plot2DChart 정의합니다
                   showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
            */
             +'<NumberFormatter id="numFmt1" precision="2"/>'
             +'<NumberFormatter id="numFmt2" precision="0" useThousandsSeparator="true"/>'
            +'<Plot2DChart showDataTips="true" dataTipJsFunction="dataTipFunc">'
                 +'<verticalAxis>'
                    +'<LinearAxis id="vAxis" formatter="{numFmt1}" title="시간"/>'
                   +'</verticalAxis>'
                   
                   +'<horizontalAxis>'
                  /*      +'<LinearAxis id="hAxis" title="공정" />'  */
                      //labelJsFunction="axisLabelFunc"
                      +'<LinearAxis id="hAxis" title="공정" minimum="'+0+'" maximum="'+8+'" interval="'+1+'" labelJsFunction="axisLabelFunc"/>'
                      /* +'<CategoryAxis categoryField="process" formatter="{numFmt2}" displayName="공정" labelJsFunction="axisLabelFunc"/>' */
                  +'</horizontalAxis>'
                  
                 +'<backgroundElements>'
                      +'<GridLines direction="both"/>'
                 +'</backgroundElements>'
                 +'<series>'
                      +'<Plot2DSeries xField="process" yField="value" labelPosition="up" upLabelField="country" radius="6.5">'
                         +'<fill>'
                            +'<SolidColor color="#f9ad02"/>'
                         +'</fill>'
                       /* Plot2DChart 정의 후 Plot2DSeries labelPosition="inside"정의합니다 */
                       // +'<showDataEffect>'
                          /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
                              // +'<SeriesZoom relativeTo="series"/>'
                             /*
                                 SeriesZoom은 시리즈 데이터가 새로운 시리즈 데이터로 표시될 때 줌 효과를 적용합니다
                                - 공통속성 -
                                   elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
                                 minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
                                              이 값보다 짧은 시간에 effect가 실행되지 않습니다
                                offset : effect개시의 지연시간을 설정합니다 default:0
                                   perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
                                  - SeriesZoom속성 -
                                   horizontalFocus - center,left,right : 줌을 시작하는 수평의 초점을 정합니다 default:center
                                  verticalFocus - center,top,bottom : 줌을 시작하는 수직의 초점을 정합니다 default:center
                                relativeTo - chart,series : 줌의 초점을 위한 경계를 정합니다 default:chart
                               */
                        // +'</showDataEffect>'
                     +'</Plot2DSeries>'
                   +'</series>'
                 +'<annotationElements>'
                      +'<CrossRangeZoomer zoomType="both"/>'
                   +'</annotationElements>'
             +'</Plot2DChart>'
        +'</rMateChart>';
	
        
}
	
	
//-------------------------------------------------------------------------------------------------------------------
	
//품명,품번 자동완성
$("#item_nm").change(_.debounce(function(event) {
	
	var item_nm = $("#item_nm").val();
	$(this).val(function(index, value) {
		console.log('item_nm key_up : '+ value);
		
		getItemInfo('nm',value);
		return value
	});
	
},400));
$("#item_code").change(
		
		_.debounce(function(event) 
		{
	
			var item_code = $("#item_code").val();
			$(this).val(function(index, value) {
				console.log('item_code key_up : '+ value);
				
				getItemInfo('cd',value);
				return value
			});
	
},400));	
	

var startValue_combo = "";

var comboValue_nm = new Array;
var comboValue_cd = new Array;

var materialArr = new Array;

function requestItem(){

	var page_url = "/frontend/repair/selectRepairItem";

	
	$.ajax({
		url : page_url,
		type : 'POST',
		data_type : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				materialArr = rowArr;
				$.each(rowArr, function(idx, row){
					row.recid = idx + 1;
					
					if (startValue_combo == "") {
						comboValue_nm.push(row.item_nm);
						comboValue_cd.push(row.item_code);
					}
				});
			
				
				if (startValue_combo == "") {
					
					
					$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });				
					$('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
				}
			} else {
				
			}

		}, complete : function() {
			startValue_combo = ":)";
		}
	});
}
function getItemInfo(type, value)
{
	
	console.log('getItemInfo() : ' + value);
	var result = "";
	if(type == 'cd')
	{
		$.each(materialArr, function(idx, row){
			
			if(value == row.item_code)
			{
				console.log('item_nm : ' + row.item_nm);
				result = row.item_nm;		
				$("#item_nm").val(result);
			}
		});

		if(result == ''){
			$("#item_nm").val('');
		}
		
	}else if(type == 'nm')
	{
		
		$.each(materialArr, function(idx, row){
			
			if(value == row.item_nm)
			{
				console.log('row.item_code : ' + row.item_code);
				result = row.item_code;
				$("#item_code").val(result);
			}
		});
		if(result == ''){
			$("#item_code").val('');
		}
		
	}
	
	loadList();
}
	
	
	
	
	
	
	
	
	
	
	
	
	function getFormatDate(d) {
		var month = d.getMonth() + 1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		return d.getFullYear() + '-' + month + '-' + date;
	}
/* 	function timeConvert(n) {
		var num = n;
		var hours = (num / 60);
		var rhours = Math.floor(hours);
		var minutes = (hours - rhours) * 60;
		var rminutes = Math.round(minutes);
		rminutes = (rminutes < 10) ? "0" + rminutes : rminutes;
		return rhours + ":" + rminutes + ":00";
	} */
	function timeConvert(n) {
		var num = n;
		var hours = (Number(num) / 60);
		var rhours = Math.floor(hours);
	
		return hours.toFixed(1) +"시간";
	}
	
	function timeConvert_num(n) {
		var num = n;
		var hours = (Number(num) / 60);
		var rhours = Math.floor(hours);
	
		return hours.toFixed(1);
	}
	
	//-------------------------------------------------------------------------------------------------------------------
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
	
	function loadData()
	{
		var item_code = $('#item_code').val();
		var item_nm = $('#item_nm').val();
		
		console.log('item_code'+item_code.length);
		console.log('item_nm'+item_nm);
		
		if( item_code.length < 1 ){
			
			item_nm ='';
			
		}
		 
		if(item_code == '' && item_nm == '')
		{
			fnMessageModalAlert("알림", "검색조건을 입력해주세요.");
		}else{
			loadList();
		}
		
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	function initOptions(obj) {
	    $(obj)
        .find('option')
        .remove()
        .end()
        //.append('<option value="">선택</option>')
        .val();
	}
	
	function load() {
		window.open("/frontend/location/info/qCostTrend","_self");
	}
	
	function msg_time() {	// 1초씩 카운트
		setInterval("load()",3000);
	}
	</script>
</body>
</html>