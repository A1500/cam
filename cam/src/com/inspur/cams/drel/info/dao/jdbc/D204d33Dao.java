package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.info.dao.ID204d33Dao;
import com.inspur.cams.drel.info.data.D204d33;

/**
 * 纳税情况dao
 * @author 
 * @date 2014-06-09
 */
public class D204d33Dao extends EntityDao<D204d33> implements ID204d33Dao {
	
	@Override
	public Class<D204d33> getEntityClass() {
		return D204d33.class;
	}

	public DataSet queryGuoshui(ParameterSet pset) {
		// TODO Auto-generated method stub
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		querySql.append("SELECT d.d204d330002,                           \n");
		querySql.append("       d.d204d330013,                            \n");
		querySql.append("       d.d204d330011,                           \n");
		querySql.append("       d.d204d330017,                           \n");
		querySql.append("       d.d204d330009,                           \n");
		querySql.append("       d.d204d330010,                           \n");
		querySql.append("       d.input_time,                            \n");
		querySql.append("       t.D204A010001,                            \n");
		querySql.append("       t.D204A010005                            \n");
		querySql.append("       from d204d33 d, D204A01 t                 \n");
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