package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomFundDomain;

/**
 * 
 * @author Muqi
 * @date 2011年6月3日11:43:24
 */
public class SomFundLiqpeopleQueryCmd extends BaseQueryCommand {
	// --------------------------------------------------muqi-------------------------------------------------
	private ISomFundDomain service = ScaComponentFactory.getService(
			ISomFundDomain.class, "somFundDomain/somFundDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.queryLiqpeople(pset);
	}

}
