package kr.co.passcombine.set.svc;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.vo.SYCodeVo;
import kr.co.passcombine.set.dao.SYCodeDAO;

@Service(value = "setCodeService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYCodeService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);

	@Resource(name = "setCodeDAO")
	private SYCodeDAO codeDAO;

	public List<SYCodeVo> selectMasterCode(SYCodeVo code){
		return codeDAO.selectMasterCode(code);
	}
	public int insertMasterCode(SYCodeVo code){
		return codeDAO.insertMasterCode(code);
	}
	public int updateMasterCode(SYCodeVo code){
		return codeDAO.updateMasterCode(code);
	}

	@Transactional
	public int deleteMasterCode(SYCodeVo code){
		int result = codeDAO.deleteDetailCode(code);
		return codeDAO.deleteMasterCode(code);
	}
	public List<SYCodeVo> selectDetailCode(SYCodeVo code){
		return codeDAO.selectDetailCode(code);
	}
	public int insertDetailCode(SYCodeVo code){
		return codeDAO.insertDetailCode(code);
	}
	public int updateDetailCode(SYCodeVo code){
		return codeDAO.updateDetailCode(code);
	}
	public int deleteDetailCode(SYCodeVo code){
		return codeDAO.deleteDetailCode(code);
	}
}
