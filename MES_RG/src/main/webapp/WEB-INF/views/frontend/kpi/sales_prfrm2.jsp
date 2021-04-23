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
                        <button type="button" id="gridLoad" onclick="loadList();" class="btn btn-warning btn-sm">검색</button>
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
                           <div id="grid_list" style="width: 100%; height: 150px; "></div>
                        </div>
                        
                     
                        <div class="col-md-6 text-left" > <!-- center -->
                           <h3 class="" style="margin: 10px;">고객별 매출비율</h3><!-- -left -->
                        </div>
                  
                        <div class="col-md-6 text-left" >
                           <h3 class="" style="margin: 10px;">고객별 품목별 매출비율</h3>
                        </div>
                        
                        <div class="col-md-6">
                           <div id="chartHolder2" style="width: 100%; height: 350px; text-align: center; "></div>
                        </div>
                        
                        <div class="col-md-6" style="margin-top: 50px;">
                           <div id="grid_list2" style="width: 100%; height: 250px; "></div>
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
         $("#date").append("<option value='  " +(currYear-2) +"'>" + (currYear-2) + "</option>");
         $("#date").append("<option value=' " +(currYear-1) +"'>" + (currYear-1) + "</option>");
         $("#date").append("<option value='" +(currYear) +"'>" + currYear + "</option>");
         $("#date").append("<option value='" +(currYear+1) +"'>" + (currYear+1) + "</option>");
 		
 		 $("#date option:eq(2)").prop("selected", true);
         
         //$("#date").val(currYear).prop("selected", true);
          
