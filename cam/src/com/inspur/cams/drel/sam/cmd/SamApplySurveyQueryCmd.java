package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamApplySurveyDomain;

/**
 * @title:入户调查Command
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class SamApplySurveyQueryCmd extends BaseQueryCommand{
	private ISamApplySurveyDomain samApplySurveyDomain = ScaComponentFactory.getService(ISamApplySurveyDomain.class, "samApplySurveyDomain/samApplySurveyDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samApplySurveyDomain.query(pset);
	}
}
