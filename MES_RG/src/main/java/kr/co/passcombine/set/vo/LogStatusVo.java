package kr.co.passcombine.set.vo;

public class LogStatusVo {

	private static final long serialVersionUID = 1L;
	
	private String batch_log_no;
	private String batch_type;
	private String batch_action;
	private String batch_start_dt;
	private String batch_end_dt;
	private String batch_source_ds;
	private String batch_target_ds;
	private String batch_process_icnt;
	private String batch_process_ucnt;
	private String batch_result;
	private String batch_description;
	private String date_created;
	private String date_updated;
	private String creator;
	private String creator_nm;
	private String updater;
	private String update_nm;
	
	
	
	public String getBatch_log_no() {
		return batch_log_no;
	}
	public void setBatch_log_no(String batch_log_no) {
		this.batch_log_no = batch_log_no;
	}
	public String getBatch_type() {
		return batch_type;
	}
	public void setBatch_type(String batch_type) {
		this.batch_type = batch_type;
	}
	public String getBatch_action() {
		return batch_action;
	}
	public void setBatch_action(String batch_action) {
		this.batch_action = batch_action;
	}
	public String getBatch_start_dt() {
		return batch_start_dt;
	}
	public void setBatch_start_dt(String batch_start_dt) {
		this.batch_start_dt = batch_start_dt;
	}
	public String getBatch_end_dt() {
		return batch_end_dt;
	}
	public void setBatch_end_dt(String batch_end_dt) {
		this.batch_end_dt = batch_end_dt;
	}
	public String getBatch_source_ds() {
		return batch_source_ds;
	}
	public void setBatch_source_ds(String batch_source_ds) {
		this.batch_source_ds = batch_source_ds;
	}
	public String getBatch_target_ds() {
		return batch_target_ds;
	}
	public void setBatch_target_ds(String batch_target_ds) {
		this.batch_target_ds = batch_target_ds;
	}
	public String getBatch_process_icnt() {
		return batch_process_icnt;
	}
	public void setBatch_process_icnt(String batch_process_icnt) {
		this.batch_process_icnt = batch_process_icnt;
	}
	public String getBatch_process_ucnt() {
		return batch_process_ucnt;
	}
	public void setBatch_process_ucnt(String batch_process_ucnt) {
		this.batch_process_ucnt = batch_process_ucnt;
	}
	public String getBatch_result() {
		return batch_result;
	}
	public void setBatch_result(String batch_result) {
		this.batch_result = batch_result;
	}
	public String getBatch_description() {
		return batch_description;
	}
	public void setBatch_description(String batch_description) {
		this.batch_description = batch_description;
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
	public String getCreator_nm() {
		return creator_nm;
	}
	public void setCreator_nm(String creator_nm) {
		this.creator_nm = creator_nm;
	}
	public String getUpdate_nm() {
		return update_nm;
	}
	public void setUpdate_nm(String update_nm) {
		this.update_nm = update_nm;
	}
	@Override
	public String toString() {
		return "LogStatusVo [batch_log_no=" + batch_log_no + ", batch_type="
				+ batch_type + ", batch_action=" + batch_action
				+ ", batch_start_dt=" + batch_start_dt + ", batch_end_dt="
				+ batch_end_dt + ", batch_source_ds=" + batch_source_ds
				+ ", batch_target_ds=" + batch_target_ds
				+ ", batch_process_icnt=" + batch_process_icnt
				+ ", batch_process_ucnt=" + batch_process_ucnt
				+ ", batch_result=" + batch_result + ", batch_description="
				+ batch_description + ", date_created=" + date_created
				+ ", date_updated=" + date_updated + ", creator=" + creator
				+ ", creator_nm=" + creator_nm + ", updater=" + updater
				+ ", update_nm=" + update_nm + "]";
	}
}
