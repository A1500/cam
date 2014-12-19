package com.inspur.cams.marry.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.marry.base.data.MrmPosition;

/**
 * @title:MrmPositionQueryCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class MrmPositionQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<MrmPosition> dao = (EntityDao<MrmPosition>) DaoFactory
				.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmPositionDao");
		return dao.query(pset);
	}
}
