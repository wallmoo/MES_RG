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
      <jsp:param name="selected_menu_cd" value="1059" />
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
                  <h3 class="box-title">설비 가동현황 조회</h3>
                  <div class="box-tools pull-right">
                       <!-- <button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="detailModal();">실적상세보기</button> -->
                     <button type="button" id="btn_search_csr" onclick="loadData();" class="btn btn-warning btn-sm">조회</button> 
                     
                  </div>
               </div>
               <div class="box-tools col-sm-12" style="margin-top:20px; margin-bottom:20px;">
					<div class ="box-body2">
						<div class="col-sm-10 pull-left">
							<button type="button" id="btn_search_csr" style="padding:10px; background-color:#000000; color:#ffffff;" onclick="modal_hold_all();" class="btn btn-sm">일괄 HOLD</button> 
							<button type="button" id="btn_search_csr" style="padding:10px; margin-left:5px;" onclick="holdAll_N();" class="btn btn-info btn-sm">일괄 HOLD 해제</button> 
						</div>
						<div class="col-sm-2 pull-right">
							<button type="button" 
							style="border:1px solid #9e9e9e; outline:0; padding:10px; background-color:#73dd5e;" disabled="disabled"><span>PROCESS</span></button>
							<button type="button" 
							style="border:1px solid #9e9e9e; outline:0; padding:10px; background-color:#6aa2ff; color:#ffffff;" disabled="disabled"><span>비가동</span></button>
							<button type="button" 
							style="border:1px solid #9e9e9e; outline:0; padding:10px; background-color:#ffd368;" disabled="disabled"><span>WAITING</span></button>
						</div>
					</div>
				</div>
               <div id="sulbi" class="box-body" style="margin-top:35px;">
               	  <div id="sulbiBox" class="col-lg-12">
	                  <!-- <table id ="sulbi_table" style="margin:auto;">
	                     <thead>
	                        <tr id="sulbi_tr">
	                          
	                        </tr>
	                     </thead>
	                  </table> -->
                  </div>
               </div>
               
               
               <div id="machine" class="box-body" style="margin-bottom:30px;">
                  <div id="machineBox" class="col-lg-12">
                  
                  
                  </div>
               </div>
               
            </div>
               
            
            
         </section>
      </div>
   </section>   
   
    <!-- /.content -->
  </div>

 
<div class="modal fade" id="modal_info" data-backdrop="static">
	<div class="modal-dialog modal-md" style="width:70%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">실적 상세보기</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">설비코드</label>
								<div class="col-sm-4">
									<input type="combo" id="m_machine_code" name="m_machine_code" class="form-control input-sm" placeholder="설비코드" >
								</div>
								<div class="col-sm-3">
									<button type="button" id="btn_search_csr" style="padding:10px 20px 10px 20px;  background-color:#000000; color:#ffffff;" onclick="modal_hold();" class="btn btn-danger btn-sm btn_hold">HOLD</button>
									<button type="button" id="btn_search_csr" style="padding:10px 20px 10px 20px;" onclick="changeHold_N();" class="btn btn-info btn-sm btn_hold_Y">HOLD 해제</button>
								</div>
							</div>
						</div>
					</div>
					
					
						<div class="col-sm-2"style ="display:none">
							<label>조회일자</label>
								<div class="input-group">
									 
									  <input type="text" id="work_end_time" name="work_end_time" class="form-control pull-right input-sm" " 
									onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
												<div class="input-group-addon">
													<i class="fa fa-calendar"></i>
												</div>
								</div>
						</div>
							
						<div class="col-sm-4">
							<div class="box-tools pull-right">
								<button type="button" id="btn_ins_csr" onclick="loadList()" class="btn btn-primary btn-sm" style="display: none;">조회</button>
													
							</div>			
						</div>
					
				
					<div class="row">
						<div class="col-md-12">
							<div id="modalGrid" style="width: 100%; height: 400px;" ></div>
							<div id="modalGrid2" style="width: 100%; height: 60px;" ></div>
						</div>
					</div>
						
					<div class="row">
						<div class="col-md-12" id="msg" style="font-weight:bold; color:blue;"></div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
