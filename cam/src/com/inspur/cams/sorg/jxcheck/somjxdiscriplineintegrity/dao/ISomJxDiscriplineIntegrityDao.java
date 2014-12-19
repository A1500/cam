package com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxDiscriplineIntegrityDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxDiscriplineIntegrityDao extends BaseCURD<SomJxDiscriplineIntegrity>{
	public void save(List<SomJxDiscriplineIntegrity> list);
}

