package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.welfare.base.data.*;

/**
 * @title:WealUnitStatusQueryCommand
 * @description:
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitStatusQueryCommand extends BaseQueryCommand {

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealUnitStatus> dao = (EntityDao<WealUnitStatus>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitStatusDao");
		return dao.query(pset);
	}
}
