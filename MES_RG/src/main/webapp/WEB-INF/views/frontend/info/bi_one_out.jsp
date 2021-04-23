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
      <jsp:param name="selected_menu_p_cd" value="1041" />
      <jsp:param name="selected_menu_cd" value="1051" />
   </jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
      원자재 출고
        <small>구매/자재관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 구매/자재관리</a></li><li class="active">원자재 출고</li>
      </ol>
    </section>

     <section class="content">
      <div class="row" style="position: relative; height:600px;">
         <div class="row" style="position: absolute;  width: 49.5%; height:600px; margin:0;">
            <section class="col-lg-12">
               <div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
                  <!-- Progress Bar -->
                  <div class="box-header with-border" style=" background-color: #DB8EB5;">
                     <h3 class="box-title">LOT 작업지시 조회</h3>
                     <div class="box-tools pull-right">
                        <button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm">조회</button><!-- loadList(); -->    
                     </div>
                  </div>
                  <div id="" class="box-body">
                	  <div class="row">
	                     <div class="col-sm-4">
	                        <div class="form-group">
	                           <label>진행상태</label>
	                           <div class="form-group">
	                              <select id="out_status" class="form-control select2 input-sm" data-placeholder="" style="width: 100%;" onchange="loadList();">
	                                 <option value="N">자재출고 대기</option>
	                                 <option value="Y">출고 완료</option>
	                              </select>
	                           </div>
	                        </div>
	                     </div>      
	                  </div>
	                  <div id="grid_list" style="width: 100%; height: 570px;"></div>
                  </div>
               </div>
            
            </div>   
            
            <div class="row" style="position: absolute; right: 15px; width: 49%; height:600px; margin:0;">
               <div class="box box-success box-solid" style="min-height: 30px; border-color: #DB8EB5;">
                  <!-- Progress Bar -->
                  <div class="box-header with-border" style=" background-color: #DB8EB5;">
                     <h3 class="box-title">가용원자재 조회 및 출고</h3>
                     <div class="box-tools pull-right">
                          <button type="button" id="btn_delete" class="btn btn-info btn-sm" onclick="requestDivision();">원자재 분할</button>
                        <button type="button" id="btn_search_csr" onclick="requestOut();" class="btn btn-success btn-sm">출고</button><!-- loadList(); -->    
                        
                     </div>
                  </div>
                  
                  <div id="" class="box-body">
                	  <div class="row"></div>
                	  <div id="grid_list2" style="width: 100%; height: 640px;"></div> 
                  </div>
               </div>
           
            </div>
         </div>
         </section>
      </div>
   </section>
   
    <!-- /.content -->
  </div>
  
 	<!--   출고모달 -->
	<div class="modal fade" id="modal_info" data-backdrop="static">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modal_code_title">출고</h4>
	        	</div>
				<div class="modal-body" id="modal_code_body">
					<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
						<div class="row">
							<div class="form-group">
								<label for="" class="col-sm-3 control-label">작업지시 요청수량</label>
								<div class="col-sm-2">	
									<input type="text" class="form-control input-sm pull-right" id="m_req_count" >
								</div>
								<label for="" class="col-sm-3 control-label">원자재 출고수량</label>
								<div class="col-sm-2">
									<input type="text" class="form-control input-sm pull-right" id="m_out_count" >
								</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-1"></div>
							<div class="col-md-10" style="height:100%;width: 100%;">
								<div id="inputOutGrid" style="width: 560px; height: 220px; "></div>
							</div>
						</div>
						
					</form>
				</div>
				<div class="modal-footer">
					<div class="col-md-12 text-center">
						<!-- <button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button> -->
						<button type="button" id="" class="btn btn-success btn-sm" onclick="saveOut();">출고</button>
						<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 원자재분할 모달 -->
	<div class="modal fade" id="modal_info2" data-backdrop="static">
		<div class="modal-dialog modal-md" style="width:50%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modal_code_title">원자재 분할</h4>
	        	</div>
				<div class="modal-body" id="modal_code_body">
					<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
						<div class="form-group row">
							<div class="col-sm-11">
								<span style="line-height: 25px; font-weight: bold;">적용 P/N</span>
								<input type="text" class="" id="m_item_code" style="width: 125px; margin: 0 15px 0 10px;" value="" maxlength="50">
								<span style="line-height: 25px; font-weight: bold;">유형선택</span>
								<span style="width: 100px; margin-left:10px; height: 25px; " value="" maxlength="50">
									<select class="" id="select_division" name="select_division" style="height: 25px; width: 100px; margin-left:10px;" value="" maxlength="50">
										<!-- <option value="1">1/4</option>
										<option value="2">1/10</option>
										<option value="3">1/30</option> -->
									</select>
								</span>
								<input type="text" class="" id="m_division"  onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled; width:50px; margin: 0 15px 0 10px;" value="" maxlength="50">
								<button type="button" id="btn_division" class="btn btn-success btn-sm" onclick="plus();">분할</button>
							</div>
							<div class="col-sm-1">
								
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-1"></div>
							<div class="col-md-10" style="height:100%; width: 100%;">
								<div id="divisionGrid" style="width: 100%; height: 75px;"></div>
							</div>
						</div>
					</form>
					<!-- 원자재 분할결과 -->
					<form id="frm_routingItnbr" name="frm_routingItnbr" class="form-horizontal">
						<div class="box-header">
							<h5 class="box-title">조회조건</h5>
							<div class="box-tools pull-right">
								<span>생산변환가용수량</span>
								<input type="text" class="" id="m_warehouse_raw_qty_1" style="width: 60px; margin: 0 15px 0 10px;" value="" maxlength="50">
								
								<span>현재수량</span>
								<input type="text" class="" id="m_warehouse_raw_qty_2" style="width: 60px; margin: 0 15px 0 10px;" value="" maxlength="50">
								
								<span>남은수량</span>
								<input type="text" class="" id="m_warehouse_raw_qty_3" style="width: 60px; margin: 0 15px 0 10px;" value="" maxlength="50">
							 	<button type="button" id="btn_update" class="btn btn-info btn-sm" onclick="saveDivision();">저장</button>
								<!-- <button type="button" id="btn_update" class="btn btn-warning btn-sm" onclick="">취소</button> -->
								
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-1"></div>
							<div class="col-md-10" style="height:100%;width: 100%;">
								<div id="divisionGrid2" style="width: 100%; height: 500px; "></div>
							</div>
						</div>
					</form>
				</div>
				<!-- <div class="modal-footer">
					<div class="col-md-12 text-center">
						<button type="button" id="" class="btn btn-success btn-sm" onclick="confirmSapSync();">동기화 작업 실행</button>
						<button type="button" id="" class="btn btn-success btn-sm" onclick="saveCompany();">저장</button>
						<button type="button" id="" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
					</div>
				</div> -->
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


