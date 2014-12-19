package com.inspur.cams.sorg.check.somproclamation.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajor;
import com.inspur.cams.sorg.check.somproclamation.dao.SomProclamation;

/**
 * @title:SomProclamationQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomProclamationQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomProclamation> dao = (EntityDao<SomProclamation>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somproclamation.dao.SomProclamationDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomProclamation> dao = (EntityDao<SomProclamation>) DaoFactory
		.getDao("com.inspur.cams.sorg.check.somproclamation.dao.SomProclamationDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
