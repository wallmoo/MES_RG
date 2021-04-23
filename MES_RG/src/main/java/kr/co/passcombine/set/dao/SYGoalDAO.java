package kr.co.passcombine.set.dao;

import java.util.List;




import kr.co.passcombine.set.vo.SYGoalVo;

import org.springframework.stereotype.Repository;

@Repository(value = "setGoalDAO")
public interface SYGoalDAO {
	
	// 좌측 그리드 
	public List<SYGoalVo> selectItem(SYGoalVo vo);
	// 우측 그리드 
	public List<SYGoalVo> selectGoal(SYGoalVo vo);
	// 우측 그리드 저장
	public int saveGoal(SYGoalVo deptVo);
	
	//1210
	public List<SYGoalVo> selectGoalMachine(SYGoalVo vo);
	
	public List<SYGoalVo> selectGoalMachineAll(SYGoalVo vo);
	// 우측 그리드 저장
	public int saveGoalMachine(SYGoalVo deptVo);
	
	public List<SYGoalVo> selectGoalCustomer(SYGoalVo vo);
	// 우측 그리드 저장
	public int saveGoalCustomer(SYGoalVo deptVo);
	
	public List<SYGoalVo> selectGoalAccount(SYGoalVo vo);
	// 우측 그리드 저장
	public int saveGoalAccount(SYGoalVo deptVo);
	
	//1215
	public List<SYGoalVo> selectGoalPrdct(SYGoalVo vo);
	// 우측 그리드 저장
	public int saveGoalPrdct(SYGoalVo deptVo);
	
	public List<SYGoalVo> selectGoalRpr(SYGoalVo vo);
	// 우측 그리드 저장
	public int saveGoalRpr(SYGoalVo deptVo);
	
	public List<SYGoalVo> selectGoalDfct(SYGoalVo vo);
	// 우측 그리드 저장
	public int saveGoalDfct(SYGoalVo deptVo);

}
