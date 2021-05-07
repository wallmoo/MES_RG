package kr.co.passcombine.set.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYTBranchVo;
import kr.co.passcombine.set.vo.SYTClientVo;
import kr.co.passcombine.set.vo.SYTEstimateVo;
import kr.co.passcombine.set.vo.SYTMaterialOrderVo;
import kr.co.passcombine.set.vo.SYTMaterialRequestVo;
import kr.co.passcombine.set.vo.SYTMaterialVo;
import kr.co.passcombine.set.vo.SYTProjectVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
import kr.co.passcombine.set.vo.SYIncome_insp_mstVo;
import kr.co.passcombine.set.vo.SYIncome_resultVo;
import kr.co.passcombine.set.vo.SYInspectMasterVo;
import kr.co.passcombine.set.vo.SYInspectionMasterVo;
import kr.co.passcombine.set.vo.SYInstrumentVo;
import kr.co.passcombine.set.vo.SYMachineVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYPartitionVO;
import kr.co.passcombine.set.vo.SYPrintVO;
import kr.co.passcombine.set.vo.SYProduct2Vo;
import kr.co.passcombine.set.vo.SYProductUnOperationVO;
import kr.co.passcombine.set.vo.SYQualityVo;
import kr.co.passcombine.set.vo.SYRepairVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;
import kr.co.passcombine.set.vo.SYTBomVo;
import kr.co.passcombine.set.vo.SYTVendorVo;
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYtool_repmt_hisVo;
import kr.co.passcombine.set.vo.SYHoldVo;

@Repository(value = "setInfoDAO")
public interface SYInfoDAO {
	
	public List<SYCustomerVo> selectCdD(SYCustomerVo vo);
	public List<SYCustomerVo> selectCdD_csmb(SYCustomerVo vo);

	public int checkCustomer(SYCustomerVo vo);
	public List<SYCustomerVo> selectCustomer(SYCustomerVo vo);
	public int insertCustomer(SYCustomerVo vo);
	public int updateCustomer(SYCustomerVo vo);
	public int deleteCustomer(SYCustomerVo vo);
	
	// Client Start
	public int checkClient(SYTClientVo vo);
	public List<SYTClientVo> selectClient(SYTClientVo vo);
	public int insertClient(SYTClientVo vo);
	public int updateClient(SYTClientVo vo);
	public int deleteClient(SYTClientVo vo);
	// Client End
	
	// Vendor Start
	public int checkVendor(SYTVendorVo vo);
	public List<SYTVendorVo> selectVendor(SYTVendorVo vo);
	public int insertVendor(SYTVendorVo vo);
	public int updateVendor(SYTVendorVo vo);
	public int deleteVendor(SYTVendorVo vo);
	// Vendor End
	
	// Branch Start
	public int checkBranch(SYTBranchVo vo);
	public List<SYTBranchVo> selectBranch(SYTBranchVo vo);
	public int insertBranch(SYTBranchVo vo);
	public int updateBranch(SYTBranchVo vo);
	public int deleteBranch(SYTBranchVo vo);
	// Branch End
	
	// Material Start
	public int checkMaterial(SYTMaterialVo vo);
	public List<SYTMaterialVo> selectMaterial(SYTMaterialVo vo);
	public int insertMaterial(SYTMaterialVo vo);
	public int updateMaterial(SYTMaterialVo vo);
	public int deleteMaterial(SYTMaterialVo vo);
	
	public List<SYMaterialVo> excelLoad(SYMaterialVo vo);
	public Integer excelMax(SYMaterialVo vo);	
	public int updateMaterial2(SYMaterialVo vo);
	public List<SYMaterialVo> selectMaterial_menge(SYMaterialVo vo);
	public List<SYMaterialVo> selectMaterial2(SYMaterialVo vo);
	public List<SYMaterialVo> selectMaterial3(SYMaterialVo vo);
	public List<SYMaterialVo> selectItemCode(SYMaterialVo vo);
	public List<SYMaterialVo> selectItemCode2(SYMaterialVo vo);
	public List<SYMaterialVo> selectItemCode3(SYMaterialVo vo);	
	
	public int updateMaterial(SYMaterialVo vo);//기존 코드 에러 방지
	// Material End
	
	// Project Start
	public int checkProject(SYTProjectVo vo);
	public List<SYTProjectVo> selectProject(SYTProjectVo vo);
	public int insertProject(SYTProjectVo vo);
	public int updateProject(SYTProjectVo vo);
	public int deleteProject(SYTProjectVo vo);
	// Project End	
	
