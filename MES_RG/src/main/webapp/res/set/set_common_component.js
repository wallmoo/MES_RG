	//공통코드를 드랍다운 메뉴화
	function fnCdD(val, val2) {
		console.log("fnCdD(" + val + ")");

		initOptions($('#' + val)); // select 박스 초기화

		var strUrl = "/info/codeDetail/selectCdD";
		var postData = "master_code=" + encodeURIComponent(val2);

		$.ajax({
			url : strUrl,
			type : "POST",
			data : postData,
			dataType : 'json',
			async : false, // 다 끝나고 다음 처리 해!
			success : function(data, textStatus, jqXHR) {
				//	 	    	console.log("(data.rows).length = " + (data.rows).length);
				if (data.status == "200" && (data.rows).length > 0 /* 1 */) {
					rowArr = data.rows;

					var sub = val.substr(0, 2);

					//  if(valsub != "m_")
					if (sub.indexOf("m_") == -1) // val
						$("#" + val)
								.append(
										"<option value="+'ALL'+">" + "전체"
												+ "</option>");

					$.each(rowArr, function(idx, row) {
						$("#" + val).append(
								"<option value=" + row.detail_code + ">"
										+ row.code_nm + "</option>");
					});

					$("#" + val + " option:eq(0)").prop("selected", true);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//fnMessageModalAlert("Notification(MES)", "정보를 처리하는데 에러가 발생하였습니다.");	
			},
			complete : function() {

			}
		});
	}	
	// 고객사 가져오기
	function requestClient(val){
		console.log("requestClient");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/account/selectClient";
		var postData = "";
		
		//w2ui['grid_list'].lock('loading...', true);
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    async : false, // 다 끝나고 다음 처리 해!
		    dataType: 'json', 
		    success:function(data, textStatus, jqXHR){
//	 	    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length > 0) {
		    		rowArr = data.rows;
		    		
		    		/* 검색어 입력시 */
		    		var sub = val.substr(0,2);

		    		if(sub.indexOf("S_") != -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val ).append("<option value=" + row.cst_IDX + ">" + row.cst_NM + "</option>");
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
	// 거래처 가져오기
	function requestVendor(val){
		console.log("requestVendor");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/account/selectVendor";
		var postData = "";
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    async : false, // 다 끝나고 다음 처리 해!
		    dataType: 'json', 
		    success:function(data, textStatus, jqXHR){
//	 	    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length > 0) {
		    		rowArr = data.rows;
		    		
		    		/* 검색어 입력시 */
		    		var sub = val.substr(0,2);

		    		if(sub.indexOf("S_") != -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val ).append("<option value=" + row.vdr_IDX + ">" + row.vdr_NM + "</option>");
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    
		    },
		    complete: function() {
	    	
		    }
		});
	}	
	// 기업정보 가져오기-배송지
	function requestBranchInfo(val){//폼 정보를 받음
		console.log("requestVendor");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/account/selectBranch";
		var postData = "";
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    async : false, // 다 끝나고 다음 처리 해!
		    dataType: 'json', 
		    success:function(data, textStatus, jqXHR){
//	 	    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length > 0) {
		    		rowArr = data.rows;
		    		
		    		/* 검색어 입력시 */
		    		var sub = val.substr(0,2);

		    		if(sub.indexOf("S_") != -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val ).append("<option value=" + row.bco_NM + ">" + row.bco_NM + "</option>");
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);	
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    
		    },
		    complete: function() {
	    	
		    }
		});
	}	
	// 프로젝트명 가져오기
	function requestProject(val){
		console.log("requestVendor");
		
		initOptions($('#'+val)); // select 박스 초기화
		
		var strUrl = "/info/account/selectProject";
		var postData = "";
		
		$.ajax({
		    url: strUrl,
		    type: "POST",
		    data: postData, 
		    async : false, // 다 끝나고 다음 처리 해!
		    dataType: 'json', 
		    success:function(data, textStatus, jqXHR){
//	 	    	console.log("(data.rows).length = " + (data.rows).length);
		    	if(data.status == "200" && (data.rows).length > 0) {
		    		rowArr = data.rows;
		    		
		    		/* 검색어 입력시 */
		    		var sub = val.substr(0,2);

		    		if(sub.indexOf("S_") != -1) // val
		    			$("#"+val ).append("<option value="+'ALL'+">" + "전체" + "</option>");
		    		
					$.each(rowArr, function(idx, row){
						$("#"+val ).append("<option value=" + row.pjt_IDX + ">" + row.pjt_NM + "</option>");
					});
					
		 			$("#"+val+" option:eq(0)").prop("selected", true);
		    	} 
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    
		    },
		    complete: function() {
	    	
		    }
		});
	}	
	//날짜 형식 맞추기
	function getFormatDate(d) {
		var month = d.getMonth() + 1;
		var date = d.getDate();
		month = (month < 10) ? "0" + month : month;
		date = (date < 10) ? "0" + date : date;
		return d.getFullYear() + '-' + month + '-' + date;
	}
	// 미 입력시
	function chkSubmit(item, msg) {
		if (item.val().replace(/\s/g, "") == "") {
			fnMessageModalAlert("알림", msg + " 입력해 주세요.");
			item.val("");
			item.focus();
			return false;
		} else {
			return true;
		}
	}	
	//셀렉트박스 초기화
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
		//.append('<option value="All">-----</option>')
	    .val();
	}
	//key 누를때 숫자만 가능하도록.
	function onlyNumber(){
		if ((event.keyCode < 48) || (event.keyCode > 57))
			event.returnValue = false;
	}
	//숫자에 ,표기
	function setComma(n) {
	    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	    n += '';                          // 숫자를 문자열로 변환         
	    while (reg.test(n)) {
	       n = n.replace(reg, '$1' + ',' + '$2');
	    }         
	    return n;
	}	
	// 개별 달력
	function fnLoadCommonOption(val) {
	 	console.log('fnLoadCommonOption()');
	 	
		$(val).daterangepicker({
			opens: 'right',
			singleDatePicker: true,
			locale: {
				format : 'YYYY-MM-DD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		    startDate : moment(minDate)
		})
		.on("change", function() {

		}); 
	}
	//시작~종료 달력
	function fnLoadDeliveryOption(val) {
	 	console.log('fnLoadCommonOption()');
	 	
		$(val).daterangepicker({
			opens: 'left',
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
 			startDate: moment().subtract(30, 'days').format('YYYY-MM-DD'),
			endDate: moment().format('YYYY-MM-DD'),
		}); 
		
		$(val).val("");		
	}	
	function fnLoadDeliveryOption(val1, val2) {
	 	console.log('fnLoadCommonOption()');
	 	
		$(val1).daterangepicker({
			opens: val2,
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
 			startDate: moment().subtract(30, 'days').format('YYYY-MM-DD'),
			endDate: moment().format('YYYY-MM-DD'),
		}); 
		
		$(val1).val("");		
	}		
	//엑셀파일 다운로드
	function excelFileDownload(val1,val2) {//initOptions($('#'+val)); // select 박스 초기화
/*		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;

		var fileName = '구매견적 관리.xlsx';
		var sheetTitle = '구매견적 관리';
		var sheetName = '구매견적 관리';*/
		
		var gridCols = w2ui[val1].columns;
		var gridData = w2ui[val1].records;

		var fileName = val2+'.xlsx';
		var sheetTitle = val2;
		var sheetName = val2;		

		var param_col_name = "", param_col_id = "", param_col_align = "", param_col_width = "";
		var is_rownum = true;

		if (gridCols != null && gridCols.length > 0) {
			for (var i = 0; i < gridCols.length; i++) {
				if (!gridCols[i].hidden) {
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width == undefined ? "10" : (gridCols[i].width).replace('px', '')) + ",";
				}
			}
			param_col_name = param_col_name.substr(0, param_col_name.length - 1);
			param_col_id = param_col_id.substr(0, param_col_id.length - 1);
			param_col_align = param_col_align.substr(0, param_col_align.length - 1);
			param_col_width = param_col_width.substr(0, param_col_width.length - 1);
		}

		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name=" + encodeURIComponent(fileName);
			export_data += "&sheet_title=" + encodeURIComponent(sheetTitle);
			export_data += "&sheet_name=" + encodeURIComponent(sheetName);
			export_data += "&header_col_names=" + encodeURIComponent(param_col_name);
			export_data += "&header_col_ids=" + encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns=" + encodeURIComponent(param_col_align);
			export_data += "&header_col_widths=" + encodeURIComponent(param_col_width);
			export_data += "&cmd=" + encodeURIComponent("grid_goods_detail");
			export_data += "&body_data=" + encodeURIComponent(JSON.stringify(gridData));

		$.ajax({
			url : export_url,
			data : export_data,
			type : 'POST',
			dataType : 'json',
			success : function(data) {
				if (data.status == 200) {
					var file_path = data.file_path;
					var file_name = data.file_name;
					var protocol = jQuery(location).attr('protocol');
					var host = jQuery(location).attr('host');
					var link_url = "/file/attach_download";
					
					link_url += "?file_path=" + encodeURIComponent(file_path);
					link_url += "&file_name=" + encodeURIComponent(file_name);

					$(location).attr('href', link_url);
				}
			},
			complete : function() { }
		});
	}		