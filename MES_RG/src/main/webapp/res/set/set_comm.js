$(function(){
	$.fn.pressEnter = function(fn) {  
    return this.each(function() {  
    	$(this).bind('enterPress', fn);
      $(this).keyup(function(e){
      	if(e.keyCode == 13) {
      		$(this).trigger("enterPress");
        }
      })
    });  
	};
	
	jQuery.xls_download = function(url, data, method){
    if( url && data ){ 
      data = typeof data == 'string' ? data : jQuery.param(data);
      var inputs = '';
      jQuery.each(data.split('&'), function(){ 
      	var pair = this.split('=');
        inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
      });
      jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>').appendTo('body').submit().remove();
    };
	};
});

function fnMessageModalAlert(title, msg) {
	$("#modal_message_title").html(title);
	$("#modal_message_body").html(msg);
	$('#modal_message').appendTo("body").modal('show');
}

function fnMessageModalConfirm(title, msg, callback) {
	$("#btn_modal_confirm_true").unbind( 'click' );
	$("#btn_modal_confirm_false").unbind( 'click' );
	
	$("#modal_confirm_result").val("N");
	$("#modal_confirm_title").html(title);
	$("#modal_confirm_body").html(msg);
	$('#modal_confirm').appendTo("body").modal('show');
	
	$( "#btn_modal_confirm_true" ).on('click', function(e) {
		$("#modal_confirm_result").val("Y");
		$('#modal_confirm').modal('hide');
		if (callback) callback(true);
	});
	
	$( "#btn_modal_confirm_false" ).on('click', function(e) {
		$("#modal_confirm_result").val("N");
		$('#modal_confirm').modal('hide');
		if (callback) callback(false);
	});
}

function maxLengthCheck(obj){
	if (obj.value.length > obj.maxLength){
    obj.value = obj.value.slice(0, obj.maxLength);
	}    
}

function resizeJqGrid(obj_id, fg_scroll, is_fixed){
	setTimeout(function () {
		/*
		// Resize all visible jqGrids that are children of ".grid-stretch-container" elements.
	    // Note: You should call resizeApp when any grid visibility changes.
	    $(".grid-stretch-container:visible .ui-jqgrid-btable").each(function (index) {
	        // Resize the grid to it's parent.
	        var container = $(this).closest(".grid-stretch-container");
	        $(this).jqGrid().setGridWidth(container.width());
	        // The grid height does not include the caption, pagers or column headers
	        // so we need to compute an offset.
	        // There's probably a better method than accessing the jqGrid "gbox".
	        var gbox = $(this).closest("#gbox_" + this.id);
	        var height = $(this).getGridParam("height") + (container.height() - gbox.height());
	        $(this).jqGrid().setGridHeight(height);

	        // Destroy and recreate the group headers to work around the bug.
	        var groupHeaders = $(this).jqGrid("getGridParam", "groupHeader");
	        if (groupHeaders != null) {
	            $(this).jqGrid("destroyGroupHeader").jqGrid("setGroupHeaders", groupHeaders);
	        }
	    });
	    */
		
		$("#" + obj_id).setGridWidth($("#dv_" + obj_id).width(), is_fixed);
		if(fg_scroll) {
			var gbody = $("#"+obj_id).parents("div.ui-jqgrid .ui-jqgrid-bdiv");
			gbody.css("overflow-x", "hidden");
		}
  }, 200);
}

function numberWithCommas(x) {
	if(x != null){
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	} else {
		return "0";
	}
}

// String Util
function nullToBlank(str){
	if(str == null || str == undefined || str == "null") str = "";
	return str;
}

function replaceAll(str, searchStr, replaceStr) {
	if(str == null || str == undefined || str == "null") return "";
	return str.split(searchStr).join(replaceStr);
}

// Date Util
function getTodayDate() {
	var d = new Date();
  var yy = d.getFullYear().toString();
  var mm = (d.getMonth() + 1).toString();
  var dd = "";
  if(mm.length == 1) {
  	mm="0"+mm;
  }
  var dd = (d.getDate()).toString();
  if(dd.length == 1) {
  	dd="0"+dd;
  }
	return yy+"."+mm+"."+dd;
}

function getMonthEndDate() {
	var d = new Date();
  var yy = d.getFullYear().toString();
  var mm = (d.getMonth() + 1).toString();
  var dd = "";
  
  var dt = new Date(yy, mm, 0);
  yy = dt.getFullYear().toString();
  mm = (dt.getMonth() + 1).toString();
  if(mm.length == 1) {
  	mm="0"+mm;
  }
  var dd = (dt.getDate()).toString();
  if(dd.length == 1) {
  	dd="0"+dd;
  }
	return yy+"."+mm+"."+dd;
}

