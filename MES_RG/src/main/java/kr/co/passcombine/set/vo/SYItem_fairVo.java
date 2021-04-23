package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYItem_fairVo implements Serializable{


	private String gb = "";
	private String item_code = "";
	private String item_nm = "";
	private String work_time = "";
	private String unwork_time = "";
	private String routing_code = "";
	
	private String product_po = "";
	private String real_seq = "";
	private String work_str_time = "";
	private String work_end_time = "";
	private String unwork_str_time = "";
	private String unwork_end_time = "";
	
	private String waiting_time = "";
	private String waiting_str_time = "";
	private String waiting_end_time = "";
	
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	
	public String getWaiting_time() {
		return waiting_time;
	}
	public void setWaiting_time(String waiting_time) {
		this.waiting_time = waiting_time;
	}
	public String getWaiting_str_time() {
		return waiting_str_time;
	}
	public void setWaiting_str_time(String waiting_str_time) {
		this.waiting_str_time = waiting_str_time;
	}
	public String getWaiting_end_time() {
		return waiting_end_time;
	}
	public void setWaiting_end_time(String waiting_end_time) {
		this.waiting_end_time = waiting_end_time;
	}
	public String getGb() {
		return gb;
	}
	public void setGb(String gb) {
		this.gb = gb;
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
	public String getWork_time() {
		return work_time;
	}
	public void setWork_time(String work_time) {
		this.work_time = work_time;
	}
	public String getUnwork_time() {
		return unwork_time;
	}
	public void setUnwork_time(String unwork_time) {
		this.unwork_time = unwork_time;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
	}
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
	}
	public String getReal_seq() {
		return real_seq;
	}
	public void setReal_seq(String real_seq) {
		this.real_seq = real_seq;
	}
	public String getWork_str_time() {
		return work_str_time;
	}
	public void setWork_str_time(String work_str_time) {
		this.work_str_time = work_str_time;
	}
	public String getWork_end_time() {
		return work_end_time;
	}
	public void setWork_end_time(String work_end_time) {
		this.work_end_time = work_end_time;
	}
	public String getUnwork_str_time() {
		return unwork_str_time;
	}
	public void setUnwork_str_time(String unwork_str_time) {
		this.unwork_str_time = unwork_str_time;
	}
	public String getUnwork_end_time() {
		return unwork_end_time;
	}
	public void setUnwork_end_time(String unwork_end_time) {
		this.unwork_end_time = unwork_end_time;
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
	
	
	
	
	
	
	
}
