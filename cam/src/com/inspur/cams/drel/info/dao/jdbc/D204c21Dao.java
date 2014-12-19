package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.info.dao.ID204c21Dao;
import com.inspur.cams.drel.info.data.D204c21;

/**
 * 车辆dao
 * @author 
 * @date 2014-06-09
 */
public class D204c21Dao extends EntityDao<D204c21> implements ID204c21Dao {
	
	@Override
	public Class<D204c21> getEntityClass() {
		return D204c21.class;
	}

	public DataSet queryCheliang(ParameterSet pset) {
		// TODO Auto-generated method stub
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		querySql.append("SELECT d.d204c210002,                           \n");
		querySql.append("       d.input_time,                            \n");
		querySql.append("       d.d204c210004,                           \n");
		querySql.append("       d.d204c210001,                           \n");
		querySql.append("       d.d204c210005,                           \n");
		querySql.append("       d.input_time,                          \n");
		querySql.append("       t.d204a010001,                           \n");
		querySql.append("       t.d204a010005,                            \n");
		querySql.append("       t.d204a010014                            \n");
		querySql.append("       from D204C21 d, D204A01 t                 \n");
		querySql.append("       where d.people_id = t.people_id    \n");
		
		String commissionId=StrUtil.n2b((String)pset.getParameter("commissionId"));
		String peopleId=StrUtil.n2b((String)pset.getParameter("peopleId"));
		if(StringUtils.isNotEmpty(commissionId)){
			querySql.append("   AND d.COMMISSION_ID = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(commissionId);
		}
		if(StringUtils.isNotEmpty(peopleId)){
			querySql.append("   AND T.PEOPLE_ID = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		
		return executeDataset(querySql.toString(),types,args,true);
	}

	
}