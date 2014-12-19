package com.inspur.cams.sorg.jxcheck.somjxviporgan.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxVipOrganDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxVipOrganDao extends BaseCURD<SomJxVipOrgan>{
	public void save(List<SomJxVipOrgan> list);
}

