package com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxFundPeopleDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxFundPeopleDao extends BaseCURD<SomJxFundPeople>{
	public void save(List<SomJxFundPeople> list);
}

