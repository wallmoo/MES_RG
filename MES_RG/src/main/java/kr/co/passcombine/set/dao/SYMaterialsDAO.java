package kr.co.passcombine.set.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository(value = "setMaterialsDAO")
public interface SYMaterialsDAO {


	int insertFile2(Map<String, Object> file);

	int insertMaterialMap2(Map<String, Object> vo);

	Map<String, Object> selectFiles2(Map<String, Object> vo);

	void updateFile2(Map<String, Object> result);

	int updateMaterialMap2(Map<String, Object> vo);

	int insertBOM2(Map<String, Object> vo);

	int updateEstimate2(List<Map<String, Object>> valueList);

	List<Map<String, Object>> selectMaterialNotIO(Map<String, Object> vo);

	List<Map<String, Object>> selectMaterialIO(Map<String, Object> vo);

	int updateEstimateOs1(Map<String, Object> vo);

	int updateEstimateOs2(Map<String, Object> vo);

	int insertEstimateOs1(Map<String, Object> vo);

	Map<String, Object> base_info(Map<String, Object> vo);

	List<Map<String, Object>> info_List_project(Map<String, Object> vo);

}
