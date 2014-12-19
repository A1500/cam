package com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxOrganBasicDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxOrganBasicDao extends BaseCURD<SomJxOrganBasic>{
	public void save(List<SomJxOrganBasic> list);
}

