package kr.co.passcombine.set.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class SYFileVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
  
  private String file_group;
  private String file_no;
  private String file_repo;
  private String file_cate;
  private String file_path;
  private String file_name;
  private String input_file_name;
  private String file_ext;
  private long file_size;
  private String file_del_yn;
  private String file_thumnail;
  private String date_created;
  private String date_updated;
  private String creator;
  private String updater;
  
  private String file_name_seq;
  private String dept_cd;
  private String matnr;
  private String maktx;
  private String werks;
  private String meins;
  private String params;
  private String file_nm;
  
  private int page;
  private int rows;
	  
  private String sidx;
  private String sord;
  
  
  private String business_code;
  private String business_nm;
  private String file_rev_no;
  private String input_rev_no;
  private String file_class_code;
  private String file_class_nm;
  private String file_class;
  private String file_type_code;
  private String file_type_nm;
  private String file_type;
  private String creator_nm;
  private String del_yn;
  private String file_new_rev_no;
  private String file_new_comment;
  private String file_comment;
  private String file_final_yn;
  
  private String input_date;
  private String input_new_date;
  
  
	
  public String getInput_date() {
	return input_date;
}
public void setInput_date(String input_date) {
	this.input_date = input_date;
}
public String getInput_new_date() {
	return input_new_date;
}
public void setInput_new_date(String input_new_date) {
	this.input_new_date = input_new_date;
}
public String getInput_rev_no() {
	return input_rev_no;
}
public void setInput_rev_no(String input_rev_no) {
	this.input_rev_no = input_rev_no;
}
public String getInput_file_name() {
	return input_file_name;
}
public void setInput_file_name(String input_file_name) {
	this.input_file_name = input_file_name;
}
public String getFile_final_yn() {
	return file_final_yn;
}
public void setFile_final_yn(String file_final_yn) {
	this.file_final_yn = file_final_yn;
}
public String getFile_new_rev_no() {
	return file_new_rev_no;
}
public void setFile_new_rev_no(String file_new_rev_no) {
	this.file_new_rev_no = file_new_rev_no;
}
public String getFile_new_comment() {
	return file_new_comment;
}
public void setFile_new_comment(String file_new_comment) {
	this.file_new_comment = file_new_comment;
}
public String getFile_comment() {
	return file_comment;
}
public void setFile_comment(String file_comment) {
	this.file_comment = file_comment;
}
public String getDel_yn() {
	return del_yn;
}
public void setDel_yn(String del_yn) {
	this.del_yn = del_yn;
}
public String getFile_class() {
	return file_class;
}
public void setFile_class(String file_class) {
	this.file_class = file_class;
}
public String getFile_type() {
	return file_type;
}
public void setFile_type(String file_type) {
	this.file_type = file_type;
}
public String getBusiness_code() {
	return business_code;
}
public void setBusiness_code(String business_code) {
	this.business_code = business_code;
}
public String getBusiness_nm() {
	return business_nm;
}
public void setBusiness_nm(String business_nm) {
	this.business_nm = business_nm;
}
public String getFile_rev_no() {
	return file_rev_no;
}
public void setFile_rev_no(String file_rev_no) {
	this.file_rev_no = file_rev_no;
}
public String getFile_class_code() {
	return file_class_code;
}
public void setFile_class_code(String file_class_code) {
	this.file_class_code = file_class_code;
}
public String getFile_class_nm() {
	return file_class_nm;
}
public void setFile_class_nm(String file_class_nm) {
	this.file_class_nm = file_class_nm;
}
public String getFile_type_code() {
	return file_type_code;
}
public void setFile_type_code(String file_type_code) {
	this.file_type_code = file_type_code;
}
public String getFile_type_nm() {
	return file_type_nm;
}
public void setFile_type_nm(String file_type_nm) {
	this.file_type_nm = file_type_nm;
}
public String getCreator_nm() {
	return creator_nm;
}
public void setCreator_nm(String creator_nm) {
	this.creator_nm = creator_nm;
}
private ArrayList<String> matnrList;
	
	public String getFile_group() {
		return file_group;
	}
	public void setFile_group(String file_group) {
		this.file_group = file_group;
	}
	public String getFile_no() {
		return file_no;
	}
	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}
	public String getFile_repo() {
		return file_repo;
	}
	public void setFile_repo(String file_repo) {
		this.file_repo = file_repo;
	}
	public String getFile_cate() {
		return file_cate;
	}
	public void setFile_cate(String file_cate) {
		this.file_cate = file_cate;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_ext() {
		return file_ext;
	}
	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public String getFile_del_yn() {
		return file_del_yn;
	}
	public void setFile_del_yn(String file_del_yn) {
		this.file_del_yn = file_del_yn;
	}
	public String getFile_thumnail() {
		return file_thumnail;
	}
	public void setFile_thumnail(String file_thumnail) {
		this.file_thumnail = file_thumnail;
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
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
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
	public void setSord(String sord) {
		this.sord = sord;
	}
	public String getFile_name_seq() {
		return file_name_seq;
	}
	public void setFile_name_seq(String file_name_seq) {
		this.file_name_seq = file_name_seq;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getMatnr() {
		return matnr;
	}
	public void setMatnr(String matnr) {
		this.matnr = matnr;
	}
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
	}
	public String getMaktx() {
		return maktx;
	}
	public void setMaktx(String maktx) {
		this.maktx = maktx;
	}
	public String getWerks() {
		return werks;
	}
	public void setWerks(String werks) {
		this.werks = werks;
	}
	public String getMeins() {
		return meins;
	}
	public void setMeins(String meins) {
		this.meins = meins;
	}
	public ArrayList<String> getMatnrList() {
		return matnrList;
	}
	public void setMatnrList(ArrayList<String> matnrList) {
		this.matnrList = matnrList;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
}
