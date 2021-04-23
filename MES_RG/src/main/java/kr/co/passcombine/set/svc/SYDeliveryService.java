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

import kr.co.passcombine.set.dao.SYDeliveryDAO;
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


@Service(value = "setDeliveryService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYDeliveryService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setDeliveryDAO")
	private SYDeliveryDAO deliveryDAO;

	
	public List<SYDeliveryVo> selectDelivery(SYDeliveryVo vo) {
		return deliveryDAO.selectDelivery(vo);
	}
/*	public int saveDelivery(SYDeliveryVo vo){
		return deliveryDAO.saveDelivery(vo);
	}*/
	
	public int deleteDelivery(SYDeliveryVo vo) {
		return deliveryDAO.deleteDelivery(vo);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveDeliveryMulti(SYDeliveryVo vo, String out_user, String out_comment){
		int result = 0 ;
		System.out.println("vo.getSend_delivery_menge()"+vo.getSend_delivery_menge());
		deliveryDAO.saveDeliveryMulti(vo);
		
		
		SYDeliveryOrderVo requestDDVo = new SYDeliveryOrderVo();
		
		
		requestDDVo.setDelivery_num(vo.getDelivery_num());
		
		List<SYDeliveryOrderVo> doVoList = deliveryDAO.selectDeliveryOrder(requestDDVo);
		
		SYDeliveryOrderVo doVo = doVoList.get(0);
		
		
		
		
		SYWarehouseOutVo woVo = new SYWarehouseOutVo();
		
	
		woVo.setBusiness_code(doVo.getBusiness_code());
		woVo.setBusiness_nm(doVo.getBusiness_nm());
		woVo.setOut_type("d");
		woVo.setOut_warehousing_status("o");
		woVo.setOut_date(vo.getDelivery_date());
		woVo.setOut_user(out_user);
		woVo.setOut_comment(out_comment);
		woVo.setItem_code(vo.getItem_code());
		woVo.setItem_nm(vo.getItem_nm());
		
		
		
		
		
		woVo.setWarehousing_qty(vo.getDelivery_menge());
		
		woVo.setCreator(vo.getCreator());
		woVo.setUpdater(vo.getUpdater());

		deliveryDAO.saveWarehouseOut(woVo);
		
		
		SYWarehouseVo wVo = new SYWarehouseVo();
		
		wVo.setItem_code(vo.getItem_code());

		wVo.setWarehousing_qty(vo.getReal_send_delivery_menge());
		System.out.println("vo.getReal_send_delivery_menge():::"+vo.getReal_send_delivery_menge());
		wVo.setUpdater(vo.getUpdater());
		deliveryDAO.minusWarehouse(wVo);
		
		return result;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveDelivery(SYDeliveryVo vo, String out_user, String out_comment){
		int result = 0 ;
		System.out.println("vo.getSend_delivery_menge()"+vo.getSend_delivery_menge());
		deliveryDAO.saveDelivery(vo);
		
		
		SYDeliveryOrderVo requestDDVo = new SYDeliveryOrderVo();
		
		
		requestDDVo.setDelivery_num(vo.getDelivery_num());
		
		List<SYDeliveryOrderVo> doVoList = deliveryDAO.selectDeliveryOrder(requestDDVo);
		
		SYDeliveryOrderVo doVo = doVoList.get(0);
		
		
		
		
		SYWarehouseOutVo woVo = new SYWarehouseOutVo();
		
	
		woVo.setBusiness_code(doVo.getBusiness_code());
		woVo.setBusiness_nm(doVo.getBusiness_nm());
		woVo.setOut_type("d");
		woVo.setOut_warehousing_status("o");
		woVo.setOut_date(vo.getDelivery_date());
		woVo.setOut_user(out_user);
		woVo.setOut_comment(out_comment);
		woVo.setItem_code(vo.getItem_code());
		woVo.setItem_nm(vo.getItem_nm());
		
		
		
		
		woVo.setWarehousing_price(doVo.getUnit_price());
		woVo.setWarehousing_qty(vo.getDelivery_menge());
		
		woVo.setCreator(vo.getCreator());
		woVo.setUpdater(vo.getUpdater());

		deliveryDAO.saveWarehouseOut(woVo);
		
		
		SYWarehouseVo wVo = new SYWarehouseVo();
		
		wVo.setItem_code(vo.getItem_code());

		wVo.setWarehousing_qty(vo.getDelivery_menge());
		wVo.setUpdater(vo.getUpdater());
		deliveryDAO.minusWarehouse(wVo);
		
		return result;
	}
	
}