function strWithYYMMDD(x){
	if(x.length != 8) return;
	var yyyy = x.substring(0, 4);
	var mm = x.substring(4, 6);
	var dd = x.substring(6, 8);
	return yyyy+"."+mm+"."+dd;
}

function strWithYYMMDD_dash(x){
	if(x.length != 8) return;
	var yyyy = x.substring(0, 4);
	var mm = x.substring(4, 6);
	var dd = x.substring(6, 8);
	return yyyy+"-"+mm+"-"+dd;
}

function lpad(s, padLength, padString){
    while(s.length < padLength)
        s = padString + s;
    return s;
}
 
function rpad(s, padLength, padString){
    while(s.length < padLength)
        s += padString;
    return s;
}

//DATE FORMAT VALIDATE
function isValidDate(dateString, format) {
	var regEx = null;
	if( 'yyyy.mm'==format ) {
		regEx = /^(19[5-9][0-9]|20[0-4][0-9]|2100)[./](0?[1-9]|1[0-2])$/;
	} else {	//'yyyy.mm.dd'
		regEx = /^(19[5-9][0-9]|20[0-4][0-9]|2100)[./](0?[1-9]|1[0-2])[./](0?[1-9]|[12][0-9]|3[01])$/;
	}
	// check
	if(!dateString.match(regEx)) { 
		return 'ERROR';  // Invalid format
	} else {
		return dateString;
	}
}

// File Handler
function ajax_download(url, data, input_name) {
  var $iframe, iframe_doc, iframe_html;
  if (($iframe = $('#download_iframe')).length === 0) {
  	$iframe = $("<iframe id='download_iframe' style='display: none' src='about:blank'></iframe>").appendTo("body");
  }
	iframe_doc = $iframe[0].contentWindow || $iframe[0].contentDocument;
  if (iframe_doc.document) {
  	iframe_doc = iframe_doc.document;
  }

  iframe_html = "<html><head></head><body><form method='POST' action='" + url +"'>" +
                "<input type=hidden name='" + input_name + "' value='"+JSON.stringify(data)+"'/></form>" +
                "</body></html>";
  
  iframe_doc.open();
  iframe_doc.write(iframe_html);
  $(iframe_doc).find('form').submit();
}

// Common Loading Function 
function getSelectCompany(obj, is_search){
	obj.empty();
	
	var sel_url = "/backend/code/data_codegrid";
	sel_url += "?master_code=" + encodeURIComponent("MC1002");
	
	$.ajax({
    url:sel_url,
    type:'POST',
    dataType: 'json',
    async: false, 
    success: function( data ) {
    	var rows = data.rows;
    	for(var i=0; i<rows.length; i++) {
    		if(i==0) {
    			obj.append($('<option>').text(data.rows[i].code_nm).attr('value', data.rows[i].filter1_val).attr('selected', 'selected'));
    		} else {
    			obj.append($('<option>').text(data.rows[i].code_nm).attr('value', data.rows[i].filter1_val));	
    		}
    	}
    	
    	if(!is_search) {
    		obj.select2({
      		minimumResultsForSearch: Infinity
  			});
    	} else {
    		obj.select2({
  			});
    	}
    }
	});
}

function getSelectCategoryDivision(obj, is_search){
	obj.empty();
	
	var sel_url = "/backend/code/data_codegrid";
	sel_url += "?master_code=" + encodeURIComponent("MC1015");
	
	$.ajax({
    url:sel_url,
    type:'POST',
    dataType: 'json',
    async: false, 
    success: function( data ) {
    	var rows = data.rows;
    	for(var i=0; i<rows.length; i++) {
    		if(i==0) {
    			obj.append($('<option>').text(data.rows[i].code_nm).attr('value', data.rows[i].filter1_val).attr('selected', 'selected'));
    		} else {
    			obj.append($('<option>').text(data.rows[i].code_nm).attr('value', data.rows[i].filter1_val));	
    		}
    	}
    	
    	if(!is_search) {
    		obj.select2({
      		minimumResultsForSearch: Infinity
  			});
    	} else {
    		obj.select2({
  			});
    	}
    }
	});
}

