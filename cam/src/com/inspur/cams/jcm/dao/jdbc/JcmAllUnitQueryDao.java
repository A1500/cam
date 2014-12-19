package com.inspur.cams.jcm.dao.jdbc;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.jcm.dao.IJcmAllUnitQueryDao;
import com.inspur.cams.jcm.data.JcmAllUnitQuery;
/**
 * 所有单位信息表Dao
 * @author 陈寿业
 * @date 2014-12-15
 */
public class JcmAllUnitQueryDao extends EntityDao<JcmAllUnitQuery> implements
		IJcmAllUnitQueryDao {
	
	

	@Override
	public Class<JcmAllUnitQuery> getEntityClass() {
		return JcmAllUnitQuery.class;
	}
	/**
	 * @Title: getDsStart 
	 * @Description: TODO(excel分页信息A) 
	 * @author 
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	/**
	 * @Title: getDsLimit 
	 * @Description: TODO(excel分页信息B) 
	 * @author 
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit;
	}
	
	
	
	
	/**
	 * 查询所有单位
	 */
	public DataSet queryAllUnit(ParameterSet pset) {
		
		String companyName = (String)pset.getParameter("companyName");
		String companyNature = (String)pset.getParameter("companyNature");
		String organName=(String)pset.getParameter("organName");
		String companyType=(String)pset.getParameter("companyType");
		String companyPostCode=(String)pset.getParameter("companyPostCode");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from JCM_COMPANY_PROFILE D WHERE 1=1 ");
		
		if (StringUtils.isNotEmpty(companyName)) {
			sql.append(" AND D.COMPANY_NAME LIKE ?  ");
			objList.add(companyName);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyNature)) {
			sql.append(" and D.COMPANY_NATURE = ?  ");
			objList.add(companyNature);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(organName)) {
			sql.append(" and D.ORGAN_NAME =?  ");
			objList.add(organName);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyType)) {
			sql.append(" and D.COMPANY_TYPE=?  ");
			objList.add(companyType);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyPostCode)) {
			sql.append(" and D.COMPANY_POST_CODE=?  ");
			objList.add(companyPostCode);
			typeList.add(Types.VARCHAR);
		}
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs,getDsStart(pset), getDsLimit(pset),true);
		}
		return ds;
	}
}
