package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYOrganVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
	
  private String cmd;
  private String company_cd;
  private String company_nm;
  private String dept_cd;
  private String dept_nm;
  private String dept_nm_en;
  private String dept_class;
  private String dept_type;
  private String dept_sdate;
  private String dept_edate;
  private String dept_use_yn;
  private String dept_p_cd;
  private String dept_p_nm;
  private String dept_order;
  private String date_created;
  private String date_updated;
  private String creator;
  private String updater;
  private Integer cnt_child;
  
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String getCompany_cd() {
		return company_cd;
	}
	public void setCompany_cd(String company_cd) {
		this.company_cd = company_cd;
	}
	public String getCompany_nm() {
		return company_nm;
	}
	public void setCompany_nm(String company_nm) {
		this.company_nm = company_nm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getDept_nm_en() {
		return dept_nm_en;
	}
	public void setDept_nm_en(String dept_nm_en) {
		this.dept_nm_en = dept_nm_en;
	}
	public String getDept_class() {
		return dept_class;
	}
	public void setDept_class(String dept_class) {
		this.dept_class = dept_class;
	}
	public String getDept_type() {
		return dept_type;
	}
	public void setDept_type(String dept_type) {
		this.dept_type = dept_type;
	}
	public String getDept_sdate() {
		return dept_sdate;
	}
	public void setDept_sdate(String dept_sdate) {
		this.dept_sdate = dept_sdate;
	}
	public String getDept_edate() {
		return dept_edate;
	}
	public void setDept_edate(String dept_edate) {
		this.dept_edate = dept_edate;
	}
	public String getDept_use_yn() {
		return dept_use_yn;
	}
	public void setDept_use_yn(String dept_use_yn) {
		this.dept_use_yn = dept_use_yn;
	}
	public String getDept_p_cd() {
		return dept_p_cd;
	}
	public void setDept_p_cd(String dept_p_cd) {
		this.dept_p_cd = dept_p_cd;
	}
	public String getDept_p_nm() {
		return dept_p_nm;
	}
	public void setDept_p_nm(String dept_p_nm) {
		this.dept_p_nm = dept_p_nm;
	}
	public String getDept_order() {
		return dept_order;
	}
	public void setDept_order(String dept_order) {
		this.dept_order = dept_order;
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
	public Integer getCnt_child() {
		return cnt_child;
	}
	public void setCnt_child(Integer cnt_child) {
		this.cnt_child = cnt_child;
	}
}
