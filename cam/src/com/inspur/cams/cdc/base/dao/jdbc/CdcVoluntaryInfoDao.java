package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcVoluntaryInfoDao;
import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;

/**
 * 志愿者信息dao
 * @author 
 * @date 2013-02-26
 */
public class CdcVoluntaryInfoDao extends EntityDao<CdcVoluntaryInfo> implements ICdcVoluntaryInfoDao {
	
	@Override
	public Class<CdcVoluntaryInfo> getEntityClass() {
		return CdcVoluntaryInfo.class;
	}
	
	/**
	 * 更新 志愿者信息参加活动次数
	 */
	public void updateCaperTimes(List<CdcVoluntaryInfo> cdcVoluntaryInfoList, int i) {
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE CDC_VOLUNTARY_INFO V SET");
		if (i > 0) {
			//增（次数和时间）
			sql.append(" V.CAPER_NUMS=V.CAPER_NUMS+1,V.CAPER_TIMES=V.CAPER_TIMES+?");
		} else if (i < 0) {
			//减（次数和时间）
			sql.append(" V.CAPER_NUMS=V.CAPER_NUMS-1,V.CAPER_TIMES=V.CAPER_TIMES-?");
		} else {
			//改（仅时间）
			sql.append(" V.CAPER_TIMES=V.CAPER_TIMES+?");
		}
		sql.append(" WHERE V.VOLUNTARY_ID=?");

		int[] types = new int[2];
		types[0] = Types.NUMERIC;
		types[1] = Types.VARCHAR;
		Object[] args = new Object[2];
		
		for (int j = 0; j < cdcVoluntaryInfoList.size(); j++) {
			args[0] = cdcVoluntaryInfoList.get(j).getTotalTimes();
			args[1] = cdcVoluntaryInfoList.get(j).getVoluntaryId();
			executeUpdate(sql.toString(), types, args);
		}
	}

	/**
	 * @Description: 根据活动编码获取志愿者信息
	 * @author xuexzh
	 */
	public DataSet queryByCaper(ParameterSet pset) {
		String caperId = (String)pset.getParameter("caperId");
		String sql = "SELECT V.*,VC.START_TIME,VC.END_TIME,VC.DIFF_TIMES FROM CDC_VOLUNTARY_CAPER_INFO VC,CDC_VOLUNTARY_INFO V WHERE VC.VOLUNTARY_ID=V.VOLUNTARY_ID AND VC.CAPER_ID=?";
		int[] types = new int[1];
		types[0] = Types.VARCHAR;
		Object[] args = new Object[1];
		args[0] = caperId;
		return executeDataset(sql,types,args,true);
	}
}