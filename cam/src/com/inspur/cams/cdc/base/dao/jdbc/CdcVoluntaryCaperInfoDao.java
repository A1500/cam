package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcVoluntaryCaperInfoDao;
import com.inspur.cams.cdc.base.data.CdcVoluntaryCaperInfo;

/**
 * 志愿者参加活动信息dao
 * @author 
 * @date 2013-02-26
 */
public class CdcVoluntaryCaperInfoDao extends EntityDao<CdcVoluntaryCaperInfo> implements ICdcVoluntaryCaperInfoDao {
	
	@Override
	public Class<CdcVoluntaryCaperInfo> getEntityClass() {
		return CdcVoluntaryCaperInfo.class;
	}
	
	/**
	 * @Description: 删除活动下的所有关系
	 * @author xuexzh
	 */
	public void deleteByCaper(String caperId) {
		int[] types = new int[1];
		types[0] = Types.VARCHAR;
		Object[] args = new Object[1];
		args[0] = caperId;
		executeUpdate("DELETE CDC_VOLUNTARY_CAPER_INFO VC WHERE VC.CAPER_ID=?", types, args);
	}
}