package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCompulsorySummaryQueryCommand
 * @description:其他优抚对象优待金发放汇总
*/
public class BptCompulsorySummaryQueryCommand extends BaseQueryCommand{

	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");

	/**
	 * 查询其他优抚对象优待金汇总
	 */
	public DataSet queryCompulsorySummary() {
		ParameterSet pset = getParameterSet();
		DataSet ds=service.queryCompulsorySummary(pset);
		return ds;
	}
}
