package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.online.base.data.SomDutyOnline;

/**
 * @title:ISomDutyOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public interface ISomDutyOnlineDao extends BaseCURD<SomDutyOnline>{
	public void save(List<SomDutyOnline> list);
	
	public DataSet queryPeople(ParameterSet pset);
}

