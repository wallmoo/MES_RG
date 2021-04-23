package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYDrwFileInfoVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private String business_code;
	private String business_nm;
	private String item_code;
	private String item_nm;
	
	private String drw_no;
	private String drw_nm;
	private String file_group;
	private String file_no;
	
	private String file_rev_no;
	
	private String file_repo;
	private String file_cate;
	
	private String cad_file_path;
	private String cad_file_name;
	private String cad_file_ext;
	private long cad_file_size;
	
	private String pdf_file_path;
	private String pdf_file_name;
	private String pdf_file_ext;
	private long pdf_file_size;

	
	private String file_final_yn;
	private String file_del_yn;
	
	private String file_comment;
	
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	
	private String file_new_rev_no;
	private String file_new_comment;
	
	private String file_type;
	
	private String typeString;
	
	public String getTypeString() {
		return typeString;
	}
	public void setTypeString(String typeString) {
		this.typeString = typeString;
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
	public String getDrw_no() {
		return drw_no;
	}
	public void setDrw_no(String drw_no) {
		this.drw_no = drw_no;
	}
	public String getDrw_nm() {
		return drw_nm;
	}
	public void setDrw_nm(String drw_nm) {
		this.drw_nm = drw_nm;
	}
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
	public String getFile_rev_no() {
		return file_rev_no;
	}
	public void setFile_rev_no(String file_rev_no) {
		this.file_rev_no = file_rev_no;
	}
	public String getFile_cate() {
		return file_cate;
	}
	public void setFile_cate(String file_cate) {
		this.file_cate = file_cate;
	}
	public String getCad_file_path() {
		return cad_file_path;
	}
	public void setCad_file_path(String cad_file_path) {
		this.cad_file_path = cad_file_path;
	}
	public String getCad_file_name() {
		return cad_file_name;
	}
	public void setCad_file_name(String cad_file_name) {
		this.cad_file_name = cad_file_name;
	}
	public String getCad_file_ext() {
		return cad_file_ext;
	}
	public void setCad_file_ext(String cad_file_ext) {
		this.cad_file_ext = cad_file_ext;
	}
	public long getCad_file_size() {
		return cad_file_size;
	}
	public void setCad_file_size(long cad_file_size) {
		this.cad_file_size = cad_file_size;
	}
	public String getPdf_file_path() {
		return pdf_file_path;
	}
	public void setPdf_file_path(String pdf_file_path) {
		this.pdf_file_path = pdf_file_path;
	}
	public String getPdf_file_name() {
		return pdf_file_name;
	}
	public void setPdf_file_name(String pdf_file_name) {
		this.pdf_file_name = pdf_file_name;
	}
	public String getPdf_file_ext() {
		return pdf_file_ext;
	}
	public void setPdf_file_ext(String pdf_file_ext) {
		this.pdf_file_ext = pdf_file_ext;
	}
	public long getPdf_file_size() {
		return pdf_file_size;
	}
	public void setPdf_file_size(long pdf_file_size) {
		this.pdf_file_size = pdf_file_size;
	}
	public String getFile_final_yn() {
		return file_final_yn;
	}
	public void setFile_final_yn(String file_final_yn) {
		this.file_final_yn = file_final_yn;
	}
	public String getFile_del_yn() {
		return file_del_yn;
	}
	public void setFile_del_yn(String file_del_yn) {
		this.file_del_yn = file_del_yn;
	}
	public String getFile_comment() {
		return file_comment;
	}
	public void setFile_comment(String file_comment) {
		this.file_comment = file_comment;
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
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}

	
}
