package com.inspur.cams.sorg.check.somcheckmajor.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajor;

/**
 * @title:SomCheckMajorQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckMajorQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckMajor> dao = (EntityDao<SomCheckMajor>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajorDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckMajor> dao = (EntityDao<SomCheckMajor>) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajorDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
