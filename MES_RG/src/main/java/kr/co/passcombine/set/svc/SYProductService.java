package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;



























import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.controller.FrontendController;
import kr.co.passcombine.set.dao.SYInfoDAO;
import kr.co.passcombine.set.dao.SYInspDAO;
import kr.co.passcombine.set.dao.SYOrderDAO;
import kr.co.passcombine.set.dao.SYProductDAO;
import kr.co.passcombine.set.dao.SYWarehousingDAO;
import kr.co.passcombine.set.util.SessionUtil;
import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
//import kr.co.passcombine.changwon.vo.SYLineVo;
//import kr.co.passcombine.changwon.vo.SYProdVo;
//import kr.co.passcombine.changwon.vo.SYScmRawSernrVo;
//import kr.co.passcombine.changwon.vo.SYSernrManageVo;
//import kr.co.passcombine.changwon.vo.SYHubItnbrVo;
//import kr.co.passcombine.changwon.vo.SYMenuVo;
//import kr.co.passcombine.changwon.vo.SYMesVo;
//import kr.co.passcombine.changwon.vo.SYPoRequirementVo;
//import kr.co.passcombine.changwon.vo.SYProdVo;
//import kr.co.passcombine.changwon.vo.SYScmRawDeliveryVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYInspVO;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYItem_fairVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYProductAnalysisVO;
import kr.co.passcombine.set.vo.SYProductMonitoringVO;
import kr.co.passcombine.set.vo.SYProductOperStatusVO;
import kr.co.passcombine.set.vo.SYProductOperationVO;
import kr.co.passcombine.set.vo.SYProductUnOperationVO;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYQualityVo;
import kr.co.passcombine.set.vo.SYWareHouseRawVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;


