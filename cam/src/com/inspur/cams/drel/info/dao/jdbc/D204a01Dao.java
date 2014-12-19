package com.inspur.cams.drel.info.dao.jdbc;

import java.sql.Types;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.info.dao.ID204a01Dao;
import com.inspur.cams.drel.info.data.D204a01;

/**
 * 成员信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204a01Dao extends EntityDao<D204a01> implements ID204a01Dao {
	
	@Override
	public Class<D204a01> getEntityClass() {
		return D204a01.class;
	}
	
	public void deletePersonAndInfo(ParameterSet pset){
		String peopleId = (String)pset.getParameter("peopleId");
		String familyId = (String)pset.getParameter("familyId");
		String commissionId = (String)pset.getParameter("commissionId");
		//调用执行删除操作的存储过程...........
	}
	
	public DataSet queryPeopleInfo(ParameterSet pset){
		String areaName = (String)pset.getParameter("areaName");
		String feedbackTime = (String)pset.getParameter("feedbackTime");
		StringBuffer sql = new StringBuffer();
		sql.append(" select p.*,ec.family_name,ec.family_id_card,ec.current_status from ensure_to_client ec left join  d204a01 p ");
		sql.append("  on p.family_id = ec.apply_id ");
		sql.append(" where ec.AREA_NAME = '"+areaName+"' ");
		sql.append(" and ec.FEEDBACK_TIME = '"+feedbackTime+"' ");
		sql.append(" order by ec.family_id_card  ");
//		System.out.println(sql.toString());
		return executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(), true);
	}
}