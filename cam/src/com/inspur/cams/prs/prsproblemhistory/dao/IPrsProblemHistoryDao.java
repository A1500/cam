package com.inspur.cams.prs.prsproblemhistory.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IPrsProblemHistoryDao
 * @description:
 * @author:
 * @since:2011-08-29
 * @version:1.0
*/
 public interface IPrsProblemHistoryDao extends BaseCURD<PrsProblemHistory>{
	public void save(List<PrsProblemHistory> list);
	
	public void updateDealFlag(String problemId);
}