$(function($) {

    fnLoadCommonOption();     

    init_grid_list();
    init_grid_list2();
	
    loadList();
    
    divisionGrid();

})


// init component
function fnLoadCommonOption() {
    console.log('fnLoadCommonOption()');
    
       $('input[type="radio"].flat-red').iCheck({
          checkboxClass: 'icheckbox_flat-green',
          radioClass: 'iradio_flat-green',
          handle: 'radio'
       });
       
       
       var minDate = getFormatDate(new Date());
      $('#macc_chndate, #m_delivery_day, #m_order_day').daterangepicker({
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
      
       $('#order_day, #c_prod_day').daterangepicker({
            opens: 'right',
            locale: {
               format : 'YYYYMMDD'   ,
               monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
                     '7월', '8월', '9월', '10월', '11월', '12월' ],
               daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
               showMonthAfterYear : true,
               yearSuffix : '년'
             },
               endDate: '2020-08-31' 
         }); 
       
       
       $("#m_order_price").keyup(function(event) {
            if(event.which >= 37 && event.which <= 40) return;
            $(this).val(function(index, value) {
               return value
               .replace(/\D/g, "")
               //.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            });
         });
}
 

//회사명 변경시 1개 이상 조회시 select box로 1개일시 input창
$("#projectBox").change(function(){
   
   var val = $("#projectBox option:selected").val(); // text();
   
   console.log("val = " + val);
   
   if(val=="") {
      return;
   }
   
});



function init_grid_list(){
   var rowArr = [];
   
   $('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
           selectColumn: true,
         lineNumbers : false,
            footer: true
        },
        multiSelect: false,
        columns: [                
         { field:'product_po', caption:'LOT작업지시번호', size:'15%', style:'text-align:center', hidden: false,sortable :true}, // 80px
         { field:'item_code', caption:'P/N', size:'12%',  style:'text-align:center',sortable :true}, // 200px
         { field:'item_nm', caption:'품명', size:'18%', style:'text-align:center',sortable :true}, // 120px
         { field:'product_menge', caption:'수량', size:'8%', style:'text-align:center',sortable :true}, // 120px
         { field:'delivery_date', caption:'납기일', size:'10%', style:'text-align:center', hidden:true},
         { field:'product_class', caption:'납기', size:'10%', style:'text-align:center',sortable :true
        	 ,render: function (record, index, col_index) {
					var html = this.getCellValue(index, col_index);

					
					var delivery_date = w2ui.grid_list.records[index].delivery_date; 
					if(html == 'n')
					{
						html = '대기';
					}else if(html == 'o')
					{
						html = delivery_date;
					}else if(html == 'f')
					{
						html ='선진행';
					}
					
	               return html;
	           } 		 
         
         
         },
         { field:'out_status', caption:'진행상태', size:'10%', style:'text-align:center',sortable :true} // right // 120px
         ], 
 
      records: [
     
                
      ],   //
      onReload: function(event) {
         //loadList();
      },
		onSelect: function (event) {
			event.onComplete = function () {
				console.log("onSelect");
				var out_status = $("#out_status").val();
				
				if(out_status == 'N')
				{
					w2ui['grid_list2'].refresh();
					w2ui['grid_list2'].unlock();
					
					w2ui['grid_list2'].clear();
					
					loadList2();
				}
			}
		},
		onUnselect: function (event) {
			event.onComplete = function () {
				w2ui.grid_list2.selectNone();
				w2ui.grid_list2.clear();
				w2ui.grid_list2.refresh();
			}
		},
		
		
      
      onClick: function (event) {}
   });

}


function init_grid_list2(){
   var rowArr = [];
   
   $('#grid_list2').w2grid({ 
        name: 'grid_list2',
        show: {
           selectColumn: true,
         lineNumbers : false,
            footer: true
        },
        multiSelect: true,
        columns: [                
      
         { field:'business_code', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'business_nm', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'warehouse_code', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'warehouse_nm', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'out_warehousing_status', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'item_nm', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'item_spec', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'item_type_code', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'item_type_nm', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'division_seq', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'warehouse_raw_price', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'product_po', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         
         { field:'item_code', caption:'P/N', size:'15%', style:'text-align:center',sortable :true}, // 120px
     
         { field:'serial_no', caption:'Serial No', size:'25%', style:'text-align:center',sortable :true},
         { field:'meins', caption:'단위', size:'10%', style:'text-align:center',sortable :true}, // right // 120px
         { field:'warehouse_raw_qty', caption:'재고수량', size:'10%', style:'text-align:center',sortable :true},
         { field:'partition_rate', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
         { field:'warehouse_raw_change_qty', caption:'변환재고수량', size:'15%', style:'text-align:center',sortable :true
             
          /*     ,render: function (record, index, col_index) {
                var html = this.getCellValue(index, col_index);

                var warehouse_raw_qty = w2ui.grid_list2.records[index].warehouse_raw_qty; 
                var partition_rate = w2ui.grid_list2.records[index].partition_rate; 
                
                var partition = partition_rate.split('/');
                
                html = Number(warehouse_raw_qty) * Number(partition[1]);
       
                   return html;
               }    */
          
          },// 120px
          { field: 'division_seq', caption: 'division_seq', size: '18%', sortable: true, attr: 'align=center', hidden: true },
          { field:'in_date', caption:'입고일자', size:'10%', style:'text-align:center',sortable :true}
         ], 

      records: [
   
                
      ],   //
      onReload: function(event) {
         //loadList();
      },
      onClick: function (event) {}
   });

}

//-------------------------------------------------------------------------------------------------------------------
var out_status_name = '';
// 왼쪽 리스트 조회
function loadList()
{
	console.log("loadList()");
	
	w2ui['grid_list'].clear();
	w2ui['grid_list'].refresh();
	w2ui['grid_list'].unlock();
	
	w2ui['grid_list'].selectNone();
	var out_status = $("#out_status").val();
	
	if(out_status == 'N')
	{
		out_status_name = '자재 출고 대기';
	}else{
		
		out_status_name = '출고 완료';
	}
	
	console.log('out_status :' + out_status);
	var page_url = "/frontend/consumable/selectProduct_one";

	//w2ui['grid_list'].lock('loading...', false);
	var postData = "raw_out_yn=" + encodeURIComponent(out_status);

	
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		async : false,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				gridDataArr = rowArr;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					row.out_status = out_status_name;
					
					row.product_menge = Number(row.product_menge);
					
					
				});
				
				w2ui['grid_list'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list'].clear();
				
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			try{
				w2ui['grid_list2'].clear();
				w2ui['grid_list2'].refresh();
			}catch(e)
			{
				
			}
			
		},complete: function () {
			
		}
	});
}





