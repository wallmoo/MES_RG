package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYDeliveryVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String delivery_num = "";
	private String delivery_menge = "";
	private String delivery_date = "";
	private String send_delivery_menge = "";
	private String real_send_delivery_menge ="";
	private String item_code = "";
	private String item_nm = "";
	private String del_yn = "";
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	private String stock_menge;
	
	private String creator_nm;
	
	

	
	
	public String getStock_menge() {
		return stock_menge;
	}
	public void setStock_menge(String stock_menge) {
		this.stock_menge = stock_menge;
	}
	public String getReal_send_delivery_menge() {
		return real_send_delivery_menge;
	}
	public void setReal_send_delivery_menge(String real_send_delivery_menge) {
		this.real_send_delivery_menge = real_send_delivery_menge;
	}
	public String getSend_delivery_menge() {
		return send_delivery_menge;
	}
	public void setSend_delivery_menge(String send_delivery_menge) {
		this.send_delivery_menge = send_delivery_menge;
	}
	public String getCreator_nm() {
		return creator_nm;
	}
	public void setCreator_nm(String creator_nm) {
		this.creator_nm = creator_nm;
	}
	
	public String getDelivery_num() {
		return delivery_num;
	}
	public void setDelivery_num(String delivery_num) {
		this.delivery_num = delivery_num;
	}
	
	public String getDelivery_menge() {
		return delivery_menge;
	}
	public void setDelivery_menge(String delivery_menge) {
		this.delivery_menge = delivery_menge;
	}
	public String getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(String delivery_date) {
		this.delivery_date = delivery_date;
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
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
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
