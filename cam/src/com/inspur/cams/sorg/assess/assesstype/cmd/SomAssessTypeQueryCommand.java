package com.inspur.cams.sorg.assess.assesstype.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.assess.assesstype.dao.*;

/**
 * @title:SomAssessTypeQueryCommand
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
public class SomAssessTypeQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomAssessType> dao = (EntityDao<SomAssessType>) DaoFactory
				.getDao("com.inspur.cams.sorg.assess.assesstype.dao.SomAssessTypeDao");
		return dao.query(pset);
	}
}