//-------------------------------------------------------------------------------------------------------------------
//원자재모달 조회
function loadList_modal() {
	console.log("loadList_modal()");
	
	var key_1 = w2ui.grid_list.getSelection();
	var key_2 = w2ui.grid_list2.getSelection();
	
	var data = w2ui.grid_list.get(key_1[0]);
	var data_2 = w2ui.grid_list2.get(key_2[0]);

	var product_po = data.product_po;
	var out_warehousing_status = data.out_warehousing_status;
	var product_menge = data.product_menge;

	
	var page_url = "/frontend/consumable/selectWarehouseRaw";
	
	var postData = "product_po=" + encodeURIComponent(product_po)
				+"&product_menge=" + encodeURIComponent(product_menge)
				+"&out_warehousing_status=" + encodeURIComponent('i');


	if( $("#select_division option:selected").val() != "ALL") {
		postData += "&business_code=" + encodeURIComponent($("#select_division option:selected").val());
		postData += "&business_codeT=" + "";
		if( $("#business option:selected").val() == "MD1243" || $("#business option:selected").val() == "MD1244" ) {
			postData +=  encodeURIComponent("MD1282");	
		} 
		
	} else {
		postData += "&business_code=" + encodeURIComponent("");
	}
	
	
	//w2ui['divisionGrid'].lock('loading...', true);
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
				});
				

				w2ui['divisionGrid'].records = rowArr;
			
			
			} else
			{
				w2ui['divisionGrid'].clear();
			}
			w2ui['divisionGrid'].refresh();
			w2ui['divisionGrid'].unlock();
		},complete: function () {
			
		}
	});
	
} 

