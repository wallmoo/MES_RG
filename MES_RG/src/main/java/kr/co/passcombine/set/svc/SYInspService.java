package kr.co.passcombine.set.svc;

//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;















import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONArray;
//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.set.dao.SYInspDAO;
import kr.co.passcombine.set.dao.SYProductDAO;
import kr.co.passcombine.set.vo.SYIncome_resultVo;
import kr.co.passcombine.set.vo.SYInspVO;
import kr.co.passcombine.set.vo.SYMaterialVo;
import kr.co.passcombine.set.vo.SYPrintVO;
import kr.co.passcombine.set.vo.SYProductOperationVO;
import kr.co.passcombine.set.vo.SYProductVO;
import kr.co.passcombine.set.vo.SYQualityFileVo;
import kr.co.passcombine.set.vo.SYRoutingMasterVo;



@Service(value = "setInspService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYInspService {

	@Resource
	private Environment environment;
	
	@Resource(name = "setInspDAO")
	private SYInspDAO inspDAO;

	@Resource(name = "setProductDAO")
	private SYProductDAO prodDao;
	
	public List<SYProductVO> selcInspMain(SYProductVO vo) {
		return inspDAO.selcInspMain(vo);
	}

	public List<SYInspVO> selcInspChkSht(SYInspVO vo) {
		
		List<SYInspVO> list = new ArrayList<SYInspVO>();
		
		if(vo.getRouting_code().substring(0, 1).equals("Z"))
		{
			list = inspDAO.selcSuipInspChkSht(vo);
		} else {
			list = inspDAO.selcInspChkSht(vo);
		}
		
		
		return list;
	}

	public List<SYInspVO> selcInspVal(SYInspVO vo) {
		return inspDAO.selcInspVal(vo);
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveInspVal(List<SYInspVO> list) {
		
		int result = 0;
		int dfct_cnt = 0;
//		int updateProdOprt = 0;
		
		//result = inspDAO.delInspVal(list.get(0));
		
		
		//입력값이 있는 상태에서 NG처리 된 항목만 해당 체크시트의 검사항목에서 NG 발생 수량 처리..입력값이 없는 항목은 다른 검사항목에서 이미 NG처리된 내역임..
		for(int i=0 ; i<list.size(); i++)
		{
			if(list.get(i).getInsp_rst().equals("NG") && list.get(i).getInsp_val().length() != 0)
			{
				dfct_cnt++;
			}
		}
		
		int product_menge =  Integer.parseInt(list.get(0).getProduct_menge());
		
		String s_dfct_cnt = Integer.toString(dfct_cnt);
		
		//초물, 중물, 말물 관리가 없어짐.. 종물하나에만 데이터 관리함.. a_dfct_cnt, b_dfct_cnt는  항상 null로 처리..c_dfct_cnt 컬럼만 관리
		if(list.get(0).getSample_type().equals("a"))
		{
			list.get(0).setA_dfct_cnt(s_dfct_cnt);
		}
		if(list.get(0).getSample_type().equals("b"))
		{
			list.get(0).setB_dfct_cnt(s_dfct_cnt);
		}
		if(list.get(0).getSample_type().equals("c"))
		{
			list.get(0).setC_dfct_cnt(s_dfct_cnt);
		}
		
		result = inspDAO.updtChkShtDfctCnt(list.get(0));
		
		String product_po = list.get(0).getProduct_po();
		String item_code = list.get(0).getItem_code();
		String routing_code = list.get(0).getRouting_code();
		String inspection_seq = list.get(0).getInspection_seq();
		String val_seq = list.get(0).getVal_seq();
		String sample_type = list.get(0).getSample_type();
		String insp_case = list.get(0).getInsp_case();
		String insp_val = list.get(0).getInsp_val();
		String insp_rst = list.get(0).getInsp_rst();
		String min_spec = list.get(0).getMin_spec();
		String creator = list.get(0).getCreator();
		String updater = list.get(0).getUpdater();

		///////////////////////////////////////////////////////////////////
		SYInspVO mVo = new SYInspVO();
		
		mVo.setProduct_po(product_po);
		mVo.setItem_code(item_code);
		mVo.setRouting_code(routing_code); 
		
//		int chkList = inspDAO.chkInspVal(mVo);
//		
//		if(chkList == 0)
//		{
//			updateProdOprt++;	//체크시트 내 검사 항목에 최초로 값이 입력될 때 생산쪽 테이블에 시작시간을 업데이트해주기 위한 flag 
//		}
		
		List<SYInspVO> tatalInfoList = new JSONArray();
		SYInspVO kVo = new SYInspVO();
		
		kVo.setProduct_po(product_po);
		kVo.setItem_code(item_code);
		kVo.setRouting_code(routing_code); 
		kVo.setInspection_seq(inspection_seq);
		
		tatalInfoList = inspDAO.selcInspNgCnt(kVo);
		
		
		///////////////////////////////////////////////////////////////////
		for(int i=0;i<product_menge;i++)
		{
			SYInspVO pVo = new SYInspVO();
		
			pVo.setProduct_po(product_po);
			pVo.setItem_code(item_code);
			pVo.setRouting_code(routing_code); 
			pVo.setInspection_seq(inspection_seq); 
			pVo.setSample_type(sample_type);
			pVo.setInsp_case(insp_case);
			pVo.setCreator(creator);
			pVo.setUpdater(updater);
		
			int flag = 0;
			
			for(int j=0;j<list.size();j++) {
				if(list.get(j).getVal_seq().equals(Integer.toString(i+1)))
				{
					flag++;
					
					//입렵값이 있을 때 
					if(list.get(j).getInsp_val().length() > 0)
					{
						pVo.setVal_seq(Integer.toString(i+1));
						pVo.setInsp_val(list.get(j).getInsp_val());
						pVo.setInsp_rst(list.get(j).getInsp_rst());
					} 
					
					//입렵값이 없을 때
					if(list.get(j).getInsp_val().length() == 0)
					{
						if(tatalInfoList.size() > 0)
						{
							for(int k=0;k<tatalInfoList.size();k++) {
								if(list.get(j).getVal_seq().equals(tatalInfoList.get(k).getVal_seq()))
								{
									int a_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_a());
									int b_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_b());
									int c_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_c());

									if(a_insp_ng_cnt > 0 || b_insp_ng_cnt > 0 || c_insp_ng_cnt > 0)			//product_po 내 각 공정, 각 검사항목 내 하나라도 NG가 있으면 a_insp_ng_cnt,b_insp_ng_cnt,c_insp_ng_cnt 항목에 1 반환
									{
										pVo.setVal_seq(Integer.toString(i+1));
										pVo.setInsp_val("");
										pVo.setInsp_rst("NG");	
									} else {
										pVo.setVal_seq(Integer.toString(i+1));
										pVo.setInsp_val("");
										pVo.setInsp_rst("OK");
									}
									
								}
							}
						} else {																			//해당 공정, 해당 검사 항목 내 과거 이력이 없는 상태에서 저장 버튼을 누르면 모두 OK 처리
							pVo.setVal_seq(Integer.toString(i+1));
							pVo.setInsp_val("");
							pVo.setInsp_rst("OK");
						}
					}
				}
			}
			
			if(flag == 0)
			{
				if(tatalInfoList.size() > 0)
				{
					for(int k=0;k<tatalInfoList.size();k++) {
						
						
						if(tatalInfoList.get(k).getVal_seq().equals(Integer.toString(i+1)))
						{
							int a_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_a());
							int b_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_b());
							int c_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_c());

							if(a_insp_ng_cnt > 0 || b_insp_ng_cnt > 0 || c_insp_ng_cnt > 0)
							{
								pVo.setVal_seq(Integer.toString(i+1));
								pVo.setInsp_val("");
								pVo.setInsp_rst("NG");	
							} else {
								pVo.setVal_seq(Integer.toString(i+1));
								pVo.setInsp_val("");
								pVo.setInsp_rst("OK");	
							}
						}
					}
				} else {
					pVo.setVal_seq(Integer.toString(i+1));
					pVo.setInsp_val("");
					pVo.setInsp_rst("OK");
				}
			}
			
			result = inspDAO.saveInspVal(pVo);
		}		
		
