package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYIncome_resultVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String purchase_order_num; 
	private String purchase_num; 
	private String income_date; 
	private String item_code; 
	private String item_nm; 
	private String item_spec; 
	private String item_type_code; 
	private String item_type_nm; 
	private String unit_price; 
	private String income_menge; 
	private String income_people; 
	private String pass_yn; 
	private String del_yn; 
	private String creator; 
	private String updater; 
	private String date_created; 
	private String date_updated; 
	private String account_code; 
	private String account_nm; 
	private String in_menge; 
	private String receiving_inspection_yn;
	
	private String inspection_item; 
	private String spec; 
	private String min_spec; 
	private String max_spec;
	
	private String result_spec;
	private String inspection_seq;
	private String inspection_gubun;
	private String inspection_gubun_nm;
	private String inspection_tool;
	private String inspection_method;
	
	private String  pang_yn;
	
	private String pass_menge;
	
	private String menge;
	private String insp_status;
	
	private String gubun_all;
	
	private String c_dfct_cnt;
	private String comment;
	private String end_time;
	private String routing_nm;
	private String worker;
	
	private String insp_val;
	private String insp_rst;
	private String insp_case;

	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getPass_menge() {
		return pass_menge;
	}
	public void setPass_menge(String pass_menge) {
		this.pass_menge = pass_menge;
	}
	public String getPurchase_order_num() {
		return purchase_order_num;
	}
	public void setPurchase_order_num(String purchase_order_num) {
		this.purchase_order_num = purchase_order_num;
	}
	public String getPurchase_num() {
		return purchase_num;
	}
	public void setPurchase_num(String purchase_num) {
		this.purchase_num = purchase_num;
	}
	public String getIncome_date() {
		return income_date;
	}
	public void setIncome_date(String income_date) {
		this.income_date = income_date;
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
	public String getItem_spec() {
		return item_spec;
	}
	public void setItem_spec(String item_spec) {
		this.item_spec = item_spec;
	}
	public String getItem_type_code() {
		return item_type_code;
	}
	public void setItem_type_code(String item_type_code) {
		this.item_type_code = item_type_code;
	}
	public String getItem_type_nm() {
		return item_type_nm;
	}
	public void setItem_type_nm(String item_type_nm) {
		this.item_type_nm = item_type_nm;
	}
	public String getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(String unit_price) {
		this.unit_price = unit_price;
	}
	public String getIncome_menge() {
		return income_menge;
	}
	public void setIncome_menge(String income_menge) {
		this.income_menge = income_menge;
	}
	public String getIncome_people() {
		return income_people;
	}
	public void setIncome_people(String income_people) {
		this.income_people = income_people;
	}
	public String getPass_yn() {
		return pass_yn;
	}
	public void setPass_yn(String pass_yn) {
		this.pass_yn = pass_yn;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public String getDate_created() {
		return date_created;
	}
	public void setDate_created(String date_created) {
		this.date_created = date_created;
	}
	public String getDate_updated() {
		return date_updated;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	public String getAccount_code() {
		return account_code;
	}
	public void setAccount_code(String account_code) {
		this.account_code = account_code;
	}
	public String getAccount_nm() {
		return account_nm;
	}
	public void setAccount_nm(String account_nm) {
		this.account_nm = account_nm;
	}
	public String getIn_menge() {
		return in_menge;
	}
	public void setIn_menge(String in_menge) {
		this.in_menge = in_menge;
	}
	public String getReceiving_inspection_yn() {
		return receiving_inspection_yn;
	}
	public void setReceiving_inspection_yn(String receiving_inspection_yn) {
		this.receiving_inspection_yn = receiving_inspection_yn;
	}
	public String getInspection_item() {
		return inspection_item;
	}
	public void setInspection_item(String inspection_item) {
		this.inspection_item = inspection_item;
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
	public String getResult_spec() {
		return result_spec;
	}
	public void setResult_spec(String result_spec) {
		this.result_spec = result_spec;
	}
	public String getInspection_seq() {
		return inspection_seq;
	}
	public void setInspection_seq(String inspection_seq) {
		this.inspection_seq = inspection_seq;
	}
	public String getInspection_gubun() {
		return inspection_gubun;
	}
	public void setInspection_gubun(String inspection_gubun) {
		this.inspection_gubun = inspection_gubun;
	}
	public String getInspection_gubun_nm() {
		return inspection_gubun_nm;
	}
	public void setInspection_gubun_nm(String inspection_gubun_nm) {
		this.inspection_gubun_nm = inspection_gubun_nm;
	}
	public String getInspection_tool() {
		return inspection_tool;
	}
	public void setInspection_tool(String inspection_tool) {
		this.inspection_tool = inspection_tool;
	}
	public String getInspection_method() {
		return inspection_method;
	}
	public void setInspection_method(String inspection_method) {
		this.inspection_method = inspection_method;
	}
	public String getPang_yn() {
		return pang_yn;
	}
	public void setPang_yn(String pang_yn) {
		this.pang_yn = pang_yn;
	}
	public String getInsp_status() {
		return insp_status;
	}
	public void setInsp_status(String insp_status) {
		this.insp_status = insp_status;
	}
	public String getGubun_all() {
		return gubun_all;
	}
	public void setGubun_all(String gubun_all) {
		this.gubun_all = gubun_all;
	}
	public String getC_dfct_cnt() {
		return c_dfct_cnt;
	}
	public void setC_dfct_cnt(String c_dfct_cnt) {
		this.c_dfct_cnt = c_dfct_cnt;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getRouting_nm() {
		return routing_nm;
	}
	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
	}
	public String getWorker() {
		return worker;
	}
	public void setWorker(String worker) {
		this.worker = worker;
	}
	public String getInsp_val() {
		return insp_val;
	}
	public String getInsp_rst() {
		return insp_rst;
	}
	public void setInsp_val(String insp_val) {
		this.insp_val = insp_val;
	}
	public void setInsp_rst(String insp_rst) {
		this.insp_rst = insp_rst;
	}
	public String getInsp_case() {
		return insp_case;
	}
	public void setInsp_case(String insp_case) {
		this.insp_case = insp_case;
	} 

	
}
