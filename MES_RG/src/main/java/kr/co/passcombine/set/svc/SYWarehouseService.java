package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;







import kr.co.passcombine.set.dao.SYWarehouseDAO;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterDVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterHVo;





//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;



@Service(value = "setWarehouseService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYWarehouseService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setWarehouseDAO")
	private SYWarehouseDAO WarehouseDAO;

	// master
	public List<SYWarehouse_MasterHVo> selectWarehouse_master_header(SYWarehouse_MasterHVo vo) {
		return WarehouseDAO.selectWarehouse_master_header(vo);
	}

	public int insertWarehouse_master_header(SYWarehouse_MasterHVo vo) {
		return WarehouseDAO.insertWarehouse_master_header(vo);
	}

	public int updateWarehouse_master_header(SYWarehouse_MasterHVo vo) {
		return WarehouseDAO.updateWarehouse_master_header(vo);
	}

	public int deleteWarehouse_master_header(SYWarehouse_MasterHVo vo) {
		return WarehouseDAO.deleteWarehouse_master_header(vo);
	}
	
	public int deleteWarehouse_master_detail(SYWarehouse_MasterHVo vo) {
		return WarehouseDAO.deleteWarehouse_master_detail(vo);
	}

	// detail
	public List<SYWarehouse_MasterDVo> selectWarehouse_master_detail(SYWarehouse_MasterDVo vo) {
		return WarehouseDAO.selectWarehouse_master_detail(vo);
	}
	
	public int allDeleteWarehouse_master_detail(SYWarehouse_MasterDVo vo) {
		return WarehouseDAO.allDeleteWarehouse_master_detail(vo);
	}

	public int saveWarehouse_master_detail(List<SYWarehouse_MasterDVo> list,
			SYWarehouse_MasterDVo vo) {

		int result = 0;
		int flag = 0;
		
		for(int i=0 ; i<list.size() ; i++)
		{
			// ????????? ????????? ?????? ?????? ??????? ?????? ?????? ??????
			// ????????? ?????? ???????????? ????????? ??????? return
			String warehouse_code = list.get(i).getWarehouse_code(); // ????????? ?????????????????? ????????? ???????????? 
			String item_type_code = list.get(i).getItem_type_code(); // ????????? ??????????????? ????????? ???????????? 
			String codeValue = WarehouseDAO.inCheckWarehouse_master_detail(item_type_code); 
			
			if( codeValue != null /*!codeValue.equals("")*/ ) { // code?????? ?????? ??? ?????????
				// ?????? ???????????? ????????? ????????? ??? ????????? ?????? ??????
				
				if( !codeValue.equals(warehouse_code) ) { // ?????? ????????? ??? ????????? ?????? ?????? 
					vo.setWarehouse_code(codeValue);
					vo.setItem_type_code(item_type_code); // ?????? ?????? ?????? ???????????? ??????
					int chk = WarehouseDAO.deleteWarehouse_master_detail(vo);
					System.out.println("chk = " + chk);
					vo.setItem_type_code("");
					
					result = WarehouseDAO.insertWarehouse_master_detail(list.get(i));
				}
				
			} else { // code?????? ?????????
				result = WarehouseDAO.insertWarehouse_master_detail(list.get(i));
			}
		}
		
		return result;
	}

	public List<SYWarehouseVo> selectWarehouse(SYWarehouseVo vo) {
		return WarehouseDAO.selectWarehouse(vo);
	}
	
	public List<SYWarehouseVo> selectMaterialBan(SYWarehouseVo vo) {
		return WarehouseDAO.selectMaterialBan(vo);
	}

	public List<SYWarehouseVo> selectWarehouse2(SYWarehouseVo vo) {
		return WarehouseDAO.selectWarehouse2(vo);
	}
}
