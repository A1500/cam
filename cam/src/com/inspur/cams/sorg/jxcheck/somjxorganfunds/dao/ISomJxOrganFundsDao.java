package com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxOrganFundsDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxOrganFundsDao extends BaseCURD<SomJxOrganFunds>{
	public void save(List<SomJxOrganFunds> list);
}

