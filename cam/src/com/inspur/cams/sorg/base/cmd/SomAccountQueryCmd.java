package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomAccountDomain;

/**
 * 账户备案查询
 * @author shgtch
 * @date 2011-10-13
 */
public class SomAccountQueryCmd extends BaseQueryCommand {

	private ISomAccountDomain somAccountDomain = ScaComponentFactory
			.getService(ISomAccountDomain.class, "somAccountDomain/somAccountDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somAccountDomain.query(pset);
	}
}
