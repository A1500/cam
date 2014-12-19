package com.inspur.cams.cdc.base.domain.support;

import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcServiceFacilitiesDao;
import com.inspur.cams.cdc.base.data.CdcServiceFacilities;
import com.inspur.cams.cdc.base.domain.ICdcServiceFacilitiesDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;


/**
 * 社区服务设施信息domain实现类
 * @author
 * @date
 */
public class CdcServiceFacilitiesDomain implements ICdcServiceFacilitiesDomain {
	@Reference
	private ICdcServiceFacilitiesDao cdcServiceFacilitiesDao;
	/**
	 * 删除社区服务设施信息
	 */
	public void delete(String constructionId) {
		cdcServiceFacilitiesDao.delete(constructionId);

	}
	/**
	 * 增加社区服务设施信息
	 */
	public void insert(CdcServiceFacilities cdcServiceFacilities) {
		cdcServiceFacilities.setConstructionId(cdcServiceFacilities.getOrganCode() + IdHelp.getUUID32());
		cdcServiceFacilities.setStatus("0");
		cdcServiceFacilities.setCreateTime(DateUtil.getTime());
		cdcServiceFacilitiesDao.insert(cdcServiceFacilities);
	}
	/**
	 * 查询社区服务设施信息
	 */
	public DataSet query(ParameterSet pset) {
		return cdcServiceFacilitiesDao.query(pset);
	}

	/**
	 * 修改社区服务设施信息
	 */
	public void update(CdcServiceFacilities cdcServiceFacilities) {
		cdcServiceFacilitiesDao.update(cdcServiceFacilities);
	}
	/**
	 * 汇总社区服务设施信息
	 */
	public void sum(CdcServiceFacilities cdcServiceFacilities) {
		// 查询本单位下级数据
		ParameterSet ps = new ParameterSet();
		ps.setParameter("PARENT_CODE@=", cdcServiceFacilities.getOrganCode());
		ps.setParameter("STATUS@=","1");
		ps.setParameter("REPORT_TYPE@=", cdcServiceFacilities.getReportType());
		ps.setParameter("REPORT_DATE@=", cdcServiceFacilities.getReportDate());
		DataSet childDataSet = cdcServiceFacilitiesDao.query(ps);

		//数据合计并保存
		cdcServiceFacilities.setOffComputeNum(childDataSet.sum("offComputeNum"));
		cdcServiceFacilities.setOffConArea(childDataSet.sum("offConArea"));
		cdcServiceFacilities.setOffHouseArea(childDataSet.sum("offHouseArea"));
		cdcServiceFacilities.setSerConArea(childDataSet.sum("serConArea"));
		BigDecimal avgLen;
		BigDecimal countNum;
		 if ("0".equals(childDataSet.getCount())){
			 avgLen = new BigDecimal("0");
		 }else {
			 countNum = new BigDecimal(childDataSet.getCount());
			 avgLen = childDataSet.sum("serLen").divide(countNum, 0, 6);
		  }
		cdcServiceFacilities.setSerLen(avgLen);
		cdcServiceFacilities.setSerTotleArea(childDataSet.sum("serTotleArea"));
		cdcServiceFacilities.setSerVillageNum(childDataSet.sum("serVillageNum"));
		insert(cdcServiceFacilities);
	}
	/**
	 * 查询社区服务设施
	 */
	public DataSet queryList(ParameterSet pset) {
		return cdcServiceFacilitiesDao.queryList(pset);
	}

	/**
	 * 上报社区服务设施
	 */
	public void report(String id){
		CdcServiceFacilities cFacilities = cdcServiceFacilitiesDao.get(id);
		if (cFacilities != null) {
			cFacilities.setStatus("1");
			cdcServiceFacilitiesDao.update(cFacilities);
		}

	}
}