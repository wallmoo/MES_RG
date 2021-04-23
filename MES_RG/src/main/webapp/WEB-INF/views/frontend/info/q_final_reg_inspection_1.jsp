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
		<jsp:param name="selected_menu_cd" value="1093" />
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
								<button type="button" id="" onclick="openInspModal();" class="btn btn-warning btn-sm">체크시트 조회</button>
								<button type="button" id="" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>
							</div>
						</div>
						
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>작업지시번호</label> <input type="text" id="m_product_po" name="m_product_po" placeholder="ex) 작업지시번호"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>P/N</label> <input type="text" id="m_item_code" name="m_item_code" placeholder="ex) P/N"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>	
							<div class="col-sm-3">
								<div class="form-group" style="margin-bottom: 0px;">
									<label>품명</label> <input type="text" id="m_item_nm" name="m_item_nm" placeholder="ex) 품명"
									 class="form-control input-sm cond_1" maxlength="50" />
								</div>
							</div>	
						</div>
						<div id="" class="box-body col-sm-12" style="padding:10px 0 10px 0;">
							<div class="col-sm-3">
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
							<div class="col-sm-3">
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
							<div class="col-sm-3">    
								<div class="form-group" style="margin-top:0px;">
									<label>검사구분</label>
									<div style="padding-top: 4px;">          
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
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>작업지시번호 : </label>
							<label id="p_product_po">-</label>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>P/N : </label>
							<label id="p_item_code">-</label>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>품명 : </label>
							<label id="p_item_nm">-</label>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>생산요청일자 : </label>
							<label id="p_product_req_date">-</label>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>공정코드 : </label>
							<label id="p_routing_code">-</label>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>공정명 : </label>
							<label id="p_routing_nm">-</label>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>수량 : </label>
							<label id="p_product_menge">-</label>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>진행상태 : </label>
							<label id="p_insp_status">-</label>
						</div>
					</div>
				</div>
				<div class="row" style="margin-bottom:10px">
					<div class="col-sm-3">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>작업자 : </label>
							<input type="text" id="p_worker" name="p_worker" class="form-control input-sm" maxlength="50" />
						</div>
					</div>
					<div class="col-sm-9">
						<div class="form-group" style="margin-bottom: 0px;">
							<label>비고 : </label>
							<input type="text" id="p_comment" name="p_comment" class="form-control input-sm" maxlength="200" />
						</div>
					</div>
				</div>
				
				<div class="row" style="margin-bottom:10px">
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
		                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1580" > 10
		                	</label>
		                	<label>
		                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1581" > 50
		                	</label>
		                	<label>
		                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1582" > 100
		                	</label>
		                	<label>
		                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1550" > 홀수
		                	</label>
		                	<label>
		                  		<input type="radio" name="rdo_insp_case" class="flat-red" value="MD1551" > 짝수
		                	</label>
		                </div>
	               	</div>
	            </div>
	                			
				<div class="row hide">
					<div class="col-sm-12">
						<div id="grid_info" style="height: 100px;"></div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div id="grid_val" style="height: 550px;"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="box-tools pull-left">
					<button type="button" id="btn_close" class="btn btn-default btn-sm" data-dismiss="modal" onclick="loadList();">닫기</button>
				</div>
				<div class="box-tools pull-right">
					<button type="button" id="" onclick="initInspInfo();" class="btn btn-success btn-sm">측정값 초기화</button>
				</div>
				<div class="text-center">
					<button type="button" id="btn_img_view" onclick="openImgView();" class="btn btn-success btn-sm">도면파일보기</button>
					<button type="button" id="" onclick="strtChkShtData();" class="btn btn-success btn-sm">검사시작</button>
					<button type="button" id="btn_insp_save" onclick="saveInspVal();" class="btn btn-success btn-sm">측정값 저장</button>
					<button type="button" id="" onclick="fnshChkShtData();" class="btn btn-success btn-sm">검사종료</button>
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
 	loadList();
 	
 	$(':radio[name="rdo_insp_case"]').on('ifChecked', function(event){ 		
 		loadVal();
 	}); 
 	
	$(".cond_1").pressEnter(function(e) {
		e.preventDefault();
		loadList();
	});
	
 	$('.cond_2').on("change",function(event){ 
		loadList();
 	});
 	
	$(":radio[name='rdo_ps_gubun']").on('ifChecked', function(event){
 		
		if($(":radio[name='rdo_ps_gubun']:checked").val() == 'P')
			$('#dt_nm').html('생산요청일자');
		else
			$('#dt_nm').html('검사확정일자');  
 		
		loadList();
 	});
})

	
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
			{ field:'product_po', caption:'작업지시 번호', size:'20%', style:'text-align:center',sortable :true},
			{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center',sortable :true},
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center',sortable :true},
			{ field:'', caption:'LOTNo.', size:'10%', style:'text-align:center', hidden:true},
			{ field:'product_menge', caption:'수량', size:'10%', style:'text-align:center',sortable :true},
			{ field:'product_req_date', caption:'생산 요청 일자', size:'20%', style:'text-align:center',sortable :true},
			{ field:'', caption:'검사 방법', size:'10%', style:'text-align:center', hidden:true},
			{ field:'routing_code', caption:'공정코드', size:'10%', style:'text-align:center',sortable :true},
			{ field:'routing_nm', caption:'공정명', size:'10%', style:'text-align:center',sortable :true},
			{ field:'flag', caption:'진행상태', size:'10%', style:'text-align:center',sortable :true},
			{ field:'insp_case', caption:'insp_case', size:'10%', style:'text-align:center', hidden:true},
			{ field:'warehouse_gubun', caption:'warehouse_gubun', size:'10%', style:'text-align:center', hidden:true}
		],
		onReload: function(event) {
		},
		onClick: function (event) {
		}
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
	
	var gridDataArr;

