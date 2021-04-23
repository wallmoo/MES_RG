package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYKPI_OperationVo implements Serializable{


	private String year = "";
	private String month = "";
	private String product_po = "";
	private String routing_code = "";
	private String real_seq = "";
	private String machine_code = "";
	
	private String machine_nm = "";
	private String prod_str_time = "";
	private String prod_end_time = "";
	private String work_str_time = "";
	private String work_end_time = "";
	private String unwork_str_time = "";
	private String unwork_end_time = "";
	private String unwork_time = "";
	private String today_str_time = "";
	private String today_end_time = "";
	private String today_time = "";
	private String per = "";
	private String machine_class_code="";
	private String item_nm="";
	private String item_type_code;
	private String goal="";
	
	
	
	
	
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getItem_type_code() {
		return item_type_code;
	}
	public void setItem_type_code(String item_type_code) {
		this.item_type_code = item_type_code;
	}
	public String getItem_nm() {
		return item_nm;
	}
	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}
	public String getMachine_class_code() {
		return machine_class_code;
	}
	public void setMachine_class_code(String machine_class_code) {
		this.machine_class_code = machine_class_code;
	}
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	private String Origin_end_time;
	private String gb;
	private String item_code;
	private String work_time_sec;
	private String work_time_hour;
	private String today_time_sec;
	private String today_time_hour;
	private String prod_menge;
	private String prod_fail_menge;
	private String prod_menge_sum;
	private String prod_fail_menge_sum;
	private String work_time_sec_sum;
	
	
	
	public String getWork_time_sec_sum() {
		return work_time_sec_sum;
	}
	public void setWork_time_sec_sum(String work_time_sec_sum) {
		this.work_time_sec_sum = work_time_sec_sum;
	}
	public String getProd_menge_sum() {
		return prod_menge_sum;
	}
	public void setProd_menge_sum(String prod_menge_sum) {
		this.prod_menge_sum = prod_menge_sum;
	}
	public String getProd_fail_menge_sum() {
		return prod_fail_menge_sum;
	}
	public void setProd_fail_menge_sum(String prod_fail_menge_sum) {
		this.prod_fail_menge_sum = prod_fail_menge_sum;
	}
	public String getProd_menge() {
		return prod_menge;
	}
	public void setProd_menge(String prod_menge) {
		this.prod_menge = prod_menge;
	}
	public String getProd_fail_menge() {
		return prod_fail_menge;
	}
	public void setProd_fail_menge(String prod_fail_menge) {
		this.prod_fail_menge = prod_fail_menge;
	}
	public String getWork_time_sec() {
		return work_time_sec;
	}
	public void setWork_time_sec(String work_time_sec) {
		this.work_time_sec = work_time_sec;
	}
	public String getWork_time_hour() {
		return work_time_hour;
	}
	public void setWork_time_hour(String work_time_hour) {
		this.work_time_hour = work_time_hour;
	}
	public String getToday_time_sec() {
		return today_time_sec;
	}
	public void setToday_time_sec(String today_time_sec) {
		this.today_time_sec = today_time_sec;
	}
	public String getToday_time_hour() {
		return today_time_hour;
	}
	public void setToday_time_hour(String today_time_hour) {
		this.today_time_hour = today_time_hour;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public String getGb() {
		return gb;
	}
	public void setGb(String gb) {
		this.gb = gb;
	}
	public String getOrigin_end_time() {
		return Origin_end_time;
	}
	public void setOrigin_end_time(String origin_end_time) {
		Origin_end_time = origin_end_time;
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
	public String getProduct_po() {
		return product_po;
	}
	public void setProduct_po(String product_po) {
		this.product_po = product_po;
	}
	public String getRouting_code() {
		return routing_code;
	}
	public void setRouting_code(String routing_code) {
		this.routing_code = routing_code;
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
	public String getMachine_nm() {
		return machine_nm;
	}
	public void setMachine_nm(String machine_nm) {
		this.machine_nm = machine_nm;
	}
	public String getProd_str_time() {
		return prod_str_time;
	}
	public void setProd_str_time(String prod_str_time) {
		this.prod_str_time = prod_str_time;
	}
	public String getProd_end_time() {
		return prod_end_time;
	}
	public void setProd_end_time(String prod_end_time) {
		this.prod_end_time = prod_end_time;
	}
	public String getWork_str_time() {
		return work_str_time;
	}
	public void setWork_str_time(String work_str_time) {
		this.work_str_time = work_str_time;
	}
	public String getWork_end_time() {
		return work_end_time;
	}
	public void setWork_end_time(String work_end_time) {
		this.work_end_time = work_end_time;
	}
	public String getUnwork_str_time() {
		return unwork_str_time;
	}
	public void setUnwork_str_time(String unwork_str_time) {
		this.unwork_str_time = unwork_str_time;
	}
	public String getUnwork_end_time() {
		return unwork_end_time;
	}
	public void setUnwork_end_time(String unwork_end_time) {
		this.unwork_end_time = unwork_end_time;
	}
	public String getUnwork_time() {
		return unwork_time;
	}
	public void setUnwork_time(String unwork_time) {
		this.unwork_time = unwork_time;
	}
	public String getToday_str_time() {
		return today_str_time;
	}
	public void setToday_str_time(String today_str_time) {
		this.today_str_time = today_str_time;
	}
	public String getToday_end_time() {
		return today_end_time;
	}
	public void setToday_end_time(String today_end_time) {
		this.today_end_time = today_end_time;
	}
	public String getToday_time() {
		return today_time;
	}
	public void setToday_time(String today_time) {
		this.today_time = today_time;
	}
	public String getPer() {
		return per;
	}
	public void setPer(String per) {
		this.per = per;
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
	public void setWork_time_sec_sum(int work_time_sec_sum2) {
		// TODO Auto-generated method stub
		
	}
	public void setToday_time_sec_sum(int today_time_sec_sum) {
		// TODO Auto-generated method stub
		
	}
	public void setProd_menge_sum(int prod_menge_sum2) {
		// TODO Auto-generated method stub
		
	}
	public void setProd_fail_menge_sum(int prod_fail_menge_sum2) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	
	
}
