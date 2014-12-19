package com.inspur.cams.sorg.jxcheck.somjxpeople.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxPeopleDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxPeopleDao extends BaseCURD<SomJxPeople>{
	public void save(List<SomJxPeople> list);
}