function loadList()
{
	w2ui['grid_list'].clear();
	
	var page_url = "/frontend/insp/selcInspMain_final";
	var postData = "product_po=" + encodeURIComponent($("#m_product_po").val())
			+ "&item_code=" + encodeURIComponent($("#m_item_code").val())
			+ "&item_nm=" + encodeURIComponent($("#m_item_nm").val())
			+ "&flag=" + encodeURIComponent($("#m_flag").val())
			+ "&gubun=" + encodeURIComponent('Y')
			+ "&search_type=" + encodeURIComponent($(":radio[name='rdo_ps_gubun']:checked").val())
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
					if (startValue_combo == "") {
						gridDataArr = rowArr;
						comboValue_nm1.push(row.item_code);
						comboValue_nm2.push(row.item_nm);
						comboValue_nm3.push(row.product_po);
					}
					row.product_menge = Number(row.product_menge);
				});
				w2ui['grid_list'].records = rowArr;
				
				

			} else if (data.status == 200 && (data.rows).length == 0) {
				w2ui['grid_list'].clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			$('#m_item_code').w2field('combo', { items: _.uniq(comboValue_nm1,false) ,match : 'contains' });
			$('#m_item_nm').w2field('combo', { items: _.uniq(comboValue_nm2,false) ,match : 'contains' });
			$('#m_product_po').w2field('combo', { items: _.uniq(comboValue_nm3,false) ,match : 'contains' });
		},
		complete : function() {
			
			startValue_combo = ":)";
			
			document.getElementById("m_item_code").style.removeProperty("height");
			document.getElementById("m_item_nm").style.removeProperty("height");
			document.getElementById("m_product_po").style.removeProperty("height");
			
		}
	});	
}

function filterLoadInpt(rowArr){
	var insp_case = $(':radio[name="rdo_insp_case"]:checked').val();
	var rstArr = [];
		
	console.log(insp_case);
	
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
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 2 == 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});		
	} else if(insp_case == 'MD1548')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 3 == 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});
	} else if(insp_case == 'MD1549')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 5 == 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});
	} else if(insp_case == 'MD1550')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 2 != 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});			
	} else if(insp_case == 'MD1551')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 2 == 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});			
	}else if(insp_case == 'MD1580')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 10 == 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});
	}else if(insp_case == 'MD1581')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 50 == 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});
	}else if(insp_case == 'MD1582')
	{
		var rstIdx = 1;
		
		$.each(rowArr,function(idx, row){
			if(idx >= 0 && idx <= 4)
			{
				row.recid = rstIdx++;
				rstArr.push(row);
			} else {
				if(row.insp_info % 100 == 0)
				{
					row.recid = rstIdx++;
					rstArr.push(row);
				}	
			}
		});
	}
			
	w2ui.grid_val.clear();

	
