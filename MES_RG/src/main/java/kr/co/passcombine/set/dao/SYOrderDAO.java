package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;

@Repository(value = "setOrderDAO")
public interface SYOrderDAO {
	
	/**
	 * 창완
	 * 
	 */
	
	// Order
	
	public String selectOrderNum();
	
	public List<SYOrderVo> selectOrder(SYOrderVo vo);
	
	public List<SYOrderVo> selectOrder2(SYOrderVo vo);
	
	public List<SYOrderVo> selectOrderPlan(SYOrderVo vo);
	
	public List<SYOrderVo> selectOrderAll(SYOrderVo vo);
	
	public int saveOrder(SYOrderVo vo);
	
	public int deleteOrder(SYOrderVo vo);
	
	public int deleteOrder2(SYOrderVo vo);
	
	// Product 에서 사용
	public List<SYOrderVo> selectOrderProduct(SYOrderVo vo);
}
