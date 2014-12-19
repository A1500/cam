package com.inspur.cams.cdc.base.domain.support;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcPlanInfoDao;
import com.inspur.cams.cdc.base.data.CdcPlanInfo;
import com.inspur.cams.cdc.base.domain.ICdcPlanInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社区建设规划信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcPlanInfoDomain implements ICdcPlanInfoDomain {

	@Reference
	private ICdcPlanInfoDao cdcPlanInfoDao;

	/**
	 * ??��??社区建设规划信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcPlanInfoDao.query(pset);
	}

	/**
	 * �????社区建设规划信息�?
	 * @param cdcPlanInfo
	 */
	public void insert(CdcPlanInfo cdcPlanInfo) {
		cdcPlanInfo.setPlanId(cdcPlanInfo.getOrganCode()+IdHelp.getUUID32());
		cdcPlanInfo.setStatus("0");
		cdcPlanInfo.setCreateTime(DateUtil.getTime());
		cdcPlanInfoDao.insert(cdcPlanInfo);
	}
	
	/**
	 * �????社区建设规划信息�?
	 * @param cdcPlanInfo
	 */
	public void update(CdcPlanInfo cdcPlanInfo) {
		cdcPlanInfoDao.update(cdcPlanInfo);
	}
	
	/**
	 * ??????社区建设规划信息�?
	 * @param planId
	 */
	public void delete(String planId) {
		cdcPlanInfoDao.delete(planId);
	}

	public void sum(CdcPlanInfo cdcPlanInfo) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcPlanInfo.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_DATE@=", cdcPlanInfo.getReportDate());
		DataSet childDataSet = cdcPlanInfoDao.query(ps);
		
		// 数据合计并保存
		cdcPlanInfo.setPlanNum(childDataSet.sum("planNum"));
		cdcPlanInfo.setYearCompleteNum(childDataSet.sum("yearCompleteNum"));
		cdcPlanInfo.setCompleteNum(childDataSet.sum("completeNum"));
		insert(cdcPlanInfo);
	}

	public DataSet queryList(ParameterSet pset) {
		return cdcPlanInfoDao.queryList(pset);
	}

	public void audit(String id) {
		CdcPlanInfo info = cdcPlanInfoDao.get(id);
		if(info!=null){
			info.setStatus("2");
			cdcPlanInfoDao.update(info);
		}
	}

	public void report(String id) {
		CdcPlanInfo info = cdcPlanInfoDao.get(id);
		if(info!=null){
			info.setStatus("1");
			DateFormat f = new SimpleDateFormat("yyyy-MM-dd");
			info.setSubmitDate(f.format(new Date()));
			cdcPlanInfoDao.update(info);
		}
	}

}