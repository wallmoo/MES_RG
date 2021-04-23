package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYCodeVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
	
  private String cmd;
  private String master_code;
  private String detail_code;
  private String code_nm;
  private String code_nm_en;
  private String code_dscr;
  private String code_order;
  private String code_use_yn;
  private String filter1_val;
  private String filter2_val;
  private String filter3_val;
  private String date_created;
  private String date_updated;
  private String creator;
  private String updater;
  
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
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
	public String getCode_nm_en() {
		return code_nm_en;
	}
	public void setCode_nm_en(String code_nm_en) {
		this.code_nm_en = code_nm_en;
	}
	public String getCode_dscr() {
		return code_dscr;
	}
	public void setCode_dscr(String code_dscr) {
		this.code_dscr = code_dscr;
	}
	public String getCode_order() {
		return code_order;
	}
	public void setCode_order(String code_order) {
		this.code_order = code_order;
	}
	public String getCode_use_yn() {
		return code_use_yn;
	}
	public void setCode_use_yn(String code_use_yn) {
		this.code_use_yn = code_use_yn;
	}
	public String getFilter1_val() {
		return filter1_val;
	}
	public void setFilter1_val(String filter1_val) {
		this.filter1_val = filter1_val;
	}
	public String getFilter2_val() {
		return filter2_val;
	}
	public void setFilter2_val(String filter2_val) {
		this.filter2_val = filter2_val;
	}
	public String getFilter3_val() {
		return filter3_val;
	}
	public void setFilter3_val(String filter3_val) {
		this.filter3_val = filter3_val;
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
