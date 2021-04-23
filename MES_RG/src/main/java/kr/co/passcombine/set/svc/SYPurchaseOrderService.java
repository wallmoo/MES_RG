package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;













//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.dao.SYInfoDAO;
import kr.co.passcombine.set.dao.SYOrderDAO;
import kr.co.passcombine.set.dao.SYPurchaseOrderDAO;
import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
//import kr.co.passcombine.changwon.vo.SYLineVo;
//import kr.co.passcombine.changwon.vo.SYProdVo;
//import kr.co.passcombine.changwon.vo.SYScmRawSernrVo;
//import kr.co.passcombine.changwon.vo.SYSernrManageVo;
//import kr.co.passcombine.changwon.vo.SYHubItnbrVo;
//import kr.co.passcombine.changwon.vo.SYMenuVo;
//import kr.co.passcombine.changwon.vo.SYMesVo;
//import kr.co.passcombine.changwon.vo.SYPoRequirementVo;
//import kr.co.passcombine.changwon.vo.SYProdVo;
//import kr.co.passcombine.changwon.vo.SYScmRawDeliveryVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYDeliveryOrderVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYPurchaseOrderVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;


@Service(value = "setPurchaseOrderService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYPurchaseOrderService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setPurchaseOrderDAO")
	private SYPurchaseOrderDAO dao;

	
	public String selectPurchaseOrderNum()
	{
		return dao.selectPurchaseOrderNum();
	}
	
	public List<SYPurchaseOrderVo> selectPurchaseOrder(SYPurchaseOrderVo vo) {
		return dao.selectPurchaseOrder(vo);
	}
	
	public int savePurchaseOrder(SYPurchaseOrderVo vo){
		return dao.savePurchaseOrder(vo);
	}
	
	public int deletePurchaseOrder(SYPurchaseOrderVo vo) {
		return dao.deletePurchaseOrder(vo);
	}
	
	// 메인화면 
	public List<SYPurchaseOrderDetailVo> selectPurchaseOrderMain(SYPurchaseOrderDetailVo vo) {
		return dao.selectPurchaseOrderMain(vo);
	}
	
	// Detail
	
	public List<SYPurchaseOrderDetailVo> selectPurchaseOrderDetail(SYPurchaseOrderDetailVo vo) {
		return dao.selectPurchaseOrderDetail(vo);
	}
	
	/*public int savePurchaseOrderDetail(SYPurchaseOrderDetailVo vo){
		return dao.savePurchaseOrderDetail(vo);
	}*/
	
	public int deletePurchaseOrderDetail(SYPurchaseOrderDetailVo vo) {
		return dao.deletePurchaseOrderDetail(vo);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int savePurchaseOrderDetail(List<SYPurchaseOrderDetailVo> list, SYPurchaseOrderVo vo){
	
		int result = 0;
		
		dao.savePurchaseOrder(vo);
		
		for(int i=0 ; i<list.size() ; i++)
		{ 
			if("R".equals(list.get(i).getPurchase_status())){
				list.get(i).setPurchase_order_num(vo.getPurchase_order_num());
				result = dao.savePurchaseOrderDetail(list.get(i));
			}
		}
		
		return result;
	}
	
}
