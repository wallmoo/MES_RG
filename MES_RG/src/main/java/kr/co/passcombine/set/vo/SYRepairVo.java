package kr.co.passcombine.set.vo;

public class SYRepairVo {
	private String repair_num;
	private String repair_class_code;
	private String repair_class_nm;
	private String customer_integration_nm;
	private String carry_in_customer_code;
	private String carry_in_land;
	private String carry_out_customer_code;
	private String carry_out_land;
	private String item_code;
	private String item_nm;
	private String sernr;
	private String carry_in_date;
	private String repair_date;
	private String out_date;
	private String proc1_manager_nm;
	private String proc2_manager_nm;
	private String proc3_manager_nm;
	private String proc4_manager_nm;
	private String proc5_manager_nm;
	private String proc6_manager_nm;
	
	private String using_day;
	private String proc1_code;
	private String proc1_file_group;
	private String proc1_date;
	private String proc2_code;
	private String proc2_file_group;
	private String proc2_date;
	private String proc3_code;
	private String proc3_file_group;
	private String proc3_date;
	private String proc4_code;
	private String proc4_file_group;
	private String proc4_date;
	private String proc5_code;
	private String proc5_file_group;
	private String proc5_date;
	private String proc6_code;
	private String proc6_file_group;
	private String proc6_date;
	private String success_status;
	private String del_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	private String proc1_date_d;
	private String proc2_date_d;
	private String proc3_date_d;
	private String proc4_date_d;
	private String proc5_date_d;
	private String proc6_date_d;
	
	
	private String proc1_file_name;
	private String proc2_file_name;
	private String proc3_file_name;
	private String proc4_file_name;
	private String proc5_file_name;
	private String proc6_file_name;
	
	private String proc1_file_path;
	private String proc2_file_path;
	private String proc3_file_path;
	private String proc4_file_path;
	private String proc5_file_path;
	private String proc6_file_path;
	
	private String report_code;

	private String customer_integration_code;
	private String carry_in_date_st;
	private String carry_in_date_ed;
	private String in_customer_nm;
	private String out_customer_nm;
	
	private String out_date_start;
	private String out_date_end;
	
	private String in_date_start;
	private String in_date_end;
	
	private String repair_comment;
	
	private String proc2_request_date;
	private String proc2_account_code;
	private String proc2_account_nm;
	
	private String current_status;
	
	private String proc2_outsourcing_price;
	
	private String status;
	
	private String out_date_time;
	
	
	private String proc1_date_ymd;
	
	private String proc2_date_ymd;
	
