<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id='doctest' style="display:none">
<!-- <div id='doctest'> -->

<!--  ******************************************************************************************************************************************************************* -->	

	<table style="width: 100%; margin-bottom:10px;word-break: break-all;">
		<tbody id="my0-tbody_0">
			<tr>
				<td rowspan="2" style="width: 16.6667%;">
					<img src="/res/images/common/print_set_logo.png" style="width: 50%;width: 80%;">
				</td>
				<td colspan="3" rowspan="2" style="width: 50%;" id='rpt_title'><strong>제 &nbsp;&nbsp;품 &nbsp;&nbsp;검 &nbsp;&nbsp;사 &nbsp;&nbsp;성 &nbsp;&nbsp;적 &nbsp;&nbsp;서</strong></td>
				<td class="ctt-nm" style="width: 16.6667%;">최초 생산일</td>
				<td style="width: 16.6667%;" id="pt_s_prod_end_time"></td>
			</tr>
			<tr>
				<td class="ctt-nm" style="width: 16.6667%;">최종 생산일</td>
				<td style="width: 16.6667%;" id="pt_e_prod_end_time"></td>
			</tr>
			<tr>
				<td class="ctt-nm" style="width: 16.6667%;">작업지시서 &amp; LOT NO</td>
				<td style="width: 16.6667%;" id="pt_product_po"></td>
				<td class="ctt-nm" style="width: 16.6667%;">원자재 Mill Sheet No.</td>
				<td style="width: 16.6667%;" id="pt_mill_sheet_no"></td>
				<td class="ctt-nm" style="width: 16.6667%;">제품 검사일</td>
				<td style="width: 16.6667%;" id="pt_prod_end_time"></td>
			</tr>
			<tr>
				<td class="ctt-nm" style="width: 16.6667%;">P/N</td>
				<td style="width: 16.6667%;" id="pt_item_code"></td>
				<td class="ctt-nm" style="width: 16.6667%;">Description</td>
				<td style="width: 16.6667%;" id="pt_comment"></td>
				<td class="ctt-nm" style="width: 16.6667%;">제품 검사자</td>
				<td style="width: 16.6667%;" id="pt_member_nm"></td>
			</tr>
			<tr>
				<td class="ctt-nm" style="width: 16.6667%;">S/N</td>
				<td style="width: 16.6667%;" id="pt_sn"></td>
				<td class="ctt-nm" style="width: 16.6667%;">고객사</td>
				<td style="width: 16.6667%;" id="pt_customer_nm"></td>
				<td class="ctt-nm" style="width: 16.6667%;">SITE</td>
				<td style="width: 16.6667%;" id="pt_site"></td>
			</tr>
			<tr>
				<td class="ctt-nm" style="width: 16.6667%;">검사 입고 수량</td>
				<td style="width: 16.6667%;" id="pt_prod_menge"></td>
				<td class="ctt-nm" style="width: 16.6667%;">검사 불량 수량</td>
				<td style="width: 16.6667%;" id="pt_prod_fail_menge"></td>
				<td class="ctt-nm" style="width: 16.6667%;">최종 합격 수량</td>
				<td style="width: 16.6667%;" id="pt_f_prod_menge"></td>
			</tr>
		</tbody>
	</table>

<!--  ******************************************************************************************************************************************************************* -->
	<table style="width: 100%; margin-bottom:10px;" id='img_tbl'>	
		<tbody id="my0-tbody_1">
		</tbody>
	</table>

	<table class="endline" style="width: 100%; margin-bottom:10px; word-break: break-all;" id="insp_val_area">	
		<tbody id="my0-tbody_2">
		</tbody>
	</table>
	
	<table style="width: 100%; word-break: break-all;">
		<tbody id="my0-tbody_2">
			<tr>
				<td>
					<div width='50%'>
					* Remark : 
					</div>
					<div width='50%' style="float: right;">
						<div class="jb-wrap">
							<div class="jb-image"><img src="/res/images/common/set_stamp.png" style="height: 130px; width: 130px;"></div>
							<div class="jb-text">
								<strong id='pt_stp_date'></strong>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
