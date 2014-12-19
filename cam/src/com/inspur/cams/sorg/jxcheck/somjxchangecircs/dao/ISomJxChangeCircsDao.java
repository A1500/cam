package com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxChangeCircsDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxChangeCircsDao extends BaseCURD<SomJxChangeCircs>{
	public void save(List<SomJxChangeCircs> list);
}

