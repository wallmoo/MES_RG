package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYProduct2Vo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String dt; 
	private String prod_menge; 
	private String prod_fail_menge; 
	private String prod_fail_fa; 
	private String prod_fail_f; 
	private String item_code; 
	private String item_nm; 
	private String order_menge;
	private String routing_code; 
	private String routing_seq; 
	private String routing_nm; 
	private String prod_end_time;
	private String machine_code; 
	private String machine_nm; 
	private String machine_class_code;
	private String dt_i; 
	private String dt_u;
	
	private String sumPM;
	private String sumPFM;
	
	private String routing_gubun;
	
	private String product_po;
	
	
	
	
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
	}
	public String getRouting_gubun() {
		return routing_gubun;
	}
	public void setRouting_gubun(String routing_gubun) {
		this.routing_gubun = routing_gubun;
	}
	public String getDt() {
		return dt;
	}
	public void setDt(String dt) {
		this.dt = dt;
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
	public String getProd_fail_fa() {
		return prod_fail_fa;
	}
	public void setProd_fail_fa(String prod_fail_fa) {
		this.prod_fail_fa = prod_fail_fa;
	}
	public String getProd_fail_f() {
		return prod_fail_f;
	}
	public void setProd_fail_f(String prod_fail_f) {
		this.prod_fail_f = prod_fail_f;
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
	public String getOrder_menge() {
		return order_menge;
	}
	public void setOrder_menge(String order_menge) {
		this.order_menge = order_menge;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public String getRouting_seq() {
		return routing_seq;
	}
	public void setRouting_seq(String routing_seq) {
		this.routing_seq = routing_seq;
	}
	public String getRouting_nm() {
		return routing_nm;
	}
	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
	}
	public String getProd_end_time() {
		return prod_end_time;
	}
	public void setProd_end_time(String prod_end_time) {
		this.prod_end_time = prod_end_time;
	}
	public String getMachine_code() {
		return machine_code;
	}
	public void setMachine_code(String machine_code) {
		this.machine_code = machine_code;
	}
	public String getMachine_nm() {
		return machine_nm;
	}
	public void setMachine_nm(String machine_nm) {
		this.machine_nm = machine_nm;
	}
	public String getMachine_class_code() {
		return machine_class_code;
	}
	public void setMachine_class_code(String machine_class_code) {
		this.machine_class_code = machine_class_code;
	}
	public String getDt_i() {
		return dt_i;
	}
	public void setDt_i(String dt_i) {
		this.dt_i = dt_i;
	}
	public String getDt_u() {
		return dt_u;
	}
	public void setDt_u(String dt_u) {
		this.dt_u = dt_u;
	}
	public String getSumPM() {
		return sumPM;
	}
	public void setSumPM(String sumPM) {
		this.sumPM = sumPM;
	}
	public String getSumPFM() {
		return sumPFM;
	}
	public void setSumPFM(String sumPFM) {
		this.sumPFM = sumPFM;
	} 

}
