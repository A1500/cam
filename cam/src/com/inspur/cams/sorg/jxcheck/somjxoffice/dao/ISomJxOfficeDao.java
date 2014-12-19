package com.inspur.cams.sorg.jxcheck.somjxoffice.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxOfficeDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxOfficeDao extends BaseCURD<SomJxOffice>{
	public void save(List<SomJxOffice> list);
}

