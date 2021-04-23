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
</head>


<body class="hold-transition skin-<%= thema %> sidebar-mini"><!-- <.%=thema%.> -->
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1012" />
		<jsp:param name="selected_menu_cd" value="1025" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			품질 검사 항목 관리 <small> 기준정보관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 기준정보관리</a></li>
			<li class="active">품질 검사 항목 관리</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box" style="margin-bottom:0px; border: none;">
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
									<div class="col-sm-4">
										<div class="row">
											<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border" style=" background-color: #DB8EB5;">
													<h3 class="box-title">검사그룹</h3>
													<div class="box-tools pull-right">
														<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-primary btn-sm" onclick="">그룹추가</button>
														<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
													</div>
												</div>
												<div class="box-body">
													<div class="row">
													
													
														<div class="col-sm-4">
																 <label>Business</label>
																 <select id="business" name="business" class="form-control" style="height: 30px;" >
																 	<option value="ALL" selected="selected">전체</option> 
																 	<option value="business1">business1</option>
																 	<option value="business2">business2</option>
																 	<option value="business3">business3</option>
																 </select>
														</div>
														
														<div class="col-sm-4">
														  <label>검사구분</label> 
														  <input type="text" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="검사구분" maxlength="30">
														</div>
														
														<div class="col-sm-4">
														  <label>그룹명</label> 
														  <input type="text" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="그룹명" maxlength="30">
														</div>
														
														
													</div>
													<div id="grid_list" class="w2g-h200" style="margin-top: 10px;"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
												<div class="box-header with-border" style=" background-color: #DB8EB5;">
													<h3 class="box-title">검사자재</h3>
													<div class="box-tools pull-right">
														<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-primary btn-sm" onclick="">자재정보검색</button>
														<button type="button" id="btn_del_csr" onclick="delItem();" class="btn btn-primary btn-sm" onclick="">검사그룹매칭</button>	 
													</div>
												</div>
												<div class="box-body">
													<div id="grid_list2" class="w2g-h250"></div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-sm-8">
										
										<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
											<div class="box-header with-border" style=" background-color: #DB8EB5;">
												<h3 class="box-title">검사 항목 관리</h3>
												<div class="box-tools pull-right">
													<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-primary btn-sm" onclick="">추가</button>
													<button type="button" id="btn_ins_csr" onclick="insItem();" class="btn btn-danger btn-sm" onclick="">삭제</button> 
												</div>
											</div>
											<div class="box-body">
												<div id="grid_list3" class="w2g-h600"></div>
											</div>
										</div>
									</div>
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

<!-- 모달 커팅 -->


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
$(function($) {
	
 	loadLeftGrid();
 	loadRightGrid();
})

// loadLeftGrid
function loadLeftGrid(){
// 	 console.log('fnSetLoadWorkerGrid()');
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'r_gr_code', caption:'그룹코드', size:'35%', style:'text-align:center'}, 
			{ field:'r_gr_rel', caption:'구분', style:'text-align:center'},
			{ field:'r_gr_name', caption:'그룹명', style:'text-align:center'}
		
			], 
		sortData: [{field: 'mt_name', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				//w2ui.grid_list3.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list3'].refresh();
				
				console.log("matnr : " + data.matnr);
				// 오른쪽 그리드
				requestItemName(data.matnr);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list3'].clear();		
				w2ui['grid_list3'].refresh();
			}
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
	

	$('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
			lineNumbers : true,
			selectColumn: true,
            footer: true
        },
        multiSelect: true,
        columns: [
			{ field:'product_code', caption:'자재코드', style:'text-align:center'}, 
			{ field:'product_name', caption:'자재명', style:'text-align:center'}, 
			{ field:'spec', caption:'자재유형', style:'text-align:center'}
		
			], 
		sortData: [{field: 'mt_type', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
				//w2ui.grid_list3.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
				w2ui['grid_list3'].refresh();
				
				console.log("matnr : " + data.matnr);
				// 오른쪽 그리드
				requestItemName(data.matnr);
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['grid_list3'].clear();		
				w2ui['grid_list3'].refresh();
			}
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
}



function loadRightGrid(){
	var rowArr = [];
	
	$('#grid_list3').w2grid({
		name : 'grid_list3',
		 show: {
				lineNumbers : true,
	            footer: true,
	            selectColumn : true
	        },
	    multiSelect: true,
        
        columns: [
        			{ field:'product_name', caption:'구분', style:'text-align:center'},
        			{ field:'product_code', caption:'검사 항목', style:'text-align:center'},
        			{ field:'MainSub', caption:'검사 기준/대상', style:'text-align:center'},
        			{ field:'modifier', caption:'최소값', style:'text-align:center'},
        			{ field:'cre_date', caption:'최대값', style:'text-align:center'},
        			{ field:'SKIP', caption:'검사방법', style:'text-align:center'}
                 ],
		records: [  
		   ],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},

		onClick: function (event) {
		
		}, 
		onDblClick: function(event) {
			
		},onChange: function(event){
			console.log("onChange");
			event.onComplete = function() {
				console.log("onChange onComplete");
				// 이벤트 전체
				console.log(event);
				
				// 오브젝트
			    console.log(event.value_new);		
				console.log("event.column : " + event.column);	     
			    console.log(event.value_new.text);
			    
			   	//var rowData = w2ui.grid_list3.records[recid];	
			 	// console.log("rowData.item_name : " + rowData.item_name); 
				//w2ui['grid_list'].refresh();
			}
		}, 
		
		
    }); 
	
}

</script>

</body>
</html>