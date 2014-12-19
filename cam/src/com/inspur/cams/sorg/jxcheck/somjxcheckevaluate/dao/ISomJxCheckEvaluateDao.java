package com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckEvaluateDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckEvaluateDao extends BaseCURD<SomJxCheckEvaluate>{
	public void save(List<SomJxCheckEvaluate> list);
}

