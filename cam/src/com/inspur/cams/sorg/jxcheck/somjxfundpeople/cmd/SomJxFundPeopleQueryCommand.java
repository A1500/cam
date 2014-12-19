package com.inspur.cams.sorg.jxcheck.somjxfundpeople.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.*;

/**
 * @title:SomJxFundPeopleQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxFundPeopleQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxFundPeople> dao = (EntityDao<SomJxFundPeople>) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeopleDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxFundPeople> dao = (EntityDao<SomJxFundPeople>) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeopleDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
