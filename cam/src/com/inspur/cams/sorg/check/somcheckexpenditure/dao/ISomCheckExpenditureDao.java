package com.inspur.cams.sorg.check.somcheckexpenditure.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckExpenditureDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckExpenditureDao extends BaseCURD<SomCheckExpenditure>{
	public void save(List<SomCheckExpenditure> list);
}