	public int checkAccount(SYAccountVo vo);
	public List<SYAccountVo> selectAccount(SYAccountVo vo);
	public int insertAccount(SYAccountVo vo);
	public int updateAccount(SYAccountVo vo);
	public int deleteAccount(SYAccountVo vo);
	
	////
	// cw
	public List<SYPartitionVO> selectPartition2(SYPartitionVO vo);
	// jyp 
	public List<SYPartitionVO> selectPartition(SYPartitionVO vo);
	public int insPartition(SYPartitionVO vo);
	public int updPartition(SYPartitionVO vo);
	public int delPartition(SYPartitionVO vo);
	
	public int delPartitionAll(SYPartitionVO vo);
	
	public List<SYPartitionVO> selectPartitionList(SYPartitionVO vo);
	public List<SYPartitionVO> selectPartitionDetail(SYPartitionVO vo);
	public int insPartitionDetail(Map<String, Object> params);
	public int updPartitionDetail(SYPartitionVO vo);
	
	public int checkMachine(SYMachineVO vo);
	
	public List<SYMachineVO> selectMachine( SYMachineVO vo);
	public int insMachine(SYMachineVO vo);
	public int updMachine(SYMachineVO vo);
	public int delMachine(Map<String, Object> params);
	
	
	public List<SYMachineVO> selectMachine_waiting( SYMachineVO vo);
	public String selectMachine_waiting_check( SYMachineVO vo);
	
	public List<SYMachineVO> selectMachine_class( SYMachineVO vo);
	
	
	
	public List<SYMachineVO> selectMachine_nm( SYMachineVO vo);
	public int changeHold_Y(SYMachineVO vo);
	public int changeHold_N(SYMachineVO vo);
	
	public int changeHold_ALL_Y(SYMachineVO vo);
	public int changeHold_ALL_N(SYMachineVO vo);
	
	public int insertHold(SYProductUnOperationVO vo);
	public int updateHold(SYProductUnOperationVO vo);
	
	public SYProductUnOperationVO selectMachineHold( SYProductUnOperationVO vo);
	public SYProductUnOperationVO selectMachineHold_from_seq( SYProductUnOperationVO vo);
	// jyp
	
	// yb

	public List<SYBomVo> selectBomlist(SYBomVo vo);
	public int insertBomlist(SYBomVo vo);
	public int deleteBomlist(SYBomVo vo);
	public List<SYRepairVo> selectrepairReqT(SYRepairVo vo);
	
	
	
	
	
	
	
	
	
	
	
	
	//yb
	
	/// ssss 
	public List<SYRoutingMasterVo> selectRouting_master(SYRoutingMasterVo vo);
	
	//성민
	
	public int checkWarehouse(SYWarehouseVo vo);
	
	public List<SYWarehouseVo> select_wh_mng(SYWarehouseVo vo);
	
	public int insertWarehouse(SYWarehouseVo vo);
	public int updateWarehouse(SYWarehouseVo vo);
	public int deleteWarehouse(SYWarehouseVo vo);
	
	public List<SYRoutingMasterVo> selectRouting_com_master(SYRoutingMasterVo vo);
	
	public List<SYRoutingMasterVo> selectUpdate_routing(SYRoutingMasterVo vo);
	
	//210108
	public List<SYRoutingMasterVo> selectUpdate_routing_code(SYRoutingMasterVo vo);
	
	public List<SYRoutingMasterVo> selectRouting_com_master_2(SYRoutingMasterVo vo);
	
	public int saveRouting(List<SYRoutingMasterVo> list);
	
	
	public int deleteRoutingCom(SYRoutingMasterVo vo);
	
	
	
	public int saveRouting_master(SYRoutingMasterVo syRoutingMasterVo);
	public int saveRouting_master2(SYRoutingMasterVo syRoutingMasterVo);
	public void allUpdateRouting_master(SYMaterialVo vo);

	public String selectRouting_masterMax(SYRoutingMasterVo syRoutingMasterVo);
	public int updateRouting_master(SYRoutingMasterVo syRoutingMasterVo);

	public List<SYProduct2Vo> selectS_product2(SYProduct2Vo vo);
	public List<SYProduct2Vo> selectS_product2u(SYProduct2Vo vo);
	public List<SYProduct2Vo> selectS_product(SYProduct2Vo vo);	
	public List<SYProduct2Vo> selectS_productu(SYProduct2Vo vo);	
	
	public List<SYProduct2Vo> selectS_product_fail(SYProduct2Vo vo);
	public List<SYProduct2Vo> selectS_productu_fail(SYProduct2Vo vo);
	
	
	/**
	 * 창완
	 * 
	 */
	
