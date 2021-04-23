<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = "SET"; //SessionUtil.getProperties("mes.company");
String memberNm= SessionUtil.getMemberNm(request);
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
    		
		[id*=grid_grid_chk_data_][col="4"]
		{
			background-color:#ffff0030;
		}    		
    	
    	[id*=grid_grid_chk_data_][col="11"]
		{
			background-color:#ffff0030;
		}    			   		    	
		
		[id*=grid_grid_inpt_data_][col="4"]
		{
			background-color:#ffff0030;
		}    			   		
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
		<jsp:param name="selected_menu_cd" value="1065" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      	최종검사
        <small>품질관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>품질관리</a></li><li class="active">최종검사</li>
      </ol>
    </section>

  	<section class="content">
			<div class="row" style="position: absolute; height:600px; margin:0;">
				<section class="col-md-12">
					<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
						<!-- Progress Bar -->
						<div class="box-header with-border" style=" background-color: #DB8EB5;">
							<h3 class="box-title">공정 검사 대상</h3>
							<div class="box-tools pull-right">
								<button type="button" id="" onclick="openCheckSheet();" class="btn btn-warning btn-sm">체크시트 조회</button>
								<button type="button" id="" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>
							</div>
						</div>
						
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>작업지시번호</label> <input type="text" id="m_product_po" name="m_product_po" placeholder="ex) 작업지시번호"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>P/N</label> <input type="text" id="m_item_code" name="m_item_code" placeholder="ex) P/N"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>	
							<div class="col-sm-4">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>품명</label> <input type="text" id="m_item_nm" name="m_item_nm" placeholder="ex) 품명"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>	
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">	
<!-- 							<div class="col-sm-4"> -->
<!-- 								<div class="form-group" style="margin-bottom: 0px;"> -->
<!-- 									<label>LOTNo.</label> <input type="text" id="customer_nm" name="customer_nm" placeholder="ex) LOT 작업지시번호" -->
<!-- 									 class="form-control input-sm" maxlength="50" /> -->
<!-- 								</div> -->
<!-- 							</div>	 -->
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
<!-- 							<div class="col-sm-4"> -->
<!-- 								<div class="form-group" style="margin-bottom: 0px;"> -->
<!-- 									<label>검사진행 현황</label> <input type="text" id="" name="customer_nm" placeholder="ex) 검사진행 현황" -->
<!-- 									 class="form-control input-sm" maxlength="50" /> -->
<!-- 								</div> -->
<!-- 							</div>			 -->
						</div>
						<div id="grid_list" style="height: 470px; margin: 15px"></div>
					</div>
				</div>	
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>


<div class="modal fade" id="modal_chk_sheet" aria-hidden="true" style="display: none;" data-backdrop="static">
	<div class="modal-dialog" style="width:80%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="modal_title">측정값 관리</h4>
			</div>
			<div class="modal-body" id="">
				<div class="row">
					<div class="col-sm-4">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>작업지시번호 : </label>
							<label id="p_product_po">-</label>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>P/N : </label>
							<label id="p_item_code">-</label>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>품명 : </label>
							<label id="p_item_nm">-</label>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>생산요청일자 : </label>
							<label id="p_product_req_date">-</label>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>공정코드 : </label>
							<label id="p_routing_code">-</label>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>공정명 : </label>
							<label id="p_routing_nm">-</label>
						</div>
					</div>
				</div>		
			
				<div class="row">
					<div class="col-sm-12">
						<div id="grid_chk" style="height: 550px;"></div>
					</div>
					<div id="inpt_area" style="height: 550px;">
						<div class="col-sm-4">
							<div class="form-group" style="margin-bottom: 0px;">
								<label>샘플타입 : </label>
								<label id="p_sample_type">-</label>
							</div>
						</div>
						<div class="col-sm-4 hide">
							<div class="form-group" style="margin-bottom: 0px;">
								<label>grid_chk 선택 recid : </label>
								<label id="p_slot">-</label>
							</div>
						</div>
						<div class="col-md-4">	
							<div class="form-group" style="margin-bottom: 0px;">
	                  			<label for="rdo_insp_case" class="control-label" style="padding-top: 0px;">검사유형 : </label>
	                  			<label>
			                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1541"> 전수
			                	</label>
			                	<label>
			                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1542" > 2
			                	</label>
			                	<label>
			                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1548" > 3
			                	</label>
			                	<label>
			                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1549" > 5
			                	</label>
			                	<label>
			                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1550" > 홀수
			                	</label>
			                	<label>
			                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1551" > 짝수
			                	</label>
			                </div>
	                	</div>
	                	<div class="col-sm-12">
							<div id="grid_inpt" style="height: 550px;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="box-tools pull-left">
					<button type="button" id="btn_back" onclick="backChkSht();" class="btn btn-warning btn-sm inpt_cate">back</button>
					<button type="button" id="btn_close" class="btn btn-default btn-sm sht_cate" data-dismiss="modal">닫기</button>
				</div>
				<div class="text-center">
					<button type="button" id="btn_img_view" onclick="openImgView();" class="btn btn-success btn-sm sht_cate">도면파일보기</button>
					<button type="button" id="btn_sht_save" onclick="saveChkSht();" class="btn btn-success btn-sm sht_cate">체크시트 저장</button>
					<button type="button" id="btn_insp_save" onclick="saveInspVal();" class="btn btn-success btn-sm inpt_cate">측정값 저장</button>
					<button type="button" id="" onclick="fnshChkShtData();" class="btn btn-success btn-sm sht_cate">검사종료</button>
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
comboValue_nm3 = new Array;
var memberNm = '<%=memberNm%>';