function getCommonCodeCombo(obj, m_code, lang, is_all, is_search){
	obj.empty();
	
	var sel_url = "/backend/code/data_codegrid";
	sel_url += "?master_code=" + encodeURIComponent(m_code);
	
	$.ajax({
    url:sel_url,
    type:'POST',
    dataType: 'json',
    async: false, 
    success: function( data ) {
    	var rows = data.rows;
    	for(var i=0; i<rows.length; i++) {
    		var combo_text = "", combo_val = "";
    		if(lang == "ko") {
    			combo_text = data.rows[i].code_nm;
    		} else if(lang == "en") {
    			combo_text = data.rows[i].code_nm_en;
    		}
    		combo_val = data.rows[i].filter1_val;
    		
    		if(i==0) {
    			if(is_all) {
    				// obj.append($('<option>').text("전체").attr('value', "").attr('selected', 'selected'));
    				obj.append($('<option>').text(combo_text).attr('value', combo_val));
    			} else {
    				// obj.append($('<option>').text(combo_text).attr('value', combo_val).attr('selected', 'selected'));
    				obj.append($('<option>').text(combo_text).attr('value', combo_val));
    			}
    		} else {
    			obj.append($('<option>').text(combo_text).attr('value', combo_val));	
    		}
    	}
    	
    	if(is_search) {
    		obj.SumoSelect({
    			search: true, 
    			searchText: 'Search...',
    			selectAll: true,
    			forceCustomRendering: true
    		});
    	} else {
    		obj.SumoSelect({
    		});
    	}
    }
	});
}
/****************************************************************************
내    용 : 입력값이 특정 문자(chars)만으로 되어있는지 체크
                 특정 문자만 허용하려 할 때 사용
파라미터 : str :입력값
리 턴 값 :
참고사항 :
***************************************************************************/
function cf_hasContainsCharsChk(str, chars) {
	for (var inx = 0; inx < str.length; inx++) {
		if (chars.indexOf(str.charAt(inx)) == -1)
			return false;
	}
	return true;
}

/****************************************************************
 * 내	용 	: 입력값이 알파벳대문자 체크
 * 파라미터 : 1. str : 입력문자열
 * 리 턴 값 :
 * 참고사항 :
*****************************************************************/
function cf_isAlphabetUpper(str) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    return cf_hasContainsCharsChk(str, chars);
}

/****************************************************************
 * 내	용 	: 입력값이 숫자와 Dot(.) 체크
 * 파라미터 : 1. str : 입력문자열
 * 리 턴 값 :
 * 참고사항 :
*****************************************************************/
function cf_isNumberDot(str) {
    var chars = "1234567890.-";
    return cf_hasContainsCharsChk(str, chars);
}
/****************************************************************
 * 내	용 	: 입력값이 숫자와 영어로 되어있는지 체크
 * 파라미터 : 1. str : 입력문자열
 * 리 턴 값 :
 * 참고사항 :
*****************************************************************/
function cf_isNumberAlphabet(str) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    return cf_hasContainsCharsChk(str, chars);
}
/****************************************************************
 * 내	용 	: 입력값이 숫자, 영어, 특수문자(-,_)로 되어있는지 체크
 * 파라미터 : 1. str : 입력문자열
 * 리 턴 값 :
 * 참고사항 :
*****************************************************************/
function cf_isNumAlphaDashUnderbar(str) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
    return cf_hasContainsCharsChk(str, chars);
}
/****************************************************************
 * 내	용 	: 입력값이 숫자로 되어있는지 체크
 * 파라미터 : 1. str : 입력문자열
 * 리 턴 값 :
 * 참고사항 :
*****************************************************************/
function cf_isNumber(str) {
    var chars = "0123456789";
    return cf_hasContainsCharsChk(str, chars);
}

/*************************************************
* 내    용   : 입력한 숫자 문자열에 , 추가
* 파라미터   : 변환 숫자 스트링
* 리 턴 값   : 스트링
* 참고사항   :
**************************************************/
function addCommas(nStr) {
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}

function jqgridHighlightFormatter(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">사용</span>';
	} else {
		return "";
	}
}
function jqgridHighlightFormatterInsp(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">입고후검사</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">입고전검사</span>';
	}
}
function jqgridHighlightFormatterInspYn(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">검사대상</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">무검사대상</span>';
	}
}
function jqgridHighlightFormatterGr(cellvalue, options, rowObject) {
	if (cellvalue != null && cellvalue != "" && cellvalue == "Y") {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">등급대상</span>';
	} else {
		return '<span style=\"display:block;height:22px;text-align:center;valign:middle;font-weight:bold;color:#FA4C28;background-color:#FFD48E\">비등급대상</span>';
	}
}

