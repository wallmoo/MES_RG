package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYSelf_InspFailVo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String product_po;
	private String gubun;
	
	private String fail_num;
	
	private String dis_routing_nm;
	private String receipt_date;
	private String customer_nm;
	private String item_code;
	private String prod_menge;
	private String prod_fail_menge;
	private String fail_type_nm;
	private String fail_type_code;
	private String reason;
	private String cause;
	private String comment1;
	private String comment2;
	private String complete_date;
	private String comment_date; 
	
	private String file_cate;
	private String file_path;
	private String file_name;
	private String file_ext;
	private long file_size = 0;
	
	private String t_file_cate;
	private String t_file_path;
	private String t_file_name;
	private String t_file_ext;
	private long t_file_size = 0;
	
	private String del_yn;
	
	private String routing_code;
	private String routing_nm;
	
	private String current_status;
	
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	
	public String getFail_type_code() {
		return fail_type_code;
	}
	public void setFail_type_code(String fail_type_code) {
		this.fail_type_code = fail_type_code;
	}
	public String getFail_num() {
		return fail_num;
	}
	public void setFail_num(String fail_num) {
		this.fail_num = fail_num;
	}
	public String getCurrent_status() {
		return current_status;
	}
	public void setCurrent_status(String current_status) {
		this.current_status = current_status;
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
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getDis_routing_nm() {
		return dis_routing_nm;
	}
	public void setDis_routing_nm(String dis_routing_nm) {
		this.dis_routing_nm = dis_routing_nm;
	}
	public String getReceipt_date() {
		return receipt_date;
	}
	public void setReceipt_date(String receipt_date) {
		this.receipt_date = receipt_date;
	}
	public String getCustomer_nm() {
		return customer_nm;
	}
	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
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
	public String getFail_type_nm() {
		return fail_type_nm;
	}
	public void setFail_type_nm(String fail_type_nm) {
		this.fail_type_nm = fail_type_nm;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getCause() {
		return cause;
	}
	public void setCause(String cause) {
		this.cause = cause;
	}
	public String getComment1() {
		return comment1;
	}
	public void setComment1(String comment1) {
		this.comment1 = comment1;
	}
	public String getComment2() {
		return comment2;
	}
	public void setComment2(String comment2) {
		this.comment2 = comment2;
	}
	public String getComplete_date() {
		return complete_date;
	}
	public void setComplete_date(String complete_date) {
		this.complete_date = complete_date;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	public String getFile_cate() {
		return file_cate;
	}
	public void setFile_cate(String file_cate) {
		this.file_cate = file_cate;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_ext() {
		return file_ext;
	}
	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public String getT_file_cate() {
		return t_file_cate;
	}
	public void setT_file_cate(String t_file_cate) {
		this.t_file_cate = t_file_cate;
	}
	public String getT_file_path() {
		return t_file_path;
	}
	public void setT_file_path(String t_file_path) {
		this.t_file_path = t_file_path;
	}
	public String getT_file_name() {
		return t_file_name;
	}
	public void setT_file_name(String t_file_name) {
		this.t_file_name = t_file_name;
	}
	public String getT_file_ext() {
		return t_file_ext;
	}
	public void setT_file_ext(String t_file_ext) {
		this.t_file_ext = t_file_ext;
	}
	public long getT_file_size() {
		return t_file_size;
	}
	public void setT_file_size(long t_file_size) {
		this.t_file_size = t_file_size;
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
