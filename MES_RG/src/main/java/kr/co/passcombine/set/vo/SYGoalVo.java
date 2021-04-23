package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYGoalVo implements Serializable{
	
  private static final long serialVersionUID = 1L;
	
  private String code;
  private String name;
  private String year;
  private String month;
  private String goal;
  private  String creator;
  private String updater;
  private String date_created;
  private String date_updated;
  private String master_code;
  
  
  
	public String getMaster_code() {
	return master_code;
}
public void setMaster_code(String master_code) {
	this.master_code = master_code;
}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
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
