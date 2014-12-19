package com.inspur.cams.sorg.jxcheck.somjxproclamation.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxProclamationDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxProclamationDao extends BaseCURD<SomJxProclamation>{
	public void save(List<SomJxProclamation> list);
}

