package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYPurchaseOrderVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String purchase_order_num = "";
	private String purchase_status = "";
	private String purchase_date = "";
	
	private String account_code = "";
	private String account_nm = "";
	
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	
	public String getPurchase_order_num() {
		return purchase_order_num;
	}
	public void setPurchase_order_num(String purchase_order_num) {
		this.purchase_order_num = purchase_order_num;
	}
	public String getPurchase_status() {
		return purchase_status;
	}
	public void setPurchase_status(String purchase_status) {
		this.purchase_status = purchase_status;
	}
	public String getPurchase_date() {
		return purchase_date;
	}
	public void setPurchase_date(String purchase_date) {
		this.purchase_date = purchase_date;
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
