package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYInspectionMasterVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String item_code; 
	private String routing_code; 
	private String inspection_seq; 
	private String routing_nm; 
	private String inspection_item; 
	private String inspection_gubun; 
	private String inspection_gubun_nm;
	private String inspection_tool; 
	private String inspection_method;
	private String inspection_method_nm;
	private String inspection_point;
	private String spec; 
	private String min_spec; 
	private String max_spec; 
	private String use_yn; 
	private String creator; 
	private String updater; 
	private String date_created; 
	private String date_updated;
	private String qc_yn;
	
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public String getInspection_seq() {
		return inspection_seq;
	}
	public void setInspection_seq(String inspection_seq) {
		this.inspection_seq = inspection_seq;
	}
	public String getRouting_nm() {
		return routing_nm;
	}
	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
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
	public String getInspection_method_nm() {
		return inspection_method_nm;
	}
	public void setInspection_method_nm(String inspection_method_nm) {
		this.inspection_method_nm = inspection_method_nm;
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
	public String getQc_yn() {
		return qc_yn;
	}
	public void setQc_yn(String qc_yn) {
		this.qc_yn = qc_yn;
	}
	public String getInspection_point() {
		return inspection_point;
	}
	public void setInspection_point(String inspection_point) {
		this.inspection_point = inspection_point;
	} 

}
