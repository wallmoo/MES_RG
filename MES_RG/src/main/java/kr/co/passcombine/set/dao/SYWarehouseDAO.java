package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterDVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterHVo;

import org.springframework.stereotype.Repository;



@Repository(value = "setWarehouseDAO")
public interface SYWarehouseDAO {

	/**
	 * 수빈
	 * 
	 */
	
	// Warehouse master
	List<SYWarehouse_MasterHVo> selectWarehouse_master_header( SYWarehouse_MasterHVo vo);

	int insertWarehouse_master_header(SYWarehouse_MasterHVo vo);

	int updateWarehouse_master_header(SYWarehouse_MasterHVo vo);

	int deleteWarehouse_master_header(SYWarehouse_MasterHVo vo);
	
	int deleteWarehouse_master_detail(SYWarehouse_MasterHVo vo);

	// Warehouse detail
	List<SYWarehouse_MasterDVo> selectWarehouse_master_detail(SYWarehouse_MasterDVo vo);
	
	int insertWarehouse_master_detail( SYWarehouse_MasterDVo syWarehouse_MasterDVo);
	
	int allDeleteWarehouse_master_detail(SYWarehouse_MasterDVo vo);

	String inCheckWarehouse_master_detail(String warehouse_code);

	int deleteWarehouse_master_detail(SYWarehouse_MasterDVo vo);

	// Warehouse
	List<SYWarehouseVo> selectWarehouse(SYWarehouseVo vo);
	List<SYWarehouseVo> selectWarehouse2(SYWarehouseVo vo);

	
	
	List<SYWarehouseVo> selectMaterialBan(SYWarehouseVo vo);
	
	
	
}
