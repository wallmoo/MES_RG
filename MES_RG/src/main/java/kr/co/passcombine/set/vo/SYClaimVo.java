package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYClaimVo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String claim_num;
	private String receipt_date;
	private String claim_date;
	private String complete_date;
	private String status;
	
	private String customer_nm;
	private String customer_code;
	private String item_code;
	private String item_nm;
	private String serial_no;
	
	private String out_date;
	private String mounting_date;
	private String desorption_date;
	
	private String reason;
	private String comment1;
	private String comment2;
	private String comment3;

	private String apply;
	private String result;
	private String type;
	private String comment_etc;
	private String claim_type;
	
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
	
	
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	
	
	public String getClaim_type() {
		return claim_type;
	}
	public void setClaim_type(String claim_type) {
		this.claim_type = claim_type;
	}
	public String getClaim_num() {
		return claim_num;
	}
	public void setClaim_num(String claim_num) {
		this.claim_num = claim_num;
	}
	public String getReceipt_date() {
		return receipt_date;
	}
	public void setReceipt_date(String receipt_date) {
		this.receipt_date = receipt_date;
	}
	public String getClaim_date() {
		return claim_date;
	}
	public void setClaim_date(String claim_date) {
		this.claim_date = claim_date;
	}
	public String getComplete_date() {
		return complete_date;
	}
	public void setComplete_date(String complete_date) {
		this.complete_date = complete_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCustomer_nm() {
		return customer_nm;
	}
	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}
	public String getCustomer_code() {
		return customer_code;
	}
	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
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
	public String getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
	}
	public String getOut_date() {
		return out_date;
	}
	public void setOut_date(String out_date) {
		this.out_date = out_date;
	}
	public String getMounting_date() {
		return mounting_date;
	}
	public void setMounting_date(String mounting_date) {
		this.mounting_date = mounting_date;
	}
	public String getDesorption_date() {
		return desorption_date;
	}
	public void setDesorption_date(String desorption_date) {
		this.desorption_date = desorption_date;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
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
	public String getComment3() {
		return comment3;
	}
	public void setComment3(String comment3) {
		this.comment3 = comment3;
	}
	public String getApply() {
		return apply;
	}
	public void setApply(String apply) {
		this.apply = apply;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getComment_etc() {
		return comment_etc;
	}
	public void setComment_etc(String comment_etc) {
		this.comment_etc = comment_etc;
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
