package com.inspur.cams.drel.config.assistance.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.config.assistance.dao.ISamAssistanceClassDao;
import com.inspur.cams.drel.config.assistance.data.SamAssistanceClass;

/**
 * @title:分类施保配置dao
 * @description:
 * @author:
 * @since:2012-05-02
 * @version:1.0
 */
public class SamAssistanceClassDao extends EntityDao<SamAssistanceClass>
		implements ISamAssistanceClassDao {

	@SuppressWarnings("unchecked")
	@Override
	protected Class getEntityClass() {
		return SamAssistanceClass.class;
	}

	@SuppressWarnings("unchecked")
	public SamAssistanceClass getClassMoney(ParameterSet pset) {
		String classCode=(String)pset.getParameter("classCode");
		String organArea=(String)pset.getParameter("organArea");
		String nowTime=(String)pset.getParameter("nowTime");
		String assistanceType=(String)pset.getParameter("assistanceType");
		 StringBuffer sql = new StringBuffer();
		 sql.append(" select * from sam_assistance_class t where t.assistance_class_code= ?  and t.area_code = ? and t.assistance_type=? and ? between t.begin_date and t.end_date ");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(classCode);
		 typeList.add(Types.VARCHAR);
		 argsList.add(organArea);
		 
		 typeList.add(Types.VARCHAR);
		 argsList.add(assistanceType);
		 
		 typeList.add(Types.VARCHAR);
		 argsList.add(nowTime);
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds= this.executeDataset(sql.toString(), types, args, true);
		 if(ds.getCount() > 0){
			 SamAssistanceClass sac = new SamAssistanceClass();
			 sac.setComputeValue((BigDecimal)ds.getRecord(0).get("COMPUTE_VALUE"));
			 sac.setComputeMode((String)ds.getRecord(0).get("COMPUTE_MODE"));
			 return sac;
		 }else{
			 return new SamAssistanceClass();
		 }
	}
}