	public int updateRouting_master_qc(SYRoutingMasterVo syRoutingMasterVo);
	
	// Quality
	
	public List<SYQualityVo> selectQuality(SYQualityVo vo);
	
	public List<SYInspectMasterVo> selectInspect_master(SYInspectMasterVo vo);
	
	public int saveInspect_master(SYInspectMasterVo vo);
	
	public int deleteInspect_master(SYInspectMasterVo vo);
	
	public List<SYRoutingMasterVo> selectRou_mstG(SYRoutingMasterVo vo);
	public List<SYInspectionMasterVo> selectInspection_master2(SYInspectionMasterVo vo);
	public List<SYInstrumentVo> selectInstrumentTool(SYInstrumentVo vo);
	public int insertInspection(SYInspectionMasterVo vo);
	public int updateInspection(SYInspectionMasterVo vo);
	public int deleteInspection(SYInspectionMasterVo vo);
	
	public int upRouting_mstQc_yn(SYInspectionMasterVo vo);
	
	
	public List<SYIncome_insp_mstVo> selectIncome_inspect_master(SYIncome_insp_mstVo vo);
	public int insertIncome_inspect_master(SYIncome_insp_mstVo vo);
	public int updateIncome_inspect_master(SYIncome_insp_mstVo vo);
	public int upReceiving_inspection_yn(SYIncome_insp_mstVo vo);
	public int deleteIncome_inspect_master(SYIncome_insp_mstVo vo);
	
	
	public List<SYIncome_resultVo> selectIncome_result(SYIncome_resultVo vo);
	public List<SYIncome_resultVo> selectIncome_result2(SYIncome_resultVo vo);
	public List<SYIncome_resultVo> selectIncome_result3(SYIncome_resultVo vo);
	public int saveIncome_result2(SYIncome_resultVo vo);
	public int saveIncome_result3(SYIncome_resultVo vo);
	
	
	public List<SYPrintVO> selectPrintFI(SYPrintVO vo);
	
	public List<SYtool_repmt_hisVo> selectTool_replacement_his(SYtool_repmt_hisVo vo);
	public int insertTool_replacement_his(SYtool_repmt_hisVo vo);
	public int updateTool_replacement_his(SYtool_repmt_hisVo vo);
	public int deleteTool_replacement_his(SYtool_repmt_hisVo vo);
	public void deleteRoutingCode(String routing_code);
	public List<SYTMaterialVo> selectBOMbyPRO(SYTMaterialVo vo);
	public List<SYTProjectVo> selectBOMbyProject(SYTProjectVo Vo);
	public List<SYTMaterialVo> selectMaterialsBOM(SYTMaterialVo Vo);
	public int InsertMaterialsBOM(List<Map<String,Object>> vo);
	
	public int updateBomQuantity(SYTBomVo vo);
	
	// Material Request Start	
	public List<SYTMaterialRequestVo> selectMaterialRequest(SYTMaterialRequestVo vo);
	public int insertMaterialRequest(List<Map<String,Object>> vo);
	public int updateMaterialRequest(SYTMaterialRequestVo vo);
	public int deleteMaterialRequest(SYTMaterialRequestVo vo);
	public int updateReqQuantity(SYTMaterialRequestVo vo);
	public int updateEstVendor(SYTEstimateVo vo);
	// Material Request End	
	
	
	public List<SYTMaterialVo> selectMaterialD(List<Map<String, Object>> vo);
	public int insertFile(Map<String, Object> file);
	public int updateFile(Map<String, Object> file);
	public int insertMaterialMap(Map<String, Object> vo);
	public int updateMaterialMap(Map<String, Object> vo);
	public Map<String, Object> selectFiles(Map<String, Object> vo);
	public int InsertBOMExcel(List<Map<String, Object>> vo);
	
	// Estimate Start	
	public List<SYTEstimateVo> selectEstimate(SYTEstimateVo vo);
	public int insertEstimate(List<Map<String,Object>> vo);
	public int updateEstimate(SYTEstimateVo vo);
	public int deleteEstimate(SYTEstimateVo vo);
	// Estimate End	
	
	// MaterialOrder Start	
	public List<SYTMaterialOrderVo> selectMaterialOrder(SYTMaterialOrderVo vo);
	public int insertMaterialOrderMST(Map<String,Object> vo);
	public int insertMaterialOrder(List<Map<String,Object>> vo);
	public int updateMaterialOrder(SYTMaterialOrderVo vo);
	public int deleteMaterialOrder(SYTMaterialOrderVo vo);
	// MaterialOrder End		
	
}