<!-- 					<button type="button" id="" class="btn btn-success btn-sm" onclick="saveProcess();">저장</button> -->
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_hold" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">HOLD</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">HOLD 사유</label>
								<div class="col-sm-7">
									<input type="input" id="m_hold_comment" name="m_hold_comment" class="form-control input-sm">
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="changeHold_Y();">HOLD</button>
					<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_hold2" data-backdrop="static">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="modal_code_title">HOLD</h4>
        	</div>
			<div class="modal-body" id="modal_code_body">
				<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">HOLD 사유</label>
								<div class="col-sm-7">
									<input type="input" id="hold_comment" name="hold_comment" class="form-control input-sm">
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<div class="col-md-12 text-center">
					<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
					<button type="button" id="" class="btn btn-success btn-sm" onclick="holdAll_Y();">HOLD</button>
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
var addStageValue=0;

var machineCode = [];
$(function($) {
   
   requestMachine_class();
   //requestMachine_nm();
   fnLoadCommonOption();
   
   init_grid_list();
   init_grid_list2();
 
})

function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		
		$('#work_end_time').daterangepicker({
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
	
function loadData(){
	
	$("#sulbiBox").empty();
	$("#machineBox").empty();
	
	requestMachine_class();
}


 function requestMachine_nm(){    
   var pageUrl = "/info/machine/selectMachine_nm";
   
   for(var i=0; i < machineCode.length; i++){
      var postData = {
            machine_class_code : machineCode[i]
      };
      

      var div = $("<div>");
      div.addClass("col-sm-1 control-label machineReset");
      div.attr("id", "machin_table_nm_" + (i+1));
      
      
      var table  = $("<table>");
      table.attr("style", "width:100%; text-align:center; border:1px solid #bcbcbc;");
      
      var thead  = $("<thead>");
      
      $.ajax({
         url : pageUrl,
         type : "POST",
         data : postData,
         async : false, 
         dataType : 'json',
         success : function(data){
            if(data.status == 200 && (data.rows).length > 0){
              rowArr = data.rows;
              
               
              $("#machineBox").append( div.append(table.append(thead) ) );
               
              $.each(rowArr, function(idx, row){
//                  machineNm[idx]['n'+i] = row.machine_nm;
//                  machineNm[idx]['c'+i] = row.machine_code; 

				   
				   
				   var tr  = $("<tr>");
				   var td  = $("<td>");
				   
				   var divCd = $("<div>");
				   divCd.text(row.machine_code); //.addClass("col-sm-1 control-label")
				   divCd.addClass("hidden");
				   divCd.attr("id", "machine_code" + (i+1) + "_" + (idx+1));
				   
				   
	               var divNm = $("<div>");
	               divNm.text(row.machine_code);
	               divNm.addClass("machineClick");
	               divNm.attr("id", "machine_nm" + (i+1) + "_" + (idx+1));
	               divNm.attr(
	                        "style", "cursor:pointer; border-bottom: 1px solid #bcbcbc; padding:14px 0 14px; font-size:13px; font-weight:bold; margin:auto;"
	                     );	  
	               
	               console.log("row.status????" + row.status);
	               
	               if(row.status == 'n' || row.status == 'nh'){
	            	   console.log("대기중----------");
	            	   divNm.attr("style", "background-color: #ffd368; cursor:pointer; border-bottom: 1px solid #ffffff; padding:14px 0 14px; font-size:13px; font-weight:bold;");
	               }else if(row.status == 'i' || row.status == 'ue'){
	            	   console.log("가동중----------");
	            	   divNm.attr("style", "background-color: #73dd5e; cursor:pointer; border-bottom: 1px solid #ffffff; padding:14px 0 14px; font-size:13px; font-weight:bold;");
	               }else if(row.status == 'us'){
	            	   console.log("비가동중----------");
	            	   divNm.attr("style", "background-color: #6aa2ff; cursor:pointer; border-bottom: 1px solid #ffffff; color:#ffffff; padding:14px 0 14px; font-size:13px; font-weight:bold;");
	               }else{
	            	   console.log("없다----------");
	               }
	               
	               if(row.hold_yn == 'Y'){
	            	   console.log("비가동중----------");
	            	   divNm.attr("style", "background-color: #000000; cursor:pointer; border-bottom: 1px solid #ffffff; color:#ffffff; padding:14px 0 14px; font-size:13px; font-weight:bold;");
	               }else{
	            	   
	               }

            	  $("#machin_table_nm_"+ (i+1) +" thead").append( tr.append( td.append(divCd).append(divNm) ) );
			  });
               
            }
         }, complete : function(){
        	 
         }         
         
      });
   }   
   
} 
 
function requestMachineInfo(machine_code){    
 
	var pageUrl = "/info/machine/selectMachine_nm";
 
	 var postData = {
	            machine_code : machine_code
	      };

    $.ajax({
       url : pageUrl,
       type : "POST",
       data : postData,
       async : false, 
       dataType : 'json',
       success : function(data){
          if(data.status == 200 && (data.rows).length > 0){
        	  rowArr = data.rows;
        	  
        	  var hold_yn = rowArr[0].hold_yn;
        	  var status = rowArr[0].status;
        	  
        	  console.log("status??" + status);
        	  console.log("hold_yn??" + hold_yn);
        	  
        	  if( status == 'i' || status == 'ue' || status == 'h'){
        		  
        		  console.log("status 탔따요");
        		  
        		  if( hold_yn == 'N'){
        			  
        			  console.log("hold_yn_N 탔따요");
        			  $(".btn_hold").show();
        			  $(".btn_hold_Y").hide();
        			  
        		  }else if(hold_yn == 'Y'){
        			  console.log("hold_yn_Y 탔따요");
        			  $(".btn_hold_Y").show();
        			  $(".btn_hold").hide();
        			  
        		  }else{
        			  console.log("암것도 아니다");
        			  $(".btn_hold").hide();
        			  $(".btn_hold_Y").hide();
        			  
        		  }
        	  }else{
        		  $(".btn_hold").hide();
    			  $(".btn_hold_Y").hide();
        	  }
              
          }else{}
          
       }, complete : function(){
      	 
       }         
       
    });
}   
	   
	
 
// class 로 머신명 선택 이벤트
$(document).on("click", ".machineClick", function(){
// 	console.log(this);
// 	console.log( document.getElementById( $(this).attr('id').replace("nm", "code") ) );
	// 선택한 머신명 ID 
	let id = $(this).attr('id');
    let cdV = id.replace("nm", "code");
    requestMachineInfo($("#"+id).text());
	// 머신명
    console.log( $("#"+id).text() );
    // 머신코드
    console.log( $("#"+cdV).text() );
    
    setTimeout(function(){
	      w2ui['modalGrid2'].resize();
	      w2ui['modalGrid2'].refresh();
	      
	      w2ui['modalGrid'].resize();
	      w2ui['modalGrid'].refresh();
	   }, 200);
    
	/* $(".btn_hold").hide();    
	$(".btn_hold_Y").hide();  */
    
    $("#m_machine_code").val($("#"+cdV).text());
    $("#m_machine_code").attr('disabled', true);
	
	$("#modal_info").modal('show');
	$("#btn_ins_csr").trigger('click');
// 	console.log( document.getElementById( cdV ) );
    
 }); 

function requestMachine_class(){
   
   var pageUrl = "/info/machine/selectMachine_class";
   
   machineCode = [];
   
   $.ajax({
      url : pageUrl,
      type : "POST",
      //data : postData,
      dataType : 'json',
      success : function(data){
         if(data.status == 200 && (data.rows).length > 0){
            rowArr = data.rows;
            
            $.each(rowArr, function(idx, row){
               //row.recid = idx + 1;             
               machineCode.push(row.machine_class_code);
               
               var div = $("<div>");
               div.addClass("col-sm-1 control-label");
              // div.attr("style", "width:100%;");
               
               var table  = $("<table>");
               table.attr( "style", "width:100%; background-color:#6d69b8; color:#ffffff; text-align:center;");
               
               var thead  = $("<thead>");
               
               var td  = $("<td>");
                
               var divNm = $("<div>");
               divNm.text(row.machine_class_nm);//.addClass("col-sm-1 control-label")
               divNm.attr("id", "m_machine_class_nm" + (idx+1));
               divNm.attr(
                        "style", "padding:15px 0 15px 0; font-size:14px; font-weight:bold; background-color:#6d69b8; color:#ffffff;"
                     );
               $("#sulbiBox").append( div.append(table.append(thead.append(td.append(divNm)))) );
               //$("#sulbiBox").append( div.append(td.append(divNm) ) );
            });
            
         } else {
         }
      }, complete : function(){
         requestMachine_nm();
      }         
      
   });
}

function init_grid_list(){
	// 	 console.log(page_url);
	var rowArr = [];
	
	$('#modalGrid').w2grid({ 
        name: 'modalGrid',
        show: {
        	selectColumn: false,
			lineNumbers : false,
            footer: true
        },
        multiSelect: false,
        columns: [                
			{ field:'gb', caption:'EVENT', size:'12%', style:'text-align:center'
				 ,render: function (record, index, col_index) {
					var gb = this.getCellValue(index, col_index);
			
			       if(gb == 'PROCESS')
			   	{
			   	   return 'PROCESS';
			   	   
			   	}
			       else if (gb == 'UNPROCESS')
			   	{
			   		 return '비가동';
			   	}
			       else if(gb == 'WAITING')
			   	{
			   		 return 'WAITING';
			   	}   else if(gb == 'HOLD')
                {
                    return 'HOLD';
                }
			   	return html;
			   
			      }  
			}, 
			{ field:'routing_nm', caption:'공정명', size:'12%', style:'text-align:center'}, 	
			{ field:'machine_code', caption:'설비코드', size:'12%', style:'text-align:center', sortable: true },
			
			{ field:'work_str_time', caption:'시작', size:'20%', style:'text-align:center', sortable: true}, 
			{ field:'work_end_time', caption:'종료', size:'20%', style:'text-align:center', sortable: true}, 
			{ field:'work_time', caption:'시간', size:'20%', style:'text-align:center', sortable: true}, 
	      	{ field:'product_po', caption:'작업지시번호', size:'15%', style:'text-align:center', sortable: true},
			{ field:'item_code', caption:'P/N', size:'15%', style:'text-align:center', sortable: true}, 
			{ field:'item_nm', caption:'품명', size:'20%', style:'text-align:center', sortable: true}, 
			{ field:'prod_menge', caption:'생산수량', size:'8%', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);

	             	var gb = w2ui.modalGrid.records[index].gb; 
	             	
	             	if(gb == "WAITING" || gb == "UNPROCESS")
	             	{
	             		html = "";
	             	}
	             	
	                return html;
	              }	
			},
			{ field:'prod_fail_menge', caption:'불량수량', size:'8%', style:'text-align:center', sortable: true
	            	  ,render: function (record, index, col_index) {
	  	       	        var html = this.getCellValue(index, col_index);

						var gb = w2ui.modalGrid.records[index].gb; 
		             	
		             	if(gb == "WAITING" || gb == "UNPROCESS" )
		             	{
		             		html = "";
		             	}
	  	        
	  	              }
	              }
			], 
		records: [],	//
		onReload: function(event) {
			//loadList();
		},
		onClick: function (event) {}
	});
	//loadList();
}

