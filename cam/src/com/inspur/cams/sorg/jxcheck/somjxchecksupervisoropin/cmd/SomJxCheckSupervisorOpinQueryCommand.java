package com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.*;

/**
 * @title:SomJxCheckSupervisorOpinQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckSupervisorOpinQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckSupervisorOpin> dao = (EntityDao<SomJxCheckSupervisorOpin>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.SomJxCheckSupervisorOpinDao");
		return dao.query(pset);
	}
}
