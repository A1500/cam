package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcDecisionInfoDao;
import com.inspur.cams.cdc.base.data.CdcDecisionInfo;
import com.inspur.cams.cdc.base.domain.ICdcDecisionInfoDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 基层民主民主决策信息表domain实现类
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcDecisionInfoDomain implements ICdcDecisionInfoDomain {

	@Reference
	private ICdcDecisionInfoDao cdcDecisionInfoDao;

	/**
	 * 查询基层民主民主决策信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcDecisionInfoDao.query(pset);
	}

	/**
	 * 增加基层民主民主决策信息
	 * @param cdcDecisionInfo
	 */
	public void insert(CdcDecisionInfo cdcDecisionInfo) {
		cdcDecisionInfo.setDecisionId(IdHelp.getUUID32());
		cdcDecisionInfoDao.insert(cdcDecisionInfo);
	}
	
	/**
	 * 修改基层民主民主决策信息
	 * @param cdcDecisionInfo
	 */
	public void update(CdcDecisionInfo cdcDecisionInfo) {
		cdcDecisionInfoDao.update(cdcDecisionInfo);
	}

	/**
	 * 删除基层民主民主决策信息
	 * @param cdcDecisionInfo
	 */
	public void delete(String recordId) {
		cdcDecisionInfoDao.delete(recordId);
	}
	
	/**
	 * 对本单位数据进行汇总
	 * @param cdcDecisionInfo
	 */
	public void sum(CdcDecisionInfo cdcDecisionInfo) {
		//
	}

	public void delete(String recordId, String organCode) {
		cdcDecisionInfoDao.delete(recordId,organCode);
		
	}

}