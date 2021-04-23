package kr.co.passcombine.set.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.passcombine.set.vo.SYMemberVo;
import kr.co.passcombine.set.vo.SYOrganVo;

import org.springframework.stereotype.Repository;

@Repository(value = "setOrganDAO")
public interface SYOrganDAO {
	
	public List<SYOrganVo> selectOrgan(SYOrganVo deptVo);
	public SYOrganVo selectOrganInfo(SYOrganVo deptVo);
	
	public List<SYOrganVo> selOrganList(HashMap<String, Object> params);
	
	public List<SYOrganVo> selectDeptAll(SYOrganVo deptVo);
	public int insertDept(SYOrganVo deptVo);
	public int updateDept(SYOrganVo deptVo);
	public int deleteDept(SYOrganVo deptVo);
	
	public List<SYMemberVo> selectMemberList(SYMemberVo memberVo);
	public SYMemberVo selectMemberInfo(SYMemberVo memberVo);
	public SYMemberVo selectMemberLoginInfoAuto(SYMemberVo memberVo);
	
	public List<SYMemberVo> selectMemberCheck(SYMemberVo memberVo);
	public int selectRoleMemberCount(SYMemberVo memberVo);
	
	
	public List<SYMemberVo> selectRoleMemberList(SYMemberVo memberVo);
	public int insertRoleMember(SYMemberVo memberVo);
	public int deleteRoleMember(SYMemberVo memberVo);
	
	public SYMemberVo selectMemberLoginInfo(SYMemberVo memberVo);
	public int selectMemberIdCheck(SYMemberVo memberVo);
	public int selectMemberEMPCheck(SYMemberVo memberVo);
	public int insertMember(SYMemberVo memberVo);
	public int updateMember(SYMemberVo memberVo);
	public int updateMemberPwd(SYMemberVo memberVo);
	public int deleteMember(SYMemberVo memberVo);
	
	public int insertOrganMember(SYMemberVo memberVo);
	public int updateOrganMember(SYMemberVo memberVo);
	public int deleteOrganMember(SYMemberVo memberVo);
	
	public int insertMasterOrgan(HashMap<String, String> htObj);
	public int updateDisableOrgan();
	public int insertSyncOrgan();
	public int insertMasterMember(HashMap<String, String> htObj);
	public int updateDisableMember();
	public int insertSyncMember();
	public int insertSyncMemberOrg();
	
	public int updateDisableOrganMes();
	public int insertSyncOrganMes();
	public int updateDisableMemberMes();
	public int insertSyncMemberMes();
	public int insertSyncMemberOrgMes();
	public int chnDeptSave(SYMemberVo memberVo);
	
}
