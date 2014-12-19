package com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckInMarketDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckInMarketDao extends BaseCURD<SomJxCheckInMarket>{
	public void save(List<SomJxCheckInMarket> list);
}

