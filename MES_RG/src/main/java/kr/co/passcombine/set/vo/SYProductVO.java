package kr.co.passcombine.set.vo;

import java.util.ArrayList;

public class SYProductVO {
	

	private String product_po = "";
	private String product_class = "";
	private String product_status = "";
	private String product_status_info = "";
	private String routing_code = "";
	private String routing_nm = "";
	private String product_req_date = "";
	private String product_date = "";
	private String order_num = "";
	private String item_code = "";
	private String item_nm = "";
	private String delivery_date = "";
	private String order_menge = "";
	private String warehouse_delivery_menge = "";
	private String product_menge = "";
	private String raw_out_yn = "";
	private String del_yn;
	
	
	private String routing_nms= "";
	private String routing_codes= "";
	
	private String flag = "";
	private String gubun = "";
	
	private String prod_fail_menge;
	
	private String prod_menges = "";
	private String prod_fail_menges = "";
	
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	
	private String next_routing_nm;
	
	private String next_routing_code;
	private String file_path;
	
	
	private String machine_code;
	
	
	private String real_seq;
	
	private String status;
	private String insp_case;
	private String warehouse_gubun;
	private String end_time;
	
	
	private ArrayList<String> list;
	
	
	private String one_yn;
	
	
	private String search_type;
	
	
	

	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getOne_yn() {
		return one_yn;
	}
	public void setOne_yn(String one_yn) {
		this.one_yn = one_yn;
	}
	public ArrayList<String> getList() {
		return list;
	}
	public void setList(ArrayList<String> list) {
		this.list = list;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReal_seq() {
		return real_seq;
	}
	public void setReal_seq(String real_seq) {
		this.real_seq = real_seq;
	}
	public String getMachine_code() {
		return machine_code;
	}
	public void setMachine_code(String machine_code) {
		this.machine_code = machine_code;
	}
	public String getNext_routing_code() {
		return next_routing_code;
	}
	public void setNext_routing_code(String next_routing_code) {
		this.next_routing_code = next_routing_code;
	}
	public String getNext_routing_nm() {
		return next_routing_nm;
	}
	public void setNext_routing_nm(String next_routing_nm) {
		this.next_routing_nm = next_routing_nm;
	}
	public String getProd_menges() {
		return prod_menges;
	}
	public void setProd_menges(String prod_menges) {
		this.prod_menges = prod_menges;
	}
	public String getProd_fail_menges() {
		return prod_fail_menges;
	}
	public void setProd_fail_menges(String prod_fail_menges) {
		this.prod_fail_menges = prod_fail_menges;
	}
	public String getProd_fail_menge() {
		return prod_fail_menge;
	}
	public void setProd_fail_menge(String prod_fail_menge) {
		this.prod_fail_menge = prod_fail_menge;
	}
	public String getRouting_nms() {
		return routing_nms;
	}
	public void setRouting_nms(String routing_nms) {
		this.routing_nms = routing_nms;
	}
	public String getRouting_codes() {
		return routing_codes;
	}
	public void setRouting_codes(String routing_codes) {
		this.routing_codes = routing_codes;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
	}
	public String getProduct_class() {
		return product_class;
	}
	public void setProduct_class(String product_class) {
		this.product_class = product_class;
	}
	public String getProduct_status() {
		return product_status;
	}
	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}
	
	public String getProduct_status_info() {
		return product_status_info;
	}
	public void setProduct_status_info(String product_status_info) {
		this.product_status_info = product_status_info;
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
	public String getProduct_req_date() {
		return product_req_date;
	}
	public void setProduct_req_date(String product_req_date) {
		this.product_req_date = product_req_date;
	}
	public String getProduct_date() {
		return product_date;
	}
	public void setProduct_date(String product_date) {
		this.product_date = product_date;
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
	public String getOrder_menge() {
		return order_menge;
	}
	public void setOrder_menge(String order_menge) {
		this.order_menge = order_menge;
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
	public String getRaw_out_yn() {
		return raw_out_yn;
	}
	public void setRaw_out_yn(String raw_out_yn) {
		this.raw_out_yn = raw_out_yn;
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
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getInsp_case() {
		return insp_case;
	}
	public void setInsp_case(String insp_case) {
		this.insp_case = insp_case;
	}
	public String getWarehouse_gubun() {
		return warehouse_gubun;
	}
	public void setWarehouse_gubun(String warehouse_gubun) {
		this.warehouse_gubun = warehouse_gubun;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	
	

}
