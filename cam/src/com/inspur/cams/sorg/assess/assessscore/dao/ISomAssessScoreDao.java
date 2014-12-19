package com.inspur.cams.sorg.assess.assessscore.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.assess.assessscore.data.SomAssessScore;

/**
 * @title:ISomAssessScoreDao
 * @description:
 * @author:
 * @since:2011-12-09
 * @version:1.0
*/
 public interface ISomAssessScoreDao extends BaseCURD<SomAssessScore>{
	 
	@Trans
	public void save(List<SomAssessScore> list);
	
	@Trans
	public void deleteByTaskCode(String taskCode);
}

