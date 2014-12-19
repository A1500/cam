package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomBorgChangeDomain;

/**
 * @title:业务主管单位变更queryCmd
 * @description:
 * @author:
 * @since:2013-03-05
 * @version:1.0
 */
public class SomBorgChangeQueryCmd extends BaseQueryCommand {
	private ISomBorgChangeDomain somBorgChangeDomain = ScaComponentFactory
			.getService(ISomBorgChangeDomain.class,
					"somBorgChangeDomain/somBorgChangeDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somBorgChangeDomain.query(pset);
	}

	/**
	 * 业务主管单位变更历史
	 */
	public DataSet showChange() {
		ParameterSet pset=getParameterSet();
		return somBorgChangeDomain.showChange(pset);
	}	
}