// 원자재 분할
function requestDivision()
{
	console.log('requestDivision()');
	
	var key_1 = w2ui.grid_list.getSelection();
	var key_2 = w2ui.grid_list2.getSelection();
	if( key_2.length == 0 ) {
		fnMessageModalAlert("알림", "분할하려는 원자재를 선택해주세요.");	
		return;
	}
	w2ui['divisionGrid'].clear();
	w2ui['divisionGrid'].refresh();
	
	divisionGrid2();
	
	w2ui['divisionGrid2'].clear();
	w2ui['divisionGrid2'].refresh();
	
	$("#m_division").val('');
	
	//selectPartitionRate();
	
	initOptions($('#select_division')); 
	
	
	var data_1 = w2ui.grid_list.get(key_1[0]);
	var data_2 = w2ui.grid_list2.get(key_2[0]);
	
	//////////원자재분할 수량 계산부분/////////////////////////////////////////////////////
	$("#m_warehouse_raw_qty_1").attr('disabled', true);
	$("#m_warehouse_raw_qty_2").attr('disabled', true);
	$("#m_warehouse_raw_qty_3").attr('disabled', true);
	
	
	var m_warehouse_raw_qty_1 = $("#m_warehouse_raw_qty_1").val(data_2.warehouse_raw_change_qty);
	
	$("#m_warehouse_raw_qty_2").val('');
	$("#m_warehouse_raw_qty_3").val('');
	
	/////////////////////////////////////////////////////////////////////////////////
	var serial_no = data_2.serial_no;
	var meins =  data_2.meins;
	var warehouse_raw_qty =  data_2.warehouse_raw_qty;
	var item_code =  data_2.item_code;
	
	var product_menge =  data_1.product_menge;
	var division_seq =  data_2.division_seq;
	
	var partition_rate = data_2.partition_rate; 
       
    var partition = partition_rate.split('/');
    
	$("#select_division").append("<option value=" + partition[1] + ">" + partition_rate + "</option>");
		$("#select_division option:eq(0)").prop("selected", true);	

	$("#m_item_code").attr('disabled',true);
	$("#m_item_code").val(data_1.item_code);
	
	
	setTimeout(function(){
	      w2ui['divisionGrid'].resize();
	      w2ui['divisionGrid'].refresh();
	      w2ui['divisionGrid2'].resize();
	      w2ui['divisionGrid2'].refresh();
	   }, 200);
	
	
	//loadList_modal();
	$("#modal_info2").modal('show');

	var target = document.getElementById("select_division");
	
	var select_div = target.options[target.selectedIndex].value;

	console.log('select_div : ' +select_div);
	
		var warehouse_raw_qty_1 = Number(warehouse_raw_qty)*Number(select_div);
		warehouse_raw_qty_1 = warehouse_raw_qty_1.toFixed(1);
	w2ui['divisionGrid'].add([
       		{ recid: '' ,division_seq: division_seq, item_type_nm: item_code, serial_no: serial_no, meins : meins, warehouse_raw_qty : warehouse_raw_qty, 
       			warehouse_raw_qty_1 : warehouse_raw_qty_1 , warehouse_raw_qty_2 : product_menge}
       	]); 
		

}

function warehouseResult(){
	var key = w2ui.grid_list2.getSelection();
	
	var total = 0;
    for( var i =0; i<key.length; i ++  ){
  	  	var data = w2ui.grid_list2.get(key[i]);
  	  	
        var warehouse_raw_qty = data.warehouse_raw_qty;
        var partition_rate = data.partition_rate;
        var partition = data.partition_rate.split('/');                
        var val= Number(warehouse_raw_qty) * Number(partition[1]);
        
        	total = Number(total) + Number(val);
    	
    }

}


