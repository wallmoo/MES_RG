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
		<jsp:param name="selected_menu_cd" value="1098" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			 KPI 목표관리(구매) <small> 기준정보관리 </small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>기준정보관리 </a></li>
			<li class="active">KPI 목표관리(구매)</li>
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
						<div class="row" style=""> <!-- form-group  margin-bottom: 10px; -->
							<div class="col-sm-6">
								<h4 class="col-sm-2" style="margin: 0px; ">관리년도</h4>
								<div class="col-sm-2" style="padding-right: 0px;">
									<select id="year" name="year" class="form-control input-sm s_cond" data-placeholder="Action 구분선택..." onClick="loadList();">							
									</select>
								</div>
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
									<div class="col-sm-12" style="height:50px;">
										<div class="form-group">
											<label for="" class="col-sm-2 control-label">년 목표</label>
											<div class="col-sm-3">
												<input type="text" id="m_menge" name="m_menge" class="form-control input-sm"  style="IME-MODE:disabled;">
											</div>
											<div class="col-md-1 text-right">
												<div class="box-tools">
													<button type="button" id="btn_ins_csr" onclick="makeNum();" class="btn btn-primary btn-sm" >균등분할</button>
												</div>			
											</div>
										</div>
									</div>
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
	loadList();

})

$("#year").change(function(){
		
	var val = $("#year option:selected").val(); // text();	

	
	requestGoal();
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
              
			{ field:'account_nm', caption:'거래처명', size:'100%', style:'text-align:center', padding:'30px', hidden : true}, 
			{ field:'account_code', caption:'코드', size:'10%', style:'text-align:center', hidden : true},
			{ field:'flag', caption:'거래처명', size:'100%', style:'text-align:center', padding:'30px'
				
				,render: function (record, index, col_index) {
					var account_nm = w2ui.grid_list.records[index].account_nm;
					var html = this.getCellValue(index, col_index);

	                if(html == 'N')
	            	{
	            	   return account_nm;
	            	
	            	}else 
	            		if(html == 'Y')
	            	{
	            		 return '<div style="background-color:#c3fc93; height=20px;">'+account_nm+'</div>';
	            	}
	               return html;
	          	}
			}	
		
			], 
		//sortData: [{field: 'nap_no', direction: 'ASC'}],
		records: [
				 
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
// 				w2ui.itemGrid.recordHeight = 40;
				var key = w2ui.grid_list.getSelection();

				var data = w2ui.grid_list.get(key[0]);
				
			
				
				// 오른쪽 그리드
				requestGoal(data.account_code);
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
        
        columns: [
					{ field: 'recid', caption: 'No', size: '50%', sortable: false, attr: 'align=center', resizable: true, hidden : true},
                    { field: 'month', caption: '월', size: '50%', sortable: false, attr: 'align=center', resizable: true,
                	  render:function(record, index, col_index) {
    	                    var html = this.getCellValue(index, col_index);
    	  
    	                    return html + '월';
                  	  }
                    }, 
                    { field : 'goal',caption : '목표량',size : '50%',sortable : false,attr : 'align=center',resizable : true,
  					editable:{ type:"int"}
  	                , render:function(record, index, col_index) {
  	                    var html = this.getCellValue(index, col_index);
  	                
  	                    return html;
                	  }
                    },
                    { field: 'updater', caption: '수정자', size: '30%', sortable: false, attr: 'align=center', resizable: true},
                    { field: 'date_updated', caption: '수정일자', size: '50%', sortable: false, attr: 'align=center', resizable: true}
                 ],
		records: [ 

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
					 { field: 'month', caption: '', size: '50%', sortable: false, attr: 'align=center', resizable: true}, 
					 { field : 'goal_tot',
		  					caption : '합계',
		  					size : '50%',
		  					sortable : false,
		  					attr : 'align=center',
		  					resizable : true,
		  					 render:function(record, index, col_index) {
		  	                    var html = this.getCellValue(index, col_index);
		  	                
		  	                    return html;
		                	  }
		                  },
                  { field: 'month', caption: '', size: '80%', sortable: false, attr: 'align=center', resizable: true}, 
             
                  
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
	
	console.log("lenght?????" + rowArr3.length);

	for(var i = 0; i < rowArr3.length; i ++)
	{
		var data = rowArr3[i];
		
		console.log("00000000000000000000");
 		
		goal_tot = goal_tot + parseInt(data.goal);

	}
	
	console.log('goal_tot :  ' + goal_tot);
	
	goal_tot = w2utils.formatters['number'](goal_tot);
		               	
	w2ui['itemGrid_tot'].set('g1',{ goal_tot : goal_tot});
	
}

function makeNum(){
	
	console.log("makenum::::::")
	
		setTimeout(function(){
	      w2ui['itemGrid'].resize();
	      w2ui['itemGrid'].refresh();

	   }, 200);

	var goal = 0;	
	
	goal = $('#m_menge').val();
		
	
	console.log("goal::"+goal);
	goal = (Number(goal)/12).toFixed(0);  

	console.log("goal::"+goal);

	w2ui['itemGrid'].set('1',{ goal : goal});
	w2ui['itemGrid'].set('2',{ goal : goal});
	w2ui['itemGrid'].set('3',{ goal : goal});
	w2ui['itemGrid'].set('4',{ goal : goal});
	w2ui['itemGrid'].set('5',{ goal : goal});
	w2ui['itemGrid'].set('6',{ goal : goal});
	w2ui['itemGrid'].set('7',{ goal : goal});
	w2ui['itemGrid'].set('8',{ goal : goal});	
	w2ui['itemGrid'].set('9',{ goal : goal});
	w2ui['itemGrid'].set('10',{ goal : goal});
	w2ui['itemGrid'].set('11',{ goal : goal});
	w2ui['itemGrid'].set('12',{ goal : goal});
	
	for(var i = 1; i<=12; i++)
	{
		myMap.set(i, goal);
	}

 	grid_list_tot();
	
}

function loadList()
{
	
	var year = $('#year option:selected').val();
	var pageUrl = "/info/account/selectAccount";
	var postData = "year=" + encodeURIComponent(year)
	
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
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
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
			w2ui['grid_list'].sort('account_nm','asc');
		}
	});
}

