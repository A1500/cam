package com.inspur.cams.marry.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.base.data.MrmRegisArea;

/**
 * @title:MrmRegisAreaQueryCommand
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
public class MrmRegisAreaQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<MrmRegisArea> dao = (EntityDao<MrmRegisArea>) DaoFactory
				.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmRegisAreaDao");
		return dao.query(pset);
	}
}
