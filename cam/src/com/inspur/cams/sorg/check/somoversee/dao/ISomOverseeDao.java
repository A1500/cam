package com.inspur.cams.sorg.check.somoversee.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomOverseeDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomOverseeDao extends BaseCURD<SomOversee>{
	public void save(List<SomOversee> list);
}