// 	$.each(rstArr,function(idx, row){
// 		if(row.edit_mode == 'NG')
// 			row.w2ui = { "style": "text-decoration: line-through;-webkit-text-decoration-color: red; text-decoration-color: red;" };
// 	});		

	w2ui.grid_val.records = rstArr;
	w2ui.grid_val.refresh(); 
	w2ui['grid_val'].unlock();
	
}

function getFormatDate(d) {
	var month = d.getMonth() + 1;
	var date = d.getDate();
	month = (month < 10) ? "0" + month : month;
	date = (date < 10) ? "0" + date : date;
	return d.getFullYear() + '-' + month + '-' + date;
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

function saveInspVal()
{	
	var total_cnt = w2ui.grid_val.records.length - 5;
	var ng_cnt = 0;
	var ok_cnt = 0;
	$.each(w2ui.grid_val.records, function(idx, row) {
		if(row.insp_rst == 'NG')
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
		
		
		var rowInfoData = getEditRecords("grid_info");
		var rowValData = getEditRecords("grid_val");
		var insp_case = $(':radio[name="rdo_insp_case"]:checked').val();


		var mat_arr = new Array();
		
		for(var i=0 ; i<(Number(w2ui.grid_info.columns.length)-1) ; i++)
		{
			var arr = new Array();
			
			for(var j=5 ; j<rowValData.length ; j++)
			{
				var obj = new Object();
				
				obj.product_po = $("#p_product_po").html();
				obj.item_code = $("#p_item_code").html();
				obj.routing_code = $("#p_routing_code").html();
				obj.inspection_seq = rowInfoData[1]["col_" + (i+1)];
				obj.val_seq = rowValData[j]["insp_info"];
				obj.insp_val = rowValData[j]["col_" + (i+1)]; 
				obj.a_insp_ng_cnt = "0";
				obj.b_insp_ng_cnt = "0";
				obj.c_insp_ng_cnt = rowValData[j]["col_"+(i+1)+"_c_insp_ng_cnt"];
				obj.insp_rst = rowValData[j]["col_"+(i+1)+"_rst"];
				
				arr.push(obj);
			}
			mat_arr.push(arr);
		}
		

		var page_url = "/insp/saveInspValue";
		var postData = "param=" + encodeURIComponent(JSON.stringify(mat_arr));
		postData += "&sample_type=" + encodeURIComponent('c');
		postData += "&insp_case=" + encodeURIComponent($(':radio[name="rdo_insp_case"]:checked').val());
		postData += "&product_menge=" + encodeURIComponent($("#p_product_menge").html());
		postData += "&worker=" + encodeURIComponent($("#p_worker").val());
		postData += "&comment=" + encodeURIComponent($("#p_comment").val());
		postData += "&product_po=" + encodeURIComponent($("#p_product_po").html());
		postData += "&routing_code=" + encodeURIComponent($("#p_routing_code").html());
		
		FunLoadingBarStart();
		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData,
			dataType : 'json',
			success: function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					if (data.cnt != 0) {
						fnMessageModalAlert("알림", "검사시작을 먼저 진행해주세요.");
						$('#modal_chk_sheet').css('overflow','auto');
					} else {
						fnMessageModalAlert("알림", "저장을 완료했습니다.");
						loadVal();	
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
				imageWin = window.open("", "profile_popup", "width=" + imgObj.width + "px, height=" + imgObj.height + "px"); 
				imageWin.document.write("<html><body style='margin:0'>"); 
				imageWin.document.write("<a href=javascript:window.close()><img src='" + imgObj.src + "' border=0></a>"); 
				imageWin.document.write("</body><html>"); 
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

function init_grid_val(col_cnt){
	
	var cols = new Array();
	
	cols.push({ field:'insp_info', caption:'insp_info', size:'10%', style:'text-align:center'});
	
	for(var i=0 ; i<col_cnt; i++)
	{
		cols.push({ field:'col_'+(i+1), caption:'col_'+(i+1), size:'10%', style:'text-align:center',
			render : function(record, index, col_index){
				var html = this.getCellValue(index, col_index);

				var inspection_gubun = w2ui.grid_info.get(1)["col_"+col_index];
				
				if(inspection_gubun != 'MD1543')
				{
					if(record["col_"+col_index] == 'OK' || record["col_"+col_index] == '유'){
						return '<span style="background-color:green;color: white;padding: 40px;">'+record["col_"+col_index]+'</span>';	
					} else if(record["col_"+col_index] == 'NG'  || record["col_"+col_index] == '무'){
						return '<span style="background-color:red;color: white;padding: 40px;">'+record["col_"+col_index]+'</span>';
					} else {
	                    return html || '';	
					}	
				} else {
					return html || '';
				}
			}
		});
	}
	cols.push({ field:'insp_rst', caption:'insp_rst', size:'10%', style:'text-align:center',
		render : function(record, index, col_index){
			
			if(record.insp_rst == 'OK'){
				return '<span style="color: green;font-weight: bold;">OK</span>';	
			} else if(record.insp_rst == 'NG'){
				return '<span style="color: red;font-weight: bold;">NG</span>';
			} else {
				var flag = 0;
				for(var j=0 ; j<col_cnt; j++)
				{
					if(record["col_"+(j+1)+"_c_insp_ng_cnt"] > 0 && record["edit_mode_" + (j+1)] == 'NG'){
						flag++;
					} 
				}
				if(flag > 0)
					return '<span style="color: red;font-weight: bold;">NG</span>';
				else 
					return this.getCellValue(index, col_index) || '';
			}
		}
	});
	
	for(var i=0 ; i<col_cnt; i++)
	{
		cols.push({ field:'col_'+(i+1)+'_rst', caption:'col_'+(i+1)+'_rst', size:'10%', style:'text-align:center', hidden:true});
	}
	for(var i=0 ; i<col_cnt; i++)
	{
		cols.push({ field:'col_'+(i+1)+'_c_insp_ng_cnt', caption:'col_'+(i+1)+'_c_insp_ng_cnt', size:'10%', style:'text-align:center', hidden:true});
	}
	for(var i=0 ; i<col_cnt; i++)
	{
		cols.push({ field:'edit_mode_'+(i+1), caption:'edit_mode_'+(i+1), size:'10%', style:'text-align:center', hidden:true});
	}
	
	
	$('#grid_val').w2grid({ 
        name: 'grid_val',
        show: {
        	header: false,
			columnHeaders: false,
            footer: false
        },
        multiSelect: false,
        columns: cols,
		onReload: function(event) {
		},
		onClick: function (event) {
		},
		onChange: function (event) {
			event.onComplete = function () {
				
				var caption = w2ui.grid_info.get(1)["col_"+event.column];
				
				if(caption == 'MD1543')
				{
					var rowData = getEditRecords('grid_val');
					
					var insp_val = Number(rowData[event.recid-1]["col_"+event.column]);
					var min_spec = Number(rowData[3]["col_"+event.column]);
					var max_spec = Number(rowData[4]["col_"+event.column]);
									
					if(insp_val >= min_spec && insp_val <= max_spec){
						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'_rst":"OK"}'));
						w2ui['grid_val'].set(event.recid, JSON.parse('{"insp_rst":"OK"}'));
						for(var i=0 ; i<col_cnt; i++)
			 			{
							w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"OK"}'));	
			 			}	
						
					} else if(insp_val == "") {
						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'_rst":""}'));
						w2ui['grid_val'].set(event.recid, JSON.parse('{"insp_rst":""}'));
						for(var i=0 ; i<col_cnt; i++)
			 			{
							w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"OK"}'));	
			 			}
					} else {
						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'_rst":"NG"}'));
						w2ui['grid_val'].set(event.recid, JSON.parse('{"insp_rst":"NG"}'));
						for(var i=0 ; i<col_cnt; i++)
			 			{
 							if(event.column == (i+1)){
 								w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"OK"}'));	
 							}else {
 								w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"NG"}'));
 							}
			 			}
						
					}  
					
					w2ui.grid_val.save();
				}
			}
		},
		onEditField: function (event) {
			var getData = w2ui.grid_val.get(event.recid);
			
			if(getData["edit_mode_" + event.column] == 'NG')
			{
				w2ui.grid_val.editField(event.recid+1, event.column); 
				event.preventDefault();	
			}
		},
		onDblClick: function (event) {
			
			if($("#p_insp_status").html() == '검사전')
			{
				fnMessageModalAlert('알림', '검사시작을 먼저 진행해주세요.');
				$('#modal_chk_sheet').css('overflow','auto');
				return;
			}
			
			var caption = w2ui.grid_info.get(1)["col_"+event.column];
			
			var getData = w2ui.grid_val.get(event.recid);
			
			delete w2ui.grid_val.columns[event.column].editable;
			
			if(caption == 'MD1543')
			{
				if(getData["edit_mode_" + event.column] == 'OK')
				{
					w2ui.grid_val.columns[event.column].editable = { type: 'text' };
				}
			}
			if(caption == 'MD1544'	|| caption == 'MD1545')
			{
				if(getData["edit_mode_" + event.column] == 'OK')
				{
					if(getData["col_"+event.column] == 'NG' || getData["col_"+event.column] == '')
 					{
						w2ui['grid_val'].set(event.recid, JSON.parse('{"insp_rst":"OK"}'));
						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'":"OK"}'));
						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'_rst":"OK"}'));
						
						for(var i=0 ; i<col_cnt; i++)
			 			{
							w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"OK"}'));	
			 			}	
 					}
 					else if(getData["col_"+event.column] == 'OK')
 					{
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"insp_rst":"NG"}'));
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'":"NG"}'));
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'_rst":"NG"}'));
 						
 						for(var i=0 ; i<col_cnt; i++)
			 			{
 							if(event.column == (i+1)){
 								w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"OK"}'));	
 							}else {
 								w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"NG"}'));
 							}
			 			}	
 					}
				} 
			}
			if(caption == 'MD1577')
			{
				if(getData["edit_mode_" + event.column] == 'OK')
				{
					if(getData["col_"+event.column] == '무' || getData["col_"+event.column] == '')
 					{
						w2ui['grid_val'].set(event.recid, JSON.parse('{"insp_rst":"OK"}'));
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'": "유"}'));
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'_rst":"OK"}'));
 						
 						for(var i=0 ; i<col_cnt; i++)
			 			{
							w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"OK"}'));	
			 			}	
 					}
 					else if(getData["col_"+event.column] == '유')
 					{
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"insp_rst":"NG"}'));
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'": "무"}'));
 						w2ui['grid_val'].set(event.recid, JSON.parse('{"col_'+event.column+'_rst":"NG"}'));
 						
 						for(var i=0 ; i<col_cnt; i++)
			 			{
 							if(event.column == (i+1)){
 								w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"OK"}'));	
 							}else {
 								w2ui['grid_val'].set(event.recid, JSON.parse('{"edit_mode_'+(i+1)+'":"NG"}'));
 							}
			 			}	
 					}
				}
			}
		}
	});

}

