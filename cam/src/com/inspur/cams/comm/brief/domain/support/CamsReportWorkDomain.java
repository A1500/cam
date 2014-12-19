package com.inspur.cams.comm.brief.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.brief.dao.ICamsReportWorkDao;
import com.inspur.cams.comm.brief.data.CamsReportWork;
import com.inspur.cams.comm.brief.domain.ICamsReportWorkDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;

/**
 * 填报期数配置表domain
 * @author 
 * @date 2014-04-23
 */
public class CamsReportWorkDomain implements ICamsReportWorkDomain {

	@Reference
	private ICamsReportWorkDao camsReportWorkDao;

	/**
	 * 查询 填报期数配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return camsReportWorkDao.query(pset);
	}

	/**
	 * 获取 填报期数配置表
	 * @param pset
	 * @return
	 */
	public CamsReportWork get(String workId) {
		return camsReportWorkDao.get(workId);
	}

	/**
	 * 增加 填报期数配置表
	 * @param camsReportWork
	 */
	public void insert(CamsReportWork camsReportWork) {
		camsReportWork.setWorkId(camsReportWork.getWorkYear()+"-0"+camsReportWork.getWorkQuarter());
		camsReportWork.setCreateOrganCode(BspUtil.getCorpOrgan().getOrganCode());
		camsReportWork.setCreateOrganName(BspUtil.getCorpOrgan().getOrganName());
		camsReportWork.setCreateTime(DateUtil.getDay());
		camsReportWorkDao.insert(camsReportWork);
	}
	
	/**
	 * 修改 填报期数配置表
	 * @param camsReportWork
	 */
	public void update(CamsReportWork camsReportWork) {
		camsReportWork.setWorkId(camsReportWork.getWorkYear()+"-0"+camsReportWork.getWorkQuarter());
		camsReportWorkDao.update(camsReportWork);
	}
	
	/**
	 * 删除 填报期数配置表
	 * @param workId
	 */
	public void delete(String workId) {
		camsReportWorkDao.delete(workId);
	}

	/**
	 * 删除 开启上报任务    1：开启  0：关闭
	 * @param workId
	 */
	public void unlock(String workId) {
		CamsReportWork info = camsReportWorkDao.get(workId);
		if(info!=null){
			info.setStatus("1");
			camsReportWorkDao.update(info);
		}	
	}
	/**
	 * 删除 关闭上报任务    0：开启  1：关闭
	 * @param workId
	 */
	public void lock(String workId) {
		CamsReportWork info = camsReportWorkDao.get(workId);
		if(info!=null){
			info.setStatus("0");
			camsReportWorkDao.update(info);
		}	
	}
}