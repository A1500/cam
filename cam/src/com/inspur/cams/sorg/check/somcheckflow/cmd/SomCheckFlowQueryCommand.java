package com.inspur.cams.sorg.check.somcheckflow.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckflow.data.SomCheckFlow;

/**
 * @title:SomCheckFlowQueryCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckFlowQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckFlow> dao = (EntityDao<SomCheckFlow>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckflow.dao.SomCheckFlowDao");
		return dao.query(pset);
	}
}
