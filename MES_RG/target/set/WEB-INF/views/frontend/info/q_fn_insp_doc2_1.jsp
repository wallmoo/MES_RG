<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div id='testDoc' style="display:block; text-align: center; width: 100%;" >		 	

<!-- insp_doc.jsp -->
<!-- 원본 -->	
<!-- 
	<table class="__se_tbl_ext" border="0" cellpadding="0" cellspacing="0" width="1924" style="border-collapse: collapse;width:1446pt">
 -->				
<table id="tableT" class="__se_tbl_ext" border="0" cellpadding="0" cellspacing="0" width="1618" style="border-collapse: collapse;width:1215pt; margin: auto;">
 <colgroup><col width="25" style="mso-width-source:userset;mso-width-alt:711;width:19pt">
 <col width="186" style="mso-width-source:userset;mso-width-alt:5290;width:140pt">
 <col width="107" style="mso-width-source:userset;mso-width-alt:3043;width:80pt">
 <col width="270" style="mso-width-source:userset;mso-width-alt:7680;width:203pt">
 <col width="183" style="mso-width-source:userset;mso-width-alt:5205;width:137pt">
 <col width="146" style="mso-width-source:userset;mso-width-alt:4152;width:110pt">
 <col width="96" style="mso-width-source:userset;mso-width-alt:2730;width:72pt">
 <col width="102" style="mso-width-source:userset;mso-width-alt:2901;width:77pt">
 <col width="135" style="mso-width-source:userset;mso-width-alt:3840;width:101pt">
 <col width="96" span="2" style="mso-width-source:userset;mso-width-alt:2730;
 width:72pt">
 <col width="72" style="mso-width-source:userset;mso-width-alt:2048;width:54pt">
 <col width="79" style="mso-width-source:userset;mso-width-alt:2247;width:59pt">
 <col width="25" style="mso-width-source:userset;mso-width-alt:711;width:19pt">
 </colgroup><tbody>
 <tr height="40" style="mso-height-source:userset;height:30.0pt">
  <td colspan="3" rowspan="2" height="60" class="xl84" width="318" style="font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext; border-right:1px solid black; 
	border-bottom:1px solid black; height:60.0pt; width:239pt">
		<img style="width: 191pt; position:relative; top:-6%; margin-top:5px;" alt="" src="/res/images/common/print_set_logo.png">
	</td>
  <td colspan="5" rowspan="2" class="xl90" width="797" style="height:30.0pt; font-size:36.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1px solid windowtext; border-right:1px solid black;
  border-bottom:1px solid black;width:599pt">제품 검사 성적서</td>
  <td colspan="2" class="xl113" width="231" style="height:30.0pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1px solid windowtext;
	border-bottom:1px solid windowtext;
	border-left:1px solid windowtext; border-left:none;width:173pt">최초  생산일</td>
  <td colspan="4" id="pt_s_prod_end_time" class="xl114" width="272" style="height:30.0pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	mso-number-format:'mm\0022월\0022\\ dd\0022일\0022';
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1px solid windowtext;
	border-bottom:1px solid windowtext;
	border-left:1px solid windowtext; border-right:1.0pt solid black;
  border-left:none;width:5650pt;"></td><!-- 자동 --> <!-- width:204pt; -->
 </tr>
 <tr height="46" style="mso-height-source:userset;height:34.9pt">
  <td colspan="2" height="46" class="xl107" style="width:38pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; height:34.9pt;border-left:none">최종  생산일</td>
  <td colspan="4" id="pt_e_prod_end_time" class="xl73" style="height:34.9pt; width:320pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-right:1.0pt solid black;border-left:
  none"></td><!-- 자동 -->
 </tr>
 <tr height="46" style="mso-height-source:userset;height:34.9pt">
  <td colspan="2" height="46" class="xl106" style="width:38pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:1px solid windowtext;
	border-bottom:1px solid windowtext;
	border-left:1.0pt solid windowtext; height:34.9pt">작업지시서 &amp; LOT NO</td>
  <td colspan="2" id="pt_product_po" class="xl73" style="height:34.9pt; width:160pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- 자동 연결 -->
  <td class="xl107" style="height:34.9pt; width:137pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-top:none;border-left:none">원자재 Mill Sheet No.</td>
  <td colspan="3" id="pt_mill_sheet_no" class="xl73" style="height:34.9pt; width:330pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- 자동연결 -->
  <td colspan="2" class="xl107" style="height:34.9pt; width:202pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none">제품 검사일</td>
  <td colspan="4" id="pt_prod_end_time" class="xl83" style="height:34.9pt; width:288pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	mso-number-format:'mm\0022월\0022\\ dd\0022일\0022';
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-right:1.0pt solid black;border-left:
  none"></td><!-- 자동 -->
 </tr>
 <tr height="46" style="mso-height-source:userset;height:34.9pt">
  <td colspan="2" height="46" class="xl106" style="width:38pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:1px solid windowtext;
	border-bottom:1px solid windowtext;
	border-left:1.0pt solid windowtext; height:34.9pt">P/N</td>
  <td colspan="2" id="pt_item_code" class="xl73" style="height:34.9pt; width:160pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- 자동 연결 -->
  <td class="xl107" style="height:34.9pt; width:137pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-top:none;border-left:none">Description</td>
  <td colspan="3" id="pt_item_nm" class="xl73" style="height:34.9pt; width:330pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- 자동연결 -->
  <td colspan="2" class="xl107" style="height:34.9pt; width:202pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none">제품 검사자</td>
  <td colspan="4" id="pt_member_nm" class="xl79" style="height:34.9pt; width:288pt; color:red;
	font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-right:1.0pt solid black;border-left:
  none"></td><!-- KEY IN -->
 </tr>
 <tr height="46" style="mso-height-source:userset;height:34.9pt">
  <td colspan="2" height="46" class="xl106" style="width:38pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:1px solid windowtext;
	border-bottom:1px solid windowtext;
	border-left:1.0pt solid windowtext; height:34.9pt">S/N</td>
  <td colspan="2" class="xl79" style="height:34.9pt; width:160pt; color:red;
	font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- 해당 사항 없는 제품이 있는 관계로 선택적 기입 -->
  <td class="xl107" style="height:34.9pt; width:137pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-top:none;border-left:none">고객사</td>
  <td colspan="3" id="pt_customer_nm" class="xl107" style="height:34.9pt; width:330pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- 자동연결 -->
  <td colspan="2" class="xl107" style="height:34.9pt; width:202pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none">SITE</td>
  <td colspan="4" id="pt_site" class="xl79" style="height:34.9pt; width:288pt; color:red;
	font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-right:1.0pt solid black;border-left:
  none"></td><!-- KEY IN -->
 </tr>
 <tr height="46" style="mso-height-source:userset;height:34.9pt">
  <td colspan="2" height="46" class="xl106" style="width:38pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:1px solid windowtext;
	border-bottom:1px solid windowtext;
	border-left:1.0pt solid windowtext; height:34.9pt">검사 입고 수량</td>
  <td colspan="2" id="pt_prod_menge" class="xl108" style="height:34.9pt; width:160pt; color:black;
	font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- 자동 연결 -->
  <td class="xl107" style="height:34.9pt; width:137pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-top:none;border-left:none">검사 불량 수량</td>
  <td colspan="3" id="pt_prod_fail_menge" class="xl109" style="height:34.9pt; width:330pt; color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none"></td><!-- KEY IN -->
  <td colspan="2" class="xl107" style="height:34.9pt; width:202pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-left:none">최종 합격 수량</td>
  <td colspan="4" id="pt_f_prod_menge" class="xl73" style="height:34.9pt; width:288pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext; border-right:1.0pt solid black;border-left:
  none"></td><!-- =입고수얄-불량수량(계산) -->
 </tr>
 <tr height="46" style="mso-height-source:userset;height:34.9pt">
  <td height="46" class="xl110" colspan="4" style="width:76pt; color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:none;
	border-bottom:1px solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:black none; height:34.9pt;mso-ignore:colspan"></td> <!-- 이  줄은 항후 추가 정보를 입력 할수 있도록 SPARE -->
  <td class="xl111" style="height:34.9pt; width:137pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:none;
	border-bottom:1px solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:black none; border-top:none">　</td>
  <td class="xl111" style="height:34.9pt; width:110pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:none;
	border-bottom:1px solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:black none; border-top:none">　</td>
  <td class="xl111" style="height:34.9pt; width:72pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:none;
	border-bottom:1px solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:black none; border-top:none">　</td>
  <td class="xl111" style="height:34.9pt; width:77pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:none;
	border-bottom:1px solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:black none; border-top:none">　</td>
  <td class="xl111" style="height:34.9pt; width:101pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:none;
	border-bottom:1px solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:black none; border-top:none">　</td>
  <td class="xl112" style="height:34.9pt; width:72pt; font-size:12.0pt;
	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	vertical-align:middle;
	border-top:1px solid windowtext;
	border-right:1px solid windowtext;
	border-bottom:1px solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:black none; border-top:none">　</td>
  <td colspan="4" class="xl77" style="height:34.9pt; width:288pt; font-size:12.0pt;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:1px solid windowtext;
	background:yellow;
	mso-pattern:black none; border-right:1.0pt solid black;border-left:
  none">　</td>
 </tr>
 
 
 <tr height="5" style="mso-height-source:userset;height:5pt">
  <td colspan="14" height="34" class="xl71" style="width:266pt; font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext; border-right:1.0pt solid black;
  height:5pt">　</td>
 </tr>
 
 <tr height="27" style="mso-height-source:userset;height:20.25pt">
  <td height="27" class="xl71" style="width:19pt; font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext; height:20.25pt">&nbsp;</td>
  
  
  <td id="td_img"  colspan="12" class="xl104" style=" font-size:14.0pt;
  	height:550pt;
  	width:1260pt; 
  	font-weight:700;
	font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border: none;
	border-bottom: none;">
	
	<!-- <img src=""  /> --> <!-- style=" overflow: hidden; display: flex;  align-items: center; justify-content: center; width: 100%; height: 50%;" -->
     
	</td>
	
  
  <td class="xl67" style="height:20.25pt; width:5pt; font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;">&nbsp;</td>
 </tr>
 
 
 <tr height="5" style="mso-height-source:userset;height:5pt">
  <td colspan="14" height="34" class="xl71" style="width:266pt; font-family:'맑은 고딕', monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext; border-right:1.0pt solid black;
  height:5pt">　</td>
 </tr>
 
 
 </tbody>
</table>

</div>