$(function($) {

 	fnLoadCommonOption();
 	init_grid_list();
 	init_grid_chk();
 	init_grid_inpt();
 	loadList();

 	$(':radio[name="rdo_insp_case"]').on('ifChecked', function(event){
 	
 		w2ui['grid_inpt'].destroy();
 		init_grid_inpt();
 		loadInpt('c');
 	}); 
 	
 	$(".cond_1").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	
 	$('.cond_2').on("change",function(event){ 
		loadList();
 	}); 
 	
})

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
				console.log('m_item_code key_up : '+ value);
				
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
		$.each(rowArr, function(idx, row){
			
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
		
		$.each(rowArr, function(idx, row){
			
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

	loadList();
	
}

function fnLoadCommonOption() {
 	
 		$('input[type="radio"].flat-red').iCheck({
 			checkboxClass: 'icheckbox_flat-green',
 			radioClass: 'iradio_flat-green',
 			handle: 'radio'
 		});
 		
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
}
 


function init_grid_list(){
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
            footer: true
        },
        columns: [                
			{ field:'product_po', caption:'작업지시 번호', size:'20%', style:'text-align:center'},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center'},
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center'},
			{ field:'', caption:'LOTNo.', size:'10%', style:'text-align:center', hidden:true},
			{ field:'product_menge', caption:'수량', size:'10%', style:'text-align:center'},
			{ field:'product_req_date', caption:'생산 요청 일자', size:'20%', style:'text-align:center'},
			{ field:'', caption:'검사 방법', size:'10%', style:'text-align:center', hidden:true},
			{ field:'routing_code', caption:'공정코드', size:'10%', style:'text-align:center'},
			{ field:'routing_nm', caption:'공정명', size:'10%', style:'text-align:center'},
			{ field:'flag', caption:'진행상태', size:'10%', style:'text-align:center'}
		],
		onReload: function(event) {
		},
		onClick: function (event) {
		}
	});

}

