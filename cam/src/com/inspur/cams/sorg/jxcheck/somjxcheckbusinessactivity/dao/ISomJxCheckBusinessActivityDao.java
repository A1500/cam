package com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckBusinessActivityDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckBusinessActivityDao extends BaseCURD<SomJxCheckBusinessActivity>{
	public void save(List<SomJxCheckBusinessActivity> list);
}

