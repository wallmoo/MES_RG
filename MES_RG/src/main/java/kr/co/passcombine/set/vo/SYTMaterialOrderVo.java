package kr.co.passcombine.set.vo;

import java.io.Serializable;

public class SYTMaterialOrderVo implements Serializable{

	private static final long serialVersionUID = 1L;

	private int ORD_IDX;
	private int PJT_IDX;
	private int VDR_IDX;
	private int MTL_ORD_DTL_IDX;
	private int MTL_IDX;
	private String MTL_ORD_TYPE;
	private String MTL_ORD_PLC;
	private String MTL_ORD_DLV_DT;
	private String MTL_ORD_FLE1;
	private String MTL_ORD_FLE2;
	private String MTL_ORD_FLE3;
	private String MTL_ORD_STATUS;
	private String MTL_ORD_REG_DT;
	private String MTL_ORD_REG_ID;
	private String MTL_ORD_DEL_YN;
	private String ORD_DTL_PRICE;
	private String ORD_DTL_QTY;
	private String PJT_NM;
	private String MTL_NM;
	private String VDR_NM;
	private String ORD_DTL_STATUS;
	private String MTL_MKR_CD;
	private String MTL_MKR_NO;
	private String MTL_UNT;
	private String MTL_STD;
	private String ORD_CHK_STATUS;
	private String MTL_QTY;
	private String CALCUL_DLV_DT;
	
	
	public String getCALCUL_DLV_DT() {
		return CALCUL_DLV_DT;
	}
	public void setCALCUL_DLV_DT(String cALCUL_DLV_DT) {
		CALCUL_DLV_DT = cALCUL_DLV_DT;
	}
	public int getORD_IDX() {
		return ORD_IDX;
	}
	public void setORD_IDX(int oRD_IDX) {
		this.ORD_IDX = oRD_IDX;
	}
	public int getPJT_IDX() {
		return PJT_IDX;
	}
	public void setPJT_IDX(int pJT_IDX) {
		this.PJT_IDX = pJT_IDX;
	}
	public int getVDR_IDX() {
		return VDR_IDX;
	}
	public void setVDR_IDX(int vDR_IDX) {
		this.VDR_IDX = vDR_IDX;
	}
	public int getMTL_ORD_DTL_IDX() {
		return MTL_ORD_DTL_IDX;
	}
	public void setMTL_ORD_DTL_IDX(int mTL_ORD_DTL_IDX) {
		this.MTL_ORD_DTL_IDX = mTL_ORD_DTL_IDX;
	}
	public int getMTL_IDX() {
		return MTL_IDX;
	}
	public void setMTL_IDX(int mTL_IDX) {
		this.MTL_IDX = mTL_IDX;
	}
	public String getMTL_ORD_TYPE() {
		return MTL_ORD_TYPE;
	}
	public void setMTL_ORD_TYPE(String mTL_ORD_TYPE) {
		this.MTL_ORD_TYPE = mTL_ORD_TYPE;
	}
	public String getMTL_ORD_PLC() {
		return MTL_ORD_PLC;
	}
	public void setMTL_ORD_PLC(String mTL_ORD_PLC) {
		this.MTL_ORD_PLC = mTL_ORD_PLC;
	}
	public String getMTL_ORD_DLV_DT() {
		return MTL_ORD_DLV_DT;
	}
	public void setMTL_ORD_DLV_DT(String mTL_ORD_DLV_DT) {
		MTL_ORD_DLV_DT = mTL_ORD_DLV_DT;
	}
	public String getMTL_ORD_FLE1() {
		return MTL_ORD_FLE1;
	}
	public void setMTL_ORD_FLE1(String mTL_ORD_FLE1) {
		this.MTL_ORD_FLE1 = mTL_ORD_FLE1;
	}
	public String getMTL_ORD_FLE2() {
		return MTL_ORD_FLE2;
	}
	public void setMTL_ORD_FLE2(String mTL_ORD_FLE2) {
		this.MTL_ORD_FLE2 = mTL_ORD_FLE2;
	}
	public String getMTL_ORD_FLE3() {
		return MTL_ORD_FLE3;
	}
	public void setMTL_ORD_FLE3(String mTL_ORD_FLE3) {
		this.MTL_ORD_FLE3 = mTL_ORD_FLE3;
	}
	public String getMTL_ORD_STATUS() {
		return MTL_ORD_STATUS;
	}
	public void setMTL_ORD_STATUS(String MTL_ORD_STATUS) {
		this.MTL_ORD_STATUS = MTL_ORD_STATUS;
	}
	public String getMTL_ORD_REG_DT() {
		return MTL_ORD_REG_DT;
	}
	public void setMTL_ORD_REG_DT(String mTL_ORD_REG_DT) {
		this.MTL_ORD_REG_DT = mTL_ORD_REG_DT;
	}
	public String getMTL_ORD_REG_ID() {
		return MTL_ORD_REG_ID;
	}
	public void setMTL_ORD_REG_ID(String mTL_ORD_REG_ID) {
		this.MTL_ORD_REG_ID = mTL_ORD_REG_ID;
	}
	public String getMTL_ORD_DEL_YN() {
		return MTL_ORD_DEL_YN;
	}
	public String getPJT_NM() {
		return PJT_NM;
	}
	public void setPJT_NM(String pJT_NM) {
		PJT_NM = pJT_NM;
	}
	public void setMTL_ORD_DEL_YN(String mTL_ORD_DEL_YN) {
		this.MTL_ORD_DEL_YN = mTL_ORD_DEL_YN;
	}
	public String getORD_DTL_PRICE() {
		return ORD_DTL_PRICE;
	}
	public void setORD_DTL_PRICE(String oRD_DTL_PRICE) {
		this.ORD_DTL_PRICE = oRD_DTL_PRICE;
	}
	public String getORD_DTL_QTY() {
		return ORD_DTL_QTY;
	}
	public void setORD_DTL_QTY(String oRD_DTL_QTY) {
		this.ORD_DTL_QTY = oRD_DTL_QTY;
	}
	public String getMTL_NM() {
		return MTL_NM;
	}
	public void setMTL_NM(String mTL_NM) {
		MTL_NM = mTL_NM;
	}
	public String getVDR_NM() {
		return VDR_NM;
	}
	public void setVDR_NM(String vDR_NM) {
		VDR_NM = vDR_NM;
	}
	public String getORD_DTL_STATUS() {
		return ORD_DTL_STATUS;
	}
	public void setORD_DTL_STATUS(String oRD_DTL_STATUS) {
		ORD_DTL_STATUS = oRD_DTL_STATUS;
	}
	public String getMTL_MKR_CD() {
		return MTL_MKR_CD;
	}
	public void setMTL_MKR_CD(String mTL_MKR_CD) {
		MTL_MKR_CD = mTL_MKR_CD;
	}
	public String getMTL_MKR_NO() {
		return MTL_MKR_NO;
	}
	public void setMTL_MKR_NO(String mTL_MKR_NO) {
		MTL_MKR_NO = mTL_MKR_NO;
	}
	public String getMTL_UNT() {
		return MTL_UNT;
	}
	public void setMTL_UNT(String mTL_UNT) {
		MTL_UNT = mTL_UNT;
	}
	public String getMTL_STD() {
		return MTL_STD;
	}
	public void setMTL_STD(String mTL_STD) {
		MTL_STD = mTL_STD;
	}
	public String getORD_CHK_STATUS() {
		return ORD_CHK_STATUS;
	}
	public void setORD_CHK_STATUS(String oRD_CHK_STATUS) {
		ORD_CHK_STATUS = oRD_CHK_STATUS;
	}
	public String getMTL_QTY() {
		return MTL_QTY;
	}
	public void setMTL_QTY(String mTL_QTY) {
		MTL_QTY = mTL_QTY;
	}
	

}
