package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomFundDomain;

/**
 * 办事机构备案查询
 * @author Jiangzhaobao
 *
 * @date 2011年5月13日16:07:56
 */
public class SomFundOfficeQueryCmd extends BaseQueryCommand{
	private ISomFundDomain service = ScaComponentFactory.getService(ISomFundDomain.class, "somFundDomain/somFundDomain");
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return service.queryOffice(pset);
	}
}
