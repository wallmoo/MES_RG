<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema"); // SessionUtil.java에 getProperties 메소드가 없음. 
String pageTitle = SessionUtil.getProperties("mes.company");
// String empNo= SessionUtil.getMemberEmpNo(request);
// String memberId= SessionUtil.getMemberId(request);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title><%=pageTitle %></title>
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
		<jsp:param name="selected_menu_p_cd" value="1012" />
		<jsp:param name="selected_menu_cd" value="1096" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			 KPI 목표관리(설비) <small> 기준정보관리 </small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>기준정보관리 </a></li>
			<li class="active">KPI 목표관리(설비)</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-md-12">
				
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
													
					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">대상제품</h3>
						<div class="box-tools pull-right" style="width: 60px;">
							<button type="button" id="" class="btn btn-success btn-sm btn-block" onclick="saveGoals();">저장</button>
						</div>
					</div>
				
					<div id="" class="box-body">	
					
<!-- 						<div class="row" style=""> form-group  margin-bottom: 10px; -->
<!-- 							<div class="col-sm-6"> -->
<!-- 								<h4 class="col-sm-2" style="margin: 0px; ">관리년도</h4> -->
<!-- 								<div class="col-sm-2" style="padding-right: 0px;"> -->
<!-- 									<select id="year" name="year" class="form-control input-sm s_cond" data-placeholder="Action 구분선택..." onClick="loadList();">							 -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
						
						<div class="col-sm-2">
										<div class="form-group">
											<label>관리년도</label> 
											<select id="year" name="year" class="form-control input-sm s_cond" data-placeholder="Action 구분선택..." onClick="loadList();">							
									</select>
										</div>
									</div>
						
						<div class="col-sm-2">
										<div class="form-group">
											<label>설비분류</label> 
											<select id="pn" name="pn"class="form-control" style="height: 30px;">

											</select>
										</div>
									</div>
									
									
					</div>
					
					<div class="box" style="border: 1px solid #DB8EB5;"></div> <!-- #DB8E85 -->
					
					<div id="" class="box-body">	
						<div class="row">
							<div class="col-sm-12" style=""> <!-- padding-left: 0px; padding-right: 0px; -->
								<div class="col-sm-5" style="">
									<div id="grid_list" style="width: 100%; height: 400px;"></div>
								</div>
								
								<div class="col-sm-7" style="padding-left: 0px;">
									<div id="itemGrid" style="width: 100%; height: 600px;"></div>
									<div id="itemGrid_tot" style="width: 100%; height: 80px;"></div>
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

<div class="modal fade" id="modal_c" aria-hidden="true" style="display: none; "> <!-- data-backdrop="static">  z-index: 1070; -->
	<div class="modal-dialog modal-lg" style="width: 50%;"> <!-- style="width: 100%;" -->
		<div class="modal-content">
			  	<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_c_title">주문등록</h4>
        	</div>
			<div class="modal-body" id="">
				
			
			<div class="form-group row">
					<div class="form-group">
						<label for="" class="col-sm-3 control-label">프로젝트명</label>
						<div class="col-sm-7">
						<input type="hidden" class="form-control input-sm" id="c_member_id" value="" >
						<input type="hidden" class="form-control input-sm" id="c_member_nm" value="" >
						<input type="text" class="form-control input-sm" id="c_project_nm" value="" >
						</div>
					</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-12">
					<div class="box-tools pull-right">
						<button type="button" id="" class="btn btn-success btn-sm" onclick="planLoadList();">조회</button>
					</div>
				</div>
			</div>
				<div class="row">
					<div class="col-md-12">
						<div id="planGrid" style="width: 100%; height: 300px;"></div>
					</div>
				</div>
				
				<div class="modal-footer">
					<div class="col-md-12 text-center">
						<button type="button" id="" class="btn btn-success btn-sm" onclick="savePrUserMt();">매칭</button>
						<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
					</div>
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

let myMap = new Map();

$(function($) {
	
	HashMap = function(){  
	    this.map = new Array();
	};
	
	HashMap.prototype = {  
	    put : function(key, value){  
	        this.map[key] = value;
	    },  
	    get : function(key){  
	        return this.map[key];
	    },  
	    getAll : function(){  
	        return this.map;
	    },  
	    clear : function(){  
	        this.map = new Array();
	    },  
	    getKeys : function(){  
	        var keys = new Array();  
	        for(i in this.map){  
	            keys.push(i);
	        }  
	        return keys;
	    }
	};

	var date = new Date();
	var currYear = date.getFullYear();

	$("#year").append("<option value='" +(currYear-2) +"'>" + (currYear-2) + "</option>");
	$("#year").append("<option value='" +(currYear-1) +"'>" + (currYear-1) + "</option>");
	$("#year").append("<option value='" +(currYear) +"'>" + currYear + "</option>");
	$("#year").append("<option value='" +(currYear+1) +"'>" + (currYear+1) + "</option>");
	//$("#year option:eq(2)").prop("selected", true);
	$("#year").val(currYear).prop("selected", true);
	
 	fnLoadCommonOption(); 	 
 
 	loadLeftGrid();
 	loadRightGrid();
 	w2ui.itemGrid.recordHeight = 45;
	//requestSelectItem();
	loadRightGrid_tot();
	fnCdD('pn', 'MC1021');
	loadList();
	
	var machine_class_code = $("#pn option:selected").val();
	requestGoalAll(machine_class_code);

})

