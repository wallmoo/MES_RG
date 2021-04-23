package kr.co.passcombine.set.svc;

import java.util.List;

import javax.annotation.Resource;

import kr.co.passcombine.set.dao.SYGoalDAO;
import kr.co.passcombine.set.vo.SYGoalVo;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


@Service(value = "setGoalService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYGoalService {


	@Resource(name = "setGoalDAO")
	private SYGoalDAO goalDAO;

	public List<SYGoalVo> selectItem(SYGoalVo code){
		return goalDAO.selectItem(code);
	}
	
	public List<SYGoalVo> selectGoal(SYGoalVo code){
		return goalDAO.selectGoal(code);
	}
	
	public int saveGoal(SYGoalVo vo){
		return goalDAO.saveGoal(vo);
	}
	//1210
	public List<SYGoalVo> selectGoalMachine(SYGoalVo code){
		return goalDAO.selectGoalMachine(code);
	}
	public List<SYGoalVo> selectGoalMachineAll(SYGoalVo code){
		return goalDAO.selectGoalMachineAll(code);
	}
	
	public int saveGoalMachine(SYGoalVo vo){
		return goalDAO.saveGoalMachine(vo);
	}
	
	//1210
	public List<SYGoalVo> selectGoalCustomer(SYGoalVo code){
		return goalDAO.selectGoalCustomer(code);
	}
	
	public int saveGoalCustomer(SYGoalVo vo){
		return goalDAO.saveGoalCustomer(vo);
	}
	
	//1210
	public List<SYGoalVo> selectGoalAccount(SYGoalVo code){
		return goalDAO.selectGoalAccount(code);
	}
	
	public int saveGoalAccount(SYGoalVo vo){
		return goalDAO.saveGoalAccount(vo);
	}
	
	//1215
	public List<SYGoalVo> selectGoalPrdct(SYGoalVo code){
		return goalDAO.selectGoalPrdct(code);
	}
	
	public int saveGoalPrdct(SYGoalVo vo){
		return goalDAO.saveGoalPrdct(vo);
	}
	
	//1215
	public List<SYGoalVo> selectGoalRpr(SYGoalVo code){
		return goalDAO.selectGoalRpr(code);
	}
	
	public int saveGoalRpr(SYGoalVo vo){
		return goalDAO.saveGoalRpr(vo);
	}
	
	
	//1217
	public List<SYGoalVo> selectGoalDfct(SYGoalVo code){
		return goalDAO.selectGoalDfct(code);
	}
	
	public int saveGoalDfct(SYGoalVo vo){
		return goalDAO.saveGoalDfct(vo);
	}


}
