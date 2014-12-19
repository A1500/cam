package com.inspur.cams.sorg.check.checkevent.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;

/**
 * @title:SomCheckEventQueryCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckEventQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckEvent> dao = (EntityDao<SomCheckEvent>) DaoFactory.getDao("com.inspur.cams.sorg.check.checkevent.dao.SomCheckEventDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckEvent> dao = (EntityDao<SomCheckEvent>) DaoFactory.getDao("com.inspur.cams.sorg.check.checkevent.dao.SomCheckEventDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
