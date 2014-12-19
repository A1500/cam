package com.inspur.cams.sorg.jxcheck.somjxextraplan.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxextraplan.dao.*;

/**
 * @title:SomJxExtraPlanQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxExtraPlanQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxExtraPlan> dao = (EntityDao<SomJxExtraPlan>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxextraplan.dao.SomJxExtraPlanDao");
		return dao.query(pset);
	}
}
