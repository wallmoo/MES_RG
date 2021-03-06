package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;



















import kr.co.passcombine.set.controller.FrontendController;
import kr.co.passcombine.set.dao.SYWarehouseDAO;
import kr.co.passcombine.set.dao.SYWarehousingDAO;
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

















import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;



@Service(value = "setWarehousingService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYWarehousingService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setWarehousingDAO")
	private SYWarehousingDAO dao;

	public String selectLastDate(SYWareHousingVo vo){
		return dao.selectLastDate(vo);
	}
	public String selectFileKey(){
		return dao.selectFileKey();
	}
										 
	public List<SYWareHousingVo> selectWarehousing(SYWareHousingVo vo) {
		return dao.selectWarehousing(vo);
	}
	
	public int insFileInfo(SYWareHousingVo vo) {
		return dao.insFileInfo(vo);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int updateWarehousingProcess(SYWareHousingVo vo) {
		
		int result = 0;
		dao.modFileInfo(vo);
		
		SYWareHouseRawVo wrVo = new SYWareHouseRawVo();
		wrVo.setItem_code(vo.getItem_code());
		wrVo.setCurrent_serial_no(vo.getCurrent_serial_no());
		wrVo.setSerial_no(vo.getSerial_no());
		wrVo.setUpdater(vo.getUpdater());
		dao.updateWarehouseRawFile(wrVo);
		return result;
		
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int insertWarehousingProcess(SYWareHousingVo vo, String purchase_order_num, String purchase_num) {
		int result = 0;
		
		
		String flag = vo.getItem_type_code();
		logger.debug("################flag :" + flag);
		
	
		int in_menge = Integer.parseInt(vo.getIn_menge());
		String mill_sheet_no = vo.getMill_sheet_no();
		
		if("MD1245".equals(flag)){
			
	
			for(int i = 0; i<in_menge; i++)
			{
				SYWareHousingVo new_vo = vo;
				String new_in_menge = "1";
				String new_serial_no = mill_sheet_no + "_" + (i+1);
				new_vo.setIn_menge(new_in_menge);
				new_vo.setSerial_no(new_serial_no);
				dao.insFileInfo(new_vo);
			}
		}
		else 
		{
			dao.insFileInfo(vo);
		}

		
		/*
		 * 
		 *  ????????? ??? 
		 * 1. warehousing_tbl         	-> insert 
		 * 2. purchase_order_master   	-> purchase_status update
		 * 3. purchase_order_detail		-> purchase_end_date, in_menge update
		 * 4. warehouse_raw_tbl 		-> insert -> ????????? 
		 * 
		 * 4. warehouse_tbl 		-> insert/update -> ???????????? ?????????
		 */
		
		

		SYPurchaseOrderDetailVo podVo = new SYPurchaseOrderDetailVo();
		podVo.setPurchase_order_num(purchase_order_num);
		podVo.setPurchase_num(purchase_num);
		
		podVo.setIn_menge(in_menge+"");
		podVo.setUpdater(vo.getUpdater());
		podVo.setDate_updated(vo.getDate_updated());
		dao.updatePurchaseOrderDetail(podVo);
		
		
		
		// ???????????? ?????? Purchase Detail ????????????, menge , in_menge ?????? ?????????.	
		String pod_purchase_status = getPurchaseStatusDetail(podVo);
	
	
		String purchase_end_date = vo.getIn_date();
		
		podVo.setPurchase_end_date(purchase_end_date);
		// ????????? ????????????
		podVo.setPurchase_status(pod_purchase_status);
		podVo.setIn_menge("");
		podVo.setUpdater(vo.getUpdater());
		podVo.setDate_updated(vo.getDate_updated());
		dao.updatePurchaseOrderDetail(podVo);
		
		SYPurchaseOrderVo poVo = new SYPurchaseOrderVo();
		poVo.setPurchase_order_num(purchase_order_num);
		
		String po_purchase_status = getPurchaseStatus(purchase_order_num);
		poVo.setPurchase_status(po_purchase_status);

		poVo.setUpdater(vo.getUpdater());
		poVo.setDate_updated(vo.getDate_updated());
		dao.updatePurchaseOrder(poVo);
		
		
		/**
		 * ????????? ???????????? ?????? ???????????? ???????????? ???????????????.
		 * 
		 * 
		 */
		
		if("MD1245".equals(flag)){
			SYWareHouseRawVo wrVo = new SYWareHouseRawVo();
			
			String business_code = "MD1243";
			String business_nm = "Consumable Parts";
			//String warehouse_code = vo.getIn_ware_code();
			String warehouse_code = "wm19";
		//	String warehouse_nm = "???????????????";
			
			wrVo.setBusiness_code(business_code);
			wrVo.setBusiness_nm(business_nm);
			wrVo.setWarehouse_code(warehouse_code);
		//	wrVo.setWarehouse_nm(warehouse_nm);
			
			
			wrVo.setItem_code(vo.getItem_code());
			wrVo.setItem_nm(vo.getItem_nm());
			wrVo.setItem_spec(vo.getItem_spec());
			wrVo.setItem_type_code(vo.getItem_type_code());
			wrVo.setItem_type_nm(vo.getItem_type_nm());
	
			wrVo.setMeins(vo.getMeins());
			
			wrVo.setDivision_seq("1");
			
			/*wrVo.setSerial_no(vo.getSerial_no());
			wrVo.setWarehouse_raw_qty(vo.getIn_menge());
			dao.insertWarehouseRaw(wrVo);*/
			
			for(int i = 0; i<in_menge; i++)
			{
				SYWareHouseRawVo new_vo = wrVo;
				String new_in_menge = "1";
				String new_serial_no = mill_sheet_no + "_" + (i+1);
				new_vo.setWarehouse_raw_qty(new_in_menge);
				new_vo.setSerial_no(new_serial_no);
				dao.insertWarehouseRaw(new_vo);
			}
		
		
		}else
		{
			SYWarehouseVo wVo = new SYWarehouseVo();
			
			String business_code = "MD1243";
			String business_nm = "Consumable Parts";
			String warehouse_code = vo.getIn_ware_code();
			//String warehouse_nm = "?????????/??????????????????";
			
			wVo.setBusiness_code(business_code);
			wVo.setBusiness_nm(business_nm);
			wVo.setWarehouse_code(warehouse_code);
		//	wVo.setWarehouse_nm(warehouse_nm);
			
			
			wVo.setItem_code(vo.getItem_code());
			wVo.setItem_nm(vo.getItem_nm());
			wVo.setItem_spec(vo.getItem_spec());
			wVo.setItem_type_code(vo.getItem_type_code());
			wVo.setItem_type_nm(vo.getItem_type_nm());
			
			wVo.setMeins(vo.getMeins());
			
	
			// menge ??? ???????????? + ????????????
			wVo.setWarehousing_qty(vo.getIn_menge());
			
			dao.saveWarehouse(wVo);
		}
	/*	else if("MD1247".equals(flag) || "MD1248".equals(flag)){
			
			SYWarehouseVo wVo = new SYWarehouseVo();
			
			String business_code = "MD1243";
			String business_nm = "Consumable Parts";
			String warehouse_code = "wm18";
			String warehouse_nm = "????????????";
			
			wVo.setBusiness_code(business_code);
			wVo.setBusiness_nm(business_nm);
			wVo.setWarehouse_code(warehouse_code);
			wVo.setWarehouse_nm(warehouse_nm);
			
			
			wVo.setItem_code(vo.getItem_code());
			wVo.setItem_nm(vo.getItem_nm());
			wVo.setItem_spec(vo.getItem_spec());
			wVo.setItem_type_code(vo.getItem_type_code());
			wVo.setItem_type_nm(vo.getItem_type_nm());
			
			wVo.setMeins(vo.getMeins());
			
	
			// menge ??? ???????????? + ????????????
			wVo.setWarehousing_qty(vo.getIn_menge());
			
			dao.saveWarehouse(wVo);
			
		}
		else if("MD1246".equals(flag) || "MD1249".equals(flag)|| "MD1250".equals(flag)){
				
			SYWarehouseVo wVo = new SYWarehouseVo();
			
			String business_code = "MD1243";
			String business_nm = "Consumable Parts";
			String warehouse_code = "wm20";
			String warehouse_nm = "?????????/??????????????????";
			
			wVo.setBusiness_code(business_code);
			wVo.setBusiness_nm(business_nm);
			wVo.setWarehouse_code(warehouse_code);
			wVo.setWarehouse_nm(warehouse_nm);
			
			
			wVo.setItem_code(vo.getItem_code());
			wVo.setItem_nm(vo.getItem_nm());
			wVo.setItem_spec(vo.getItem_spec());
			wVo.setItem_type_code(vo.getItem_type_code());
			wVo.setItem_type_nm(vo.getItem_type_nm());
			
			wVo.setMeins(vo.getMeins());
			
	
			// menge ??? ???????????? + ????????????
			wVo.setWarehousing_qty(vo.getIn_menge());
			
			dao.saveWarehouse(wVo);
			
		}*/
		
		return 0;
	}


	public int deleteWarehousingProcess(SYWareHousingVo vo) {
		int result = 0;
		
		dao.deleteWarehousing(vo);

		String type = vo.getItem_type_code();
		
		String purchase_order_num = vo.getPurchase_order_num();
		String purchase_num = vo.getPurchase_num();
			
		
		// ????????? Purchase Detail ?????? ????????? ??????.
		SYPurchaseOrderDetailVo podVo = new SYPurchaseOrderDetailVo();
		podVo.setPurchase_order_num(purchase_order_num);
		podVo.setPurchase_num(purchase_num);
		
		podVo.setIn_menge(vo.getIn_menge());
		dao.updatePurchaseOrderDetail_minus(podVo);
		
		// ???????????? ?????? Purchase Detail ????????????, menge , in_menge ?????? ?????????.
		
		String pod_purchase_status = getPurchaseStatusDetail(podVo);
		
		String purchase_end_date = "";
		if("P".equals(pod_purchase_status))
		{
			purchase_end_date = dao.selectLastDate(vo);
		}
		podVo.setPurchase_end_date(purchase_end_date);
		// ????????? ????????????
		podVo.setPurchase_status(pod_purchase_status);
		podVo.setIn_menge("");
		dao.updatePurchaseOrderDetail_minus(podVo);
		
		
		SYPurchaseOrderVo poVo = new SYPurchaseOrderVo();
		poVo.setPurchase_order_num(purchase_order_num);
		
		String po_purchase_status = getPurchaseStatus(purchase_order_num);
		poVo.setPurchase_status(po_purchase_status);

		dao.updatePurchaseOrder(poVo);
		
		

		SYWareHouseRawVo wrVo = new SYWareHouseRawVo();
		
		wrVo.setItem_code(vo.getItem_code());
		wrVo.setSerial_no(vo.getSerial_no());

		
		if("MD1245".equals(type)){
			logger.debug("MD1245.equals(type) ??????.");
			logger.debug("type?????-------111111111" + type);
			
			
			dao.deleteWarehouseRaw(wrVo);
		}else
		{
			
			logger.debug("type?????-------22222222" + type);
			/**
			 * ???????????? ?????? ???????????? ????????? ??? ?????????. ?????? ????????? ????????? ?????? ?????????.
			 *  
			 */
			SYWarehouseVo wVo = new SYWarehouseVo();
			
			wVo.setItem_code(vo.getItem_code());
			wVo.setWarehousing_qty(vo.getIn_menge());
			dao.minusWarehouse(wVo);
		}
		
		return 0;
	}
	
	
	public String getPurchaseStatusDetail(SYPurchaseOrderDetailVo podVo)
	{
		
		List<SYPurchaseOrderDetailVo> purchaseOrderDetailList = dao.selectPurchaseOrderDetail(podVo);
		
		int menge = 0 ;
		int in_menge = 0;
		try{
			menge = Integer.parseInt(purchaseOrderDetailList.get(0).getMenge());
		}catch(Exception e)
		{
			e.getStackTrace();
		}

		try{
			in_menge = Integer.parseInt(purchaseOrderDetailList.get(0).getIn_menge());
		}catch(Exception e)
		{
			e.getStackTrace();
		}
		
		String pod_purchase_status = "R";

		/*
		 * in_menge == 0			-> R ????????????
		 * in_menge > 0 	-> P ????????????
		 * in_menge == menge	-> Y ????????????
		 * 						-> C ?????? ?????? 
		 */
		if(in_menge == 0)
		{
			pod_purchase_status = "R";
			
		}
		if(in_menge > 0)
		{
			pod_purchase_status = "P";
		}
		if(in_menge == menge)
		{
			pod_purchase_status = "Y";
		}
		
		
		return pod_purchase_status;
		
	}

	
	public String getPurchaseStatus(String purchase_order_num)
	{
		SYPurchaseOrderDetailVo podVo = new SYPurchaseOrderDetailVo();
		podVo.setPurchase_order_num(purchase_order_num);
		List<SYPurchaseOrderDetailVo> purchaseOrderDetailList = dao.selectPurchaseOrderDetail(podVo);
		
		String pod_purchase_status = "R";
		
	
		String default_purchase_status = "R";
		// purchaseOrderDetail??? ???????????? ??? ???????????? 1??? ??????, ?????? ?????? status ??? purchaseOrderMaster?????? ?????? ??????.
		if(purchaseOrderDetailList.size() == 1)
		{
			pod_purchase_status = purchaseOrderDetailList.get(0).getPurchase_status();
		}else {
			for(int i = 0; i < purchaseOrderDetailList.size(); i++)
			{
				String purchase_status = purchaseOrderDetailList.get(i).getPurchase_status();
				
				// ??? ?????? ????????? status ??? ??????????????? ?????? ??????.
				if(i == 0)
				{
					default_purchase_status = purchase_status;
					if("P".equals(purchase_status))
					{
						pod_purchase_status = purchase_status;
						break;
					}
				}else
				{
					// 0????????? ????????? status??? ????????? status ?????? ????????????,
					if(!default_purchase_status.equals(purchase_status))
					{
						if("Y".equals(purchase_status))
						{
							if("R".equals(default_purchase_status))
							{
								pod_purchase_status = "P";
								break;
							}

						}else if("P".equals(purchase_status))
						{
							pod_purchase_status = purchase_status;
							break;
						}else if("R".equals(purchase_status))
						{
							if(!"R".equals(default_purchase_status))
							{
								pod_purchase_status = "P";
								break;
							}else
							{
								pod_purchase_status = "R";
							}
						}
					}
					
				}
				
			
			}
		}
		
		


	
		
		return pod_purchase_status;
		
	}
	
	public List<SYWareHouseRawVo> selectWarehouseRaw(SYWareHouseRawVo vo) {
		return dao.selectWarehouseRaw(vo);
	}
	public List<SYWareHouseRawVo> selectWarehouseRawPartition(SYWareHouseRawVo vo) {
		return dao.selectWarehouseRawPartition(vo);
	}
	
	private static final Logger logger = LoggerFactory
			.getLogger(SYWarehousingService.class);
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int rivisionWarehouseRawProcess(SYWareHouseRawVo vo , List<SYWareHouseRawVo> list) {
		int result = 0;
		
		
		/**
		 * 1.?????? ????????? ?????? MAX(division_seq)??? ?????????
		 * 
		 * 
		 * 2.????????? ??????
		 * 
		 * 2.grid ??? insert
		 * 
		 * 
		 */
		
		String division_seq = dao.selectWarehouseRawLastSeq(vo);
		
	
		logger.debug("rivisionWarehouseRawProcess division_seq : " + division_seq);
		dao.deleteWarehouseRaw(vo);
		
		String send_division_seq = division_seq;
				
		for(int i =0; i<list.size(); i++)
		{
			send_division_seq = (Integer.parseInt(send_division_seq) + 1) + "";
			SYWareHouseRawVo wVo = list.get(i);
			wVo.setDivision_seq(send_division_seq);
			dao.insertWarehouseRaw(wVo);
		}
		return 0;
	}
	

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int outWarehouseRawProcess(String product_po,String item_code, List<SYWareHouseRawVo> list) {
		int result = 0;
		
		
		/**
		 * 1.warehouse_raw_tbl 
		 * -> out_warehousing_status = 'o'
		 * -> product_po = ?????? ????????? ?????? ???????????? ??????
		 * 
		 * 
		 * 2.product_tbl 
		 * -> raw_out_yn = 'Y'
		 * 
		 * 
		 */

				
		for(int i =0; i<list.size(); i++)
		{

			SYWareHouseRawVo wVo = list.get(i);
			wVo.setProduct_po(product_po);
			logger.debug("wVo division_seq : " + wVo.getDivision_seq());
			dao.updateWarehouseRawStatus(wVo);
		}
		
		SYProductVO pVo = new SYProductVO();
		pVo.setProduct_po(product_po);
		pVo.setItem_code(item_code);

		dao.updateProductRawStatus(pVo);

		return 0;
	}
	public List<SYWareHousingVo> selectWarehousingMng(SYWareHousingVo vo) {
		return dao.selectWarehousingMng(vo);
	}
	public List<SYWareHousingVo> selectWarehousingMngEtc(SYWareHousingVo vo) {
		return dao.selectWarehousingMngEtc(vo);
	}
	public List<SYWareHouseRawVo> selectWarehouseRawMng(SYWareHouseRawVo vo) {
		return dao.selectWarehouseRawMng(vo);
	}
	
	public List<SYWareHousingVo> selectWarehouseHis(SYWareHousingVo vo) {
		return dao.selectWarehouseHis(vo);
	}

	
	// warehout out
		
	public List<SYWarehouseOutVo> selectWarehouseOut(SYWarehouseOutVo vo) {
		return dao.selectWarehouseOut(vo);
	}
	
	// ?????????????????? - ???????????? - ??????
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveWarehouseIn(SYWareHousingVo wiVo) {
	

		
		wiVo.setIn_menge(wiVo.getWarehousing_qty());
		dao.insertWarehousing(wiVo);
		
		
		
		logger.debug("wVo getItem_code : " + wiVo.getItem_code());
		logger.debug("wVo getWarehousing_qty : " + wiVo.getWarehousing_qty());

		SYWarehouseVo wVo = new SYWarehouseVo();
		
		wVo.setItem_code(wiVo.getItem_code());

		wVo.setWarehousing_qty(wiVo.getWarehousing_qty());
		wVo.setUpdater(wiVo.getUpdater());
		dao.plusWarehouse(wVo);

		return 0;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveWarehouseOut(SYWarehouseOutVo woVo) {
	
		
		dao.saveWarehouseOut(woVo);
		
		
		
		logger.debug("wVo getItem_code : " + woVo.getItem_code());
		logger.debug("wVo getWarehousing_qty : " + woVo.getWarehousing_qty());

		SYWarehouseVo wVo = new SYWarehouseVo();
		
		wVo.setItem_code(woVo.getItem_code());

		wVo.setWarehousing_qty(woVo.getWarehousing_qty());
		wVo.setUpdater(woVo.getUpdater());
		dao.minusWarehouse(wVo);

		return 0;
	}
	
	
	
	

	
	
	
	
}
