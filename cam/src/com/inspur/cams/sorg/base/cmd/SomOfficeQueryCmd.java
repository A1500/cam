package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomOfficeDomain;

/**
 * 办事机构备案查询
 * @author shgtch
 * @date 2011-10-13
 */
public class SomOfficeQueryCmd extends BaseQueryCommand {
	
	private ISomOfficeDomain somOfficeDomain = ScaComponentFactory.getService(
			ISomOfficeDomain.class, "somOfficeDomain/somOfficeDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somOfficeDomain.query(pset);
	}
	
}
