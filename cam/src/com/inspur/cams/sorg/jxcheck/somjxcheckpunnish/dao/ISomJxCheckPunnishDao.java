package com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckPunnishDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckPunnishDao extends BaseCURD<SomJxCheckPunnish>{
	public void save(List<SomJxCheckPunnish> list);
}

