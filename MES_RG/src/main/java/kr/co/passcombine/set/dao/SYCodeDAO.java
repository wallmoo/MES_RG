package kr.co.passcombine.set.dao;

import java.util.List;

import kr.co.passcombine.set.vo.SYCodeVo;

import org.springframework.stereotype.Repository;

@Repository(value = "setCodeDAO")
public interface SYCodeDAO {

	public List<SYCodeVo> selectMasterCode(SYCodeVo code);
	public int insertMasterCode(SYCodeVo code);
	public int updateMasterCode(SYCodeVo code);
	public int deleteMasterCode(SYCodeVo code);

	public List<SYCodeVo> selectDetailCode(SYCodeVo code);
	public int insertDetailCode(SYCodeVo code);
	public int updateDetailCode(SYCodeVo code);
	public int deleteDetailCode(SYCodeVo code);
}