function init_grid_list2(){
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#modalGrid2').w2grid({ 
	        name: 'modalGrid2',
	        show: {
	        	selectColumn: false,
				lineNumbers : false,
	            footer: false
	        },
	        multiSelect: false,
	        columns: [       
				{ field:'date', caption:'일자', size:'20%', style:'text-align:center'}, 
				{ field:'machine_code', caption:'설비코드', size:'12%', style:'text-align:center'}, 			
				{ field:'prod_menge_sum', caption:'생산수량', size:'15%', style:'text-align:center'}, 
				{ field:'prod_fail_menge_sum', caption:'불량수량', size:'15%', style:'text-align:center'}, 
				{ field:'per', caption:'가동률', size:'10%', style:'text-align:center'}, 
				{ field:'today_time_hour', caption:'총작업시간', size:'12%', style:'text-align:center'},
				{ field:'process_time_hour', caption:'PROCESS', size:'12%', style:'text-align:center'},
				{ field:'unprocess_time_hour', caption:'비가동', size:'12%', style:'text-align:center'},
				{ field:'waiting_time_hour', caption:'WAITING', size:'12%', style:'text-align:center'}
				], 
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		
}

function detailModal(){
	
	console.log("detailModal()");
	
	
}

var grapArr = new Array();
//모달조회
function loadList() {
		
		grapArr = new Array();
		 
		w2ui.modalGrid.clear();
		try{
		w2ui.modalGrid2.clear();
		}catch(e)
		{
			
		}
		
		chartData = new Array();
		
		var page_url = "/frontend/machine/selectProductOperStatus";
		
		var date = $("#work_end_time").val();
		var gb = $('#gb').val();
		var machine_code = $('#m_machine_code').val() || "";
		// product_po = $('#product_po').val() || "";
		var item_code = $('#item_code').val() || "";
		var item_nm = $('#item_nm').val() || "";
		
		var postData = {
				 work_str_time : date,
				 gb : gb,
				 machine_code : machine_code,
				// product_po : product_po, 
				 item_code : item_code,
				 item_nm : item_nm
			
		};
		
    
		w2ui['modalGrid'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length > 0){
					rowArr = data.rows;
					
					grapArr = new Array();
					
					var prevDate = '';
		
					var grap_process = 0;
					var grap_unprocess = 0;
					var grap_waiting = 0;
					
					$.each(rowArr, function(idx, row){
						row.recid = idx + 1;

				
					});
					
					
					w2ui['modalGrid'].records = rowArr;
					
					var date =  $("#work_end_time").val();
					
					var date_split = date.split(" ");
					
					var date_single = date_split[0];
					
					
					var machine_code = $('#m_machine_code').val() || "";	
					var prod_menge_sum =  rowArr[0].prod_menge_sum;
					var prod_fail_menge_sum =  rowArr[0].prod_fail_menge_sum;
					
					var process_time_s = rowArr[0].process_time_s;
					var today_time_s =  rowArr[0].today_time_s;
					
					var today_time_hour = rowArr[0].today_time_hour;
					var process_time_hour = rowArr[0].process_time_hour;
					var unprocess_time_hour = rowArr[0].unprocess_time_hour;
					var waiting_time_hour = rowArr[0].waiting_time_hour;
					
					var per = ( Number(process_time_s) / Number(today_time_s) ) * 100; 
					per = per.toFixed(2)+ '%';
					w2ui['modalGrid2'].clear();
					w2ui['modalGrid2'].add([{
						recid : 1,
						date : date_single, 
						machine_code : machine_code, 
						prod_menge_sum : prod_menge_sum, 
						prod_fail_menge_sum : prod_fail_menge_sum,
						per : per, 
						today_time_hour : today_time_hour, 
						process_time_hour : process_time_hour,
						unprocess_time_hour : unprocess_time_hour,
						waiting_time_hour : waiting_time_hour
		
					
					}]);
			
					w2ui['modalGrid2'].save();
					w2ui['modalGrid2'].refresh();

				} else {
					w2ui['modalGrid'].clear();
					
					var b = [];
					//document.getElementById("chart1").setData(b);
					w2ui['modalGrid'].unlock();
					//makeLayout();
					fnLoadChart(new Array());
					rMateChartH5.call("chart1", "hasNoData", true);					
				}
				
				w2ui['modalGrid'].refresh();
				w2ui['modalGrid'].unlock();
				
				
				
				
			}, complete : function(){
				
				w2ui['modalGrid'].refresh();
				w2ui['modalGrid'].unlock();
				//loadList2();
			}			
			
		});
		
	}
	
