package com.inspur.cams.sorg.jxcheck.somjxproclamation.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople;
import com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.*;

/**
 * @title:SomJxProclamationQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxProclamationQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxProclamation> dao = (EntityDao<SomJxProclamation>) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamationDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxProclamation> dao = (EntityDao<SomJxProclamation>) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamationDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