@Service(value = "setProductService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYProductService {
	private static final Logger logger = LoggerFactory
			.getLogger(FrontendController.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "setProductDAO")
	private SYProductDAO dao;

	@Resource(name = "setInspDAO")
	private SYInspDAO inspDAO;
	
	@Resource(name = "setInfoDAO")
	private SYInfoDAO infoDAO;
	

	@Resource(name = "setWarehousingDAO")
	private SYWarehousingDAO wDAO;
	
	
	public String selectOrderNum()
	{
		return dao.selectOrderNum();
	}

	public List<SYRoutingMasterVo> selectRouting_master(SYRoutingMasterVo vo) {
		return dao.selectRouting_master(vo);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveProductProcess(List<SYProductVO> list)
	{
		int result = 0;
		
		
		
		
		/*
		 * product_tbl insert ( routing_code 제외)
		 * 
		 * 
		 * rounting_master에 등록된 제품 공정만큼 반복문 
		 * product_operation_tbl insert 
		 * 
		 * 
		 */
		for(int i =0; i<list.size(); i++)
		{
			SYProductVO pVo = list.get(i);
			String item_code = pVo.getItem_code();
			String product_po = pVo.getProduct_po();
			if("".equals(product_po) || product_po == null){
				product_po = dao.selectOrderNum();
			}
			pVo.setProduct_class("o");
			pVo.setProduct_po(product_po);
			dao.saveProduct(pVo);
			
			
			
			SYRoutingMasterVo rVo = new SYRoutingMasterVo();
			rVo.setItem_code(item_code);
			List<SYRoutingMasterVo> routingList = dao.selectRouting_master(rVo);
			
			for(int j=0; j<routingList.size(); j++)
			{
				
				SYProductOperationVO poVo = new SYProductOperationVO();
				
				poVo.setProduct_po(product_po);
				poVo.setRouting_code(routingList.get(j).getRouting_code());
				poVo.setRouting_seq(routingList.get(j).getRouting_seq());
				poVo.setRouting_nm(routingList.get(j).getRouting_nm());
				poVo.setRouting_gubun(routingList.get(j).getRouting_gubun());
				poVo.setOutsourcing_gubun(routingList.get(j).getOutsourcing_gubun());
				poVo.setMachine_gubun(routingList.get(j).getMachine_gubun());
				poVo.setWarehouse_gubun(routingList.get(j).getWarehouse_gubun());
				poVo.setReal_seq((j+1)+"");
				
				/*
				 * poVo Setting 
				 */
				
				dao.saveProductOperation(poVo);
			}
			
		}	
		return result;
	}
	
	@Transactional
	public List<SYProductOperStatusVO> selectProductOperStatus(SYProductOperStatusVO vo){
		//return dao.selectProductOperStatus(vo);
		return dao.selectProductOperStatus_real(vo);
	}
	
	@Transactional
	public List<SYProductOperStatusVO> selectProductOperStatus_2(SYProductOperStatusVO vo){
		return dao.selectProductOperStatus_2(vo);
	}
	
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int reSaveProductProcess(List<SYProductVO> list, String parent_product_po)
	{
		
		int result = 0;
		
		SYProductVO parentPVo = new SYProductVO();
		parentPVo.setProduct_po(parent_product_po);
		dao.deleteProduct(parentPVo);
	
		
		SYProductOperationVO parentPdVo = new SYProductOperationVO();
		parentPdVo.setProduct_po(parent_product_po);
		dao.deleteProductOperation(parentPdVo);
		
		for(int i =0; i<list.size(); i++)
		{
			SYProductVO pVo = list.get(i);
			String item_code = pVo.getItem_code();
			String product_po = pVo.getProduct_po();
			pVo.setProduct_po(product_po);
			dao.saveProduct(pVo);
			
			
			
			SYRoutingMasterVo rVo = new SYRoutingMasterVo();
			rVo.setItem_code(item_code);
			List<SYRoutingMasterVo> routingList = dao.selectRouting_master(rVo);
			
			for(int j=0; j<routingList.size(); j++)
			{
				
				SYProductOperationVO poVo = new SYProductOperationVO();
				
				poVo.setProduct_po(product_po);
				poVo.setRouting_code(routingList.get(j).getRouting_code());
				poVo.setRouting_seq(routingList.get(j).getRouting_seq());
				poVo.setRouting_nm(routingList.get(j).getRouting_nm());
				poVo.setRouting_gubun(routingList.get(j).getRouting_gubun());
				poVo.setOutsourcing_gubun(routingList.get(j).getOutsourcing_gubun());
				poVo.setMachine_gubun(routingList.get(j).getMachine_gubun());
				poVo.setWarehouse_gubun(routingList.get(j).getWarehouse_gubun());
				poVo.setReal_seq((j+1)+"");
				
				
				/*
				 * poVo Setting 
				 */
				
				dao.saveProductOperation(poVo);
			}
			
		}	
		
		return result;
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveProductDirect(SYProductVO pVo)
	{
		int result = 0;
		
		String product_po = pVo.getProduct_po();
		String item_code = pVo.getItem_code();
		if("".equals(product_po) || product_po == null){
			product_po = dao.selectOrderNum();
		}
		pVo.setProduct_class("f");
		pVo.setProduct_po(product_po);
		dao.saveProduct(pVo);
		
		SYRoutingMasterVo rVo = new SYRoutingMasterVo();
		rVo.setItem_code(item_code);
		List<SYRoutingMasterVo> routingList = dao.selectRouting_master(rVo);
		
		for(int j=0; j<routingList.size(); j++)
		{
			
			SYProductOperationVO poVo = new SYProductOperationVO();
			
			poVo.setProduct_po(product_po);
			poVo.setRouting_code(routingList.get(j).getRouting_code());
			poVo.setRouting_seq(routingList.get(j).getRouting_seq());
			poVo.setRouting_nm(routingList.get(j).getRouting_nm());
			poVo.setRouting_gubun(routingList.get(j).getRouting_gubun());
			poVo.setOutsourcing_gubun(routingList.get(j).getOutsourcing_gubun());
			poVo.setMachine_gubun(routingList.get(j).getMachine_gubun());
			poVo.setWarehouse_gubun(routingList.get(j).getWarehouse_gubun());
			poVo.setReal_seq((j+1)+"");
			/*
			 * poVo Setting 
			 */
			
			dao.saveProductOperation(poVo);
			
		}
		
		return result;
	}
	
	
	public List<SYProductVO> selectProduct(SYProductVO vo) {
		return dao.selectProduct(vo);
	}
	
	public List<SYProductVO> selectProduct_one(SYProductVO vo) {
		return dao.selectProduct_one(vo);
	}
	
	public List<SYProductVO> selectProduct_V1(SYProductVO vo) {
		return dao.selectProduct_V1(vo);
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateProductDateProcess(List<SYProductVO> list)
	{
		int result = 0;
		
		for(int i =0; i<list.size(); i++)
		{
			SYProductVO pVo = list.get(i);
			dao.updateProductDate(pVo);
		}
		
		return result;
	}
	public int updateProductDate(SYProductVO vo){
		return dao.saveProduct(vo);
	}
	
	public int saveProduct(SYProductVO vo){
		return dao.saveProduct(vo);
	}
	
	public int deleteProduct(SYProductVO vo) {
		return dao.deleteProduct(vo);
	}
	
	
	public List<SYWarehouseVo> selectProductPlanNow(SYWarehouseVo vo) {
		return dao.selectProductPlanNow(vo);
	}

	//Product Operation
	public List<SYProductOperationVO> selectProductOperation(SYProductOperationVO vo) {
		return dao.selectProductOperation(vo);
	}
	
	public List<SYProductOperationVO> selectProductOperation_V1(SYProductOperationVO vo) {
		return dao.selectProductOperation_V1(vo);
	}

	public SYProductOperationVO selectProductOperationStatus(SYProductOperationVO vo) {
		return dao.selectProductOperationStatus(vo);
	}
		
	public int saveProductOperation(SYProductOperationVO vo){
		return dao.saveProductOperation(vo);
	}
	
	public int deleteProductOperation(SYProductOperationVO vo) {
		return dao.deleteProductOperation(vo);
	}
	
	public int updateProductOperation(SYProductOperationVO vo)
	{
		return dao.updateProductOperation(vo);
	}
	
	public List<SYProductOperationVO> selectOutSourcing(SYProductOperationVO vo) {
		return dao.selectOutSourcing(vo);
	}
	public List<SYProductOperationVO> selectOutSourcingAll(SYProductOperationVO vo) {
		return dao.selectOutSourcingAll(vo);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateProductOperationOS_REQ(SYProductOperationVO vo){
		
		int result = 0;
		
		String status = "i";
		
		SYProductVO pVo = new SYProductVO();
		pVo.setProduct_po(vo.getProduct_po());	
		pVo.setProduct_status_info(status);
		pVo.setRouting_code(vo.getRouting_code());
		pVo.setUpdater(vo.getUpdater());
		pVo.setProduct_status(status);
		dao.updateProductStatus(pVo);
		
		dao.updateProductOperationOS_REQ(vo);
		
		return result;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateProductOperationOS_END(SYProductOperationVO vo){
		
		int result = 0;
		
		String status = "e";
		
		SYProductVO pVo = new SYProductVO();
		pVo.setProduct_po(vo.getProduct_po());	
		pVo.setProduct_status_info(status);
		pVo.setRouting_code(vo.getRouting_code());
		
		pVo.setUpdater(vo.getUpdater());
		dao.updateProductStatus(pVo);
		
		dao.updateProductOperationOS_END(vo);
		
		String warehouse_gubun = vo.getWarehouse_gubun();
		logger.debug("warehouse_gubun : " + warehouse_gubun);
		if("b".equals(warehouse_gubun))
		{
			SYInspVO iVo = new SYInspVO();
			iVo.setProduct_po(vo.getProduct_po());
			iVo.setRouting_code(vo.getRouting_code());
			
			inspDAO.instWarehousingInfo(iVo);
			int warehouseQty = inspDAO.selecWarehouseInfo(iVo);
			iVo.setWarehousing_qty(warehouseQty);
			inspDAO.instWarehouseInfo(iVo);
		}
		
		
		return result;
	}
	
	
	//Product UnOperation
	public List<SYProductUnOperationVO> selectProductUnOperation(SYProductUnOperationVO vo) {
		return dao.selectProductUnOperation(vo);
	}
	
	public List<SYProductUnOperationVO> selectProductUnOperation_V1(SYProductUnOperationVO vo) {
		return dao.selectProductUnOperation_V1(vo);
	}
	
	
	public int saveProductUnOperation(SYProductUnOperationVO vo){
		return dao.saveProductUnOperation(vo);
	}
	
	public int deleteProductUnOperation(SYProductUnOperationVO vo) {
		return dao.deleteProductUnOperation(vo);
	}
	
	public int updateProductUnOperation(SYProductUnOperationVO vo)
	{
		return dao.updateProductUnOperation(vo);
	}
	
	
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateProductOperationProcess(SYProductOperationVO vo)
	{
		int result = 0;
		
		/**
		 * ProductOperation 상태값 
		 * 진행상태 대기 n / 작업시작 i / 비가동시작 us / 비가동종료 ue / 작업종료 e
		 * 
		 */
		
		SYProductOperationVO statusVo = dao.selectProductOperationStatus(vo);
		
	//	String currentStatus = statusVo.getStatus();
		String currentStatus = vo.getStatus();
		/**
		 * 
		 * 1. i(작업시작)		
		 * product_tbl status = i 로 변경
		 * product_operation_tbl status = us / member정보 / prod_str_time update
		 * 
		 * 2. us(비가동시작)	
		 * product_operation_tbl status = us
		 * product_unoperation_tbl insert
		 * 
		 * 3. ue(비가동종료)
		 * product_operation_tbl status = ue
		 * product_unoperation_tbl update
		 * 
		 * 4. e(작업종료)
		 * product_operation_tbl status = e / member정보 / prod_end_time update
		 * 
		 * 5. y(작업종료)
		 * product_tbl status = y / product_date update
		 * 
		 */


		if("i".equals(currentStatus) && !"".equals(vo.getMachine_code()))
		{
			SYMachineVO mVo = new SYMachineVO();
			mVo.setMachine_code(vo.getMachine_code());
			String cnt = infoDAO.selectMachine_waiting_check(mVo);
			
			if( Integer.parseInt(cnt) > 0)
			{
				return 999;
			}
		}
		
		if("ue".equals(currentStatus) && !"".equals(vo.getMachine_code()))
		{
			SYMachineVO mVo = new SYMachineVO();
			mVo.setMachine_code(vo.getMachine_code());
			String cnt = infoDAO.selectMachine_waiting_check(mVo);
			
			if( Integer.parseInt(cnt) > 0)
			{
				return 888;
			}
		}
		
	
		
		SYProductVO pVo = new SYProductVO();
		pVo.setProduct_po(vo.getProduct_po());	
		pVo.setProduct_status_info(vo.getStatus());
		pVo.setRouting_code(vo.getRouting_code());
		pVo.setUpdater(vo.getUpdater());
		
		if("i".equals(currentStatus))
		{

			pVo.setProduct_status(vo.getStatus());
			dao.updateProductStatus(pVo);
			
			vo.setProd_str_time("GO");
			dao.updateProductOperationInfo(vo);
			
			/*************************** 수입검사 시작 : start ***************************/
						
			SYInspVO iVo = new SYInspVO();
			
			iVo.setProduct_po(vo.getProduct_po());
			iVo.setRouting_code(vo.getRouting_code());
			iVo.setUpdater(vo.getUpdater());
			if(iVo.getProduct_po().substring(0, 1).equals("S")){
				
				int flag = inspDAO.suipStrtRtngChk(iVo);	// 1이면 첫번째 라우팅.. 0이면 첫번째 라우팅이 아님
				
				System.out.println("************** flag");
				System.out.println(flag);
				
				if(flag == 1)
				{
					iVo.setPurchase_status("I");
					int rst = inspDAO.savePrcInsp(iVo);	
				}
			}
			/*************************** 수입검사 시작 : end ***************************/
		}
		
		if("us".equals(currentStatus))
		{
			dao.updateProductStatus(pVo);	
			
			dao.updateProductOperationInfo(vo);
			
			
			SYProductUnOperationVO puoVo = new SYProductUnOperationVO();
			
			puoVo.setProduct_po(vo.getProduct_po());
			puoVo.setRouting_code(vo.getRouting_code());
			puoVo.setMember_emp_no(vo.getMember_emp_no());
			puoVo.setMember_nm(vo.getMember_nm());
			puoVo.setUnprod_str_time("GO");
			puoVo.setUpdater(vo.getUpdater());
			//dao.saveProductUnOperation(puoVo);
			
			dao.insertProductUnOperation(puoVo);
		}
		
		if("ue".equals(currentStatus))
		{

			dao.updateProductStatus(pVo);
			
			
			dao.updateProductOperationInfo(vo);
			
			
			SYProductUnOperationVO puoVo = new SYProductUnOperationVO();
			
			puoVo.setProduct_po(vo.getProduct_po());
			puoVo.setRouting_code(vo.getRouting_code());
			puoVo.setMember_emp_no(vo.getMember_emp_no());
			puoVo.setMember_nm(vo.getMember_nm());
			puoVo.setUnprod_comment(vo.getUnprod_comment());
			puoVo.setUnprod_end_time("GO");
			puoVo.setUpdater(vo.getUpdater());
			//dao.saveProductUnOperation(puoVo);
			
			String seq = dao.selectProductUnOperationSeq(puoVo);
			puoVo.setUnoperation_seq(seq);
			dao.updateProductUnOperation(puoVo);
		}
		
		if("e".equals(currentStatus))
		{

			dao.updateProductStatus(pVo);
			
			
			vo.setProd_end_time("GO");
			
			dao.updateProductOperationInfo(vo);
			
			
			String warehouse_gubun = vo.getWarehouse_gubun();
			
			if("b".equals(warehouse_gubun))
			{
				SYInspVO iVo = new SYInspVO();
				iVo.setProduct_po(vo.getProduct_po());
				iVo.setRouting_code(vo.getRouting_code());
				
				inspDAO.instWarehousingInfo(iVo);
				int warehouseQty = inspDAO.selecWarehouseInfo(iVo);
				iVo.setWarehousing_qty(warehouseQty);
				inspDAO.instWarehouseInfo(iVo);
			}
			
			
			
	
			
		}
		if("y".equals(currentStatus))
		{

			pVo.setProduct_status(vo.getStatus());
			pVo.setProduct_date("GO");
			dao.updateProductStatus(pVo);
			
			
		}
	
		
		return result;
	}
	
	
	
	
	
	
	public List<SYProductVO> selectProductMonitoring(SYProductVO vo) {
		return dao.selectProductMonitoring(vo);
	}
	public List<SYProductVO> selectProductMonitoring2(SYProductVO vo) {
		return dao.selectProductMonitoring2(vo);
	}
	
	// LOT 추적 	
	public List<SYProductOperationVO> selectLot(SYProductOperationVO vo) {
		return dao.selectLot(vo);
	}
	
	public List<SYWareHouseRawVo> selectLot2(SYWareHouseRawVo vo) {
		return dao.selectLot2(vo);
	}
	
	public List<SYProductOperationVO> selectLot3(SYProductOperationVO vo) {
		return dao.selectLot3(vo);
	}
	
	
	
	public List<SYItem_fairVo> selectItemFair(SYItem_fairVo vo) {
		return dao.selectItemFair(vo);
	}
	public List<SYItem_fairVo> selectItemFair_graph(SYItem_fairVo vo) {
		return dao.selectItemFair_graph(vo);
	}
	
	
	public List<SYProductVO> selectProductItem(SYProductVO vo) {
		return dao.selectProductItem(vo);
	}
	
	
	
	@Transactional
	public List<SYProductOperStatusVO> selectProductOperStatus_real(SYProductOperStatusVO vo){
		
		
		// 변경할 데이터 
		List<SYProductOperStatusVO> realList = new ArrayList<SYProductOperStatusVO>();
		
		// 원본데이터 
		List<SYProductOperStatusVO> dataList = dao.selectProductOperStatus_real(vo);
		
		

		
		realList = dataList;
		
		
		
		
		return realList;
	}
	
	
	//1222
	public List<SYProductAnalysisVO> selectProductAnalysis(SYProductAnalysisVO vo){
		//return dao.selectProductOperStatus(vo);
		return dao.selectProductAnalysis(vo);
	}
	
	
	public List<SYProductOperationVO> selectMonitorAccount(SYProductOperationVO vo) {
		return dao.selectMonitorAccount(vo);
	}
	//1228
	public List<SYProductMonitoringVO> selectMonitoringList(SYProductMonitoringVO vo)
	{
		return dao.selectMonitoringList(vo);
	}
	
	public List<SYProductMonitoringVO> selectMonitoringGraph(SYProductMonitoringVO vo)
	{
		return dao.selectMonitoringGraph(vo);
	}
	
	public List<SYProductMonitoringVO> selectMonitoringListDown(SYProductMonitoringVO vo)
	{
		return dao.selectMonitoringListDown(vo);
	}
	
	
	//210122
	public int updateOutsourcing(SYProductOperationVO vo){
		return dao.updateOutsourcing(vo);
	}
	
	
	

}
