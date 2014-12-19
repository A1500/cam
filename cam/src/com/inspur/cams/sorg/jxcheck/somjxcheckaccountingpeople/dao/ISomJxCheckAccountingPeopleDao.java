package com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckAccountingPeopleDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckAccountingPeopleDao extends BaseCURD<SomJxCheckAccountingPeople>{
	public void save(List<SomJxCheckAccountingPeople> list);
}