function init_grid_chk(){
	
	$('#grid_chk').w2grid({ 
        name: 'grid_chk',
        show: {
        	selectColumn: true,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'inspection_seq', caption:'NO', size:'5%', style:'text-align:center'},
			{ field:'routing_nm', caption:'공정명', size:'10%', style:'text-align:center'},
			{ field:'inspection_time', caption:'작업시간(LOT)', size:'10%', style:'text-align:center', hidden:true},
			{ field:'product_menge', caption:'투입수량', size:'10%', style:'text-align:center'},
			{ field:'worker', caption:'작업자', size:'10%', style:'text-align:center', editable : { type: 'text'}},
			{ field:'inspection_item', caption:'검사항목', size:'10%', style:'text-align:center'},
			{ field:'spec', caption:'SPEC(mm)', size:'10%', style:'text-align:center'},
			{ field:'insp_cnt_a', caption:'초물', size:'10%', style:'text-align:center', hidden:true,
				render : function(record, index, col_index){
					if(record.insp_cnt_a == 0){
						return '<div style="background-color: #eeeeee;color: red;border: double;">검사 진행전</div>';	
					} else if(record.insp_cnt_a > 0){
						return '<div style="background-color: #eeeeee;color: green;border: double;">검사완료</div>';
					} else {
						var html = this.getCellValue(index, col_index);
	                    return html || '';	
					}
				}				
			},
			{ field:'insp_cnt_b', caption:'중물', size:'10%', style:'text-align:center', hidden:true,
				render : function(record, index, col_index){
					if(record.insp_cnt_b == 0){
						return '<div style="background-color: #eeeeee;color: red;border: double;">검사 진행전</div>';	
					} else if(record.insp_cnt_b > 0){
						return '<div style="background-color: #eeeeee;color: green;border: double;">검사완료</div>';
					} else {
						var html = this.getCellValue(index, col_index);
	                    return html || '';	
					}
				}
			},
			{ field:'insp_cnt_c', caption:'검사', size:'10%', style:'text-align:center',
				render : function(record, index, col_index){
					if(record.insp_cnt_c == 0){
						return '<div style="background-color: #eeeeee;color: red;border: double;">검사 진행전</div>';	
					} else if(record.insp_cnt_c > 0){
						return '<div style="background-color: #eeeeee;color: green;border: double;">검사완료</div>';
					} else {
						var html = this.getCellValue(index, col_index);
	                    return html || '';	
					}
				}
			},
			{ field:'dfct_cnt', caption:'NG수량', size:'10%', style:'text-align:center'},
			{ field:'comment', caption:'불량내용', size:'10%', style:'text-align:center', editable : { type: 'text'}},
			{ field:'end_time', caption:'검사종료시간', size:'15%', style:'text-align:center'},
			
			{ field:'insp_case_a', caption:'초물 insp_case', size:'10%', style:'text-align:center', hidden:true},
			{ field:'insp_case_b', caption:'중물 insp_case', size:'10%', style:'text-align:center', hidden:true},
			{ field:'insp_case_c', caption:'종물 insp_case', size:'10%', style:'text-align:center', hidden:true},

			{ field:'product_po', caption:'product_po', size:'10%', style:'text-align:center', hidden:true},
			{ field:'item_code', caption:'item_code', size:'10%', style:'text-align:center', hidden:true},
			{ field:'routing_code', caption:'routing_code', size:'10%', style:'text-align:center', hidden:true},
			
			{ field:'min_spec', caption:'min_spec', size:'10%', style:'text-align:center', hidden:true},
			{ field:'max_spec', caption:'max_spec', size:'10%', style:'text-align:center', hidden:true},
			{ field:'inspection_gubun', caption:'inspection_gubun', size:'10%', style:'text-align:center', hidden:true},
			{ field:'warehouse_gubun', caption:'warehouse_gubun', size:'10%', style:'text-align:center', hidden:true}
		],
		onReload: function(event) {
		},
		onSelect: function (event) {
			
			var getData = w2ui.grid_chk.get(event.recid);
			/*
			if(event.column == 7)
			{	
				$('#p_sample_type').html("초물");
				$('#p_slot').html(getData.inspection_seq);
				$('#grid_chk').hide();
				$("#inpt_area").show();
				$(".inpt_cate").show();
				$(".sht_cate").hide();
				$('input:radio[name=rdo_insp_case]').iCheck('uncheck');
				
				if(getData.insp_case_a == null)
					$('input:radio[name=rdo_insp_case]:input[value="MD1541"]').iCheck('check');
				else
					$('input:radio[name=rdo_insp_case]:input[value="'+getData.insp_case_a+'"]').iCheck('check');
			}
			if(event.column == 8)
			{	
				$('#p_sample_type').html("중물");
				$('#p_slot').html(getData.inspection_seq);
				$('#grid_chk').hide();
				$("#inpt_area").show();
				$(".inpt_cate").show();
				$(".sht_cate").hide();
				$('input:radio[name=rdo_insp_case]').iCheck('uncheck');
				if(getData.insp_case_b == null)
					$('input:radio[name=rdo_insp_case]:input[value="MD1541"]').iCheck('check');
				else
					$('input:radio[name=rdo_insp_case]:input[value="'+getData.insp_case_b+'"]').iCheck('check');
			}
			*/
			if(event.column == 9)
			{	
				$('#p_sample_type').html("최종");
				$('#p_slot').html(getData.recid);
				$('#grid_chk').hide();
				$("#inpt_area").show();
				$(".inpt_cate").show();
				$(".sht_cate").hide();
				$('input:radio[name=rdo_insp_case]').iCheck('uncheck');
				if(getData.insp_case_c == null)
					$('input:radio[name=rdo_insp_case]:input[value="MD1541"]').iCheck('check');
				else
					$('input:radio[name=rdo_insp_case]:input[value="'+getData.insp_case_c+'"]').iCheck('check');
			}
		}
	});

}


