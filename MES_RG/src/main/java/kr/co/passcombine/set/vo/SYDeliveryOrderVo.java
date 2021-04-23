package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYDeliveryOrderVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String business_code = "";
	private String business_nm = "";
	private String delivery_num = "";
	private String delivery_order_menge = "";
	private String delivery_order_date = "";
	private String order_num = "";
	private String item_code = "";
	private String item_nm = "";
	private String delivery_req_date = "";
	private String customer_code = "";
	private String customer_nm = "";
	private String land = "";
	private String unit_price = "";
	private String menge = "";
	private String total_price = "";
	private String success_status = "";
	
	private String stock_menge = "";
	private String delivery_menge = "";
	
	private String location = "";

	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	private String creator_nm;
	
	
	private String delivery_date;
	
	private String request_num;
	
	private String del_yn;
	
	
	

	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getRequest_num() {
		return request_num;
	}
	public void setRequest_num(String request_num) {
		this.request_num = request_num;
	}
	public String getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(String delivery_date) {
		this.delivery_date = delivery_date;
	}
	public String getCreator_nm() {
		return creator_nm;
	}
	public void setCreator_nm(String creator_nm) {
		this.creator_nm = creator_nm;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getBusiness_code() {
		return business_code;
	}
	public void setBusiness_code(String business_code) {
		this.business_code = business_code;
	}
	
	public String getBusiness_nm() {
		return business_nm;
	}
	public void setBusiness_nm(String business_nm) {
		this.business_nm = business_nm;
	}
	public String getDelivery_num() {
		return delivery_num;
	}
	public void setDelivery_num(String delivery_num) {
		this.delivery_num = delivery_num;
	}
	public String getDelivery_order_menge() {
		return delivery_order_menge;
	}
	public void setDelivery_order_menge(String delivery_order_menge) {
		this.delivery_order_menge = delivery_order_menge;
	}
	public String getDelivery_order_date() {
		return delivery_order_date;
	}
	public void setDelivery_order_date(String delivery_order_date) {
		this.delivery_order_date = delivery_order_date;
	}
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
		this.order_num = order_num;
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
	public String getDelivery_req_date() {
		return delivery_req_date;
	}
	public void setDelivery_req_date(String delivery_req_date) {
		this.delivery_req_date = delivery_req_date;
	}
	public String getCustomer_code() {
		return customer_code;
	}
	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
	}
	public String getCustomer_nm() {
		return customer_nm;
	}
	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}
	public String getLand() {
		return land;
	}
	public void setLand(String land) {
		this.land = land;
	}
	public String getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(String unit_price) {
		this.unit_price = unit_price;
	}
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
	}
	public String getTotal_price() {
		return total_price;
	}
	public void setTotal_price(String total_price) {
		this.total_price = total_price;
	}
	public String getSuccess_status() {
		return success_status;
	}
	public void setSuccess_status(String success_status) {
		this.success_status = success_status;
	}
	
	public String getStock_menge() {
		return stock_menge;
	}
	public void setStock_menge(String stock_menge) {
		this.stock_menge = stock_menge;
	}
	
	public String getDelivery_menge() {
		return delivery_menge;
	}
	public void setDelivery_menge(String delivery_menge) {
		this.delivery_menge = delivery_menge;
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
