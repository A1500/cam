package com.inspur.cams.sorg.query.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.query.domain.ISomWorkflowQueryDomain;

public class SomWorkflowQueryCmd extends BaseQueryCommand {

	private ISomWorkflowQueryDomain somWorkflowQueryDomain = ScaComponentFactory
			.getService(ISomWorkflowQueryDomain.class,"somWorkflowQueryDomain/somWorkflowQueryDomain");

	/**
	 * 按照日期查询 已办理过的业务数量
	 * 
	 * @return
	 */
	public DataSet queryNum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = somWorkflowQueryDomain.queryNum(pset);
		return ds;
	}
	
	/**
	 * 按照日期查询 已办理过的指定业务对应的所有社会组织列表
	 * @return
	 */
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		DataSet ds = somWorkflowQueryDomain.queryList(pset);
		return ds;
	}
	
	/**
	 * 按照日期查询 已办理过的业务中指定的社会组织对应的所有环节情况
	 * @return
	 */
	public DataSet queryDetail(){
		ParameterSet pset = getParameterSet();
		DataSet ds = somWorkflowQueryDomain.queryDetail(pset);
		return ds;
	}
}
