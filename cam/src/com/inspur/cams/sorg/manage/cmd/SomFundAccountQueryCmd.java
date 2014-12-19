package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.sorg.manage.domain.ISomFundDomain;
/**
 * 基金会账户查询
 * @author Jiangzhaobao
 *
 * @date 2011-5-24
 */
public class SomFundAccountQueryCmd extends BaseQueryCommand{
	private ISomFundDomain service = ScaComponentFactory.getService(ISomFundDomain.class, "somFundDomain/somFundDomain");
	public DataSet execute() {
		ParameterSet pset =getParameterSet();

		return service.queryAccount(pset);
	}
}