//출고
function requestOut()
{
   
   	console.log('--------------출고');
   	var total = 0;
   	var key_1 = w2ui.grid_list.getSelection(); 
   	
    var data_1 = w2ui.grid_list.get(key_1[0]);
    var product_menge =  data_1.product_menge;

   	var key_2 = w2ui.grid_list2.getSelection(); 
   	var total = 0;
   /*  for( var i =0; i< key_2.length; i ++  ){
  	  	var data_2 = w2ui.grid_list2.get(key_2[i]);
  	  	
        var warehouse_raw_qty = data_2.warehouse_raw_qty;
        var partition_rate = data_2.partition_rate;
        var partition = data_2.partition_rate.split('/');                
        var val= Number(warehouse_raw_qty) * Number(partition[1]);
        
        	total = Number(total) + Number(val);
    	
    } */
    
    for( var i =0; i< key_2.length; i ++  ){
     	var data_2 = w2ui.grid_list2.get(key_2[i]);
    	  var warehouse_raw_change_qty = data_2.warehouse_raw_change_qty;
    	  
    	  total = Number(total) + Number(warehouse_raw_change_qty);
    }
    
   	console.log('product_menge: '+ product_menge);
   	console.log('total: '+ total);
   	
  	 if( key_2.length == 0 ) {
	   
  		fnMessageModalAlert("알림", "출고하려는 원자재를 선택해주세요.");	
		return;   
   	}
     
  	 
  	 //선택한 grid_list1 의 수량과 선택한 grid_list2 의 변환재고 수량의 합이 같아야 출고모달을 띄울 수 있다. 
  	if( Number(product_menge) == Number(total) ){
  		console.log('product_menge: '+ product_menge);
  	   	console.log('total: '+ total);
  		
  		
  		$("#modal_info").modal('show');
  		
  	}else {
  		
  		console.log('product_menge: '+ product_menge);
  	   	console.log('total: '+ total);
  		
  		fnMessageModalAlert("알림", "출고하려는 변환재고수량이 맞지않습니다.");	
		return;   
  	}
  	 
    
  
    
    $("#m_req_count").val(product_menge);
    $("#m_req_count").attr('disabled',true);
    $("#m_out_count").attr('disabled',true);
    $("#m_out_count").val('');
    
    setTimeout(function(){
          w2ui['inputOutGrid'].resize();
          w2ui['inputOutGrid'].refresh();
       }, 200);
    
    $("#modal_info").modal('show');
    inputOutGrid();

    w2ui['inputOutGrid'].clear();
    w2ui['inputOutGrid'].refresh();

   
        
        for( var i =0; i<key_2.length; i ++  ){
           
           var recid = Number(i) + 1;
           
           var data = w2ui.grid_list2.get(key_2[i]);
           var item_code = data.item_code;
           var serial_no = data.serial_no;
           var meins = data.meins;
           var warehouse_raw_qty = data.warehouse_raw_qty;
           var warehouse_raw_change_qty = data.warehouse_raw_change_qty;
           var partition_rate = data.partition_rate;
           var division_seq = data.division_seq;
           var product_po = data.product_po;
           
       w2ui['inputOutGrid'].add([
                            { recid: recid , item_code: item_code, serial_no: serial_no, meins : meins, warehouse_raw_qty : warehouse_raw_qty, 
                            	warehouse_raw_change_qty : warehouse_raw_change_qty,
                            	partition_rate : partition_rate, division_seq : division_seq , product_po : product_po}
                         ]); 
        }
    
        
    w2ui['inputOutGrid'].selectNone();
    outItem();
   

}
function outItem() {
	console.log('outItem()');
	$("#modal_code_title").text('출고');
	$("#ct_codeView").css('display', 'none');
	$("#m_customer_code").val('');
	 			
	$("#modal_info").modal('show');

}
//출고 그리드
function inputOutGrid(){
   console.log('inputOutGrid()');
   
   var rowArr = [];
   
   $('#inputOutGrid').w2grid({ 
      name : "inputOutGrid" ,
      show: { /*  toolbar: true,  */ footer: false , selectColumn: true},
      searches: [             
            
          ],
        multiSelect: true,
        columns: [
                  { field: 'item_code', caption: '품목번호', size: '18%', sortable: true, attr: 'align=center'},
                  { field: 'serial_no', caption: 'Seria1', size: '15%', sortable: true, attr: 'align=center'},
                  { field: 'meins', caption: '단위', size: '15%', sortable: true, attr: 'align=center' },
                  { field: 'warehouse_raw_qty', caption: '재고수량', size: '15%', sortable: true, attr: 'align=center'},
                  { field:'partition_rate', caption:'등급', size:'15%', style:'text-align:center', hidden:true },
                  { field:'warehouse_raw_change_qty', caption:'생산변환가용수량', size:'15%', style:'text-align:center'
                      
                      /* ,render: function (record, index, col_index) {
                         var html = this.getCellValue(index, col_index);

                         var warehouse_raw_qty = w2ui.inputOutGrid.records[index].warehouse_raw_qty; 
                         var partition_rate = w2ui.inputOutGrid.records[index].partition_rate; 
                         
                         var partition = partition_rate.split('/');
                         
                         html = Number(warehouse_raw_qty) * Number(partition[1]);
                
                            return html;
                        }     */
                   
                   },// 120px
                  { field: 'division_seq', caption: 'r', size: '18%', sortable: true, attr: 'align=center', hidden: true },
                  { field: 'product_po', caption: 'r', size: '18%', sortable: true, attr: 'align=center', hidden: true }
                
                ],
         sortData: [],
      records: [   

      ],
      total : 0,
      recordHeight : 30,
      onReload: function(event) {},
      onSelect: function(event) {
    	  event.onComplete = function () {
    		var key = w2ui.inputOutGrid.getSelection();
    		
    		
    		var total = 0;
            for( var i =0; i<key.length; i ++  ){
          	  	var data = w2ui.inputOutGrid.get(key[i]);
          	  	
                var warehouse_raw_qty = data.warehouse_raw_qty;
                var partition = data.partition_rate.split('/');                
                var val= Number(warehouse_raw_qty) * Number(partition[1]);

                console.log('warehouse_raw_qty : ' + warehouse_raw_qty);
                console.log('val : ' + val);
          	 	total = Number(total) + Number(val);
            	
            }
            $("#m_out_count").val(total);
      	  
		}
    	  
    	  
    	  	 
    	  	
			
      },
      onClick: function (event) {

  	  		/* var key = w2ui.inputOutGrid.getSelection();
			var data = w2ui.inputOutGrid.get(key[0]);
			
			var warehouse_raw_change_qty = data.warehouse_raw_change_qty;
			
			$("#m_out_count").val(warehouse_raw_change_qty); */
    	  
      }
   
    }); 
   
}

