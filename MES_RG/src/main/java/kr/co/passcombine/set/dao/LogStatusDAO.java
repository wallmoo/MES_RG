package kr.co.passcombine.set.dao;

import java.util.List;

import kr.co.passcombine.set.vo.*;

import org.springframework.stereotype.Repository;

@Repository(value = "setLogStatusDAO")
public interface LogStatusDAO {
	public List<LogStatusVo> selectLogStatus(LogStatusVo logVo);
	public int insertLogStatus(LogStatusVo logVo);
	public int deleteLogStatus(LogStatusVo logVo);
}