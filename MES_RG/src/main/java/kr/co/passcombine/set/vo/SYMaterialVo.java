package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYMaterialVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String business_code;
	private String business_codeT;
	private String business_nm;
	private String item_code;
	private String item_nm;
	private String item_spec;
	private String item_type_code;
	private String item_type_codeT;
	private String item_type_nm;
	private String meins;
	private String warehousing_price;
	private String release_price;
	private String receiving_inspection_yn;
	private String receiving_inspection_routing_yn;
	private String class_yn;
	private String safety_stock_yn;
	private String safety_menge;
	
	private String routing_yn;
	
	private String one_yn;

	private String qc_yn;
	private String del_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	private String master_code;
	private String detail_code;
	private String code_nm;
	
	private String recordsLength;
	
	private String warehousing_qty;
	
	private String outsourcing_price;
	private String location;
	
	private String creator_nm;
	private String updater_nm;
	
	private String in_ware_code;
	private String prod_ware_code;
	private String in_ware_nm;
	private String prod_ware_nm;
	
	private String routing_nm;
	
	private String excelMax;
	private int pjt_idx;
	
	
	
	
	public int getPjt_idx() {
		return pjt_idx;
	}
	public void setPjt_idx(int pjt_idx) {
		this.pjt_idx = pjt_idx;
	}
	public String getExcelMax() {
		return excelMax;
	}
	public void setExcelMax(String excelMax) {
		this.excelMax = excelMax;
	}
	public String getRouting_nm() {
		return routing_nm;
	}
	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
	}
	public String getIn_ware_code() {
		return in_ware_code;
	}
	public void setIn_ware_code(String in_ware_code) {
		this.in_ware_code = in_ware_code;
	}
	public String getProd_ware_code() {
		return prod_ware_code;
	}
	public void setProd_ware_code(String prod_ware_code) {
		this.prod_ware_code = prod_ware_code;
	}
	public String getIn_ware_nm() {
		return in_ware_nm;
	}
	public void setIn_ware_nm(String in_ware_nm) {
		this.in_ware_nm = in_ware_nm;
	}
	public String getProd_ware_nm() {
		return prod_ware_nm;
	}
	public void setProd_ware_nm(String prod_ware_nm) {
		this.prod_ware_nm = prod_ware_nm;
	}
	public String getOne_yn() {
		return one_yn;
	}
	public void setOne_yn(String one_yn) {
		this.one_yn = one_yn;
	}
	public String getCreator_nm() {
		return creator_nm;
	}
	public void setCreator_nm(String creator_nm) {
		this.creator_nm = creator_nm;
	}
	public String getUpdater_nm() {
		return updater_nm;
	}
	public void setUpdater_nm(String updater_nm) {
		this.updater_nm = updater_nm;
	}
	public String getOutsourcing_price() {
		return outsourcing_price;
	}
	public void setOutsourcing_price(String outsourcing_price) {
		this.outsourcing_price = outsourcing_price;
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
	public String getBusiness_codeT() {
		return business_codeT;
	}
	public void setBusiness_codeT(String business_codeT) {
		this.business_codeT = business_codeT;
	}
	public String getBusiness_nm() {
		return business_nm;
	}
	public void setBusiness_nm(String business_nm) {
		this.business_nm = business_nm;
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
	
	public String getItem_type_codeT() {
		return item_type_codeT;
	}
	public void setItem_type_codeT(String item_type_codeT) {
		this.item_type_codeT = item_type_codeT;
	}
	public String getItem_type_nm() {
		return item_type_nm;
	}
	public void setItem_type_nm(String item_type_nm) {
		this.item_type_nm = item_type_nm;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public String getWarehousing_price() {
		return warehousing_price;
	}
	public void setWarehousing_price(String warehousing_price) {
		this.warehousing_price = warehousing_price;
	}
	public String getRelease_price() {
		return release_price;
	}
	public void setRelease_price(String release_price) {
		this.release_price = release_price;
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
	public String getClass_yn() {
		return class_yn;
	}
	public void setClass_yn(String class_yn) {
		this.class_yn = class_yn;
	}
	public String getSafety_stock_yn() {
		return safety_stock_yn;
	}
	public void setSafety_stock_yn(String safety_stock_yn) {
		this.safety_stock_yn = safety_stock_yn;
	}
	
	public String getSafety_menge() {
		return safety_menge;
	}
	public void setSafety_menge(String safety_menge) {
		this.safety_menge = safety_menge;
	}
	public String getRouting_yn() {
		return routing_yn;
	}
	public void setRouting_yn(String routing_yn) {
		this.routing_yn = routing_yn;
	}
	public String getQc_yn() {
		return qc_yn;
	}
	public void setQc_yn(String qc_yn) {
		this.qc_yn = qc_yn;
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
	
	public String getMaster_code() {
		return master_code;
	}
	public void setMaster_code(String master_code) {
		this.master_code = master_code;
	}
	public String getDetail_code() {
		return detail_code;
	}
	public void setDetail_code(String detail_code) {
		this.detail_code = detail_code;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getRecordsLength() {
		return recordsLength;
	}
	public void setRecordsLength(String recordsLength) {
		this.recordsLength = recordsLength;
	}
	public String getWarehousing_qty() {
		return warehousing_qty;
	}
	public void setWarehousing_qty(String warehousing_qty) {
		this.warehousing_qty = warehousing_qty;
	}

}
