package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYInspectMasterVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String item_code;
	private String routing_code;
	private String inspect_code;
	private String routing_nm;
	private String routing_gubun;
	private String inspect_nm;
	private String inspect_spec;
	private String use_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
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
	public String getInspect_code() {
		return inspect_code;
	}
	public void setInspect_code(String inspect_code) {
		this.inspect_code = inspect_code;
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
	public String getInspect_nm() {
		return inspect_nm;
	}
	public void setInspect_nm(String inspect_nm) {
		this.inspect_nm = inspect_nm;
	}
	public String getInspect_spec() {
		return inspect_spec;
	}
	public void setInspect_spec(String inspect_spec) {
		this.inspect_spec = inspect_spec;
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
	
	
}
