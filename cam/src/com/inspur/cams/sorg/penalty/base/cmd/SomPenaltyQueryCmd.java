package com.inspur.cams.sorg.penalty.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.penalty.base.domain.ISomPenaltyBaseDomain;

/**
 * 行政执法基本信息查询
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public class SomPenaltyQueryCmd extends BaseQueryCommand {
	private ISomPenaltyBaseDomain service = ScaComponentFactory.getService(
			ISomPenaltyBaseDomain.class,
			"somPenaltyBaseDomain/somPenaltyBaseDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
