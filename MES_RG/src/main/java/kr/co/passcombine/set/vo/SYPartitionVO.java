package kr.co.passcombine.set.vo;

public class SYPartitionVO {
	

	// partition list view fields
	private String item_code;
	private String item_nm;
	private String item_spec;
	// partition list view fields
	
	
	private String raw_item_code; 
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
	public String getItem_spec() {
		return item_spec;
	}
	public void setItem_spec(String item_spec) {
		this.item_spec = item_spec;
	}
	
	
	private String partition_code;
	private String raw_item_nm;
	private String raw_item_spec;
	private String partition_rate;
	private String del_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	public String getRaw_item_code() {
		return raw_item_code;
	}
	public void setRaw_item_code(String raw_item_code) {
		this.raw_item_code = raw_item_code;
	}
	public String getPartition_code() {
		return partition_code;
	}
	public void setPartition_code(String partition_code) {
		this.partition_code = partition_code;
	}
	public String getRaw_item_nm() {
		return raw_item_nm;
	}
	public void setRaw_item_nm(String raw_item_nm) {
		this.raw_item_nm = raw_item_nm;
	}
	public String getRaw_item_spec() {
		return raw_item_spec;
	}
	public void setRaw_item_spec(String raw_item_spec) {
		this.raw_item_spec = raw_item_spec;
	}
	public String getPartition_rate() {
		return partition_rate;
	}
	public void setPartition_rate(String partition_rate) {
		this.partition_rate = partition_rate;
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

	

}
