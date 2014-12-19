package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.info.dao.ID204z62Dao;
import com.inspur.cams.drel.info.data.D204z62;


/**
 * 殡葬信息dao
 * @author 
 * @date 2014-08-21
 */
public class D204z62Dao extends EntityDao<D204z62> implements ID204z62Dao {
	
	@Override
	public Class<D204z62> getEntityClass() {
		return D204z62.class;
	}

	public DataSet queryBinzang(ParameterSet pset) {
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		querySql.append("SELECT d.d204z620004,                           \n");
		querySql.append("       d.d204z620006,                            \n");
		querySql.append("       d.d204z620007,                           \n");
		querySql.append("       d.d204z620008,                           \n");
		querySql.append("       d.d204z620009,                           \n");
		querySql.append("       d.create_organ_name,                           \n");
		querySql.append("       d.input_time,                            \n");
		querySql.append("       t.D204A010001,                            \n");
		querySql.append("       t.D204A010005                           \n");
		querySql.append("       from d204z62 d, D204A01 t                 \n");
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