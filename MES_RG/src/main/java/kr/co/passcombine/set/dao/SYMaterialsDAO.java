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

}
