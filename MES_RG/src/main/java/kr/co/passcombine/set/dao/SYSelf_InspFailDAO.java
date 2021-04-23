package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYClaimVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;
import kr.co.passcombine.set.vo.SYSelf_InspFailVo;

@Repository(value = "setSelf_InspFailDAO")
public interface SYSelf_InspFailDAO {
	

	public List<SYSelf_InspFailVo> selectSelfInspFail(SYSelf_InspFailVo vo);
	
	
	public int saveSelfInspFail(SYSelf_InspFailVo vo);
	
	public int deleteSelfInspFail(SYSelf_InspFailVo vo);
	
	public int updateSelfInspFail(SYSelf_InspFailVo vo);
	
	public int saveSelfInspFail2(SYSelf_InspFailVo vo);



}
