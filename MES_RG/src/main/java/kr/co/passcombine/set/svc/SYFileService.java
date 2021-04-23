package kr.co.passcombine.set.svc;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.passcombine.set.dao.SYFileDAO;
import kr.co.passcombine.set.vo.SYFileVo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service(value = "setFileService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYFileService {

	private static final Logger logger = LoggerFactory.getLogger(SYFileService.class);
	
	@Resource(name = "setFileDAO")
	private SYFileDAO fileDAO;
	
	public SYFileVo selectFileDetail(SYFileVo fileVo){
		return fileDAO.selectFileDetail(fileVo);
	}
	
	/*public int insertFile(SYFileVo fileVo){
		return fileDAO.insertFile(fileVo);
	}*/
	public int deleteFile(SYFileVo fileVo){
		return fileDAO.deleteFile(fileVo);
	}

	public int delFlagFile(SYFileVo sVo) {
		return fileDAO.delFlagFile(sVo);
	}

	public int selectFile_count(SYFileVo sVo) {
		return fileDAO.selectFile_count(sVo);
	}

	public List<SYFileVo> selectFile_nopage(SYFileVo sVo) {
		return fileDAO.selectFile_nopage(sVo);
	}
	
	//prod_mng
	public String selectFileKey(){
		return fileDAO.selectFileKey();
	}
	public String selectRepairFileKey() {
		return fileDAO.selectRepairFileKey();
	}
	
	/*@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertDrwFile(SYFileVo fileVo){
		int result = fileDAO.updtDrwInfo(fileVo);
		result = fileDAO.insertFile(fileVo);
		result = fileDAO.insertDrwInfo(fileVo);		
		return result; 
	}
	*/
	
	// jyp
	public List<SYFileVo> selectFile(SYFileVo vo){
		return fileDAO.selectFile(vo);
	}
	public int selectFileClass_cnt(SYFileVo vo) {
		return fileDAO.selectFileClass_cnt(vo);
	}
	public List<SYFileVo> selectFileClass(SYFileVo vo){
		return fileDAO.selectFileClass(vo);
	}
	public int insFileClass(SYFileVo vo) {
		return fileDAO.insFileClass(vo);
	}
	public int updFileClass(SYFileVo vo) {
		return fileDAO.updFileClass(vo);
	}
	public int delFileClass(Map<String, Object> params) {
		return fileDAO.delFileClass(params);
	}
	public List<SYFileVo> selectFileType(SYFileVo vo){
		return fileDAO.selectFileType(vo);
	}
	
	public int insFileType (SYFileVo vo) {
		return fileDAO.insFileType(vo);
	}
	public int updFileType(SYFileVo vo) {
		return fileDAO.updFileType(vo);
	}
	public int delFileType(Map<String, Object> params) {
		return fileDAO.delFileType(params);
	}
	
	public int insFileInfo(SYFileVo vo) {
		return fileDAO.insFileInfo(vo);
	}
	
	public int insNewFileInfo(SYFileVo vo) {
		return fileDAO.insNewFileInfo(vo);
	}
	
	public int updFileInfo(SYFileVo vo) {
		return fileDAO.updFileInfo(vo);
	}
	
	public int delFileInfo(Map<String, Object> params) {
		return fileDAO.delFileInfo(params);
	}
	
	public int insRepairReportFile(SYFileVo vo) {
		return fileDAO.insRepairReportFile(vo);
	}
	public int deleteRepairFile(SYFileVo vo) {
		return fileDAO.deleteRepairFile(vo);
	}
	public int delFileByClass(Map<String, Object> params) {
		return fileDAO.delFileByClass(params);
	}
	public int delFileByType(Map<String, Object> params) {
		return fileDAO.delFileByType(params);
	}
	public int delFileTypeByClass(Map<String, Object> params) {
		return fileDAO.delFileTypeByClass(params);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// jyp

}