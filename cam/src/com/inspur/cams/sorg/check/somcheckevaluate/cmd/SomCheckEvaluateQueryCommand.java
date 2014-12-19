package com.inspur.cams.sorg.check.somcheckevaluate.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluate;

/**
 * @title:SomCheckEvaluateQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckEvaluateQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckEvaluate> dao = (EntityDao<SomCheckEvaluate>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluateDao");
		return dao.query(pset);
	}
}