function initScreenSizeModal() {
	$('.modal').on('show.bs.modal', function () {
	      if ($(document).height() > $(window).height()) {
	          // no-scroll
	          $('body').addClass("modal-open-noscroll");
	      }
	      else {
	          $('body').removeClass("modal-open-noscroll");
	      }
	  });
	  $('.modal').on('hide.bs.modal', function () {
	      $('body').removeClass("modal-open-noscroll");
	  });
}
//읽기 쓰기 모드에서 읽기 권한일 경우 모든 버튼들 숨김처리
function readOnlyFilter(role_cd, selected_menu_cd){ 
	var revalue="";
	var page_url = "/backend/data_sy_menu_alc";
	var post_data = "role_cd=" + encodeURIComponent(role_cd);
	post_data += "&menu_cd=" + encodeURIComponent(selected_menu_cd);
	
	$.ajax({
		url : page_url,
		data : post_data,
		type : "POST",
		dataType : 'json',
		async : false,
		success : function(data) {
			if(data.result == "success") {
				
				var btn_show = "btn btn-danger btn-sm"; 
				var btn_hide = "btn btn-danger btn-sm hide";
				var filter_key = data.data.read_yn;
				if(filter_key == "Y" || role_cd !="A" ){
					var btn = document.getElementsByClassName(btn_show);
				    if(btn[0]){
				    }else{ 
				    	btn = document.getElementsByClassName(btn_hide); 
				    	
				    }
				    if(btn[0] != null){
				    if(btn[0].readonly == ""){
				        for(i in btn){ 
				        	 btn[i].className = btn_hide; 
				        	 btn[i].value = btn_hide; 
				        } 
				    }else{
				    	for(i in btn){ 
				    		btn[i].className = btn_hide; 
				        } 
				    } }
				    if(filter_key == "Y"){
				    	revalue = 'Y';
				    }else{
				    	revalue = 'N';
				    }
				    
				}else{
					revalue = 'N';
				}
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			fnMessageModalAlert("Notification", "데이터를 로딩하는데 에러가 발생하였습니다.");	
			revalue = 'N';
	  }
	});
	
	return revalue;
	//	if read_yn == Y  -----------------------------------------------
} 

function fnLoadProfile(p_member_no){
	$('#modal_profile').appendTo("body").modal('show');
}

/**
 * progress bar modal
 * Module for displaying "Waiting for..." dialog using Bootstrap
 *
 * @author Eugene Maslovich <ehpc@em42.ru>
 * https://bootsnipp.com/snippets/featured/quotwaiting-forquot-modal-dialog
 * 
 * waitingDialog.show();
 * waitingDialog.show('Custom message');
 * waitingDialog.show('LTBP 를 생성중입니다.', {dialogSize: 'sm', progressType: 'warning'});
 * 
 */

// hyper tag create
function getHyperTagMes(){
	console.log("get hyper tag");
}

var waitingDialog = waitingDialog || (function ($) {
    'use strict';

	// Creating modal dialog's DOM
	var $dialog = $(
		'<div class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true" style="padding-top:15%; overflow-y:visible;">' +
		'<div class="modal-dialog modal-m">' +
		'<div class="modal-content">' +
			'<div class="modal-header"><h3 style="margin:0;"></h3></div>' +
			'<div class="modal-body">' +
				'<div class="progress progress-striped active" style="margin-bottom:0;"><div class="progress-bar" style="width: 100%"></div></div>' +
			'</div>' +
		'</div></div></div>');

	return {
		/**
		 * Opens our dialog
		 * @param message Custom message
		 * @param options Custom options:
		 * 				  options.dialogSize - bootstrap postfix for dialog size, e.g. "sm", "m";
		 * 				  options.progressType - bootstrap postfix for progress bar type, e.g. "success", "warning".
		 */
		show: function (message, options) {
			// Assigning defaults
			if (typeof options === 'undefined') {
				options = {};
			}
			if (typeof message === 'undefined') {
				message = 'Loading';
			}
			var settings = $.extend({
				dialogSize: 'm',
				progressType: '',
				onHide: null // This callback runs after the dialog was hidden
			}, options);

			// Configuring dialog
			$dialog.find('.modal-dialog').attr('class', 'modal-dialog').addClass('modal-' + settings.dialogSize);
			$dialog.find('.progress-bar').attr('class', 'progress-bar');
			if (settings.progressType) {
				$dialog.find('.progress-bar').addClass('progress-bar-' + settings.progressType);
			}
			$dialog.find('h3').text(message);
			// Adding callbacks
			if (typeof settings.onHide === 'function') {
				$dialog.off('hidden.bs.modal').on('hidden.bs.modal', function (e) {
					settings.onHide.call($dialog);
				});
			}
			// Opening dialog
			$dialog.modal();
		},
		/**
		 * Closes dialog
		 */
		hide: function () {
			$dialog.modal('hide');
		}
	};

})(jQuery);