package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
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
import kr.co.passcombine.set.vo.SYWarehouseVo;
import kr.co.passcombine.set.vo.SYtool_repmt_hisVo;
import kr.co.passcombine.set.vo.SYHoldVo;

@Repository(value = "setInfoDAO")
public interface DOCompanyDAO {
	
	public List<SYCustomerVo> selectCdD(SYCustomerVo vo);
	public List<SYCustomerVo> selectCdD_csmb(SYCustomerVo vo);

	public int checkCustomer(SYCustomerVo vo);
	public List<SYCustomerVo> selectCustomer(SYCustomerVo vo);
	public int insertCustomer(SYCustomerVo vo);
	public int updateCustomer(SYCustomerVo vo);
	public int deleteCustomer(SYCustomerVo vo);
	
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
	public int checkMaterial(SYMaterialVo vo);
	public List<SYMaterialVo> selectMaterial(SYMaterialVo vo);
	public List<SYMaterialVo> excelLoad(SYMaterialVo vo);
	public Integer excelMax(SYMaterialVo vo);
	public int insertMaterial(SYMaterialVo vo);
	public int updateMaterial(SYMaterialVo vo);
	public int updateMaterial2(SYMaterialVo vo);
	public int deleteMaterial(SYMaterialVo vo);

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
	
	public List<SYMaterialVo> selectMaterial_menge(SYMaterialVo vo);
	public List<SYMaterialVo> selectMaterial2(SYMaterialVo vo);
	public List<SYMaterialVo> selectMaterial3(SYMaterialVo vo);
	
	public List<SYMaterialVo> selectItemCode(SYMaterialVo vo);
	public List<SYMaterialVo> selectItemCode2(SYMaterialVo vo);
	public List<SYMaterialVo> selectItemCode3(SYMaterialVo vo);
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
	
}
