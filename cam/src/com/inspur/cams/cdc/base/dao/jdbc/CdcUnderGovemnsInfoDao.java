package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.cdc.base.dao.ICdcUnderGovemnsInfoDao;
import com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo;

/**
 * @title:CdcUnderGovemnsInfoDao
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
 public class CdcUnderGovemnsInfoDao extends EntityDao<CdcUnderGovemnsInfo> implements ICdcUnderGovemnsInfoDao{

  	@Override
	public Class<CdcUnderGovemnsInfo> getEntityClass() {
		return CdcUnderGovemnsInfo.class;
	}

	public String getSelections(String userId) {
		String sql = "SELECT T.RECORD_ID,T.REPORT_DATE FROM CDC_ELECTION_INFO T WHERE T.ORGAN_CODE = ? ";
		DataSet ds = this.executeDataset(sql,new int[]{Types.VARCHAR},new Object[]{userId},false);
		StringBuffer reportDate =new StringBuffer();
		Record record  = null;
		for (int i = 0; i < ds.getCount(); i++) {
			if(i>5) break;
			record = ds.getRecord(i);
			reportDate.append(record.get("RECORD_ID")).append(";").append(record.get("REPORT_DATE"));
			if((i!=ds.getCount()-1)&&(i!=5)){
				reportDate.append("#");
			};
		}
		return reportDate.toString();
	}
	
	//查询下辖村
	public DataSet queryUnder(ParameterSet pset){
		String organId = (String) pset.getParameter("organId");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(
				"select * from com_ext_user u left join cdc_under_govemns_info t on u.user_id=t.village_code where 1=1 ");
		
		if (organId != null && !"".equals(organId)) {
			sql.append(" and u.organ_id=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organId);
		}
		sql.append(" order by u.user_id ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
}