	private String diff_time;
	
	
	
	
	public String getDiff_time() {
		return diff_time;
	}
	public void setDiff_time(String diff_time) {
		this.diff_time = diff_time;
	}
	public String getProc2_date_ymd() {
		return proc2_date_ymd;
	}
	public void setProc2_date_ymd(String proc2_date_ymd) {
		this.proc2_date_ymd = proc2_date_ymd;
	}
	public String getProc1_date_ymd() {
		return proc1_date_ymd;
	}
	public void setProc1_date_ymd(String proc1_date_ymd) {
		this.proc1_date_ymd = proc1_date_ymd;
	}
	public String getOut_date_time() {
		return out_date_time;
	}
	public void setOut_date_time(String out_date_time) {
		this.out_date_time = out_date_time;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getProc2_outsourcing_price() {
		return proc2_outsourcing_price;
	}
	public void setProc2_outsourcing_price(String proc2_outsourcing_price) {
		this.proc2_outsourcing_price = proc2_outsourcing_price;
	}
	public String getIn_date_start() {
		return in_date_start;
	}
	public void setIn_date_start(String in_date_start) {
		this.in_date_start = in_date_start;
	}
	public String getIn_date_end() {
		return in_date_end;
	}
	public void setIn_date_end(String in_date_end) {
		this.in_date_end = in_date_end;
	}
	public String getCurrent_status() {
		return current_status;
	}
	public void setCurrent_status(String current_status) {
		this.current_status = current_status;
	}
	public String getProc2_account_code() {
		return proc2_account_code;
	}
	public void setProc2_account_code(String proc2_account_code) {
		this.proc2_account_code = proc2_account_code;
	}
	public String getProc2_account_nm() {
		return proc2_account_nm;
	}
	public void setProc2_account_nm(String proc2_account_nm) {
		this.proc2_account_nm = proc2_account_nm;
	}
	public String getProc2_request_date() {
		return proc2_request_date;
	}
	public void setProc2_request_date(String proc2_request_date) {
		this.proc2_request_date = proc2_request_date;
	}
	public String getRepair_comment() {
		return repair_comment;
	}
	public void setRepair_comment(String repair_comment) {
		this.repair_comment = repair_comment;
	}
	public String getProc1_date_d() {
		return proc1_date_d;
	}
	public void setProc1_date_d(String proc1_date_d) {
		this.proc1_date_d = proc1_date_d;
	}
	public String getProc2_date_d() {
		return proc2_date_d;
	}
	public void setProc2_date_d(String proc2_date_d) {
		this.proc2_date_d = proc2_date_d;
	}
	public String getProc3_date_d() {
		return proc3_date_d;
	}
	public void setProc3_date_d(String proc3_date_d) {
		this.proc3_date_d = proc3_date_d;
	}
	public String getProc4_date_d() {
		return proc4_date_d;
	}
	public void setProc4_date_d(String proc4_date_d) {
		this.proc4_date_d = proc4_date_d;
	}
	public String getProc5_date_d() {
		return proc5_date_d;
	}
	public void setProc5_date_d(String proc5_date_d) {
		this.proc5_date_d = proc5_date_d;
	}
	public String getProc6_date_d() {
		return proc6_date_d;
	}
	public void setProc6_date_d(String proc6_date_d) {
		this.proc6_date_d = proc6_date_d;
	}
	public String getOut_date_start() {
		return out_date_start;
	}
	public void setOut_date_start(String out_date_start) {
		this.out_date_start = out_date_start;
	}
	public String getOut_date_end() {
		return out_date_end;
	}
	public void setOut_date_end(String out_date_end) {
		this.out_date_end = out_date_end;
	}
	public String getRepair_num() {
		return repair_num;
	}
	public void setRepair_num(String repair_num) {
		this.repair_num = repair_num;
	}
	public String getRepair_class_code() {
		return repair_class_code;
	}
	public void setRepair_class_code(String repair_class_code) {
		this.repair_class_code = repair_class_code;
	}
	public String getRepair_class_nm() {
		return repair_class_nm;
	}
	public void setRepair_class_nm(String repair_class_nm) {
		this.repair_class_nm = repair_class_nm;
	}
	public String getCustomer_integration_nm() {
		return customer_integration_nm;
	}
	public void setCustomer_integration_nm(String customer_integration_nm) {
		this.customer_integration_nm = customer_integration_nm;
	}
	public String getCarry_in_customer_code() {
		return carry_in_customer_code;
	}
	public void setCarry_in_customer_code(String carry_in_customer_code) {
		this.carry_in_customer_code = carry_in_customer_code;
	}
	public String getCarry_in_land() {
		return carry_in_land;
	}
	public void setCarry_in_land(String carry_in_land) {
		this.carry_in_land = carry_in_land;
	}
	public String getCarry_out_customer_code() {
		return carry_out_customer_code;
	}
	public void setCarry_out_customer_code(String carry_out_customer_code) {
		this.carry_out_customer_code = carry_out_customer_code;
	}
	public String getCarry_out_land() {
		return carry_out_land;
	}
	public void setCarry_out_land(String carry_out_land) {
		this.carry_out_land = carry_out_land;
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
	public String getSernr() {
		return sernr;
	}
	public void setSernr(String sernr) {
		this.sernr = sernr;
	}
	public String getCarry_in_date() {
		return carry_in_date;
	}
	public void setCarry_in_date(String carry_in_date) {
		this.carry_in_date = carry_in_date;
	}
	public String getRepair_date() {
		return repair_date;
	}
	public void setRepair_date(String repair_date) {
		this.repair_date = repair_date;
	}
	public String getOut_date() {
		return out_date;
	}
	public void setOut_date(String out_date) {
		this.out_date = out_date;
	}
	public String getProc1_manager_nm() {
		return proc1_manager_nm;
	}
	public void setProc1_manager_nm(String proc1_manager_nm) {
		this.proc1_manager_nm = proc1_manager_nm;
	}
	public String getProc2_manager_nm() {
		return proc2_manager_nm;
	}
	public void setProc2_manager_nm(String proc2_manager_nm) {
		this.proc2_manager_nm = proc2_manager_nm;
	}
	public String getProc3_manager_nm() {
		return proc3_manager_nm;
	}
	public void setProc3_manager_nm(String proc3_manager_nm) {
		this.proc3_manager_nm = proc3_manager_nm;
	}
	public String getProc4_manager_nm() {
		return proc4_manager_nm;
	}
	public void setProc4_manager_nm(String proc4_manager_nm) {
		this.proc4_manager_nm = proc4_manager_nm;
	}
	public String getProc5_manager_nm() {
		return proc5_manager_nm;
	}
	public void setProc5_manager_nm(String proc5_manager_nm) {
		this.proc5_manager_nm = proc5_manager_nm;
	}
	public String getProc6_manager_nm() {
		return proc6_manager_nm;
	}
	public void setProc6_manager_nm(String proc6_manager_nm) {
		this.proc6_manager_nm = proc6_manager_nm;
	}
	public String getUsing_day() {
		return using_day;
	}
	public void setUsing_day(String using_day) {
		this.using_day = using_day;
	}
	public String getProc1_code() {
		return proc1_code;
	}
	public void setProc1_code(String proc1_code) {
		this.proc1_code = proc1_code;
	}
	public String getProc1_file_group() {
		return proc1_file_group;
	}
	public void setProc1_file_group(String proc1_file_group) {
		this.proc1_file_group = proc1_file_group;
	}
	public String getProc1_date() {
		return proc1_date;
	}
	public void setProc1_date(String proc1_date) {
		this.proc1_date = proc1_date;
	}
	public String getProc2_code() {
		return proc2_code;
	}
	public void setProc2_code(String proc2_code) {
		this.proc2_code = proc2_code;
	}
	public String getProc2_file_group() {
		return proc2_file_group;
	}
	public void setProc2_file_group(String proc2_file_group) {
		this.proc2_file_group = proc2_file_group;
	}
	public String getProc2_date() {
		return proc2_date;
	}
	public void setProc2_date(String proc2_date) {
		this.proc2_date = proc2_date;
	}
	public String getProc3_code() {
		return proc3_code;
	}
	public void setProc3_code(String proc3_code) {
		this.proc3_code = proc3_code;
	}
	public String getProc3_file_group() {
		return proc3_file_group;
	}
	public void setProc3_file_group(String proc3_file_group) {
		this.proc3_file_group = proc3_file_group;
	}
	public String getProc3_date() {
		return proc3_date;
	}
	public void setProc3_date(String proc3_date) {
		this.proc3_date = proc3_date;
	}
	public String getProc4_code() {
		return proc4_code;
	}
	public void setProc4_code(String proc4_code) {
		this.proc4_code = proc4_code;
	}
	public String getProc4_file_group() {
		return proc4_file_group;
	}
	public void setProc4_file_group(String proc4_file_group) {
		this.proc4_file_group = proc4_file_group;
	}
	public String getProc4_date() {
		return proc4_date;
	}
	public void setProc4_date(String proc4_date) {
		this.proc4_date = proc4_date;
	}
	public String getProc5_code() {
		return proc5_code;
	}
	public void setProc5_code(String proc5_code) {
		this.proc5_code = proc5_code;
	}
	public String getProc5_file_group() {
		return proc5_file_group;
	}
	public void setProc5_file_group(String proc5_file_group) {
		this.proc5_file_group = proc5_file_group;
	}
	public String getProc5_date() {
		return proc5_date;
	}
	public void setProc5_date(String proc5_date) {
		this.proc5_date = proc5_date;
	}
	public String getProc6_code() {
		return proc6_code;
	}
	public void setProc6_code(String proc6_code) {
		this.proc6_code = proc6_code;
	}
	public String getProc6_file_group() {
		return proc6_file_group;
	}
	public void setProc6_file_group(String proc6_file_group) {
		this.proc6_file_group = proc6_file_group;
	}
	public String getProc6_date() {
		return proc6_date;
	}
	public void setProc6_date(String proc6_date) {
		this.proc6_date = proc6_date;
	}
	public String getSuccess_status() {
		return success_status;
	}
	public void setSuccess_status(String success_status) {
		this.success_status = success_status;
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
	public String getProc1_file_name() {
		return proc1_file_name;
	}
	public void setProc1_file_name(String proc1_file_name) {
		this.proc1_file_name = proc1_file_name;
	}
	public String getProc2_file_name() {
		return proc2_file_name;
	}
	public void setProc2_file_name(String proc2_file_name) {
		this.proc2_file_name = proc2_file_name;
	}
	public String getProc3_file_name() {
		return proc3_file_name;
	}
	public void setProc3_file_name(String proc3_file_name) {
		this.proc3_file_name = proc3_file_name;
	}
	public String getProc4_file_name() {
		return proc4_file_name;
	}
	public void setProc4_file_name(String proc4_file_name) {
		this.proc4_file_name = proc4_file_name;
	}
	public String getProc5_file_name() {
		return proc5_file_name;
	}
	public void setProc5_file_name(String proc5_file_name) {
		this.proc5_file_name = proc5_file_name;
	}
	public String getProc6_file_name() {
		return proc6_file_name;
	}
	public void setProc6_file_name(String proc6_file_name) {
		this.proc6_file_name = proc6_file_name;
	}
	public String getProc1_file_path() {
		return proc1_file_path;
	}
	public void setProc1_file_path(String proc1_file_path) {
		this.proc1_file_path = proc1_file_path;
	}
	public String getProc2_file_path() {
		return proc2_file_path;
	}
	public void setProc2_file_path(String proc2_file_path) {
		this.proc2_file_path = proc2_file_path;
	}
	public String getProc3_file_path() {
		return proc3_file_path;
	}
	public void setProc3_file_path(String proc3_file_path) {
		this.proc3_file_path = proc3_file_path;
	}
	public String getProc4_file_path() {
		return proc4_file_path;
	}
	public void setProc4_file_path(String proc4_file_path) {
		this.proc4_file_path = proc4_file_path;
	}
	public String getProc5_file_path() {
		return proc5_file_path;
	}
	public void setProc5_file_path(String proc5_file_path) {
		this.proc5_file_path = proc5_file_path;
	}
	public String getProc6_file_path() {
		return proc6_file_path;
	}
	public void setProc6_file_path(String proc6_file_path) {
		this.proc6_file_path = proc6_file_path;
	}
	public String getReport_code() {
		return report_code;
	}
	public void setReport_code(String report_code) {
		this.report_code = report_code;
	}
	public String getCustomer_integration_code() {
		return customer_integration_code;
	}
	public void setCustomer_integration_code(String customer_integration_code) {
		this.customer_integration_code = customer_integration_code;
	}
	public String getCarry_in_date_st() {
		return carry_in_date_st;
	}
	public void setCarry_in_date_st(String carry_in_date_st) {
		this.carry_in_date_st = carry_in_date_st;
	}
	public String getCarry_in_date_ed() {
		return carry_in_date_ed;
	}
	public void setCarry_in_date_ed(String carry_in_date_ed) {
		this.carry_in_date_ed = carry_in_date_ed;
	}
	public String getIn_customer_nm() {
		return in_customer_nm;
	}
	public void setIn_customer_nm(String in_customer_nm) {
		this.in_customer_nm = in_customer_nm;
	}
	public String getOut_customer_nm() {
		return out_customer_nm;
	}
	public void setOut_customer_nm(String out_customer_nm) {
		this.out_customer_nm = out_customer_nm;
	}
	
}