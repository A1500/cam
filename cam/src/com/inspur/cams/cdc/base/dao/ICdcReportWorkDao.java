package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.data.CdcReportWork;

/**
 * 基层民主填报工作信息表Dao实现类
 * @author shgtch
 * @date 2011-12-20
 */
public interface ICdcReportWorkDao extends BaseCURD<CdcReportWork> {

	/**
	 * 查询 填报工作字典，如果organCode为空则查询全部工作任务，如果不为空则查询当前单位未填报工作任务
	 * 参数：reportType 报表类型
	 * 参数：organCode 单位行政区划
	 * @param pset
	 * @return
	 */
	public DataSet getDic(ParameterSet pset);
	
	/**
	 * 基层政权与社区建设社区级统计分析
	 */
	public DataSet queryInfo(ParameterSet pset);
	
	/**
	 * 基层政权与社区建设街道及以上单位统计分析
	 */
	public DataSet queryStreetInfo(ParameterSet pset);

}