package kr.co.passcombine.set.vo;

public class SYKPI_ProductVo {
	
	
	private String product_po = "";
	private String item_code = ""; 	// P/N	
	private String item_nm = "";	// 품명
	private String product_req_date = "";
	private String product_date = "";	// 실적 일자
	private String year = "";
	private String month = "";
	private String order_menge = "";
	private String prod_menge;		// 실적수량
	private String prod_fail_menge;	// 불량수량
	private String fail_per;		// 불량율
	private String avg;				// TAT(평균)
	private String process_time;
	private String d_process_time;
	private String item_type_code;
	
	private String goal;
	
	
	
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getItem_type_code() {
		return item_type_code;
	}
	public void setItem_type_code(String item_type_code) {
		this.item_type_code = item_type_code;
	}
	public String getD_process_time() {
		return d_process_time;
	}
	public void setD_process_time(String d_process_time) {
		this.d_process_time = d_process_time;
	}
	public String getProcess_time() {
		return process_time;
	}
	public void setProcess_time(String process_time) {
		this.process_time = process_time;
	}
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
	public String getItem_nm() {
		return item_nm;
	}
	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}
	public String getProduct_req_date() {
		return product_req_date;
	}
	public void setProduct_req_date(String product_req_date) {
		this.product_req_date = product_req_date;
	}
	public String getProduct_date() {
		return product_date;
	}
	public void setProduct_date(String product_date) {
		this.product_date = product_date;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getOrder_menge() {
		return order_menge;
	}
	public void setOrder_menge(String order_menge) {
		this.order_menge = order_menge;
	}
	public String getProd_menge() {
		return prod_menge;
	}
	public void setProd_menge(String prod_menge) {
		this.prod_menge = prod_menge;
	}
	public String getProd_fail_menge() {
		return prod_fail_menge;
	}
	public void setProd_fail_menge(String prod_fail_menge) {
		this.prod_fail_menge = prod_fail_menge;
	}
	public String getFail_per() {
		return fail_per;
	}
	public void setFail_per(String fail_per) {
		this.fail_per = fail_per;
	}
	public String getAvg() {
		return avg;
	}
	public void setAvg(String avg) {
		this.avg = avg;
	}
	
	
}