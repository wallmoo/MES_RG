package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYWareHousingVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String date = "";
	
	private String warehousing_status = "";
	
	private String purchase_order_num = "";
	private String purchase_num = "";
	private String in_date = "";
	
	private String item_code = "";
	private String item_nm = "";
	private String item_spec = "";
	private String item_type_code = "";
	private String item_type_nm = "";
	
	private String serial_no = "";
	private String meins = "";
	private String in_menge = "";
	private String delivery_date = "";
	
	private String file_group = "";
	private String file_no = "";
	private String mill_sheet_no = "";
	private String file_repo = "";
	private String file_cate = "";
	private String file_path = "";
	private String file_name = "";
	private String file_ext = "";
	private long file_size = 0;
	
	private String del_yn = "";
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	private String in_date_doc = "";
	private String in_type;
	
	
	
	public String menge = "";
	
	private String original_cnt = "";


	private String warehousing_qty;
	private String warehousing_price;
	
	private String current_serial_no;
	
	private String in_comment = "";
	
	private String comment = "";
	
	private String in_qty;
	private String out_qty;

	private String warehouse_qty;
	
	private String account_nm;
	
	
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
	public String getAccount_nm() {
		return account_nm;
	}
	public void setAccount_nm(String account_nm) {
		this.account_nm = account_nm;
	}
	public String getWarehouse_qty() {
		return warehouse_qty;
	}
	public void setWarehouse_qty(String warehouse_qty) {
		this.warehouse_qty = warehouse_qty;
	}
	public String getIn_qty() {
		return in_qty;
	}
	public void setIn_qty(String in_qty) {
		this.in_qty = in_qty;
	}
	public String getOut_qty() {
		return out_qty;
	}
	public void setOut_qty(String out_qty) {
		this.out_qty = out_qty;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getIn_comment() {
		return in_comment;
	}
	public void setIn_comment(String in_comment) {
		this.in_comment = in_comment;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getIn_type() {
		return in_type;
	}
	public void setIn_type(String in_type) {
		this.in_type = in_type;
	}
	public String getCurrent_serial_no() {
		return current_serial_no;
	}
	public void setCurrent_serial_no(String current_serial_no) {
		this.current_serial_no = current_serial_no;
	}
	public String getWarehousing_qty() {
		return warehousing_qty;
	}
	public void setWarehousing_qty(String warehousing_qty) {
		this.warehousing_qty = warehousing_qty;
	}
	public String getWarehousing_price() {
		return warehousing_price;
	}
	public void setWarehousing_price(String warehousing_price) {
		this.warehousing_price = warehousing_price;
	}
	public String getOriginal_cnt() {
		return original_cnt;
	}
	public void setOriginal_cnt(String original_cnt) {
		this.original_cnt = original_cnt;
	}
	public String getMenge() {
		return menge;
	}
	public void setMenge(String menge) {
		this.menge = menge;
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
	public String getIn_date_doc() {
		return in_date_doc;
	}
	public void setIn_date_doc(String in_date_doc) {
		this.in_date_doc = in_date_doc;
	}
	public String getWarehousing_status() {
		return warehousing_status;
	}
	public void setWarehousing_status(String warehousing_status) {
		this.warehousing_status = warehousing_status;
	}
	public String getIn_date() {
		return in_date;
	}
	public void setIn_date(String in_date) {
		this.in_date = in_date;
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
	public String getIn_menge() {
		return in_menge;
	}
	public void setIn_menge(String in_menge) {
		this.in_menge = in_menge;
	}
	public String getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(String delivery_date) {
		this.delivery_date = delivery_date;
	}
	public String getFile_group() {
		return file_group;
	}
	public void setFile_group(String file_group) {
		this.file_group = file_group;
	}
	public String getFile_no() {
		return file_no;
	}
	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}
	public String getMill_sheet_no() {
		return mill_sheet_no;
	}
	public void setMill_sheet_no(String mill_sheet_no) {
		this.mill_sheet_no = mill_sheet_no;
	}
	public String getFile_repo() {
		return file_repo;
	}
	public void setFile_repo(String file_repo) {
		this.file_repo = file_repo;
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