function init_grid_inpt(){
	
	$('#grid_inpt').w2grid({ 
        name: 'grid_inpt',
        show: {
            footer: true
        },
        columns: [                
			{ field:'val_seq', caption:'NO', size:'5%', style:'text-align:center'},
			{ field:'spec', caption:'spec', size:'5%', style:'text-align:center'},
			{ field:'min_spec', caption:'min_spec', size:'5%', style:'text-align:center'},
			{ field:'max_spec', caption:'max_spec', size:'5%', style:'text-align:center'},
			
			{ field:'insp_val', caption:'측정값', size:'10%', style:'text-align:center',
				render : function(record, index, col_index){
					
					var html = this.getCellValue(index, col_index);
					
					if(record.inspection_gubun != 'MD1543')
					{
						if(record.insp_val == 'OK' || record.insp_val == '유'){
							return '<span style="background-color:green;color: white;padding: 40px;">'+record.insp_val+'</span>';	
						} else if(record.insp_val == 'NG'  || record.insp_val == '무'){
							return '<span style="background-color:red;color: white;padding: 40px;">'+record.insp_val+'</span>';
						} else {
		                    return html || '';	
						}	
					} else {
						return html || '';
					}
				}
			},
			{ field:'insp_rst', caption:'측정결과', size:'5%', style:'text-align:center',
				render : function(record, index, col_index){
					
					if(record.insp_rst == 'OK'){
						return '<span style="color: green;font-weight: bold;">OK</span>';	
					} else if(record.insp_rst == 'NG'){
						return '<span style="color: red;font-weight: bold;">NG</span>';
					} else {
						if((record.a_insp_ng_cnt > 0 || record.b_insp_ng_cnt > 0 || record.c_insp_ng_cnt > 0) && record.edit_mode == 'NG')
						{
							return '<span style="color: red;font-weight: bold;">NG</span>';	
						}
					}
				}
			},
			{ field:'product_po', caption:'product_po', hidden:true},
			{ field:'item_code', caption:'item_code', hidden:true},
			{ field:'routing_code', caption:'routing_code', hidden:true},
			{ field:'inspection_seq', caption:'inspection_seq', hidden:true},
			
			{ field:'sample_type', caption:'sample_type', size:'5%', style:'text-align:center', hidden:true},
			{ field:'insp_case', caption:'insp_case', size:'5%', style:'text-align:center', hidden:true},
			{ field:'inspection_gubun', caption:'inspection_gubun', size:'5%', style:'text-align:center', hidden:true},
			
			{ field:'a_insp_ng_cnt', caption:'초물 ng 여부', size:'5%', style:'text-align:center', hidden:true},
			{ field:'b_insp_ng_cnt', caption:'중물 ng 여부', size:'5%', style:'text-align:center', hidden:true},
			{ field:'c_insp_ng_cnt', caption:'종물 ng 여부', size:'5%', style:'text-align:center', hidden:true},
			
			{ field:'a_ing_status', caption:'초물 진행 여부', size:'5%', style:'text-align:center', hidden:true},
			{ field:'b_ing_status', caption:'중물 진행 여부', size:'5%', style:'text-align:center', hidden:true},
			{ field:'c_ing_status', caption:'종물 진행 여부', size:'5%', style:'text-align:center', hidden:true},
			
			{ field:'edit_mode', caption:'수정가능여부(slot 불량 처리 구분)', size:'5%', style:'text-align:center', hidden:true}
			
		],
		onReload: function(event) {
		},
		onChange: function (event) {
			event.onComplete = function () {
				var rowData = getEditRecords('grid_inpt');					
				var insp_val = Number(rowData[event.recid-1].insp_val);
				var min_spec = Number(rowData[event.recid-1].min_spec);
				var max_spec = Number(rowData[event.recid-1].max_spec);
				
				var getData = w2ui.grid_inpt.get(event.recid);
				
				if(insp_val >= min_spec && insp_val <= max_spec){
					w2ui['grid_inpt'].set(event.recid, { insp_rst: 'OK' });					
				} else if(insp_val == "")
					w2ui['grid_inpt'].set(event.recid, { insp_rst: '' });
				else {
					w2ui['grid_inpt'].set(event.recid, { insp_rst: 'NG' });
				}  
				
				w2ui.grid_inpt.save();
			}
		},
		onEditField: function (event) {
			var getData = w2ui.grid_inpt.get(event.recid);
			if(event.column == 4  )
			{
				if(getData.edit_mode == 'NG')
				{
					w2ui.grid_inpt.editField(event.recid+1, event.column); 
					event.preventDefault();	
				}
			}
		},
		onDblClick: function (event) {
 			event.onComplete = function () {
	
 				var getData = w2ui.grid_inpt.get(event.recid);
 				if(event.column == 4)
 				{
 					delete w2ui.grid_inpt.columns[4].editable; 				
 					
 					if(getData.inspection_gubun == 'MD1543')
 	 				{
	 					if(getData.edit_mode == 'OK')
	 					{
	 						w2ui.grid_inpt.columns[4].editable = { type: 'text' };
	 					}
 	 				} else if(getData.inspection_gubun == 'MD1544'	|| getData.inspection_gubun == 'MD1545')
 	 				{
 	 					if(getData.edit_mode == 'OK')
	 					{
 	 						if(getData.insp_val == 'NG' || getData.insp_val == '')
 	 	 					{
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_val: 'OK' });
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_rst: 'OK' });
 	 	 					}
 	 	 					else if(getData.insp_val == 'OK')
 	 	 					{
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_val: 'NG' });
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_rst: 'NG' });
 	 	 					}
	 					}
 	 				} else if(getData.inspection_gubun == 'MD1577')
 	 				{
 	 					if(getData.edit_mode == 'OK')
	 					{
 	 						if(getData.insp_val == '무' || getData.insp_val == '')
 	 	 					{
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_val: '유' });
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_rst: 'OK' });
 	 	 					}
 	 	 					else if(getData.insp_val == '유')
 	 	 					{
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_val: '무' });
 	 	 						w2ui['grid_inpt'].set(event.recid, { insp_rst: 'NG' });
 	 	 					}
	 					}
 	 				}
 				}
 			}
		}
	});
}

