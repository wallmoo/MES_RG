package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;


//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.dao.SYOverhaulDAO;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYRepairAnalysisVo;
import kr.co.passcombine.set.vo.SYRepairVo;


@Service(value = "setOverhaulService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYOverhaulService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setOverhaulDAO")
	private SYOverhaulDAO overhaulDAO;

	// Overhaul
	
	public List<SYRepairVo> selectrepairReqT(SYRepairVo vo){
		return overhaulDAO.selectrepairReqT(vo);
	}
	public int selectrepairReqTcnt(String str){
		return overhaulDAO.selectrepairReqTcnt(str);
	}
	public List<SYCustomerVo> findinout(SYCustomerVo vo){
		return overhaulDAO.findinout(vo);
	}
	public int updateOutDate(SYRepairVo vo){
		return overhaulDAO.updateOutDate(vo);
	}
	public int cancelCompleteReport(SYRepairVo vo){
		return overhaulDAO.cancelCompleteReport(vo);
	}
	public int insRepair(SYRepairVo vo){
		return overhaulDAO.insRepair(vo);
	}
	public int modRepair(SYRepairVo vo){
		return overhaulDAO.modRepair(vo);
	}
	public int delRepair(SYRepairVo vo){
		return overhaulDAO.delRepair(vo);
	}
	public List<SYMaterialVo> getItemnm(SYMaterialVo vo){
		return overhaulDAO.getItemnm(vo);
	}
	public int delRepairReportFile(SYRepairVo vo) {
		return overhaulDAO.delRepairReportFile(vo);
	}
	
	
	public List<SYRepairAnalysisVo> selectRepairAnalysis(SYRepairAnalysisVo vo)
	{
		return overhaulDAO.selectRepairAnalysis(vo);
	}
	
	public List<SYRepairVo> selectrepairReqR(SYRepairVo vo){
		return overhaulDAO.selectrepairReqR(vo);
	}
	
	
	public List<SYRepairVo> selectrepairOther(SYRepairVo vo){
		return overhaulDAO.selectrepairOther(vo);
	}
	public int updateRepairOrder(SYRepairVo vo){
		return overhaulDAO.updateRepairOrder(vo);
	}
	
	public List<SYRepairVo> selectrepairUsingDay(SYRepairVo vo){
		return overhaulDAO.selectrepairUsingDay(vo);
	}
	
	public List<SYRepairVo> selectrepairItem(SYRepairVo vo){
		return overhaulDAO.selectrepairItem(vo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// jyp
	public int insRepairReportFile(SYRepairVo vo){
		return overhaulDAO.insRepairReportFile(vo);
	}
	
	//210204
	public int updateReportDate(SYRepairVo vo){
		return overhaulDAO.updateReportDate(vo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
