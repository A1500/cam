package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.dao.ID204c23Dao;
import com.inspur.cams.drel.info.data.D204c23;

/**
 * 存款dao
 * @author 
 * @date 2014-06-09
 */
public class D204c23Dao extends EntityDao<D204c23> implements ID204c23Dao {
	
	@Override
	public Class<D204c23> getEntityClass() {
		return D204c23.class;
	}

	public DataSet queryBank(ParameterSet pset) {
	 	String peopleId = (String)pset.getParameter("peopleId");//家庭ID
	 	String commId = (String)pset.getParameter("commId");//委托ID
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.D204c230006 as BALANCE,m.D204C290002 as BIG_OUT,n.d204d360003 as FINANCE_PRODUCT");
		sql.append(" from D204C23 t ");
		sql.append(" left join D204C29 m");
		sql.append("  on t.commission_id = m.commission_id");
		sql.append(" left join D204D36 n");
		sql.append("  on t.commission_id = n.commission_id");
		sql.append(" WHERE 1=1");
		if (StringUtils.isNotEmpty(peopleId)) {
			sql.append(" and t.PEOPLE_ID=?  ");
			objList.add(peopleId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(commId)) {
			sql.append(" and t.commission_id=?  ");
			objList.add(commId);
			typeList.add(Types.VARCHAR);
		}
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		}else{
			ds = this.executeDataset(sql.toString(),true);
		}
		return ds;
	}
}