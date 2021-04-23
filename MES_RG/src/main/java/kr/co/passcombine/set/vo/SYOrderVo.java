package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYOrderVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String business_code = "";
	private String order_num = "";
	private String item_code = "";
	private String item_nm = "";
	private String delivery_date = "";
	private String customer_code = "";
	private String customer_nm = "";
	private String sap_code = "";
	private String comment = "";
	private String request_num = "";
	
	private String manager_nm = "";
	private String land = "";
	private String unit_price = "";
	private String menge = "";
	private String total_price = "";
	private String success_status = "";
	
	private String order_stock_menge = "";
	private String stock_menge = "";

	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	private String warehouse_delivery_menge;
	private String product_menge;
	private String product_po;
	
	private String product_po_origin;
	
	
	private String plan_status;
	
	private String product_status;
	private String process_status;
	
	
	private String serial_no;
	
	
	private String item_rec_id;
	
	private String fast_yn;
	
	
	
	
	
	public String getFast_yn() {
		return fast_yn;
	}
	public void setFast_yn(String fast_yn) {
		this.fast_yn = fast_yn;
	}
	public String getItem_rec_id() {
		return item_rec_id;
	}
	public void setItem_rec_id(String item_rec_id) {
		this.item_rec_id = item_rec_id;
	}
	public String getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
	}
	public String getProduct_status() {
		return product_status;
	}
	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}
	public String getProcess_status() {
		return process_status;
	}
	public void setProcess_status(String process_status) {
		this.process_status = process_status;
	}
	public String getPlan_status() {
		return plan_status;
	}
	public void setPlan_status(String plan_status) {
		this.plan_status = plan_status;
	}
	public String getProduct_po_origin() {
		return product_po_origin;
	}
	public void setProduct_po_origin(String product_po_origin) {
		this.product_po_origin = product_po_origin;
	}
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
	}
	public String getWarehouse_delivery_menge() {
		return warehouse_delivery_menge;
	}
	public void setWarehouse_delivery_menge(String warehouse_delivery_menge) {
		this.warehouse_delivery_menge = warehouse_delivery_menge;
	}
	public String getProduct_menge() {
		return product_menge;
	}
	public void setProduct_menge(String product_menge) {
		this.product_menge = product_menge;
	}
	public String getBusiness_code() {
		return business_code;
	}
	public void setBusiness_code(String business_code) {
		this.business_code = business_code;
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
	public String getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(String delivery_date) {
		this.delivery_date = delivery_date;
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
	public String getSap_code() {
		return sap_code;
	}
	public void setSap_code(String sap_code) {
		this.sap_code = sap_code;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getRequest_num() {
		return request_num;
	}
	public void setRequest_num(String request_num) {
		this.request_num = request_num;
	}
	public String getManager_nm() {
		return manager_nm;
	}
	public void setManager_nm(String manager_nm) {
		this.manager_nm = manager_nm;
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
	
	public String getOrder_stock_menge() {
		return order_stock_menge;
	}
	public void setOrder_stock_menge(String order_stock_menge) {
		this.order_stock_menge = order_stock_menge;
	}
	
	public String getStock_menge() {
		return stock_menge;
	}
	public void setStock_menge(String stock_menge) {
		this.stock_menge = stock_menge;
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
