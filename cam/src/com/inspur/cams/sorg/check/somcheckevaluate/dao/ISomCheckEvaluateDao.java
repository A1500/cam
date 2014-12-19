package com.inspur.cams.sorg.check.somcheckevaluate.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckEvaluateDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckEvaluateDao extends BaseCURD<SomCheckEvaluate>{
	public void save(List<SomCheckEvaluate> list);
}

