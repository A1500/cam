package com.inspur.cams.sorg.assess.assesstype.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

/**
 * @title:ISomAssessTypeDao
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public interface ISomAssessTypeDao extends BaseCURD<SomAssessType>{
	 
	@Trans
	public void save(List<SomAssessType> list);
}

