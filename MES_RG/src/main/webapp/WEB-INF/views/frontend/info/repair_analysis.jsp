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
		<jsp:param name="selected_menu_p_cd" value="1042" />
		<jsp:param name="selected_menu_cd" value="1105" />
	</jsp:include>
	
	

 <div class="content-wrapper">
	<section class="content-header">
		<h1>
			공정관리분석 <small>생산관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>생산관리 </a></li>
			<li class="active">공정관리분석</li>
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
								<label>작업지시일자</label>
									<div class="input-group">
										<input type="text" 
											class="form-control pull-right input-sm" style="" id="product_req_date" placeholder="yyyymmdd~yyyymmdd" onChange="">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							<!-- <div class="col-sm-2">
								<div class="form-group">
									<label>접수번호</label> <input type="text" id="repair_num" name="repair_num" placeholder="ex) 접수번호"
									 class="form-control input-sm" maxlength="100" />
								</div>
							</div> -->
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
<!-- 									<label>FROM공정</label> -->
									<select id="from_fair" name="from_fair" class="form-control" style="height: 30px; display: none;" onchange="changeData();">
									 
									</select>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
<!-- 									<label>TO공정</label> -->
									<select id="to_fair" name="to_fair" class="form-control" style="height: 30px;display: none;">
									
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
								<div id="grid_list" style="width: 100%; height: 400px; "></div>
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
	
	var grid_size = 50;	
	$(function($) {
/* 
		rMateChartH5.create("chart1", "table_chart1", "", "100%", "100%");
		$('#table_chart1').css("display", "none");
 */
 
		fnCdD('from_fair', 'MC1019');
 		fnCdD('to_fair', 'MC1019');
 
		fnLoadCommonOption(); // 달력
		settingLayout();//그래프
		
		init_grid_list(initGridList_columns(grid_size));
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
		 
		 
		 
		 $('#product_req_date').daterangepicker({
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
	
	function init_grid_list(colObj) {
			var rowArr = [];

			$('#grid_list').w2grid({
				name : 'grid_list',
				show : {
					selectColumn : false,
					lineNumbers : false,
					footer : true
				},
				multiSelect : false,
				columns : colObj,

				records : [

				], //
				onReload : function(event) {
					//loadList();
				},
				onClick : function(event) {
				}
			});

		}
	var gridSize = 30;
	function initGridList_columns(grid_size) {
		var colObj = [];
		colObj
				.push(
						{ field: 'product_po', caption: '작업지시번호', size : '120px',frozen : true, sortable: true, attr: 'align=center', resizable: true },
						{ field: 'item_code', caption: 'P/N', size : '120px',frozen : true, sortable: true, attr: 'align=center', resizable: true},
						{ field: 'item_nm', caption: '품명', size : '120px',frozen : true, sortable: true, attr: 'align=center', resizable: true},
						{ field: 'product_req_date', caption:'작업지시일자',frozen : true, size : '120px', style:'text-align:center', sortable: true}
						
				);
		

		for (var i = 1; i <= grid_size; i++) {

			console.log('그리는중 : ' + i);
			colObj.push({
						field : 'r' + i,
						caption : '공정#' + i,
						size : '110px',
						attr : 'align=center',
						frozen : false
						
					});
			
			colObj.push({
				field : 'w' + i,
				caption : 'WAITING',
				size : '110px',
				attr : 'align=center',
				frozen : false
				
			});
		}

		return colObj;
	}
	function initGridList_columns2(grid_size) {
		var colObj = [];
		colObj
				.push(
						{ field: 'product_po', caption: '작업지시번호', size : '120px',frozen : true, sortable: true, attr: 'align=center', resizable: true },
						{ field: 'item_code', caption: 'P/N', size : '120px',frozen : true, sortable: true, attr: 'align=center', resizable: true},
						{ field: 'item_nm', caption: '품명', size : '120px',frozen : true, sortable: true, attr: 'align=center', resizable: true},
						{ field: 'product_req_date', caption:'작업지시일자',frozen : true, size : '120px', style:'text-align:center', sortable: true}
						
				);
		

		for (var i = 1; i <= grid_size; i++) {

			colObj.push({
						field : 'r' + i,
						caption : nameArr[Number(i-1)*2],
						size : '110px',
						attr : 'align=center',
						frozen : false
						,render: function (record, index, col_index) {
			       	        var html = this.getCellValue(index, col_index);

			                  return html + '시간';
			              }	
						
					});
			
			if(i != grid_size)
			{
				colObj.push({
					field : 'w' + i,
					caption : 'WAITING',
					size : '110px',
					attr : 'align=center',
					frozen : false
					,render: function (record, index, col_index) {
		       	        var html = this.getCellValue(index, col_index);

		                  return html + '시간';
		              }	
				});
			}
			
			
			/* var chartData = [
			                 {"r1":0.0,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.12,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.5,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.125,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.14,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.4,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.125,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.12,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.4,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.0,"w1":0.4,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.4,"w4":0.0,"colName":6.76},
			                 {"r1":0.0,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
			                 {"r1":0.0,"w1":0.1,"r2":0.12,"w2":0.5,"r3":0.1,"w3":0.0,"r4":0.25,"w4":0.0,"colName":6.76},
							 
				   ]; */
		}

		return colObj;
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
	var nameArr;
	var gridDataArr;
	
	var grapArr = new Array();
	
	
	//-------------------------------------------------------------------------------------------------------------------
	function loadList(){
		textArr = new Array();
		console.log("loadList()");
		
		try{
		w2ui['grid_list'].refresh();
		w2ui['grid_list'].unlock();
		}catch(e){
			
		}
		
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
		var product_req_date = $("#product_req_date").val();
		product_req_date = product_req_date.replace(/-/gi, "");
		
		var item_code = $('#item_code').val();
		var item_nm = $('#item_nm').val();
		
		
		var page_url = '';
		var postData = '';

		page_url = "/frontend/consumable/selectProductAnalysis";
		postData = {
				
				item_code : item_code,
				product_req_date : product_req_date,
				item_nm : item_nm
		};

		//w2ui['grid_list'].lock('loading...', true);
		var resultData ;
		
		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			data: postData,
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					console.log("rowArr::::::"+rowArr[0].w9)
					console.log("rowArr::::::"+rowArr[0].w10)
					 grapArr = new Array();
					
					var max_size = 0 ;
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						
						var before_menu_name = row.menu_name;
						var after_menu_name = before_menu_name.split("@");
						var menu_count = after_menu_name[0];
						
						
						var menu_size = Number(menu_count);
						if(max_size < menu_size)
						{
							max_size = menu_size;
						}
						
						console.log('max_size : ' + max_size);
						
						var col_name = after_menu_name[1];
						var nArr = col_name.split(",");
												
						for(var i = 1; i< menu_size; i++)
						{
							var value = 'r' + i;
							var value2 = 'w' + i;
							
			
							nArr[i] = row[value]; 
							nArr[i] = row[value2]; 
						
							console.log("value2:::"+value2)
							console.log("row[value2]row[value2]:::"+row[value2])
	
						}
						
					});
					
					var before_col_name = rowArr[0].menu_name;
					var after_col_name = before_col_name.split("@");
					var pro_size = after_col_name[0];
					var col_name = after_col_name[1];
					
				
					nameArr = col_name.split(",");
					var col_count ;
					
			
					// 파괴 성공 기원
					w2ui['grid_list'].destroy();
					
					init_grid_list(initGridList_columns2(max_size));
					
					w2ui['grid_list'].records = rowArr;
					grapArr2 = new Array();
					grapArr = new Array();
					textArr = nameArr;
					var process = -1;
					for(var i = 0; i < Number(pro_size); i++)
					{					
							var grapObj = new Object();
							
							$.each(rowArr, function(idx, row){
									process = (Number(i)*2);
						        	var value = 'r' + (i+1);
							    	grapObj = new Object();
							    	grapObj.country = '';
									grapObj.process = process;				
									grapObj.val = value;
									grapObj.text = nameArr[process];
									grapObj.value = row[value];
								
									grapArr.push(grapObj);
									
									
									if(Number(i) != Number(pro_size)) 
									{
										var value2 = 'w' + (i+1);
										 
										grapObj = new Object();
											
										grapObj.country = '';
										grapObj.process = process+1;
										grapObj.val = value2;
										grapObj.text = nameArr[process+1];
										grapObj.value = row[value2];
										
										grapArr.push(grapObj);
										
									}
									
									
									grapArr2.push(grapArr);  
							}
							
							);		
							
						}  
					
					console.log(grapArr);
					console.log(grapArr2);
					console.log("grapArr길이::::"+grapArr.length);
					console.log("grapArr2길이::::"+grapArr2.length);
				
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
				
			}
		});
	
		
	}
	
	
	var infoArr = new Array();

	//-------------------------------------------------------------------------------------------------------------------
	
