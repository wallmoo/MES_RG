package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYClaimVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYIncome_resultVo;
import kr.co.passcombine.set.vo.SYInspVO;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYPrintVO;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYQualityFileVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;

@Repository(value = "setInspDAO")
public interface SYInspDAO {

	List<SYProductVO> selcInspMain(SYProductVO vo);

	List<SYInspVO> selcInspChkSht(SYInspVO vo);

	List<SYInspVO> selcInspVal(SYInspVO vo);

	int saveInspVal(SYInspVO syInspVO);

	int saveChkSht(SYInspVO syInspVO);

	int delInspVal(SYInspVO syInspVO);

	int updtChkShtDfctCnt(SYInspVO syInspVO);

	int fnshChkShtData(SYInspVO vo);

	List<SYInspVO> selcInspNgCnt(SYInspVO vo);

	List<SYInspVO> selcInspRstVal(SYInspVO vo);

	int chkInspVal(SYInspVO pVo);

	int updateProdOprtSrtInfo(SYInspVO syInspVO);

	int chkInspEnd(SYInspVO vo);

	int updateProdOprtEndInfo(SYInspVO vo);

	int updateProdSrtInfo(SYInspVO syInspVO);

	int updateProdEndInfo(SYInspVO vo);

	List<SYProductVO> selcInspMain_final(SYProductVO vo);

	List<SYProductVO> selcInspMain_his(SYProductVO vo);

	List<SYProductVO> selcInspMain_final_his(SYProductVO vo);

	int nextInspInfoCreate(SYInspVO vo);

	int nextInspNum(SYInspVO vo);

	List<SYInspVO> nextRtngInfo(SYInspVO vo);

	List<SYInspVO> nextInspInfo(SYInspVO vo);

	List<SYInspVO> nowInspNgInfo(SYInspVO vo);

	int instWarehousingInfo(SYInspVO vo);

	int instWarehouseInfo(SYInspVO vo);

	int selecWarehouseInfo(SYInspVO vo);

	int selcProdEndInfo(SYInspVO vo);

	List<SYMaterialVo> qLoadItemCode(SYMaterialVo vo);

	List<SYInspVO> getRtngInfo(SYInspVO vo);

	List<SYInspVO> getQAnalData_1(SYInspVO vo);

	List<SYInspVO> getQAnalData_2(SYInspVO vo);

	List<SYQualityFileVo> getPnImg(SYQualityFileVo vo);

	List<SYInspVO> getInspInfo(SYInspVO vo);

	List<SYInspVO> dfctKpiGraph(SYInspVO vo);

	List<SYInspVO> dfctKpiLtGrid(SYInspVO vo);

	List<SYInspVO> dfctKpiRtGrid(SYInspVO vo);

	int saveFirstChkSht(SYInspVO vo);

	List<SYInspVO> rtngInspInfo(SYInspVO vo);

	List<SYInspVO> chkSheetData(SYInspVO vo);

	List<SYInspVO> inspValData(SYInspVO vo);

	int saveFirstInspVal(SYInspVO vo);

	int updtChkSht(SYInspVO syInspVO);

	int fnshInspData(SYInspVO vo);

	int chkInspIng(SYInspVO vo);

	List<SYInspVO> selcSuipInspVal(SYInspVO vo);

	int saveFirstSuipChkSht(SYInspVO vo);

	int saveFirstSuipInspVal(SYInspVO vo);

	int saveOrdInspInfo(SYInspVO list);

	String getOrdCntInfo(SYInspVO syInspVO);

	int fnshSuipInspData(SYInspVO vo);

	int updateInspRst(SYInspVO nVo);

	int chkInspIptCnt(SYInspVO vo);
	
	public List<SYIncome_resultVo> selectIncome_result_s(SYIncome_resultVo vo);
	public List<SYIncome_resultVo> selectIncome_result2_s(SYIncome_resultVo vo);
	public List<SYIncome_resultVo> selectIncome_result3_s(SYIncome_resultVo vo);

	int chkProdStrt(SYInspVO vo);

	int strtInspData(SYInspVO vo);

	int updateProdOprtSrtInfoBtn(SYInspVO vo);

	List<SYInspVO> selectDfctGrph(SYInspVO vo);

	List<SYInspVO> selectDfctGrphLt(SYInspVO vo);

	List<SYInspVO> selectDfctGrphRt(SYInspVO vo);

	int chkSuipInspIptCnt(SYInspVO vo);

	int updateInspMstInfo(SYInspVO vo);

	List<SYPrintVO> selectPrtInfo(SYPrintVO vo);

	List<SYInspVO> selectDfctGrphMd(SYInspVO vo);

	List<SYInspVO> selcSuipInspChkSht(SYInspVO vo);

	List<SYInspVO> selcSuipInspRstVal(SYInspVO vo);

	int initProdSrtInfo(SYInspVO vo);

	int initProdOprtSrtInfoBtn(SYInspVO vo);

	int initInspValInfo(SYInspVO vo);

	int initInspChkInfo(SYInspVO vo);

	List<SYInspVO> export_fnsh_insp(SYInspVO vo);

	List<SYInspVO> selcSuipInspOrd(SYInspVO vo);

	int confirmSuipInsp(SYInspVO vo);

	String selectInspOrderNum();

	int savePrcInsp(SYInspVO vo);

	int suipStrtRtngChk(SYInspVO vo);

	String getSuipMengeInfo(SYInspVO vo);

}
