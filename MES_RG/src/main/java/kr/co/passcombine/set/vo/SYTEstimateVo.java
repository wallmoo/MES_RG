package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYTEstimateVo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int EST_IDX;
	private int PJT_IDX;
	private int MTL_IDX;
	private int VDR_IDX;
	private int MTL_REQ_IDX;
	private int CST_IDX;
	private String MTL_REQ_QTY;
	private String MTL_EST_MOQ;
	private String MTL_EST_PRICE;
	private String MTL_EST_DLV_DT;
	private String MTL_EST_BG;
	private String MTL_EST_REG_DT;
	private String MTL_EST_RE_DT;
	private String MTL_EST_REG_ID;
	private String MTL_EST_DEL_YN;
	
	//추가 VO
	private String VDR_NM;
	private String PJT_NM;
	private String MTL_NM;
	private String MTL_MKR_NO;
	private String MTL_STD;
	private String MTL_MKR_CD;
	private String MTL_UNT;
	private String MTL_TOT_PRICE;
	
	
	public int getEST_IDX() {
		return EST_IDX;
	}
	public void setEST_IDX(int eST_IDX) {
		this.EST_IDX = eST_IDX;
	}
	public int getPJT_IDX() {
		return PJT_IDX;
	}
	public void setPJT_IDX(int pJT_IDX) {
		this.PJT_IDX = pJT_IDX;
	}
	public int getMTL_IDX() {
		return MTL_IDX;
	}
	public void setMTL_IDX(int mTL_IDX) {
		this.MTL_IDX = mTL_IDX;
	}
	public int getVDR_IDX() {
		return VDR_IDX;
	}
	public void setVDR_IDX(int vDR_IDX) {
		this.VDR_IDX = vDR_IDX;
	}
	public int getMTL_REQ_IDX() {
		return MTL_REQ_IDX;
	}
	public void setMTL_REQ_IDX(int mTL_REQ_IDX) {
		MTL_REQ_IDX = mTL_REQ_IDX;
	}
	public String getMTL_REQ_QTY() {
		return MTL_REQ_QTY;
	}
	public void setMTL_REQ_QTY(String mTL_REQ_QTY) {
		this.MTL_REQ_QTY = mTL_REQ_QTY;
	}
	public String getMTL_EST_MOQ() {
		return MTL_EST_MOQ;
	}
	public void setMTL_EST_MOQ(String mTL_EST_MOQ) {
		this.MTL_EST_MOQ = mTL_EST_MOQ;
	}
	public String getMTL_EST_PRICE() {
		return MTL_EST_PRICE;
	}
	public void setMTL_EST_PRICE(String mTL_EST_PRICE) {
		this.MTL_EST_PRICE = mTL_EST_PRICE;
	}
	public String getMTL_EST_DLV_DT() {
		return MTL_EST_DLV_DT;
	}
	public void setMTL_EST_DLV_DT(String mTL_EST_DLV_DT) {
		this.MTL_EST_DLV_DT = mTL_EST_DLV_DT;
	}
	public String getMTL_EST_BG() {
		return MTL_EST_BG;
	}
	public void setMTL_EST_BG(String mTL_EST_BG) {
		this.MTL_EST_BG = mTL_EST_BG;
	}
	public String getMTL_EST_REG_DT() {
		return MTL_EST_REG_DT;
	}
	public void setMTL_EST_REG_DT(String mTL_EST_REG_DT) {
		this.MTL_EST_REG_DT = mTL_EST_REG_DT;
	}
	public String getMTL_EST_RE_DT() {
		return MTL_EST_RE_DT;
	}
	public void setMTL_EST_RE_DT(String mTL_EST_RE_DT) {
		this.MTL_EST_RE_DT = mTL_EST_RE_DT;
	}
	public String getMTL_EST_REG_ID() {
		return MTL_EST_REG_ID;
	}
	public void setMTL_EST_REG_ID(String mTL_EST_REG_ID) {
		this.MTL_EST_REG_ID = mTL_EST_REG_ID;
	}
	public String getMTL_EST_DEL_YN() {
		return MTL_EST_DEL_YN;
	}
	public void setMTL_EST_DEL_YN(String mTL_EST_DEL_YN) {
		this.MTL_EST_DEL_YN = mTL_EST_DEL_YN;
	}
	public String getVDR_NM() {
		return VDR_NM;
	}
	public void setVDR_NM(String vDR_NM) {
		this.VDR_NM = vDR_NM;
	}
	public String getPJT_NM() {
		return PJT_NM;
	}
	public void setPJT_NM(String pJT_NM) {
		this.PJT_NM = pJT_NM;
	}
	public String getMTL_NM() {
		return MTL_NM;
	}
	public void setMTL_NM(String mTL_NM) {
		this.MTL_NM = mTL_NM;
	}
	public String getMTL_MKR_NO() {
		return MTL_MKR_NO;
	}
	public void setMTL_MKR_NO(String mTL_MKR_NO) {
		this.MTL_MKR_NO = mTL_MKR_NO;
	}
	public String getMTL_STD() {
		return MTL_STD;
	}
	public void setMTL_STD(String mTL_STD) {
		this.MTL_STD = mTL_STD;
	}
	public String getMTL_MKR_CD() {
		return MTL_MKR_CD;
	}
	public void setMTL_MKR_CD(String mTL_MKR_CD) {
		this.MTL_MKR_CD = mTL_MKR_CD;
	}
	public String getMTL_UNT() {
		return MTL_UNT;
	}
	public void setMTL_UNT(String mTL_UNT) {
		this.MTL_UNT = mTL_UNT;
	}
	public String getMTL_TOT_PRICE() {
		return MTL_TOT_PRICE;
	}
	public void setMTL_TOT_PRICE(String mTL_TOT_PRICE) {
		this.MTL_TOT_PRICE = mTL_TOT_PRICE;
	}
	public int getCST_IDX() {
		return CST_IDX;
	}
	public void setCST_IDX(int cST_IDX) {
		CST_IDX = cST_IDX;
	}
	
}
