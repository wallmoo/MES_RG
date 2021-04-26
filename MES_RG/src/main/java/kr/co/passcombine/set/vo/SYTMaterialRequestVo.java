package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYTMaterialRequestVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private int MTL_REQ_MST;
	private int BOM_IDX;
	private int MTL_IDX;
	private int PJT_IDX;
	private String MTL_REQ_TYPE;
	private String MTL_REQ_QTY;
	private String MTL_DLV_QTY;
	private String MTL_REQ_STATE;
	private String MTL_REQ_REG_DT;
	private String MTL_REQ_REG_ID;	
	private String MTL_REQ_DEL_YN;
	
	public int getMTL_REQ_MST() {
		return MTL_REQ_MST;
	}
	public void setMTL_REQ_MST(int mTL_REQ_MST) {
		this.MTL_REQ_MST = mTL_REQ_MST;
	}
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
	public String getMTL_REQ_TYPE() {
		return MTL_REQ_TYPE;
	}
	public void setMTL_REQ_TYPE(String mTL_REQ_TYPE) {
		this.MTL_REQ_TYPE = mTL_REQ_TYPE;
	}
	public String getMTL_REQ_QTY() {
		return MTL_REQ_QTY;
	}
	public void setMTL_REQ_QTY(String mTL_REQ_QTY) {
		this.MTL_REQ_QTY = mTL_REQ_QTY;
	}
	public String getMTL_DLV_QTY() {
		return MTL_DLV_QTY;
	}
	public void setMTL_DLV_QTY(String mTL_DLV_QTY) {
		this.MTL_DLV_QTY = mTL_DLV_QTY;
	}
	public String getMTL_REQ_STATE() {
		return MTL_REQ_STATE;
	}
	public void setMTL_REQ_STATE(String mTL_REQ_STATE) {
		this.MTL_REQ_STATE = mTL_REQ_STATE;
	}
	public String getMTL_REQ_REG_DT() {
		return MTL_REQ_REG_DT;
	}
	public void setMTL_REQ_REG_DT(String mTL_REQ_REG_DT) {
		this.MTL_REQ_REG_DT = mTL_REQ_REG_DT;
	}
	public String getMTL_REQ_REG_ID() {
		return MTL_REQ_REG_ID;
	}
	public void setMTL_REQ_REQ_ID(String mTL_REQ_REQ_ID) {
		this.MTL_REQ_REG_ID = mTL_REQ_REQ_ID;
	}
	public String getMTL_REQ_DEL_YN() {
		return MTL_REQ_DEL_YN;
	}
	public void setMTL_REQ_DEL_YN(String mTL_REQ_DEL_YN) {
		this.MTL_REQ_DEL_YN = mTL_REQ_DEL_YN;
	}

}
