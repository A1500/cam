package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomFundDomain;

/**
 * 
 * @author Muqi
 * @date 2011年6月3日11:42:13
 */
public class SomFundOrganQueryCmd extends BaseQueryCommand {
	// --------------------------------------------------muqi-------------------------------------------------
	private ISomFundDomain service = ScaComponentFactory.getService(
			ISomFundDomain.class, "somFundDomain/somFundDomain");

	public DataSet queryOrgan() {
		ParameterSet pset = getParameterSet();
		return service.queryOrgan(pset);
	}

	public DataSet queryMain() {
		ParameterSet pset = getParameterSet();
		return service.queryMain(pset);
	}

	public DataSet queryBranch() {
		ParameterSet pset = getParameterSet();
		return service.queryBranch(pset);
	}

}