function requestGoal()
{
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
	}  else {

		var row = w2ui.grid_list.get(selIdxArr[0]);

		var year = $('#year option:selected').val();	
		var code = row.account_code;

		var page_url = "/info/goal/selectGoalAccount";
		var postData = 
			  "code=" + encodeURIComponent(code);
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


function requestSelectItem(){
 	console.log('requestSelectItem()');

	var page_url = "/info/goal/selectItem";
	 var postData = "";

	 
	//w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data: postData,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['grid_list'].records = rowArr;
			} else if (data.status == 200 && (data.rows).length==0 ){
				w2ui['grid_list'].clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			w2ui['grid_list'].select(1);
			w2ui['grid_list'].refresh();
			
		},complete: function () {}
	}); 
}


function saveGoals()
{
	console.log("111111")
	var rowArr3 = w2ui['itemGrid'].records; 
	
	var goal_tot = 0;
	
	for(var i = 0; i < rowArr3.length; i ++)
	{
		var data = rowArr3[i];
		
		console.log("00000000000000000000");
 		
		goal_tot = goal_tot + parseInt(data.goal);

	}
	
	console.log("goal_tot::"+goal_tot) 
	
	if($('#m_menge').val()==""||$('#m_menge').val()==goal_tot){
	
	var selIdxArr = w2ui.grid_list.getSelection();
	var chkLen = selIdxArr.length;
	if( chkLen==0 ) {
		
	}  
	else {
		var row = w2ui.grid_list.get(selIdxArr[0]);
		var code = row.account_code;
		
		
		/* for (let [key, value] of myMap) {
			  console.log(key + ' = ' + value)
			  saveGoal(code,key,value);
		} */
		myMap.forEach(function(value, key) {
			  console.log(key + ' = ' + value)
			  saveGoal(code,key,value);
			})
    
	}
	
	}
	else if ($('#m_menge').val()!=goal_tot) {
				
		fnMessageModalAlert("알림", "년 목표금액과 합계금액이 일치하지않습니다");
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


	console.log('year : ' +year);
	var postData = '';

	var page_url  = "/info/goal/saveGoalAccount";

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