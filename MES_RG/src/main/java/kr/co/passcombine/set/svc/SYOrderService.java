package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;















import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.dao.SYDeliveryOrderDAO;
import kr.co.passcombine.set.dao.SYInfoDAO;
import kr.co.passcombine.set.dao.SYOrderDAO;
import kr.co.passcombine.set.dao.SYProductDAO;
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
import kr.co.passcombine.set.vo.SYProductOperationVO;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;


@Service(value = "setOrderService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYOrderService {
	
	private static final Logger logger = LoggerFactory
			.getLogger(SYInfoService.class);

	@Resource
	private Environment environment;
	
	@Resource(name = "setOrderDAO")
	private SYOrderDAO orderDAO;
	
	@Resource(name = "setDeliveryOrderDAO")
	private SYDeliveryOrderDAO deliveryOrderDAO;
	
	@Resource(name = "setProductDAO")
	private SYProductDAO productDAO;

	// Order
	
	public String selectOrderNum()
	{
		return orderDAO.selectOrderNum();
	}
	
	public List<SYOrderVo> selectOrder(SYOrderVo vo) {
		return orderDAO.selectOrder(vo);
	}
	public List<SYOrderVo> selectOrder2(SYOrderVo vo) {
		return orderDAO.selectOrder2(vo);
	}
	
	public List<SYOrderVo> selectOrderPlan(SYOrderVo vo) {
		return orderDAO.selectOrderPlan(vo);
	}
	public int saveOrder(SYOrderVo vo){
		return orderDAO.saveOrder(vo);
	}
	
	public int deleteOrder(SYOrderVo vo) {
		return orderDAO.deleteOrder(vo);
	}
	
	
	
	
	//210120 주문등록 아이템 하나 삭제
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int deleteOrder2(SYOrderVo vo) {
		
		int result = 0;
		
		String order_num = vo.getOrder_num();
		String item_code = vo.getItem_code();
		
		logger.debug("order_num : " + order_num);
		logger.debug("item_code : " + item_code);
		
		SYProductVO dvo = new SYProductVO();
		
		dvo.setOrder_num(order_num); 
		dvo.setItem_code(item_code);
		
		List<SYProductVO> dList =  productDAO.selectProduct_status_info(dvo); 
		
		
		if(dList.size() > 0)
		{
			return 888;
		}else{
			
			orderDAO.deleteOrder2(vo);
			
			return 0;
		}
		
	}
	
	// product에서 사용
	public List<SYOrderVo> selectOrderProduct(SYOrderVo vo) {
		return orderDAO.selectOrderProduct(vo);
	}
	public List<SYOrderVo> selectOrderAll(SYOrderVo vo) {
		return orderDAO.selectOrderAll(vo);
	}
	
}
