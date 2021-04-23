package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYPurchaseOrderDetailVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String account_code = "";
	private String account_nm = "";
	private String purchase_order_num = "";
	private String purchase_num = "";
	private String purchase_date = "";
	private String purchase_req_date = "";
	private String purchase_end_date = "";
	private String purchase_status = "";
	private String purchase_status_main = "";
	
	private String item_code = "";
	private String item_nm = "";
	private String item_spec = "";
	private String item_type_code = "";
	private String item_type_nm = "";
	private String unit_price = "";
	private String menge = "";
	private String in_menge = "";
	private String total_price = "";
	private String del_yn = "";

	private String safety_menge = "";	// 안전재고
	private String warehousing_qty = "";	// 현재 재고
	
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	
	private String receiving_inspection_yn;
	private String receiving_inspection_routing_yn;
	
	private String pass_menge;
	
	private String in_ware_code;
	private String in_ware_nm;
	
	
	
	public String getIn_ware_code() {
		return in_ware_code;
	}
	public void setIn_ware_code(String in_ware_code) {
		this.in_ware_code = in_ware_code;
	}
	public String getIn_ware_nm() {
		return in_ware_nm;
	}
	public void setIn_ware_nm(String in_ware_nm) {
		this.in_ware_nm = in_ware_nm;
	}
	public String getPurchase_status_main() {
		return purchase_status_main;
	}
	public void setPurchase_status_main(String purchase_status_main) {
		this.purchase_status_main = purchase_status_main;
	}
	public String getPass_menge() {
		return pass_menge;
	}
	public void setPass_menge(String pass_menge) {
		this.pass_menge = pass_menge;
	}
	public String getReceiving_inspection_yn() {
		return receiving_inspection_yn;
	}
	public void setReceiving_inspection_yn(String receiving_inspection_yn) {
		this.receiving_inspection_yn = receiving_inspection_yn;
	}
	public String getReceiving_inspection_routing_yn() {
		return receiving_inspection_routing_yn;
	}
	public void setReceiving_inspection_routing_yn(
			String receiving_inspection_routing_yn) {
		this.receiving_inspection_routing_yn = receiving_inspection_routing_yn;
	}
	public String getPurchase_end_date() {
		return purchase_end_date;
	}
	public void setPurchase_end_date(String purchase_end_date) {
		this.purchase_end_date = purchase_end_date;
	}
	public String getItem_type_nm() {
		return item_type_nm;
	}
	public void setItem_type_nm(String item_type_nm) {
		this.item_type_nm = item_type_nm;
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
	public String getPurchase_order_num() {
		return purchase_order_num;
	}
	public void setPurchase_order_num(String purchase_order_num) {
		this.purchase_order_num = purchase_order_num;
	}
	public String getPurchase_num() {
		return purchase_num;
	}
	public void setPurchase_num(String purchase_num) {
		this.purchase_num = purchase_num;
	}
	
	public String getPurchase_date() {
		return purchase_date;
	}
	public void setPurchase_date(String purchase_date) {
		this.purchase_date = purchase_date;
	}
	public String getPurchase_req_date() {
		return purchase_req_date;
	}
	public void setPurchase_req_date(String purchase_req_date) {
		this.purchase_req_date = purchase_req_date;
	}
	public String getPurchase_status() {
		return purchase_status;
	}
	public void setPurchase_status(String purchase_status) {
		this.purchase_status = purchase_status;
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
	public String getItem_type_code() {
		return item_type_code;
	}
	public void setItem_type_code(String item_type_code) {
		this.item_type_code = item_type_code;
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
	public String getIn_menge() {
		return in_menge;
	}
	public void setIn_menge(String in_menge) {
		this.in_menge = in_menge;
	}
	public String getTotal_price() {
		return total_price;
	}
	public void setTotal_price(String total_price) {
		this.total_price = total_price;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	
	public String getSafety_menge() {
		return safety_menge;
	}
	public void setSafety_menge(String safety_menge) {
		this.safety_menge = safety_menge;
	}
	public String getWarehousing_qty() {
		return warehousing_qty;
	}
	public void setWarehousing_qty(String warehousing_qty) {
		this.warehousing_qty = warehousing_qty;
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
