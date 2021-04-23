package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;










//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.dao.SYKPIDAO;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYGoalVo;
import kr.co.passcombine.set.vo.SYKPI_OperationVo;
import kr.co.passcombine.set.vo.SYKPI_ProductVo;
import kr.co.passcombine.set.vo.SYKPI_PurchaseVo;
import kr.co.passcombine.set.vo.SYKPI_RepairVo;
import kr.co.passcombine.set.vo.SYKPI_SalesVo;
import kr.co.passcombine.set.vo.SYProductOperStatusVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;


@Service(value = "setKPIService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYKPIService {

	@Resource
	private Environment environment;
	 
	@Resource(name = "setKPIDAO")
	private SYKPIDAO dao;

	// Overhaul
	
	
	
	public List<SYKPI_RepairVo> selectRepair(SYKPI_RepairVo vo)
	{
		return dao.selectRepair(vo);
	}
	
	public List<SYKPI_RepairVo> selectRepairItem(SYKPI_RepairVo vo){
		return dao.selectRepairItem(vo);
	}
	public List<SYKPI_RepairVo> selectRepair2(SYKPI_RepairVo vo)
	{
		return dao.selectRepair2(vo);
	}
	public List<SYKPI_RepairVo> selectRepair3(SYKPI_RepairVo vo)
	{
		return dao.selectRepair3(vo);
	}
	
	public List<SYKPI_ProductVo> selectProduct(SYKPI_ProductVo vo)
	{
		return dao.selectProduct(vo);
	}
	
	public List<SYKPI_ProductVo> selectProduct2(SYKPI_ProductVo vo)
	{
		return dao.selectProduct2(vo);
	}
	
	public List<SYKPI_ProductVo> selectProduct3(SYKPI_ProductVo vo)
	{
		return dao.selectProduct3(vo);
	}
	
	
	
	
	public List<SYKPI_PurchaseVo> selectPurchaseList(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseList(vo);
	}
	

	public List<SYKPI_PurchaseVo> selectPurchaseList_total(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseList_total(vo);
	}
	

	public List<SYKPI_PurchaseVo> selectPurchaseList_in(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseList_in(vo);
	}
	

	public List<SYKPI_PurchaseVo> selectPurchaseList_no(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseList_no(vo);
	}
	
	
	
	public List<SYKPI_PurchaseVo> selectPurchaseGraph(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseGraph(vo);
	}
	
	
	//210112
	public List<SYKPI_PurchaseVo> selectPurchaseGraph_total(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseGraph_total(vo);
	}
	
	public List<SYKPI_PurchaseVo> selectPurchaseGraph_in(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseGraph_in(vo);
	}
	
	public List<SYKPI_PurchaseVo> selectPurchaseGraph_no(SYKPI_PurchaseVo vo)
	{
		return dao.selectPurchaseGraph_no(vo);
	}
	

	public List<SYPurchaseOrderDetailVo> selectPurchaseSearch(SYPurchaseOrderDetailVo vo)
	{
		return dao.selectPurchaseSearch(vo);
	}
	
	
	public List<SYKPI_SalesVo> selectSalesSearch(SYKPI_SalesVo vo)
	{
		return dao.selectSalesSearch(vo);
	}
	public List<SYKPI_SalesVo> selectSalesGrid(SYKPI_SalesVo vo)
	{
		return dao.selectSalesGrid(vo);
	}

	public List<SYKPI_SalesVo> selectSalesGraph(SYKPI_SalesVo vo)
	{
		return dao.selectSalesGraph(vo);
	}

	public List<SYKPI_SalesVo> selectSalesGrid2(SYKPI_SalesVo vo)
	{
		return dao.selectSalesGrid2(vo);
	}
	
	public List<SYKPI_SalesVo> selectSalesGraph_no(SYKPI_SalesVo vo)
	{
		return dao.selectSalesGraph_no(vo);
	}

	public List<SYKPI_SalesVo> selectSalesGrid2_no(SYKPI_SalesVo vo)
	{
		return dao.selectSalesGrid2_no(vo);
	}

	public List<SYKPI_SalesVo> selectSalesGraph_ju(SYKPI_SalesVo vo)
	{
		return dao.selectSalesGraph_ju(vo);
	}
	public List<SYKPI_SalesVo> selectSalesGrid2_ju(SYKPI_SalesVo vo)
	{
		return dao.selectSalesGrid2_ju(vo);
	}
	
	public List<SYKPI_OperationVo> selectOperation(SYKPI_OperationVo vo)
	{
		return dao.selectOperation(vo);
	}
	
	public List<SYKPI_OperationVo> selectOperation_2(SYKPI_OperationVo vo)
	{
		return dao.selectOperation_2(vo);
	}
	
	public List<SYProductOperStatusVO> selectOperation_real(SYProductOperStatusVO vo)
	{
		return dao.selectOperation_real(vo);
	}
	
	
	public List<SYKPI_PurchaseVo> purchaseGrid(SYKPI_PurchaseVo vo)
	{
		return dao.purchaseGrid(vo);
	}
	
	
	public List<SYKPI_PurchaseVo> purchaseGrid_in(SYKPI_PurchaseVo vo)
	{
		return dao.purchaseGrid_in(vo);
	}
	
	public List<SYCustomerVo> selectCustomerIntergration(SYCustomerVo vo)
	{
		return dao.selectCustomerIntergration(vo);
	}
	
	
	//1218
	public List<SYGoalVo> selectOperation_second(SYProductOperStatusVO vo)
	{
		return dao.selectOperation_second(vo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
