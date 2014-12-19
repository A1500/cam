package com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckCashFlowDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckCashFlowDao extends BaseCURD<SomJxCheckCashFlow>{
	public void save(List<SomJxCheckCashFlow> list);
}

