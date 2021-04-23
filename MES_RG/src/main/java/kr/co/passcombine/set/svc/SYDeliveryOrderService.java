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

import kr.co.passcombine.set.controller.FrontendController;
import kr.co.passcombine.set.dao.SYDeliveryOrderDAO;
import kr.co.passcombine.set.dao.SYInfoDAO;
import kr.co.passcombine.set.dao.SYOrderDAO;
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
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;


@Service(value = "setDeliveryOrderService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYDeliveryOrderService {
	private static final Logger logger = LoggerFactory
			.getLogger(SYDeliveryOrderService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "setDeliveryOrderDAO")
	private SYDeliveryOrderDAO dOrderDAO;

	public String selectDeliveryNum()
	{
		return dOrderDAO.selectDeliveryNum();
	}
	
	public List<SYDeliveryOrderVo> selectDeliveryOrder(SYDeliveryOrderVo vo) {
		return dOrderDAO.selectDeliveryOrder(vo);
	}
	public int saveDeliveryOrder(SYDeliveryOrderVo vo){
		return dOrderDAO.saveDeliveryOrder(vo);
	}
	
	public int deleteDeliveryOrder(SYDeliveryOrderVo vo) {
		return dOrderDAO.deleteDeliveryOrder(vo);
	}
	
	public int updateSuccessStatus(SYDeliveryOrderVo vo) {
		return dOrderDAO.updateSuccessStatus(vo);
	}
	
	public int delDeliveryOrder(SYDeliveryOrderVo vo) {
		return dOrderDAO.delDeliveryOrder(vo);
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveDeliveryOrder2(List<SYDeliveryOrderVo> list, SYOrderVo vo){
	
		int result = 0;
		
		
		for(int i=0 ; i<list.size() ; i++)
		{ 
			list.get(i).setOrder_num(vo.getOrder_num());
			list.get(i).setItem_code(vo.getItem_code());
			list.get(i).setItem_nm(vo.getItem_nm());
			
			list.get(i).setDelivery_req_date(vo.getDelivery_date());
			list.get(i).setCustomer_code(vo.getCustomer_code());
			list.get(i).setCustomer_nm(vo.getCustomer_nm());
			list.get(i).setLand(vo.getLand());
			
			list.get(i).setUnit_price(vo.getUnit_price());
			list.get(i).setMenge(vo.getMenge());
			list.get(i).setTotal_price(vo.getTotal_price());
			
			
			result = dOrderDAO.saveDeliveryOrder(list.get(i));
		}
		
		return result;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveDeliveryOrderAll(List<SYDeliveryOrderVo> list){
	
		int result = 0;

		for(int i=0 ; i<list.size() ; i++)
		{ 

			result = dOrderDAO.saveDeliveryOrder(list.get(i));
		}
		
		return result;
	}
	
	
	
	
}
