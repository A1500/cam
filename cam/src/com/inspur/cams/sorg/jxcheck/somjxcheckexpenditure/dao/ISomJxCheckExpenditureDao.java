package com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckExpenditureDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckExpenditureDao extends BaseCURD<SomJxCheckExpenditure>{
	public void save(List<SomJxCheckExpenditure> list);
}

