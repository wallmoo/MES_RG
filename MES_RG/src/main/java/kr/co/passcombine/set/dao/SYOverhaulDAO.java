package kr.co.passcombine.set.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYRepairAnalysisVo;
import kr.co.passcombine.set.vo.SYRepairVo;

@Repository(value = "setOverhaulDAO")
public interface SYOverhaulDAO {
	
	public List<SYRepairVo> selectrepairReqT(SYRepairVo vo);
	public int selectrepairReqTcnt(String str);
	public List<SYCustomerVo> findinout(SYCustomerVo vo);
	public int insRepair(SYRepairVo vo);
	public int modRepair(SYRepairVo vo);
	public int delRepair(SYRepairVo vo);
	public List<SYMaterialVo> getItemnm(SYMaterialVo vo);
	
	
	
	public List<SYRepairAnalysisVo> selectRepairAnalysis(SYRepairAnalysisVo vo);
	public List<SYRepairVo> selectrepairReqR(SYRepairVo vo);
	
	public List<SYRepairVo> selectrepairOther(SYRepairVo vo);
	
	public int updateRepairOrder(SYRepairVo vo);
	
	public List<SYRepairVo> selectrepairUsingDay(SYRepairVo vo);
	
	public List<SYRepairVo> selectrepairItem(SYRepairVo vo);
	
	
	
	
	
	
	
	
	
	
	
	
	
	// jyp
	public int insRepairReportFile(SYRepairVo vo);
	public int delRepairReportFile(SYRepairVo vo);
	
	
	public int updateOutDate(SYRepairVo vo);
	public int cancelCompleteReport(SYRepairVo vo);
	
	
	//210204
	public int updateReportDate(SYRepairVo vo);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
