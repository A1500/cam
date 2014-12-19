package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcReportWorkDao;
import com.inspur.cams.cdc.base.data.CdcReportWork;
import com.inspur.cams.cdc.base.domain.ICdcReportWorkDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基层民主填报工作信息表Domain实现类
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcReportWorkDomain implements ICdcReportWorkDomain {

	@Reference
	private ICdcReportWorkDao cdcReportWorkDao;

	/**
	 * 查询基层民主填报工作信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcReportWorkDao.query(pset);
	}

	/**
	 * 查询 填报工作字典，如果organCode为空则查询全部工作任务，如果不为空则查询当前单位未填报工作任务
	 * 参数：reportType 报表类型
	 * 参数：organCode 单位行政区划
	 * @param pset
	 * @return
	 */
	public DataSet getDic(ParameterSet pset) {
		return cdcReportWorkDao.getDic(pset);
	}

	/**
	 * 增加基层民主填报工作信息
	 * @param cdcDecisionInfo
	 */
	public void insert(CdcReportWork cdcReportWork) {
		cdcReportWork.setWorkId(cdcReportWork.getOrganCode() + IdHelp.getUUID32());
		cdcReportWork.setStatus("0");
		cdcReportWork.setOrganCode(BspUtil.getOrganCode());
		cdcReportWork.setOrganName(BspUtil.getOrganName());
		cdcReportWork.setCreateTime(DateUtil.getTime());
		cdcReportWorkDao.insert(cdcReportWork);
	}
	
	/**
	 * 修改基层民主填报工作信息
	 * @param cdcDecisionInfo
	 */
	public void update(CdcReportWork cdcReportWork) {
		cdcReportWorkDao.update(cdcReportWork);
	}
	
	/**
	 * 基层政权与社区建设社区级统计分析
	 */
	public DataSet queryInfo(ParameterSet pset) {
		return cdcReportWorkDao.queryInfo(pset);
	}
	
	/**
	 * 基层政权与社区建设街道及以上单位统计分析
	 */
	public DataSet queryStreetInfo(ParameterSet pset) {
		return cdcReportWorkDao.queryStreetInfo(pset);
	}

}