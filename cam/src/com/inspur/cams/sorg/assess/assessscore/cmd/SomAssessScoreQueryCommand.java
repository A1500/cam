package com.inspur.cams.sorg.assess.assessscore.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.sorg.assess.assessscore.data.SomAssessScore;

/**
 * @title:SomAssessScoreQueryCommand
 * @description:
 * @author:
 * @since:2011-12-09
 * @version:1.0
*/
public class SomAssessScoreQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomAssessScore> dao = (EntityDao<SomAssessScore>) DaoFactory
				.getDao("com.inspur.cams.sorg.assess.assessscore.dao.SomAssessScoreDao");
		return dao.query(pset);
	}
}
