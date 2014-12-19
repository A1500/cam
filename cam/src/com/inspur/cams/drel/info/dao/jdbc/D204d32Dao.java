package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.info.dao.ID204d32Dao;
import com.inspur.cams.drel.info.data.D204d32;

/**
 * 社会保险缴费dao
 * @author 
 * @date 2014-06-09
 */
public class D204d32Dao extends EntityDao<D204d32> implements ID204d32Dao {
	
	@Override
	public Class<D204d32> getEntityClass() {
		return D204d32.class;
	}

	public DataSet queryShebao(ParameterSet pset) {
		// TODO Auto-generated method stub
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		querySql.append("SELECT d.d204d320010,                           \n");
		querySql.append("       d.d204d320006,                            \n");
		querySql.append("       d.d204d320026,                           \n");
		querySql.append("       d.d204d320002,                           \n");
		querySql.append("       d.d204d320027,                           \n");
		querySql.append("       d.d204d320003,                           \n");
		querySql.append("       d.d204d320028,                           \n");
		querySql.append("       d.d204d320004,                           \n");
		querySql.append("       d.d204d320005,                           \n");
		querySql.append("       d.d204d320029,                           \n");
		querySql.append("       d.d204d320030,                           \n");
		querySql.append("       d.d204d320031,                           \n");
		querySql.append("       d.compare_type,                           \n");
		querySql.append("       d.input_time,                            \n");
		querySql.append("       t.D204A010001,                            \n");
		querySql.append("       t.D204A010005                           \n");
		querySql.append("       from d204d32 d, D204A01 t                 \n");
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