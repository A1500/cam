package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.ExportExcelPageUtil;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.info.dao.ID204c22Dao;
import com.inspur.cams.drel.info.data.D204c22;

/**
 * 房产dao
 * @author 
 * @date 2014-06-09
 */
public class D204c22Dao extends EntityDao<D204c22> implements ID204c22Dao {
	
	@Override
	public Class<D204c22> getEntityClass() {
		return D204c22.class;
	}
	
	public DataSet queryHouse(ParameterSet pset) {
		String commId = (String)pset.getParameter("commId");//申报ID
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.* ");
		sql.append("  from D204c22 t ");
		sql.append("  left join drel_commission c ");
		sql.append("   on c.commission_id = t.commission_id ");
		sql.append("  left join drel_info_query q ");
		sql.append("    on q.info_query_id = t.info_query_id ");
		sql.append(" where q.query_check_result = '1' ");
		if (StringUtils.isNotEmpty(commId)) {
			sql.append(" and c.commission_id=?  ");
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
			ds = this.executeDataset(sql.toString(), types, objs, ExportExcelPageUtil.getDsStart(pset), ExportExcelPageUtil.getDsLimit(pset), true);
		}else{
			ds = this.executeDataset(sql.toString(),ExportExcelPageUtil.getDsStart(pset), ExportExcelPageUtil.getDsLimit(pset),true);
		}
		return ds;
	}

	public DataSet queryFangguan(ParameterSet pset) {
		// TODO Auto-generated method stub
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		querySql.append("SELECT d.d204c220001,                           \n");
		querySql.append("       d.d204c220005,                            \n");
		querySql.append("       d.d204c220008,                           \n");
		querySql.append("       d.d204c220002,                           \n");
		querySql.append("       d.d204c220003,                           \n");
		querySql.append("       d.d204c220007,                           \n");
		querySql.append("       d.d204c220004,                           \n");
		querySql.append("       d.d204c220009,                           \n");
		querySql.append("       d.input_time,                            \n");
		querySql.append("       t.D204A010001,                            \n");
		querySql.append("       t.D204A010005                           \n");
		querySql.append("       from d204c22 d, D204A01 t                 \n");
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