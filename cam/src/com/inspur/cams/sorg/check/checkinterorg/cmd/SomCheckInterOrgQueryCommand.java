package com.inspur.cams.sorg.check.checkinterorg.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkinterorg.data.SomCheckInterOrg;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrg;

/**
 * @title:SomCheckInterOrgQueryCommand
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
public class SomCheckInterOrgQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckInterOrg> dao = (EntityDao<SomCheckInterOrg>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkinterorg.dao.SomCheckInterOrgDao");
		return dao.query(pset);
	}
	public DataSet queryNoPage() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckInterOrg> dao = (EntityDao<SomCheckInterOrg>) DaoFactory
		.getDao("com.inspur.cams.sorg.check.checkinterorg.dao.SomCheckInterOrgDao");
		List<SomJxCheckInterOrg> list = dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
