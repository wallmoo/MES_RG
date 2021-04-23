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

@Repository(value = "setClaimDAO")
public interface SYClaimDAO {
	

	public List<SYClaimVo> selectClaim(SYClaimVo vo);
	
	
	public int saveClaim(SYClaimVo vo);
	
	public int deleteClaim(SYClaimVo vo);
	
	public int updateClaim(SYClaimVo vo);


	public int saveClaimFile(SYClaimVo vo);


}
