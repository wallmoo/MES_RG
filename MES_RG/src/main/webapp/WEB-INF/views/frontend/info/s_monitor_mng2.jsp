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
		<jsp:param name="selected_menu_p_cd" value="1042" />
		<jsp:param name="selected_menu_cd" value="1094" />
	</jsp:include>

<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>	

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      설비가동현황 모니터링
        <small>생산관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>생산관리</a></li><li class="active">설비가동현황 모니터링</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">일간설비 가동현황 조회</h3>
						<div class="box-tools pull-right">
					     	<button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="detailModal();">실적상세보기</button>
							<button type="button" id="btn_search_csr" onclick="loadData();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->	 
							
						</div>
					</div>
					<div id="" class="box-body">
				<!-- 		<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
								<label>From Date</label>
								<div class="input-group">
									<input type="text" 
										class="form-control pull-right input-sm" style="" id="from_monitor_date" >
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
								</div>
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
								<label>To Date</label>
								<div class="input-group">
									<input type="text" 
										class="form-control pull-right input-sm" style="" id="to_monitor_date">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
								</div>
								</div>
							</div>
						</div> -->
					
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
	<div class="modal-dialog modal-md" style="width:50%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">생산진행현황 상세보기</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<div class="row">
					<div class="col-md-12">
						<div id="modalGrid" style="width: 100%; height: 400px;" ></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
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
comboValue_nm1 = new Array;
comboValue_nm2 = new Array;

$(function($) {
	tab_grid();
	
	fnLoadCommonOption(); 	 

 	init_grid_list();
 	init_grid_list2();

 	loadList_Waiting();
 	loadList_detail();
 
})
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 		
 		var minDate = getFormatDate(new Date());
 		$('#from_monitor_date').daterangepicker(
				{
					opens : 'right',
					singleDatePicker : true,
				     timePicker: true,
				      timePicker24Hour:true,
					locale : {
						format : 'YYYY-MM-DD HH:mm', //'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
						showMonthAfterYear : true,
						yearSuffix : '년',
						orientation : "top left"
					},
						startDate : moment(minDate).format('YYYY-MM-DD 08:30')
					
				});
 		
 		$('#to_monitor_date').daterangepicker(
				{
					opens : 'right',
					singleDatePicker : true,
				     timePicker: true,
				      timePicker24Hour:true,
					locale : {
						format : 'YYYY-MM-DD HH:mm', //'YYYY-MM-DD', // inputbox 에 '2011-04-29' 로표시
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
						showMonthAfterYear : true,
						yearSuffix : '년',
						orientation : "top left"
					},
						startDate : moment(minDate).format('YYYY-MM-DD 17:30')
					
				});
		
	
}
var tab_flag = 'tab1'   // tab1 , tab2
//tab설정
function tab_grid(){
	$('#tabs').w2tabs({
        name: 'tabs',
        active: 'tab1',
        tabs: [
            { id: 'tab1', text: '대기중', style: "background-color: #8bcb77;"  },
            { id: 'tab2', text: '가동중', style: 'background-color:' },
 
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
	            	
	            	tab_flag = 'A';
	            	
	            	
	       			w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });
	
	   
	       			loadList_Waiting();
	   
	        	}else if(event.target == 'tab2')
	        	{
	        		tab_flag = 'B';
	
	      			w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });
	      			

	 				
	 				loadList_Operation();
	       		}
				
	   			w2ui['tabs'].refresh();
        }
    });
}

function tabGridLoad(){
	
	deleteItems = new Array;
	
	if( tab_flag == 'A' ) {
		console.log("loadList_tab1");
		loadList_Waiting();
	}else if ( tab_flag == 'B' ){	
		console.log("loadList_tab2");
		loadList_Operation();	
	}
}



function init_grid_list(){
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        recordHeight : 22,
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [                

			{ field:'machine_code', caption:'설비코드', size:'8%', style:'text-align:center'}, 
			{ field:'machine_nm', caption:'설비명', size:'12%', style:'text-align:center',}, 
			{ field:'current_status', caption:'진행현황', size:'10%', style:'text-align:center'
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
					
					if(html == 'WAIT')
					{
						return '대기중';
					}else if(html == 'ING')
					{
						return '가동중';
					}else {
						return html;
					}
		   
		           } 
			}, 
			{ field:'item_code', caption:'진행중 P/N', size:'20%', style:'text-align:center'}, 
			{ field:'item_nm', caption:'진행중 품명', size:'20%', style:'text-align:center'}, 
			{ field:'prod_menge', caption:'일 생산수량', size:'10%', style:'text-align:center'}, 
			{ field:'prod_fail_menge', caption:'일 불량수량', size:'10%', style:'text-align:center'},
		
			{ field:'prod_per', caption:'가동률', size:'10%', style:'text-align:center'
				,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);
		               try{
		            		
		            	  	var all_time = w2ui.grid_list.records[index].all_time; 
		               	   	var prod_time = w2ui.grid_list.records[index].prod_time; 
		               	   	
		               	   	console.log('all_time : ' + all_time);
		            	   	console.log('prod_time : ' + prod_time);
		               	 	if(prod_time == '' || prod_time == 'null' || prod_time == null)
		            		{
		            		   return '';
		            		}
		               	 	//if(Number(prod_time) > Number(all_time))
		               	 	//{
		               	 	//	all_time = prod_time;
		               	 	//}
		               	 
		             	  	html = Number(prod_time) / Number(all_time) * 100;
		             	  
		             	  	html = Number(html).toFixed(2);
		                  	return html+'%';
		               }catch(e)
		               {
		            	   
		               }
		   
		           } 
			},
			{ field:'all_time_f', caption:'총 가동시간', size:'10%', style:'text-align:center'}, 
			{ field:'prod_time_f', caption:'작업시간', size:'10%', style:'text-align:center'},
			{ field:'prod_time', caption:'가동시간', size:'10%', style:'text-align:center', hidden : true}, 
			{ field:'process_time', caption:'작업시간', size:'10%', style:'text-align:center',  hidden : true}, 
			{ field:'all_time', caption:'총가동시간', size:'10%', style:'text-align:center',  hidden : true}, 
			], 
		records: [
		
		],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});

}

