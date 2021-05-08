package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYMemberVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
	
  private String cmd;
  private String member_emp_no;
  private String default_member_emp_no;
  private String member_id;
  private String member_email;
  private String member_pwd;
  private String member_nm;
  private String member_nm_en;
  private String phone_no;
  private String extension;
  private String company_cd;
  private String company_nm;
  private String area_cd;
  private String use_yn;
  private String init_yn;
  private String pwd_chg_date;
  private String date_created;
  private String date_updated;
  private String creator;
  private String updater;
  
  private String chn_dept_cd;
  private String dept_cd;
  private String dept_nm;
  private String dept_nm_en;
  private String position_cd;
  private String position_nm;
  private String start_dt;
  private String end_dt;
  private Integer map_ord;
  private String member_new_pwd;
  private String member_lang;
  
	private String role_cd;
	private String role_nm;
	
	private Integer page;
	private Integer rows;
	private Integer rnum;
	private String sidx;
	private String sord;
	
	private String vendor_cd;
	private String vendor_nm; 
	
	private String lang; 
	private String jocod; 
	private String vdr_idx;
	
  
	public String getVdr_idx() {
		return vdr_idx;
	}
	public void setVdr_idx(String vdr_idx) {
		this.vdr_idx = vdr_idx;
	}
	public String getMember_new_pwd() {
		return member_new_pwd;
	}
	public void setMember_new_pwd(String member_new_pwd) {
		this.member_new_pwd = member_new_pwd;
	}
	public String getMember_lang() {
		return member_lang;
	}
	public void setMember_lang(String member_lang) {
		this.member_lang = member_lang;
	}
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String getMember_emp_no() {
		return member_emp_no;
	}
	public void setMember_emp_no(String member_emp_no) {
		this.member_emp_no = member_emp_no;
	}
	public String getDefault_member_emp_no() {
		return default_member_emp_no;
	}
	public void setDefault_member_emp_no(String default_member_emp_no) {
		this.default_member_emp_no = default_member_emp_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getMember_nm_en() {
		return member_nm_en;
	}
	public void setMember_nm_en(String member_nm_en) {
		this.member_nm_en = member_nm_en;
	}
	public String getPhone_no() {
		return phone_no;
	}
	public void setPhone_no(String phone_no) {
		this.phone_no = phone_no;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
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
	public String getArea_cd() {
		return area_cd;
	}
	public void setArea_cd(String area_cd) {
		this.area_cd = area_cd;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getInit_yn() {
		return init_yn;
	}
	public void setInit_yn(String init_yn) {
		this.init_yn = init_yn;
	}
	public String getPwd_chg_date() {
		return pwd_chg_date;
	}
	public void setPwd_chg_date(String pwd_chg_date) {
		this.pwd_chg_date = pwd_chg_date;
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
	public String getPosition_cd() {
		return position_cd;
	}
	public void setPosition_cd(String position_cd) {
		this.position_cd = position_cd;
	}
	public String getPosition_nm() {
		return position_nm;
	}
	public void setPosition_nm(String position_nm) {
		this.position_nm = position_nm;
	}
	public String getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(String start_dt) {
		this.start_dt = start_dt;
	}
	public String getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}
	public Integer getMap_ord() {
		return map_ord;
	}
	public void setMap_ord(Integer map_ord) {
		this.map_ord = map_ord;
	}
	public String getRole_cd() {
		return role_cd;
	}
	public void setRole_cd(String role_cd) {
		this.role_cd = role_cd;
	}
	public String getRole_nm() {
		return role_nm;
	}
	public void setRole_nm(String role_nm) {
		this.role_nm = role_nm;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public String getSidx() {
		return sidx;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public String getSord() {
		return sord;
	}
	public String getVendor_nm() {
		return vendor_nm;
	}
	public void setVendor_nm(String vendor_nm) {
		this.vendor_nm = vendor_nm;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public String getVendor_cd() {
		return vendor_cd;
	}
	public void setVendor_cd(String vendor_cd) {
		this.vendor_cd = vendor_cd;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getJocod() {
		return jocod;
	}
	public void setJocod(String jocod) {
		this.jocod = jocod;
	}
	public String getChn_dept_cd() {
		return chn_dept_cd;
	}
	public void setChn_dept_cd(String chn_dept_cd) {
		this.chn_dept_cd = chn_dept_cd;
	}
}
