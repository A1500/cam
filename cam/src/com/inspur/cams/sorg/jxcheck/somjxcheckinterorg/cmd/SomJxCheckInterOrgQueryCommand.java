package com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.cmd;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeeting;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.*;

/**
 * @title:SomJxCheckInterOrgQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
public class SomJxCheckInterOrgQueryCommand extends BaseQueryCommand {

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckInterOrg> dao = (EntityDao<SomJxCheckInterOrg>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao");
		return dao.query(pset);
	}

	public DataSet queryNoPage() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckInterOrg> dao = (EntityDao<SomJxCheckInterOrg>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao");
		List<SomJxCheckInterOrg> list = dao.queryNoPage(pset);
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
}
