package kr.co.passcombine.set.svc;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import kr.co.passcombine.set.vo.LogStatusVo;
import kr.co.passcombine.set.dao.LogStatusDAO;

@Component("setLogStatusService")
public class LogStatusService {
	@Resource(name="setLogStatusDAO")
	private LogStatusDAO logStatusDAO;
	
	public List<LogStatusVo> selectLogStatus(LogStatusVo logVo){
		return logStatusDAO.selectLogStatus(logVo);
	}
	
	public int insertLogStatus(LogStatusVo logVo){
		return logStatusDAO.insertLogStatus(logVo);
	}
	
	public int deleteLogStatus(LogStatusVo logVo){
		return logStatusDAO.deleteLogStatus(logVo);
	}
}
