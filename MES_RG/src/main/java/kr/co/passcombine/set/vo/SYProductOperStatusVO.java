package kr.co.passcombine.set.vo;

public class SYProductOperStatusVO {
	 

	private String grapType = "";
	private String year = "";
	
	private String month;
	private String product_po = "";
	private String routing_code = "";
	private String routing_seq = "";
	private String real_seq;
	private String routing_nm = "";
	private String routing_gubun = "";
	private String status = "";
	private String machine_code = "";
	private String machine_nm = "";
	private String warehouse_gubun = "";
	private String member_emp_no = "";
	private String member_nm = "";
	private String prod_str_time;
	private String prod_end_time;
	private String process_time;
	
	private String outsourcing_gubun;
	private String machine_gubun;
	
	private String skip_yn = "";

	
	private String del_yn = "";
	
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	private String unprod_comment;
	private String prev_prod_menge = "0";
	private String prev_prod_fail_menge = "0";
	private String req_prod_menge;
	private String prod_menge;
	private String prod_fail_menge;
	private String order_menge;
	
	private String account_nm;
	private String delivery_request_date;
	private String item_code;
	private String item_nm;
	private String account_code;
	
	private String end_date;
	
	
	private String product_date;
	
	
	private String outsourcing_price;
	
	private String work_str_time;
	private String work_end_time;
	private String view_machine_process="";
	private String gb = "";
	private String matching_routing_code;
	
	private String origin_end_time;
	
	private String change_str_time;
	
	private String work_time_sec = "0";
	
	private String work_time_hour = "";
	
	private String today_str_time;
	
	private String today_end_time;
	
	private String today_time_sec = "";
	
	private String today_time_hour = "";
	
	private String process_time_hour = "";
	private String unprocess_time_hour = "";
	private String waiting_time_hour = "";
	
	private String per;
	
	private int work_time_sec_sum = 0;
	private int today_time_sec_sum = 0;
	private int prod_menge_sum = 0;
	private int prod_fail_menge_sum =0;
	
	
	private int today_time_s = 0;
	private int process_time_s = 0;
	private int unprocess_time_s = 0;
	private int waiting_time_s = 0;
	
	

	private float today_total = 0;
	
	private String machine_class_code ="";
	
	
	private String goal = "";
	
	
	
	public String getGoal() {
		return goal;
	}

	public void setGoal(String goal) {
		this.goal = goal;
	}

	public String getMachine_class_code() {
		return machine_class_code;
	}

