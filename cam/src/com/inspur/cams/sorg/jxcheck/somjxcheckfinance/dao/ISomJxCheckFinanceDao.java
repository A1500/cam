package com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckFinanceDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckFinanceDao extends BaseCURD<SomJxCheckFinance>{
	public void save(List<SomJxCheckFinance> list);
}

