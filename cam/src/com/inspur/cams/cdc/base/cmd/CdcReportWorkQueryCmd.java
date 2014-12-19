package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcReportWorkDomain;

/**
 * 基层民主填报工作息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcReportWorkQueryCmd extends BaseQueryCommand {

	private ICdcReportWorkDomain cdcReportWorkDomain = ScaComponentFactory
			.getService(ICdcReportWorkDomain.class, "cdcReportWorkDomain/cdcReportWorkDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcReportWorkDomain.query(pset);
	}
	
	/**
	 * 查询 填报工作字典，如果organCode为空则查询全部工作任务，如果不为空则查询当前单位未填报工作任务
	 * 参数：reportType 报表类型
	 * 参数：organCode 单位行政区划
	 * @param pset
	 * @return
	 */
	public DataSet getDic() {
		ParameterSet pset = getParameterSet();
		DataSet ds = cdcReportWorkDomain.getDic(pset);
		ds.getMetaData().setIdProperty("value");
		return ds;
	}
	
	/**
	 * 基层政权与社区建设社区级统计.
	 */
	public DataSet queryInfo() {
		ParameterSet pset = getParameterSet();
		return cdcReportWorkDomain.queryInfo(pset);
	}
	
	/**
	 * 基层政权与社区建设街道及以上单位统计.
	 */
	public DataSet queryStreetInfo() {
		ParameterSet pset = getParameterSet();
		return cdcReportWorkDomain.queryStreetInfo(pset);
	}
	
}