function init_grid_list2(){
	var rowArr = [];
	
	$('#modalGrid').w2grid({ 
        name: 'modalGrid',
        show: {
        	selectColumn: true,
			lineNumbers : true,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'idx', caption:'idx', size:'10%', style:'text-align:center', hidden : true },
			
			{ field:'item_code', caption:'P/N', size:'20%', style:'text-align:center'}, // 80px
			{ field:'member_nm', caption:'작업자', size:'10%', style:'text-align:center'}, // 200px
			{ field:'prod_str_time', caption:'작업 시작', size:'10%', style:'text-align:center'}, // 120px
			{ field:'prod_end_time', caption:'작업 종료', size:'10%', style:'text-align:center'}, // 120px
			{ field:'prod_menge', caption:'생산 수량', size:'10%', style:'text-align:center'}, // 120px
			{ field:'prod_fail_menge', caption:'불량 수량', size:'12%', style:'text-align:center'}, // 120px
			{ field:'un_process_time_f', caption:'비가동시간', size:'10%', style:'text-align:center'}
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

//실적 상세보기
function detailModal() {
	console.log('detailModal()');
	
	w2ui['modalGrid'].clear();
	w2ui['modalGrid'].refresh();

	
 	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	 if( key.length==1 ) {
		 
		 
		 loadList_detail();
		$("#modal_info").modal('show');
	}else {
		fnMessageModalAlert("알림", "실적을 볼 항목을 선택 해주세요.");
	}
}




var curFile = null;
function loadData()
{
	console.log('loadData()');
    if(tab_flag == 'tab1')
	{
		
		w2ui['tabs'].set('tab1' ,  { style: "background-color: #8bcb77;"  });

		
		loadList_Waiting();

	}else if(event.tab_flag == 'tab2')
	{

		w2ui['tabs'].set('tab2' ,  { style: "background-color: #8bcb77;"  });

		
		
		loadList_Operation();
	}
}

function chgEindt()
{
	console.log('chgEindt()');
	loadList();
}
//조회
function loadList_Waiting()
{
	console.log('loadList_Waiting()');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var machine_code = w2ui["grid_list"].records.machine_code;
	
	
	var page_url = "/frontend/consumable/selectWaiting";
	
	//var postData = "machine_code=" + encodeURIComponent(machine_code);
	
	try{
		
		w2ui.grid_list.selectNone();
		//w2ui['grid_list'].lock('loading...', true);
	}catch(e)
	{
		
	}
	
	$.ajax({
		url : page_url,
		type : 'POST',
		//data : postData, 
		dataType : 'json',
		async : false,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
				});
				
				w2ui['grid_list'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			

		},complete: function () {
		}
	});
}
function loadList_Operation()
{
	console.log('loadList_Operation()');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var page_url = "/frontend/consumable/selectOperation";
	
	//var postData = "machine_code=" + encodeURIComponent(machine_code);
	
	try{
		
		w2ui.grid_list.selectNone();
		//w2ui['grid_list'].lock('loading...', true);
	}catch(e)
	{
		
	}
	
	$.ajax({
		url : page_url,
		type : 'POST',
		//data : postData, 
		dataType : 'json',
		async : false,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
				});
				
				w2ui['grid_list'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			

		},complete: function () {
		}
	});
}



function loadList_detail()
{
	console.log('loadList_detail()');
	
	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	
	var machine_code = data.machine_code;
	
	
	var page_url = "/frontend/consumable/selectInfo";
	
	var postData = "machine_code=" + encodeURIComponent(machine_code);
	
	try{
		
		w2ui.modalGrid.selectNone();
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
					
				});
				
				w2ui['modalGrid'].records = rowArr;
			
			
			}else
			{
				w2ui['modalGrid'].clear();
				
			}
			setTimeout(function(){
			      w2ui['modalGrid'].resize();
			      w2ui['modalGrid'].refresh();

			   }, 200);
		
			w2ui['modalGrid'].unlock();
			

		},complete: function () {
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
	
	
</script>

</body>
</html>



//s_monitor_mng