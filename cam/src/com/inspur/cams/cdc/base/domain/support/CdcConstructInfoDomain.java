package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcConstructInfoDao;
import com.inspur.cams.cdc.base.data.CdcConstructInfo;
import com.inspur.cams.cdc.base.domain.ICdcConstructInfoDomain;

/**
 * 基础信息农村社区规划信息domain实现类
 * @author shgtch
 * @date 2012-2-7
 */
public class CdcConstructInfoDomain implements ICdcConstructInfoDomain {

	@Reference
	private ICdcConstructInfoDao cdcConstructInfoDao;
	
	/**
	 * 查询基础信息农村社区规划信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcConstructInfoDao.query(pset);
	}

	/**
	 * 增加基础信息农村社区规划信息
	 * @param cdcConstructInfo
	 */
	public void insert(CdcConstructInfo cdcConstructInfo) {
		cdcConstructInfoDao.insert(cdcConstructInfo);
	}
	
	/**
	 * 修改基础信息农村社区规划信息
	 * @param cdcConstructInfo
	 */
	public void update(CdcConstructInfo cdcConstructInfo) {
		cdcConstructInfoDao.update(cdcConstructInfo);
	}
	
	/**
	 * 删除基础信息农村社区规划信息
	 * @param constructId
	 */
	public void delete(String recordId) {
		cdcConstructInfoDao.delete(recordId);
	}
}