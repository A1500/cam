package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcFundInfoDao;
import com.inspur.cams.cdc.base.data.CdcFundInfo;
import com.inspur.cams.cdc.base.domain.ICdcFundInfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社区建设经费情况信息Domain实现类
 * @author 
 * @date 
 */
public class CdcFundInfoDomain implements ICdcFundInfoDomain {

	@Reference
	private ICdcFundInfoDao cdcFundInfoDao;

	/**
	 * 查询社区建设经费情况信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcFundInfoDao.query(pset);
	}

	/**
	 * 增加社区建设经费情况信息
	 * @param cdcFundInfo
	 */
	public void insert(CdcFundInfo cdcFundInfo) {
		cdcFundInfo.setFundId(cdcFundInfo.getOrganCode() + IdHelp.getUUID32());
		cdcFundInfo.setStatus("0");
		cdcFundInfo.setCreateTime(DateUtil.getTime());
		cdcFundInfoDao.insert(cdcFundInfo);
	}
	
	/**
	 * 修改社区建设经费情况信息
	 * @param cdcFundInfo
	 */
	public void update(CdcFundInfo cdcFundInfo) {
		cdcFundInfoDao.update(cdcFundInfo);
	}
	
	/**
	 * 删除社区建设经费情况信息
	 * @param fundId
	 */
	public void delete(String fundId) {
		cdcFundInfoDao.delete(fundId);
	}

	public void sum(CdcFundInfo cdcFundInfo) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcFundInfo.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcFundInfo.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcFundInfo.getReportDate());
		DataSet childDataSet = cdcFundInfoDao.query(ps);
		
		//数据合计并保存
		cdcFundInfo.setCommunityNum(childDataSet.sum("communityNum"));
		cdcFundInfo.setOffEnbowMon(childDataSet.sum("offEnbowMon"));
		cdcFundInfo.setOffFinanceMon(childDataSet.sum("offFinanceMon"));
		cdcFundInfo.setOffMon(childDataSet.sum("offMon"));
		cdcFundInfo.setOffOtherMon(childDataSet.sum("offOtherMon"));
		cdcFundInfo.setOffSelfMon(childDataSet.sum("offSelfMon"));
		cdcFundInfo.setSepEnbowMon(childDataSet.sum("sepEnbowMon"));
		cdcFundInfo.setSepFinanceMon(childDataSet.sum("sepFinanceMon"));
		cdcFundInfo.setSepMon(childDataSet.sum("sepMon"));
		cdcFundInfo.setSepOtherMon(childDataSet.sum("sepOtherMon"));
		cdcFundInfo.setSepSelfMon(childDataSet.sum("sepSelfMon"));
		cdcFundInfo.setUseActionMon(childDataSet.sum("useActionMon"));
		cdcFundInfo.setUseBuildMon(childDataSet.sum("useBuildMon"));
		cdcFundInfo.setUseOtherMon(childDataSet.sum("useOtherMon"));
		cdcFundInfo.setUseServiceMon(childDataSet.sum("useServiceMon"));
		
		insert(cdcFundInfo);
	}

}