function loadList2() {
	
	w2ui.grid_list2.clear();
	w2ui['grid_list2'].refresh();
	var page_url = "/frontend/machine/selectProductOperStatus_2";
	
	var date = $("#work_end_time").val();
	var origin_end_time = $("#origin_end_time").val();
	var gb = $('#gb').val();
	var machine_code = $('#m_machine_code').val() || "";
	//var product_po = $('#product_po').val() || "";
	var item_code = $('#item_code').val() || "";
	var item_nm = $('#item_nm').val() || "";
	
	var postData = {
			 work_str_time : date,
			 origin_end_time : origin_end_time,
			 gb : gb,
			 machine_code : machine_code,
			// product_po : product_po, 
			 item_code : item_code,
			 item_nm : item_nm
		
	};
	w2ui['grid_list2'].lock('loading...', true);
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		success : function( data ) {
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
		
				
				var date =  $("#work_end_time").val();
				var machine_code = $('#m_machine_code').val() || "";	
				var prod_menge =  rowArr[0].prod_menge_sum;
				var prod_fail_menge =  rowArr[0].prod_fail_menge_sum;
				
				var work_time_sec = rowArr[0].work_time_sec_sum;
				var today_time_sec =  rowArr[0].today_time_sec_sum;
				
				var work_time_hour =  rowArr[0].work_time_hour ;
				var today_time_hour =  rowArr[0].today_time_hour;
				
				var per = (( Number(work_time_sec) / Number(today_time_sec) ) * 100).toFixed(2) + '%';
		
				
				w2ui['grid_list2'].clear();
				w2ui['grid_list2'].add([{
					recid : 1,
					date : date, 
					machine_code : machine_code, 
					prod_menge : prod_menge, 
					prod_fail_menge : prod_fail_menge,
					per : per, 
					work_time_hour : work_time_hour, 
					today_time_hour : today_time_hour
				
				}]);
			    w2ui.grid_list2.save();
			} else {
				w2ui['grid_list2'].clear();
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
			
			
			
		}, complete : function(){
			

			w2ui['grid_list2'].refresh();
		}			
		
	});
	
}