function init_grid_info(col_cnt){
	
	
	var cols = new Array();
	
	cols.push({ field:'insp_info', caption:'insp_info', size:'10%', style:'text-align:center'});

	for(var i=0 ; i<col_cnt; i++)
	{
		cols.push({ field:'col_'+(i+1), caption:'col_'+(i+1), size:'10%', style:'text-align:center'});
	}
	
	$('#grid_info').w2grid({ 
        name: 'grid_info',
        show: {
        },
        multiSelect: false,
        columns: cols,
		onReload: function(event) {
		},
		onClick: function (event) {
		}
	});
}
	
function openInspModal()
{
	$("#p_product_po").html('');
	$("#p_item_code").html('');
	$("#p_item_nm").html('');
	$("#p_product_req_date").html('');
	$("#p_routing_code").html('');
	$("#p_routing_nm").html('');
	$("#p_product_menge").html('');
	$("#p_worker").val('');
	$("#p_comment").val('');
	$("#p_insp_status").html('');
	
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
	var product_menge = w2ui.grid_list.get(selIdxArr[0]).product_menge;
	var insp_case = w2ui.grid_list.get(selIdxArr[0]).insp_case;
	
	$("#p_product_po").html(product_po);
	$("#p_item_code").html(item_code);
	$("#p_item_nm").html(item_nm);
	$("#p_product_req_date").html(product_req_date);
	$("#p_routing_code").html(routing_code);
	$("#p_routing_nm").html(routing_nm);
	$("#p_product_menge").html(product_menge);
	
	if(insp_case == null)
		$('input:radio[name=rdo_insp_case]:input[value="MD1541"]').iCheck('check');
	else
		$('input:radio[name=rdo_insp_case]:input[value="'+insp_case+'"]').iCheck('check');
	
	loadVal();
	
	$("#modal_chk_sheet").modal('show');
}

