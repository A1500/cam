package com.inspur.cams.sorg.jxcheck.somjxactivity.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxActivityDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxActivityDao extends BaseCURD<SomJxActivity>{
	public void save(List<SomJxActivity> list);
}

