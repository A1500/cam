package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.info.dao.ID204b12Dao;
import com.inspur.cams.drel.info.data.D204b12;

/**
 * 经营性收入dao
 * @author 
 * @date 2014-06-09
 */
public class D204b12Dao extends EntityDao<D204b12> implements ID204b12Dao {
	
	@Override
	public Class<D204b12> getEntityClass() {
		return D204b12.class;
	}

	public DataSet queryGongshang(ParameterSet pset) {
		// TODO Auto-generated method stub
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		querySql.append("SELECT d.data_source,                           \n");
		querySql.append("       d.d204b120004,                            \n");
		querySql.append("       d.adress_true,                           \n");
		querySql.append("       d.d204b120005,                           \n");
		querySql.append("       d.d204b120007,                           \n");
		querySql.append("       d.d204b120003,                           \n");
		querySql.append("       d.adress,                           \n");
		querySql.append("       d.input_time,                            \n");
		querySql.append("       t.D204A010001,                            \n");
		querySql.append("       t.D204A010005                           \n");
		querySql.append("       from d204b12 d, D204A01 t                 \n");
		querySql.append("       where d.people_id = t.people_id    \n");
		
		String commissionId=StrUtil.n2b((String)pset.getParameter("commissionId"));
		if(StringUtils.isNotEmpty(commissionId)){
			querySql.append("   AND T.COMMISSION_ID = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(commissionId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		
		return executeDataset(querySql.toString(),types,args,true);
	
	}
}