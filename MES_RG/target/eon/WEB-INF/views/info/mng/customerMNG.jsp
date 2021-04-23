<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
 //String thema = SessionUtil.getProperties("mes.thema"); // SessionUtil.java에 getProperties 메소드가 없음.
//String pageTitle = SessionUtil.getCompanyNm("mes.tbkimchi"); //.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title> <%-- <.%=pageTitle %.> --%>Set </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

	<jsp:include page="/common/header_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</head>


<body class="hold-transition skin-green-light sidebar-mini"><!-- <.%=thema%.> -->
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1021" />
		<jsp:param name="selected_menu_cd" value="1032" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			운임비 설정 <small> 주문 관리 </small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>운임비 설정 </a></li>
			<li class="active">주문 관리</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-md-12">
				<div class="box" style="margin-bottom:0px;">
					<div class="box-header with-border">
				
						<div class="form-group row">
						
							<div class="box-tools pull-right" style="padding-right: 30px;">
							
								<button type="button" id="" class="btn btn-success btn-sm" onclick="saveItems();">저장</button>
							</div>
						
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12" style="padding-left: 0px; padding-right: 0px;">
							
									<div class="col-sm-12" style="padding-left: 0px; margin-top: 0px;">
										
										<div id="itemGrid" style="width: 100%; height: 600px;"></div>
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
	
 	fnLoadCommonOption(); 	 
 
 	initGridList();

 	loadList();
 	
});


// init component
function fnLoadCommonOption() {
 	console.log('fnLoadCommonOption()');
 
 		
 	var minDate = getFormatDate(new Date());
		
 	console.log("minDate : " + minDate);
 	
 	var year = minDate.split('-');
	$("#year").val(year).attr('selected', true);
}
 

function initGridList(){
	console.log('itemGrid()');
	
	var rowArr = [];
	
	$('#itemGrid').w2grid({
		name : 'itemGrid',
		recordHeight : 40,
		 show: {
				lineNumbers : true,
	            footer: true
	        },
	    multiSelect: false,
        
        columns: [
               	{
					field : 'site_name',
					caption : '접수사이트',
					size : '10%',
					sortable : false,
					attr : 'align=center',
					resizable : true,
					/* editable:{ type:"list", items:site_group, showAll:true }
	                , render:function(record, index, col_index) {
	                    var html = this.getCellValue(index, col_index);
	                    console.log("html : " + html);
	                    return html;
	                } */
				}
                  , 
                  { 
                	field : 'price',
  					caption : '운임비',
  					size : '50%',
  					sortable : false,
  					attr : 'align=center',
  					resizable : true,
  					editable:{ type:"int"}
  	                , render:function(record, index, col_index) {
  	                    var html = this.getCellValue(index, col_index);
  	                    console.log("html : " + html);
  	                    return html;
                	  }
                  }
                 ],
		records: [ /* 
		           {recid: 1, site_name: '대한사이트', item_name: ''},
		          {recid: 2, site_name: '위메프', item_name: ''},
		          {recid: 3, site_name: '우체국', item_name: ''},
		          {recid: 4, site_name: 'CJ홈쇼핑', item_name: ''},
		          {recid: 5, site_name: '네이버쇼핑', item_name: ''} */
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

				w2ui.itemGrid.save();
				
				// 이벤트 전체
				console.log(event);
				
				console.log("event.column : " + event.column);
				console.log("event.recid : " + event.recid);			    
				
				if( event.column == 1 ) {
					 var selListV = w2ui['itemGrid'].getCellValue(event.recid-1, event.column);
					 console.log("selListV : " + selListV);	
					 if(selListV.length == 0 ) {
						 selListV = 0;
						 w2ui.itemGrid.set( event.recid , {'price' : 0 });
					 }
					 
					var site_name = w2ui['itemGrid'].getCellValue(event.recid-1, 0); 
					 
					// 값 설정
					myMap.set(site_name , selListV );
					
					console.log( "myMap" ); 
					console.log( myMap.keys() ); 
					console.log( myMap.values() ); 
					
				}
			}
		}, 
		
		
    }); 
	loadList();
}

function saveItems()
{

	/* for (let [key, value] of myMap) {
		  console.log(key + ' = ' + value)
		  saveItem(key,value);
	} */
	
	myMap.forEach(function(value, key) {
		  console.log(key + ' = ' + value)
		  saveItem(key,value);
		})
	
	 // 변경된 모든데이터 가져올거야
   /* 
	 var changeSize = w2ui['itemGrid'].getChanges().length;

    console.log("- changeSize : " + changeSize);

    for (var i = 0; i < changeSize; i++)
    {
    	var changeDatas = w2ui['itemGrid'].getChanges()[i];
    	console.log(changeDatas);
    
    	//w2ui.itemGrid.records[recid];
    	var recid = changeDatas["recid"];
    	var site_name = w2ui.itemGrid.get(recid).site_name;
		var price = changeDatas["price"];
		
		
    	console.log("site_name : " + site_name);
    	console.log("item_name : " + price);
		saveItem(site_name, price);
    } 
  */
	
}

function saveItem(site_name, price) {
 	console.log('saveItem()');
	var page_url = "/frontend/info/savePrice";
	var postData = "site_name=" + encodeURIComponent(site_name)
		+ "&price=" + encodeURIComponent(price); 
	
	$.ajax({
		url : page_url,
		type : 'POST',
		dataType : 'json',
		data: postData,
	    success:function(data, textStatus, jqXHR){
	    	if(data.status == "200") {
		    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
		    	loadList();
	    	}
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
	    },
	    complete: function() {
	    }
	}); 
}


function loadList(){
	console.log("loadList()");
	//var matnr = '';
	
	var page_url = "/frontend/info/selectSitePrice";


	w2ui['itemGrid'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
 	//	dataType : 'json',
 	//	data: postData,
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				
				console.log("######loadList_data");
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
				});
				w2ui['itemGrid'].records = rowArr;
			} else {
				w2ui['itemGrid'].clear();
			}

			w2ui['itemGrid'].refresh();
			w2ui['itemGrid'].unlock();
		},complete: function () {}
	});
	

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




</script>

</body>
</html>