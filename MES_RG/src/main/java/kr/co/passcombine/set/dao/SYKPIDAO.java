package kr.co.passcombine.set.dao;

import java.util.List;

import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYGoalVo;
import kr.co.passcombine.set.vo.SYKPI_OperationVo;
import kr.co.passcombine.set.vo.SYKPI_ProductVo;
import kr.co.passcombine.set.vo.SYKPI_PurchaseVo;
import kr.co.passcombine.set.vo.SYKPI_RepairVo;
import kr.co.passcombine.set.vo.SYKPI_SalesVo;
import kr.co.passcombine.set.vo.SYMenuVo;
import kr.co.passcombine.set.vo.SYProductOperStatusVO;
import kr.co.passcombine.set.vo.SYRepairAnalysisVo;
import kr.co.passcombine.set.vo.SYRepairVo;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;

import org.springframework.stereotype.Repository;

@Repository(value = "setKPIDAO")
public interface SYKPIDAO {
	
	public List<SYKPI_RepairVo> selectMenu(SYKPI_RepairVo menuVo);
	public List<SYKPI_RepairVo> selectRepairItem(SYKPI_RepairVo vo);
	public List<SYKPI_RepairVo> selectRepair(SYKPI_RepairVo vo);
	public List<SYKPI_RepairVo> selectRepair2(SYKPI_RepairVo vo);
	public List<SYKPI_RepairVo> selectRepair3(SYKPI_RepairVo vo);
	
	public List<SYKPI_ProductVo> selectProduct(SYKPI_ProductVo vo);
	public List<SYKPI_ProductVo> selectProduct2(SYKPI_ProductVo vo);
	public List<SYKPI_ProductVo> selectProduct3(SYKPI_ProductVo vo);
	
	public List<SYKPI_PurchaseVo> selectPurchaseList(SYKPI_PurchaseVo vo);
	
	public List<SYKPI_PurchaseVo> selectPurchaseList_total(SYKPI_PurchaseVo vo);
	public List<SYKPI_PurchaseVo> selectPurchaseList_in(SYKPI_PurchaseVo vo);
	public List<SYKPI_PurchaseVo> selectPurchaseList_no(SYKPI_PurchaseVo vo);
	
	
	public List<SYKPI_PurchaseVo> selectPurchaseGraph(SYKPI_PurchaseVo vo);
	public List<SYPurchaseOrderDetailVo> selectPurchaseSearch(SYPurchaseOrderDetailVo vo);
	
	public List<SYKPI_PurchaseVo> selectPurchaseGraph_total(SYKPI_PurchaseVo vo);
	public List<SYKPI_PurchaseVo> selectPurchaseGraph_in(SYKPI_PurchaseVo vo);
	public List<SYKPI_PurchaseVo> selectPurchaseGraph_no(SYKPI_PurchaseVo vo);
	
	
	public List<SYKPI_SalesVo> selectSalesSearch(SYKPI_SalesVo vo);
	public List<SYKPI_SalesVo> selectSalesGrid(SYKPI_SalesVo vo);
	public List<SYKPI_SalesVo> selectSalesGraph(SYKPI_SalesVo vo);
	public List<SYKPI_SalesVo> selectSalesGrid2(SYKPI_SalesVo vo);
	
	public List<SYKPI_SalesVo> selectSalesGraph_no(SYKPI_SalesVo vo);
	public List<SYKPI_SalesVo> selectSalesGrid2_no(SYKPI_SalesVo vo);
	
	public List<SYKPI_SalesVo> selectSalesGraph_ju(SYKPI_SalesVo vo);
	public List<SYKPI_SalesVo> selectSalesGrid2_ju(SYKPI_SalesVo vo);
	public List<SYKPI_OperationVo> selectOperation(SYKPI_OperationVo vo);
	
	public List<SYProductOperStatusVO> selectOperation_real(SYProductOperStatusVO vo);
	
	public List<SYKPI_OperationVo> selectOperation_2(SYKPI_OperationVo vo);
	public List<SYKPI_PurchaseVo> purchaseGrid(SYKPI_PurchaseVo vo);
	
	public List<SYKPI_PurchaseVo> purchaseGrid_in(SYKPI_PurchaseVo vo);
	
	public List<SYCustomerVo> selectCustomerIntergration(SYCustomerVo vo);
	
	//1218
	public List<SYGoalVo> selectOperation_second(SYProductOperStatusVO vo);


}