$("#year").change(function(){
		
	var val = $("#year option:selected").val(); // text();	

	
	requestGoal();
	requestGoalAll();
});

// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 
 		
 	var minDate = getFormatDate(new Date());
	
 	
 	var year = minDate.split('-');
	$("#year").val(year).attr('selected', true);
}
 

// loadLeftGrid
function loadLeftGrid(){
// 	 console.log('fnSetLoadWorkerGrid()');
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        recordHeight : 35,
        show: {
        	selectColumn: true, 
        	lineNumbers : true, 
            footer: true
        },
        multiSelect: false,
        columns: [    
              
			{ field:'machine_nm', caption:'설비명', size:'100%', style:'text-align:center', padding:'30px'}, 
			{ field:'machine_code', caption:'코드', size:'10%', style:'text-align:center', hidden : true},
			{ field:'machine_class_code', caption:'설비분류코드', size:'10%', style:'text-align:center', hidden : true}
		
			], 
		//sortData: [{field: 'nap_no', direction: 'ASC'}],
		records: [
				 	/* {recid: 1, name: '설비가동정보'},
					{recid: 2, name: '생산실적정보'},
					{recid: 3, name: '수리실적정보'},
					{recid: 4, name: '매출실적정보'},
					{recid: 5, name: '구매실적정보'}   */
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
// 				w2ui.itemGrid.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);

				// 오른쪽 그리드
				requestGoal(data.machine_code);
				
				grid_list_tot();
				
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui['itemGrid'].clear();		
				w2ui['itemGrid'].refresh();			

			}
		},
		onClick: function (event) {
// 		 	itemGrid(); // 클릭 이벤트
event.onComplete = function () {
loadLeftGrid();
				var key = w2ui.grid_list.getSelection();
				var keylen = key.length;
				if( keylen==0 ) {
					var machine_class_code = $("#pn option:selected").val();
					requestGoalAll(machine_class_code);
				}
}
		}
	});
// 	requestGoal();
}

function loadRightGrid(){
	console.log('itemGrid()');
	
	var rowArr = [];
	
	$('#itemGrid').w2grid({
		name : 'itemGrid',
		
		 show: {
				selectColumn: true, 
				lineNumbers : true,
	            footer: true,
	            recordHeight : 40,
	        },
	    multiSelect: false,
        
        columns: [{ field: 'recid', caption: 'No', size: '50%', sortable: false, attr: 'align=center', resizable: true, hidden : true},
                  { field: 'month', caption: '월', size: '50%', sortable: false, attr: 'align=center', resizable: true,
                	  render:function(record, index, col_index) {
    	                    var html = this.getCellValue(index, col_index);
    	  
    	                    return html + '월';
                  	  }
                  }, 
                  { 
                	field : 'goal',
  					caption : '목표량',
  					size : '50%',
  					sortable : false,
  					attr : 'align=center',
  					resizable : true,
  		
  					editable:{ type:"float"}
  	                , render:function(record, index, col_index) {
  	                    var html = this.getCellValue(index, col_index);
  	                
  	                    return html;
                	  }
                  },
                  /* ,
                  { 
                  	field : 'sales',
    					caption : '매출액',
    					size : '50%',
    					sortable : true,
    					attr : 'align=center',
    					resizable : true,
    					hidden : true,
    					editable:{ type:"int"}
    	                , render:function(record, index, col_index) {
    	                    var html = this.getCellValue(index, col_index);
    	                    console.log("html : " + html);
    	                    return html;
                  	  }
                    } */
                    { field: 'updater', caption: '수정자', size: '30%', sortable: false, attr: 'align=center', resizable: true},
                    { field: 'date_updated', caption: '수정일자', size: '50%', sortable: false, attr: 'align=center', resizable: true}
                 ],
		records: [ 
		        /*    {recid: 1, month: '1'},
		          {recid: 2, month: '2'},
		          {recid: 3, month: '3'},
		          {recid: 4, month: '4'},
		          {recid: 5, month: '5'},
		          {recid: 6, month: '6'},
		          {recid: 7, month: '7'},
		          {recid: 8, month: '8'},
		          {recid: 9, month: '9'},
		          {recid: 10, month: '10'},
		          {recid: 11, month: '11'},
		          {recid: 12, month: '12'} */
		   ],
		total : 0,
		recordHeight : 30,
		onChange: function(event) {

			event.onComplete = function() {
				
				w2ui.itemGrid.save();
				    
				
				if( event.column == 2 ) {
					 var selListV = w2ui['itemGrid'].getCellValue(event.recid-1, event.column);	
					 if(selListV.length == 0 ) {
						 selListV = 0;
						 w2ui.itemGrid.set( event.recid , {'goal' : 0 });
					}
					 
					var month = w2ui['itemGrid'].getCellValue(event.recid-1, 1); 
					 
					// 값 설정
					myMap.set(month, selListV );
						
				}
				
				grid_list_tot();
				
			}
		}
	        
    }); 
	
}

