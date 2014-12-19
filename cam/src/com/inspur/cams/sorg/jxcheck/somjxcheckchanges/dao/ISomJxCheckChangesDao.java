package com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckChangesDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckChangesDao extends BaseCURD<SomJxCheckChanges>{
	public void save(List<SomJxCheckChanges> list);
}

