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
	<style type="text/css">
		.ui-datepicker table{display : none;}
	</style>
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
		<jsp:param name="selected_menu_cd" value="1026" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
		<h1>
			설비 관리 <small> 기준정보관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>기준정보관리 </a></li>
			<li class="active">설비 관리</li>
		</ol>
	</section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box" style="margin-bottom:0px; border: none;">
					<div id="" class="box-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="row">
									<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
										<div class="box-header with-border" style=" background-color: #DB8EB5;">
											<h3 class="box-title">조회 조건</h3>
											<div class="box-tools pull-right">
												<button type="button" id="btn_search_csr" onclick="excelDown();" class="btn btn-info btn-sm" onclick="">엑셀다운로드</button>
												<button type="button" id="btn_search_csr" onclick="openMod('ins');" class="btn btn-primary btn-sm" onclick="">등록</button>
												<button type="button" id="btn_search_csr" onclick="openMod('upd');" class="btn btn-primary btn-sm" onclick="">수정</button>
												<button type="button" id="btn_search_csr" onclick="delMachine();" class="btn btn-danger btn-sm" onclick="">삭제</button>
												<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning  btn-sm" onclick="">조회</button>	 
											</div>
										</div>
										<div class="box-body">
											<div class="row">
												<div class="form-group">
													<div class="col-sm-2">
														<label>설비명</label> <input type="combo" id="search_machine_nm" name="search_machine_nm" class="form-control input-sm" placeholder="설비명"
														onkeypress="if(event.keyCode==13) {loadList(); return false;}">
													</div>
												</div>
											</div>
											<div id="grid_list" class="w2g-h600" style="margin-top: 10px;"></div>
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

<div class="modal fade" id="modal_info" aria-hidden="true" style="display: none;"><!-- data-backdrop="static"> -->
		<div class="modal-dialog modal-md" >
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modal_title">등록 / 수정</h4>
	        	</div>
				<div class="modal-body" id="">
							<!-- frm_info -->
					<form id="frm_insertInfo" name="frm_insertInfo" class="form-horizontal">	
<!-- 						<input type="hidden" class="clear_field" id="mod_machine_code"/>				 -->
						<input type="hidden" id="fg_check_yn" name="fg_check_yn" value="N">
					
					
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">설비코드</label>
							<input type="text" class="col-sm-5 clear_field" id="mod_machine_code" />	
							<div class="col-sm-3">
		                  		<button type="button" id="btn_check" class="btn btn-primary btn-sm">설비코드 중복체크</button>
		                   </div>
						</div>
						
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">설비명</label>
							<input type="text" class="col-sm-4 clear_field" id="mod_machine_nm" />	
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">설비유형</label>
							<div class="col-sm-9 clear_field" style="padding-left:0;">
								<select id="mod_machine_class_nm" name="mod_machine_class_nm" style="height:30px;" class="col-sm-5" onchange="">
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">Main 매칭공정</label>
<!-- 							<input type="text" class="col-sm-4 clear_field" id="machine_management_num" />	 -->
								<select id="mod_matching_routing_code" name = "mod_matching_routing_code" style="height:30px;" class="col-sm-5" onchange="">
								</select>
						</div>
						
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">Sub 매칭공정</label>
								<select id="mod_sub_matching_routing_code" name = "mod_sub_matching_routing_code" style="height:30px;" class="col-sm-5" onchange="">
								</select>
						</div>
						
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">제작사</label>
							<input type="text" class="col-sm-8 clear_field" id="mod_machine_maker" />	
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">규격</label>
							<input type="text" class="col-sm-8 clear_field" id="mod_machine_standard" />	
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">모델</label>
							<input type="text" class="col-sm-8 clear_field" id="mod_machine_model" />	
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">설명</label>
							<input type="text" class="col-sm-8 clear_field" id="mod_machine_dscr" />	
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label ">제조년월</label>
							<input type="text" class="col-sm-3 clear_field dp_component_mo" id="mod_machine_making_date" />	
							<h4 class="col-sm-6 col-form-label">Display 유무</h5>
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">취득단가</label>
							<input type="text" class="col-sm-3 clear_field" id="mod_machine_acq_price" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>	
							<label for="rdo_mretire_yn" class="col-sm-2 control-label" style="text-align:left;">모니터링</label>
							<div class="col-sm-2" style="padding-top: 7px;">
								<label style="margin-right: 10px;"> <input
									type="radio" id="rdo_monitoring_Y"
									name="rdo_monitoring_yn" class="flat-red" value="Y"
									checked="checked">
									Y
								</label>
							</div>
							<div class="col-sm-2" style="padding-top: 7px;">
								<label style="margin-right: 10px;"> <input
									type="radio" id="rdo_monitoring_N"
									name="rdo_monitoring_yn" class="flat-red" value="N">
									N
								</label>
							</div>
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">구입일자</label>
							<input type="text" class="col-sm-3 clear_field dp_component_d" id="mod_machine_purchase_date" />	
							<label for="rdo_mretire_yn" class="col-sm-2 control-label" style="text-align:left;">가동률</label>
							<div class="col-sm-2" style="padding-top: 7px;">
								<label style="margin-right: 10px;"> <input
									type="radio" id="rdo_rate_Y"
									name="rdo_rate_yn" class="flat-red" value="Y"
									checked="checked">
									Y
								</label>
							</div>
							<div class="col-sm-2" style="padding-top: 7px;">
								<label style="margin-right: 10px;"> <input
									type="radio" id="rdo_rate_N"
									name="rdo_rate_yn" class="flat-red" value="N">
									N
								</label>
							</div>
						</div>
						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label">매각일자</label>
							<input type="text" class="col-sm-3 clear_field dp_component_d" id="mod_machine_sale_date" />	
							<label for="rdo_mretire_yn" class="col-sm-2 control-label" style="text-align:left;">히스토리</label>
							<div class="col-sm-2" style="padding-top: 7px;">
								<label style="margin-right: 10px;"> <input
									type="radio" id="rdo_history_Y"
									name="rdo_history_yn" class="flat-red" value="Y"
									checked="checked">
									Y
								</label>
							</div>
							<div class="col-sm-2" style="padding-top: 7px;">
								<label style="margin-right: 10px;"> <input
									type="radio" id="rdo_history_N"
									name="rdo_history_yn" class="flat-red" value="N">
									N
								</label>
							</div>
						</div>
					</form>
					
				</div>
				
				<div class="modal-footer">
					<div class="col-md-12 text-center">
						<button type="button" id="btn_mod_save" class="btn btn-success btn-sm">저장</button>
						<button type="button" id="btn_mod_cancel" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
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
comboValue_nm = new Array;
var startValue_combo = "";

