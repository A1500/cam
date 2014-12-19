package com.inspur.cams.sorg.check.checkinterproject.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;
import com.inspur.cams.sorg.check.checkinterproject.data.SomCheckInterProject;
import com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajor;

/**
 * @title:SomCheckInterProjectQueryCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckInterProjectQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckInterProject> dao = (EntityDao<SomCheckInterProject>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkinterproject.dao.SomCheckInterProjectDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage(){
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckInterProject> dao = (EntityDao<SomCheckInterProject>) DaoFactory
		.getDao("com.inspur.cams.sorg.check.checkinterproject.dao.SomCheckInterProjectDao");
		List<SomCheckEvent> list =  dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
