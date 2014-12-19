package com.inspur.cams.sorg.check.somcheckpunnish.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckPunnishDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckPunnishDao extends BaseCURD<SomCheckPunnish>{
	public void save(List<SomCheckPunnish> list);
}

