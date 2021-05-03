package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYTBomVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int BOM_IDX;
	private int MTL_IDX;
	private int PJT_IDX;
	private String BOM_MTL_QTY;
	private String BOM_REG_DT;
	private String BOM_REG_ID;
	private String BOM_DEL_YN;
	
	public int getBOM_IDX() {
		return BOM_IDX;
	}
	public void setBOM_IDX(int bOM_IDX) {
		this.BOM_IDX = bOM_IDX;
	}
	public int getMTL_IDX() {
		return MTL_IDX;
	}
	public void setMTL_IDX(int mTL_IDX) {
		this.MTL_IDX = mTL_IDX;
	}
	public int getPJT_IDX() {
		return PJT_IDX;
	}
	public void setPJT_IDX(int pJT_IDX) {
		this.PJT_IDX = pJT_IDX;
	}
	public String getBOM_MTL_QTY() {
		return BOM_MTL_QTY;
	}
	public void setBOM_MTL_QTY(String bOM_MTL_QTY) {
		this.BOM_MTL_QTY = bOM_MTL_QTY;
	}
	public String getBOM_REG_DT() {
		return BOM_REG_DT;
	}
	public void setBOM_REG_DT(String bOM_REG_DT) {
		this.BOM_REG_DT = bOM_REG_DT;
	}
	public String getBOM_REG_ID() {
		return BOM_REG_ID;
	}
	public void setBOM_REG_ID(String bOM_REG_ID) {
		this.BOM_REG_ID = bOM_REG_ID;
	}
	public String getBOM_DEL_YN() {
		return BOM_DEL_YN;
	}
	public void setBOM_DEL_YN(String bOM_DEL_YN) {
		this.BOM_DEL_YN = bOM_DEL_YN;
	}
	
}