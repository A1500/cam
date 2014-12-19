package com.inspur.cams.sorg.penalty.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.penalty.base.data.SomPenaltyCorrect;

/**
 * @title:SomPenaltyCorrectQueryCommand
 * @description:
 * @author:
 * @since:2011-12-29
 * @version:1.0
*/
public class SomPenaltyCorrectQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomPenaltyCorrect> dao = (EntityDao<SomPenaltyCorrect>) DaoFactory
				.getDao("com.inspur.cams.sorg.penalty.base.dao.jdbc.SomPenaltyCorrectDao");
		return dao.query(pset);
	}
}
