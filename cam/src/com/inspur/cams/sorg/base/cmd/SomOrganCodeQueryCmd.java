package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomOrganCodeDomain;

/**
 * 组织机构代码备案查询
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomOrganCodeQueryCmd extends BaseQueryCommand {

	private ISomOrganCodeDomain somOrganCodeDomain = ScaComponentFactory
			.getService(ISomOrganCodeDomain.class,
					"somOrganCodeDomain/somOrganCodeDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somOrganCodeDomain.query(pset);
	}
}