//          initComponent(); // 달력

         fnAccount();

         initGridList(); // 첫 그리드
         grid_list2();
         
         loadList_down();
         
         //loadList();
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
         loadList();
         loadList_graph();
         loadList_down();
      });
      
      $("#date").change(function(){
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
         
         var postData;
         
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
       
      //-------------------------------------------------------------------------------------------------------------------
      function loadList(){
			console.log("loadList()");
			
			chartData = [
			             {recid: 1, 
			              gb:"수량", c1:"300", c2:"500", c3:"250", c4:"330", c5:"40", 
			              c6:"110", c7:"252", c8:"21", c9:"57", c10:"89", c11:"500", c12:"210", p:"2659"},
			              {recid: 2, 
				              gb:"시간", c1:"3", c2:"12", c3:"24", c4:"3", c5:"6", 
				              c6:"10", c7:"9", c8:"2", c9:"10", c10:"7", c11:"2", c12:"1", p:"89"},
			];
			
			w2ui['grid_list'].records = chartData;

			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
			
			chartData = new Array();
			
			for(var i = 1; i <=12; i ++)
			{
				var grapObj = new Object();
				grapObj.month = i + "월";
				
				grapObj.su = w2ui.grid_list.get(1)['c'+i];
				grapObj.time = w2ui.grid_list.get(2)['c'+i];
				
				chartData.push(grapObj);
			}
			
			chartLength = chartData.length;
			console.log("chartLength = " + chartLength);
			console.log("chartData");
			console.log( chartData );
			
			makeLayout();
			fnLoadChart();
	 }
      
      
      
      var grapArr2 = new Array();
      
      function loadList_graph() {
         console.log("loadList_graph()");
         
         var grapArr2 = new Array();
         chartData2 = new Array();
         
         var customer_code = $("#customer_code").val();
         var year = $("#date").val();
         
         var page_url = "/frontend/repair/selectSalesGraph";
         
         var postData = "customer_code=" + encodeURIComponent( customer_code )
                  +"&year=" + encodeURIComponent(year);
         
         var result ;
         
         
         $.ajax({
            url : page_url,
            type : 'POST',
            data : postData, 
            dataType : 'json',
            success : function( data ) {
               if(data.status == 200 && (data.rows).length>0 ) {
                  //console.table(data.rows);
                  result = data.rows;
      
                  console.table(result); 
                  
                  setTimeout(function () {
                     console.log('result');
                     console.table(result); 
                     
                  
                     var max_total_price = 0;
                     for(var i = 0 ; i < result.length; i++){
                     
                        var grapObj = new Object();
                        
                        grapObj.customer_code = result[i].customer_code;
                        grapObj.customer_nm = result[i].customer_nm;
                        grapObj.sum_price = result[i].sum_price;
                        
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
                     
                     
                     makeLayout2(max_total_price);
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
         var year = $("#date").val();
         
         var page_url = "/frontend/repair/selectSalesGrid2";
         
         var postData = "customer_code=" + encodeURIComponent(customer_code)
                  +"&year=" + encodeURIComponent(year);
         

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
      
      
      function fnLoadChart() {
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
  		return value + " 개";
  	}
      
      function axisLabelFunc2(id, value){
    		return value + " 시간";
    	}
      
      //-------------------------------------------------------------------------------------------------------------------
      function makeLayout() {
			var date = $("#date option:selected").val();
			layoutStr =
		         '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
	              +'<Options>'
	                  +'<Caption text="'+date+'년 매출 실적 그래프"/>'
	                  +'<SubCaption text="--" textAlign="center" />'
	                   +'<Legend useVisibleCheck="true"/>'
	               +'</Options>'
	             +'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
	                 +'<horizontalAxis>'
	                       +'<CategoryAxis categoryField="month" padding="0.2"/>'
	                    +'</horizontalAxis>'
	                         +'<verticalAxis>'
                                 +'<LinearAxis id="vAxis1" labelJsFunction="axisLabelFunc" minimum="0"/>'
                              +'</verticalAxis>'
	                    +'<series>'
	                    
	                       /*
	                      itemRenderer는 Tip이 보여지는 영역차트 부분에 ItemRenderer에서 제공하는 모양을 그려줍니다
	                      이 예제에서는 Diamond입니다
	                      사용할 수 있는 도형을 모두 표현한 예제는 Chart Samples 의 범례 예제를 참고하십시오.
	                      */
	                    
	                        +'<Line2DSeries labelPosition="up" yField="su" fill="#ffffff" radius="5" displayName="수량" itemRenderer="CircleItemRenderer">'
	                       /* itemRenderer는 Circle입니다 */
	                       
	                           +'<showDataEffect>'
	                               +'<SeriesInterpolate/>'
	                           +'</showDataEffect>'
	                      +'</Line2DSeries>'
	                     

	                        +'<Line2DSeries yField="time" fill="#ffffff" radius="5" labelJsFunction="axisLabelFunc2" displayName="시간" itemRenderer="CircleItemRenderer">'
	                       /* itemRenderer는 Circle입니다 */
	                      +'<verticalAxis>'
                                 +'<LinearAxis id="vAxis2" labelJsFunction="axisLabelFunc2" minimum="0"/>'
                              +'</verticalAxis>'
	                           +'<showDataEffect>'
	                               +'<SeriesInterpolate/>'
	                           +'</showDataEffect>'
	                      +'</Line2DSeries>'
	                      
	                    +'</series>'
	                    +'<verticalAxisRenderers>'
                        +'<Axis2DRenderer axis="{vAxis1}" showLine="false" verticalAxisTitleAlignment="top"/>'
                        +'<Axis2DRenderer axis="{vAxis2}" showLine="false" verticalAxisTitleAlignment="top">'
                         
                      +'</Axis2DRenderer>'
                  +'</verticalAxisRenderers>'
	                    /* hover시 선 뜨는거 유무 */
	                  +'<annotationElements>'
	                       +'<CrossRangeZoomer zoomType="horizontal" fontSize="11" color="#FFFFFF" verticalLabelPlacement="bottom" horizontalLabelPlacement="left" enableZooming="false" enableCrossHair="true">'
	                        +'</CrossRangeZoomer>'
	                    +'</annotationElements>'
	              +'</Line2DChart>'
	         +'</rMateChart>';
		}
      
      function makeLayout2() {
         var date = $("#date option:selected").val();
         
         layoutStr2 =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
               +'<Options>'
               +'<Caption text="'+date+'년 고객별 매출비율"/>'
                 +'<SubCaption text="--"/>'
                   +'<Legend useVisibleCheck="true"/>'
               +'</Options>'
             +'<CurrencyFormatter id="numFmt" currencySymbol="%" alignSymbol="right"/>'
                /*
              Pie3D 차트 생성시에 필요한 Pie3DChart 정의합니다
              showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.
                */
              +'<Pie3DChart showDataTips="true"  depth="50" paddingLeft="100" paddingTop="50" paddingRight="100" paddingBottom="50">'
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
      
   </script>
</body>
</html>