function modal_hold(){
	
	$("#modal_hold").modal('show');
	
	var hold_comment = $("#m_hold_comment").val('');
	
}

function modal_hold_all(){
	$("#modal_hold2").modal('show');
	
	
	var hold_comment = $("#hold_comment").val('');
	
}

//hold_yn Y로 변경
function changeHold_Y(){
	
	var hold_comment = $("#m_hold_comment").val();
	
	console.log('hold_comment : ' + hold_comment);
	if(hold_comment == ''){
		fnMessageModalAlert("알림", "HOLD사유를 작성해주세요.");
		return ;
	}
	
	var machine_code = $('#m_machine_code').val() || "";
	
	fnMessageModalConfirm("알림", "HOLD를 진행하시겠습니까?", function(result) {
		if(result) {
			
			var strUrl = "/info/machine/saveHold_Y";
			
			var postData = "machine_code=" + encodeURIComponent(machine_code)
							+ "&hold_comment=" + encodeURIComponent(hold_comment);
			
			
			
			$.ajax({
				 url: strUrl,
				 type: "POST",
				 dataType : 'json', 
				 data : postData, 
				 async : false,
				 success:function(data, textStatus, jqXHR){
				 	if(data.status == "200") {
				 		console.log(data);
				 		
				 		$('#modal_info').modal('hide');
				 		$('#modal_hold').modal('hide');
				 		loadData();
				 		
				    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
				 	}
				 },
				 error: function(jqXHR, textStatus, errorThrown){
				    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
				 },
				 complete: function() {
					 
					 
				 }
			}); 
			
		}
	});
}

