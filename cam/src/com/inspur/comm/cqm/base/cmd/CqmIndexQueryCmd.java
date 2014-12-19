package com.inspur.comm.cqm.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.domain.ICqmIndexDomain;

/**
 * 自定义统计报表指标表查询cmd
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmIndexQueryCmd extends BaseQueryCommand {

	private ICqmIndexDomain cqmIndexDomain = ScaComponentFactory
			.getService(ICqmIndexDomain.class, "cqmIndexDomain/cqmIndexDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmIndexDomain.query(pset);
	}
	
	public DataSet getRowIndex() {
		String indexId = (String) getParameter("indexId");
		String organCode = (String) getParameter("organCode");
		DataSet dataSet = new DataSet();
		dataSet.addRecord(cqmIndexDomain.getRowIndex(indexId,organCode));
		return dataSet;
	}
	
	/**
	 * 获取字典
	 * @return
	 */
	public DataSet getDic() {
		ParameterSet pset = getParameterSet();
		return cqmIndexDomain.getDic(pset);
	}
	
}