function loadRightGrid_tot(){
	console.log('loadRightGrid_tot()');
	
	var rowArr = [];
	
	$('#itemGrid_tot').w2grid({
		name : 'itemGrid_tot',
		
		 show: {
				selectColumn: true, 
				lineNumbers : true,
	            footer: true,
	        },
	    multiSelect: false,
        
        columns: [
					{ field: 'recid', caption: '', size: '50%', sortable: false, attr: 'align=center', resizable: true, hidden : true
					},
                  { field: 'month', caption: '', size: '50%', sortable: false, attr: 'align=center', resizable: true}, 
                  { 
                	field : 'goal_tot',
  					caption : '평균',
  					size : '50%',
  					sortable : false,
  					attr : 'align=center',
  					resizable : true,
  		
  					render:function(record, index, col_index) {
  	                    var html = this.getCellValue(index, col_index);
  	                
  	                    return html;
                	  }
                  }
		   ],
		total : 0,
		onChange: function(event) {}
	        
    }); 
	
	w2ui['itemGrid_tot'].add([
		          			 { recid:'g1', goal_tot : '' }
		          	     ]);
	
}

function grid_list_tot()
{
	
	setTimeout(function(){
	      w2ui['itemGrid_tot'].resize();
	      w2ui['itemGrid_tot'].refresh();

	   }, 200);
	
	var rowArr3 = w2ui['itemGrid'].records; 
	
	var goal_tot = 0;	
	
	currentRecid = Number(i) + 1;
	

	for(var i = 0; i < rowArr3.length; i ++)
	{
		var data = rowArr3[i];
		
		console.log("00000000000000000000");
 		
		goal_tot = goal_tot + parseFloat(data.goal);
	}
	
	console.log('goal_tot : ' + goal_tot);
	
	goal_tot = w2utils.formatters['number']((goal_tot/12).toFixed(2)) ;
		               	
	w2ui['itemGrid_tot'].set('g1',{ goal_tot : goal_tot});
	
}

$("#pn").change(function() {
	

	
	var machine_class_code = $("#pn option:selected").val();
	
	var key = w2ui.grid_list.getSelection();
	var chkLen = key.length;
	var data = w2ui.grid_list.get(key[0]);
	
	loadList();
	if( chkLen==0 ) {
		
		requestGoalAll(machine_class_code);
	}else{
		requestGoal(data.machine_code);
	}
	
	
	
	loadRightGrid();
	loadRightGrid_tot();

});

function fnCdD(val, val2) {
	console.log("fnCdD(" + val + ")");

	//initOptions($('#'+val)); // select 박스 초기화

	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent(val2);

	$
			.ajax({
				url : strUrl,
				type : "POST",
				data : postData,
				dataType : 'json',
				async : false, // 다 끝나고 다음 처리 해!
				success : function(data, textStatus, jqXHR) {
					//	 	    	console.log("(data.rows).length = " + (data.rows).length);
					if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
						rowArr = data.rows;

						//$("#" + val).append("<option value="+''+">" + "전체"+ "</option>");

						$.each(rowArr, function(idx, row) {
							if (val == "pn") {
								$("#" + val).append("<option value=" + row.detail_code + ">"+ row.code_nm+ "</option>");
							}
						});

						$("#" + val + " option:eq(0)").prop("selected",
								true);
						$("#machine_nm option:eq(0)").prop("selected",
								true);
						$("#machine_nm").attr("disabled", true);
					}

				},
				error : function(jqXHR, textStatus, errorThrown) {
					//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
				},
				complete : function() {
					// 		    	fnMachine();
				}
			});

}

var mcArr = new Array();

