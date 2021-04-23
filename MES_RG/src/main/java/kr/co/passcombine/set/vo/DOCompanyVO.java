package kr.co.passcombine.set.vo;

import java.io.Serializable;

/**
* <pre>
* 1. VOName : Company Master
* 2. ClassName : DOCompanyVO.java
* 3. Comment : 고객사, 거래처, 지사정보 관리
* 4. 작성자 : DEV_KIMDEUKYONG
* 5. 작성일 : 2021. 04. 22.
* </pre>
*
* @param request
* @param commandMap
* @return
* @throws Exception
*/
public class DOCompanyVO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int CST_IDX;//고객사
	
	private int VDR_IDX;//거래처

	private int BCO_IDX;//지점 정보
	private String BCO_HD_YN;//본사, 지점 여부체크(현재 사용안함)
	
	private int CPN_INF_IDX;	
	private String CPN_NM;
	private String CPN_CEO_NM;
	private String CPN_PLC;
	private String CPN_NO;
	private String CPN_ADD;
	private String CPN_TEL;
	private String CPN_FAX;
	private String CPN_ML1;
	private String CPN_ML2;
	private String CPN_ML3;
	private String CPN_HP;
	private String CTM_REG_DT;
	private String CTM_REG_ID;
	private String CPN_STATE;
	
	/**
	 * @return the vDR_IDX
	 */
	public int getVDR_IDX() {
		return VDR_IDX;
	}
	/**
	 * @param vDR_IDX the vDR_IDX to set
	 */
	public void setVDR_IDX(int vDR_IDX) {
		this.VDR_IDX = vDR_IDX;
	}
	/**
	 * @return the cPN_INF_IDX
	 */
	public int getCPN_INF_IDX() {
		return CPN_INF_IDX;
	}
	/**
	 * @param cPN_INF_IDX the cPN_INF_IDX to set
	 */
	public void setCPN_INF_IDX(int cPN_INF_IDX) {
		this.CPN_INF_IDX = cPN_INF_IDX;
	}
	/**
	 * @return the vDR_STATE
	 */
	public String getVDR_STATE() {
		return CPN_STATE;
	}
	/**
	 * @param vDR_STATE the vDR_STATE to set
	 */
	public void setVDR_STATE(String vDR_STATE) {
		this.CPN_STATE = vDR_STATE;
	}
	/**
	 * @return the cPN_NM
	 */
	public String getCPN_NM() {
		return CPN_NM;
	}
	/**
	 * @param cPN_NM the cPN_NM to set
	 */
	public void setCPN_NM(String cPN_NM) {
		this.CPN_NM = cPN_NM;
	}
	/**
	 * @return the cPN_CEO_NM
	 */
	public String getCPN_CEO_NM() {
		return CPN_CEO_NM;
	}
	/**
	 * @param cPN_CEO_NM the cPN_CEO_NM to set
	 */
	public void setCPN_CEO_NM(String cPN_CEO_NM) {
		this.CPN_CEO_NM = cPN_CEO_NM;
	}
	/**
	 * @return the cPN_PLC
	 */
	public String getCPN_PLC() {
		return CPN_PLC;
	}
	/**
	 * @param cPN_PLC the cPN_PLC to set
	 */
	public void setCPN_PLC(String cPN_PLC) {
		this.CPN_PLC = cPN_PLC;
	}
	/**
	 * @return the cPN_NO
	 */
	public String getCPN_NO() {
		return CPN_NO;
	}
	/**
	 * @param cPN_NO the cPN_NO to set
	 */
	public void setCPN_NO(String cPN_NO) {
		this.CPN_NO = cPN_NO;
	}
	/**
	 * @return the cPN_ADD
	 */
	public String getCPN_ADD() {
		return CPN_ADD;
	}
	/**
	 * @param cPN_ADD the cPN_ADD to set
	 */
	public void setCPN_ADD(String cPN_ADD) {
		this.CPN_ADD = cPN_ADD;
	}
	/**
	 * @return the cPN_TEL
	 */
	public String getCPN_TEL() {
		return CPN_TEL;
	}
	/**
	 * @param cPN_TEL the cPN_TEL to set
	 */
	public void setCPN_TEL(String cPN_TEL) {
		this.CPN_TEL = cPN_TEL;
	}
	/**
	 * @return the cPN_FAX
	 */
	public String getCPN_FAX() {
		return CPN_FAX;
	}
	/**
	 * @param cPN_FAX the cPN_FAX to set
	 */
	public void setCPN_FAX(String cPN_FAX) {
		this.CPN_FAX = cPN_FAX;
	}
	/**
	 * @return the cPN_ML1
	 */
	public String getCPN_ML1() {
		return CPN_ML1;
	}
	/**
	 * @param cPN_ML1 the cPN_ML1 to set
	 */
	public void setCPN_ML1(String cPN_ML1) {
		this.CPN_ML1 = cPN_ML1;
	}
	/**
	 * @return the cPN_ML2
	 */
	public String getCPN_ML2() {
		return CPN_ML2;
	}
	/**
	 * @param cPN_ML2 the cPN_ML2 to set
	 */
	public void setCPN_ML2(String cPN_ML2) {
		this.CPN_ML2 = cPN_ML2;
	}
	/**
	 * @return the cPN_ML3
	 */
	public String getCPN_ML3() {
		return CPN_ML3;
	}
	/**
	 * @param cPN_ML3 the cPN_ML3 to set
	 */
	public void setCPN_ML3(String cPN_ML3) {
		this.CPN_ML3 = cPN_ML3;
	}
	/**
	 * @return the cPN_HP
	 */
	public String getCPN_HP() {
		return CPN_HP;
	}
	/**
	 * @param cPN_HP the cPN_HP to set
	 */
	public void setCPN_HP(String cPN_HP) {
		this.CPN_HP = cPN_HP;
	}
	/**
	 * @return the cTM_REG_DT
	 */
	public String getCTM_REG_DT() {
		return CTM_REG_DT;
	}
	/**
	 * @param cTM_REG_DT the cTM_REG_DT to set
	 */
	public void setCTM_REG_DT(String cTM_REG_DT) {
		this.CTM_REG_DT = cTM_REG_DT;
	}
	/**
	 * @return the cTM_REG_ID
	 */
	public String getCTM_REG_ID() {
		return CTM_REG_ID;
	}
	/**
	 * @param cTM_REG_ID the cTM_REG_ID to set
	 */
	public void setCTM_REG_ID(String cTM_REG_ID) {
		this.CTM_REG_ID = cTM_REG_ID;
	}
	/**
	 * @return the cST_IDX
	 */
	public int getCST_IDX() {
		return CST_IDX;
	}
	/**
	 * @param cST_IDX the cST_IDX to set
	 */
	public void setCST_IDX(int cST_IDX) {
		this.CST_IDX = cST_IDX;
	}
	/**
	 * @return the bCO_IDX
	 */
	public int getBCO_IDX() {
		return BCO_IDX;
	}
	/**
	 * @param bCO_IDX the bCO_IDX to set
	 */
	public void setBCO_IDX(int bCO_IDX) {
		this.BCO_IDX = bCO_IDX;
	}
	/**
	 * @return the bCO_HD_YN
	 */
	public String getBCO_HD_YN() {
		return BCO_HD_YN;
	}
	/**
	 * @param bCO_HD_YN the bCO_HD_YN to set
	 */
	public void setBCO_HD_YN(String bCO_HD_YN) {
		this.BCO_HD_YN = bCO_HD_YN;
	}
}