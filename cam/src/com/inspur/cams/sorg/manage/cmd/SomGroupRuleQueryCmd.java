package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;
/**
 * 章程备案查询
 * @author Jiangzhaobao
 *
 * @date 2011年5月13日16:08:09
 */

public class SomGroupRuleQueryCmd extends BaseQueryCommand{
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
	public DataSet execute() {
		ParameterSet pset =getParameterSet();
		return service.queryRule(pset);
	}
}
