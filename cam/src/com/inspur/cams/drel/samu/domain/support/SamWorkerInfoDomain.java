package com.inspur.cams.drel.samu.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.samu.dao.ISamWorkerInfoDao;
import com.inspur.cams.drel.samu.data.SamWorkerInfo;
import com.inspur.cams.drel.samu.domain.ISamWorkerInfoDomain;

/**
 * 工作人员信息domain
 * @author 
 * @date 2012-09-26
 */
public class SamWorkerInfoDomain implements ISamWorkerInfoDomain {

	@Reference
	private ISamWorkerInfoDao samWorkerInfoDao;

	/**
	 * 查询 工作人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samWorkerInfoDao.query(pset);
	}

	/**
	 * 获取 工作人员信息
	 * @param pset
	 * @return
	 */
	public SamWorkerInfo get(String workerId) {
		return samWorkerInfoDao.get(workerId);
	}

	/**
	 * 增加 工作人员信息
	 * @param samWorkerInfo
	 */
	public void insert(SamWorkerInfo samWorkerInfo) {
		samWorkerInfoDao.insert(samWorkerInfo);
	}
	
	/**
	 * 修改 工作人员信息
	 * @param samWorkerInfo
	 */
	public void update(SamWorkerInfo samWorkerInfo) {
		samWorkerInfoDao.update(samWorkerInfo);
	}
	
	/**
	 * 删除 工作人员信息
	 * @param workerId
	 */
	public void delete(String workerId) {
		samWorkerInfoDao.delete(workerId);
	}
	//统计-敬老院工作员工
	public DataSet reportWorkerInfo(ParameterSet pset){
		return samWorkerInfoDao.reportWorkerInfo(pset);
	}
}