$(function($) {
	
	loadCommFn();
	
	fnCdD('mod_machine_class_nm', 'MC1021');
	
	
 	loadGrid();
 	loadList();
})

function loadCommFn(){
	/* $('.dp_component').datepicker({
			format: 'yyyy.MM', // inputbox 에 '2011/04/29' 로표시
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			showMonthAfterYear: true,
			yearSuffix: '년',
			orientation: "top left"
	}); */
	
		$('.dp_component_mo').datepicker({
			language: 'kr',
			autoclose:true,
			viewMode: 'months',
		    minViewMode: 'months',
			format:'yyyy-mm'
		}).on('show', function(e) {
			$('.datepicker').css('z-index', '9999');
		});
		
		$('.dp_component_d').datepicker({
			language: 'kr',
			autoclose:true,
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			format:'yyyy-mm-dd'
		}).on('show', function(e) {
			$('.datepicker').css('z-index', '9999');
		});
		$('.dp_component_d').datepicker('setDate', moment().format('YYYY-MM-DD'));
}

$("#mod_machine_code").change(function(){
	$("#fg_check_yn").val("N");
});

$('input[type="radio"].flat-red').iCheck({
	checkboxClass : 'icheckbox_flat-green',
	radioClass : 'iradio_flat-green',
	handle : 'radio'
});


$( "#btn_check" ).on('click', function(e) {
	e.preventDefault();
	if($.trim($("#mod_machine_code").val()).length == 0) {
		fnMessageModalAlert("알림", "설비코드를 입력하세요.");
		return;
	}
	
	fnCheckMachine();
});

function fnCheckMachine(){
	var machine_code = $("#mod_machine_code").val();
	var postData = "machine_code="+encodeURIComponent(machine_code);
  var formURL = "/info/machine/checkMachine";
  
  $.ajax({
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR){
      	if(data.status == "200") {
      		if(data.cnt > 0) {
      			$("#fg_check_yn").val("N");
      			fnMessageModalAlert("알림", "입력하신 설비 코드는 사용할 수 없습니다.(이미 사용중)");
      		} else {
      			$("#fg_check_yn").val("Y");
      			fnMessageModalAlert("알림", "입력하신 설비 코드는 사용할 수 있습니다.");
      		}
      	} else {
      		fnMessageModalAlert("알림", "입력하신 설비 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
      	}
      },
      error: function(jqXHR, textStatus, errorThrown){
        fnMessageModalAlert("알림", "입력하신 설비 코드 중복여부를 확인하는데 에러가 발생하였습니다.");	
      }
  });
}