function loadVal()
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

	if(w2ui['grid_val'] != undefined)
	{
		w2ui['grid_val'].clear();
	}
	
	FunLoadingBarStart();
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData, 
		dataType : 'json',
		success : function(data) {
			if (data.status == 200 && (data.rows).length > 0) {
				rowArr = data.rows;
				
				$("#p_insp_status").html(rowArr[0].insp_status);
				
				if(rowArr[0].worker.length == 0)
					$("#p_worker").val(memberNm);
				else 
					$("#p_worker").val(rowArr[0].worker);
				
				$("#p_comment").val(rowArr[0].comment);
				
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
				
				
				var rowInfo = new Array();
				obj = new Object();
				obj.insp_info = "inspection_gubun";
				for(var j=0 ; j<inspInfo.length; j++)
				{
					obj["col_"+(j+1)] = inspInfo[j].inspection_gubun;
				}
				rowInfo.push(obj);
				
				obj = new Object();
				obj.insp_info = "inspection_seq";
				for(var j=0 ; j<inspInfo.length; j++)
				{
					obj["col_"+(j+1)] = inspInfo[j].inspection_seq;
				}
				rowInfo.push(obj);
				
				
				$.each(rowInfo, function(idx, row) {
					row.recid = idx + 1;		
				});
				
				if(w2ui['grid_info'] != undefined)
				{
					w2ui['grid_info'].destroy();
					w2ui['grid_val'].destroy();
				}
				
				init_grid_info(inspInfo.length);
				
				w2ui['grid_info'].records = rowInfo;
				
				w2ui['grid_info'].refresh();
				w2ui['grid_info'].unlock();
			 	
				init_grid_val(inspInfo.length);
			
				filterLoadInpt(t_arr);
				
			} else {
				if(w2ui['grid_info'] != undefined)
				{
					w2ui['grid_info'].destroy();
					w2ui['grid_val'].destroy();	
				}
			}
			
			setTimeout(function(){
				 w2ui['grid_info'].resize();
		         w2ui['grid_info'].refresh();
		         w2ui['grid_val'].resize();
		         w2ui['grid_val'].refresh();
			   }, 200);
			
			FunLoadingBarEnd();
		}
	});
}

