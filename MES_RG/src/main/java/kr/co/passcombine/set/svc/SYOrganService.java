package kr.co.passcombine.set.svc;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.core.env.Environment;

import kr.co.passcombine.set.vo.SYMemberVo;
import kr.co.passcombine.set.vo.SYOrganVo;
import kr.co.passcombine.set.dao.SYOrganDAO;

 

@Service(value = "setOrganService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYOrganService {

	private static final Logger logger = LoggerFactory.getLogger(SYOrganService.class);
	
	@Resource
	private Environment environment;
	
	@Resource(name = "setOrganDAO")
	private SYOrganDAO organDAO;
	
	public List<SYOrganVo> selectOrgan(SYOrganVo deptVo){
		return organDAO.selectOrgan(deptVo);
	}
	public SYOrganVo selectOrganInfo(SYOrganVo deptVo){
		return organDAO.selectOrganInfo(deptVo);
	}
	public int insertDept(SYOrganVo deptVo){
		return organDAO.insertDept(deptVo);
	}
	public int updateDept(SYOrganVo deptVo){
		return organDAO.updateDept(deptVo);
	}
	public int deleteDept(SYOrganVo deptVo){
		return organDAO.deleteDept(deptVo);
	}
	public List<SYMemberVo> selectMemberList(SYMemberVo memberVo){
		return organDAO.selectMemberList(memberVo);
	}
	public SYMemberVo selectMemberInfo(SYMemberVo memberVo){
		return organDAO.selectMemberInfo(memberVo);
	}
	
	public SYMemberVo selectMemberLoginInfoAuto(SYMemberVo memberVo){
		return organDAO.selectMemberLoginInfoAuto(memberVo);
	}
	
	public List<SYMemberVo> selectMemberCheck(SYMemberVo memberVo){
		return organDAO.selectMemberCheck(memberVo);
	}
	public int selectRoleMemberCount(SYMemberVo memberVo){
		return organDAO.selectRoleMemberCount(memberVo);
	}
	public List<SYMemberVo> selectRoleMemberList(SYMemberVo memberVo){
		return organDAO.selectRoleMemberList(memberVo);
	}
	public int insertRoleMember(SYMemberVo memberVo){
		int result = organDAO.deleteRoleMember(memberVo);
		result = organDAO.insertRoleMember(memberVo); 
		return result;
	}
	public int deleteRoleMember(SYMemberVo memberVo){
		return organDAO.deleteRoleMember(memberVo);
	}
	public SYMemberVo selectMemberLoginInfo(SYMemberVo memberVo){
		return organDAO.selectMemberLoginInfo(memberVo);
	}
	public int selectMemberIdCheck(SYMemberVo memberVo){
		return organDAO.selectMemberIdCheck(memberVo);
	}
	public int selectMemberEMPCheck(SYMemberVo memberVo){
		return organDAO.selectMemberEMPCheck(memberVo);
	}
	public int insertMember(SYMemberVo memberVo){
		int result = organDAO.insertMember(memberVo);
		result = organDAO.insertOrganMember(memberVo);
		return result;
	}
	public int updateMember(SYMemberVo memberVo){
		int result = organDAO.updateMember(memberVo);
		result = organDAO.updateOrganMember(memberVo);
		return result;
	}
	public int updateMemberPwd(SYMemberVo memberVo) {
		return organDAO.updateMemberPwd(memberVo);
	}
	public int deleteMember(SYMemberVo memberVo){
		int result = organDAO.deleteMember(memberVo);
		result = organDAO.deleteOrganMember(memberVo);
		return result;
	}
	public int chnDeptSave(SYMemberVo memberVo) {
		return organDAO.chnDeptSave(memberVo);
	}
	
	 
	
}