// loadLeftGrid
function loadGrid(){
// 	 console.log('fnSetLoadWorkerGrid()');
	var rowArr = [];
	
	$('#grid_list').w2grid({ 
        name: 'grid_list',
        show: {
			lineNumbers : true,
            selectColumn: true
        },
        multiSelect: true,
        columns: [                
			{ field:'machine_code', caption:'설비코드', size:'12%',style:'text-align:center', sortable: true},
			{ field:'machine_nm', caption:'설비명', size:'16%',style:'text-align:center', sortable: true},
			{ field:'machine_class_nm', caption:'설비유형', size:'10%',style:'text-align:center', sortable: true},
			{ field:'machine_class_code', caption:'설비유형코드',size:'16%', style:'text-align:center', hidden:true},
			{ field:'matching_routing_nm', caption:'Main 매칭공정', size:'16%', style:'text-align:center', sortable: true},
			{ field:'matching_routing_code', caption:'Main 매칭공정', size:'16%', style:'text-align:center', hidden: true},
			{ field:'sub_matching_routing_nm', caption:'Sub 매칭공정', size:'16%', style:'text-align:center', sortable: true},
			{ field:'sub_matching_routing_code', caption:'Sub 매칭공정', size:'16%', style:'text-align:center', hidden: true},
			{ field:'machine_maker', caption:'제작사', size:'16%', style:'text-align:center', sortable: true},
			{ field:'machine_standard', caption:'규격', size:'18%', style:'text-align:center', sortable: true},
			{ field:'machine_model', caption:'모델', size:'16%', style:'text-align:center', sortable: true},
			{ field:'machine_dscr', caption:'설명', size:'16%', style:'text-align:center', sortable: true},
			{ field:'machine_making_date', caption:'제조년월', size:'10%', style:'text-align:center', sortable: true},
			{ field:'machine_acq_price', caption:'취득단가', size:'10%', style:'text-align:center', sortable: true
				,render: function (record, index, col_index) {
	       	        var html = this.getCellValue(index, col_index);
	
	              html = w2utils.formatters['number'](html);
	              html = setComma(html);
	                  return html;
	              }	
			},
			{ field:'machine_purchase_date', caption:'구입일자', size:'10%', style:'text-align:center', sortable: true},
			{ field:'machine_sale_date', caption:'매각일자', size:'10%', style:'text-align:center', sortable: true},
			
			{ field:'display_monitoring', caption:'모니터링', size:'7%', style:'text-align:center', sortable: true},
			{ field:'display_rate', caption:'가동률', size:'7%', style:'text-align:center', sortable: true},
			{ field:'display_history', caption:'히스토리', size:'7%', style:'text-align:center', sortable: true}
			], 
		sortData: [{field: 'machine_code', direction: 'ASC'}],
		records: [
			], // rowArr
		onSelect: function (event) {
			event.onComplete = function () {
			}
		},
		onUnselect: function (event) {
		},
		onClick: function (event) {
// 		 	grid_list3(); // 클릭 이벤트
		}
	});
}

