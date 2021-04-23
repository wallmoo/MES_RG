package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYQualityVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String business_code;
	private String business_codeT;
	private String business_nm;
	private String item_code;
	private String item_nm;
	private String item_spec;
	private String routing_code;
	private String routing_nm;
	private String routing_gubun;
	private String routing_yn;
	private String qc_yn;
	private String del_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	public String getBusiness_code() {
		return business_code;
	}
	public void setBusiness_code(String business_code) {
		this.business_code = business_code;
	}
	public String getBusiness_codeT() {
		return business_codeT;
	}
	public void setBusiness_codeT(String business_codeT) {
		this.business_codeT = business_codeT;
	}
	public String getBusiness_nm() {
		return business_nm;
	}
	public void setBusiness_nm(String business_nm) {
		this.business_nm = business_nm;
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
	
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public String getRouting_nm() {
		return routing_nm;
	}
	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
	}
	
	public String getRouting_gubun() {
		return routing_gubun;
	}
	public void setRouting_gubun(String routing_gubun) {
		this.routing_gubun = routing_gubun;
	}
	public String getRouting_yn() {
		return routing_yn;
	}
	public void setRouting_yn(String routing_yn) {
		this.routing_yn = routing_yn;
	}
	public String getQc_yn() {
		return qc_yn;
	}
	public void setQc_yn(String qc_yn) {
		this.qc_yn = qc_yn;
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
	

}
