package com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.IBaseinfoPeopleArchiveDao;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive;

/**
 * @title:BaseinfoPeopleArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class BaseinfoPeopleArchiveDao extends EntityDao<BaseinfoPeopleArchive> implements IBaseinfoPeopleArchiveDao{

 	public BaseinfoPeopleArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return BaseinfoPeopleArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from BaseinfoPeopleArchive");
	}

	
	/**
	 * @Title: queryPeopleDetail 
	 * @Description: TODO(人员详细信息查询) 
	 * @author wangziming
	 */
	public DataSet queryPeopleDetail(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		
		String peopleId = (String) pset.getParameter("peopleId");
			
		sql.append("SELECT DISTINCT ");
		sql.append("       P.PEOPLE_ID,");
		sql.append("       X.EXTNED_ID,");
		sql.append("       P.NAME,");
		sql.append("       P.SEX,");
		sql.append("       P.NATION,");
		sql.append("       P.ID_CARD,");
		sql.append("       P.PHOTO_ID,");
		sql.append("       P.DOMICILE_TYPE,");
		sql.append("       P.BIRTHDAY,");
		sql.append("       P.CAREER_CODE,");
		sql.append("       P.TEL_MOBILE,");
		sql.append("       P.ADDRESS,");
		sql.append("       P.POST_CODE,");
		sql.append("       P.POLITICAL_CODE,");
		sql.append("       P.HEALTH_CODE,");
		sql.append("       P.EDU_CODE,");
		sql.append("       P.MARRIAGE_CODE,");
		sql.append("       X.BELONGING,");
		sql.append("       X.IS_ASSISTANCE,");
		sql.append("       X.SPICAL_TYPE,");
		sql.append("       X.TRADITON_TYPE,");
		sql.append("       X.SUPPORT_WAY,");
		sql.append("       X.DOMICILE_ADDRESS,");
		sql.append("       X.DOMICILE_POST_CODE,");
		sql.append("       X.SELF_CARE_ABILITY,");
		sql.append("       X.LABOR_CAPACITY,");
		sql.append("       X.IS_THREE_NO,");
		sql.append("       X.ASSISTANCE_CLASS,");
		sql.append("       X.REMARKS ");
		sql.append("  FROM BASEINFO_PEOPLE_ARCHIVE P ");
		sql.append("  LEFT JOIN SAM_PEOPLE_EXTEND_ARCHIVE X ON P.PEOPLE_ARCHIVE_ID = X.PEOPLE_ARCHIVE_ID ");
		sql.append(" WHERE 1=1 ");
	
		if(StringUtils.isNotEmpty(peopleId)){
			sql.append("   AND P.PEOPLE_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}

	/**
	* @Title: queryPeopleForSamArchive
	* @Description: TODO(人员列表)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryPeopleForSamArchive(ParameterSet pset) {
		String applyId=(String)pset.getParameter("APPLY_ID");
		String peopleId=(String)pset.getParameter("PEOPLE_ID");
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT D.DISABILITY_TYPE,P.PEOPLE_ID,P.FAMILY_ARCHIVE_ID,P.NAME,P.ID_CARD,P.SEX,P.RELATIONSHIP_TYPE,P.HEALTH_CODE,P.EMPLOYMENT_CODE,P.EDU_CODE, ");
		sql.append("	P.INCOME_MONTH,P.INCOME_YEAR,P.PERSONAL_STATS_TAG, ");
		sql.append("	E.LABOR_CAPACITY ,E.SELF_CARE_ABILITY,E.IS_ASSISTANCE,  ");
		sql.append("	PE.EDU_STATUS ");
		sql.append(" FROM sam_people_disability_archive D,BASEINFO_PEOPLE_ARCHIVE P,SAM_PEOPLE_EXTEND_ARCHIVE E,SAM_PEOPLE_EDU_ARCHIVE PE ");
		sql.append(" WHERE D.PEOPLE_ARCHIVE_ID(+)=P.PEOPLE_ARCHIVE_ID AND P.PEOPLE_ARCHIVE_ID=E.PEOPLE_ARCHIVE_ID(+) AND P.PEOPLE_ARCHIVE_ID=PE.PEOPLE_ARCHIVE_ID(+) ");
		if(applyId!=null){
			sql.append(" AND P.APPLY_ID=? ");	
			sql.append(" ORDER BY P.RELATIONSHIP_TYPE ");			
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{applyId},true);
		}else{
			sql.append(" AND P.PEOPLE_ID=?");			
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);				
		}
	}

	public String queryExistPeople(String peopleId) {
		StringBuffer sql=new StringBuffer();
		sql.append("	select * ");
		sql.append("	from sam_family_treatment t ");
		sql.append("	 where t.apply_id in  ");
		sql.append("	 (select apply_id ");
		sql.append("	  from baseinfo_people_archive w ");
		sql.append("	 where w.people_id = ? ) ");
		sql.append("	 and t.BEGIN_DATE <= to_char(sysdate, 'yyyy-mm') ");
		sql.append("	 and t.end_date >= to_char(sysdate, 'yyyy-mm') ");
		DataSet ds = executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);
		if(ds.getCount() > 0 ){
			return "1";
		}else{
			return "0";
		}
	}
}