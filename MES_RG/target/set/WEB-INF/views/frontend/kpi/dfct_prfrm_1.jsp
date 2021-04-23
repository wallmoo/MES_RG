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
		<jsp:param name="selected_menu_p_cd" value="1013" />
		<jsp:param name="selected_menu_cd" value="1086" />
	</jsp:include>

<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>	

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      품질 실적 정보
        <small>KPI Monitoring</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> KPI Monitoring</a></li><li class="active">품질 실적 정보</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button>	 
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>연도</label>
									 <select id="date" name="date" class="form-control" style="height: 30px;"></select>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>검사종류</label>
									 <select id="kind" name="kind" class="form-control" style="height: 30px;" >
										<option value="합계" selected="selected">합계</option>
									 	<option value="제품품질">제품품질</option>
									 	<option value="외주">외주검사</option>
									 	<option value="자주">자주검사</option>
									 	<option value="최종">최종검사</option>
									 	<option value="수리">수리검사</option>
									 </select>
								</div>
							</div>
							
							
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>P/N</label>
									 <input type="text" id="item_code" name="item_code" placeholder="ex) P/N"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>품명</label>
									 <input type="text" id="item_nm" name="item_nm" placeholder="ex) 품명"
									 class="form-control input-sm" onkeypress="if(event.keyCode==13) {loadList(); return false;}"/>
								</div>
							</div>
							
						</div>
						
						<div class="row" style="margin-bottom: 10px">
							<div class="col-md-12 text-center">
								<div id="chartHolder" style="width: 100%; height: 360px; text-align: center; margin-bottom: 5px;"></div>
							</div>
						</div>
						
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-md-12">
								<div class="col-md-12 text-right" style="margin-bottom: 5px; padding-right: 0px">
									<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload3();">엑셀다운로드</button>
								</div>
								<div id="grid_list_md" style="width: 100%; height: 490px; "></div>
							</div>
						</div>
						
						
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-md-12">
								<div class="col-md-3 text-left" >
									<h3 class="" style="margin: 0; margin-left: 15px;">월별 상세(불량)</h3>
								</div>	
								<div class="col-md-3 text-right">
									<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload2();">엑셀다운로드</button>
								</div>
								<div class="col-md-3 text-left" >
									<h3 class="" style="margin: 0; margin-left: 30px;" id="idxMonth">월 상세</h3>
								</div>
								<div class="col-md-3 text-right" style="padding-right: 0px;">
									<button type="button" id="" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀다운로드</button>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-md-6">
								<div id="grid_list_rt" style="width: 100%; height: 300px; "></div>
							</div>								
							<div class="col-md-6">
								<div id="grid_list_lt" style="width: 100%; height: 300px; "></div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->

