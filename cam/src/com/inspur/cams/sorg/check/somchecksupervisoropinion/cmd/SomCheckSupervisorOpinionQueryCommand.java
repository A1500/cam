package com.inspur.cams.sorg.check.somchecksupervisoropinion.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinion;

/**
 * @title:SomCheckSupervisorOpinionQueryCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckSupervisorOpinionQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomCheckSupervisorOpinion> dao = (EntityDao<SomCheckSupervisorOpinion>) DaoFactory
				.getDao("com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinionDao");
		return dao.query(pset);
	}
}
