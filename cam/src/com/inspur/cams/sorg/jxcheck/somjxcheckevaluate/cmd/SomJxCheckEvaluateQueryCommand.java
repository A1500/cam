package com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.*;

/**
 * @title:SomJxCheckEvaluateQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckEvaluateQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckEvaluate> dao = (EntityDao<SomJxCheckEvaluate>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluateDao");
		return dao.query(pset);
	}
}
