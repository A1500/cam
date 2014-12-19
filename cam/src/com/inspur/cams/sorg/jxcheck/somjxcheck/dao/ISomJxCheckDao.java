package com.inspur.cams.sorg.jxcheck.somjxcheck.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckDao extends BaseCURD<SomJxCheck>{
	public void save(List<SomJxCheck> list);
}

