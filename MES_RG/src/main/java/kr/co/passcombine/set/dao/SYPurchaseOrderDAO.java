package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYPurchaseOrderVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;

@Repository(value = "setPurchaseOrderDAO")
public interface SYPurchaseOrderDAO {
	
	/**
	 * 창완
	 * 
	 */
	// Master 
	public String selectPurchaseOrderNum();
	
	public List<SYPurchaseOrderVo> selectPurchaseOrder(SYPurchaseOrderVo vo);
	
	public int savePurchaseOrder(SYPurchaseOrderVo vo);
	
	public int deletePurchaseOrder(SYPurchaseOrderVo vo);
	
	// 메인
	public List<SYPurchaseOrderDetailVo> selectPurchaseOrderMain(SYPurchaseOrderDetailVo vo);
	
	// Detail
	
	public List<SYPurchaseOrderDetailVo> selectPurchaseOrderDetail(SYPurchaseOrderDetailVo vo);
	
	public int savePurchaseOrderDetail(SYPurchaseOrderDetailVo vo);
	
	public int deletePurchaseOrderDetail(SYPurchaseOrderDetailVo vo);
	
	public int updatePurchaseIncoming(SYPurchaseOrderDetailVo vo);
	
}
