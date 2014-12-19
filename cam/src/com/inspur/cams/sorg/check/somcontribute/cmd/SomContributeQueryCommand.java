package com.inspur.cams.sorg.check.somcontribute.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcontribute.dao.SomContribute;

/**
 * @title:SomContributeQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomContributeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomContribute> dao = (EntityDao<SomContribute>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcontribute.dao.SomContributeDao");
		return dao.query(pset);
	}
}
