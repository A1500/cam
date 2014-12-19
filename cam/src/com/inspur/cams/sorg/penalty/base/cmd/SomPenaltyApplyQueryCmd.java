package com.inspur.cams.sorg.penalty.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.penalty.base.domain.ISomPenaltyApplyBaseDomain;

/**
 * 行政执法审批查询
 * 
 * @author:zhangjian
 * @since:2011-12-21
 */
public class SomPenaltyApplyQueryCmd extends BaseQueryCommand {
	private ISomPenaltyApplyBaseDomain service = ScaComponentFactory
			.getService(ISomPenaltyApplyBaseDomain.class,
					"somPenaltyApplyBaseDomain/somPenaltyApplyBaseDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}