function fnshChkShtData()
{
	if( w2ui.grid_val.records.length == 0 ) {
		fnMessageModalAlert('알림', '검사 대상 항목이 없습니다.');		
		return;
	}
	
	
	if($("#p_worker").val().length == 0)
	{
		fnMessageModalAlert('알림', '작업자를 먼저 저장해주세요.');		
		return;
	}
	
	var rowInfoData = getEditRecords("grid_info");
	var rowValData = getEditRecords("grid_val");
	
	var ipt_flag = 0;
	var ipt_cnt = 0;
	for(var i=0 ; i<(Number(w2ui.grid_info.columns.length)-1) ; i++)
	{
		for(var j=5 ; j<rowValData.length ; j++)
		{
			if(rowInfoData[0]["col_" + (i+1)] == 'MD1543')
			{
				if((rowValData[j]["col_" + (i+1)].length == 0 && rowValData[j]["insp_rst"] == "OK" )|| (rowValData[j]["insp_rst"] == ""))
				{
					ipt_flag++;
				}
				
				if((rowValData[j]["col_" + (i+1)].length > 0))
					ipt_cnt++;
			}
		}
	}
	
	if(ipt_flag > 0)
	{
		fnMessageModalAlert('알림', '치수 입력값은 모두 입력돼야합니다.');		
		return;
	}
	
	fnMessageModalConfirm("알림", "해당 검사를 종료처리하시겠습니까?", function(chk){
		if(!chk)
		{
			return;
		}
		
		var selIdxArr = w2ui.grid_list.getSelection();
		
		var product_po = w2ui.grid_list.get(selIdxArr[0]).product_po;
		var item_code = w2ui.grid_list.get(selIdxArr[0]).item_code;
		var routing_code = w2ui.grid_list.get(selIdxArr[0]).routing_code;
		var warehouse_gubun = w2ui.grid_list.get(selIdxArr[0]).warehouse_gubun;
		
		var page_url = "/insp/fnshInspData";
		var postData = "product_po=" + encodeURIComponent(product_po);
		postData += "&item_code=" + encodeURIComponent(item_code);
		postData += "&routing_code=" + encodeURIComponent(routing_code);
		postData += "&warehouse_gubun=" + encodeURIComponent(warehouse_gubun);
		postData += "&ipt_cnt=" + encodeURIComponent(ipt_cnt);
		FunLoadingBarStart();
		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData,
			dataType : 'json',
			success: function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					if (data.cnt > 0) {
						fnMessageModalAlert("알림", "측정값 저장을 먼저 해주세요.");
					} else {
						if (data.strtChk != 0) {
							fnMessageModalAlert("알림", "검사시작을 먼저 진행해주세요.");
							$('#modal_chk_sheet').css('overflow','auto');
						}
						else{
							fnMessageModalAlert("알림", "해당 공정 검사가 완료되었습니다.");
							loadList();
							$("#modal_chk_sheet").modal('hide');	
						}
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

function strtChkShtData()
{
	var selIdxArr = w2ui.grid_list.getSelection();
	
	var product_po = w2ui.grid_list.get(selIdxArr[0]).product_po;
	var routing_code = w2ui.grid_list.get(selIdxArr[0]).routing_code;
	
	var page_url = "/insp/strtChkShtData";
	var postData = "product_po=" + encodeURIComponent(product_po);
	postData += "&routing_code=" + encodeURIComponent(routing_code);
	
	FunLoadingBarStart();
	$.ajax({
		url : page_url,
		type : 'POST',
		data: postData,
		dataType : 'json',
		success: function(data, textStatus, jqXHR) {
			if (data.status == "200") {
				if (data.cnt == 0) {
					fnMessageModalAlert("알림", "해당 공정이 이미 시작되었습니다.");
				} else {
					fnMessageModalAlert("알림", "해당 공정 검사가 시작되었습니다.");	
				}
			} else {
				fnMessageModalAlert("알림", "저장을 실패했습니다.");
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			fnMessageModalAlert("알림", "저장을 실패했습니다.");
		},	
		complete: function () {
			loadVal();
			FunLoadingBarEnd();
		}
	});   
}

function initInspInfo()
{
	fnMessageModalConfirm("알림", "현재 화면에 저장된 내역을 검사시작전 상태로 변경합니다.<br/>입력하신 측정값은 모두 초기화됩니다.<br/>계속 진행하시겠습니까?   ", function(chk){
		if(!chk)
		{
			return;
		}
		var selIdxArr = w2ui.grid_list.getSelection();
		
		var product_po = w2ui.grid_list.get(selIdxArr[0]).product_po;
		var routing_code = w2ui.grid_list.get(selIdxArr[0]).routing_code;
		
		var page_url = "/insp/initInspInfo";
		var postData = "product_po=" + encodeURIComponent(product_po);
		postData += "&routing_code=" + encodeURIComponent(routing_code);
		
		FunLoadingBarStart();
		$.ajax({
			url : page_url,
			type : 'POST',
			data: postData,
			dataType : 'json',
			success: function(data, textStatus, jqXHR) {
				if (data.status == "200") {
					fnMessageModalAlert("알림", "해당 공정 측정 정보를 초기화했습니다.");
					loadList();
					$("#modal_chk_sheet").modal('hide');
				} else {
					fnMessageModalAlert("알림", "초기화를 실패했습니다.");
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				fnMessageModalAlert("알림", "초기화를 실패했습니다.");
			},	
			complete: function () {
				FunLoadingBarEnd();
			}
		});   
	});
}
</script>

</body>
</html>