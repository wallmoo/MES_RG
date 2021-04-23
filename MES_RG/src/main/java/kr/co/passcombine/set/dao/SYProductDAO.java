package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.passcombine.set.vo.SYAccountVo;
import kr.co.passcombine.set.vo.SYBomVo;
import kr.co.passcombine.set.vo.SYCustomerVo;
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

@Repository(value = "setProductDAO")
public interface SYProductDAO {

	
	public String selectOrderNum();
	
	// Routing 정보를 위해
	public List<SYRoutingMasterVo> selectRouting_master(SYRoutingMasterVo vo);
	
	// Product
	public List<SYProductVO> selectProduct(SYProductVO vo);
	
	public List<SYProductVO> selectProductItem(SYProductVO vo);
	
	public List<SYProductVO> selectProduct_one(SYProductVO vo);
	
	public List<SYProductVO> selectProduct_V1(SYProductVO vo);

	public int updateProductDate(SYProductVO vo);
	
	public int updateProductStatus(SYProductVO vo);
	
	public int saveProduct(SYProductVO vo);
	
	public int deleteProduct(SYProductVO vo);

	// Product Plan Now
	public List<SYWarehouseVo> selectProductPlanNow(SYWarehouseVo vo);

	
	// Product Operation
	
	public List<SYProductOperationVO> selectProductOperation(SYProductOperationVO vo);
	
	public List<SYProductOperationVO> selectProductOperation_V1(SYProductOperationVO vo);
	
	// 현재 쓰는 버전 
	public List<SYProductOperStatusVO> selectProductOperStatus(SYProductOperStatusVO vo);
	
	public List<SYProductOperStatusVO> selectProductOperStatus_V2(SYProductOperStatusVO vo);
	
	public List<SYProductOperStatusVO> selectProductOperStatus_2(SYProductOperStatusVO vo);
	
	// 20201128 마지막 - WAITING 문제 있음 <- 데이터 찾아도 흔적이 없음 
	public List<SYProductOperStatusVO> selectProductOperStatus_real(SYProductOperStatusVO vo);
	
	public SYProductOperationVO selectProductOperationStatus(SYProductOperationVO vo);

	public int saveProductOperation(SYProductOperationVO vo);
	
	public int deleteProductOperation(SYProductOperationVO vo);
	
	public int updateProductOperation(SYProductOperationVO vo);
	
	public int updateProductOperationInfo(SYProductOperationVO vo);
	
	public int updateProductOperationOS_REQ(SYProductOperationVO vo);
	
	public int updateProductOperationOS_END(SYProductOperationVO vo);
	// Product UnOperation
	
	
	public String selectProductUnOperationSeq(SYProductUnOperationVO vo);
	
	public List<SYProductUnOperationVO> selectProductUnOperation(SYProductUnOperationVO vo);
	
	public List<SYProductUnOperationVO> selectProductUnOperation_V1(SYProductUnOperationVO vo);

	public int insertProductUnOperation(SYProductUnOperationVO vo);
	public int updateProductUnOperation(SYProductUnOperationVO vo);
	
	public int saveProductUnOperation(SYProductUnOperationVO vo);
	
	public int deleteProductUnOperation(SYProductUnOperationVO vo);
	
	
	
	// Product
	public List<SYProductVO> selectProductMonitoring(SYProductVO vo);
	public List<SYProductVO> selectProductMonitoring2(SYProductVO vo);

	public List<SYProductOperationVO> selectOutSourcing(SYProductOperationVO vo);
	public List<SYProductOperationVO> selectOutSourcingAll(SYProductOperationVO vo);
	
	
	// LOT  추적
	
	public List<SYProductOperationVO> selectLot(SYProductOperationVO vo);
	
	public List<SYWareHouseRawVo> selectLot2(SYWareHouseRawVo vo);
	
	public List<SYProductOperationVO> selectLot3(SYProductOperationVO vo);
	
	
	
	//아이템별 공정현황
	public List<SYItem_fairVo> selectItemFair(SYItem_fairVo vo);
	public List<SYItem_fairVo> selectItemFair_graph(SYItem_fairVo vo);
	
	
	
	public List<SYProductOperationVO> selectHoldStatus(SYProductOperationVO vo);
	public int updateOperationHold(SYProductOperationVO vo);
	public int updateProductHold(SYProductVO vo);
	
	public List<SYProductOperationVO> selectHold_Y_Target();
	public List<SYProductOperationVO> selectHold_N_Target();
	
	
	public List<SYProductVO> selectProduct_status_info(SYProductVO vo);
	
	//1222
	public List<SYProductAnalysisVO> selectProductAnalysis(SYProductAnalysisVO vo);
	
	public List<SYProductOperationVO> selectMonitorAccount(SYProductOperationVO vo);
	//1228
	public List<SYProductMonitoringVO> selectMonitoringList(SYProductMonitoringVO vo);
	public List<SYProductMonitoringVO> selectMonitoringGraph(SYProductMonitoringVO vo);
	public List<SYProductMonitoringVO> selectMonitoringListDown(SYProductMonitoringVO vo);
	
	
	//210122
	public int updateOutsourcing(SYProductOperationVO vo);
}