function loadList(){
	
	var machine_class_code = $("#pn option:selected").val();
	
	var pageUrl = "/info/machine/selectMachine";
	var postData = "machine_class_code=" + encodeURIComponent(machine_class_code);
	
	//w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		async : false,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				console.log("rowArr.length::::"+rowArr.length)
				
				mcArr=[];
				for(var i = 0; i < rowArr.length; i ++){
					console.log("rowArr[i].code::::"+rowArr[i].machine_code);
					
					var mc = rowArr[i].machine_code
					console.log("mc::"+mc);
					mcArr.push(mc);
				}
				console.log("mcArr:::::"+mcArr[0])

				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					row.machine_nm = row.machine_nm + '(' + row.machine_code + ')';
				});
				
				w2ui['grid_list'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			
			try{
				//w2ui['grid_list2'].clear();
			}catch(e)
			{
				
			}
			
		},complete: function () {
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		}
	});
}


function requestGoal()
{	console.log("requestGoal();")
//	var machine_class_code = $("#pn option:selected").val();
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
//		requestGoalAll(machine_class_code);
	}  else {

		var row = w2ui.grid_list.get(selIdxArr[0]);

		var year = $('#year option:selected').val();	
		var code = row.machine_code;

		var page_url = "/info/goal/selectGoalMachine";
		var postData = "code=" + encodeURIComponent(code);
		postData = postData + "&year=" + encodeURIComponent(year);
		

		
		//w2ui['itemGrid'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			data : postData,
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					
					
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
					});
					w2ui['itemGrid'].records = rowArr;
				} else {
					w2ui.itemGrid.clear();
				}
				w2ui['itemGrid'].refresh();
				w2ui['itemGrid'].unlock();
				
	
			},complete: function () {
				grid_list_tot();
			}
		});
	}
}

function requestGoalAll()
{   console.log("requestGoalAll();")
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen!=0 ) {
	}  else {

		var row = w2ui.grid_list.get(selIdxArr[0]);
		
		var master_code = $('#pn option:selected').val();
		var year = $('#year option:selected').val();	

		var page_url = "/info/goal/selectGoalMachineAll";
		var postData = "master_code=" + encodeURIComponent(master_code);
		postData = postData + "&year=" + encodeURIComponent(year);
		

		
		//w2ui['itemGrid'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			data : postData,
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;
					
					
					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						row.month = idx+1;
					});
					w2ui['itemGrid'].records = rowArr;
				} else {
					w2ui.itemGrid.clear();
				}
				w2ui['itemGrid'].refresh();
				w2ui['itemGrid'].unlock();
				
	
			},complete: function () {
				grid_list_tot();
			}
		});
	}
}




function company_search()
{
	console.log('company_search()');

	fnInsert2();
}


function moveToOrderList()
{
	console.log('moveToOrderList()');
	openOrderModal();
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



function saveGoals()
{
	
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		
		for(var i = 0; i < mcArr.length; i ++){
			console.log("mcArr[i]::::"+mcArr[i]);
			var code = mcArr[i];

			myMap.forEach(function(value, key) {
				
				console.log("foreach시작")
				  console.log(key + ' = ' + value)
				  saveGoal(code,key,value);
				})
		}
		
		
		
	}  
	else {
		var row = w2ui.grid_list.get(selIdxArr[0]);
		var code = row.machine_code;
		
		
		/* for (let [key, value] of myMap) {
			  console.log(key + ' = ' + value)
			  saveGoal(code,key,value);
		} */
		myMap.forEach(function(value, key) {
			console.log("foreach시작")
			  console.log(key + ' = ' + value)
			  saveGoal(code,key,value);
			})
    
	}

}

function saveGoalsAll()
{

		for(var i = 0; i < mcArr.length; i ++){
			console.log("mcArr[i]::::"+mcArr[i]);
			var code = mcArr[i];

			myMap.forEach(function(value, key) {
				
				console.log("foreach시작")
				  console.log(key + ' = ' + value)
				  saveGoal(code,key,value);
				})
		}
}

function isEmpty(str){
    
    if(typeof str == "undefined" || str == null)
        return true;
    else
        return false ;
}

//----------------------------------------------------------------------------------------
// 저장
function saveGoal(code, month, goal/* , sales */) {
	console.log('saveGoal()');

	var year = $('#year option:selected').val();	
	var master_code =  $('#pn option:selected').val();

	console.log('year : ' +year);
	var postData = '';

	var page_url  = "/info/goal/saveGoalMachine";
	
	postData += "&master_code=" +  encodeURIComponent(master_code);
	postData += "&code=" +  encodeURIComponent(code);
	postData += "&year=" +  encodeURIComponent(year);
	postData += "&month=" +  encodeURIComponent(month);
	if(!isEmpty(goal)){
		postData += "&goal=" +  encodeURIComponent(goal);
	}
	/* if(!isEmpty(sales)){
		console.log('T1 sales : '  + sales);
		postData += "&sales=" +  encodeURIComponent(sales);
	} */

	
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data: postData,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
		    	requestGoal();
		    	myMap.clear();
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
	    },
	    complete: function() {
	    }
	});
} 

</script>

</body>
</html>