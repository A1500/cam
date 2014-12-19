package com.inspur.cams.sorg.jxcheck.somjxoversee.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxOverseeDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxOverseeDao extends BaseCURD<SomJxOversee>{
	public void save(List<SomJxOversee> list);
}