//		if(updateProdOprt > 0)
//		{
//			result = inspDAO.updateProdSrtInfo(list.get(0));
//			result = inspDAO.updateProdOprtSrtInfo(list.get(0));
//		}
		
		return result;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveChkSht(List<SYInspVO> list) {
	int result = 0;
		
		for(int i=0;i<list.size();i++)
		{
			result = inspDAO.saveChkSht(list.get(i));
		}
		
		return result;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int fnshChkShtData(SYInspVO vo) {
		int result = 0;
		result = inspDAO.fnshChkShtData(vo);
		
		int chkFlag = inspDAO.chkInspEnd(vo);
		
		if(chkFlag == 1)
		{
			
			int nextRowExistChk = inspDAO.selcProdEndInfo(vo);
			//0이면 다음 공정라우팅 없음...
			
			if(nextRowExistChk == 0)
			{
				vo.setNext_row_flag("Y");
				result = inspDAO.updateProdEndInfo(vo);
				result = inspDAO.updateProdOprtEndInfo(vo);
			}
			else
			{
				vo.setNext_row_flag("");
				result = inspDAO.updateProdEndInfo(vo);
				result = inspDAO.updateProdOprtEndInfo(vo);
			}
			
			
			if(StringUtils.defaultString(vo.getWarehouse_gubun()).equals("b"))
			{
				result = inspDAO.instWarehousingInfo(vo);
				int warehouseQty = inspDAO.selecWarehouseInfo(vo);
				vo.setWarehousing_qty(warehouseQty);
				result = inspDAO.instWarehouseInfo(vo);
			} 
			
			//다음 검사 정보 미리 생성
			List<SYInspVO> nowInspNgInfo = inspDAO.nowInspNgInfo(vo);
			
			int rtngNextRowNum = inspDAO.nextInspNum(vo);
			vo.setNext_row_num(rtngNextRowNum);
			List<SYInspVO> NextRtngInfo = inspDAO.nextRtngInfo(vo);
			if(NextRtngInfo.size() > 0)
			{
				String rtng_code = NextRtngInfo.get(0).getRouting_code();
				SYInspVO dVo = new SYInspVO();
				dVo.setProduct_po(vo.getProduct_po());
				dVo.setRouting_code(rtng_code);
				
				
				List<SYInspVO> nextInspInfo = inspDAO.nextInspInfo(dVo);
				
				
				
				
				for(int i=0 ; i<nextInspInfo.size(); i++)
				{
					//다음 라우팅 체크시트 생성
					nextInspInfo.get(i).setCreator(vo.getCreator());
					nextInspInfo.get(i).setUpdater(vo.getUpdater());	
					result = inspDAO.saveChkSht(nextInspInfo.get(i));
					
					int product_menge = Integer.parseInt(nextInspInfo.get(0).getProduct_menge());
					//다음 라우팅 측정데이터 생성
					for(int j=0 ; j<product_menge; j++)
					{
						nextInspInfo.get(i).setCreator(vo.getCreator());
						nextInspInfo.get(i).setUpdater(vo.getUpdater());
						
						nextInspInfo.get(i).setVal_seq((j+1)+ "");
						
						int flag = 0;
						for(int k=0 ; k<nowInspNgInfo.size(); k++)
						{
							if(nowInspNgInfo.get(k).getVal_seq().equals(j+1+"")){
								nextInspInfo.get(i).setInsp_rst("NG");
								flag++;
							}
						}
						
						if(flag == 0)
						{
							nextInspInfo.get(i).setInsp_rst("");
						}
						nextInspInfo.get(i).setInsp_val("");
						
						nextInspInfo.get(i).setSample_type("a");
						result = inspDAO.saveInspVal(nextInspInfo.get(i));
						nextInspInfo.get(i).setSample_type("b");
						result = inspDAO.saveInspVal(nextInspInfo.get(i));
						nextInspInfo.get(i).setSample_type("c");
						result = inspDAO.saveInspVal(nextInspInfo.get(i));
					}	
					
				}
				
			}
			
			
			
			
		}
		
		return chkFlag; 
	}

	public List<SYInspVO> selcInspNgCnt(SYInspVO vo) {
		return inspDAO.selcInspNgCnt(vo);
	}

	public List<SYInspVO> selcInspRstVal(SYInspVO vo) {
		
		List<SYInspVO> list = new ArrayList<SYInspVO>();
		
		if(vo.getRouting_code().substring(0, 1).equals("Z"))
		{
			list = inspDAO.selcSuipInspRstVal(vo);
		} else {
			list = inspDAO.selcInspRstVal(vo);
		}
		
		
		return list;		
	}

	public List<SYProductVO> selcInspMain_final(SYProductVO vo) {
		return inspDAO.selcInspMain_final(vo);
	}

	public List<SYProductVO> selcInspMain_his(SYProductVO vo) {
		return inspDAO.selcInspMain_his(vo);
	}
	
	public List<SYProductVO> selcInspMain_final_his(SYProductVO vo) {
		return inspDAO.selcInspMain_final_his(vo);
	}

	public List<SYMaterialVo> qLoadItemCode(SYMaterialVo vo) {
		return inspDAO.qLoadItemCode(vo);
	}

	public List<SYInspVO> getRtngInfo(SYInspVO vo) {
		return inspDAO.getRtngInfo(vo);
	}

	public List<SYInspVO> getQAnalData_1(SYInspVO vo) {
		return inspDAO.getQAnalData_1(vo);
	}

	public List<SYInspVO> getQAnalData_2(SYInspVO vo) {
		return inspDAO.getQAnalData_2(vo);
	}

	public List<SYQualityFileVo> getPnImg(SYQualityFileVo vo) {
		return inspDAO.getPnImg(vo);
	}

	public List<SYInspVO> getInspInfo(SYInspVO vo) {
		return inspDAO.getInspInfo(vo);
	}

	public List<SYInspVO> dfctKpiGraph(SYInspVO vo) {
		return inspDAO.dfctKpiGraph(vo);
	}

	public List<SYInspVO> dfctKpiLtGrid(SYInspVO vo) {
		return inspDAO.dfctKpiLtGrid(vo);
	}

	public List<SYInspVO> dfctKpiRtGrid(SYInspVO vo) {
		return inspDAO.dfctKpiRtGrid(vo);
	}

	public int saveFirstChkSht(SYInspVO vo) {
		return inspDAO.saveFirstChkSht(vo);
	}

	public List<SYInspVO> chkSheetData(SYInspVO vo) {
		return inspDAO.chkSheetData(vo);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public List<SYInspVO> rtngInspInfo(SYInspVO vo) {
		
		
		List<SYInspVO> chkSheetData = inspDAO.chkSheetData(vo);
		List<SYInspVO> inspValData = inspDAO.selcInspVal(vo);
		
		//첫번째 검사 공정 시작할때 val 테이블 데이터 만들어 줘야함...
		
		
		return inspDAO.rtngInspInfo(vo);
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveTotInspVal(List<List<SYInspVO>> t_list) {
		
		int result = 0;
		
		for(int i=0 ; i<t_list.size(); i++)
		{
			if(i == 0)
			{ 
				result = inspDAO.updtChkSht(t_list.get(0).get(0));				
			}
			result = saveNewInspVal(t_list.get(i));
		}
	
		
		updateInspRst(t_list.get(0).get(0));
		
		
		return result;
	}

	
	public int updateInspRst(SYInspVO vo) {
		
		int result = 0;
		SYInspVO kVo = new SYInspVO();
		
		kVo.setProduct_po(vo.getProduct_po());
		kVo.setItem_code(vo.getItem_code());
		kVo.setRouting_code(vo.getRouting_code()); 
		
		List<SYInspVO> tatalInfoList = inspDAO.selcInspNgCnt(kVo);
		for(int k=0 ; k<tatalInfoList.size(); k++)
		{
			String v_seq = tatalInfoList.get(k).getVal_seq();
			String v_insp_cnt_c = tatalInfoList.get(k).getInsp_cnt_c();
			
			if(v_insp_cnt_c.equals("0"))
			{
				kVo.setInsp_rst("OK");
				kVo.setVal_seq(v_seq);
				
				result = inspDAO.updateInspRst(kVo);
			}
		}
		
		return result;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveFirstInspData(SYInspVO vo) {
		
		int result = 0;
				
		if(vo.getRouting_code().substring(0, 1).equals("Z"))
		{
			result = inspDAO.saveFirstSuipChkSht(vo);
			result = inspDAO.saveFirstSuipInspVal(vo);
		} else {
			result = inspDAO.saveFirstChkSht(vo);
			result = inspDAO.saveFirstInspVal(vo);
		}
		
		return result;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int fnshInspData(SYInspVO vo) {
		int result = 0;
		result = inspDAO.fnshInspData(vo);
		
		int chkFlag = inspDAO.chkInspEnd(vo);
		
		System.out.println("chkFlag###############################################");
		System.out.println(chkFlag);
		
		if(chkFlag == 1)
		{
			int nextRowExistChk = inspDAO.selcProdEndInfo(vo);
			//0이면 다음 공정라우팅 없음...

			System.out.println("다음 라우팅 존재 유무확인###############################################");
			System.out.println(nextRowExistChk);
			
			
			if(nextRowExistChk == 0)
			{
				vo.setNext_row_flag("Y");
				result = inspDAO.updateProdEndInfo(vo);
				result = inspDAO.updateProdOprtEndInfo(vo);
				
				System.out.println("라우팅 구분자 확인###############################################");
				System.out.println(vo.getProduct_po().substring(0, 1));
				
				if(vo.getProduct_po().substring(0, 1).equals("S")){
					vo.setPurchase_status("S");
					
					String prod_menge = inspDAO.getSuipMengeInfo(vo);
					vo.setProd_menge(prod_menge);
					
					result = inspDAO.savePrcInsp(vo);
				}
				
			}
			else
			{
				vo.setNext_row_flag("");
				result = inspDAO.updateProdEndInfo(vo);
				result = inspDAO.updateProdOprtEndInfo(vo);
			}
			
			if(StringUtils.defaultString(vo.getWarehouse_gubun()).equals("b"))
			{
				result = inspDAO.instWarehousingInfo(vo);
				int warehouseQty = inspDAO.selecWarehouseInfo(vo);
				vo.setWarehousing_qty(warehouseQty);
				result = inspDAO.instWarehouseInfo(vo);
			} 
			
			//다음 검사 정보 미리 생성
			
			if(!vo.getRouting_code().substring(0, 1).equals("Z"))
			{
			
				List<SYInspVO> nowInspNgInfo = inspDAO.nowInspNgInfo(vo);
				
				int rtngNextRowNum = inspDAO.nextInspNum(vo);
				vo.setNext_row_num(rtngNextRowNum);
				List<SYInspVO> NextRtngInfo = inspDAO.nextRtngInfo(vo);
				if(NextRtngInfo.size() > 0)
				{
					String rtng_code = NextRtngInfo.get(0).getRouting_code();
					SYInspVO dVo = new SYInspVO();
					dVo.setProduct_po(vo.getProduct_po());
					dVo.setRouting_code(rtng_code);
					
					List<SYInspVO> nextInspInfo = inspDAO.nextInspInfo(dVo);
					
					for(int i=0 ; i<nextInspInfo.size(); i++)
					{
						//다음 라우팅 체크시트 생성
						nextInspInfo.get(i).setCreator(vo.getCreator());
						nextInspInfo.get(i).setUpdater(vo.getUpdater());	
						result = inspDAO.saveChkSht(nextInspInfo.get(i));
						
						int product_menge = Integer.parseInt(nextInspInfo.get(0).getProduct_menge());
						//다음 라우팅 측정데이터 생성
						for(int j=0 ; j<product_menge; j++)
						{
							nextInspInfo.get(i).setCreator(vo.getCreator());
							nextInspInfo.get(i).setUpdater(vo.getUpdater());
							
							nextInspInfo.get(i).setVal_seq((j+1)+ "");
							
							int flag = 0;
							for(int k=0 ; k<nowInspNgInfo.size(); k++)
							{
								if(nowInspNgInfo.get(k).getVal_seq().equals(j+1+"")){
									nextInspInfo.get(i).setInsp_rst("NG");
									flag++;
								}
							}
							
							if(flag == 0)
							{
								nextInspInfo.get(i).setInsp_rst("");
							}
							nextInspInfo.get(i).setInsp_val("");
							
							nextInspInfo.get(i).setSample_type("a");
							result = inspDAO.saveInspVal(nextInspInfo.get(i));
							nextInspInfo.get(i).setSample_type("b");
							result = inspDAO.saveInspVal(nextInspInfo.get(i));
							nextInspInfo.get(i).setSample_type("c");
							result = inspDAO.saveInspVal(nextInspInfo.get(i));
						}	
					}
				}
			}
			
		}
		return chkFlag; 
	}

	public int chkInspIng(SYInspVO vo) {
		return inspDAO.chkInspIng(vo);
	}

	public List<SYInspVO> selcSuipInspVal(SYInspVO vo) {
		return inspDAO.selcSuipInspVal(vo);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveFirstSuipInspData(SYInspVO vo) {
		int result = inspDAO.saveFirstSuipChkSht(vo);
		result = inspDAO.saveFirstSuipInspVal(vo);
		return result;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int saveTotSuipInspVal(List<List<SYInspVO>> t_list) {
		
		int result = 0;
		
		for(int i=0 ; i<t_list.size(); i++)
		{
			if(i == 0)
			{ 
				result = inspDAO.updtChkSht(t_list.get(0).get(0));				
			}
			result = saveInspVal(t_list.get(i));
		}
		
		String prod_menge = inspDAO.getOrdCntInfo(t_list.get(0).get(0));
		t_list.get(0).get(0).setProd_menge(prod_menge);
		t_list.get(0).get(0).setPurchase_status("I");
		result = inspDAO.saveOrdInspInfo(t_list.get(0).get(0));
		
		return result;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public int fnshSuipInspData(SYInspVO vo) {
		int result = inspDAO.fnshInspData(vo);
		vo.setPurchase_status("S");
		result = inspDAO.saveOrdInspInfo(vo);
		return result; 
	}
	
	public int saveNewInspVal(List<SYInspVO> list) {
		
		int result = 0;
		int dfct_cnt = 0;
		int updateProdOprt = 0;
		
		//result = inspDAO.delInspVal(list.get(0));
		
		
		//입력값이 있는 상태에서 NG처리 된 항목만 해당 체크시트의 검사항목에서 NG 발생 수량 처리..입력값이 없는 항목은 다른 검사항목에서 이미 NG처리된 내역임..
		for(int i=0 ; i<list.size(); i++)
		{
			if(list.get(i).getInsp_rst().equals("NG") && list.get(i).getInsp_val().length() != 0)
			{
				dfct_cnt++;
			}
		}
		
		int product_menge =  Integer.parseInt(list.get(0).getProduct_menge());
		
		String s_dfct_cnt = Integer.toString(dfct_cnt);
		
		//초물, 중물, 말물 관리가 없어짐.. 종물하나에만 데이터 관리함.. a_dfct_cnt, b_dfct_cnt는  항상 null로 처리..c_dfct_cnt 컬럼만 관리
		if(list.get(0).getSample_type().equals("a"))
		{
			list.get(0).setA_dfct_cnt(s_dfct_cnt);
		}
		if(list.get(0).getSample_type().equals("b"))
		{
			list.get(0).setB_dfct_cnt(s_dfct_cnt);
		}
		if(list.get(0).getSample_type().equals("c"))
		{
			list.get(0).setC_dfct_cnt(s_dfct_cnt);
		}
		
		result = inspDAO.updtChkShtDfctCnt(list.get(0));
		
		String product_po = list.get(0).getProduct_po();
		String item_code = list.get(0).getItem_code();
		String routing_code = list.get(0).getRouting_code();
		String inspection_seq = list.get(0).getInspection_seq();
		String val_seq = list.get(0).getVal_seq();
		String sample_type = list.get(0).getSample_type();
		String insp_case = list.get(0).getInsp_case();
		String insp_val = list.get(0).getInsp_val();
		String insp_rst = list.get(0).getInsp_rst();
		String min_spec = list.get(0).getMin_spec();
		String creator = list.get(0).getCreator();
		String updater = list.get(0).getUpdater();

		///////////////////////////////////////////////////////////////////
		SYInspVO mVo = new SYInspVO();
		
		mVo.setProduct_po(product_po);
		mVo.setItem_code(item_code);
		mVo.setRouting_code(routing_code); 
		
		int chkList = inspDAO.chkInspVal(mVo);
		
		if(chkList == 0)
		{
			updateProdOprt++;	//체크시트 내 검사 항목에 최초로 값이 입력될 때 생산쪽 테이블에 시작시간을 업데이트해주기 위한 flag 
		}
		
		List<SYInspVO> tatalInfoList = new JSONArray();
		SYInspVO kVo = new SYInspVO();
		
		kVo.setProduct_po(product_po);
		kVo.setItem_code(item_code);
		kVo.setRouting_code(routing_code); 
		kVo.setInspection_seq(inspection_seq);
		
		tatalInfoList = inspDAO.selcInspNgCnt(kVo);
		
		
		///////////////////////////////////////////////////////////////////
		for(int i=0;i<product_menge;i++)
		{
			SYInspVO pVo = new SYInspVO();
		
			pVo.setProduct_po(product_po);
			pVo.setItem_code(item_code);
			pVo.setRouting_code(routing_code); 
			pVo.setInspection_seq(inspection_seq); 
			pVo.setSample_type(sample_type);
			pVo.setInsp_case(insp_case);
			pVo.setCreator(creator);
			pVo.setUpdater(updater);
		
			int flag = 0;
			
			for(int j=0;j<list.size();j++) {
				if(list.get(j).getVal_seq().equals(Integer.toString(i+1)))
				{
					flag++;
					
					//입렵값이 있을 때 
					if(list.get(j).getInsp_val().length() > 0)
					{
						pVo.setVal_seq(Integer.toString(i+1));
						pVo.setInsp_val(list.get(j).getInsp_val());
						pVo.setInsp_rst(list.get(j).getInsp_rst());
					} 
					
					//입렵값이 없을 때
					if(list.get(j).getInsp_val().length() == 0)
					{
						if(tatalInfoList.size() > 0)
						{
							for(int k=0;k<tatalInfoList.size();k++) {
								if(list.get(j).getVal_seq().equals(tatalInfoList.get(k).getVal_seq()))
								{
									int a_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_a());
									int b_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_b());
									int c_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_c());

									if(a_insp_ng_cnt > 0 || b_insp_ng_cnt > 0 || c_insp_ng_cnt > 0)			//product_po 내 각 공정, 각 검사항목 내 하나라도 NG가 있으면 a_insp_ng_cnt,b_insp_ng_cnt,c_insp_ng_cnt 항목에 1 반환
									{
										pVo.setVal_seq(Integer.toString(i+1));
										pVo.setInsp_val("");
										pVo.setInsp_rst("NG");	
									} else {
										pVo.setVal_seq(Integer.toString(i+1));
										pVo.setInsp_val("");
										pVo.setInsp_rst("OK");
									}
									
								}
							}
						} else {																			//해당 공정, 해당 검사 항목 내 과거 이력이 없는 상태에서 저장 버튼을 누르면 모두 OK 처리
							pVo.setVal_seq(Integer.toString(i+1));
							pVo.setInsp_val("");
							pVo.setInsp_rst("OK");
						}
					}
				}
			}
			
			if(flag == 0)
			{
				if(tatalInfoList.size() > 0)
				{
					for(int k=0;k<tatalInfoList.size();k++) {
						
						
						if(tatalInfoList.get(k).getVal_seq().equals(Integer.toString(i+1)))
						{
							int a_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_a());
							int b_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_b());
							int c_insp_ng_cnt = Integer.parseInt(tatalInfoList.get(k).getInsp_cnt_c());

							if(a_insp_ng_cnt > 0 || b_insp_ng_cnt > 0 || c_insp_ng_cnt > 0)
							{
								pVo.setVal_seq(Integer.toString(i+1));
								pVo.setInsp_val("");
								pVo.setInsp_rst("NG");	
							} else {
								pVo.setVal_seq(Integer.toString(i+1));
								pVo.setInsp_val("");
								pVo.setInsp_rst("OK");	
							}
						}
					}
				} else {
					pVo.setVal_seq(Integer.toString(i+1));
					pVo.setInsp_val("");
					pVo.setInsp_rst("OK");
				}
			}
			
			result = inspDAO.saveInspVal(pVo);
		}		
		
		//시작시간 버튼 입력방식으로 변경.
//		if(updateProdOprt > 0)
//		{
//			result = inspDAO.updateProdSrtInfo(list.get(0));
//			result = inspDAO.updateProdOprtSrtInfo(list.get(0));
//		}
		
		return result;
	}

	public int chkInspIptCnt(SYInspVO vo) {
		return inspDAO.chkInspIptCnt(vo);
	}
	

	public List<SYIncome_resultVo> selectIncome_result_s(SYIncome_resultVo vo) {
		return inspDAO.selectIncome_result_s(vo);
	}
	public List<SYIncome_resultVo> selectIncome_result2_s(SYIncome_resultVo vo) {
		return inspDAO.selectIncome_result2_s(vo);
	}
	public List<SYIncome_resultVo> selectIncome_result3_s(SYIncome_resultVo vo) {
		return inspDAO.selectIncome_result3_s(vo);
	}

	public int chkProdStrt(SYInspVO vo) {
		return inspDAO.chkProdStrt(vo);
	}

	public int strtInspData(SYInspVO vo) {
		int result = 0;
		result = inspDAO.updateInspMstInfo(vo);
		result = inspDAO.updateProdSrtInfo(vo);
		result = inspDAO.updateProdOprtSrtInfoBtn(vo);
		
//		System.out.println("************** vo.getProduct_po().substring(0, 1)");
//		System.out.println(vo.getProduct_po().substring(0, 1));
//		if(vo.getProduct_po().substring(0, 1).equals("S")){
//			
//			int flag = inspDAO.suipStrtRtngChk(vo);	// 1이면 첫번째 라우팅.. 0이면 첫번째 라우팅이 아님
//			
//			System.out.println("************** flag");
//			System.out.println(flag);
//			
//			if(flag == 1)
//			{
//				vo.setPurchase_status("I");
//				result = inspDAO.savePrcInsp(vo);	
//			}
//		}
		return result;
	}

	public List<SYInspVO> selectDfctGrph(SYInspVO vo) {
		return inspDAO.selectDfctGrph(vo);
	}

	public List<SYInspVO> selectDfctGrphLt(SYInspVO vo) {
		return inspDAO.selectDfctGrphLt(vo);
	}

	public List<SYInspVO> selectDfctGrphRt(SYInspVO vo) {
		return inspDAO.selectDfctGrphRt(vo);
	}

	public int chkSuipInspIptCnt(SYInspVO vo) {
		return inspDAO.chkSuipInspIptCnt(vo);
	}

	public List<SYPrintVO> selectPrtInfo(SYPrintVO vo) {
		return inspDAO.selectPrtInfo(vo);
	}

	public List<SYInspVO> selectDfctGrphMd(SYInspVO vo) {
		return inspDAO.selectDfctGrphMd(vo);
	}

	public int initInspInfo(SYInspVO vo) {
		int result = 0;
		result = inspDAO.initInspValInfo(vo);
		result = inspDAO.initInspChkInfo(vo);
		result = inspDAO.initProdSrtInfo(vo);
		result = inspDAO.initProdOprtSrtInfoBtn(vo);
		
		return result;
	}

	public List<SYInspVO> export_fnsh_insp(SYInspVO vo) {
		return inspDAO.export_fnsh_insp(vo);
	}

	public List<SYInspVO> selcSuipInspOrd(SYInspVO vo) {
		return inspDAO.selcSuipInspOrd(vo);
	}

	public int confirmSuipInsp(SYInspVO vo) {
		int result = 0;
		
		String product_po = inspDAO.selectInspOrderNum();
		vo.setProduct_po(product_po);
		result = inspDAO.confirmSuipInsp(vo);
		
		SYProductVO pVo = new SYProductVO();
		
		Date date_now = new Date(System.currentTimeMillis());
		SimpleDateFormat fourteen_format = new SimpleDateFormat("yyyy-MM-dd"); 
		String nowDate = fourteen_format.format(date_now);
		
		pVo.setProduct_po(product_po);
		pVo.setProduct_class("f");
		pVo.setProduct_req_date(nowDate);
		pVo.setItem_code(vo.getItem_code());
		pVo.setItem_nm(vo.getItem_nm());
		pVo.setProduct_menge(vo.getProduct_menge());
		pVo.setCreator(vo.getCreator());
		pVo.setUpdater(vo.getUpdater());
		
		prodDao.saveProduct(pVo);
		
		SYRoutingMasterVo rVo = new SYRoutingMasterVo();
		rVo.setItem_code(vo.getItem_code());
		rVo.setCreator(vo.getCreator());
		rVo.setUpdater(vo.getUpdater());
		List<SYRoutingMasterVo> routingList = prodDao.selectRouting_master(rVo);
		
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
			
			poVo.setCreator(vo.getCreator());
			poVo.setUpdater(vo.getUpdater());
			
			prodDao.saveProductOperation(poVo);
			
		}
		
		return result;
	}
}