function divisionGrid(){
	console.log('divisionGrid()');
	
	var rowArr = [];
	
	$('#divisionGrid').w2grid({ 
		name : "divisionGrid" ,
		show: { /*  toolbar: true,  */ footer: false , selectColumn: false},
		searches: [             
				
   		 ],
        multiSelect: false,
        columns: [
                

		            { field: 'item_type_nm', caption: '원자재', size: '18%', sortable: true, attr: 'align=center', resizable: true },
		            { field: 'serial_no', caption: 'Seria1', size: '15%', sortable: true, attr: 'align=center', resizable: true },
		            { field: 'meins', caption: '단위', size: '15%', sortable: true, attr: 'align=center', resizable: true },
		            { field: 'warehouse_raw_qty', caption: '재고수량', size: '15%', sortable: true, attr: 'align=center', resizable: true },
		            { field: 'warehouse_raw_qty_1', caption: '생산변환 <br>가용수량', size: '15%', sortable: true, attr: 'align=center', resizable: true },
		            { field: 'warehouse_raw_qty_2', caption: '작업지시<br> 요청수량', size: '15%', sortable: true, attr: 'align=center', resizable: true },
		        	{ field: 'division_seq', caption: 'division_seq', size: '18%', sortable: true, attr: 'align=center', hidden: true },
         		 ],
			sortData: [],
		records: [			
					/* {recid : 1, item_type_nm:'MM-1234', serial_no: '004',
						meins:'EA', warehouse_raw_qty:'', warehouse_raw_qty_1:'', warehouse_raw_qty_2:''
					} */
		],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		
		onClick: function (event) {
		}
	
    }); 
	
}

function divisionGrid2(){
	console.log('divisionGrid2()');
	
	var rowArr = [];
	
	$('#divisionGrid2').w2grid({ 
		name : "divisionGrid2" ,
		show: { /*  toolbar: true,  */ footer: false , lineNumbers : true, selectColumn: false},
		searches: [             
				
   		 ],
        multiSelect: false,
        columns: [
                  
		            { field: 'item_type_nm', caption: '원자재', size: '18%', sortable: true, attr: 'align=center', resizable: true },
		           
		            { field: 'serial_no', caption: 'Seria1', size: '15%', sortable: true, attr: 'align=center', resizable: true },
		            { field: 'meins', caption: '단위', size: '15%', sortable: true, attr: 'align=center', resizable: true },
		            { field: 'warehouse_raw_qty', caption: '재고수량', size: '15%', sortable: true, attr: 'align=center', resizable: true 
		              
		            	/*  ,render: function (record, index, col_index) {
	                         var html = this.getCellValue(index, col_index);

	                         var warehouse_raw_qty_1 = w2ui.divisionGrid2.records[index].warehouse_raw_qty_1; 
	                         var partition_rate = $("#select_division").val();
	                         
	                        console.log('warehouse_raw_qty_1 : ' + warehouse_raw_qty_1);
	                        console.log('partition_rate : ' + partition_rate);
	                  
	                         
	                         html = parseInt(warehouse_raw_qty_1) / parseInt(partition_rate);
	                		
	                            return html;
	                        }     */
		            
		            
		            },
		            { field: 'warehouse_raw_qty_1', caption: '생산변환 가용수량', size: '30%', sortable: true, attr: 'align=center'
		            	, editable: { type: 'number' }  },
		            	{ field: 'division_seq', caption: 'division_seq', size: '18%', sortable: true, attr: 'align=center', hidden: true },
         		 ],
			sortData: [],
		records: [	

		],
		total : 0,
		recordHeight : 30,
		onReload: function(event) {},
		onChange: function (event) {
 			event.onComplete = function () {
 				console.log("onChange");
 		
 				w2ui.divisionGrid2.save();
 				
 			 	if(event.column == 4){
 					console.log("시작-------------------");
 					
 					var key = w2ui.divisionGrid2.getSelection();
 					var data = w2ui.divisionGrid2.get(key[0]); 
 					//var data = w2ui.divisionGrid2.records[event.recid];
 					var warehouse_raw_qty_1 = data.warehouse_raw_qty_1;
 					
 				
 					var rate = $("#select_division").val();

 					
 					var warehouse_raw_qty = parseInt(warehouse_raw_qty_1) / parseInt(rate);
 					warehouse_raw_qty = warehouse_raw_qty.toFixed(1);
 					w2ui.divisionGrid2.set( event.recid , {'warehouse_raw_qty' : warehouse_raw_qty});
 					w2ui.divisionGrid2.refresh();
 					w2ui.divisionGrid2.save();
 					
 	 				var m_warehouse_raw_qty_2 = $("#m_warehouse_raw_qty_2").val();
 	 				
 	 				$("#m_warehouse_raw_qty_2").val(Number(m_warehouse_raw_qty_2) + Number(data.warehouse_raw_qty_1));
 				} 
 			 	
 			 	
 			 	
 			 	var m_warehouse_raw_qty_4 = $("#m_warehouse_raw_qty_1").val();
 			 	console.log("m_warehouse_raw_qty_4???" + m_warehouse_raw_qty_4);
 			 	
 			 	console.log("m_warehouse_raw_qty_2???" + m_warehouse_raw_qty_2);
 			 	
 			 	var qty_total = Number(m_warehouse_raw_qty_4) - Number($("#m_warehouse_raw_qty_2").val());
 			 	
 			 	$("#m_warehouse_raw_qty_3").val(qty_total);
 			 	
 			 	console.log("qty_total???" + qty_total);
 			 	
 				
 			}
		},
		onClick: function (event) {
		}
	
    }); 
	
}