var maxData1 = '0';

function axisLabelFunc(id, value){
	var result = '';
	
	
	
	try{
		if(Number(value) == Number(nameArr.length) - 1 )
		{
			 return '';
		}
		result = nameArr[Number(value)];
	}catch(e)
		{
			 return '';
		}
	console.log("id:::::"+id)
	console.log("value:::::"+value)
	console.log("result:::::"+result)
	
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
                       	+'<LinearAxis id="hAxis" title="공정" labelJsFunction="axisLabelFunc" />'                       	
                       //+'<CategoryAxis id="hAxis" categoryField="process"  displayName="공정" labelJsFunction="axisLabelFunc"/>' 
                   +'</horizontalAxis>'
                   
                  
                  
                 +'<backgroundElements>'
                      +'<GridLines direction="both"/>'
                 +'</backgroundElements>'
                 +'<series>'
                      +'<Plot2DSeries xField="process" yField="value"  radius="6.5">'
                         +'<fill>'
                            +'<SolidColor color="#f9ad02"/>'
                         +'</fill>'
                       /* Plot2DChart 정의 후 Plot2DSeries labelPosition="inside"정의합니다 */
                      //  +'<showDataEffect>'
                          /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
                             //  +'<SeriesZoom relativeTo="series"/>'
                             
                       //  +'</showDataEffect>'
                     +'</Plot2DSeries>'
                   +'</series>'
                   
//                    +'<horizontalAxis>'
//                    /*      +'<LinearAxis id="hAxis" title="공정" />'  */
//                        //labelJsFunction="axisLabelFunc"
//                        +'<CategoryLinearAxis id="hAxis2" categoryField="val"/>'                  	
//                        //+'<CategoryAxis categoryField="process" formatter="{numFmt2}" displayName="공정" labelJsFunction="axisLabelFunc"/>' 
//                    +'</horizontalAxis>'
                   
                 +'<annotationElements>'
                      +'<CrossRangeZoomer zoomType="both"/>'
                   +'</annotationElements>'

                   
//                +'<horizontalAxisRenderers>'
//                    +'<ScrollableAxisRenderer axis="{hAxis}" visibleItemSize="10"  canDropLabels="true"/>'      
//                +'</horizontalAxisRenderers>'
                   
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

var menu_count ;

function requestItem(){

	var page_url = "/frontend/consumable/selectProductAnalysis";

	
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
					
					/* var before_menu_name = row.menu_name;
					var after_menu_name = before_menu_name.split("@");
					menu_name = after_menu_name[0];
					
					console.log("menu_name의 갯수는?" + menu_name); */
					
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
		
		//init_grid_list(initGridList_columns());
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
			w2ui['grid_list'].clear();
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
			w2ui['grid_list'].clear();
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