function openMod(mode){
	// selectCdD2 // machine인 얘만
	fnCdD('mod_matching_routing_code', 'MC1015');
	
	if(mode == 'ins'){
		w2ui.grid_list.selectNone();
		$('.clear_field').val('');
		$('.clear_field.dp_component_d').datepicker('setDate', moment().format('YYYY-MM-DD'));
		
		$("#mod_machine_code").attr('disabled',false);
 		$("#btn_check").show();
 		$("#fg_check_yn").val("N");
 		$("#mod_machine_code").val('');
 		$("#mod_machine_acq_price").val('');
 		$("#mod_machine_sale_date").val('');
 		
 		$(':radio[name="rdo_monitoring_yn"][value="Y"]').iCheck('check');
		$(':radio[name="rdo_monitoring_yn"]').iCheck('update');
		
		$(':radio[name="rdo_rate_yn"][value="Y"]').iCheck('check');
		$(':radio[name="rdo_rate_yn"]').iCheck('update');
		
		$(':radio[name="rdo_history_yn"][value="Y"]').iCheck('check');
		$(':radio[name="rdo_history_yn"]').iCheck('update');
	}
	
	if(mode == 'upd'){
		
		var recids = w2ui.grid_list.getSelection();
		
		if(recids.length != 1){
			fnMessageModalAlert("알림", "수정 하실 설비를 리스트중 한건 선택 하셔야합니다.");	// Notification(MES)
			return false;
		} 
			
		var pdata = w2ui.grid_list.get(recids[0]);
		
		var keys = Object.keys(pdata);
		$.each(keys, function(idx, key){
			$('#mod_'+key).val(pdata[key]);
		})
		
		$("#mod_machine_class_nm").val(pdata.machine_class_code);
		
		$("#mod_matching_routing_code").val(pdata.matching_routing_code);
		$("#mod_sub_matching_routing_code").val(pdata.sub_matching_routing_code);
		
		$("#mod_machine_code").val(pdata.machine_code);
		
		$("#mod_machine_code").attr('disabled',true);
		$("#btn_check").hide();
		$("#fg_check_yn").val("Y");
		
		$("#mod_machine_acq_price").val(pdata.machine_acq_price);
 		$("#mod_machine_sale_date").val(pdata.machine_sale_date);
 		
 		
 		$(':radio[name="rdo_monitoring_yn"][value="'
						+ pdata.display_monitoring + '"]').iCheck('check');
		$(':radio[name="rdo_monitoring_yn"]').iCheck('update');
		
		$(':radio[name="rdo_rate_yn"][value="'
				+ pdata.display_rate + '"]').iCheck('check');
		$(':radio[name="rdo_rate_yn"]').iCheck('update');
		
		$(':radio[name="rdo_history_yn"][value="'
				+ pdata.display_history + '"]').iCheck('check');
		$(':radio[name="rdo_history_yn"]').iCheck('update');
		
		
	}
	
	$('#btn_mod_save').off('click').on('click', function(){
		modInsert(mode);
	});
	
	$("#modal_info").modal("show");
}

// connect server
function loadList(){
	w2ui.grid_list.clear();
	
	var pageUrl = "/info/machine/selectMachine";
	var machineNm = $('#search_machine_nm').val() || "";
	var postData = {
			machine_nm : machineNm
	};
	w2ui['grid_list'].lock('loading...', true);
	$.ajax({
		url : pageUrl,
		type : "POST",
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.status == 200 && (data.rows).length > 0){
				rowArr = data.rows;
				
				$.each(rowArr, function(idx, row){
					comboValue_nm.push(row.machine_nm);
					row.recid = idx + 1;
				});
				
				w2ui['grid_list'].records = rowArr;
				if (startValue_combo == "") {
					$('#search_machine_nm').w2field('combo', { items: _.uniq(comboValue_nm,false) ,match : 'contains' });
				}
				
			} else {
				w2ui['grid_list'].clear();
			}
			w2ui['grid_list'].refresh();
			w2ui['grid_list'].unlock();
		}, complete : function(){
			startValue_combo = ":)";
	
			document.getElementById("search_machine_nm").style.removeProperty("height");
		}			
		
	});
	
}

