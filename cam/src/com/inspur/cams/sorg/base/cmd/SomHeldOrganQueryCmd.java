package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;

/**
 * 社会组织发起人（单位）查询cmd
 * @author shgtch
 * @date 2011-8-9
 */
public class SomHeldOrganQueryCmd extends BaseQueryCommand {

	ISomHeldOrganDomain somHeldOrganDomain = ScaComponentFactory.getService(ISomHeldOrganDomain.class, "somHeldOrganDomain/somHeldOrganDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somHeldOrganDomain.query(pset);
	}

}