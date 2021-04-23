package kr.co.passcombine.set.vo;

public class SYPrintVO {

	private String product_po; // 작업지시서 & LOT NO
	private String item_code;  // P/N
	private String sn;		   // S/N
	private String prod_menge; // 검사 입고 수량
	private String mill_sheet_no; // 원자재 Mill Sheet No.
	private String item_nm; 		// Description
	private String customer_nm; 	// 고객사
	private String prod_fail_menge;  // 검사 불량 수량
	private String s_prod_end_time; // 최초 생산일
	private String e_prod_end_time; // 최종 생산일
	private String prod_end_time;   // 제품 검사일
	
	private String member_nm; // 제품 검사자
	private String site; 
	private String f_prod_menge; // 최종 합격 수량
	private String inspection_item; // 검사항목
	private String inspection_tool; // 검사Tool
	private String code_nm;  // 검사방법
	private String point; // 검사Point
	private String spec; 
	private String min_spec; // UCL
	private String max_spec; // LCL
	private String insp_val; // 측정DATA
	private String insp_rst; // 판정
	private String comment;  // 비고
	private String routing_code;
	
	private String inspection_point;

	
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getProd_menge() {
		return prod_menge;
	}
	public void setProd_menge(String prod_menge) {
		this.prod_menge = prod_menge;
	}
	public String getMill_sheet_no() {
		return mill_sheet_no;
	}
	public void setMill_sheet_no(String mill_sheet_no) {
		this.mill_sheet_no = mill_sheet_no;
	}
	public String getItem_nm() {
		return item_nm;
	}
	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}
	public String getCustomer_nm() {
		return customer_nm;
	}
	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}
	public String getProd_fail_menge() {
		return prod_fail_menge;
	}
	public void setProd_fail_menge(String prod_fail_menge) {
		this.prod_fail_menge = prod_fail_menge;
	}
	public String getS_prod_end_time() {
		return s_prod_end_time;
	}
	public void setS_prod_end_time(String s_prod_end_time) {
		this.s_prod_end_time = s_prod_end_time;
	}
	public String getE_prod_end_time() {
		return e_prod_end_time;
	}
	public void setE_prod_end_time(String e_prod_end_time) {
		this.e_prod_end_time = e_prod_end_time;
	}
	public String getProd_end_time() {
		return prod_end_time;
	}
	public void setProd_end_time(String prod_end_time) {
		this.prod_end_time = prod_end_time;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	public String getF_prod_menge() {
		return f_prod_menge;
	}
	public void setF_prod_menge(String f_prod_menge) {
		this.f_prod_menge = f_prod_menge;
	}
	public String getInspection_item() {
		return inspection_item;
	}
	public void setInspection_item(String inspection_item) {
		this.inspection_item = inspection_item;
	}
	public String getInspection_tool() {
		return inspection_tool;
	}
	public void setInspection_tool(String inspection_tool) {
		this.inspection_tool = inspection_tool;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getMin_spec() {
		return min_spec;
	}
	public void setMin_spec(String min_spec) {
		this.min_spec = min_spec;
	}
	public String getMax_spec() {
		return max_spec;
	}
	public void setMax_spec(String max_spec) {
		this.max_spec = max_spec;
	}
	public String getInsp_val() {
		return insp_val;
	}
	public void setInsp_val(String insp_val) {
		this.insp_val = insp_val;
	}
	public String getInsp_rst() {
		return insp_rst;
	}
	public void setInsp_rst(String insp_rst) {
		this.insp_rst = insp_rst;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public String getInspection_point() {
		return inspection_point;
	}
	public void setInspection_point(String inspection_point) {
		this.inspection_point = inspection_point;
	} 
	
}
