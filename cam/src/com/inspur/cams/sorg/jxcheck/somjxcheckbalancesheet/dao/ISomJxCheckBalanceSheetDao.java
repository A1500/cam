package com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckBalanceSheetDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckBalanceSheetDao extends BaseCURD<SomJxCheckBalanceSheet>{
	public void save(List<SomJxCheckBalanceSheet> list);
}