function loadList()
{
	w2ui['grid_list'].clear();
	
	var page_url = "/frontend/insp/selcInspMain_final";
	var postData = "product_po=" + encodeURIComponent($("#m_product_po").val())
			+ "&item_code=" + encodeURIComponent($("#m_item_code").val())
			+ "&item_nm=" + encodeURIComponent($("#m_item_nm").val())
			+ "&flag=" + encodeURIComponent($("#m_flag").val())
			+ "&gubun=" + encodeURIComponent('Y')
			+ "&product_req_date=" + encodeURIComponent($("#m_product_req_date").val());

	w2ui['grid_list'].lock('loading...', true);
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
					
					if(row.item_code)comboValue_nm1.push(row.item_code);
					if(row.item_nm)comboValue_nm2.push(row.item_nm);
					if(row.product_po)comboValue_nm3.push(row.product_po);
				});
				w2ui['grid_list'].records = rowArr;
				
				if (startValue_combo == "") {
					$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
					$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
					$('#m_product_po').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
				}
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_list'].clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		},
		complete : function() {
			startValue_combo = ":)";
			
			document.getElementById("m_item_code").style.removeProperty("height");
			document.getElementById("m_item_nm").style.removeProperty("height");
			document.getElementById("m_product_po").style.removeProperty("height");
		}
	});
	
}

function loadChk(item_code, routing_code, product_po)
{
	w2ui['grid_chk'].clear();
	
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
					if(row.worker.length == 0)
						row.worker = memberNm;
				});
				w2ui['grid_chk'].records = rowArr;
			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_chk'].clear();
			}
			w2ui['grid_chk'].refresh();
			w2ui['grid_chk'].unlock();
		},
		complete : function() {
		}
	});
	
}

function loadInpt(sample_type)
{
	w2ui['grid_inpt'].clear();

	var selIdxArr = $('#p_slot').html();
	var product_po = w2ui.grid_chk.get(selIdxArr).product_po;
	var item_code = w2ui.grid_chk.get(selIdxArr).item_code;
	var routing_code = w2ui.grid_chk.get(selIdxArr).routing_code;
	var inspection_seq = w2ui.grid_chk.get(selIdxArr).inspection_seq;
	var product_menge = w2ui.grid_chk.get(selIdxArr).product_menge;
	var insp_case = $(':radio[name="rdo_insp_case"]:checked').val();
	
	var spec = w2ui.grid_chk.get(selIdxArr).spec;
	var min_spec = w2ui.grid_chk.get(selIdxArr).min_spec;
	var max_spec = w2ui.grid_chk.get(selIdxArr).max_spec;
	var inspection_gubun = w2ui.grid_chk.get(selIdxArr).inspection_gubun;
	
	var page_url = "/frontend/insp/selcInspVal";
	var postData = "product_po=" + encodeURIComponent(product_po)
			+ "&item_code=" + encodeURIComponent(item_code)
			+ "&routing_code=" + encodeURIComponent(routing_code)
			+ "&inspection_seq=" + encodeURIComponent(inspection_seq)
			+ "&insp_case=" + encodeURIComponent(insp_case)
			+ "&sample_type=" + encodeURIComponent(sample_type);

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
					
					row.a_insp_ng_cnt = row.insp_cnt_a;	
					row.b_insp_ng_cnt = row.insp_cnt_b;
					row.c_insp_ng_cnt = row.insp_cnt_c;
					if(row.insp_cnt_a > 0 || row.insp_cnt_b > 0 || row.insp_cnt_c > 0)
					{
						row.edit_mode = 'NG';
						
						if(row.insp_val.length > 0)
						{
							row.edit_mode = 'OK';
						}
					}
					else
						row.edit_mode = 'OK';
				});
				
				filterLoadInpt(rowArr);
				
			} else if (data.status == 200 && (data.rows).length == 0) {
			
				var page_url = "/frontend/insp/selcInspNgCnt";
				var postData = "product_po=" + encodeURIComponent(product_po);
				postData += "&item_code=" + encodeURIComponent(item_code);
				postData += "&routing_code=" + encodeURIComponent(routing_code);
				postData += "&inspection_seq=" + encodeURIComponent(inspection_seq);

				$.ajax({
					url : page_url,
					type : 'POST',
					data: postData,
					dataType : 'json',
					success: function(data, textStatus, jqXHR) {
						if (data.status == "200") {
							
							var rowData = data.rows;
							
							var mas = [];
							for(var i=0 ; i<product_menge; i++)
							{
								var obj1 = new Object();
								obj1.recid = i+1;
								obj1.val_seq = i+1;
								obj1.insp_val = "";
								obj1.insp_rst = "";
					
								obj1.product_po = product_po;
								obj1.item_code = item_code;
								obj1.routing_code = routing_code;
								obj1.inspection_seq = inspection_seq;
								
								obj1.sample_type = sample_type;
								obj1.insp_case = $(':radio[name="rdo_insp_case"]:checked').val();
								
								obj1.spec = spec;
								obj1.min_spec = min_spec;
								obj1.max_spec = max_spec;
								
								obj1.inspection_gubun = inspection_gubun;
								
								
								if(rowData.length > 0)
								{
									$.each(rowData,function(idx, row){
										if(row.val_seq == i+1)
										{
											obj1.a_insp_ng_cnt = row.insp_cnt_a;	
											obj1.b_insp_ng_cnt = row.insp_cnt_b;
											obj1.c_insp_ng_cnt = row.insp_cnt_c;
											
											if(row.insp_cnt_a > 0 || row.insp_cnt_b > 0 || row.insp_cnt_c > 0)
												obj1.edit_mode = 'NG';
											else
												obj1.edit_mode = 'OK';
											
											
											obj1.a_ing_status = row.a_ing_status;	
											obj1.b_ing_status = row.b_ing_status;
											obj1.c_ing_status = row.c_ing_status;
										}
									});	
								} else {
									obj1.a_insp_ng_cnt = 0;	
									obj1.b_insp_ng_cnt = 0;
									obj1.c_insp_ng_cnt = 0;
									
									obj1.a_ing_status = 0;	
									obj1.b_ing_status = 0;
									obj1.c_ing_status = 0;
									
									obj1.edit_mode = 'OK';
								}
								
								mas.push(obj1);
							}

							filterLoadInpt(mas);
							
						} else {
							fnMessageModalAlert("알림", "처리를 실패했습니다.");
							w2ui['grid_inpt'].clear();
							w2ui['grid_inpt'].refresh();
							w2ui['grid_inpt'].unlock();
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
						fnMessageModalAlert("알림", "처리를 실패했습니다.");
						w2ui['grid_inpt'].clear();
						w2ui['grid_inpt'].refresh();
						w2ui['grid_inpt'].unlock();
					},	
					complete: function () {
					}
				});   
				
			} else {
				fnMessageModalAlert('알림', '데이터를 불러오는데 실패했습니다.');
				w2ui['grid_inpt'].clear();
				w2ui['grid_inpt'].refresh();
				w2ui['grid_inpt'].unlock();
			}
			
		},
		complete : function() {
		}
	});
}

