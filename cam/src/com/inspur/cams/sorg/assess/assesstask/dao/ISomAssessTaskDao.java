package com.inspur.cams.sorg.assess.assesstask.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.assess.assesstask.data.SomAssessTask;

/**
 * @title:ISomAssessTaskDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public interface ISomAssessTaskDao extends BaseCURD<SomAssessTask>{
	 
	@Trans
	public void save(List<SomAssessTask> list);
}

