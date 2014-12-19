package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;

/**
 * 社会组织章程查询cmd
 * @author shgtch
 * @date 2011-10-13
 */
public class SomRuleQueryCmd extends BaseQueryCommand {
	
	private ISomRuleDomain somRuleDomain = ScaComponentFactory.getService(
			ISomRuleDomain.class, "somRuleDomain/somRuleDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somRuleDomain.query(pset);
	}
	
	public DataSet queryRule() {
		ParameterSet pset = getParameterSet();
		return somRuleDomain.queryRule(pset);
	}
}
