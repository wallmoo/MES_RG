<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.set.util.*"%>
<% 
if(!SessionUtil.isLogIn(request)){
	//response.sendRedirect("/login");
}
%>
<link rel="shortcut icon" href="/res/images/common/v_favicon.ico">

<link rel="stylesheet" href="/res/admin_lte/css/VWfont.css" />
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet" href="/res/bootstrap/css/bootstrap.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/res/admin_lte/css/AdminLTE.css?v=<%=System.currentTimeMillis()%>">
<!-- AdminLTE Skins. Choose a skin from the css/skins
     folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="/res/admin_lte/css/skins/_all-skins.css?v=<%=System.currentTimeMillis()%>">
<!-- Morris chart -->
<link rel="stylesheet" href="/res/plugins/morris/morris.css">
<!-- jvectormap -->
<link rel="stylesheet" href="/res/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Date Picker -->
<link rel="stylesheet" href="/res/plugins/datepicker/datepicker3.css">
<!-- Daterange picker -->
<link rel="stylesheet" href="/res/plugins/daterangepicker/daterangepicker.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="/res/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
<link rel="stylesheet" href="/res/plugins/iCheck/all.css?v=<%=System.currentTimeMillis()%>">

<!-- JQueryUI -->
<link rel="stylesheet" href="/res/plugins/jQueryUI/jquery-ui.css">
<!-- JSTree -->
<link rel="stylesheet" href="/res/plugins/jstree/themes/default/style.css">
<!-- JQGrid -->
<link rel="stylesheet" href="/res/plugins/jqgrid/ui.jqgrid.css?v=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="/res/plugins/jqgrid/ui.jqgrid-bootstarp.css?v=<%=System.currentTimeMillis()%>" />

<!-- Select2 -->
<link rel="stylesheet" href="/res/plugins/select2/select2.css?v=<%=System.currentTimeMillis()%>">

<!-- Sumoselect -->
<link rel="stylesheet" href="/res/plugins/sumoselect/sumoselect.css?v=<%=System.currentTimeMillis()%>">

<!-- jQueryFileUpload -->
<link rel="stylesheet" href="/res/plugins/jQueryFileUpload/css/jquery.fileupload.css?v=<%=System.currentTimeMillis()%>">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

<!-- w2ui -->
<link rel="stylesheet" href="/res/plugins/w2ui/w2ui.css">

<!-- rMateGridH5 -->
<link rel="stylesheet" type="text/css" href="/res/plugins/rMateGridH5/Assets/rMateH5.css"/>

<!-- jQuery 3.1.1 -->
<script src="/res/plugins/jQuery/jquery-3.1.1.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/res/plugins/jQueryUI/jquery-ui.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.7 -->
<script src="/res/bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="/res/plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="/res/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="/res/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/res/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="/res/plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="/res/plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="/res/plugins/datepicker/bootstrap-datepicker.js?v=1"></script>
<script src="/res/plugins/datepicker/locales/bootstrap-datepicker.kr.js?v=1"></script>

<!-- Bootstrap WYSIHTML5 -->
<script src="/res/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="/res/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/res/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/res/admin_lte/js/adminlte.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/res/admin_lte/js/pages/dashboard.js?v=1"></script>

<script src="/res/plugins/iCheck/icheck.min.js?v=<%=System.currentTimeMillis()%>"></script>

<script src="/res/set/set_comm.js?v=<%=System.currentTimeMillis()%>"></script>

<!-- JQGrid -->
<script src="/res/plugins/jqgrid/i18n/grid.locale-en.js"></script>
<script src="/res/plugins/jqgrid/jquery.jqGrid.src.js?v=<%=System.currentTimeMillis()%>"></script>
<!-- JSTree -->
<script src="/res/plugins/jstree/jstree.min.js"></script>
<!-- Select2 -->
<script src="/res/plugins/select2/select2.full.min.js"></script>
<!-- sumoselect -->
<script src="/res/plugins/sumoselect/jquery.sumoselect.js"></script>

<!-- jQueryFileUpload -->
<script src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
<script src="//blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/jquery.iframe-transport.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/vendor/jquery.ui.widget.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/jquery.fileupload.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/jquery.fileupload-process.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/jquery.fileupload-image.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/jquery.fileupload-audio.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/jquery.fileupload-video.js"></script>
<script src="/res/plugins/jQueryFileUpload/js/jquery.fileupload-validate.js"></script>


<!-- w2ui -->
<script src="/res/plugins/w2ui/w2ui.js"></script>
<!-- lodash -->
<script src="/res/plugins/lodash-4.17.10/package/lodash.min.js"></script>

<!-- rMateGridH5 -->
<script type="text/javascript" src="/res/plugins/rMateGridH5/rMateGridH5License.js"></script>
<script type="text/javascript" src="/res/plugins/rMateGridH5/JS/rMateGridH5.js"></script>
<script type="text/javascript" src="/res/plugins/rMateGridH5/JS/jszip.min.js"></script>


<script type="text/javascript">
function FunLoadingBarStart() {
	var backHeight = $(document).height(); //뒷 배경의 상하 폭
	var backWidth = window.document.body.clientWidth; //뒷 배경의 좌우 폭
// 	var backWidth = $(document).width();
	
	var backGroundCover = "<div id='back'></div>"; //뒷 배경을 감쌀 커버
	var loadingBarImage = ''; //가운데 띄워 줄 이미지
	loadingBarImage += "<div id='loadingBar'>";
	loadingBarImage += " <img src='/res/images/common/loading1.gif'/>"; //로딩 바 이미지
	loadingBarImage += "</div>";
	$('body').append(backGroundCover).append(loadingBarImage);
	$('#back').css({ 'width': backWidth, 'height': backHeight, 'opacity': '0.3' });
	$('#back').show();
	$('#loadingBar').show();
}
function FunLoadingBarEnd() {
	$('#back, #loadingBar').hide();
	$('#back, #loadingBar').remove();
}
</script>

<style>
body {
	padding-right: 0px !important
}

.modal-open {
	overflow-y: auto;
}

#back{
/* position: absolute; */
/* z-index: 100; */
/* background-color: #000000; */
/* display:none; */
/* left:0; */
/* top:0; */

  position:absolute;  
  left:0;
  top:0;
  z-index:9000;  
  background-color:#000;  
  display:none; 
}
#loadingBar{
position:absolute;
left:45%;
top: 20%;
display:none;
z-index:9010;

border: 3px solid gold;
border-radius: 7px;
-moz-border-radius: 7px;
-khtml-border-radius: 7px;
-webkit-border-radius: 7px;
}

</style>