function fnCal(m_warehouse_raw_qty_2){
	
	var m_warehouse_raw_qty_4 = $("#warehouse_raw_qty_1").val();
	 	
 	var warehouse_raw_qty_3 = $("#warehouse_raw_qty_3").val();
 	
 	warehouse_raw_qty_3 = Number(warehouse_raw_qty_4) - Number(m_warehouse_raw_qty_2);
}
// 오른쪽 리스트 조회 
function loadList2()
{
	console.log("loadList2()");

	var key = w2ui.grid_list.getSelection();
	var data = w2ui.grid_list.get(key[0]);
	var product_po = data.product_po;
	
	var page_url = "/frontend/consumable/selectWarehouseRawPartition";

	//w2ui['grid_list'].lock('loading...', false);
	var postData = "out_warehousing_status=" + encodeURIComponent('i')
	+"&item_code=" + encodeURIComponent(data.item_code);
	
	$.ajax({
		url : page_url,
		type : 'POST',
		data : postData, 
		dataType : 'json',
		async : false,	
		success : function( data ) {
			if(data.status == 200 && (data.rows).length>0 ) {
				rowArr = data.rows;
				gridDataArr = rowArr;
				
				$.each(rowArr, function(idx, row){
					row.recid = idx+1;
					
					var key = w2ui.grid_list.getSelection();
					var data1 = w2ui.grid_list.get(key[0]);
					
					console.log('p_item_code : ' + row.p_item_code);
					console.log('data1.item_code : ' + data1.item_code);
					if(row.p_item_code != data1.item_code)
					{
						
						console.log('CHECK 1');
						var warehouse_raw_qty =row.warehouse_raw_qty; 
			            var partition_rate = row.partition_rate; 
			            var partition = partition_rate.split('/');
			            
			            row.warehouse_raw_qty = Number(row.warehouse_raw_qty);
			            row.warehouse_raw_change_qty = Number(row.warehouse_raw_change_qty);
			            
						row.warehouse_raw_change_qty  = Number(warehouse_raw_qty) * Number(partition[1]);
						row.warehouse_raw_change_qty  = row.warehouse_raw_change_qty.toFixed(1);
						
						
						
					}
					
					if(row.warehouse_raw_change_qty == null || row.warehouse_raw_change_qty == '' 
							|| row.warehouse_raw_change_qty == 'null'){
						
						console.log('CHECK 2');
						var warehouse_raw_qty =row.warehouse_raw_qty; 
			            var partition_rate = row.partition_rate; 
			            var partition = partition_rate.split('/');
						row.warehouse_raw_change_qty  = Number(warehouse_raw_qty) * Number(partition[1]);
						row.warehouse_raw_change_qty  = row.warehouse_raw_change_qty.toFixed(1);
					}
					
					   
					
					console.log('warehouse_raw_change_qty : ' + row.warehouse_raw_change_qty);
					

				});
				
				w2ui['grid_list2'].records = rowArr;
			
			
			}else
			{
				w2ui['grid_list2'].clear();
				
			}
			w2ui['grid_list2'].refresh();
			w2ui['grid_list2'].unlock();
			
		},complete: function () {
			
		}
	});
}
var deleteItems = new Array;
function plus() {
	console.log("plus()");

	w2ui.divisionGrid2.selectNone();
	w2ui['divisionGrid2'].clear();
	w2ui['divisionGrid2'].refresh();
	
	var rowArr = w2ui['divisionGrid'].records; 

	var data = rowArr[0];
	var num_menge = $("#m_division").val();
	console.log('num_menge : ' + num_menge);
	
	if(num_menge == '')
    {
       fnMessageModalAlert("알림", "분할수량을 입력해주세요.");
       return;
    }
	if(Number(num_menge) < 2)
    {
       fnMessageModalAlert("알림", "분할수량을 확인해주세요.");
       return;
    }
	var item_type_nm = data.item_type_nm;
	var serial_no = data.serial_no;
	var meins =  data.meins;
	var division_seq = data.division_seq;
	
	for(var i = 0; i< Number(num_menge); i++ )
	{
		
		var recid = Number(i) + 1;
		
		//var product_po = parent_product_po + '_'+recid
		w2ui['divisionGrid2'].add([
		               		{ recid:  recid , 
		               			division_seq: division_seq,
		               			item_type_nm: item_type_nm, 
		               			serial_no: serial_no, 
		               			meins: meins
		               			}
		               	]);
	}
	

}