	public void setMachine_class_code(String machine_class_code) {
		this.machine_class_code = machine_class_code;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getGrapType() {
		return grapType;
	}

	public void setGrapType(String grapType) {
		this.grapType = grapType;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public float getToday_total() {
		return today_total;
	}

	public void setToday_total(float today_total) {
		this.today_total = today_total;
	}

	public String getProcess_time_hour() {
		return process_time_hour;
	}

	public void setProcess_time_hour(String process_time_hour) {
		this.process_time_hour = process_time_hour;
	}

	public String getUnprocess_time_hour() {
		return unprocess_time_hour;
	}

	public void setUnprocess_time_hour(String unprocess_time_hour) {
		this.unprocess_time_hour = unprocess_time_hour;
	}

	public String getWaiting_time_hour() {
		return waiting_time_hour;
	}

	public void setWaiting_time_hour(String waiting_time_hour) {
		this.waiting_time_hour = waiting_time_hour;
	}

	public int getToday_time_s() {
		return today_time_s;
	}

	public void setToday_time_s(int today_time_s) {
		this.today_time_s = today_time_s;
	}

	public int getProcess_time_s() {
		return process_time_s;
	}

	public void setProcess_time_s(int process_time_s) {
		this.process_time_s = process_time_s;
	}

	public int getUnprocess_time_s() {
		return unprocess_time_s;
	}

	public void setUnprocess_time_s(int unprocess_time_s) {
		this.unprocess_time_s = unprocess_time_s;
	}

	public int getWaiting_time_s() {
		return waiting_time_s;
	}

	public void setWaiting_time_s(int waiting_time_s) {
		this.waiting_time_s = waiting_time_s;
	}

	public int getWork_time_sec_sum() {
		return work_time_sec_sum;
	}

	public void setWork_time_sec_sum(int work_time_sec_sum) {
		this.work_time_sec_sum = work_time_sec_sum;
	}

	public int getToday_time_sec_sum() {
		return today_time_sec_sum;
	}

	public void setToday_time_sec_sum(int today_time_sec_sum) {
		this.today_time_sec_sum = today_time_sec_sum;
	}

	public int getProd_menge_sum() {
		return prod_menge_sum;
	}

	public void setProd_menge_sum(int prod_menge_sum) {
		this.prod_menge_sum = prod_menge_sum;
	}

	public int getProd_fail_menge_sum() {
		return prod_fail_menge_sum;
	}

	public void setProd_fail_menge_sum(int prod_fail_menge_sum) {
		this.prod_fail_menge_sum = prod_fail_menge_sum;
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

	public String getPer() {
		return per;
	}

	public void setPer(String per) {
		this.per = per;
	}

	public String getChange_str_time() {
		return change_str_time;
	}

	public void setChange_str_time(String change_str_time) {
		this.change_str_time = change_str_time;
	}

	public String getOrigin_end_time() {
		return origin_end_time;
	}

	public void setOrigin_end_time(String origin_end_time) {
		this.origin_end_time = origin_end_time;
	}

	private String work_time;
	


	public String getWork_time() {
		return work_time;
	}

	public void setWork_time(String work_time) {
		this.work_time = work_time;
	}

	public String getMatching_routing_code() {
		return matching_routing_code;
	}

	public void setMatching_routing_code(String matching_routing_code) {
		this.matching_routing_code = matching_routing_code;
	}

	public String getGb() {
		return gb;
	}

	public void setGb(String gb) {
		this.gb = gb;
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

	public String getView_machine_process() {
		return view_machine_process;
	}

	public void setView_machine_process(String view_machine_process) {
		this.view_machine_process = view_machine_process;
	}

	public String getOutsourcing_price() {
		return outsourcing_price;
	}

	public void setOutsourcing_price(String outsourcing_price) {
		this.outsourcing_price = outsourcing_price;
	}

	public String getPrev_prod_fail_menge() {
		return prev_prod_fail_menge;
	}

	public void setPrev_prod_fail_menge(String prev_prod_fail_menge) {
		this.prev_prod_fail_menge = prev_prod_fail_menge;
	}

	public String getProduct_date() {
		return product_date;
	}

	public void setProduct_date(String product_date) {
		this.product_date = product_date;
	}

	public String getReal_seq() {
		return real_seq;
	}

	public void setReal_seq(String real_seq) {
		this.real_seq = real_seq;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getAccount_code() {
		return account_code;
	}

	public void setAccount_code(String account_code) {
		this.account_code = account_code;
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

	public String getAccount_nm() {
		return account_nm;
	}

	public void setAccount_nm(String account_nm) {
		this.account_nm = account_nm;
	}

	public String getDelivery_request_date() {
		return delivery_request_date;
	}

	public void setDelivery_request_date(String delivery_request_date) {
		this.delivery_request_date = delivery_request_date;
	}

	public String getPrev_prod_menge() {
		return prev_prod_menge;
	}

	public void setPrev_prod_menge(String prev_prod_menge) {
		this.prev_prod_menge = prev_prod_menge;
	}

	public String getReq_prod_menge() {
		return req_prod_menge;
	}

	public void setReq_prod_menge(String req_prod_menge) {
		this.req_prod_menge = req_prod_menge;
	}

	public String getProd_fail_menge() {
		return prod_fail_menge;
	}

	public void setProd_fail_menge(String prod_fail_menge) {
		this.prod_fail_menge = prod_fail_menge;
	}

	public String getOrder_menge() {
		return order_menge;
	}

	public void setOrder_menge(String order_menge) {
		this.order_menge = order_menge;
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

	public String getRouting_seq() {
		return routing_seq;
	}

	public void setRouting_seq(String routing_seq) {
		this.routing_seq = routing_seq;
	}

	public String getRouting_nm() {
		return routing_nm;
	}

	public void setRouting_nm(String routing_nm) {
		this.routing_nm = routing_nm;
	}

	public String getRouting_gubun() {
		return routing_gubun;
	}

	public void setRouting_gubun(String routing_gubun) {
		this.routing_gubun = routing_gubun;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public String getWarehouse_gubun() {
		return warehouse_gubun;
	}

	public void setWarehouse_gubun(String warehouse_gubun) {
		this.warehouse_gubun = warehouse_gubun;
	}

	public String getMember_emp_no() {
		return member_emp_no;
	}

	public void setMember_emp_no(String member_emp_no) {
		this.member_emp_no = member_emp_no;
	}

	public String getMember_nm() {
		return member_nm;
	}

	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
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

	public String getProcess_time() {
		return process_time;
	}

	public void setProcess_time(String process_time) {
		this.process_time = process_time;
	}

	public String getOutsourcing_gubun() {
		return outsourcing_gubun;
	}

	public void setOutsourcing_gubun(String outsourcing_gubun) {
		this.outsourcing_gubun = outsourcing_gubun;
	}

	public String getMachine_gubun() {
		return machine_gubun;
	}

	public void setMachine_gubun(String machine_gubun) {
		this.machine_gubun = machine_gubun;
	}

	public String getSkip_yn() {
		return skip_yn;
	}

	public void setSkip_yn(String skip_yn) {
		this.skip_yn = skip_yn;
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

	public String getUnprod_comment() {
		return unprod_comment;
	}

	public void setUnprod_comment(String unprod_comment) {
		this.unprod_comment = unprod_comment;
	}

	public String getProd_menge() {
		return prod_menge;
	}

	public void setProd_menge(String prod_menge) {
		this.prod_menge = prod_menge;
	}
	
	
}
