package com.inspur.cams.sorg.jxcheck.somjxcheckflow.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao.*;

/**
 * @title:SomJxCheckFlowQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckFlowQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckFlow> dao = (EntityDao<SomJxCheckFlow>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao.SomJxCheckFlowDao");
		return dao.query(pset);
	}
}
