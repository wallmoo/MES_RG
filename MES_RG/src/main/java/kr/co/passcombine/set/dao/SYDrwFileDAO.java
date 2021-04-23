package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
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

@Repository(value = "setDrwFileDAO")
public interface SYDrwFileDAO {
	
	/**
	 * 창완
	 * 
	 */
	
	// DrwFileInfo	
	public int fnCheckPN(SYDrwFileInfoVo vo);
	
	public List<SYDrwFileInfoVo> selectDrwFile(SYDrwFileInfoVo vo);

	public String selectFileKey();
	
	public int insFileInfo(SYDrwFileInfoVo vo);
	public int insNewFileInfo(SYDrwFileInfoVo vo);
	public int updFileInfo(SYDrwFileInfoVo vo);
	
	public int delFileInfo(Map<String ,Object> vo);
}