//hold_yn N으로 변경
function changeHold_N(){
	
	var machine_code = $('#m_machine_code').val() || "";	
	
	fnMessageModalConfirm("알림", "HOLD를 해제하시겠습니까?", function(result) {
		if(result) {
			
			var strUrl = "/info/machine/saveHold_N";
			
			var postData = "machine_code=" + encodeURIComponent(machine_code);
			
			$.ajax({
				 url: strUrl,
				 type: "POST",
				 dataType : 'json', 
				 data : postData, 
				 async : false,
				 success:function(data, textStatus, jqXHR){
				 	if(data.status == "200") {
				 		console.log(data);
				 		
				 		$('#modal_info').modal('hide');
				 		loadData();
				 		
				 		
				    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
				 	}
				 },
				 error: function(jqXHR, textStatus, errorThrown){
				    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
				 },
				 complete: function() {
				 }
			}); 
			
		}
	});
}


function holdAll_Y(){
	
	var hold_comment = $("#hold_comment").val();
	
	if(hold_comment == ''){
		fnMessageModalAlert("알림", "HOLD사유를 작성해주세요.");
		return;
	}
	
	fnMessageModalConfirm("알림", "일괄 HOLD를 진행하시겠습니까?", function(result) {
		if(result) {
			
			var strUrl = "/info/machine/saveHold_ALL_Y";
			
			var postData = "hold_comment=" + encodeURIComponent(hold_comment);
			
			$.ajax({
				 url: strUrl,
				 type: "POST",
				 dataType : 'json', 
				 data : postData, 
				 async : false,
				 success:function(data, textStatus, jqXHR){
				 	if(data.status == "200") {
				 		console.log(data);
				 		
				 		rowArr = data.rows;
				 		
				 		//$('#modal_info').modal('hide');
				 		$('#modal_hold2').modal('hide');
				 		loadData();
				 		
				 		
				    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
				 	}
				 },
				 error: function(jqXHR, textStatus, errorThrown){
				    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
				 },
				 complete: function() {
				 }
			}); 
			
		}
	});
}

function holdAll_N(){
	fnMessageModalConfirm("알림", "일괄 HOLD 해제를 진행하시겠습니까?", function(result) {
		if(result) {
			
			var strUrl = "/info/machine/saveHold_ALL_N";
			
			var postData = "";
			
			$.ajax({
				 url: strUrl,
				 type: "POST",
				 dataType : 'json', 
				 data : postData, 
				 async : false,
				 success:function(data, textStatus, jqXHR){
				 	if(data.status == "200") {
				 		console.log(data);
				 		
				 		$('#modal_info').modal('hide');
				 		loadData();
				 		
				 		
				    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
				 	}
				 },
				 error: function(jqXHR, textStatus, errorThrown){
				    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
				 },
				 complete: function() {
				 }
			}); 
			
		}
	});
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