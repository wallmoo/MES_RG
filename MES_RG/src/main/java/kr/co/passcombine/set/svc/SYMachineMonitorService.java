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

import kr.co.passcombine.set.dao.SYClaimDAO;
import kr.co.passcombine.set.dao.SYInfoDAO;
import kr.co.passcombine.set.dao.SYInstrumentDAO;
import kr.co.passcombine.set.dao.SYMachineMonitorDAO;
import kr.co.passcombine.set.dao.SYOrderDAO;
import kr.co.passcombine.set.dao.SYPurchaseOrderDAO;
import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYClaimVo;
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
import kr.co.passcombine.set.vo.SYInstrumentVo;
import kr.co.passcombine.set.vo.SYMachineMonitorInfoVO;
import kr.co.passcombine.set.vo.SYMachineMonitorVO;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYPurchaseOrderVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;




@Service(value = "setMachineMonitorService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYMachineMonitorService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setMachineMonitorDAO")
	private SYMachineMonitorDAO dao;

	public List<SYMachineMonitorVO> selectWaiting(SYMachineMonitorVO vo) {
		return dao.selectWaiting(vo);
	}
	public List<SYMachineMonitorVO> selectOperation(SYMachineMonitorVO vo) {
		return dao.selectOperation(vo);
	}
	public List<SYMachineMonitorInfoVO> selectInfo(SYMachineMonitorInfoVO vo) {
		return dao.selectInfo(vo);
	}
	
	
}
