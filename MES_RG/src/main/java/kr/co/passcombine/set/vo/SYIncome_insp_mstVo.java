package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYIncome_insp_mstVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String item_code; 
	private String inspection_seq; 
	private String inspection_item; 
	private String inspection_gubun; 
	private String inspection_tool; 
	private String inspection_method; 
	private String spec; 
	private String min_spec; 
	private String max_spec; 
	private String use_yn; 
	private String creator; 
	private String updater; 
	private String date_created; 
	private String date_updated;
	
	private String receiving_inspection_routing_yn ;
	
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public String getInspection_seq() {
		return inspection_seq;
	}
	public void setInspection_seq(String inspection_seq) {
		this.inspection_seq = inspection_seq;
	}
	public String getInspection_item() {
		return inspection_item;
	}
	public void setInspection_item(String inspection_item) {
		this.inspection_item = inspection_item;
	}
	public String getInspection_gubun() {
		return inspection_gubun;
	}
	public void setInspection_gubun(String inspection_gubun) {
		this.inspection_gubun = inspection_gubun;
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
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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
	public String getReceiving_inspection_routing_yn() {
		return receiving_inspection_routing_yn;
	}
	public void setReceiving_inspection_routing_yn(String receiving_inspection_routing_yn) {
		this.receiving_inspection_routing_yn = receiving_inspection_routing_yn;
	} 
	
	
}
