package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYWareHouseRawVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String product_po = "";
	private String business_code = "";
	private String business_nm = "";
	private String warehouse_code = "";
	private String warehouse_nm = "";
	private String out_warehousing_status = "";
	
	private String item_code = "";
	private String item_nm = "";
	private String item_spec = "";
	private String item_type_code = "";
	private String item_type_nm = "";
	
	private String serial_no = "";
	private String division_seq = "";
	private String meins = "";
	private String warehouse_raw_price = "";
	private String warehouse_raw_qty = "";
	private String warehouse_raw_change_qty = "";
	
	private String del_yn = "";
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	
	private String partition_rate = "";
	private String origin_item_code = "";
	
	
	private String original_cnt = "";
	
	
	private String mill_sheet_no;
	private String file_path;
	private String file_name;
	private String file_ext;
	
	private String safety_stock_qty;

	private String business_codeT;
	
	private String warehousing_price;
	private String warehousing_qty;
	
	private String p_item_code;
	
	private String current_serial_no;
	
	private String in_date;
	
	

	
	public String getIn_date() {
		return in_date;
	}
	public void setIn_date(String in_date) {
		this.in_date = in_date;
	}
	public String getCurrent_serial_no() {
		return current_serial_no;
	}
	public void setCurrent_serial_no(String current_serial_no) {
		this.current_serial_no = current_serial_no;
	}
	public String getP_item_code() {
		return p_item_code;
	}
	public void setP_item_code(String p_item_code) {
		this.p_item_code = p_item_code;
	}
	public String getWarehousing_price() {
		return warehousing_price;
	}
	public void setWarehousing_price(String warehousing_price) {
		this.warehousing_price = warehousing_price;
	}
	public String getWarehousing_qty() {
		return warehousing_qty;
	}
	public void setWarehousing_qty(String warehousing_qty) {
		this.warehousing_qty = warehousing_qty;
	}
	public String getBusiness_codeT() {
		return business_codeT;
	}
	public void setBusiness_codeT(String business_codeT) {
		this.business_codeT = business_codeT;
	}
	public String getSafety_stock_qty() {
		return safety_stock_qty;
	}
	public void setSafety_stock_qty(String safety_stock_qty) {
		this.safety_stock_qty = safety_stock_qty;
	}
	public String getMill_sheet_no() {
		return mill_sheet_no;
	}
	public void setMill_sheet_no(String mill_sheet_no) {
		this.mill_sheet_no = mill_sheet_no;
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
	public String getOriginal_cnt() {
		return original_cnt;
	}
	public void setOriginal_cnt(String original_cnt) {
		this.original_cnt = original_cnt;
	}
	public String getOrigin_item_code() {
		return origin_item_code;
	}
	public void setOrigin_item_code(String origin_item_code) {
		this.origin_item_code = origin_item_code;
	}
	public String getPartition_rate() {
		return partition_rate;
	}
	public void setPartition_rate(String partition_rate) {
		this.partition_rate = partition_rate;
	}
	public String getDivision_seq() {
		return division_seq;
	}
	public void setDivision_seq(String division_seq) {
		this.division_seq = division_seq;
	}
	public String getWarehouse_raw_change_qty() {
		return warehouse_raw_change_qty;
	}
	public void setWarehouse_raw_change_qty(String warehouse_raw_change_qty) {
		this.warehouse_raw_change_qty = warehouse_raw_change_qty;
	}
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
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
	public String getWarehouse_code() {
		return warehouse_code;
	}
	public void setWarehouse_code(String warehouse_code) {
		this.warehouse_code = warehouse_code;
	}
	public String getWarehouse_nm() {
		return warehouse_nm;
	}
	public void setWarehouse_nm(String warehouse_nm) {
		this.warehouse_nm = warehouse_nm;
	}
	public String getOut_warehousing_status() {
		return out_warehousing_status;
	}
	public void setOut_warehousing_status(String out_warehousing_status) {
		this.out_warehousing_status = out_warehousing_status;
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
	public String getItem_type_nm() {
		return item_type_nm;
	}
	public void setItem_type_nm(String item_type_nm) {
		this.item_type_nm = item_type_nm;
	}
	public String getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getWarehouse_raw_price() {
		return warehouse_raw_price;
	}
	public void setWarehouse_raw_price(String warehouse_raw_price) {
		this.warehouse_raw_price = warehouse_raw_price;
	}
	public String getWarehouse_raw_qty() {
		return warehouse_raw_qty;
	}
	public void setWarehouse_raw_qty(String warehouse_raw_qty) {
		this.warehouse_raw_qty = warehouse_raw_qty;
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
