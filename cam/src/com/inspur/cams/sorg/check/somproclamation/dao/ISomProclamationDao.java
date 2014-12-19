package com.inspur.cams.sorg.check.somproclamation.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomProclamationDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomProclamationDao extends BaseCURD<SomProclamation>{
	public void save(List<SomProclamation> list);
}

