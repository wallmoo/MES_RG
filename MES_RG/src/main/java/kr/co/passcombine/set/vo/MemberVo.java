package kr.co.passcombine.set.vo;

public class MemberVo {
	private String member_id;
	private String member_iden_no;
	private String member_nm;
	private String member_pwd;
	private String dept_cd;
	
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_iden_no() {
		return member_iden_no;
	}
	public void setMember_iden_no(String member_iden_no) {
		this.member_iden_no = member_iden_no;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
	
}
