package kr.co.passcombine.set.svc;

import java.util.List;

import javax.annotation.Resource;

import kr.co.passcombine.set.vo.SYMenuVo;
import kr.co.passcombine.set.dao.SYMenuDAO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service(value = "setMenuService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYMenuService {

	// private static final Logger logger = LoggerFactory.getLogger(SYMenuService.class);
	
	@Resource(name = "setMenuDAO")
	private SYMenuDAO menuDAO;
	
	public List<SYMenuVo> selectMenu(SYMenuVo menuVo){
		return menuDAO.selectMenu(menuVo);
	}
	public SYMenuVo selectMenuInfo(SYMenuVo menuVo){
		return menuDAO.selectMenuInfo(menuVo);
	}
	public int insertMenu(SYMenuVo menuVo){
		return menuDAO.insertMenu(menuVo);
	}
	public int updateMenu(SYMenuVo menuVo){
		return menuDAO.updateMenu(menuVo);
	}
	public int deleteMenu(SYMenuVo menuVo){
		return menuDAO.deleteMenu(menuVo);
	}
	public List<SYMenuVo> selectMenuAll(SYMenuVo menuVo){
		return menuDAO.selectMenuAll(menuVo);
	}
	public List<SYMenuVo> selectMenuAcl(SYMenuVo menuVo){
		return menuDAO.selectMenuAcl(menuVo);
	}
	public List<SYMenuVo> selectMenuRole(SYMenuVo menuVo){
		return menuDAO.selectMenuRole(menuVo);
	}
	
	public int insertMenuRole(SYMenuVo menuVo, String menus, String mngs, String writes, String reads){
		int result = menuDAO.deleteMenuRole(menuVo);
		String[] arrMenu = menus.split(",");
		String[] arrMng = mngs.split(",");
		String[] arrWrite = writes.split(",");
		String[] arrRead = reads.split(",");
		
	  System.out.println("flow log : arrMenu : " + arrMenu.length);
	  
		if(arrMenu != null && arrMenu.length > 0){
			for(int i=0;i<arrMenu.length; i++){
				SYMenuVo mVo = new SYMenuVo();
				mVo.setRole_cd(menuVo.getRole_cd());
				mVo.setMenu_div(menuVo.getMenu_div());
				mVo.setMenu_cd(arrMenu[i]);
				mVo.setMng_yn(arrMng[i]);
				mVo.setWrite_yn(arrWrite[i]);
				mVo.setRead_yn(arrRead[i]);
				mVo.setCreator(menuVo.getCreator());
				mVo.setUpdater(menuVo.getUpdater());
				
				result = menuDAO.insertMenuRole(mVo);
			}
		}
		return result; 
	}
	
	public int insertMenuRole(SYMenuVo menuVo){
		return menuDAO.deleteMenuRole(menuVo);
	}
	
}