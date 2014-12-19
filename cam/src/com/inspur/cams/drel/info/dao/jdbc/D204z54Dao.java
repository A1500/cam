package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.info.dao.ID204z54Dao;
import com.inspur.cams.drel.info.data.D204z54;

/**
 * 社会组织管理信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z54Dao extends EntityDao<D204z54> implements ID204z54Dao {
	
	@Override
	public Class<D204z54> getEntityClass() {
		return D204z54.class;
	}

	public DataSet queryMinfei(ParameterSet pset) {
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		querySql.append("SELECT d.d204z540001,                           \n");
		querySql.append("       d.d204z540002,                            \n");
		querySql.append("       d.d204z540003,                           \n");
		querySql.append("       d.d204z540007,                           \n");
		querySql.append("       d.d204z540005,                           \n");
		querySql.append("       d.d204z540006,                           \n");
		querySql.append("       d.d204z540004,                           \n");
		querySql.append("       d.d204z540008,                           \n");
		querySql.append("       t.input_time,                            \n");
		querySql.append("       t.D204A010001,                            \n");
		querySql.append("       t.D204A010005                            \n");
		querySql.append("       from d204z54 d, D204A01 t                 \n");
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