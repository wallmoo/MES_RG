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
import kr.co.passcombine.set.vo.SYWarehouseOutVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;

@Repository(value = "setDeliveryDAO")
public interface SYDeliveryDAO {
	
	/**
	 * 창완
	 * 
	 */
	
	// Delivery

	
	public List<SYDeliveryVo> selectDelivery(SYDeliveryVo vo);
	
	public int saveDelivery(SYDeliveryVo vo);
	
	public int saveDeliveryMulti(SYDeliveryVo vo);
	
	public int deleteDelivery(SYDeliveryVo vo);
	

	// 출하실적관리의 출고 처리시 필요함. 
	
	public List<SYDeliveryOrderVo> selectDeliveryOrder(SYDeliveryOrderVo vo);
	
	
	public int saveWarehouseOut(SYWarehouseOutVo vo);
	
	public int minusWarehouse(SYWarehouseVo vo);
}
