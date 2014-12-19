package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisCemeInfoDao;
import com.inspur.cams.fis.base.data.FisCemeInfo;

/**
 * 殡葬业务公墓信息表dao
 * @author 
 * @date 2013-08-01
 */
public class FisCemeInfoDao extends EntityDao<FisCemeInfo> implements IFisCemeInfoDao {
	
	@Override
	public Class<FisCemeInfo> getEntityClass() {
		return FisCemeInfo.class;
	}
	
	public void setOrganState(String organState, String recordId){
		StringBuffer sBuffer = new StringBuffer(
				"update FIS_CEME_INFO "
		);
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if (organState != null && !"".equals(organState)) {
			sBuffer.append(" set ORGAN_STATE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organState);
		}
		
		if (recordId != null && !"".equals(recordId)) {
			sBuffer.append(" where RECORD_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(recordId);
		}
		//DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			this.executeUpdate(sBuffer.toString(), types, args);
		}
	}
    
}