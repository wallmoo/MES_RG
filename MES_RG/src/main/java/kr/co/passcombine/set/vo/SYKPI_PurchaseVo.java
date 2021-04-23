package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYKPI_PurchaseVo implements Serializable{


	private String account_code = "";
	private String account_nm = "";
	private String year = "";
	private String month = "";
	private String item_code = "";
	private String item_nm = "";
	private String item_type_code = "";
	private String item_type_nm = "";
	
	private String unit_price = "";
	private String menge = "";
	private String total_price = "";
	private String in_menge = "";
	private String in_price = "";
	private String no_price = "";
	private String no_menge = "";
	
	
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	private String gubun="";
	private String goal="";
	
	private String sum_price_acc;
	private String goal_acc;
	
	private String prev_no_price;
	
	
	
	
	
	public String getPrev_no_price() {
		return prev_no_price;
	}
	public void setPrev_no_price(String prev_no_price) {
		this.prev_no_price = prev_no_price;
	}
	public String getSum_price_acc() {
		return sum_price_acc;
	}
	public void setSum_price_acc(String sum_price_acc) {
		this.sum_price_acc = sum_price_acc;
	}
	public String getGoal_acc() {
		return goal_acc;
	}
	public void setGoal_acc(String goal_acc) {
		this.goal_acc = goal_acc;
	}
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getNo_menge() {
		return no_menge;
	}
	public void setNo_menge(String no_menge) {
		this.no_menge = no_menge;
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
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
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
	public String getIn_menge() {
		return in_menge;
	}
	public void setIn_menge(String in_menge) {
		this.in_menge = in_menge;
	}
	public String getIn_price() {
		return in_price;
	}
	public void setIn_price(String in_price) {
		this.in_price = in_price;
	}
	public String getNo_price() {
		return no_price;
	}
	public void setNo_price(String no_price) {
		this.no_price = no_price;
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
