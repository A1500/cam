package com.inspur.cams.sorg.assess.assess.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.assess.assess.data.SomAssess;

/**
 * @title:SomAssessQueryCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class SomAssessQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomAssess> dao = (EntityDao<SomAssess>) DaoFactory
				.getDao("com.inspur.cams.sorg.assess.assess.dao.SomAssessDao");
		return dao.query(pset);
	}
}