function filterLoadInpt(rowArr){
	var insp_case = $(':radio[name="rdo_insp_case"]:checked').val();
	var rstArr = [];
		
	if(insp_case == 'MD1541')
	{
		$.each(rowArr,function(idx, row){
			row.recid = idx + 1;
		});
		rstArr = rowArr;
	} else if(insp_case == 'MD1542')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(row.val_seq % 2 == 0)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			}
		});		
	} else if(insp_case == 'MD1548')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(row.val_seq % 3 == 0)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			}
		});
	} else if(insp_case == 'MD1549')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(row.val_seq % 5 == 0)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			}
		});
	} else if(insp_case == 'MD1550')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(row.val_seq % 2 != 0)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			}
		});			
	} else if(insp_case == 'MD1551')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(row.val_seq % 2 == 0)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			}
		});			
	}
			
	w2ui.grid_inpt.clear();
	
	
	
	
	var getData = rowArr[0];
	
	$.each(rstArr,function(idx, row){
		if(row.edit_mode == 'NG')
			row.w2ui = { "style": "text-decoration: line-through;-webkit-text-decoration-color: red; text-decoration-color: red;" };
	});		
	
	w2ui.grid_inpt.records = rstArr;
	w2ui.grid_inpt.refresh(); 
	w2ui['grid_inpt'].unlock();
	
}

function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
}	


function openCheckSheet()
{
	
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '선택된 항목이 없습니다.');		
		return;
	}
	if( w2ui.grid_list.get(selIdxArr[0]).flag == '품질검사항목없음' ) {
		fnMessageModalAlert('알림', '선택된 항목의 품질검사항목정보가 없습니다.');		
		return;
	}
	
	var item_code = w2ui.grid_list.get(selIdxArr[0]).item_code;
	var routing_code = w2ui.grid_list.get(selIdxArr[0]).routing_code;
	var product_po = w2ui.grid_list.get(selIdxArr[0]).product_po;
	
	var item_nm = w2ui.grid_list.get(selIdxArr[0]).item_nm;
	var product_req_date = w2ui.grid_list.get(selIdxArr[0]).product_req_date;
	var routing_nm = w2ui.grid_list.get(selIdxArr[0]).routing_nm;
	
	$("#p_product_po").html(product_po);
	$("#p_item_code").html(item_code);
	$("#p_item_nm").html(item_nm);
	$("#p_product_req_date").html(product_req_date);
	$("#p_routing_code").html(routing_code);
	$("#p_routing_nm").html(routing_nm);
	
	
	$("#grid_chk").show();
	$("#inpt_area").hide();
	$(".inpt_cate").hide();
	$(".sht_cate").show();
	
	
	setTimeout(function(){ 
		w2ui['grid_chk'].resize(); 
		w2ui['grid_chk'].refresh(); 
	}, 200); 
	


	loadChk(item_code, routing_code, product_po);
	
	$("#modal_chk_sheet").modal('show'); 
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

