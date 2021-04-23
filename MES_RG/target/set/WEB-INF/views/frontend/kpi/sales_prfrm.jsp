<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<%
// jsp properties
String thema = SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
// String empNo= SessionUtil.getMemberEmpNo(request);
// String memberId= SessionUtil.getMemberId(request);
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

<link rel="stylesheet"
   href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>


</head>

<body class="hold-transition skin-<%= thema  %> sidebar-mini">

<div class="wrapper">
   <jsp:include page="/common/top_menu_inc" flush="true">
      <jsp:param name="fb_div" value="F" />
      <jsp:param name="page_title" value="0" />
   </jsp:include>

   <jsp:include page="/common/sidebar_menu_inc" flush="true">
      <jsp:param name="menu_div" value="F" />
      <jsp:param name="selected_menu_p_cd" value="1013"  />
      <jsp:param name="selected_menu_cd" value="1031" />
   </jsp:include>

   <div class="content-wrapper">
      <section class="content-header">
         <h1>
            매출 실적 정보 <small>KPI Monitoring</small>
         </h1>
         <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>KPI Monitoring</a></li>
            <li class="active">매출 실적 정보</li>
         </ol>
      </section>

      <!-- 내용  -->
      <section class="content">
         <div class="row">
            <div class="col-md-12">
               <div class="box box-primary box-solid"  style="border-color: #DB8EB5;">

                  <div class="box-header with-border" style=" background-color: #DB8EB5;">
                     <h3 class="box-title">조회조건</h3>
                     <div class="box-tools pull-right">
                     <button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload();">액셀다운로드</button>
                        <button type="button" id="gridLoad" onclick="loadData();" class="btn btn-warning btn-sm">검색</button>
                     </div>
               </div>
               
               <div id="" class="box-body">
                     <div class="row">   
                        <div class="col-sm-2">
                           <div class="form-group">
                               <label>연도</label>
                               <select id="date" name="date" class="form-control" style="height: 30px;" >
                              </select>
                           </div>
                        </div>
                        
                        <div class="col-sm-2">
                           <div class="form-group">
                               <label>구분</label>
                               <select id="gubun" name="gubun" class="form-control" style="height: 30px;" >
                                 	<option value="">매출</option>
								    <option value="no">미출하</option>
								    <option value="ju">주문</option>
                               </select>
                           </div>
                        </div>
                        <div class="col-sm-2">
                           <div class="form-group">
                               <label>메인 고객사</label>
                               <select id="customer_integration_code" name="customer_integration_code" class="form-control" style="height: 30px;" >
                                 
                               </select>
                           </div>
                        </div>
                        
                        <div class="col-sm-2">
                           <div class="form-group">
                               <label>고객사</label>
                               <select id="customer_code" name="customer_code" class="form-control" style="height: 30px;" >
                                 
                               </select>
                           </div>
                        </div>
                        
                        <div class="col-md-12 text-center">
                           <div id="chartHolder"
                              style="width: 100%; height: 300px; text-align: center;"></div>
                        </div>
                     
                        <div class="col-md-12">
                           <div id="grid_list" style="width: 100%; height: 300px; margin-top:15px;"></div>
                        </div>
                        
                     
                        <div class="col-md-6 text-left" style="margin-top:15px;"> <!-- center -->
                           <h3 class="grap_text" style="margin: 10px;">고객별 매출비율</h3><!-- -left -->
                        </div>
                  
                        <div class="col-md-5 text-left" style="margin-top:15px;">
                           <h3 class="list_text" style="margin: 10px;">고객별 품목별 매출비율</h3>
                        </div>
                        <div class="col-md-1 text-left" style="margin-top:25px;">
                           <button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFileDownload2();">액셀다운로드</button>
                        </div>
                        
                        <div class="col-md-6">
                           <div id="chartHolder2" style="width: 100%; height: 350px; margin-top:15px; text-align: center; "></div>
                        </div>
                        
                        <div class="col-md-6" style="margin-top: 15px;">
                           <div id="grid_list2" style="width: 100%; height: 400px; "></div>
                        </div>
                           
                        
                        
                     </div>
                  </div>
               </div>
               <!-- 차트 영역 -->
               <!-- <div class="row" style="margin-bottom: 10px">
                  <div class="col-md-12 text-center">
                     <div id="chartHolder"
                        style="width: 100%; height: 300px; text-align: center;"></div>
                  </div>
               </div>

               <div class="row">
                  <div class="col-md-12">
                     <div id="grid_list" style="width: 100%; height: 150px; "></div>
                  </div>
               </div> -->
            </div> <!-- 공정그룹 목록 -->
         </div><!-- 젤 앞의  row -->
      </section>
   </div> <!-- content-wrapper -->
   <!-- 내용 End -->

   <!-- modal -->

   <!-- modal End -->

   <jsp:include page="/common/footer_inc" flush="true">
      <jsp:param name="page_title" value="0" />
   </jsp:include>

   <jsp:include page="/common/sidebar_rview_inc" flush="true">
      <jsp:param name="page_title" value="0" />
   </jsp:include>

