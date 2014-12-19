package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomPeopleResumeDomain;

/**
 * @title:SomPeopleResumeQueryCommand
 * @description:
 * @author:
 * @since:2011-10-31
 * @version:1.0
*/
public class SomPeopleResumeQueryCommand extends BaseQueryCommand{

	ISomPeopleResumeDomain somPeopleResumeDomain = ScaComponentFactory.getService(ISomPeopleResumeDomain.class,"somPeopleResumeDomain/somPeopleResumeDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somPeopleResumeDomain.executeQuery(pset);
	}
	
	public DataSet commExecute(){
		ParameterSet pset = getParameterSet();
		return somPeopleResumeDomain.commExecute(pset);
	}
}