<script type="text/javascript">
	var layoutStr = "";
	var chartLength = "";
	var chartData = new Array();
	
	$(function($) {
	 	fnLoadCommonOption(); 	 

	 	var date = new Date();
		var currYear = date.getFullYear();

		$("#date").append("<option value='" +(currYear-2) +"'>" + (currYear-2) + "</option>");
		$("#date").append("<option value='" +(currYear-1) +"'>" + (currYear-1) + "</option>");
		$("#date").append("<option value='" +(currYear) +"'>" + currYear + "</option>");
		$("#date").append("<option value='" +(currYear+1) +"'>" + (currYear+1) + "</option>");
		
		$("#date option:eq(2)").prop("selected", true);
		
		fnLoadMdGrid();
	 	fnLoadLeftGrid();
	 	fnLoadRightGrid();
	 	
	 	loadList();
	 	
	 	
	 	requestItem();
	 	
		$('#grid_list_md').on('DOMSubtreeModified propertychange', _.debounce(function() {
			changeGridUI();
	   }, 100));
	})
	//품명,품번 자동완성
	$("#item_nm").change(_.debounce(function(event) {
		
		var item_nm = $("#item_nm").val();
		$(this).val(function(index, value) {
			
			
			getItemInfo('nm',value);
			return value
		});
		
	},400));
	$("#item_code").change(
			
		_.debounce(function(event) 
		{

			var item_code = $("#item_code").val();
			$(this).val(function(index, value) {
				
				
				getItemInfo('cd',value);
				return value
			});

		},400)
	);
	
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
	
	function fnLoadLeftGrid(){
		console.log('fnLoadLeftGrid()');
		var rowArr = [];
		
		$('#grid_list_lt').w2grid({ 
	        name: 'grid_list_lt',
	        show: {
	        	selectColumn: false,
				lineNumbers : true,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [                
					{ field:'m_month', caption:'월', size:'10%', style:'text-align:center', sortable: true},
					{ field:'kind', caption:'검사종류', size:'10%', style:'text-align:center', sortable: true
						,render: function (record, index, col_index) {
							var html = this.getCellValue(index, col_index);

			                if(html == '합계')
			            	{
			            	   return html;
			            	}else
			            	{
			            		return html+'검사';	
			            	}
			           }
					},
					{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center', sortable: true}, 
					{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center', sortable: true}, 
 					{ field:'prod_menge', caption:'전체수량', size:'10%', style:'text-align:center', sortable: true},
 					{ field:'prfr_menge', caption:'생산수량', size:'10%', style:'text-align:center', sortable: true},
					{ field:'ng_cnt', caption:'불량수량', size:'10%', style:'text-align:center', sortable: true } 					
				], 
			records: [],
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
	}
	
	function fnLoadRightGrid(){
		 console.log('fnLoadRightGrid()');
		var rowArr = [];
		
		$('#grid_list_rt').w2grid({ 
	        name: 'grid_list_rt',
	        show: {
	        	selectColumn: false,
				lineNumbers : true,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [          
				{ field:'m_month', caption:'월', size:'10%', style:'text-align:center', sortable: true},
				{ field:'kind', caption:'검사종류', size:'10%', style:'text-align:center', sortable: true
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);

		                if(html == '합계')
		            	{
		            	   return html;
		            	}else
		            	{
		            		return html+'검사';	
		            	}
		           }	
				},
				{ field:'item_code', caption:'P/N', size:'10%', style:'text-align:center', sortable: true}, 
				{ field:'item_nm', caption:'품명', size:'10%', style:'text-align:center', sortable: true},	
				{ field:'ng_cnt', caption:'불량수량', size:'10%', style:'text-align:center', sortable: true },
				], 
			records: [],
			onReload: function(event) {
			},
			onClick: function (event) {}
		});
	}
	
	function fnLoadMdGrid(){
		 console.log('fnLoadMdGrid()');
		
		$('#grid_list_md').w2grid({ 
	        name: 'grid_list_md',
	        show: {
	        	selectColumn: false,
				lineNumbers : true,
	            footer: true
	        },
	        multiSelect: false,
	        columns: [          
				{ field:'kind', caption:'검사종류', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var html = this.getCellValue(index, col_index);

		                if(html == '합계')
		            	{
		            	   return html;
		            	}else
		            	{
		            		return html+'검사';	
		            	}
		           }
				},
				{ field:'info', caption:'정보', size:'10%', style:'text-align:center'},
				{ field:'m_1', caption:'1월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           } 	
				}, 
				{ field:'m_2', caption:'2월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           } 	
				},
				{ field:'m_3', caption:'3월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           } 	
				},
				{ field:'m_4', caption:'4월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }					
				},
				{ field:'m_5', caption:'5월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				},
				{ field:'m_6', caption:'6월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				},
				{ field:'m_7', caption:'7월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				},
				{ field:'m_8', caption:'8월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				},
				{ field:'m_9', caption:'9월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				},
				{ field:'m_10', caption:'10월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				},
				{ field:'m_11', caption:'11월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				},
				{ field:'m_12', caption:'12월', size:'10%', style:'text-align:center'
					,render: function (record, index, col_index) {
						var info = record['info'];
						var html = this.getCellValue(index, col_index);

		                if(info == '불량율')
		            	{
		            	   return html+'%';
		            	}else
		            	{
		            		return html;	
		            	}
		           }	
				}
				], 
			records: [],
			onReload: function(event) {
			},
			onClick: function (event) {}
		});
	}
	
	$("#date").change(function(){
		loadList();
	});

	$("#kind").change(function(){
		loadList();
	});
	
	
	var startValue_combo = "";

	comboValue_nm_i = new Array;
	comboValue_cd = new Array;

	var materialArr = new Array;

	//모달 제품
	function requestItem(){
		var page_url = "/frontend/repair/selectRepairItem";
		
	/* 	var postData = "item_code=" + encodeURIComponent(item_code)
			+ "&item_nm=" + encodeURIComponent(item_nm); */
		
		$.ajax({
			url : page_url,
			type : 'POST',
			//data : postData,
			data_type : 'json',
			success : function(data){
				if(data.status == 200 && (data.rows).length > 0){
					rowArr = data.rows;
					materialArr = rowArr;
					$.each(rowArr, function(idx, row){
						row.recid = idx + 1;
						
						if (startValue_combo == "") {
							comboValue_nm_i.push(row.item_nm);
							comboValue_cd.push(row.item_code);
						}
					});
				
					
					if (startValue_combo == "") {
						$('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm_i,false) ,match : 'contains' });				
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
		
		
		var result = "";
		if(type == 'cd')
		{
			$.each(materialArr, function(idx, row){
				
				if(value == row.item_code)
				{
					
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
					
					result = row.item_code;
					$("#item_code").val(result);
				}
			});
			if(result == ''){
				$("#item_code").val('');
			}
			
		}
	}
	
	function loadList() {
		w2ui.grid_list_md.clear();
		w2ui.grid_list_lt.clear();
		w2ui.grid_list_rt.clear();		
		
		chartData = new Array();
		
		var year = $("#date option:selected").val(); 
		var item_code = $("#item_code").val(); 
		var item_nm = $("#item_nm").val(); 
		
		var page_url = "/insp/selectDfctGrph";
		
		var postData = "m_year=" + encodeURIComponent(year)
				+"&item_code=" + encodeURIComponent(item_code)
				+"&item_nm=" + encodeURIComponent(item_nm);
		var result ;
		
		FunLoadingBarStart();
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {

					result = data.rows;

					var grapArr = new Array();
										
					var maxVal = 0;
					
// 					for(var c = 1; c<= 12; c++)
// 					{
// 						var grapObj = new Object();
// 						grapObj.m_month = c + "월";
						
// 						grapArr.push(grapObj);
						
// 					}
					
					var maxChkArr = new Array();
					
					for(var i = 0; i< result.length; i++)
					{
						var grapObj = new Object();
						var month = result[i].m_month;
						
				
						grapObj.m_month  = month.replace(/(^0+)/, "") + "월";
					
						grapObj.kind_1 = result[i].kind_1;
						grapObj.kind_2 = result[i].kind_2;
						grapObj.kind_4 = result[i].kind_4;
						grapObj.kind_5 = result[i].kind_5;
						grapObj.kind_6 = result[i].kind_6;
						grapObj.kind_7 = result[i].kind_7;

						grapObj.c_kind_1 = result[i].c_kind_1;
						grapObj.c_kind_2 = result[i].c_kind_2;
						grapObj.c_kind_4 = result[i].c_kind_4;
						grapObj.c_kind_5 = result[i].c_kind_5;
						grapObj.c_kind_6 = result[i].c_kind_6;
						grapObj.c_kind_7 = result[i].c_kind_7;
						//목표 goal
						grapObj.goal_1 = result[i].goal_1;
						grapObj.goal_2 = result[i].goal_2;
						grapObj.goal_4 = result[i].goal_4;
						grapObj.goal_5 = result[i].goal_5;
						grapObj.goal_6 = result[i].goal_6;
						grapObj.goal_7 = result[i].goal_7;
						
						
						grapObj.acc_goal_1 = 0;
						grapObj.acc_goal_2 = 0;
						grapObj.acc_goal_4 = 0;
						grapObj.acc_goal_5 = 0;
						grapObj.acc_goal_6 = 0;
						grapObj.acc_goal_7 = 0;

						for (var j = 0; j < i+1; j++) {
							grapObj.acc_goal_1 = grapObj.acc_goal_1 + Number(result[j].goal_1);
							grapObj.acc_goal_2 = grapObj.acc_goal_2 + Number(result[j].goal_2);
							grapObj.acc_goal_4 = grapObj.acc_goal_4 + Number(result[j].goal_4);
							grapObj.acc_goal_5 = grapObj.acc_goal_5 + Number(result[j].goal_5);
							grapObj.acc_goal_6 = grapObj.acc_goal_6 + Number(result[j].goal_6);
							grapObj.acc_goal_7 = grapObj.acc_goal_7 + Number(result[j].goal_7);
						}
						
						grapObj.acc_goal_1 = (Number(grapObj.acc_goal_1)/(i+1)).toFixed(2);
						grapObj.acc_goal_2 = (Number(grapObj.acc_goal_2)/(i+1)).toFixed(2);
						grapObj.acc_goal_4 = (Number(grapObj.acc_goal_4)/(i+1)).toFixed(2);
						grapObj.acc_goal_5 = (Number(grapObj.acc_goal_5)/(i+1)).toFixed(2);
						grapObj.acc_goal_6 = (Number(grapObj.acc_goal_6)/(i+1)).toFixed(2);
						grapObj.acc_goal_7 = (Number(grapObj.acc_goal_7)/(i+1)).toFixed(2);

						
						var kind = $("#kind").val(); 
				
						if(kind == '외주')
						{
							maxChkArr.push(Number(grapObj.kind_1));
							maxChkArr.push(Number(grapObj.c_kind_1));
							maxChkArr.push(Number(grapObj.goal_1));
							maxChkArr.push(Number(grapObj.acc_goal_1));
						}
						if(kind == '자주')
						{
							maxChkArr.push(Number(grapObj.kind_2));
							maxChkArr.push(Number(grapObj.c_kind_2));
							maxChkArr.push(Number(grapObj.goal_2));
							maxChkArr.push(Number(grapObj.acc_goal_2));
						}
						if(kind == '최종')
						{
							maxChkArr.push(Number(grapObj.kind_4));
							maxChkArr.push(Number(grapObj.c_kind_4));
							maxChkArr.push(Number(grapObj.goal_4));
							maxChkArr.push(Number(grapObj.acc_goal_4));
						}
						if(kind == '수리')
						{
							maxChkArr.push(Number(grapObj.kind_5));
							maxChkArr.push(Number(grapObj.c_kind_5));
							maxChkArr.push(Number(grapObj.goal_5));
							maxChkArr.push(Number(grapObj.acc_goal_5));
						}
						if(kind == '합계')
						{
							maxChkArr.push(Number(grapObj.kind_6));
							maxChkArr.push(Number(grapObj.c_kind_6));
							maxChkArr.push(Number(grapObj.goal_6));
							maxChkArr.push(Number(grapObj.acc_goal_6));
						}
						if(kind == '제품품질')
						{
							maxChkArr.push(Number(grapObj.kind_7));
							maxChkArr.push(Number(grapObj.c_kind_7));
							maxChkArr.push(Number(grapObj.goal_7));
							maxChkArr.push(Number(grapObj.acc_goal_7));
						}
						
						grapArr[i] = grapObj;
						
					}
					console.log(maxChkArr);
					maxVal = Math.max.apply(null, maxChkArr); 
					maxVal = Math.ceil(Number(maxVal)*1.1)
					setTimeout(function () {
						
						chartData = grapArr;
						
						console.log(chartData);
						
						chartLength = chartData.length;
						
						makeLayout(maxVal);
						fnLoadChart();
						
				
					}, 500);
					
					loadList_md('','');
					loadList_lt('',kind);
					loadList_rt('',kind);
					
				} else {
					console.log('check');
					var b = [];
					document.getElementById("chart1").setData(b);
					makeLayout(100);
					fnLoadChart();
					rMateChartH5.call("chart1", "hasNoData", true);					
					
				}
			},complete: function () {
				FunLoadingBarEnd();
			}
		});
	}
	
	// 클릭한 아이템 정보 보기
	function gridData (seriesId, displayText, index, data, values) {
		console.log("gridData()");
		
		var valMonth = values[0];
		
		var month = valMonth.replace('월',"");
		
		loadList_md(month, displayText);
		loadList_lt(month, displayText);
		loadList_rt(month, displayText);  
		hMonthChange(month);
	}
	
	function hMonthChange(month){
		$("#idxMonth").text(month + "월 상세");
	}
	
	function loadList_md(month, displayText){
		hMonthChange('');
		w2ui['grid_list_md'].clear();
		
		var year = $("#date option:selected").val(); 
		var item_code = $("#item_code").val(); 
		var item_nm = $("#item_nm").val(); 
		var kind = '';
		
		var page_url = "/insp/selectDfctGrphMd";
		
		var postData = "m_year=" + encodeURIComponent(year)
			 + "&kind=" + encodeURIComponent(kind)
			 + "&m_month=" + encodeURIComponent(month)
			 + "&item_code=" + encodeURIComponent(item_code)
			 + "&item_nm=" + encodeURIComponent(item_nm);
		
		
		w2ui['grid_list_md'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					
					rowArr = data.rows;
					
					var kinds = ['외주', '자주', '최종', '제품품질', '수리', '합계'];
					var infos = ['생산수량', '불량수량', '불량율'];
					
					//데이터 초기화 :: start
					var arr = new Array();
					
					for(var a=0 ; a<kinds.length; a++)
					{
						for(var b=0 ; b<infos.length; b++)
						{
							var obj = new Object();
							obj.kind = kinds[a];
							obj.info = infos[b];
													
							for(var c=0 ; c<12 ; c++)
							{
								obj["m_"+(c+1)] = 0;
							}
							
							arr.push(obj);
						}
					}
					//데이터 초기화 :: end
				
					//데이터 입력 :: start		
					$.each(rowArr, function(idx, row){
						for(var a=0 ; a<arr.length; a++)
						{
							if(row.kind == arr[a].kind)
							{
								if(a%3 == 0)
									arr[a]["m_"+row.m_month] = row.prfr_menge;
								if(a%3 == 1)
									arr[a]["m_"+row.m_month] = row.ng_cnt;
								if(a%3 == 2)
								{
									if(Number(row.dfct_rate) == 0)
									{
										arr[a]["m_"+row.m_month] = 0;
									} else {
										arr[a]["m_"+row.m_month] = Number(row.dfct_rate);	
									}
									
								}
									
									
							}
						}
					});
					//데이터 입력 :: end
	
					
					$.each(arr, function(idx, row){
						row.recid = idx+1;
					});
					
					w2ui['grid_list_md'].records = arr;
				} else {
					w2ui.grid_list_md.clear();
				}
				w2ui['grid_list_md'].refresh();
				w2ui['grid_list_md'].unlock();
			},complete: function () {}
		});
		
	}
	
	function loadList_lt(month, displayText){
		
		w2ui['grid_list_lt'].clear();
		
		var year = $("#date option:selected").val(); 
		var item_code = $("#item_code").val(); 
		var item_nm = $("#item_nm").val(); 
		var kind = '';
		
		if(displayText.indexOf('외주') != -1) {
			kind = '외주';
		}
		if(displayText.indexOf('자주') != -1) {
			kind = '자주';
		}
		if(displayText.indexOf('최종') != -1) {
			kind = '최종';
		}
		if(displayText.indexOf('수리') != -1) {
			kind = '수리';
		}
		if(displayText.indexOf('제품품질') != -1) {
			kind = '제품품질';
		}
		
		var page_url = "/insp/selectDfctGrphLt";
		
		var postData = "m_year=" + encodeURIComponent(year)
			 + "&kind=" + encodeURIComponent(kind)
			 + "&m_month=" + encodeURIComponent(month)
			 + "&item_code=" + encodeURIComponent(item_code)
			 + "&item_nm=" + encodeURIComponent(item_nm);
		
		
		w2ui['grid_list_lt'].lock('loading...', true);
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
						
						row.prfr_menge = Number(row.prfr_menge);
						row.prod_menge = Number(row.prod_menge);
						row.ng_cnt = Number(row.ng_cnt);
						row.c_dfct_cnt = Number(row.c_dfct_cnt);
					});
					w2ui['grid_list_lt'].records = rowArr;
				} else {
					w2ui.grid_list_lt.clear();
				}
				w2ui['grid_list_lt'].refresh();
				w2ui['grid_list_lt'].unlock();
			},complete: function () {}
		});
		
	}
	
	function loadList_rt(month, displayText){
		
		w2ui['grid_list_rt'].clear();
		
		var year = $("#date option:selected").val(); 
		var item_code = $("#item_code").val(); 
		var item_nm = $("#item_nm").val(); 
		var kind = '';
		
		if(displayText.indexOf('외주') != -1) {
			kind = '외주';
		}
		if(displayText.indexOf('자주') != -1) {
			kind = '자주';
		}
		if(displayText.indexOf('최종') != -1) {
			kind = '최종';
		}
		if(displayText.indexOf('수리') != -1) {
			kind = '수리';
		}
		if(displayText.indexOf('제품품질') != -1) {
			kind = '제품품질';
		}
		
		var page_url = "/insp/selectDfctGrphRt";
		
		var postData = "m_year=" + encodeURIComponent(year)
		 + "&kind=" + encodeURIComponent(kind)
		 + "&item_code=" + encodeURIComponent(item_code)
		 + "&item_nm=" + encodeURIComponent(item_nm);
		
		w2ui['grid_list_rt'].lock('loading...', true);
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
						row.prfr_menge = Number(row.prfr_menge);
						row.prod_menge = Number(row.prod_menge);
						row.ng_cnt = Number(row.ng_cnt);
						row.c_dfct_cnt = Number(row.c_dfct_cnt);
					});
					w2ui['grid_list_rt'].records = rowArr;
				} else {
					w2ui.grid_list_rt.clear();
				}
				w2ui['grid_list_rt'].refresh();
				w2ui['grid_list_rt'].unlock();
			},complete: function () {}
		});
		
	}
	
	
	
	// hasNoData(false); 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면
		// false로 주어 차트 전체의 visible을 false로 설정합니다.
	// hasNoData(true); 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어
		// visible을 true로 설정합니다.
	/* function checkData(data){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		if(data.length <= 0)
			document.getElementById("chart1").hasNoData(true);
		
	} */
	// PROPERTIES +
	// 이벤트
	
	
	
	//-------------------------------------------------------------------------------------------------------------------
	// 촤트
	
	// 차트 로딩 
	// 프리로더를 보이게 합니다.
	function showPreloader()
	{
	  document.getElementById("chart1").showAdditionalPreloader();
	}
	 
	// 프리로더를 제거합니다.
	function hidePreloader()
	{
	   document.getElementById("chart1").removeAdditionalPreloader();
	}
	// 차트 로딩
	
	
	function fnLoadChart() {
		rMateChartH5.create("chart1", "chartHolder", "", "100%", "100%");
		rMateChartH5.calls("chart1", {
			   "setLayout" : layoutStr,
			    "setData" : chartData
		});
	}
	