</div>

   <script src="/res/plugins/pagination.js"></script>
   <script src="/res/plugins/pagination1.js"></script>
   <script type="text/javascript">
      var page = 1;       // 화면에서 사용할 page
      var pageNum = 0;    // 서버에 넘겨줄 page -> mysql 은 0 부터 시작
      var rowPerPage = 20;
      var rowLength = 0;
      var totalPage = 0;
      var cntRowPagination = 5;   // << 1 2 3 4 5 >>

      var chartData = [];
      var chartData2 = [];
      
      var layoutStr = "";
      var layoutStr2 = "";
      
      //-------------------------------------------------------------------------------------------------------------------
      $(function($) {
         var date = new Date();
         var currYear = date.getFullYear();
         console.log("currYear = " + currYear);
         $("#date").append("<option value='"+(currYear-10)+"'>" + (currYear-10) + "</option>");
         $("#date").append("<option value='"+(currYear-9)+"'>" + (currYear-9) + "</option>");
         $("#date").append("<option value='"+(currYear-8)+"'>" + (currYear-8) + "</option>");
         $("#date").append("<option value='"+(currYear-7)+"'>" + (currYear-7) + "</option>");
         $("#date").append("<option value='"+(currYear-6)+"'>" + (currYear-6) + "</option>");
         $("#date").append("<option value='"+(currYear-5)+"'>" + (currYear-5) + "</option>");
         $("#date").append("<option value='"+(currYear-4)+"'>" + (currYear-4) + "</option>");
         $("#date").append("<option value='"+(currYear-3)+"'>" + (currYear-3) + "</option>");
         $("#date").append("<option value='"+(currYear-2)+"'>" + (currYear-2) + "</option>");
         $("#date").append("<option value='"+(currYear-1)+"'>" + (currYear-1) + "</option>");
         $("#date").append("<option value='"+(currYear)+"'>" + currYear + "</option>");
         $("#date").append("<option value='"+(currYear+1)+"'>" + (currYear+1) + "</option>");
         

 		
 		 $("#date option:eq(10)").prop("selected", true);
         
         //$("#date").val(currYear).prop("selected", true);
          
//          initComponent(); // 달력

		fnCdD('customer_integration_code', 'MD1525');

         fnAccount();

         initGridList(); // 첫 그리드
         grid_list2();
         
         loadList_down();
         
         loadList();
//          msg_time();
         
         
         $("#p_netwr, #p_menge").keyup(function(event) {
            if(event.which >= 37 && event.which <= 40) return;
            $(this).val(function(index, value) {
               return value
               .replace(/\D/g, "")
               .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            });
         });

      })
      //-------------------------------------------------------------------------------------------------------------------
      // 달력
      function initComponent() {
         console.info('initComponent()');

         $('#s_inspection_year').daterangepicker({
            opens: 'right',
            singleDatePicker: true,
            locale: {
               format: 'YYYY', // inputbox 에 '2011-04-29' 로표시
               monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
               daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
               showMonthAfterYear: true,
               yearSuffix: '년',
               orientation: "top left"
            }
         });
      } //
      
      
      $("#customer_code").change(function(){
    	  w2ui['grid_list2'].refresh();
          w2ui['grid_list2'].unlock();
          w2ui['grid_list2'].clear();
          
         loadList();
         loadList_graph();
         loadList_down();
      });
      
      $("#customer_integration_code").change(function(){
    	  w2ui['grid_list2'].refresh();
          w2ui['grid_list2'].unlock();
          w2ui['grid_list2'].clear();
          
         loadList();
         loadList_graph();
         loadList_down();
         fnAccount();
      });
      
      $("#date").change(function(){
    	  w2ui['grid_list2'].refresh();
          w2ui['grid_list2'].unlock();
          w2ui['grid_list2'].clear();
          
         loadList();
         loadList_graph();
         loadList_down();
      });
      
      function loadData(){
    	  w2ui['grid_list2'].refresh();
          w2ui['grid_list2'].unlock();
          w2ui['grid_list2'].clear();
          
    	  loadList();
          loadList_graph();
          loadList_down();
          
          
      }
      
      
      $("#gubun").change(function(){
    	  
          var gubun = $("#gubun").val();
          
          if(gubun == ''){
        	  $(".grap_text").text("고객별 매출비율");
        	  $(".list_text").text("고객별 품목별 매출비율");
        	  
        	  w2ui['grid_list2'].removeColumn('recid', 'sum_price');
        	  w2ui['grid_list2'].addColumn('success_status', { field: 'sum_price', caption: '매출', size: '10%', sortable: true, attr: 'align=center', resizable: true ,
							            	  render: function (record, index, col_index) {
								                    	var val = this.getCellValue(index, col_index);
								                       return w2utils.formatNumber(Number(val));
							            	  		}
							                  
							                    });		
        	  
        	  
        	  
          }else if(gubun == 'no'){
        	  $(".grap_text").text("고객별 미출하 비율");
        	  $(".list_text").text("고객별 품목별 미출하 비율");
        	  
        	  
        	  w2ui['grid_list2'].removeColumn('recid', 'sum_price');
        	  w2ui['grid_list2'].addColumn('success_status', { field: 'sum_price', caption: '미출하', size: '10%', sortable: true, attr: 'align=center', resizable: true ,
							            	  render: function (record, index, col_index) {
								                    	var val = this.getCellValue(index, col_index);
								                       return w2utils.formatNumber(Number(val));
							            	  		}
							                  
							                    });		
        	  
        	  
        	  
          }else if(gubun == 'ju'){
        	  $(".grap_text").text("고객별 주문 비율");
        	  $(".list_text").text("고객별 품목별 주문 비율");
        	  
        	  w2ui['grid_list2'].removeColumn('recid', 'sum_price');
        	  w2ui['grid_list2'].addColumn('success_status', { field: 'sum_price', caption: '주문', size: '10%', sortable: true, attr: 'align=center', resizable: true ,
							            	  render: function (record, index, col_index) {
								                    	var val = this.getCellValue(index, col_index);
								                       return w2utils.formatNumber(Number(val));
							            	  		}
							                  
							                    });	
          }
          
          w2ui['grid_list2'].refresh();
          w2ui['grid_list2'].unlock();
          w2ui['grid_list2'].clear();
          
          loadList();
          loadList_graph();
          loadList_down();
          
       });
      
      //-------------------------------------------------------------------------------------------------------------------
      // 첫 그리드
      function initGridList() {
         console.log('initGridList()');
         var rowArr = [];

         // project_manager
         $('#grid_list').w2grid({
              name: 'grid_list',
              show: { footer: true }, // , selectColumn: true
              columnGroups: [
                            /*  { caption: '생산지시번호', master: true },
                             { caption: '주야', span: 1  } */
                         ],
              multiSelect: false,
              columns: [
                        //33

                  { field: 'recid', caption: 'No', size: '70px', sortable: true, attr: 'align=center', resizable: true, hidden: true},
                  { field: 'gb', caption: '구분', size: '10%', sortable: true, attr: 'align=center', resizable: true },
                  { field: 'c1', caption: '1월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c2', caption: '2월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c3', caption: '3월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c4', caption: '4월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c5', caption: '5월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c6', caption: '6월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },       //v
                  { field: 'c7', caption: '7월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c8', caption: '8월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c9', caption: '9월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c10', caption: '10월', size:'10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c11', caption: '11월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },
                  { field: 'c12', caption: '12월', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  },

                  { field: 'p', caption: '합계', size: '10%', sortable: true, attr: 'align=center', resizable: true,
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                        if(record.gb != '달성률(%)'){
                           return w2utils.formatNumber(Number(val));
                        }else{
                           return val + '%';
                        }
                        }
                  }
             ],
              sortData: [
            ],
            total : 0,
            recordHeight : 30,
            onReload: function(event) {},
            onClick: function (event) {
            },
            onDblClick: function (event) {
            }
          });

         // 차트 값 넣기
         loadList();

      }
      
      
      // 첫 그리드
      function grid_list2() {
         console.log('grid_list2()');
         var rowArr = [];

         // project_manager
         $('#grid_list2').w2grid({
              name: 'grid_list2',
              show: { footer: true }, // , selectColumn: true
              columnGroups: [
                            /*  { caption: '생산지시번호', master: true },
                             { caption: '주야', span: 1  } */
                         ],
              multiSelect: false,
              columns: [
                        //33

                   { field: 'customer_code', caption: '고객사', size: '70px', sortable: true, attr: 'align=center', resizable: true, hidden: true},
                  { field: 'customer_nm', caption: '고객사', size: '10%', sortable: true, attr: 'align=center', resizable: true },
                  { field: 'item_code', caption: 'P/N', size: '10%', sortable: true, attr: 'align=center', resizable: true },
                  { field: 'item_nm', caption: '품명', size: '10%', sortable: true, attr: 'align=center', resizable: true },
                  { field: 'sum_price', caption: '매출', size: '10%', sortable: true, attr: 'align=center', resizable: true ,
                	  render: function (record, index, col_index) {
                          	var val = this.getCellValue(index, col_index);
                             return w2utils.formatNumber(Number(val));
                        
                          }
                  },
                  { field: 'success_status', caption: '비율', size: '10%', sortable: true, attr: 'align=center', resizable: true, 
                     render: function (record, index, col_index) {
                        var val = this.getCellValue(index, col_index);
                           
                        return  val + "%";
                        }   
                  
                  }
                  
             ],
              sortData: [
            ],
            total : 0,
            recordHeight : 30,
            onReload: function(event) {},
            onClick: function (event) {
            },
            onDblClick: function (event) {
            }
          });

         // 차트 값 넣기
		loadList_graph();
      }
      
      
      function fnAccount(){
         
         initOptions($('#customer_code')); // select 박스 초기화
         
         var strUrl = "/frontend/repair/selectSalesSearch";
         
         var customer_code = $("#customer_code").val();
         var customer_integration_code = $("#customer_integration_code").val();
     	var postData = "customer_integration_code=" + encodeURIComponent(customer_integration_code);
		
         
         $.ajax({
             url: strUrl,
             type: "POST",
             data: postData, 
             dataType: 'json', 
             async : false, // 다 끝나고 다음 처리 해!
             success:function(data, textStatus, jqXHR){
        //              console.log("(data.rows).length = " + (data.rows).length);
                if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
                   rowArr = data.rows;
                   $("#customer_code").append("<option value="+''+">" + "전체" + "</option>");
                   
                  $.each(rowArr, function(idx, row){
                     
                     $("#customer_code").append("<option value=" + row.customer_code + ">" + row.customer_nm + "</option>");
                     row.recid = idx + 1;
                     
                  });
                   $("customer_code option:eq(0)").prop("selected", true);
                   
                   

                  /* if (startValue_combo2 == "") {
                     
                     $('#item_nm').w2field('combo', { items: _.uniq(comboValue_nm_i,false) ,match : 'contains' });            
                     $('#item_code').w2field('combo', { items: _.uniq(comboValue_cd,false) ,match : 'contains' });
                  } */
                } 
                
             },
             error: function(jqXHR, textStatus, errorThrown){
             },
             complete: function() {
                //startValue_combo2 =")";
             }
         });
         
      }
      
      function initOptions(obj) {

    	  $(obj)

    	  .find('option')

    	  .remove()

    	  .end()

    	  .val();

    	  }
      
      //-------------------------------------------------------------------------------------------------------------------
      
      	function fnCdD(val, val2) {
		console.log("fnCdD(" + val + ")");

		//initOptions($("#customer_integration_code")); // select 박스 초기화
		
		var strUrl = "/frontend/repair/selectCustomerIntergration";
		var postData = "customer_integration_code=" + encodeURIComponent(val2);

		$.ajax({
					url : strUrl,
					type : "POST",
					//data : postData,
					dataType : 'json',
					async : false, // 다 끝나고 다음 처리 해!
					success : function(data, textStatus, jqXHR) {
						//	 	    	console.log("(data.rows).length = " + (data.rows).length);
						if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
							rowArr = data.rows;

							var sub = val.substr(0, 2); 
							//  if(valsub != "m_")
							$("#customer_integration_code").append("<option value="+''+">" + "전체"+ "</option>");
							
							$.each(rowArr, function(idx, row) {
								
								$("#customer_integration_code").append("<option value=" + row.customer_integration_code + ">"+ row.customer_integration_nm+ "</option>");});

								$("#customer_integration_code option:eq(0)").prop("selected",true);

						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
					},

					complete : function() {
 						loadList();

					}
				});

	}
	
	$("#item_type_code").change(function() {

		var item_type_code = $("#item_type_code").val();

		loadList();

	});
      
    var max_total_price = 0;
    var max_total_price2 = 0;
    
    var max_total_price3 = 0;
    var max_total_price4 = 0;
    
    var max_total_price5 = 0;
    var prev_no_sum = 0;
    var max_total = 0;
    
      var grapArr = new Array();
      
      var listArr = new Array();
      
    function loadList(){
    	 current_month = '';
         console.log("loadList()");
         
         w2ui['grid_list'].clear();
         
         chartData = new Array();
         var customer_integration_code = $("#customer_integration_code").val();
         var customer_code = $("#customer_code").val();
         
         console.log("customer_code ??" + customer_code);
         
         var year = $("#date").val();
         var gubun = $("#gubun").val();
         
         var page_url = "/frontend/repair/selectSalesGrid";
         
         var postData = "customer_code=" + encodeURIComponent( customer_code )
          			+"&customer_integration_code=" + encodeURIComponent(customer_integration_code)
                  	+"&year=" + encodeURIComponent(year)
                    +"&gubun=" + encodeURIComponent(gubun);
         
         /* chartData = [
                      {recid: 1, 
                           gb:"매출액(원)", c1:"2320000000", c2:"1940000000", c3:"2230000000", c4:"1620000000", c5:"2040000000", 
                       c6:"0", c7:"0", c8:"0", c9:"0", c10:"0", c11:"0", c12:"0", p:"10180000000"},
                       {recid: 2, 
                          gb:"목표금액(원)", c1:"46400000", c2:"38800000", c3:"44600000", c4:"32400000", c5:"41400000", 
                          c6:"0", c7:"0", c8:"0", c9:"0", c10:"0", c11:"0", c12:"0", p:"90"},
                       {recid: 3, 
                          gb:"달성률(%)", c1:"0", c2:"0", c3:"0", c4:"0", c5:"0", 
                          c6:"0", c7:"0", c8:"0", c9:"0", c10:"0", c11:"0", c12:"0", p:"90"}   
                  ]; */
                  
          chartData = [
                         {recid: 1, 
                              gb:"목표금액(원)"},
                          {recid: 2, 
                             gb:"매출액(원)"},
                          {recid: 3, 
                             gb:"달성률(%)"},
                          {recid: 4, 
                          	 gb:"누적목표금액(원)"},
                          {recid: 5, 
                              gb:"누적매출액(원)"}   
                        ];
         

         var resultData ;
         
         $.ajax({
            url : page_url,
            type : 'POST',
            data : postData, 
            dataType : 'json',
            success : function( data ) {
               if(data.status == 200 && (data.rows).length>0 ) {

                  resultData = data.rows;
 
                  var grapArr = new Array();
                  
                  for(var i = 1; i<= 12; i++)
                  {
                     var grapObj = new Object();
                     grapObj.month = i + "월";
                     grapObj.sum_price = 0;
                     grapObj.goal = 0;
                     grapObj.goal_acc = 0;
                     grapObj.no_price = 0;
                     grapObj.ju_price = 0;
         
                     grapObj.sum_price_acc = 0;
                     grapObj.test = 0;
                     console.log('grapObj.sum_price_acc : ' + grapObj.sum_price_acc);
                     grapArr.push(grapObj);
                     
                  } 
                  console.log('33333333333rapArr');
                  console.log(grapArr);
               	
                  var hap1 = 0;
                  var hap2 = 0;
                  
                  var hap3 = 0;
                  var hap4 = 0;
                  
                   max_total_price = 0;
                   max_total_price2 = 0;
                   
                   max_total_price3 = 0;
                   max_total_price4 = 0;
                   
                   max_total_price5 = 0;
              
                  for(var i = 0; i< resultData.length; i++)
                  {
                 	 
                 	 console.log("i????????" + i);
                     var grapObj = new Object();
                     var month = resultData[i].month;
                     
                     console.log("resultDataData[i].sum_price ?" + resultData[i].sum_price);
                     console.log("resultData[i].goal ?" + resultData[i].goal);
                     
                     //resultData[i].sum_price =10000000;
                     grapObj.month = resultData[i].month + "월";
                     grapObj.sum_price = resultData[i].sum_price;
                     grapObj.goal = resultData[i].goal;
                     
                     grapObj.goal_acc = 0;
                     grapObj.sum_price_acc = 0;
                     
                     grapObj.prev_no_price = resultData[i].prev_no_price;
                     grapObj.no_price = resultData[i].no_price;
                     grapObj.ju_price = resultData[i].ju_price;
                     
                     grapObj.test = 0;
                     grapArr[Number(month) - 1] = grapObj;
                     
                     hap1 = Number(hap1) + Number(resultData[i].sum_price);
                     hap2 = Number(hap2) + Number(resultData[i].goal);
                     hap3 = Number(hap3) + Number(resultData[i].no_price);
                     hap4 = Number(hap4) + Number(resultData[i].ju_price);
                    
                  }
                  console.log('grapArr');
                  console.log(grapArr);
                  
              
                   for(var i = 0; i< grapArr.length; i++)
                  {
                     var grapObj = grapArr[i];
                     console.log("--------------------------------------");
                     console.log("grapObj.month?" + grapArr[i].month);
                     console.log("grapObj.sum_price?" + grapArr[i].sum_price);
                     console.log("grapObj.goal?" + grapArr[i].goal);
                     console.log("grapObj.goal_acc?" + grapArr[i].goal_acc);
                     console.log("grapObj.sum_price_acc?" + grapArr[i].sum_price_acc);
                     console.log("grapObj.test?" + grapArr[i].test);
                     console.log("grapObj.prev_no_price?" + grapArr[i].prev_no_price);
                     console.log("--------------------------------------");
                     if(i == 0 )
                    {
                    	 grapObj.sum_price_acc = grapArr[i].sum_price;
                    	 grapObj.test = grapArr[i].sum_price;
                     	 grapObj.goal_acc = grapArr[i].goal;
                    }else {
                    	 grapObj.sum_price_acc = Number(grapArr[i].sum_price) + Number(grapArr[i-1].sum_price_acc);
                    	 grapObj.test = Number(grapArr[i].sum_price) + Number(grapArr[i-1].test);                	
                    	 grapObj.goal_acc = Number(grapArr[i].goal) + Number(grapArr[i-1].goal_acc);
                     }
                  
                     /* console.log("1111111111--------------------------------------");
                     console.log("grapObj.month?" + grapObj.month);
                     console.log("grapObj.sum_price?" + grapObj.sum_price);
                     console.log("grapObj.goal?" + grapObj.goal);
                     console.log("grapObj.goal_acc?" + grapObj.goal_acc);
                     console.log("grapObj.sum_price_acc?" + grapObj.sum_price_acc);
                     console.log("grapObj.test?" + grapObj.test);
                     console.log("--------------------------------------");
                           */
                     grapArr[i] = grapObj;
                  }  
                   console.log('111111grapArr');
                   console.log(grapArr);
                  chartData = grapArr;      
                  
                  console.log('1111111chartData');
                  console.log(chartData);
                  //미출하 누적 합계
				
                  
                  for (var i = 0; i < grapArr.length; i++) {
						var grapObj = grapArr[i];
						console.log("1 prev_no_price:::"+grapArr[0].prev_no_price );
						if (i == 0) {
							grapObj.sum_no_price_acc = Number(grapArr[i].no_price)+Number(grapArr[i].prev_no_price)
						console.log("grapArr[0].no_price+grapArr[0].prev_no_price "+(Number(grapArr[0].prev_no_price)+Number(grapArr[0].no_price)))
						} else {
							grapObj.sum_no_price_acc = Number(grapArr[i].no_price) + Number(grapArr[i - 1].sum_no_price_acc);
						}
						prev_no_sum = Number(grapObj.sum_no_price_acc) + Number(grapObj.sum_no_price_acc)/10;
						grapArr[i] = grapObj;
                  		console.log("sum_no_price_acc:::"+grapObj.sum_no_price_acc );
						
					}

					chartData = grapArr;
				  //주문 누적 합계
				  for (var i = 0; i < grapArr.length; i++) {
						var grapObj = grapArr[i];

						if (i == 0) {
							grapObj.sum_ju_price_acc = grapArr[i].ju_price;
						} else {
							grapObj.sum_ju_price_acc = Number(grapArr[i].ju_price) + Number(grapArr[i - 1].sum_ju_price_acc);
						}

						grapArr[i] = grapObj;
					}

					chartData = grapArr;
                  
                  var listArr = [{},{},{},{},{},{},{},{}];
                /*   listArr = [
                               {recid: 1, 
                                    gb:"매출액(원)"},
                                {recid: 2, 
                                   gb:"목표금액(원)"},
                                {recid: 3, 
                                   gb:"달성률(%)"}   
                              ]; */
                  ////////////////////////////////////////
                  
					
                 //////////////////////////////////////////// 
                  
                  for(var i = 0; i < 8; i++)
                 { 	  
                	  listArr[i].recid = Number(i)+1;
                  	if( i == 0 )
                  	{
                  		listArr[i].gb = '목표금액(원)';
                  		for(var j = 0; j< grapArr.length; j++ )
                  		{
                  			
                  			listArr[i]['c'+(Number(j)+1)] = grapArr[j].goal;
                  			
                  			
                  			 if(grapArr[j].goal == 0 || grapArr[j].goal == null || grapArr[j].goal == 'NaN' || grapArr[j].goal == "undefined")
			  	  			{
                  				grapArr[j].goal = 0;
			  	  			}
                  			 
                  			console.log("listArr[1]??" + listArr[i]['c'+(Number(j)+1)]);
                  			
                  			
                  			
                  		}
                  		listArr[i].p = hap2;
                  		
                  	}else if( i == 1 )
                  	{
                  		
                  		listArr[i].gb = '매출액(원)';
                  		for(var j = 0; j< grapArr.length; j++ )
                  		{
                  			var gb1 = listArr[i]['c'+(Number(j)+1)]
                  			listArr[i]['c'+(Number(j)+1)] = grapArr[j].sum_price;
                  			
                  			console.log("listArr[0]??" + listArr[i]['c'+(Number(j)+1)]);
                  			
                  			
                  		}
                  		listArr[i].p = hap1;
                  		
                  		
  	               	}else if( i == 2 )
                  	{
                  		
                  		listArr[i].gb = '미출하금액(원)';
                  		for(var j = 0; j< grapArr.length; j++ )
                  		{
                  			var gb1 = listArr[i]['c'+(Number(j)+1)]
                  			listArr[i]['c'+(Number(j)+1)] = grapArr[j].no_price;
                  			
                  			 if(grapArr[j].no_price == 0 || grapArr[j].no_price == null || grapArr[j].no_price == 'NaN' || grapArr[j].no_price == "undefined")
 			  	  			{
                   				grapArr[j].no_price = 0;
 			  	  			}
                  			
                  			console.log("listArr[0]??" + listArr[i]['c'+(Number(j)+1)]);
                  			
                  		}
                  		
                  		listArr[i].p = hap3;
                  		
                  		if(Number(max_total_price3) < Number(listArr[i].p)){
                  			max_total_price3 = listArr[i].p;
    					}
                  		
  	               	}else if( i == 3 )
                  	{
                  		
                  		listArr[i].gb = '주문금액(원)';
                  		for(var j = 0; j< grapArr.length; j++ )
                  		{
                  			var gb1 = listArr[i]['c'+(Number(j)+1)]
                  			listArr[i]['c'+(Number(j)+1)] = grapArr[j].ju_price;
                  			
                  			 if(grapArr[j].ju_price == 0 || grapArr[j].ju_price == null || grapArr[j].ju_price == 'NaN' || grapArr[j].ju_price == "undefined")
 			  	  			{
                   				grapArr[j].ju_price = 0;
 			  	  			}
                  			
                  			console.log("listArr[0]??" + listArr[i]['c'+(Number(j)+1)]);
                  			
                  		}
                  		listArr[i].p = hap4;
                  		
                  		if(Number(max_total_price4) < Number(listArr[i].p)){
                  			max_total_price4 = listArr[i].p ;
    					}
                  		
                  		
  	               	}else if( i == 4 )
  	            	{
  	             	  	listArr[i].gb = '달성률(%)';
  	               		for(var j = 0; j< grapArr.length; j++ )
                  		{
  	               			var per = (Number(grapArr[j].sum_price) / Number(grapArr[j].goal)) * 100;
  	               			listArr[i]['c'+(Number(j)+1)] = per.toFixed(2);
  	               		    
	  	               		if(listArr[i]['c'+(Number(j)+1)] == 0 || listArr[i]['c'+(Number(j)+1)] == null || listArr[i]['c'+(Number(j)+1)] == 'NaN' || listArr[i]['c'+(Number(j)+1)] == "undefined")
			  	  			{
	  	               			listArr[i]['c'+(Number(j)+1)] = 0 ;
			  	  			}
	  	               		
	  	               		if(Number(grapArr[j].goal) == 0 )
	  	               		{
	  	               			listArr[i]['c'+(Number(j)+1)] = 0 ;
	  	               		}
                  		}
  	               		var hap ;
  	               		if(hap2 == 0){
  	               			hap3 = 0;
  	               			listArr[i].p = hap3.toFixed(0);
  	               			
  	               		}else{
  	               			hap3 = (Number(hap1) / Number(hap2)) * 100;
  	               			listArr[i].p = hap3.toFixed(2);
  	               		}
  	              		//var hap3 = (Number(hap1) / Number(hap2)) * 100;
  	              		//listArr[i].p = hap3.toFixed(2);
  	              		
  	              		console.log("hap3??/"+ hap3);
  	              		console.log("listArr[i].p??/"+ hap3.toFixed(2));
  	              		
  	         
  	            	}else if( i == 5 )
  	            	{
  	             	  	listArr[i].gb = '누적목표금액(원)';
  	             	 	console.log('CHECK grapArr.length ' + grapArr.length );	
	  	             	for(var j = 0; j< grapArr.length; j++ )
		               	{
	  	             		 listArr[i]['c'+(Number(j)+1)] = grapArr[j].goal_acc;
	  	             		 if(j == 0 )
	  	             		{
	  	             			 listArr[i]['c'+(Number(j)+1)] = Number(listArr[0]['c'+(Number(j)+1)]);
	 	  	             		
 	             			 }else
 	             			{
 	             				listArr[i]['c'+(Number(j)+1)] = Number(listArr[0]['c'+(Number(j)+1)]) + Number(listArr[i]['c'+j]);
 		  	             		
 	             			}
	  	             		listArr[i].p = Number(listArr[0]['c'+(Number(j)+1)]) + Number(listArr[i]['c'+j]);	
	  	             		
	  	             		
	  	             		if(Number(max_total_price2) < Number(listArr[i].p)){
                          		max_total_price2 = listArr[i].p ;
        					}
		               	} 
  	         
  	            	}else if( i == 6 )
  	            	{
  	             	  	listArr[i].gb = '누적매출액(원)';
  	             	  	
	  	             	for(var j = 0; j< grapArr.length; j++ )
		               	{
	  	             		//grapArr[j].sum_price_acc = listArr[i]['c'+(Number(j)+1)];
	  	             		
	  	         		 listArr[i]['c'+(Number(j)+1)] = grapArr[j].sum_price_acc;
	  	             
	  	             		 if(j == 0 )
	  	             		{
	  	             			 listArr[i]['c'+(Number(j)+1)] = Number(listArr[1]['c'+(Number(j)+1)]);
	 	  	             		
	             			 }else
	             			{
	             				listArr[i]['c'+(Number(j)+1)] = Number(listArr[1]['c'+(Number(j)+1)]) + Number(listArr[i]['c'+j]);
		  	             		
	             			}
	  	             		listArr[i].p = Number(listArr[1]['c'+(Number(j)+1)]) + Number(listArr[i]['c'+j]);	
	  	             		
	  	             		if(Number(max_total_price5) < Number(listArr[i].p)){
	  	             			max_total_price5 = listArr[i].p ;
        					}
		               	} 
	  	             	
  	            	}else if( i == 7 )
  	            	{
  	             	  	listArr[i].gb = '누적미출하금액(원)';
  	             	  	
	  	             	for(var j = 0; j< grapArr.length; j++ )
		               	{
	  	             		//grapArr[j].sum_price_acc = listArr[i]['c'+(Number(j)+1)];
	  	             		
	  	         		 listArr[i]['c'+(Number(j)+1)] = grapArr[j].sum_no_price_acc;
	  	             
	  	             		 if(j == 0 )
	  	             		{
	  	             			 listArr[i]['c'+(Number(j)+1)] = Number(listArr[2]['c'+(Number(j)+1)]) + Number(grapArr[j].prev_no_price);
	 	  	             		
	             			 }else
	             			{
	             				listArr[i]['c'+(Number(j)+1)] = Number(listArr[2]['c'+(Number(j)+1)]) + Number(listArr[i]['c'+j]);
		  	             		
	             			}
	  	             		listArr[i].p = Number(listArr[2]['c'+(Number(j)+1)]) + Number(listArr[i]['c'+j]);	
	  	             		
// 	  	             		if(Number(max_total_price5) < Number(listArr[i].p)){
// 	  	             			max_total_price5 = listArr[i].p ;
//         					}
		               	} 
	  	             	
  	            	}
                  	
                  	
                  }
                      
                     console.log("아이유 max_total_price2:::"+max_total_price2);   
                     max_total = Number(max_total_price2) - Number(max_total_price5)
                     console.log("1max_total:::"+max_total)
                     
                     if(max_total < 0){
                    	 max_total = Number(max_total_price5)
                    	 console.log("2max_total:::"+max_total)
                     }else if(max_total > 0 || max_total==0){
                    	 max_total = Number(max_total_price2) 
                    	 console.log("3max_total:::"+max_total)
                     }
                     
                     max_total_price2 = Number(max_total_price2) + Number(max_total_price2)/10;
                     max_total_price3 = Number(max_total_price3) + Number(max_total_price3)/10;
                     max_total_price4 = Number(max_total_price4) + Number(max_total_price4)/10;
                     
                     max_total_price5 = Number(max_total_price5) + Number(max_total_price5)/10;
                     
                     max_total = Number(max_total) + Number(max_total)/10;
                     console.log("4max_total:::"+max_total)
                
                 	 console.log("탓따------------------------ : "  + listArr.length);
                      w2ui['grid_list'].records = listArr;
                      console.log("아이유")
                      chartLength = chartData.length;
                      console.log("아이유")
                      makeLayout();
                      fnLoadChart(chartData);
                      console.log("chartData--------------------------------");
                      console.table(chartData);
               
             
               } else {
            	   
            	  w2ui.grid_list.clear();
            	   
                  console.log('check');
                  
                  var b = [];
                  document.getElementById("chart1").setData(b);
                  makeLayout();
                  
                  fnLoadChart(new Array());
                  
                  rMateChartH5.call("chart1", "hasNoData", true);               
               }
               
               
   				
            },complete: function () {
            	
            	w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
               
            }
         });
         
         
  
      }
      

      
      function loadList_graph() {
         console.log("loadList_graph()");
         
         var grapArr2 = new Array();
         chartData2 = new Array();
         
         var customer_code = $("#customer_code").val();
         var customer_integration_code = $("#customer_integration_code").val();
         var year = $("#date").val();
         var gubun = $("#gubun").val();
         
         var page_url = "/frontend/repair/selectSalesGraph";
         if(gubun == ''){
        	 page_url = "/frontend/repair/selectSalesGraph";
         }
         else if(gubun == 'no')
         {
         	 page_url = "/frontend/repair/selectSalesGraph_no"; 
         }else if(gubun == 'ju')
         {
         	 page_url = "/frontend/repair/selectSalesGraph_ju"; 
         }
         var postData = "customer_code=" + encodeURIComponent( customer_code )
         				 +"&customer_integration_code=" + encodeURIComponent(customer_integration_code)
				         +"&year=" + encodeURIComponent(year)
				         +"&gubun=" + encodeURIComponent(gubun);
         
         
         var result ;
         
         
         $.ajax({
            url : page_url,
            type : 'POST',
            data : postData, 
            dataType : 'json',
            success : function( data ) {
            	console.log('result aaa');
               if(data.status == 200 && (data.rows).length>0 ) {
            	   
            	   	grapArr2 = new Array();
            	   
                   	chartData2 = new Array();
                  	//console.table(data.rows);
                  	result = data.rows;
                  	console.log('result aaa');
	                console.log('size : ' + result.length);
	                console.log('result[0].year : ' + result[0].year);
                  if(result.length == 1 && result[0].year == '')
               	 {
                	  var dddd = [];
                      document.getElementById("chart2").setData(dddd);
                      makeLayout2();
                      fnLoadChart2(new Array());
                      rMateChartH5.call("chart2", "hasNoData", true);      
                      return;
                }
                  console.table(result);
                  console.log("row.기타");
                  
                  for(var i = 1; i<= 12; i++)	
                  {
                     var grapObj = new Object();
                     grapObj.month = i;
                     grapObj.customer_code = 0;
                     grapObj.sum_price = 0;
                     grapObj.customer_nm = 0;
                          
                     grapArr2.push(grapObj);
                     console.log('result aaa');
                     
                  } 
                  
                  setTimeout(function () {
                     console.log('result aaa');
                     console.table(result); 
                     
                  
                     var max_total_price = 0;
                     for(var i = 0 ; i < result.length; i++){
                     
                        var grapObj = new Object();
                        
                        grapObj.customer_code = result[i].customer_code;
                        grapObj.customer_nm = result[i].customer_nm;
                        grapObj.sum_price = result[i].sum_price;
                        
                        grapObj.month = result[i].month;
                        
                        grapArr2.push(grapObj);
                        
                     }
               
                     chartData2 = grapArr2;
                     
                     chartLength = chartData.length;
                     
                     console.log(chartLength);
                     
                     
                     makeLayout2();
                     fnLoadChart2(); 
                     
                     //checkData(chartData2); 
                     
               
                  }, 500);
               } else {
            	
                  var dddd = [];
                  document.getElementById("chart2").setData(dddd);
                  makeLayout2();
                  fnLoadChart2(new Array());
                  rMateChartH5.call("chart2", "hasNoData", true);      
                  
               }
               
            },complete: function () {
               
               
            }
         });
         
      
         
      
      
//          hidePreloader();
         //checkData(chartData); // 데이터가 존재하는지 판별한다.
      }
      
	
      
      function loadList_graph_after(month) {
         console.log("loadList_graph()");
         
         var grapArr2 = new Array();
 
         chartData2 = new Array();

         var customer_code = $("#customer_code").val();
         var customer_integration_code = $("#customer_integration_code").val();
         var year = $("#date").val();
         var gubun = $("#gubun").val();
         
         var page_url = "/frontend/repair/selectSalesGraph";
         if(gubun == ''){
        	 page_url = "/frontend/repair/selectSalesGraph";
         }
         else if(gubun == 'no')
         {
         	 page_url = "/frontend/repair/selectSalesGraph_no"; 
         } else if(gubun == 'ju')
         {
         	 page_url = "/frontend/repair/selectSalesGraph_ju"; 
         }
         var postData = postData = "customer_code=" + encodeURIComponent( customer_code )
						         +"&customer_integration_code=" + encodeURIComponent(customer_integration_code)
        						 +"&year=" + encodeURIComponent(year)
						         +"&month=" + encodeURIComponent(month)
						         +"&gubun=" + encodeURIComponent(gubun);
         
         
         var result ;
         
         
         $.ajax({
            url : page_url,
            type : 'POST',
            data : postData, 
            dataType : 'json',
            success : function( data ) {
               if(data.status == 200 && (data.rows).length>0 ) {
            	   
            	   grapArr2 = new Array();
            	   
                   chartData2 = new Array();
                  //console.table(data.rows);
                  result = data.rows;
      
                  console.log('result.length  : ' + result.length );
                  if(result.length == 1 && result[0].year == '')
                  {
                 	  var dddd = [];
                       document.getElementById("chart2").setData(dddd);
                       makeLayout2();
                       fnLoadChart2(new Array());
                       rMateChartH5.call("chart2", "hasNoData", true);      
                       return;
                  }
                  
                  for(var i = 1; i<= 12; i++)
                  {
                     var grapObj = new Object();
                     grapObj.month = i;
                     grapObj.customer_code = 0;
                     grapObj.sum_price = 0;
                     grapObj.customer_nm = 0;
                          
                     grapArr2.push(grapObj);
                     
                  }
                  
                  setTimeout(function () {
                     console.log('result');
                     console.table(result); 
                     
                  
                     var max_total_price = 0;
                     for(var i = 0 ; i < result.length; i++){
                     
                        var grapObj = new Object();
                        
                        grapObj.customer_code = result[i].customer_code;
                        grapObj.customer_nm = result[i].customer_nm;
                        grapObj.sum_price = result[i].sum_price;
                        
                        grapObj.month = result[i].month;
                        
                        grapArr2.push(grapObj);
                        
                        
                     }
               
                     /* chartData2 = [   
                                   { 
                                    account_nm:"하이닉스", account_code:"AA-1234",  total_price:"1900", in_price:"2000", no_price:"2300"},
                                   {
                                    account_nm:"하이닉스2", account_code:"E17908877",  total_price:"2400", in_price:"2000", no_price:"2300"},
                                   {
                                    account_nm:"하이닉스3", account_code:"E17908866", total_price:"900", in_price:"2000", no_price:"2300"}   
                              ]; */
                     
                     chartData2 = grapArr2;
                     
                     chartLength = chartData.length;
                     
                     console.log(chartLength);
                     
                     
                     makeLayout2();
                     fnLoadChart2(); 
                     
                     //checkData(chartData2); 
                     
               
                  }, 500);
               } else {
                  var d = [];
                  document.getElementById("chart2").setData(d);
                  makeLayout2();
                  fnLoadChart2(new Array());
                  rMateChartH5.call("chart2", "hasNoData", true);      
                  
               }
               
            },complete: function () {
               
               
            }
         });
         
      
         
      
      
//          hidePreloader();
         //checkData(chartData); // 데이터가 존재하는지 판별한다.
      }
      
      
      function loadList_down(){
         console.log('loadList_down()');
         
         var customer_code = $("#customer_code").val();
         var customer_integration_code = $("#customer_integration_code").val();
         var year = $("#date").val();
         var gubun = $("#gubun").val();
         
         var page_url = "/frontend/repair/selectSalesGrid2";
         if(gubun == '')
         {
         	 page_url = "/frontend/repair/selectSalesGrid2"; 
         } 
         else if(gubun == 'no')
        {
        	 page_url = "/frontend/repair/selectSalesGrid2_no"; 
        } else if(gubun == 'ju')
        {
       	 page_url = "/frontend/repair/selectSalesGrid2_ju"; 
        }
		var postData = "customer_code=" + encodeURIComponent( customer_code )
				        +"&customer_integration_code=" + encodeURIComponent( customer_integration_code )
						+"&year=" + encodeURIComponent(year)
				        +"&gubun=" + encodeURIComponent(gubun);
         
         
         

         try{
            
            w2ui.grid_list2.selectNone();
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
                  
                  var total = [];
                  var hap22222 = 0;
                  $.each(rowArr, function(idx, row){
                     row.recid = idx+1;
                     total[idx] = row.sum_price;
                     hap22222 = parseInt(hap22222) + parseInt(row.sum_price);
                     row.success_status = Number(row.success_status);
                     
                     row.sum_price = Number(row.sum_price);
                     
                  });
                  
                  for(var i = 0; i < rowArr.length; i++){
                	  console.log("total[i]----" +total[i]);
                	 
                	  var per = ((parseInt(total[i])*100) / parseInt(hap22222)).toFixed(0); 
                	  rowArr[i].success_status = per;
                	  console.log("rowArr[i].success_status?" + rowArr[i].success_status);
                  }
                  
                
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
         //loadList_graph(month);
      }
      
      function loadList_down_after(month){
          console.log('loadList_down()');
          
          
          var customer_code = $("#customer_code").val();
          var year = $("#date").val();
          var gubun = $("#gubun").val();
          
          var page_url = "/frontend/repair/selectSalesGrid2";
          if(gubun == '')
          {
          	 page_url = "/frontend/repair/selectSalesGrid2"; 
          } 
          else  if(gubun == 'no')
          {
          	 page_url = "/frontend/repair/selectSalesGrid2_no"; 
          } else if(gubun == 'ju')
          {
         	 page_url = "/frontend/repair/selectSalesGrid2_ju"; 
          }
 		var postData = "customer_code=" + encodeURIComponent( customer_code )
				         +"&year=" + encodeURIComponent(year)
				          +"&month=" + encodeURIComponent(month)
				          +"&gubun=" + encodeURIComponent(gubun);
          
          

          try{
             
             w2ui.grid_list2.selectNone();
             //w2ui['grid_list'].lock('loading...', true);
          }catch(e)
          {
             
          }
          w2ui['grid_list2'].lock('loading...', true);
          $.ajax({
             url : page_url,
             type : 'POST',
             data : postData, 
             dataType : 'json',
             async : false,   
             success : function( data ) {
                if(data.status == 200 && (data.rows).length>0 ) {
                   rowArr = data.rows;
                   
                   var total = [];
                   var hap22222 = 0;
                   $.each(rowArr, function(idx, row){
                      row.recid = idx+1;
                      total[idx] = row.sum_price;
                      hap22222 = parseInt(hap22222) + parseInt(row.sum_price);
                      row.success_status = Number(row.success_status);
                      row.sum_price = Number(row.sum_price);
                      
                   });
                   
                   for(var i = 0; i < rowArr.length; i++){
                 	  console.log("total[i]----" +total[i]);
                 	 
                 	  var per = ((parseInt(total[i])*100) / parseInt(hap22222)).toFixed(0); 
                 	  rowArr[i].success_status = per;
                 	  console.log("rowArr[i].success_status?" + rowArr[i].success_status);
                   }
                   
                 
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
      
      function loadList_down_after2(month, customer_code){
          console.log('loadList_down()');
          
          console.log('customerCode??' + customer_code);
          
         // var customer_code = $("#customer_code").val();
          var year = $("#date").val();
          var gubun = $("#gubun").val();
          
          var page_url = "/frontend/repair/selectSalesGrid2";
          if(gubun == '')
          {
          	 page_url = "/frontend/repair/selectSalesGrid2"; 
          }
          else if(gubun == 'no')
          {
          	 page_url = "/frontend/repair/selectSalesGrid2_no"; 
          } else if(gubun == 'ju')
          {
         	 page_url = "/frontend/repair/selectSalesGrid2_ju"; 
          }
 		var postData = "customer_code=" + encodeURIComponent( customer_code )
				         +"&year=" + encodeURIComponent(year)
				          +"&month=" + encodeURIComponent(month)
				          +"&gubun=" + encodeURIComponent(gubun);
          
          

          try{
             
             w2ui.grid_list2.selectNone();
             //w2ui['grid_list'].lock('loading...', true);
          }catch(e)
          {
             
          }
          w2ui['grid_list2'].lock('loading...', true);
          $.ajax({
             url : page_url,
             type : 'POST',
             data : postData, 
             dataType : 'json',
             async : false,   
             success : function( data ) {
                if(data.status == 200 && (data.rows).length>0 ) {
                   rowArr = data.rows;
                   
                   var total = [];
                   var hap22222 = 0;
                   $.each(rowArr, function(idx, row){
                      row.recid = idx+1;
                      total[idx] = row.sum_price;
                      hap22222 = parseInt(hap22222) + parseInt(row.sum_price);
                      row.success_status = Number(row.success_status);
                      row.sum_price = Number(row.sum_price);
                      
                   });
                   
                   for(var i = 0; i < rowArr.length; i++){
                 	  console.log("total[i]----" +total[i]);
                 	 
                 	  var per = ((parseInt(total[i])*100) / parseInt(hap22222)).toFixed(0); 
                 	  rowArr[i].success_status = per;
                 	  console.log("rowArr[i].success_status?" + rowArr[i].success_status);
                   }
                   
                 
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
      
      function grid_list_tot()
      {
         
         setTimeout(function(){
               w2ui['grid_list2'].resize();
               w2ui['grid_list2'].refresh();

            }, 200);
         
         var rowArr3 = w2ui['grid_list2'].records; 
         
         var tot = 0;   
         
         
         currentRecid = Number(i) + 1;
         
         console.log("lenght?????" + rowArr3.length);

         for(var i = 0; i < rowArr3.length; i ++)
         {
            var data = rowArr3[i];
            
            console.log("00000000000000000000");
            
            var tot_2 = data.sum_price;
            
            if(tot_2 == 0 || tot_2 == null || tot_2 == 'NaN' || tot_2 == "undefined")
            {
               tot_2 = 0;
            }
             
            tot = tot + parseInt(data.sum_price);
         }
         
         
         var result = Math.floor((tot_2) / Number(tot)*100)
         
         return result;
         
         console.log("result????" + result);
                              
         //w2ui['grid_list2'].set('g1',{ tot_price : tot_price});
         
      }
      
      
      
      /* function loadList2(){
         console.log("loadList2()");
         
         chartData2 = [
                      {recid: 1, 
                        gb:"하이닉스", c1:"AA-1234", c2:"CCC", c3:"1900", c4:"30" },
                       {recid: 2, 
                          gb:"하이닉스2", c1:"E17908877", c2:"CCC", c3:"2400", c4:"40" },
                       {recid: 3, 
                          gb:"하이닉스3", c1:"E17908866", c2:"CCC", c3:"900", c4:"60" }   
         ];
         
         w2ui['grid_list2'].records = chartData2;

         w2ui['grid_list2'].refresh();
         w2ui['grid_list2'].unlock();
         
         chartLength = chartData2.length;
         console.log("chartLength = " + chartLength);
         console.log("chartData2");
         console.log( chartData2 );
         
         makeLayout2();
         fnLoadChart2();
      } */
      
      
      function fnLoadChart(chartData) {
         rMateChartH5.create("chart1", "chartHolder", "", "100%", "100%");
         
         rMateChartH5.calls("chart1", {
               "setLayout" : layoutStr,
                "setData" : chartData
         });
      }
      
      function fnLoadChart2() {
         rMateChartH5.create("chart2", "chartHolder2", "", "100%", "100%");
         
         rMateChartH5.calls("chart2", {
               "setLayout" : layoutStr2,
                "setData" : chartData2
         });
      }
      function getResultPer(value){
		 	var val1 = w2ui.grid_list.get(2)[value];

			
			if(val1 == 0 || val1 == null || val1 == 'NaN' || val1 == "undefined")
			{
				return 0+"%";
			}
			
		}
    function axisLabelFunc(id, value){
  	  //var s = insertComma(value);
  		return value / 100000000 +"억";
  	}
       
     function axisLabelFunc2(id, value){
   	  //var s = insertComma(value);
   		return value / 100000000 +"억";
   	}
      
  var current_month = '';
  function gridData (seriesId, displayText, index, data, values) {
		console.log("gridData()");
		
		var valMonth = values[0];
		
		var month = valMonth.replace('월',"");
		current_month = month;
		console.log("month?" + month);
		
		w2ui['grid_list2'].refresh();
        w2ui['grid_list2'].unlock();
        w2ui['grid_list2'].clear();
		
		loadList_graph_after(month);
      	loadList_down_after(month);
	}
  
  function gridData2 (seriesId, displayText, index, data, values) {
		console.log("gridData2()");
		
		var customer_code = data.customer_code;
		var month = current_month;
		
		console.log("customerCode는?" + customer_code);
		console.log("month?" + month);
		
		w2ui['grid_list2'].clear();
		w2ui['grid_list2'].refresh();
		loadList_down_after2(month, customer_code);
	}
      
      
      //-------------------------------------------------------------------------------------------------------------------
      function makeLayout() {
         var date = $("#date option:selected").val();
         var gubun = $("#gubun").val();
         console.log("max_total_price2:::"+max_total_price2)
         if(gubun == ''){
	             layoutStr =
	                  '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
	                    +'<Options>'
	                        +'<Caption text="'+date+'년 매출 실적 그래프"/>'
	                        +'<SubCaption text="--" textAlign="center" />'
	                         +'<Legend useVisibleCheck="true"/>'
	                     +'</Options>'
	                     +'<CurrencyFormatter id="numFmt" currencySymbol="억" alignSymbol="right"/>'
	                   //+'<Combination2DChart showDataTips="true" itemClickJsFunction="gridData" selectionMode="single" paddingTop="0">'
	                   + '<Column2DChart showDataTips="true" itemClickJsFunction="gridData" columnWidthRatio="0.55" dataTipDisplayMode="axis">'
	                         +'<horizontalAxis>'
	                             +'<CategoryAxis categoryField="month" padding="0.2"/>'
	                         +'</horizontalAxis>'
	                          
	                         +'<verticalAxis>'
	                              +'<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0"/>'
	                         +'</verticalAxis>'
	                         
	                         +'<series>'
// 	                            +'<Column2DSet type="clustered">'
// 	                            +'<series>'
// 	                            +'<Column2DSeries labelPosition="gb" yField="sum_price" displayName="매출액">'
// 	                              +'<fill>'
// 	                                 +'<SolidColor color="#68cbf0"/>'
// 	                              +'</fill>'

	                                  
// 	                                +'<showDataEffect>'
// 	                                   +'<SeriesInterpolate/>'
// 	                               +'</showDataEffect>'
// 	                          +'</Column2DSeries>'
	                          
	                          
	                          
// 	                          +'<Column2DSeries yField="sum_price_acc" visible="true">'
// 	                              +'<fill>'
// 	                                 +'<SolidColor color="#2112ad" alpha="0"/>'
// 	                              +'</fill>'
// //	                                  +'<verticalAxis>'
// //	                                +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total_price2 +'"/>'
// //	                             +'</verticalAxis>'
	                            
	                           
// 	                                +'<showDataEffect>'
// 	                                   +'<SeriesInterpolate/>'
// 	                               +'</showDataEffect>'
// 	                          +'</Column2DSeries>'
// 	                          +'</series>'
// 	                            +'</Column2DSet>'
	                            
// 	                            //하나더
// 	                           +'<Column2DSet type="clustered"> '
// 	                            +'<series showDataTips="false">'
// 	                            +'<Column2DSeries yField="+sum_price+" labelPosition="gb" >'
// 	                            +'<fill>'
// 	                              +'<SolidColor color="#2112ad" alpha="0" />'
// 	                           +'</fill>'

// 	                          +'</Column2DSeries>'
	                          
	                          
	                          
// 	                          +'<Column2DSeries yField="sum_price_acc" displayName="누적 매출액" visible="true">'
// 	                              +'<fill>'
// 	                                 +'<SolidColor color="#2112ad" />'
// 	                              +'</fill>'
// 	                                 +'<verticalAxis>'
// 	                               +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total +'"/>'
// 	                            +'</verticalAxis>'
	                            
	                           
// 	                                +'<showDataEffect>'
// 	                                   +'<SeriesInterpolate/>'
// 	                               +'</showDataEffect>'
// 	                          +'</Column2DSeries>'
// 	                          +'</series>'
// 	                            +'</Column2DSet>'
	                            
	                               +'<Column2DSeries labelPosition="gb" yField="sum_price" displayName="매출액">'
        +'<showDataEffect>'
        +' <SeriesInterpolate/>'
        +' </showDataEffect>'
        +'  </Column2DSeries>'

        +'  <Column2DSeries yField="sum_price_acc" displayName="누적 매출액" >'
        +'   <showDataEffect>'
        +'        <SeriesInterpolate/>'
        +'       </showDataEffect>'
        +'<verticalAxis>'
        +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total +'"/>'
     +'</verticalAxis>'
        +'   </Column2DSeries>'
	                            //
	                            
	                            
	                            
	                            
	                              +'<Line2DSeries yField="goal" fill="#ffffff" radius="5" displayName="목표금액(월)" itemRenderer="CircleItemRenderer">'
	                                 +'<lineStroke>'
	                                    +'<Stroke color="#ffd736" weight="2"/>'
	                                +'</lineStroke>'
	                                 +'<showDataEffect>'
	                                     +'<SeriesInterpolate/>'
	                                 +'</showDataEffect>'
	                            +'</Line2DSeries>'

	                            
	                            //누적그래프
	                               +'<Line2DSeries yField="goal_acc" fill="#ffffff" radius="5" displayName="누적목표금액" itemRenderer="CircleItemRenderer">'
	                             /* itemRenderer는 Circle입니다 */
	                              +'<lineStroke>'
	                                      +'<Stroke color="#fc4141" weight="2"/>'
	                                  +'</lineStroke>'

	                                 +'<verticalAxis>'
	                                  +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total_price2 +'"/>'
	                               +'</verticalAxis>'

	                            
	                                 +'<showDataEffect>'
	                                     +'<SeriesInterpolate/>'
	                                 +'</showDataEffect>'
	                            +'</Line2DSeries>'

	                          +'</series>'
	                          
	                          
	                       +'<verticalAxisRenderers>'
	                            
	                             +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="true">'  
	                             +'</Axis2DRenderer>'
	                            
	                             +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false">' 
	                             +'</Axis2DRenderer>'
	                            
	                       +'</verticalAxisRenderers>'
	                          
	                          /* hover시 선 뜨는거 유무 */
	                        +'<annotationElements>'
	                             +'<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
	                              +'</CrossRangeZoomer>'
	                          +'</annotationElements>'
	                    +'</Column2DChart>'
	               +'</rMateChart>';
            }else if(gubun == 'no'){
            	
            	layoutStr =
 	               '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
 	                 +'<Options>'
 	                +'<Caption text="'+date+'년 미출하 실적 그래프"/>'
 	                     +'<SubCaption text="--" textAlign="center" />'
 	                      +'<Legend useVisibleCheck="true"/>'
 	                  +'</Options>'
 	                  +'<CurrencyFormatter id="numFmt" currencySymbol="억" alignSymbol="right"/>'
 	                +'<Combination2DChart showDataTips="true" itemClickJsFunction="gridData" dataTipDisplayMode="axis" paddingTop="0">'
 	                    +'<horizontalAxis>'
 	                          +'<CategoryAxis categoryField="month" padding="0.2"/>'
 	                       +'</horizontalAxis>'
 	                       
 	                     +'<verticalAxis>'
 	                   		  +'<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0"/>'
 	                      +'</verticalAxis>'
 	                      
 	                      +'<series>'
 	        
 	                         +'<Column2DSet type="clustered">'
 	                         +'<series>'
 	                         +'<Column2DSeries labelPosition="gb" yField="no_price" displayName="미출하금액">'
 		                        +'<fill>'
 		                           +'<SolidColor color="#68cbf0"/>'
 		                        +'</fill>'
 		                          +'<showDataEffect>'
 		                             +'<SeriesInterpolate/>'
 		                         +'</showDataEffect>'
 		                    +'</Column2DSeries>'
 		                  
 		                    
 		                    +'</series>'
 		                      +'</Column2DSet>'
 		                      
 	                         
 	                         
 	                         //누적그래프
 	                            +'<Line2DSeries yField="sum_no_price_acc" fill="#ffffff" radius="5" displayName="누적미출하금액" itemRenderer="CircleItemRenderer">'
 	                          /* itemRenderer는 Circle입니다 */
 	                           +'<lineStroke>'
 	                                   +'<Stroke color="#4452a8" weight="2"/>'
 	                               +'</lineStroke>'
 	                               
 	                           	+'<verticalAxis>'
 	                            +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+prev_no_sum+'"/>'
 	                         +'</verticalAxis>'
 	                         
 	                              +'<showDataEffect>'
 	                                  +'<SeriesInterpolate/>'
 	                              +'</showDataEffect>'
 	                         +'</Line2DSeries>'
 				          
 	                       +'</series>'
 	                     	 +'<verticalAxisRenderers>'
 		                       +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="true">'
 		                         
 		                      +'</Axis2DRenderer>'
 		                      +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false">'
 		                        
 		                      +'</Axis2DRenderer>'
 		                 +'</verticalAxisRenderers>'
 	                       
 	                       /* hover시 선 뜨는거 유무 */
 	                     +'<annotationElements>'
 	                          +'<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
 	                           +'</CrossRangeZoomer>'
 	                       +'</annotationElements>'
 	                 +'</Combination2DChart>'
 	            +'</rMateChart>';
            	
            }else if(gubun == 'ju'){
            	
            	layoutStr =
  	               '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
  	                 +'<Options>'
  	               +'<Caption text="'+date+'년 주문 실적 그래프"/>'
  	                     +'<SubCaption text="--" textAlign="center" />'
  	                      +'<Legend useVisibleCheck="true"/>'
  	                  +'</Options>'
  	                  +'<CurrencyFormatter id="numFmt" currencySymbol="억" alignSymbol="right"/>'
  	                +'<Combination2DChart showDataTips="true" itemClickJsFunction="gridData" dataTipDisplayMode="axis" paddingTop="0">'
  	                    +'<horizontalAxis>'
  	                          +'<CategoryAxis categoryField="month" padding="0.2"/>'
  	                       +'</horizontalAxis>'
  	                       
  	                     +'<verticalAxis>'
  	                   		  +'<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0"/>'
  	                      +'</verticalAxis>'
  	                      
  	                      +'<series>'
  	        
  	                         +'<Column2DSet type="clustered">'
  	                         +'<series>'
  	                         +'<Column2DSeries labelPosition="gb" yField="ju_price" displayName="주문금액">'
  		                        +'<fill>'
  		                           +'<SolidColor color="#68cbf0"/>'
  		                        +'</fill>'
  		                          +'<showDataEffect>'
  		                             +'<SeriesInterpolate/>'
  		                         +'</showDataEffect>'
  		                    +'</Column2DSeries>'
  		                  
  		                    
  		                    +'</series>'
  		                      +'</Column2DSet>'
  		                      
  	                         
  	                         
  	                         //누적그래프
  	                            +'<Line2DSeries yField="sum_ju_price_acc" fill="#ffffff" radius="5" displayName="누적주문금액" itemRenderer="CircleItemRenderer">'
  	                          /* itemRenderer는 Circle입니다 */
  	                           +'<lineStroke>'
  	                                   +'<Stroke color="#4452a8" weight="2"/>'
  	                               +'</lineStroke>'
  	                               
  	                           	+'<verticalAxis>'
  	                            +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"  maximum="'+max_total_price4+'"/>'
  	                         +'</verticalAxis>'
  	                         
  	                              +'<showDataEffect>'
  	                                  +'<SeriesInterpolate/>'
  	                              +'</showDataEffect>'
  	                         +'</Line2DSeries>'
  				          
  	                       +'</series>'
  	                     	 +'<verticalAxisRenderers>'
  		                       +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="true">'
  		                         
  		                      +'</Axis2DRenderer>'
  		                      +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false">'
  		                        
  		                      +'</Axis2DRenderer>'
  		                 +'</verticalAxisRenderers>'
  	                       
  	                       /* hover시 선 뜨는거 유무 */
  	                     +'<annotationElements>'
  	                          +'<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
  	                           +'</CrossRangeZoomer>'
  	                       +'</annotationElements>'
  	                 +'</Combination2DChart>'
  	            +'</rMateChart>';
            	
            }
      }
      
      function makeLayout2() {
         var date = $("#date option:selected").val();
         var gubun = $("#gubun").val();
         
         var gubunT = "";
         
         if(gubun == ''){
        	 gubunT = '매출';
         }else if(gubun == 'no'){
        	 gubunT = '미출하';
         }else if(gubun == 'ju'){
        	 gubunT = '주문';
         }
         
         layoutStr2 =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
               +'<Options>'
               +'<Caption text="'+date+'년 '+gubunT+' 비율"/>'
                 +'<SubCaption text="--"/>'
                   +'<Legend useVisibleCheck="true"/>'
               +'</Options>'
             +'<CurrencyFormatter id="numFmt" currencySymbol="%" alignSymbol="right"/>'
                /*
              Pie3D 차트 생성시에 필요한 Pie3DChart 정의합니다
              showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.
                */
              +'<Pie3DChart showDataTips="true" itemClickJsFunction="gridData2"  depth="50" paddingLeft="100" paddingTop="50" paddingRight="100" paddingBottom="50">'
                   +'<series>'
                       +'<Pie3DSeries nameField="customer_nm" field="sum_price" labelPosition="inside" color="#ffffff" startAngle="240">'
                        /* Pie3DChart 정의 후 Pie3DSeries labelPosition="inside"정의합니다 */
                           +'<showDataEffect>'
                               /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
                                +'<SeriesInterpolate duration="1000"/>'
                               /*
                              SeriesInterpolate 효과는 시리즈 데이터가 데이터로 표시될 때 데이터의 변화된 내용을 가지고 효과를 적용합니다
                                - 공통 -
                              elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
                              minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
                                           이 값보다 짧은 시간에 effect가 실행되지 않습니다
                             offset : effect개시의 지연시간을 설정합니다 default:0
                                perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
                               */
                          +'</showDataEffect>'
                      +'</Pie3DSeries>'
                 +'</series>'
              +'</Pie3DChart>'
          +'</rMateChart>';
      }
      
      //-------------------------------------------------------------------------------------------------------------------
	function excelFileDownload()
		{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;
		
		var nm = "매출실적정보";
	
		var fileName = '매출실적정보.xlsx';
		var sheetTitle = '매출실적정보';
		var sheetName = '매출실적정보';
		
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
	console.log("excelFileDownload2()");
	var gridCols = w2ui['grid_list2'].columns;
	var gridData = w2ui['grid_list2'].records;
	
	var nm = "고객별매출실적정보";

	var fileName = '고객별매출실적정보.xlsx';
	var sheetTitle = '고객별매출실적정보';
	var sheetName = '고객별매출실적정보';
	
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
      
      
      
      function getFormatDate(d) {
         var month = d.getMonth() + 1;
         var date = d.getDate();
         month = (month < 10) ? "0" + month : month;
         date = (date < 10) ? "0" + date : date;
         return d.getFullYear() + '-' + month + '-' + date;
      }
      function initOptions(obj) {
          $(obj)
          .find('option')
          .remove()
          .end()
//             .append('<option value="All">-----</option>')
          .val();
      }
      
      function insertComma(n) {
    	  var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    	  n += "";
    	  while(reg.test(n))
    	    n = n.replace(reg, '$1' + "," + '$2');
    	  return n;
    	}
      

	
      
   </script>
</body>
</html>