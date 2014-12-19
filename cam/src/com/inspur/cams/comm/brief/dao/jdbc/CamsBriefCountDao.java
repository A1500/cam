package com.inspur.cams.comm.brief.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.brief.dao.ICamsBriefCountDao;
import com.inspur.cams.comm.brief.data.CamsBriefConfig;
import com.inspur.cams.comm.brief.data.CamsBriefCount;
import com.inspur.cams.comm.brief.data.CamsBriefSeason;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.RecordToBeanUtil;

/**
 * 快报简报数量表dao
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefCountDao extends EntityDao<CamsBriefCount> implements ICamsBriefCountDao {
	
	@Override
	public Class<CamsBriefCount> getEntityClass() {
		return CamsBriefCount.class;
	}

	public void insertCount(CamsBriefSeason camsBriefSeason){
		String seasonId=camsBriefSeason.getSeasonId();
		String organArea=camsBriefSeason.getOrganArea();
		String organName=camsBriefSeason.getOrganName();
		String reportSeason=camsBriefSeason.getReportSeason();
		StringBuffer sqlQuery=new StringBuffer();
		sqlQuery.append("select * from CAMS_BRIEF_CONFIG t ");
		DataSet ds=executeDataset(sqlQuery.toString(), new int[]{}, new Object[]{},  true);
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record=ds.getRecord(i);
				CamsBriefConfig camsBriefConfig=(CamsBriefConfig)RecordToBeanUtil.recordToBeanUtil(record, CamsBriefConfig.class);
				CamsBriefCount camsBriefCount = new CamsBriefCount();
				camsBriefCount.setCountId(IdHelp.getUUID32());
				camsBriefCount.setConfigId(camsBriefConfig.getConfigId());
				camsBriefCount.setEnterName(camsBriefConfig.getEnterName());
				camsBriefCount.setShowName(camsBriefConfig.getShowName());
				camsBriefCount.setIndexCode(camsBriefConfig.getIndexCode());
				camsBriefCount.setUnit(camsBriefConfig.getUnit());
				camsBriefCount.setEnterSerialNum(new BigDecimal(camsBriefConfig.getEnterSerialNum().toString()));
				camsBriefCount.setShowSerialNum(new BigDecimal(camsBriefConfig.getShowSerialNum().toString()));
				camsBriefCount.setIfBold(camsBriefConfig.getIfBold());
				camsBriefCount.setIndentLevel(camsBriefConfig.getIndentLevel());
				camsBriefCount.setSeasonId(seasonId);
				camsBriefCount.setOrganArea(organArea);
				camsBriefCount.setOrganName(organName);
				camsBriefCount.setReportSeason(reportSeason);
				this.insert(camsBriefCount);
			}
			
		}	
	}
	
	public void updateCount(CamsBriefSeason camsBriefSeason){
		String organArea=camsBriefSeason.getOrganArea();
		String organName=camsBriefSeason.getOrganName();
		String reportSeason=camsBriefSeason.getReportSeason();
		StringBuffer sqlQuery=new StringBuffer();
		sqlQuery.append("select * from CAMS_BRIEF_CONFIG t ");
		DataSet ds=executeDataset(sqlQuery.toString(), new int[]{}, new Object[]{},  true);
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record=ds.getRecord(i);
				CamsBriefConfig camsBriefConfig=(CamsBriefConfig)RecordToBeanUtil.recordToBeanUtil(record, CamsBriefConfig.class);
				ParameterSet pset = new ParameterSet();
				pset.setParameter("CONFIG_ID", camsBriefConfig.getConfigId());
				DataSet getds = this.query(pset);
				Record countRecord = getds.getRecord(0);
				CamsBriefCount camsBriefCount = (CamsBriefCount) countRecord.toBean(CamsBriefCount.class);
				camsBriefCount.setOrganArea(organArea);
				camsBriefCount.setOrganName(organName);
				camsBriefCount.setReportSeason(reportSeason);
				this.update(camsBriefCount);
			}
			
		}	
	}
	
	public void deleteBySeasonId(String seasonId) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		//清空关系
		sql.append("DELETE FROM CAMS_BRIEF_COUNT WHERE SEASON_ID=?");
		typeList.add(Types.VARCHAR);
		objList.add(seasonId);

		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
		}
	}
}