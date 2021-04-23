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

import kr.co.passcombine.set.dao.SYDrwFileDAO;
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
import kr.co.passcombine.set.vo.SYDrwFileInfoVo;
import kr.co.passcombine.set.vo.SYFileVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;


@Service(value = "setDrwFileService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYDrwFileService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setDrwFileDAO")
	private SYDrwFileDAO drwDAO;


	public int fnCheckPN(SYDrwFileInfoVo vo) {
		return drwDAO.fnCheckPN(vo);
	}
	
	public List<SYDrwFileInfoVo> selectDrwFile(SYDrwFileInfoVo vo) {
		return drwDAO.selectDrwFile(vo);
	}
	
	public String selectFileKey(){
		return drwDAO.selectFileKey();
	}
	public int insFileInfo(SYDrwFileInfoVo vo) {
		return drwDAO.insFileInfo(vo);
	}
	
	public int insNewFileInfo(SYDrwFileInfoVo vo) {
		return drwDAO.insNewFileInfo(vo);
	}
	
	public int updFileInfo(SYDrwFileInfoVo vo) {
		return drwDAO.updFileInfo(vo);
	}
	
	public int delFileInfo(Map<String, Object> params) {
		return drwDAO.delFileInfo(params);
	}
	
	
	
}
