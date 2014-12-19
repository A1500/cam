package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.manage.domain.ISomPartyOrganDomain;

/**
 * 
 * @title 党建党内惩罚查询cmd
 *
 */
public class SomPartyPraiseQueryCmd extends BaseQueryCommand{
	private ISomPartyOrganDomain service = ScaComponentFactory.getService(ISomPartyOrganDomain.class, "somPartyOrganDomain/somPartyOrganDomain");
	public DataSet execute() {
		ParameterSet pset =getParameterSet();

		return service.queryPartyPraise(pset);
	}
}