function initOptions(obj) {
    $(obj)
    .find('option')
    .remove()
    .end()
    .val();
}

function backChkSht()
{
	$("#grid_chk").show();
	$("#inpt_area").hide();
	$(".inpt_cate").hide();
	$(".sht_cate").show();
	
	
	var product_po = $("#p_product_po").html();
	var item_code = $("#p_item_code").html();
	var routing_code = $("#p_routing_code").html();
	
	
	
	
	loadChk(item_code, routing_code, product_po);
}

function saveInspVal()
{

// 	var getData = w2ui.grid_inpt.records[0];

	
// 	if(getData.sample_type == 'a' )
// 	{
// 		if(getData.b_ing_status > 0) {
// 			fnMessageModalAlert("알림", "중물 검사가 이미 진행되었습니다.");
// 				return;							
// 		}
// 	}
// 	else if(getData.sample_type == 'b' )
// 	{
// 		if(getData.a_ing_status == 0) {
// 			fnMessageModalAlert("알림", "초물 검사가  진행되지 않았습니다.");
// 				return;
// 		}
		
// 		if(getData.c_ing_status > 0) {
// 			fnMessageModalAlert("알림", "종물 검사가 이미 진행되었습니다.");
// 				return;
// 		}
// 	}
// 	else if(getData.sample_type == 'c' )
// 	{
// 		if(getData.b_ing_status == 0) {
// 			fnMessageModalAlert("알림", "중물 검사가  진행되지 않았습니다.");
// 				return;
// 		}
// 	}
	//////////////////////

	var total_cnt = w2ui.grid_inpt.records.length;
	var ng_cnt = 0;
	var ok_cnt = 0;
	$.each(w2ui.grid_inpt.records, function(idx, row) {
		if(row.insp_rst == 'NG')
		{
			ng_cnt++;
		}
		else if((row.a_insp_ng_cnt > 0 || row.b_insp_ng_cnt > 0 || row.c_insp_ng_cnt > 0) && row.edit_mode == 'NG')
		{
			ng_cnt++;
		}
	});	
	var ok_cnt = Number(total_cnt) - Number(ng_cnt);
	
	
	fnMessageModalConfirm("알림", "□ 총 검사항목 수 : "+total_cnt+"<br/><font style='color:blue'>□ OK 항목 수 : "+ok_cnt+"</font><br/><font style='color:red'>□ NG 항목 수 : "+ng_cnt+"</font><br/><br/>진행하시겠습니까?", function(chk){
		if(!chk)
		{
			return;
		}
	
	
	
		var rowData = getEditRecords("grid_inpt")
		
		var selIdxArr = w2ui.grid_chk.getSelection();
		var product_menge = w2ui.grid_chk.get(selIdxArr[0]).product_menge;
		
		var sample_type = rowData[0].sample_type;
		var insp_case = $(':radio[name="rdo_insp_case"]:checked').val();
		
		var page_url = "/frontend/insp/saveInspVal";
		var postData = "param=" + encodeURIComponent(JSON.stringify(rowData));
		postData += "&sample_type=" + encodeURIComponent(sample_type);
		postData += "&insp_case=" + encodeURIComponent($(':radio[name="rdo_insp_case"]:checked').val());
		postData += "&product_menge=" + encodeURIComponent(product_menge);
		postData += "&start_flag=" + encodeURIComponent("Y");
		FunLoadingBarStart();
		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData,
			dataType : 'json',
			success: function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					fnMessageModalAlert("알림", "저장을 완료했습니다.");
					backChkSht();
				} else {
					fnMessageModalAlert("알림", "저장을 실패했습니다.");
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("알림", "저장을 실패했습니다.");
			},	
			complete: function () {
				FunLoadingBarEnd();
			}
		});   
	});
}

function saveChkSht()
{
	var rowData = getEditRecords('grid_chk');

	var page_url = "/frontend/insp/saveChkSht";
	var postData = "param=" + encodeURIComponent(JSON.stringify(rowData));
	FunLoadingBarStart();

	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData,
		dataType : 'json',
		success: function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				fnMessageModalAlert("알림", "저장을 완료했습니다.");
				
				var product_po = $("#p_product_po").html();
				var item_code = $("#p_item_code").html();
				var routing_code = $("#p_routing_code").html();
				
				loadChk(item_code, routing_code, product_po);
			} else {
				fnMessageModalAlert("알림", "저장을 실패했습니다.");
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("알림", "저장을 실패했습니다.");
		},	
		complete: function () {
			FunLoadingBarEnd();
		}
	});   
	
}

