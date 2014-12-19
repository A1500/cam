package com.inspur.cams.sorg.assess.assess.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.assess.assess.data.SomAssess;
import com.inspur.cams.sorg.assess.assess.data.SomAssessAssemble;

/**
 * @title:ISomAssessDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public interface ISomAssessDao extends BaseCURD<SomAssess>{
	public void save(List<SomAssess> list);
	
	public  void initTreeData(String assessType,String taskCode);
	
	public  List<SomAssessAssemble> buildTreeData(String assessType,String taskCode,String parentId,List<SomAssessAssemble> allList);
	
	public  List<SomAssessAssemble> getAllTreeData(String assessType,String taskCode,String parentId);
}

