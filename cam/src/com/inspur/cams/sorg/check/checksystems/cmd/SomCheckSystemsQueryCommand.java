package com.inspur.cams.sorg.check.checksystems.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.checksystems.data.SomCheckSystems;

/**
 * @title:内部制度建设情况QueryCommand
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
 */
public class SomCheckSystemsQueryCommand extends BaseQueryCommand {

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckSystems> dao = (EntityDao<SomCheckSystems>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.checksystems.dao.SomCheckSystemsDao");
		return dao.query(pset);
	}
}
