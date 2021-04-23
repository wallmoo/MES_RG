package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYFileVo;

@Repository(value = "setFileDAO")
public interface SYFileDAO {
	
	public String selectFileKey();
	public String selectRepairFileKey();
	public List<SYFileVo> selectFile(SYFileVo fVo);
	public SYFileVo selectFileDetail(SYFileVo fVo);
	
	public int deleteFile(SYFileVo fVo);
	public int delFlagFile(SYFileVo sVo);
	public int selectFile_count(SYFileVo sVo);
	public List<SYFileVo> selectFile_nopage(SYFileVo sVo);
	public int updtDrwInfo(SYFileVo fileVo);
	public int insertDrwInfo(SYFileVo fileVo);
	
	
	// jyp
	public int selectFileClass_cnt(SYFileVo vo);
	public List<SYFileVo> selectFileClass(SYFileVo vo);
	public int insFileClass(SYFileVo vo);
	public int updFileClass(SYFileVo vo);
	public int delFileClass(Map<String, Object> params);
	public List<SYFileVo> selectFileType( SYFileVo vo );
	
	public int insFileType(SYFileVo vo);
	public int updFileType(SYFileVo vo);
	public int delFileType(Map<String, Object> params);
	public int insFileInfo(SYFileVo vo);
	public int insNewFileInfo(SYFileVo vo);
	public int updFileInfo(SYFileVo vo);
	
	public int delFileInfo(Map<String ,Object> vo);
	public int insRepairReportFile(SYFileVo vo);
	public int deleteRepairFile(SYFileVo vo);
	public int delFileByClass(Map<String, Object> params);
	public int delFileByType(Map<String, Object> params);
	public int delFileTypeByClass(Map<String, Object> params);
	
	
	
	
	
	
	// jyup
}
