package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import kr.co.passcombine.set.vo.SYFileVo;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYPurchaseOrderVo;
import kr.co.passcombine.set.vo.SYWareHouseRawVo;
import kr.co.passcombine.set.vo.SYWareHousingVo;
import kr.co.passcombine.set.vo.SYWarehouseOutVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterDVo;
import kr.co.passcombine.set.vo.SYWarehouse_MasterHVo;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;



@Repository(value = "setWarehousingDAO")
public interface SYWarehousingDAO {
	
	public String selectLastDate(SYWareHousingVo vo);
	public String selectFileKey();
	
	/*
	 * 
	 *  해야할 것 
	 * 1. warehousing_tbl         	-> insert 
	 * 2. purchase_order_master   	-> purchase_status update
	 * 3. purchase_order_detail		-> purchase_end_date, in_menge update
	 * 4. warehouse_raw_tbl 		-> insert
	 * 
	 */

	// Warehousing
	public List<SYWareHousingVo> selectWarehousing(SYWareHousingVo vo);
	public List<SYWareHousingVo> selectWarehousingMng(SYWareHousingVo vo);
	public List<SYWareHousingVo> selectWarehousingMngEtc(SYWareHousingVo vo);
	
	public List<SYWareHousingVo> selectWarehouseHis(SYWareHousingVo vo);
	
	public int insFileInfo(SYWareHousingVo vo);
	
	public int modFileInfo(SYWareHousingVo vo);
	
	public int insertWarehousing(SYWareHousingVo vo);

	public int deleteWarehousing(SYWareHousingVo vo);
	
	
	// purchase
	// 마스터 정보 
	public List<SYPurchaseOrderVo> selectPurchaseOrder(SYPurchaseOrderVo vo);
	// 디테일 정보 
	public List<SYPurchaseOrderDetailVo> selectPurchaseOrderDetail(SYPurchaseOrderDetailVo vo);
	
	public int updatePurchaseOrder(SYPurchaseOrderVo vo);
	
	public int updatePurchaseOrderDetail(SYPurchaseOrderDetailVo vo);
	
	public int updatePurchaseOrderDetail_minus(SYPurchaseOrderDetailVo vo);
	
	// WarehouseRaw
	
	public String selectWarehouseRawLastSeq(SYWareHouseRawVo vo);
	
	public List<SYWareHouseRawVo> selectWarehouseRaw(SYWareHouseRawVo vo);
	
	public List<SYWareHouseRawVo> selectWarehouseRawPartition(SYWareHouseRawVo vo);
	
	public int insertWarehouseRaw(SYWareHouseRawVo vo);
	
	public int updateWarehouseRawFile(SYWareHouseRawVo vo);
	
	public int deleteWarehouseRaw(SYWareHouseRawVo vo);
	
	public int updateWarehouseRawStatus(SYWareHouseRawVo vo);
	
	
	public int updateProductRawStatus(SYProductVO vo);
	
	
	// Warehouse
	
	public int insertWarehouse(SYWarehouseVo vo);
	
	public int saveWarehouse(SYWarehouseVo vo);
	
	
	public int deleteWarehouse(SYWarehouseVo vo);
	public int plusWarehouse(SYWarehouseVo vo);
	public int minusWarehouse(SYWarehouseVo vo);
	public List<SYWareHouseRawVo> selectWarehouseRawMng(SYWareHouseRawVo vo);
	
	
	
	// warehout out
	
	
	public List<SYWarehouseOutVo> selectWarehouseOut(SYWarehouseOutVo vo);
	
	public int saveWarehouseOut(SYWarehouseOutVo vo);
	
	
	
	
	
}
