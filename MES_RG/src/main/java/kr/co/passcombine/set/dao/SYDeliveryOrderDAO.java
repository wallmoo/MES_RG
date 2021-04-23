package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYDeliveryOrderVo;
import kr.co.passcombine.set.vo.SYDeliveryVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;

@Repository(value = "setDeliveryOrderDAO")
public interface SYDeliveryOrderDAO {
	
	/**
	 * 창완
	 * 
	 */
	
	// Delivery Order

	public String selectDeliveryNum();
	
	public List<SYDeliveryOrderVo> selectDeliveryOrder(SYDeliveryOrderVo vo);
	
	public int saveDeliveryOrder(SYDeliveryOrderVo vo);
	
	public int deleteDeliveryOrder(SYDeliveryOrderVo vo);
	
	public int updateSuccessStatus(SYDeliveryOrderVo vo);
	
	public int delDeliveryOrder(SYDeliveryOrderVo vo);
	
	public List<SYDeliveryOrderVo> excelLoad(SYDeliveryOrderVo vo);
	
	public int updateDeliveryDelete(SYDeliveryOrderVo vo);
}
