package com.inspur.cams.comm.brief.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.brief.dao.ICamsBriefConfigDao;
import com.inspur.cams.comm.brief.data.CamsBriefConfig;


/**
 * 快报简报配置表dao
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefConfigDao extends EntityDao<CamsBriefConfig> implements ICamsBriefConfigDao {
	
	@Override
	public Class<CamsBriefConfig> getEntityClass() {
		return CamsBriefConfig.class;
	}

	public DataSet queryCount(ParameterSet pset){
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT T.ENTER_NAME AS ENTER_NAME,T.INDEX_CODE AS INDEX_CODE,");
		sql.append("T.UNIT AS UNIT,C.COUNT AS COUNT ");
		sql.append("FROM CAMS_BRIEF_CONFIG T LEFT JOIN CAMS_BRIEF_COUNT C ON T.CONFIG_ID=C.CONFIG_ID ");
	    sql.append("WHERE 1=1 ");
	    sql.append("ORDER BY T.ENTER_SERIAL_NUM ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args, true);
		return ds;
	}
}