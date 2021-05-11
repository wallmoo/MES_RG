package kr.co.passcombine.set.svc;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.dao.SYInfoDAO;
import kr.co.passcombine.set.dao.SYMaterialsDAO;
import kr.co.passcombine.set.dao.SYPurchaseOrderDAO;
@Service(value = "setMateriaService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYMaterialService {
	private static final Logger logger = LoggerFactory
			.getLogger(SYInfoService.class);

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "setMaterialsDAO")
	private SYMaterialsDAO MaterialsDAO;

	public int insertMaterial2(Map<String, Object> vo, Map<String, Object> file) {
		if(!file.isEmpty()) {
			int result = MaterialsDAO.insertFile2(file);
			vo.put("CMM_FLE_IDX",file.get("CMM_FLE_IDX"));
			}
			MaterialsDAO.insertMaterialMap2(vo);
			return MaterialsDAO.insertBOM2(vo);
	}

	public int UpdateEstimate(List<Map<String, Object>> valueList) {
		// TODO Auto-generated method stub
		return MaterialsDAO.updateEstimate2(valueList);
	}

	public List<Map<String, Object>> selectMaterials(Map<String, Object> vo) {
		if(vo.containsKey("WHS_HIS_GB")) {
			return  MaterialsDAO.selectMaterialIO(vo);
		}else {
			return MaterialsDAO.selectMaterialNotIO(vo);
		}
	}

	public int updateEstimateOs(Map<String, Object> vo) {
		int result=0;
		MaterialsDAO.updateEstimateOs1(vo);
		/*
		String idx = (String)vo.get("WHS_HIS_IDX");
		if(!idx.equals("") && !idx.equals("0")){
			result = MaterialsDAO.updateEstimateOs2(vo);
		}*/
		
		if(result==0) {
			MaterialsDAO.insertEstimateOs1(vo);
		}
		
		
		return 1;
	}
	
/*
	public Map<String, Object> selectFiles(Map<String, Object> vo) {
		Map<String,Object> result=MaterialsDAO.selectFiles2(vo);
		if(result!=null) {
			MaterialsDAO.updateFile2(result);
		}
		return result;
	}

	public int updateMaterial(Map<String, Object> vo, Map<String, Object> file) {
			if(!file.isEmpty()) {
			int result = MaterialsDAO.insertFile2(file);
			vo.put("CMM_FLE_IDX",file.get("CMM_FLE_IDX"));
			}
			return MaterialsDAO.updateMaterialMap2(vo);
		}
	}
		*/
}
	
	