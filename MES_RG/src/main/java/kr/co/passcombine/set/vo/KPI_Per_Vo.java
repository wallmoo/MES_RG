package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class KPI_Per_Vo implements Serializable{


	private String machine_nm = "";
	private String month = "";

	private float per = 0;

	private long today_time = 0;
	private long process_time = 0;
	
	private int cnt =0;

	public String getMachine_nm() {
		return machine_nm;
	}

	public void setMachine_nm(String machine_nm) {
		this.machine_nm = machine_nm;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	
	public float getPer() {
		return per;
	}

	public void setPer(float per) {
		this.per = per;
	}

	public long getToday_time() {
		return today_time;
	}

	public void setToday_time(long today_time) {
		this.today_time = today_time;
	}

	public long getProcess_time() {
		return process_time;
	}

	public void setProcess_time(long process_time) {
		this.process_time = process_time;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
	
	
	
	
}
