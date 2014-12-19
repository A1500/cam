package com.inspur.cams.sorg.jxcheck.somjxchecktask.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckTaskDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckTaskDao extends BaseCURD<SomJxCheckTask>{
	public void save(List<SomJxCheckTask> list);
}