// 	function axisLabelFunc2(id, value){
// 	   	  //var s = insertComma(value);
// 	   		return value;
// 	   	}
	
	function makeLayout(maxVal){
		
		var year = $("#date option:selected").val();
		var kind = $("#kind").val(); 
		
// 		 maxVal = 1;
		 
		 
		 
		layoutStr =
				'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+'<Options>'
                   	+'<Caption text="'+ year +'년 품질 그래프"/>'
                    	+'<Legend useVisibleCheck="true"/>'
					+'</Options>'
					+'<NumberFormatter id="numFmt" precision="0" useThousandsSeparator="true"/>'
					+'<NumberFormatter id="numFmt1" useThousandsSeparator="true"/>'
					+'<Combination2DChart showDataTips="true" itemClickJsFunction="gridData" selectionMode="single">' // dataTipJsFunction="dataTipJsFunc"
                 
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="m_month" padding="0.5"/>'
                    +'</horizontalAxis>'
                    +'<verticalAxis>'
                    	+'<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" formatter="{numFmt1}" maximum = "'+maxVal+'"/>'
//                      +'<LinearAxis maximum="'+Math.ceil(Number(maxVal)*1.1)+'" interval="10"/>'
                    +'</verticalAxis>'
                    +'<series>'
                    	+'<Column2DSet type="clustered">'
                      		+'<series>';
                            
                          
		if(kind == '외주')
   		{
        layoutStr +=
	        					'<Column2DSeries yField="c_kind_1" displayName="외주불량률"  showValueLabels="[2]">'
		                        	+'<fill>'
	 	                          		+'<SolidColor color="#0054FF"/>'
	 	                           	+'</fill>'
	                                +'<showDataEffect>'
	                                	+'<SeriesInterpolate/>'
	                                +'</showDataEffect>'
								+'</Column2DSeries>'    
                    		+'</series>'
                        +'</Column2DSet>'
                        +'<Line2DSeries selectable="true" yField="kind_1" displayName="누적불량률(외주)" radius="4.5" itemRenderer="CircleItemRenderer">'
  	                    	+'<stroke>'
  		                    	+'<Stroke color="#5ddc96" weight="2"/>'
  		                 	+'</stroke>'
  		                	+'<lineStroke>'
  		                    	+'<Stroke color="#5ddc96" weight="2"/>'
  		                 	+'</lineStroke>'
                       		+'<showDataEffect>'
                          		+'<SeriesInterpolate/>'
                          	+'</showDataEffect>'
                        +'</Line2DSeries>'
                        +'<Line2DSeries selectable="true" yField="goal_1" displayName="외주목표" radius="4.5" itemRenderer="CircleItemRenderer">'
					   		+'<stroke>'
  		                    	+'<Stroke color="#ffd736" weight="2"/>'
  		                 	+'</stroke>'
  		                +'<lineStroke>'
  		                     +'<Stroke color="#ffd736" weight="2"/>'
  		                +'</lineStroke>'
                       	+'<showDataEffect>'
                        	+'<SeriesInterpolate/>'
                        +'</showDataEffect>'
                       	+'</Line2DSeries>'
                        +'<Line2DSeries yField="acc_goal_1" fill="#ffffff" radius="5" displayName="누적목표(외주)" itemRenderer="CircleItemRenderer">'
                        +'<lineStroke>'
                        	+'<Stroke color="#fc4141" weight="2"/>'
                        +'</lineStroke>'
                        +'<verticalAxis>'
                        	+'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum = "'+maxVal+'"/>'
                        +'</verticalAxis>'
                        +'<showDataEffect>'
                        +'<SeriesInterpolate/>'
                        	+'</showDataEffect>'
                      	+'</Line2DSeries>'
                      
                                
    		}
            if(kind == '자주')
    		{
            layoutStr +=
	            				'<Column2DSeries yField="c_kind_2" displayName="자주불량률"  showValueLabels="[2]">'
									+'<fill>'
	  		                        	+'<SolidColor color="#0054FF"/>'
	  		                     	+'</fill>'
	                                +'<showDataEffect>'
	                                	+'<SeriesInterpolate/>'
	                                    +'</showDataEffect>'
	          					+'</Column2DSeries>'    
							+'</series>'
                        +'</Column2DSet>'
                        +'<Line2DSeries selectable="true" yField="kind_2" displayName="누적불량률(자주)" radius="4.5" itemRenderer="CircleItemRenderer">'
  	                    	+'<stroke>'
  		                    	+'<Stroke color="#5ddc96" weight="2"/>'
  		                 	+'</stroke>'
  		                	+'<lineStroke>'
  		                    	+'<Stroke color="#5ddc96" weight="2"/>'
  		                 	+'</lineStroke>'
                       		+'<showDataEffect>'
  	                     		+'<SeriesInterpolate/>'
  	                     	+'</showDataEffect>'
  	                  	+'</Line2DSeries>'
                      	+'<Line2DSeries selectable="true" yField="goal_2" displayName="자주목표" radius="4.5" itemRenderer="CircleItemRenderer">'
	                    	+'<stroke>'
		                    	+'<Stroke color="#ffd736" weight="2"/>'
		                 	+'</stroke>'
		                	+'<lineStroke>'
		                    	+'<Stroke color="#ffd736" weight="2"/>'
		                 	+'</lineStroke>'
                    		+'<showDataEffect>'
                       			+'<SeriesInterpolate/>'
                       		+'</showDataEffect>'
                    	+'</Line2DSeries>'
                    	+'<Line2DSeries yField="acc_goal_2" fill="#ffffff" radius="5" displayName="누적목표(자주)" itemRenderer="CircleItemRenderer">'
                     		+'<lineStroke>'
                            	+'<Stroke color="#fc4141" weight="2"/>'
                         	+'</lineStroke>'
                        	+'<verticalAxis>'
                         		+'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum = "'+maxVal+'"/>'
                      		+'</verticalAxis>'
                        	+'<showDataEffect>'
                            	+'<SeriesInterpolate/>'
                        	+'</showDataEffect>'
                   		+'</Line2DSeries>'
			}
                          
            if(kind == '최종')
    		{                	
            layoutStr +=
            					'<Column2DSeries yField="c_kind_4" displayName="최종불량률"  showValueLabels="[2]">'
  		                        	+'<fill>'
  	                         			+'<SolidColor color="#0054FF"/>'
  	                     	    	+'</fill>'
  	                          		+'<showDataEffect>'
                                  		+'<SeriesInterpolate/>'
                               		+'</showDataEffect>'
  		                      	+'</Column2DSeries>'
                        	+'</series>'
                        +'</Column2DSet>'
                     	+'<Line2DSeries selectable="true" yField="kind_4" displayName="누적불량률(최종)" radius="4.5" itemRenderer="CircleItemRenderer">'
  	                   		+'<stroke>'
  		                   		+'<Stroke color="#5ddc96" weight="2"/>'
  		               		+'</stroke>'
  		              		+'<lineStroke>'
  		                   		+'<Stroke color="#5ddc96" weight="2"/>'
  		               		+'</lineStroke>'
                  			+'<showDataEffect>'
                     			+'<SeriesInterpolate/>'
                     		+'</showDataEffect>'
                  		+'</Line2DSeries>'
                  		+'<Line2DSeries selectable="true" yField="goal_4" displayName="최종목표" radius="4.5" itemRenderer="CircleItemRenderer">'
                    		+'<stroke>'
	                     		+'<Stroke color="#ffd736" weight="2"/>'
	                 		+'</stroke>'
	                		+'<lineStroke>'
	                     		+'<Stroke color="#ffd736" weight="2"/>'
	                 		+'</lineStroke>'
                			+'<showDataEffect>'
                   				+'<SeriesInterpolate/>'
                   			+'</showDataEffect>'
                		+'</Line2DSeries>'
                		+'<Line2DSeries yField="acc_goal_4" fill="#ffffff" radius="5" displayName="누적목표(최종)" itemRenderer="CircleItemRenderer">'
			                +'<lineStroke>'
            		            +'<Stroke color="#fc4141" weight="2"/>'
                    		+'</lineStroke>'
                     		+'<verticalAxis>'
                     			+'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum = "'+maxVal+'"/>'
                  			+'</verticalAxis>'
                    		+'<showDataEffect>'
                        		+'<SeriesInterpolate/>'
                    		+'</showDataEffect>'
               			+'</Line2DSeries>'        
			}
                            
            if(kind == '수리')
    		{
                            
				layoutStr +=
								'<Column2DSeries yField="c_kind_5" displayName="수리불량률"  showValueLabels="[2]">'
  			                    	+'<fill>'
  	                         			+'<SolidColor color="#0054FF"/>'
  	                     	      	+'</fill>'  
  			                      	+'<showDataEffect>'
  			                        	+'<SeriesInterpolate/>'
  			                      	+'</showDataEffect>'
  		                  		+'</Column2DSeries>'
                            +'</series>'
						+'</Column2DSet>'
                  		+'<Line2DSeries selectable="true" yField="kind_5" displayName="누적불량률(수리)" radius="4.5" itemRenderer="CircleItemRenderer">'
  	                		+'<stroke>'
  		                		+'<Stroke color="#5ddc96" weight="2"/>'
  		            		+'</stroke>'
  		           			+'<lineStroke>'
  		                		+'<Stroke color="#5ddc96" weight="2"/>'
  		            		+'</lineStroke>'
               				+'<showDataEffect>'
                  				+'<SeriesInterpolate/>'
                  			+'</showDataEffect>'
               			+'</Line2DSeries>'
               			+'<Line2DSeries selectable="true" yField="goal_5" displayName="수리목표" radius="4.5" itemRenderer="CircleItemRenderer">'
               				+'<stroke>'
                    			+'<Stroke color="#ffd736" weight="2"/>'
                			+'</stroke>'
	               			+'<lineStroke>'
	                    		+'<Stroke color="#ffd736" weight="2"/>'
	                		+'</lineStroke>'
	           				+'<showDataEffect>'
	              				+'<SeriesInterpolate/>'
	              			+'</showDataEffect>'
           				+'</Line2DSeries>'
	           			+'<Line2DSeries yField="acc_goal_5" fill="#ffffff" radius="5" displayName="누적목표(수리)" itemRenderer="CircleItemRenderer">'
				            +'<lineStroke>'
	            		        +'<Stroke color="#fc4141" weight="2"/>'
	                		+'</lineStroke>'
		                	+'<verticalAxis>'
		                		+'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum = "'+maxVal+'"/>'
		             		+'</verticalAxis>'
		               		+'<showDataEffect>'
		                   		+'<SeriesInterpolate/>'
		               		+'</showDataEffect>'
	          			+'</Line2DSeries>';
                                
    		}
                    
              
			if(kind == '합계')
    		{
                            
            layoutStr +=
            					'<Column2DSeries yField="c_kind_6" displayName="합계불량률"  showValueLabels="[2]">'
									+'<fill>'
  										+'<SolidColor color="#0054FF"/>'
  	                     	     	+'</fill>'  
	  			                 	+'<showDataEffect>'
	 			                    	+'<SeriesInterpolate/>'
	  			                    +'</showDataEffect>'
  		                  		+'</Column2DSeries>'
                            +'</series>'
                        +'</Column2DSet>'
                        
                        
                      
                  		+'<Line2DSeries selectable="true" yField="kind_6" displayName="누적불량률(합계)" radius="4.5" itemRenderer="CircleItemRenderer">'
	  	                	+'<stroke>'
	  		           	    	+'<Stroke color="#5ddc96" weight="2"/>'
	  		           		+'</stroke>'
	  		           		+'<lineStroke>'
	  		                	+'<Stroke color="#5ddc96" weight="2"/>'
	  		            	+'</lineStroke>'
	               			+'<showDataEffect>'
	                  			+'<SeriesInterpolate/>'
	                  		+'</showDataEffect>'
               			+'</Line2DSeries>'
               
               			+'<Line2DSeries selectable="true" yField="goal_6" displayName="합계목표" radius="4.5" itemRenderer="CircleItemRenderer">'
	                 		+'<stroke>'
	                     		+'<Stroke color="#ffd736" weight="2"/>'
	                 		+'</stroke>'
	                		+'<lineStroke>'
	                     		+'<Stroke color="#ffd736" weight="2"/>'
	                 		+'</lineStroke>'
	             			+'<showDataEffect>'
	                			+'<SeriesInterpolate/>'
	                		+'</showDataEffect>'
             			+'</Line2DSeries>'
             
             
             			+'<Line2DSeries yField="acc_goal_6" fill="#ffffff" radius="5" displayName="누적목표(합계)" itemRenderer="CircleItemRenderer">'
              				+'<lineStroke>'
                      			+'<Stroke color="#fc4141" weight="2"/>'
                  			+'</lineStroke>'
                  			+'<verticalAxis>'
                  				+'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum = "'+maxVal+'"/>'
               				+'</verticalAxis>'
                 			+'<showDataEffect>'
                     			+'<SeriesInterpolate/>'
                 			+'</showDataEffect>'
            			+'</Line2DSeries>';
                                
			}
                        
			if(kind == '제품품질')
    		{
                            
            layoutStr +=
            					'<Column2DSeries yField="c_kind_7" displayName="제품품질불량률"  showValueLabels="[2]">'
									+'<fill>'
  										+'<SolidColor color="#0054FF"/>'
  	                     	     	+'</fill>'  
	  			                 	+'<showDataEffect>'
	 			                    	+'<SeriesInterpolate/>'
	  			                    +'</showDataEffect>'
  		                  		+'</Column2DSeries>'
                            +'</series>'
                        +'</Column2DSet>'
                        
                        
                      
                  		+'<Line2DSeries selectable="true" yField="kind_7" displayName="누적불량률(제품품질)" radius="4.5" itemRenderer="CircleItemRenderer">'
	  	                	+'<stroke>'
	  		           	    	+'<Stroke color="#5ddc96" weight="2"/>'
	  		           		+'</stroke>'
	  		           		+'<lineStroke>'
	  		                	+'<Stroke color="#5ddc96" weight="2"/>'
	  		            	+'</lineStroke>'
	               			+'<showDataEffect>'
	                  			+'<SeriesInterpolate/>'
	                  		+'</showDataEffect>'
               			+'</Line2DSeries>'
               
               			+'<Line2DSeries selectable="true" yField="goal_7" displayName="제품품질목표" radius="4.5" itemRenderer="CircleItemRenderer">'
	                 		+'<stroke>'
	                     		+'<Stroke color="#ffd736" weight="2"/>'
	                 		+'</stroke>'
	                		+'<lineStroke>'
	                     		+'<Stroke color="#ffd736" weight="2"/>'
	                 		+'</lineStroke>'
	             			+'<showDataEffect>'
	                			+'<SeriesInterpolate/>'
	                		+'</showDataEffect>'
             			+'</Line2DSeries>'
             
             
             			+'<Line2DSeries yField="acc_goal_7" fill="#ffffff" radius="5" displayName="누적목표(제품품질)" itemRenderer="CircleItemRenderer">'
              				+'<lineStroke>'
                      			+'<Stroke color="#fc4141" weight="2"/>'
                  			+'</lineStroke>'
                  			+'<verticalAxis>'
                  				+'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0" maximum = "'+maxVal+'"/>'
               				+'</verticalAxis>'
                 			+'<showDataEffect>'
                     			+'<SeriesInterpolate/>'
                 			+'</showDataEffect>'
            			+'</Line2DSeries>';
                                
			}
			
            layoutStr += 
					'</series>'
                    +'<verticalAxisRenderers>'
                    	+'<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
                        +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false">'
		                +'</Axis2DRenderer>'
					+'</verticalAxisRenderers>'
                     
                    +'<annotationElements>'
	                    +'<CrossRangeZoomer zoomType="horizontal" horizontalLabelFormatter="{numFmt}"    enableZooming="true" enableCrossHair="false">'
	                    +'</CrossRangeZoomer>'
                	+'</annotationElements>'
                	+'</Combination2DChart>'
              	+'</rMateChart>';
	}
	
	function getFormatDate(d) {
		var month = d.getMonth() + 1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		return d.getFullYear() + '-' + month + '-' + date;
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
	function excelFileDownload()
	{
		var gridCols = w2ui['grid_list_lt'].columns;
		var gridData = w2ui['grid_list_lt'].records;
	
		var nm = "품질실적정보_" + $("#idxMonth").html();
		
		
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
	
	function excelFileDownload2()
	{
		var gridCols = w2ui['grid_list_rt'].columns;
		var gridData = w2ui['grid_list_rt'].records;
	
		var nm = "품질실적정보_월별 상세";
		
		
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
	
	function excelFileDownload3()
	{
		var gridCols = w2ui['grid_list_md'].columns;
		var gridData = w2ui['grid_list_md'].records;
	
		var nm = "품질실적정보";
		
		
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
	
	function rowMerge(grid, start_row, start_col, merge_cnt)
	{
		$("#grid_"+grid+"_data_"+start_row+"_"+start_col).attr("rowspan", merge_cnt);
		for(var i=start_row+1 ; i<merge_cnt+start_row; i++)
		{
		   $("#grid_"+grid+"_data_"+i+"_"+start_col).addClass('hide');
		}
	}
	
	function changeGridUI()
	{
		rowMerge('grid_list_md',0,0,3);
		rowMerge('grid_list_md',3,0,3);
		rowMerge('grid_list_md',6,0,3);
		rowMerge('grid_list_md',9,0,3);
		rowMerge('grid_list_md',12,0,3);
		rowMerge('grid_list_md',15,0,3);
		
		$("#grid_grid_list_md_data_0_0").css("background-color","rgb(0 0 255 / 22%)");
		$("#grid_grid_list_md_data_3_0").css("background-color","rgb(255 0 0 / 12%)");
		$("#grid_grid_list_md_data_6_0").css("background-color","rgb(0 0 255 / 22%)");
		$("#grid_grid_list_md_data_9_0").css("background-color","rgb(255 0 0 / 12%)");
		$("#grid_grid_list_md_data_12_0").css("background-color","rgb(0 0 255 / 22%)");
		$("#grid_grid_list_md_data_15_0").css("background-color","rgb(255 0 0 / 12%)");
		
	}
</script>

</body>
</html>