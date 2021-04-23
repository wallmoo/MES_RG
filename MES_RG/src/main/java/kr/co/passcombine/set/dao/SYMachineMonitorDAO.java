package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYClaimVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineMonitorInfoVO;
import kr.co.passcombine.set.vo.SYMachineMonitorVO;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYMenuVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;

@Repository(value = "setMachineMonitorDAO")
public interface SYMachineMonitorDAO {
	


	public List<SYMachineMonitorVO> selectWaiting(SYMachineMonitorVO vo);
	
	public List<SYMachineMonitorVO> selectOperation(SYMachineMonitorVO vo);
	

	public List<SYMachineMonitorInfoVO> selectInfo(SYMachineMonitorInfoVO vo);

}
