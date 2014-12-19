package com.inspur.cams.sorg.check.checkorgdetail.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checkorgdetail.data.SomCheckOrgDetail;

/**
 * @title:SomCheckOrgDetailQueryCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckOrgDetailQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckOrgDetail> dao = (EntityDao<SomCheckOrgDetail>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checkorgdetail.dao.SomCheckOrgDetailDao");
		return dao.query(pset);
	}
}
