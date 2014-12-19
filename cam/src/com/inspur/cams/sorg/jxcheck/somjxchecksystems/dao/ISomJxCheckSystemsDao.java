package com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckSystemsDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckSystemsDao extends BaseCURD<SomJxCheckSystems>{
	public void save(List<SomJxCheckSystems> list);
}

