package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
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
import kr.co.passcombine.set.dao.SYProductDAO;
import kr.co.passcombine.set.dao.SYPurchaseOrderDAO;
import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYTBranchVo;
import kr.co.passcombine.set.vo.SYTClientVo;
import kr.co.passcombine.set.vo.SYTMaterialVo;
import kr.co.passcombine.set.vo.SYTProjectVo;
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
import kr.co.passcombine.set.vo.SYDeliveryOrderVo;
import kr.co.passcombine.set.vo.SYHoldVo;
import kr.co.passcombine.set.vo.SYIncome_insp_mstVo;
import kr.co.passcombine.set.vo.SYIncome_resultVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYInspectionMasterVo;
import kr.co.passcombine.set.vo.SYInstrumentVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYOrderVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYPrintVO;
import kr.co.passcombine.set.vo.SYProduct2Vo;
import kr.co.passcombine.set.vo.SYProductOperationVO;
import kr.co.passcombine.set.vo.SYProductUnOperationVO;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYPurchaseOrderDetailVo;
import kr.co.passcombine.set.vo.SYQualityVo;
import kr.co.passcombine.set.vo.SYRepairVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYTVendorVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYtool_repmt_hisVo;


@Service(value = "setInfoService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYInfoService {
	
	private static final Logger logger = LoggerFactory
			.getLogger(SYInfoService.class);

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "setInfoDAO")
	private SYInfoDAO infoDAO;
		
	@Resource(name = "setPurchaseOrderDAO")
	private SYPurchaseOrderDAO poDAO;
	
	public List<SYCustomerVo> selectCdD(SYCustomerVo vo) {
		return infoDAO.selectCdD(vo);
	}
	public List<SYCustomerVo> selectCdD_csmb(SYCustomerVo vo) {
		return infoDAO.selectCdD_csmb(vo);
	}
	
	// Customer
	public int checkCustomer(SYCustomerVo vo) {
		return infoDAO.checkCustomer(vo);
	}
	
	@Transactional
	public List<SYCustomerVo> selectCustomer(SYCustomerVo cVo){
		return infoDAO.selectCustomer(cVo);
	}

	public int insertCustomer(SYCustomerVo vo) {
		return infoDAO.insertCustomer(vo);
	}

	public int updateCustomer(SYCustomerVo vo) {
		return infoDAO.updateCustomer(vo);
	}
	
	public int deleteCustomer(SYCustomerVo vo) {
		return infoDAO.deleteCustomer(vo);
	}
	
	
	// Client Start
	public int checkClient(SYTClientVo vo) {
		return infoDAO.checkClient(vo);
	}		
	public List<SYTClientVo> selectClient(SYTClientVo cVo){
		return infoDAO.selectClient(cVo);
	}	
	public int insertClient(SYTClientVo vo) {
		return infoDAO.insertClient(vo);
	}	
	public int updateClient(SYTClientVo vo) {
		return infoDAO.updateClient(vo);
	}
	public int deleteClient(SYTClientVo vo) {
		return infoDAO.deleteClient(vo);
	}	
	// Client End
	
	// Vendor Start
	public int checkVendor(SYTVendorVo vo) {
		return infoDAO.checkVendor(vo);
	}	
	public List<SYTVendorVo> selectVendor(SYTVendorVo cVo){
		return infoDAO.selectVendor(cVo);
	}	
	public int insertVendor(SYTVendorVo vo) {
		return infoDAO.insertVendor(vo);
	}	
	public int updateVendor(SYTVendorVo vo) {
		return infoDAO.updateVendor(vo);
	}
	public int deleteVendor(SYTVendorVo vo) {
		return infoDAO.deleteVendor(vo);
	}	
	// Vendor End
	
	// Branch Start
	public int checkBranch(SYTBranchVo vo) {
		return infoDAO.checkBranch(vo);
	}		
	public List<SYTBranchVo> selectBranch(SYTBranchVo cVo){
		return infoDAO.selectBranch(cVo);
	}	
	public int insertBranch(SYTBranchVo vo) {
		return infoDAO.insertBranch(vo);
	}	
	public int updateBranch(SYTBranchVo vo) {
		return infoDAO.updateBranch(vo);
	}
	public int deleteBranch(SYTBranchVo vo) {
		return infoDAO.deleteBranch(vo);
	}	
	// Branch End	
	
	// Material Start
	public int checkMaterial(SYTMaterialVo vo) {
		return infoDAO.checkMaterial(vo);
	}	
	public List<SYTMaterialVo> selectMaterial(SYTMaterialVo vo) {
		return infoDAO.selectMaterial(vo);
	}	
	public int insertMaterial(SYTMaterialVo vo) {
		return infoDAO.insertMaterial(vo);
	}
	public int updateMaterial(SYTMaterialVo vo) {
		return infoDAO.updateMaterial(vo);
	}
	public int deleteMaterial(SYTMaterialVo vo) {
		return infoDAO.deleteMaterial(vo);
	}	
	
	public List<SYMaterialVo> excelLoad(SYMaterialVo vo) {
		return infoDAO.excelLoad(vo);
	}
	public Integer excelMax(SYMaterialVo vo) {
		return infoDAO.excelMax(vo);
	}
	public List<SYMaterialVo> selectMaterial2(SYMaterialVo vo) {
		return infoDAO.selectMaterial2(vo);
	}	
	public List<SYMaterialVo> selectMaterial3(SYMaterialVo vo) {
		return infoDAO.selectMaterial3(vo);
	}
	public int updateMaterial2(SYMaterialVo vo) {
		return infoDAO.updateMaterial2(vo);
	}	
	public List<SYMaterialVo> selectMaterial_menge(SYMaterialVo vo) {
		return infoDAO.selectMaterial_menge(vo);
	}
	public List<SYMaterialVo> selectItemCode(SYMaterialVo vo) {
		return infoDAO.selectItemCode(vo);
	}
	public List<SYMaterialVo> selectItemCode2(SYMaterialVo vo) {
		return infoDAO.selectItemCode2(vo);
	}
	public List<SYMaterialVo> selectItemCode3(SYMaterialVo vo) {
		return infoDAO.selectItemCode3(vo);
	}	
	// Material End
	
	// Project Start
	public int checkProject(SYTProjectVo vo) {
		return infoDAO.checkProject(vo);
	}		
	public List<SYTProjectVo> selectProject(SYTProjectVo cVo){
		return infoDAO.selectProject(cVo);
	}	
	public int insertProject(SYTProjectVo vo) {
		return infoDAO.insertProject(vo);
	}	
	public int updateProject(SYTProjectVo vo) {
		return infoDAO.updateProject(vo);
	}
	public int deleteProject(SYTProjectVo vo) {
		return infoDAO.deleteProject(vo);
	}	
	// Project End		
	
	
	// Account
	public int checkAccount(SYAccountVo vo) {
		return infoDAO.checkAccount(vo);
	}
	
	@Transactional
	//////////
	public List<SYAccountVo> selectAccount(SYAccountVo cVo){
		return infoDAO.selectAccount(cVo);
	}

	public int insertAccount(SYAccountVo vo) {
		return infoDAO.insertAccount(vo);
	}

	public int updateAccount(SYAccountVo vo) {
		return infoDAO.updateAccount(vo);
	}
	
	public int deleteAccount(SYAccountVo vo) {
		return infoDAO.deleteAccount(vo);
	}


	// cw 
	//partition
	public List<SYPartitionVO> selectPartition2(SYPartitionVO vo){
		return infoDAO.selectPartition2(vo);
	}
	//
	// jyp
	
	//partition
	public List<SYPartitionVO> selectPartition(SYPartitionVO vo){
		return infoDAO.selectPartition(vo);
	}
	
	public int insPartition(SYPartitionVO vo){
		return infoDAO.insPartition(vo);
	}
	
	public int updPartition(SYPartitionVO vo) {
		return infoDAO.updPartition(vo);
	}
	
	public int delPartition(SYPartitionVO vo) {
		return infoDAO.delPartition(vo);
	}
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int delPartitionAll(SYPartitionVO vo) {

		int result = 0;
		infoDAO.updPartition(vo);
		
		infoDAO.updPartitionDetail(vo);
		
		return result;
	}
	public List<SYPartitionVO> selectPartitionList(SYPartitionVO vo){
		return infoDAO.selectPartitionList(vo);
	}
	public List<SYPartitionVO> selectPartitionDetail(SYPartitionVO vo){
		return infoDAO.selectPartitionDetail(vo);
	}
	public int insPartitionDetail(Map<String, Object> params) {
		return infoDAO.insPartitionDetail(params);
	}
	public int updPartitionDetail(SYPartitionVO vo) {
		return infoDAO.updPartitionDetail(vo);
	}
	public List<SYMachineVO> selectMachine(SYMachineVO vo){
		return infoDAO.selectMachine(vo);
	}
	public int checkMachine(SYMachineVO vo) {
		return infoDAO.checkMachine(vo);
	}
	public int insMachine(SYMachineVO vo){
		return infoDAO.insMachine(vo);
	}
	public int updMachine(SYMachineVO vo) {
		return infoDAO.updMachine(vo);
	}
	public int delMachine(Map<String , Object> params) {
		return infoDAO.delMachine(params);
	}
	
	
	public List<SYMachineVO> selectMachine_waiting(SYMachineVO vo){
		return infoDAO.selectMachine_waiting(vo);
	}
	
	public String selectMachine_waiting_check(SYMachineVO vo){
		return infoDAO.selectMachine_waiting_check(vo);
	}
	
	public List<SYMachineVO> selectMachine_class(SYMachineVO vo){
		return infoDAO.selectMachine_class(vo);
	}
	
	
	
	//1113
	public List<SYMachineVO> selectMachine_nm(SYMachineVO vo){
		return infoDAO.selectMachine_nm(vo);
	}
	public int changeHold_Y(SYMachineVO vo) {
		return infoDAO.changeHold_Y(vo);
	}
	public int changeHold_N(SYMachineVO vo) {
		return infoDAO.changeHold_N(vo);
	}
	
	//일괄 HOLD
	public int changeHold_ALL_Y(SYMachineVO vo) {
		return infoDAO.changeHold_ALL_Y(vo);
	}
	public int changeHold_ALL_N(SYMachineVO vo) {
		return infoDAO.changeHold_ALL_N(vo);
	}
	
	

	@Resource(name = "setProductDAO")
	private SYProductDAO productDAO;
	
	
	// 1개 홀드 
	/*@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_Y(SYMachineVO vo ) 
	{
	
		int result = 0;
		infoDAO.changeHold_Y(vo);   //[1]
		
		SYProductOperationVO pVo = new SYProductOperationVO();
		pVo.setMachine_code( vo.getMachine_code() );
		
		List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
		
		String product_po = pList.get(0).getProduct_po();
		String routing_code = pList.get(0).getRouting_code();
		String routing_seq = pList.get(0).getRouting_seq();
		String real_seq = pList.get(0).getReal_seq();
		String status = pList.get(0).getStatus();
		String machine_code = pList.get(0).getMachine_code();
		String machine_nm = pList.get(0).getMachine_nm();
		String prod_str_time = pList.get(0).getProd_str_time();
		
		logger.debug("product_po : " + product_po);
		logger.debug("routing_code : " + routing_code);
		logger.debug("routing_seq : " + routing_seq);
		logger.debug("real_seq : " + real_seq);
		logger.debug("status : " + status);
		logger.debug("machine_code : " + machine_code);
		logger.debug("machine_nm : " + machine_nm);
		logger.debug("prod_str_time : " + prod_str_time);

		
		String hold_comment = vo.getHold_comment();
		
		SYHoldVo hVo = new SYHoldVo();
		
		hVo.setProduct_po(product_po);
		
		hVo.setRouting_code(routing_code);
		hVo.setRouting_seq(routing_seq);
		
		hVo.setReal_seq(real_seq);
		hVo.setPrev_status(status);
		hVo.setMachine_code(machine_code);
		hVo.setMachine_nm(machine_nm);
		
		hVo.setProd_str_time(prod_str_time);
	
		hVo.setHold_comment(hold_comment);
		//hVo.setDel_yn(del_yn);
		
		hVo.setCreator(vo.getUpdater());
		hVo.setUpdater(vo.getUpdater());
		
		
		infoDAO.insertHold(hVo);
		
		
		SYProductVO productVo = new SYProductVO();
		productVo.setProduct_po(product_po);
		productVo.setProduct_status_info("h");
		
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateProductHold(productVo);
		
		
		SYProductOperationVO pVo1 = new SYProductOperationVO();
		pVo1.setProduct_po(product_po);
		pVo1.setRouting_code(routing_code);
		pVo1.setStatus("h");
		
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateOperationHold(pVo1);
		
		return 0 ;
	}*/
	
	// 1개 홀드 해제
	/*@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_N(SYMachineVO vo ) 
	{
		
		*//**
		 * 
		 *  홀드 처리시 
		 *  1. machine_master 에서 해당 장비  hold_yn = 'N' 
		 *  
		 *  2. selectHoldStatus 이용해서 해당 장비의 최신 정보를 긁어옴 
		 *  
		 *  3.product_machine_hold_tbl update ( hold_end_time )
		 *  
		 *  -------------------------------------------------------------------------------
		 *  3. product_tbl 에 product_status_info =  i || ue 로 변경 (원래상태)
		 *  
		 *  4. product_operation_tbl 에  status = i || ue  로 변경 (원래상태)
		 *//*
		
		
		int result = 0;
		infoDAO.changeHold_N(vo);   //[1]
		
		SYProductOperationVO pVo = new SYProductOperationVO();
		pVo.setMachine_code( vo.getMachine_code() );
		
		List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
		
		String product_po = pList.get(0).getProduct_po();
		String routing_code = pList.get(0).getRouting_code();
		String routing_seq = pList.get(0).getRouting_seq();
		String real_seq = pList.get(0).getReal_seq();
		String machine_code = pList.get(0).getMachine_code();
		String machine_nm = pList.get(0).getMachine_nm();
		String prod_str_time = pList.get(0).getProd_str_time();
		
		logger.debug("product_po : " + product_po);
		logger.debug("routing_code : " + routing_code);
		logger.debug("routing_seq : " + routing_seq);
		logger.debug("real_seq : " + real_seq);
		logger.debug("machine_code : " + machine_code);
		logger.debug("machine_nm : " + machine_nm);
		logger.debug("prod_str_time : " + prod_str_time);

		
	
	
		SYHoldVo hVo = new SYHoldVo();
		
		hVo.setProduct_po(product_po);
		hVo.setMachine_code(machine_code);
	
		SYHoldVo result_hVo = infoDAO.selectMachineHold(hVo);
		
		hVo.setHold_seq(result_hVo.getHold_seq());
		hVo.setCreator(vo.getUpdater());
		hVo.setUpdater(vo.getUpdater());
		
		infoDAO.updateHold(hVo);
		
		
		SYProductVO productVo = new SYProductVO();
		productVo.setProduct_po(product_po);
		productVo.setProduct_status_info(result_hVo.getPrev_status());
		
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateProductHold(productVo);
		
		
		SYProductOperationVO pVo1 = new SYProductOperationVO();
		pVo1.setProduct_po(product_po);
		pVo1.setRouting_code(routing_code);
		pVo1.setStatus(result_hVo.getPrev_status());
		
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateOperationHold(pVo1);
		
		
		return 0 ;
	}*/
	
	
	
	
	
	// 일괄 홀드 
	/*@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_ALL_Y(SYHoldVo holdVo) 
	{
		
		// po2010160121_1 = MCT_001
		// po2010130104_5 = SAN_003
		
		List<SYProductOperationVO> holdTargetVo = productDAO.selectHold_Y_Target();
		int size = holdTargetVo.size();
		
		int result = 0;
		
		for(int i = 0 ; i< size; i++) {

			SYMachineVO vo = new SYMachineVO();
			vo.setMachine_code(holdTargetVo.get(i).getMachine_code());
	
			infoDAO.changeHold_Y(vo);   //[1]
			
			SYProductOperationVO pVo = new SYProductOperationVO();
			pVo.setMachine_code( vo.getMachine_code() );
			
			List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
			
			String product_po = pList.get(0).getProduct_po();
			String routing_code = pList.get(0).getRouting_code();
			String routing_seq = pList.get(0).getRouting_seq();
			String real_seq = pList.get(0).getReal_seq();
			String status = pList.get(0).getStatus();
			String machine_code = pList.get(0).getMachine_code();
			String machine_nm = pList.get(0).getMachine_nm();
			String prod_str_time = pList.get(0).getProd_str_time();
			
			logger.debug("product_po : " + product_po);
			logger.debug("routing_code : " + routing_code);
			logger.debug("routing_seq : " + routing_seq);
			logger.debug("real_seq : " + real_seq);
			logger.debug("status : " + status);
			logger.debug("machine_code : " + machine_code);
			logger.debug("machine_nm : " + machine_nm);
			logger.debug("prod_str_time : " + prod_str_time);
	
			
			String hold_comment = holdVo.getHold_comment();
			
			SYHoldVo hVo = new SYHoldVo();
			
			hVo.setProduct_po(product_po);
			
			hVo.setRouting_code(routing_code);
			hVo.setRouting_seq(routing_seq);
			
			hVo.setReal_seq(real_seq);
			hVo.setPrev_status(status);
			hVo.setMachine_code(machine_code);
			hVo.setMachine_nm(machine_nm);
			
			hVo.setProd_str_time(prod_str_time);
		
			hVo.setHold_comment(hold_comment);
			//hVo.setDel_yn(del_yn);
			
			hVo.setCreator(vo.getUpdater());
			hVo.setUpdater(vo.getUpdater());
			
			
			infoDAO.insertHold(hVo);
			
			
			SYProductVO productVo = new SYProductVO();
			productVo.setProduct_po(product_po);
			productVo.setProduct_status_info("h");
			
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateProductHold(productVo);
			
			
			SYProductOperationVO pVo1 = new SYProductOperationVO();
			pVo1.setProduct_po(product_po);
			pVo1.setRouting_code(routing_code);
			pVo1.setStatus("h");
			
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateOperationHold(pVo1);
		}
		return 0 ;
	}
	
	
	
	// 일괄 홀드 해제
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_ALL_N() 
	{
		
		// po2010160121_1 = MCT_001
		// po2010130104_5 = SAN_003
		
		List<SYProductOperationVO> holdTargetVo = productDAO.selectHold_N_Target();
		int size = holdTargetVo.size();
		
		int result = 0;
		
		for(int i = 0 ; i< size; i++) {
			
			SYMachineVO vo = new SYMachineVO();
			vo.setMachine_code(holdTargetVo.get(i).getMachine_code());
		
			infoDAO.changeHold_N(vo);   //[1]
			
			SYProductOperationVO pVo = new SYProductOperationVO();
			pVo.setMachine_code( vo.getMachine_code() );
			
			List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
			
			String product_po = pList.get(0).getProduct_po();
			String routing_code = pList.get(0).getRouting_code();
			String routing_seq = pList.get(0).getRouting_seq();
			String real_seq = pList.get(0).getReal_seq();
			String machine_code = pList.get(0).getMachine_code();
			String machine_nm = pList.get(0).getMachine_nm();
			String prod_str_time = pList.get(0).getProd_str_time();
			
			logger.debug("product_po : " + product_po);
			logger.debug("routing_code : " + routing_code);
			logger.debug("routing_seq : " + routing_seq);
			logger.debug("real_seq : " + real_seq);
			logger.debug("machine_code : " + machine_code);
			logger.debug("machine_nm : " + machine_nm);
			logger.debug("prod_str_time : " + prod_str_time);
	
			
		
		
			SYHoldVo hVo = new SYHoldVo();
			
			hVo.setProduct_po(product_po);
			hVo.setMachine_code(machine_code);
		
			SYHoldVo result_hVo = infoDAO.selectMachineHold(hVo);
			
			hVo.setHold_seq(result_hVo.getHold_seq());
			hVo.setCreator(vo.getUpdater());
			hVo.setUpdater(vo.getUpdater());
			
			infoDAO.updateHold(hVo);
			
			
			SYProductVO productVo = new SYProductVO();
			productVo.setProduct_po(product_po);
			productVo.setProduct_status_info(result_hVo.getPrev_status());
			
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateProductHold(productVo);
			
			
			SYProductOperationVO pVo1 = new SYProductOperationVO();
			pVo1.setProduct_po(product_po);
			pVo1.setRouting_code(routing_code);
			pVo1.setStatus(result_hVo.getPrev_status());
			
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateOperationHold(pVo1);
		}
		
		return 0 ;
	}
	*/
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_Y(SYMachineVO vo ) 
	{
		
		/**
		 * 
		 *  홀드 처리시 
		 *  1. machine_master 에서 해당 장비  hold_yn = 'Y' 
		 *  
		 *  2. selectHoldStatus 이용해서 해당 장비의 최신 정보를 긁어옴 
		 *  
		 *  3. 위에서 가져온 정보 + 기존에 넘긴 데이터를  바탕으로 product_machine_hold_tbl 에 insert ( hold_end_time 제외하고 나머지 다 )
		 *  
		 *  -------------------------------------------------------------------------------
		 *  3. product_tbl 에 product_status_info =  h 로 변경 
		 *  
		 *  4. product_operation_tbl 에  status = h 로 변경 
		 */
		
		
	
		int result = 0;
		infoDAO.changeHold_Y(vo);   //[1]
		
		SYProductOperationVO pVo = new SYProductOperationVO();
		pVo.setMachine_code( vo.getMachine_code() );
		
		List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
		
		String product_po = pList.get(0).getProduct_po();
		String routing_code = pList.get(0).getRouting_code();
		String routing_seq = pList.get(0).getRouting_seq();
		String real_seq = pList.get(0).getReal_seq();
		String status = pList.get(0).getStatus();
		String machine_code = pList.get(0).getMachine_code();
		String machine_nm = pList.get(0).getMachine_nm();
		String prod_str_time = pList.get(0).getProd_str_time();
		
		logger.debug("product_po : " + product_po);
		logger.debug("routing_code : " + routing_code);
		logger.debug("routing_seq : " + routing_seq);
		logger.debug("real_seq : " + real_seq);
		logger.debug("status : " + status);
		logger.debug("machine_code : " + machine_code);
		logger.debug("machine_nm : " + machine_nm);
		logger.debug("prod_str_time : " + prod_str_time);

		
		String hold_comment = vo.getHold_comment();
		
		SYProductUnOperationVO hVo = new SYProductUnOperationVO();
		
		hVo.setProduct_po(product_po);
		hVo.setRouting_code(routing_code);
		
		hVo.setUnprod_str_time(prod_str_time);
		hVo.setUnprod_comment(hold_comment);
		
		hVo.setMachine_code(machine_code);
		hVo.setMachine_nm(machine_nm);
		hVo.setPrev_status(status);
		//hVo.setDel_yn(del_yn);
		
		hVo.setCreator(vo.getUpdater());
		hVo.setUpdater(vo.getUpdater());
		hVo.setMember_emp_no(vo.getUpdater());
		hVo.setMember_nm(vo.getUpdater());
		
		hVo.setType("H");
		infoDAO.insertHold(hVo);
		
		
		SYProductVO productVo = new SYProductVO();
		productVo.setProduct_po(product_po);
		productVo.setProduct_status_info("h");
		productVo.setUpdater(vo.getUpdater());
		
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateProductHold(productVo);
		
		
		SYProductOperationVO pVo1 = new SYProductOperationVO();
		pVo1.setProduct_po(product_po);
		pVo1.setRouting_code(routing_code);
		pVo1.setStatus("h");
		pVo1.setUpdater(vo.getUpdater());
		
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateOperationHold(pVo1);
		
		return 0 ;
	}
	
	// 1개 홀드 해제
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_N(SYMachineVO vo ) 
	{
		
		/**
		 * 
		 *  홀드 처리시 
		 *  1. machine_master 에서 해당 장비  hold_yn = 'N' 
		 *  
		 *  2. selectHoldStatus 이용해서 해당 장비의 최신 정보를 긁어옴 
		 *  
		 *  3.product_machine_hold_tbl update ( hold_end_time )
		 *  
		 *  -------------------------------------------------------------------------------
		 *  3. product_tbl 에 product_status_info =  i || ue 로 변경 (원래상태)
		 *  
		 *  4. product_operation_tbl 에  status = i || ue  로 변경 (원래상태)
		 */
		
		
		int result = 0;
		infoDAO.changeHold_N(vo);   //[1]
		
		SYProductOperationVO pVo = new SYProductOperationVO();
		pVo.setMachine_code( vo.getMachine_code() );
		
		List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
		
		String product_po = pList.get(0).getProduct_po();
		String routing_code = pList.get(0).getRouting_code();
		String routing_seq = pList.get(0).getRouting_seq();
		String real_seq = pList.get(0).getReal_seq();
		String machine_code = pList.get(0).getMachine_code();
		String machine_nm = pList.get(0).getMachine_nm();
		String prod_str_time = pList.get(0).getProd_str_time();
		
		logger.debug("product_po : " + product_po);
		logger.debug("routing_code : " + routing_code);
		logger.debug("routing_seq : " + routing_seq);
		logger.debug("real_seq : " + real_seq);
		logger.debug("machine_code : " + machine_code);
		logger.debug("machine_nm : " + machine_nm);
		logger.debug("prod_str_time : " + prod_str_time);

		
	
	
		SYProductUnOperationVO hVo = new SYProductUnOperationVO();
		
		hVo.setProduct_po(product_po);
		hVo.setMachine_code(machine_code);
	
		SYProductUnOperationVO result_hVo = infoDAO.selectMachineHold(hVo);
		
		hVo.setUnoperation_seq(result_hVo.getUnoperation_seq());

		hVo.setUpdater(vo.getUpdater());
		
		infoDAO.updateHold(hVo);
		
		
		SYProductUnOperationVO next_row_hVo = infoDAO.selectMachineHold_from_seq(hVo);
		
		
		
		String str_time = next_row_hVo.getUnprod_str_time();
		String end_time = next_row_hVo.getUnprod_end_time();
		
		next_row_hVo.setUnprod_str_time(end_time);
		next_row_hVo.setType("WH");
		infoDAO.insertHold(next_row_hVo);
			
		String prev_status = result_hVo.getPrev_status();
		
		prev_status = "nh";
		SYProductVO productVo = new SYProductVO();
		productVo.setProduct_po(product_po);
		productVo.setProduct_status_info(prev_status);
		productVo.setUpdater(vo.getUpdater());
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateProductHold(productVo);
		
		
		SYProductOperationVO pVo1 = new SYProductOperationVO();
		pVo1.setProduct_po(product_po);
		pVo1.setRouting_code(routing_code);
		pVo1.setStatus(prev_status);
		pVo1.setUpdater(vo.getUpdater());
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateOperationHold(pVo1);
		
		
		return 0 ;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_ALL_Y(SYHoldVo holdVo) 
	{
		
		// po2010160121_1 = MCT_001
		// po2010130104_5 = SAN_003
		
		List<SYProductOperationVO> holdTargetVo = productDAO.selectHold_Y_Target();
		int size = holdTargetVo.size();
		
		int result = 0;
		
		for(int i = 0 ; i< size; i++) {

			SYMachineVO vo = new SYMachineVO();
			vo.setMachine_code(holdTargetVo.get(i).getMachine_code());
	
			infoDAO.changeHold_Y(vo);   //[1]
			
			SYProductOperationVO pVo = new SYProductOperationVO();
			pVo.setMachine_code( vo.getMachine_code() );
			
			List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
			
			String product_po = pList.get(0).getProduct_po();
			String routing_code = pList.get(0).getRouting_code();
			String routing_seq = pList.get(0).getRouting_seq();
			String real_seq = pList.get(0).getReal_seq();
			String status = pList.get(0).getStatus();
			String machine_code = pList.get(0).getMachine_code();
			String machine_nm = pList.get(0).getMachine_nm();
			String prod_str_time = pList.get(0).getProd_str_time();
			
			logger.debug("product_po : " + product_po);
			logger.debug("routing_code : " + routing_code);
			logger.debug("routing_seq : " + routing_seq);
			logger.debug("real_seq : " + real_seq);
			logger.debug("status : " + status);
			logger.debug("machine_code : " + machine_code);
			logger.debug("machine_nm : " + machine_nm);
			logger.debug("prod_str_time : " + prod_str_time);
	
			
			String hold_comment = vo.getHold_comment();
			
			SYProductUnOperationVO hVo = new SYProductUnOperationVO();
			
			hVo.setProduct_po(product_po);
			hVo.setRouting_code(routing_code);
			hVo.setPrev_status(status);
			hVo.setUnprod_str_time(prod_str_time);
			hVo.setUnprod_comment(hold_comment);
			
			hVo.setMachine_code(machine_code);
			hVo.setMachine_nm(machine_nm);
			//hVo.setDel_yn(del_yn);
			
			hVo.setCreator(holdVo.getUpdater());
			hVo.setUpdater(holdVo.getUpdater());
			
			hVo.setMember_nm(holdVo.getUpdater());
			
			
			hVo.setType("H");
			infoDAO.insertHold(hVo);
			
			
			SYProductVO productVo = new SYProductVO();
			productVo.setProduct_po(product_po);
			productVo.setProduct_status_info("h");
			
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateProductHold(productVo);
			
			
			SYProductOperationVO pVo1 = new SYProductOperationVO();
			pVo1.setProduct_po(product_po);
			pVo1.setRouting_code(routing_code);
			pVo1.setStatus("h");
			
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateOperationHold(pVo1);
		}
		return 0 ;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateHoldWaitingEnd(SYProductUnOperationVO hVo)
	{

		

		if(!"".equals(hVo.getMachine_code()))
		{
			SYMachineVO mVo = new SYMachineVO();
			mVo.setMachine_code(hVo.getMachine_code());
			String cnt = infoDAO.selectMachine_waiting_check(mVo);
			
			if( Integer.parseInt(cnt) > 0)
			{
				return 999;
			}
		}
		
		
		SYProductUnOperationVO result_hVo = infoDAO.selectMachineHold(hVo);	
		hVo.setUnoperation_seq(result_hVo.getUnoperation_seq());
		
		infoDAO.updateHold(hVo);
		
		SYProductVO productVo = new SYProductVO();
		productVo.setProduct_po(hVo.getProduct_po());
		productVo.setProduct_status_info("i");
		productVo.setUpdater(hVo.getUpdater());
		
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateProductHold(productVo);
		
		
		SYProductOperationVO pVo1 = new SYProductOperationVO();
		pVo1.setProduct_po(hVo.getProduct_po());
		pVo1.setRouting_code(hVo.getRouting_code());
		pVo1.setStatus("i");
		pVo1.setUpdater(hVo.getUpdater());
		// 매퍼에 하나 만들어서 dao. 로 호출
		productDAO.updateOperationHold(pVo1);
		
		
		return 0;
		
	}
	
	// 일괄 홀드 해제
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveHold_ALL_N(SYHoldVo holdVo) 
	{
		
		// po2010160121_1 = MCT_001
		// po2010130104_5 = SAN_003
		
		List<SYProductOperationVO> holdTargetVo = productDAO.selectHold_N_Target();
		int size = holdTargetVo.size();
		
		int result = 0;
		
		for(int i = 0 ; i< size; i++) {
			
			SYMachineVO vo = new SYMachineVO();
			vo.setMachine_code(holdTargetVo.get(i).getMachine_code());
		
			infoDAO.changeHold_N(vo);   //[1]
			
			SYProductOperationVO pVo = new SYProductOperationVO();
			pVo.setMachine_code( vo.getMachine_code() );
			
			List<SYProductOperationVO> pList =  productDAO.selectHoldStatus(pVo);  //[2]
			
			String product_po = pList.get(0).getProduct_po();
			String routing_code = pList.get(0).getRouting_code();
			String routing_seq = pList.get(0).getRouting_seq();
			String real_seq = pList.get(0).getReal_seq();
			String machine_code = pList.get(0).getMachine_code();
			String machine_nm = pList.get(0).getMachine_nm();
			String prod_str_time = pList.get(0).getProd_str_time();
			
			logger.debug("product_po : " + product_po);
			logger.debug("routing_code : " + routing_code);
			logger.debug("routing_seq : " + routing_seq);
			logger.debug("real_seq : " + real_seq);
			logger.debug("machine_code : " + machine_code);
			logger.debug("machine_nm : " + machine_nm);
			logger.debug("prod_str_time : " + prod_str_time);
	
			
		
		
			SYProductUnOperationVO hVo = new SYProductUnOperationVO();
			
			hVo.setProduct_po(product_po);
			hVo.setMachine_code(machine_code);
		
			SYProductUnOperationVO result_hVo = infoDAO.selectMachineHold(hVo);
			
			hVo.setUnoperation_seq(result_hVo.getUnoperation_seq());
			hVo.setUpdater(holdVo.getUpdater());
			
			infoDAO.updateHold(hVo);
			
			
			SYProductUnOperationVO next_row_hVo = infoDAO.selectMachineHold_from_seq(hVo);
		
			String end_time = next_row_hVo.getUnprod_end_time();
			
			next_row_hVo.setUnprod_str_time(end_time);
			
			next_row_hVo.setType("WH");
			next_row_hVo.setCreator(holdVo.getUpdater());
			next_row_hVo.setUpdater(holdVo.getUpdater());
			infoDAO.insertHold(next_row_hVo);
			
			String prev_status = result_hVo.getPrev_status();
			
			prev_status = "nh";
			
			SYProductVO productVo = new SYProductVO();
			productVo.setProduct_po(product_po);
			productVo.setProduct_status_info(prev_status);
			productVo.setUpdater(hVo.getUpdater());
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateProductHold(productVo);
			
			
			SYProductOperationVO pVo1 = new SYProductOperationVO();
			pVo1.setProduct_po(product_po);
			pVo1.setRouting_code(routing_code);
			pVo1.setStatus(prev_status);
			pVo1.setUpdater(holdVo.getUpdater());
			
			// 매퍼에 하나 만들어서 dao. 로 호출
			productDAO.updateOperationHold(pVo1);
		}
		
		return 0 ;
	}
	
	
	
	
	
	
	// jyp
	
	// yb
	
	public List<SYBomVo> selectBomlist(SYBomVo vo){
		return infoDAO.selectBomlist(vo);
	}
	public int insertBomlist(SYBomVo vo) {
		return infoDAO.insertBomlist(vo);
	}
	public int deleteBomlist(SYBomVo vo) {
		return infoDAO.deleteBomlist(vo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// yb
		
	
	/// sss
	public List<SYProduct2Vo> selectS_product2(SYProduct2Vo vo) {
		return infoDAO.selectS_product2(vo);
	}
	public List<SYProduct2Vo> selectS_product2u(SYProduct2Vo vo) {
		return infoDAO.selectS_product2u(vo);
	}
	public List<SYProduct2Vo> selectS_product(SYProduct2Vo vo) {
		return infoDAO.selectS_product(vo);
	}
	public List<SYProduct2Vo> selectS_productu(SYProduct2Vo vo) {
		return infoDAO.selectS_productu(vo);
	}
	
	public List<SYProduct2Vo> selectS_product_fail(SYProduct2Vo vo) {
		return infoDAO.selectS_product_fail(vo);
	}
	public List<SYProduct2Vo> selectS_productu_fail(SYProduct2Vo vo) {
		return infoDAO.selectS_productu_fail(vo);
	}
	
	
	
	

	
	public List<SYRoutingMasterVo> selectUpdate_routing(SYRoutingMasterVo vo) {
		return infoDAO.selectUpdate_routing(vo);
	}
	
	//210108
	public List<SYRoutingMasterVo> selectUpdate_routing_code(SYRoutingMasterVo vo) {
		return infoDAO.selectUpdate_routing_code(vo);
	}
	

	public List<SYRoutingMasterVo> selectRouting_master(SYRoutingMasterVo vo) {
		return infoDAO.selectRouting_master(vo);
	}
	//성민
	
	public int deleteWarehouse(SYWarehouseVo vo) {
		return infoDAO.deleteWarehouse(vo);
	}
	
	public int checkWarehouse(SYWarehouseVo vo) {
		return infoDAO.checkWarehouse(vo);
	}
	
	public List<SYWarehouseVo> select_wh_mng(SYWarehouseVo vo) {
		return infoDAO.select_wh_mng(vo);
	}
	
	public int insertWarehouse(SYWarehouseVo vo) {
		return infoDAO.insertWarehouse(vo);
	}

	public int updateWarehouse(SYWarehouseVo vo) {
		return infoDAO.updateWarehouse(vo);
	}
	
	public List<SYRoutingMasterVo> selectRouting_com_master(SYRoutingMasterVo vo) {
		return infoDAO.selectRouting_com_master(vo);
	}
	
	public List<SYRoutingMasterVo> selectRouting_com_master_2(SYRoutingMasterVo vo) {
		return infoDAO.selectRouting_com_master_2(vo);
	}
	
	public int deleteRoutingCom(SYRoutingMasterVo vo) {
	return infoDAO.deleteRoutingCom(vo);

}

	public int saveRouting(List<SYRoutingMasterVo> list) {
		infoDAO.deleteRoutingCode(list.get(0).getDetail_code());
		return infoDAO.saveRouting(list);

	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveRouting_master(List<SYRoutingMasterVo> list, SYMaterialVo vo) {

		int result = 0;
		int flag = 0;
		
		infoDAO.allUpdateRouting_master(vo);
		
		for(int i=0 ; i<list.size() ; i++)
		{ 
			int gubun = 0;
			String rc = list.get(i).getRouting_code(); // 등록한 rc의값 가져오기 ( 수정이면 이거 두글자고 새로 등록이면 1글자임)
			String ol_rc = list.get(i).getOld_routing_code(); // old_값이 없으면 등록으로 변경 될 거
			
			String cnt = rc;
					//infoDAO.selectRouting_masterMax(list.get(i)); // 제일 max 인 것 가져오기
			
			System.out.println("ol_rc = " + ol_rc);
			if(ol_rc == null/*ol_rc.equals("")*//*rc.length() < 2*/) { // 2가 더 높으면 rc는 등록입니다 >> old_값이 없으면 등록으로 변경 될 거
				if(cnt == null || cnt == "null" || cnt.equals("")) { // ?를 처음으로 등록하는 거면 null임
					list.get(i).setRouting_code(rc);
				} else {
					System.out.println("cnt.substring(1, cnt.length() = " + cnt.substring(1, cnt.length()));
					//cnt = rc+(Integer.parseInt( cnt.substring(1, cnt.length()))+1);//성민주석
					
					list.get(i).setRouting_code(cnt);
					System.out.println("cntcntcntcnt:"+cnt);
				}
				gubun = 1;
				result = infoDAO.saveRouting_master2(list.get(i));
			
			}
			else { // 2면..이거는......... 수정
				System.out.println("수정");

				// rc랑 ol_rc를 비교하는데 앞부분이 같으면 코드 그대로 수정
				// 앞부분 코드가 다르면 위에 max값 해대깅~
				// old가 p인데 구분이 같은 p이면 old_routing_code가 있다면 수정이니... 기존 값 가져오기.
				if(!ol_rc.substring(0, 1).equals(rc.substring(0, 1))) { // 같지 않으면 >>>> max값 구하기
					if(cnt == null || cnt == "null" || cnt.equals("")) { // ?를 처음으로 등록하는 거면 null임
						//list.get(i).setRouting_code(rc+"1");
						list.get(i).setRouting_code(rc);
						System.out.println("max값이 없어요..");
						
						result = infoDAO.updateRouting_master(list.get(i));
						
						gubun = 2;
					} else {
						System.out.println("max값이 있어요..");
						System.out.println(cnt.substring(1, cnt.length()) );
						cnt = rc+( Integer.parseInt( cnt.substring(1, cnt.length())) + 1);
						
						//list.get(i).setRouting_code(cnt);
						list.get(i).setRouting_code(rc);
						result = infoDAO.updateRouting_master(list.get(i));
						
						gubun = 2;
					}
				} else { // 같으면 old 코드 그대로 가자~
					System.out.println("등록 - old 코득그대로");
//					list.get(i).setRouting_code(ol_rc);
					list.get(i).setRouting_code(""); // 아무것도 변경안하고 수정시에는 코드 변경하면 오류뜸
					
					result = infoDAO.updateRouting_master(list.get(i));
					
					list.get(i).setRouting_code(ol_rc);
					
					gubun = 3;
				}
				
				// result = infoDAO.updateRouting_master(list.get(i));
			} // 딘
			
			System.out.println("rc = " + rc);
			System.out.println("cnt = " + cnt);
			
			String rc_sp = rc.substring(0, 1);
			
			if ( rc_sp.equals("Q") || rc_sp.equals("Z") ) {
				System.out.println(":D");
			} else {
				
				System.out.println(":0");
					// ?-1 만들어주기
					list.get(i).setRouting_nm( list.get(i).getRouting_nm()+"_검사" ); // 하드코딩
					/*if(rc.contains("P")) {
						list.get(i).setRouting_nm( list.get(i).getRouting_nm()+"_생산" );
					} else if(rc.contains("Q")) {
						list.get(i).setRouting_nm( list.get(i).getRouting_nm()+"_품질검사" );
					} else if(rc.contains("S")) {
						list.get(i).setRouting_nm( list.get(i).getRouting_nm()+"_자주검사" );
					}*/
					
					list.get(i).setWarehouse_gubun("");
					list.get(i).setOutsourcing_gubun("N");
					//list.get(i).setOld_routing_code(rc); 
					System.out.println("gubungubungubungubungubungubungubungubungubungubungubun = " + gubun);
					System.out.println("list.get(i).getOld_routing_code() = " + list.get(i).getOld_routing_code());
		//			list.get(i).setOld_routing_code( list.get(i).getRouting_code() + "-1");
					
					if(gubun == 1 ) {
						list.get(i).setRouting_code( list.get(i).getRouting_code() + "-1");
						
						System.out.println("-1 만들기 getRouting = " + list.get(i).getRouting_code());
						
						result = infoDAO.saveRouting_master2(list.get(i)); // result = infoDAO.saveRouting_master(list.get(i));
						System.out.println("-1 등록");
						
					} else if ( gubun == 2 ) { 
						
						
						// 옛날 코드 Q, I, F insert update
						if ( list.get(i).getOld_routing_code().substring(0, 1).equals("Q") 
								|| list.get(i).getOld_routing_code().substring(0, 1).equals("I") 
								|| list.get(i).getOld_routing_code().substring(0, 1).equals("F")
								|| list.get(i).getOld_routing_code().substring(0, 1).equals("Z")) {
							list.get(i).setRouting_code( list.get(i).getRouting_code() + "-1");
							result = infoDAO.saveRouting_master2(list.get(i));
							
							System.out.println("코드값이변경된 검사류의 등록");
						} else { // else update >> insert update
						
							list.get(i).setOld_routing_code( list.get(i).getOld_routing_code() + "-1");
							list.get(i).setRouting_code( list.get(i).getRouting_code() + "-1");
							result = infoDAO.saveRouting_master2(list.get(i)); //result = infoDAO.updateRouting_master(list.get(i));
						    System.out.println(list.get(i).getRouting_code() + "-1");
							System.out.println("코드값이변경된 수정");
						}
						System.out.println("-1 만들기 getRouting = " + list.get(i).getRouting_code());
						
					} else if ( gubun == 3 ) { 
						list.get(i).setRouting_code(list.get(i).getRouting_code() + "-1");//성민추가
						list.get(i).setOld_routing_code( list.get(i).getOld_routing_code() + "-1");
						result = infoDAO.updateRouting_master(list.get(i));
						
						System.out.println("코드값이 그대로 수정");
					}
					
					// 일단 이렇게 하고.. 나중에 가능할때 text값도 가져와서 그 값 넣어주면 if문 쓸 필요도 없음....
					/*
					
					// ?-1 저장 >> 등록 수정 여부 >> old가 없음 등록으로 변경
					if(ol_rc == null) { // rc.length() < 2
						result = infoDAO.saveRouting_master(list.get(i));
					} else { // 2면..이거는......... 수정
						System.out.println("수정");
						
						list.get(i).setRouting_code(""); 
						
						result = infoDAO.updateRouting_master(list.get(i));
					}*/
					
					/*String cnt1 = "";
					if(cnt == null || cnt == "null" || cnt.equals("")) {
						System.out.println("null임");
						list.get(i).setRouting_code(rc+"1-1");
					} else {
						cnt1 = cnt+"-1";
						list.get(i).setRouting_code(cnt1);
					}*/
			} 
					
					
			if(result <= 0)
			{
				flag++;
			}
		}
		
		if(flag == 0)
		{
			result = infoDAO.updateMaterial2(vo);
		}
		
		return result;
	}

	
	public int delRouting_master(SYMaterialVo vo) {
		System.out.println("delRouting_master");
		int result = 0;
		
		infoDAO.allUpdateRouting_master(vo);
		
		result = infoDAO.updateMaterial(vo);
		
		return result;
	}
	
	
	/**
	 * 창완
	 * 
	 */
	
	public int updateRouting_master_qc(SYRoutingMasterVo vo) {
		return infoDAO.updateRouting_master_qc(vo);
	}
	
	// Quality
	public List<SYQualityVo> selectQuality(SYQualityVo vo) {
		return infoDAO.selectQuality(vo);
	}
	
	public List<SYInspectMasterVo> selectInspect_master(SYInspectMasterVo vo) {
		return infoDAO.selectInspect_master(vo);
	}
	public int saveInspect_master(SYInspectMasterVo vo){
		return infoDAO.saveInspect_master(vo);
	}
	
	public int deleteInspect_master(SYInspectMasterVo vo) {
		return infoDAO.deleteInspect_master(vo);
	}
	
	// Material
	public List<SYRoutingMasterVo> selectRou_mstG(SYRoutingMasterVo vo) {
		return infoDAO.selectRou_mstG(vo);
	}
	public List<SYInspectionMasterVo> selectInspection_master2(SYInspectionMasterVo vo) {
		return infoDAO.selectInspection_master2(vo);
	}
	public List<SYInstrumentVo> selectInstrumentTool(SYInstrumentVo vo) {
		return infoDAO.selectInstrumentTool(vo);
	}
	public int insertInspection(SYInspectionMasterVo vo) {
		return infoDAO.insertInspection(vo);
	}
	public int updateInspection(SYInspectionMasterVo vo) {
		return infoDAO.updateInspection(vo);
	}
	public int deleteInspection(SYInspectionMasterVo vo) {
		return infoDAO.deleteInspection(vo);
	}
	public int upRouting_mstQc_yn(SYInspectionMasterVo vo) {
		return infoDAO.upRouting_mstQc_yn(vo);
	}
	
	
	//1022
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertInspection2(List<SYInspectionMasterVo> list, SYInspectionMasterVo vo){
	
		int result = 0;
		
		
		for(int i=0 ; i<list.size() ; i++)
		{ 
//			list.get(i).setInspection_item(vo.getInspection_item());
//			list.get(i).setInspection_tool(vo.getInspection_tool());
//			list.get(i).setSpec(vo.getSpec());
//			list.get(i).setMin_spec(vo.getMin_spec());
//			list.get(i).setMax_spec(vo.getMax_spec());

			list.get(i).setItem_code(vo.getItem_code());
			list.get(i).setRouting_code(vo.getRouting_code());
			
			
			result = infoDAO.insertInspection(list.get(i));
		}
		
		return result;
	}
	
	
	
	
	
	
	
	
	public List<SYIncome_insp_mstVo> selectIncome_inspect_master(
			SYIncome_insp_mstVo vo) {
		return infoDAO.selectIncome_inspect_master(vo);
	}
	public int insertIncome_inspect_master(SYIncome_insp_mstVo vo) {
		return infoDAO.insertIncome_inspect_master(vo);
	}
	public int updateIncome_inspect_master(SYIncome_insp_mstVo vo) {
		return infoDAO.updateIncome_inspect_master(vo);
	}
	public int upReceiving_inspection_yn(SYIncome_insp_mstVo vo) {
		return infoDAO.upReceiving_inspection_yn(vo);
	}
	public int deleteIncome_inspect_master(SYIncome_insp_mstVo vo) {
		return infoDAO.deleteIncome_inspect_master(vo);
	}
	public List<SYIncome_resultVo> selectIncome_result(SYIncome_resultVo vo) {
		return infoDAO.selectIncome_result(vo);
	}
	public List<SYIncome_resultVo> selectIncome_result2(SYIncome_resultVo vo) {
		return infoDAO.selectIncome_result2(vo);
	}
	public int saveIncome_result3(SYIncome_resultVo vo) {
		return infoDAO.saveIncome_result3(vo);
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveIncome_result2(SYIncome_resultVo vo) {
		int result = 0;
		infoDAO.saveIncome_result2(vo);
		
		SYPurchaseOrderDetailVo podVo = new SYPurchaseOrderDetailVo();
		
		podVo.setPass_menge(vo.getPass_menge());
		podVo.setPurchase_status("S");
		podVo.setPurchase_num(vo.getPurchase_num());
		podVo.setPurchase_order_num(vo.getPurchase_order_num());
		podVo.setUpdater(vo.getUpdater());
		
		poDAO.updatePurchaseIncoming(podVo);
		
		return result;
	}
	
	
	public List<SYIncome_resultVo> selectIncome_result3(SYIncome_resultVo vo) {
		return infoDAO.selectIncome_result3(vo);
	}
	
	public List<SYPrintVO> selectPrintFI(SYPrintVO vo) {
		return infoDAO.selectPrintFI(vo);
	}
	
	public List<SYtool_repmt_hisVo> selectTool_replacement_his(SYtool_repmt_hisVo vo) {
		return infoDAO.selectTool_replacement_his(vo);
	}
//	public String replacementHGen() {
//		return infoDAO.replacementHGen();
//	}
	public int insertTool_replacement_his(SYtool_repmt_hisVo vo) {
		return infoDAO.insertTool_replacement_his(vo);
	}
	public int updateTool_replacement_his(SYtool_repmt_hisVo vo) {
		return infoDAO.updateTool_replacement_his(vo);
	}
	public int deleteTool_replacement_his(SYtool_repmt_hisVo vo) {
		return infoDAO.deleteTool_replacement_his(vo);
	}
	
	public List<SYTMaterialVo> selectBOMbyPRO(SYTMaterialVo vo){
		return infoDAO.selectBOMbyPRO(vo);
	}
	public List<SYTProjectVo> selectBOMbyProject(SYTProjectVo Vo){
		return infoDAO.selectBOMbyProject(Vo);
	}	
	
	
}
