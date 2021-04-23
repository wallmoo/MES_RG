package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYInstrumentVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;

@Repository(value = "setInstrumentDAO")
public interface SYInstrumentDAO {
	
	/**
	 * 창완
	 * 
	 */
	
	public List<SYInstrumentVo> selectInstrument(SYInstrumentVo vo);
	public String insInstrumentHis();
	
	public int saveInstrument(SYInstrumentVo vo);
	
	public int deleteInstrument(SYInstrumentVo vo);
	
	public List<SYInstrumentVo> selectInstrumentHis(SYInstrumentVo vo);
	
	public int insInstrumentHis(SYInstrumentVo vo);


	public int updFileInstrument(SYInstrumentVo vo);


}
