package com.inspur.cams.sorg.check.somcheckaccountingpeople.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckAccountingPeopleDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckAccountingPeopleDao extends BaseCURD<SomCheckAccountingPeople>{
	public void save(List<SomCheckAccountingPeople> list);
}