function fnshChkShtData()
{

	var selIdxArr = w2ui.grid_chk.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		fnMessageModalAlert('알림', '선택된 항목이 없습니다.');		
		return;
	}

	var worker = w2ui.grid_chk.get(selIdxArr[0]).worker;
	
	var insp_cnt_c = w2ui.grid_chk.get(selIdxArr[0]).insp_cnt_c;
	
	if(insp_cnt_c == 0 )
	{
		fnMessageModalAlert('알림', '검사가 완료되지 않은 항목이 있습니다.');		
		return;
	}
	
	if(worker.length == 0)
	{
		fnMessageModalAlert('알림', '작업자를 먼저 저장해주세요.');		
		return;
	}
	
	fnMessageModalConfirm("알림", "해당 검사를 종료처리하시겠습니까?", function(chk){
		if(!chk)
		{
			return;
		}
		
		//작업자명 저장 :: start
		var rowData = getEditRecords('grid_chk');

		var page_url = "/frontend/insp/saveChkSht";
		var postData = "param=" + encodeURIComponent(JSON.stringify(rowData));
		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData,
			dataType : 'json',
			success: function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					
				} else {
					fnMessageModalAlert("알림", "저장을 실패했습니다.");
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("알림", "저장을 실패했습니다.");
			},	
			complete: function () {
			}
		});   
		//작업자명 저장 :: end
		
		var product_po = w2ui.grid_chk.get(selIdxArr[0]).product_po;
		var item_code = w2ui.grid_chk.get(selIdxArr[0]).item_code;
		var routing_code = w2ui.grid_chk.get(selIdxArr[0]).routing_code;
		var inspection_seq = w2ui.grid_chk.get(selIdxArr[0]).inspection_seq;
		var warehouse_gubun = w2ui.grid_chk.get(selIdxArr[0]).warehouse_gubun;
		
		
		var page_url = "/frontend/insp/fnshChkShtData";
		var postData = "product_po=" + encodeURIComponent(product_po);
		postData += "&item_code=" + encodeURIComponent(item_code);
		postData += "&routing_code=" + encodeURIComponent(routing_code);
		postData += "&inspection_seq=" + encodeURIComponent(inspection_seq);
		postData += "&final_insp_flag=" + encodeURIComponent("Y");
		postData += "&warehouse_gubun=" + encodeURIComponent(warehouse_gubun);
		FunLoadingBarStart();
		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData,
			dataType : 'json',
			success: function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					if(data.endChk == 1){
						fnMessageModalAlert("알림", "해당 공정 검사가 완료되었습니다.");
						loadList();
						$("#modal_chk_sheet").modal('hide');
					}
					else if(data.flag > 0)
					{
						fnMessageModalAlert("알림", "진행된 검사 내역이 없습니다.");
					} else {
						fnMessageModalAlert("알림", "저장을 완료했습니다.");
						
						var product_po = $("#p_product_po").html();
						var item_code = $("#p_item_code").html();
						var routing_code = $("#p_routing_code").html();
						
						loadChk(item_code, routing_code, product_po);
						loadList();
					}		
				} else {
					fnMessageModalAlert("알림", "저장을 실패했습니다.");
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("알림", "저장을 실패했습니다.");
			},	
			complete: function () {
				FunLoadingBarEnd();
			}
		});   
	});
}

function getEditRecords(gridNm)
{
	var chgData = w2ui[gridNm].getChanges();
	var gridData = w2ui[gridNm].records;
	
	var dc_gridData = JSON.parse(JSON.stringify(gridData));
	var newData = [];
	var key = [];
	
	
	for(var j=0 ; j<dc_gridData.length; j++)
	{
		for(var i=0 ; i<chgData.length; i++)
		{
			if(chgData[i].recid == dc_gridData[j].recid)
			{
				var chgKey = Object.keys(chgData[i]);
				for(var k=0 ; k<chgKey.length; k++)
				{
					dc_gridData[j][chgKey[k]] = chgData[i][chgKey[k]];
				}
				delete dc_gridData[j].w2ui;
				
			}
		}
		newData.push(dc_gridData[j]);
	}
		
	return newData;
}

function openImgView()
{
	var url = "";
	var page_url = "/frontend/insp/getPnImg";
	var postData = "item_code=" + encodeURIComponent($("#p_item_code").html().trim());
		
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				url = window.location.href.substring(0, window.location.href.length - window.location.pathname.length) + '/doc/';
				var path = data.rows[0].file_path;
				url = url + path; 			
				
				var imgObj = new Image();
				imgObj.src = url;
				imageWin = window.open(url, "_blank");  // , "width=" + imgObj.width + "px, height=" + imgObj.height + "px"
// 				imageWin.document.write("<html><body style='margin:0'>"); 
// 				imageWin.document.write("<a href=javascript:window.close()><img src='" + imgObj.src + "' border=0></a>"); 
// 				imageWin.document.write("</body><html>"); 
				imageWin.document.title = imgObj.src;
				
			} else if (data.status == 200 && (data.rows).length == 0) {
				fnMessageModalAlert("알림", "해당 자재에 등록된 이미지 파일이 없습니다.");
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
</script>

</body>
</html>