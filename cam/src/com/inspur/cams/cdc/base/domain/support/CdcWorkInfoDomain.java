package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcWorkInfoDao;
import com.inspur.cams.cdc.base.data.CdcWorkInfo;
import com.inspur.cams.cdc.base.domain.ICdcWorkInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基层民主与社区建设工作交流domain
 * @author shgtch
 * @date 2012-3-1
 */
public class CdcWorkInfoDomain implements ICdcWorkInfoDomain {

	@Reference
	private ICdcWorkInfoDao cdcWorkInfoDao;
	
	/**
	 * 查询基层民主与社区建设工作交流
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcWorkInfoDao.query(pset);
	}

	/**
	 * 增加基层民主与社区建设工作交流
	 * @param cdcWorkInfo
	 */
	public void insert(CdcWorkInfo cdcWorkInfo) {
		cdcWorkInfo.setWorkId(cdcWorkInfo.getOrganCode() + IdHelp.getUUID32());
		cdcWorkInfo.setCreateTime(DateUtil.getTime());
		cdcWorkInfoDao.insert(cdcWorkInfo);
	}
	
	/**
	 * 修改基层民主与社区建设工作交流
	 * @param cdcWorkInfo
	 */
	public void update(CdcWorkInfo cdcWorkInfo) {
		cdcWorkInfoDao.update(cdcWorkInfo);
	}
	
	/**
	 * 删除基层民主与社区建设工作交流
	 * @param workId
	 */
	public void delete(String workId) {
		cdcWorkInfoDao.delete(workId);
	}

	public DataSet queryList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return cdcWorkInfoDao.queryList(pset);
	}
	
}