function selectPartitionRate(){
	console.log("selectPartitionRate");
	
	initOptions($('#select_division')); 
	
	
	var key = w2ui.grid_list2.getSelection();
	var data1 = w2ui.grid_list2.get(key[0]);
	
	var raw_item_code = data1.item_code;
	
	console.log('raw_item_code: '+ raw_item_code);
	
	var strUrl = "/info/partition/selectPartition2";
	var postData = "raw_item_code=" + encodeURIComponent(raw_item_code);
	
	$.ajax({
	        url: strUrl,
	        type: "POST",
	        data: postData, 
	        dataType: 'json', 
	        async : false, 
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;    		
		    		console.log('///////////////////////SSSSSS////////////////');
		    		
					$.each(rowArr, function(idx, row){
						
						var partition_rate = row.partition_rate;
				
 						var partition = partition_rate.split("/");
						
						$("#select_division").append("<option value=" + partition[1] + ">" + row.partition_rate + "</option>");
					});
					
		 			$("#select_division option:eq(0)").prop("selected", true);	
		 			if("#select_division") {
		 				$("#select_division option:eq(1)").prop("selected", true);	
		 			}
		 			
		    	} else
		    	{
		    		console.log('///////////////////////data.status : ' + data.status);
		    	}
		    	
		    },
	       error: function(jqXHR, textStatus, errorThrown){
	             //fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");   
	       },
	       complete: function() {
	//           s_checkBox(vavaa);
	          
	       }
	   });
	
}
//모달 저장
function saveDivision(){
console.log('saveDivision()');
   


   var records1 = w2ui.divisionGrid.records;
   
   
   var records2 = w2ui.divisionGrid2.records;
   
   var key = w2ui.grid_list.getSelection();
   var data1 = w2ui.grid_list.get(key[0]);
   
   var key2 = w2ui.grid_list2.getSelection();
   var data2 = w2ui.grid_list2.get(key2[0]);
   
   var product_po = data1.product_po;
   var serial_no = records1[0].serial_no;
   var item_code = data2.item_code;
   var division_seq = data2.division_seq;
   
   
   var p_item_code = data1.item_code;
   
   
   console.log('p_item_code :  '+ p_item_code);
   
   if(records2.length == 0 )
   {
      fnMessageModalAlert("알림", "분할 해주세요.");
      return;
   }
   
   var raw_qty = 0;
   $.each(records2, function(idx, row){
      
	   raw_qty = Number(raw_qty) + Number(row.warehouse_raw_qty_1);
     
   
   }); 
   
   console.log('raw_qty : ' + raw_qty);
   console.log('data1.warehouse_raw_qty_1 : ' + records1[0].warehouse_raw_qty_1);
   
   if(Number(raw_qty) != Number(records1[0].warehouse_raw_qty_1))
   {
       fnMessageModalAlert("알림", "생산변환 가용수량을 다시 입력해주세요.");
       return;
	}

   
   var strUrl = "/frontend/consumable/rivisionWarehouseRawProcess";
   var postData = "gridData=" + encodeURIComponent(JSON.stringify(records2))
     + "&gridDataSelect=" + encodeURIComponent(JSON.stringify(data2))
   + "&product_po=" +  encodeURIComponent(product_po)
   + "&serial_no=" +  encodeURIComponent(serial_no)
   + "&item_code=" +  encodeURIComponent(item_code)
      + "&p_item_code=" +  encodeURIComponent(p_item_code)
     + "&division_seq=" +  encodeURIComponent(division_seq);
   
	FunLoadingBarStart();     
   $.ajax({
       url : strUrl,
       type : "POST", 
       dataType : 'json', 
       data : postData, 
      //async : false,   
       success:function(data, textStatus, jqXHR){
          if(data.status == "200") {
             fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
             
             $("#modal_info2").modal('hide');
             w2ui['grid_list2'].selectNone();
             loadList2();
            
      
          }
       },
       error: function(jqXHR, textStatus, errorThrown){
             fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");   // Notification(MES)
       },
       complete: function() {
         $("#modal_info").modal('hide');
     	FunLoadingBarEnd();
       }
   });
}

// 출고 - 저장
function saveOut()
{
	console.log('saveOut');
	var key = w2ui.grid_list.getSelection();
	var data1 = w2ui.grid_list.get(key[0]);
	
	var product_po = data1.product_po;
	var item_code = data1.item_code;
	
	var product_menge = data1.product_menge;
	
	var key_inputOutGrid = w2ui.inputOutGrid.getSelection();
	if(key_inputOutGrid.length == 0 )
	{
	   fnMessageModalAlert("알림", "출고하실 항목을 선택해주세요.");
	   return;
	}
	
	var total = 0;
   
	var records = new Array();
	for(var i = 0; i< key_inputOutGrid.length; i++)
	{
		var data = w2ui.inputOutGrid.get(key_inputOutGrid[i]);
		//
        var warehouse_raw_qty = data.warehouse_raw_qty;
        var partition = data.partition_rate.split('/');                
        var val= Number(warehouse_raw_qty) * Number(partition[1]);

        console.log('warehouse_raw_qty : ' + warehouse_raw_qty);
        console.log('val : ' + val);
  	 	total = Number(total) + Number(val);
  	 	
  	 	console.log('data division_seq : ' + data.division_seq);
		records.push(data);
		
	}
	//수량확인
	if( Number(product_menge) != Number(total) ){
		
		fnMessageModalAlert("알림", "작업지시 요청수량과 원자재 출고수량이 맞지않습니다.");	
  		
  	}
	console.log('records : ' + records[0].item_code);
	
	console.log('saveOut------------------')

	   
	var strUrl = "/frontend/consumable/outWarehouseRawProcess";
  	var postData = "gridData=" + encodeURIComponent(JSON.stringify(records))
  	+ "&product_po=" +  encodeURIComponent(product_po)
   	+ "&item_code=" +  encodeURIComponent(item_code);
   
	FunLoadingBarStart();      
   $.ajax({
       url : strUrl,
       type : "POST", 
       dataType : 'json', 
       data : postData, 
      //async : false,   
       success:function(data, textStatus, jqXHR){
          if(data.status == "200") {
             fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");// Notification(MES)
             
             $("#modal_info2").modal('hide');
             w2ui['grid_list2'].selectNone();
             loadList2();
            
             loadList();
      
          }
       },
       error: function(jqXHR, textStatus, errorThrown){
             fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");   // Notification(MES)
       },
       complete: function() {
         $("#modal_info").modal('hide');
     	FunLoadingBarEnd();
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
//       .append('<option value="All">-----</option>')
    .val();
}
</script>

</body>
</html>