function modInsert(mode){
	
	if($("#fg_check_yn").val() == "N") {
		fnMessageModalAlert("알림", "설비코드 중복체크를 확인하세요.");
		return;
	} else if(/* flag=="I" &&  */!chkSubmit($("#mod_machine_code"), "설비코드를")) return;
	
	if(!chkSubmit($("#mod_machine_acq_price"), "취득단가를")) return;
	
	var display_monitoring = $(':radio[name="rdo_monitoring_yn"]:checked').val();
	var display_rate = $(':radio[name="rdo_rate_yn"]:checked').val();
	var display_history = $(':radio[name="rdo_history_yn"]:checked').val();
	
	var pageUrl = "";
	if(mode == 'ins') pageUrl = "/info/machine/insMachine";
	else if(mode == 'upd') pageUrl = "/info/machine/updMachine";
	var postData = {
			machine_code : $('#mod_machine_code').val() || "",
			machine_nm : $("#mod_machine_nm").val() || "",
			machine_class_code : $("#mod_machine_class_nm").val() || "",
			matching_routing_code : $('#mod_matching_routing_code').val() || "",
			sub_matching_routing_code : $('#mod_sub_matching_routing_code').val() || "",
			machine_maker : $('#mod_machine_maker').val() || "",
			machine_standard : $('#mod_machine_standard').val() || "",
			machine_model : $('#mod_machine_model').val() || "",
			machine_dscr : $('#mod_machine_dscr').val() || "",
			machine_making_date : $('#mod_machine_making_date').val().replace(/-/gi,'') || "",
			machine_purchase_date : $('#mod_machine_purchase_date').val().replace(/-/gi,'') || "",
			machine_acq_price : $('#mod_machine_acq_price').val() || "",
			machine_sale_date : $('#mod_machine_sale_date').val().replace(/-/gi,'') || "",
			
			display_monitoring : display_monitoring,
			display_rate : display_rate,
			display_history : display_history
			
	}
	
	console.log(postData);
	$.ajax({
		url : pageUrl,
		type : 'POST',
		data : postData,
		dataType : 'json',
		success : function(data){
			if(data.status == 200){
				fnMessageModalAlert("결과", "설비장비 등록을 완료 하였습니다.");	// Notification(MES)
				$("#modal_info").modal("hide");
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		}, complete : function(){
			loadList();
		}
	})
}

function delMachine(){
	var recids = w2ui.grid_list.getSelection();
	var rData;
	var machineCodes = [];
	
	$.each(recids, function(idx, recid){
		rData = w2ui.grid_list.get(recid);
		machineCodes.push(rData);
	})
	
	var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else if( key.length>1 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else{
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result){
					
					var pageUrl = "/info/machine/delMachine";
					var p = "param=" + encodeURIComponent(JSON.stringify(machineCodes));
					
					
					$.ajax({
						url : pageUrl,
						type : 'POST',
						data : p,
						dataType : 'json',
						success : function(data){
							console.table(data);
							if(data.status == 200){
								fnMessageModalAlert("결과", "설비장비 삭제를 완료 하였습니다.");	// Notification(MES)
							}
						},
						error : function(jqXHR, textStatus, errorThrown){
							fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다. / " + textStatus);	// Notification(MES)
						}, complete : function(){
							loadList();
						}
					})
				}
			});
	}
	
}

// excel download
function excelDown(){
	var gridCols = w2ui['grid_list'].columns;
	var gridData = w2ui['grid_list'].records;
	
	var fileName = '설비 관리.xlsx';
	var sheetTitle = "설비 관리";
	var sheetName = "설비 관리";
	
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



function fnCdD(val, val2){
	console.log("fnCdD("+val+")");
	
	if ( val == "mod_matching_routing_code" ) {
		initOptions($('#'+val)); // select 박스 초기화
		initOptions($('#mod_sub_matching_routing_code')); // select 박스 초기화
		
		$("#mod_sub_matching_routing_code" ).append("<option value=''></option>");
	}
	
	var strUrl = "/info/codeDetail/selectCdD";
	var postData = "master_code=" + encodeURIComponent(val2);
	
	$.ajax({
	    url: strUrl,
	    type: "POST",
	    data: postData, 
	    dataType: 'json', 
	    async : false, // 다 끝나고 다음 처리 해!
	    success:function(data, textStatus, jqXHR){
  //	 	    	console.log("(data.rows).length = " + (data.rows).length);
	    	if(data.status == "200" && (data.rows).length>0 /* 1 */ ) {
	    		rowArr = data.rows;
	    		
	    		
				$.each(rowArr, function(idx, row){
					if( val == "mod_machine_class_nm") {
						$("#"+val ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					} else if ( val == "mod_matching_routing_code" ) {
						if( row.filter2_val == "MACHINE") {
							$("#mod_matching_routing_code" ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
							$("#mod_sub_matching_routing_code" ).append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
						}
					}
				});
				
	 			$("#"+val+" option:eq(0)").prop("selected", true);	
	 			
	 			
	    	} 
	    	
	    },
	    error: function(jqXHR, textStatus, errorThrown){
		    	//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
	    },
	    complete: function() {
	    	
	    }
	});
}

function initOptions(obj) {
    $(obj)
    .find('option')
    .remove()
    .end()
//	    .append('<option value="All">-----</option>')
    .val();
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
function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
}

function checkNum(e){
	var keyVal = event.keyCode;
	 
    if(((keyVal >= 48) && (keyVal <= 57))){
        return true;
    }
    else{
        alert("숫자만 입력가능합니다");
        return false;
    }
}

</script>

</body>
</html>