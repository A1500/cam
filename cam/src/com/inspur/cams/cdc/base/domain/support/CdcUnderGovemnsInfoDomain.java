package com.inspur.cams.cdc.base.domain.support;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcUnderGovemnsInfoDao;
import com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo;
import com.inspur.cams.cdc.base.domain.ICdcUnderGovemnsInfoDomain;

/**
 * 志愿者信息domain
 * @author 
 * @date 2013-02-26
 */
public class CdcUnderGovemnsInfoDomain implements ICdcUnderGovemnsInfoDomain {

	@Reference
	private ICdcUnderGovemnsInfoDao cdcUnderGovemnsInfoDao;

	@Reference
	public void setCdcUnderGovemnsInfoDao(
			ICdcUnderGovemnsInfoDao cdcUnderGovemnsInfoDao) {
		this.cdcUnderGovemnsInfoDao = cdcUnderGovemnsInfoDao;
	}

	public void delete(String id) {
		cdcUnderGovemnsInfoDao.delete(id);
	}

	public void insert(CdcUnderGovemnsInfo info) {
		cdcUnderGovemnsInfoDao.insert(info);
	}

	public void update(CdcUnderGovemnsInfo info) {
		cdcUnderGovemnsInfoDao.update(info);
	}

	public void batchDelete(String[] ids) {
		cdcUnderGovemnsInfoDao.batchDelete(ids);
		
	}

	public DataSet query(ParameterSet pset) {
		return cdcUnderGovemnsInfoDao.query(pset);
	}

	public String getSelections(String userId) {
		return cdcUnderGovemnsInfoDao.getSelections(userId);
	}
	
	
	//查询下辖村
	public DataSet queryUnder(ParameterSet pset){
		return cdcUnderGovemnsInfoDao.queryUnder(pset);
	}
	
	//保存下辖村
	public void saveVillage(List list){
		 cdcUnderGovemnsInfoDao.save(list);
	}

}