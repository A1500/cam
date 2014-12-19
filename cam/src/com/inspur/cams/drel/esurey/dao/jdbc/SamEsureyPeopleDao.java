package com.inspur.cams.drel.esurey.dao.jdbc;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleDao;
import com.inspur.cams.drel.esurey.data.SamEsureyPeople;

/**
 * @title:SamEsureyPeopleDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyPeopleDao extends EntityDao<SamEsureyPeople> implements ISamEsureyPeopleDao{

 	public SamEsureyPeopleDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyPeople.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyPeople");
	}
   public void delete(String delId){
	   String sql="DELETE FROM SAM_ESUREY_PEOPLE WHERE PEOPLE_ID='"+delId+"'";
	   executeUpdate(sql);
   }
   /**
	 * 根据familyId查询赡养人员
	 */
	public DataSet querySupportPeople(ParameterSet pset){
		StringBuffer sql=new StringBuffer("select PEOPLE_ID,FAMILY_ID ,IS_SUPPORT,NAME,ID_CARD,RELATIONSHIP_TYPE,SEX,NATION FROM SAM_ESUREY_PEOPLE WHERE PEOPLE_ID in " +
				"(select s.PEOPLE_ID FROM SAM_ESUREY_RELATION s WHERE 1=1 ");
		String familyId=(String)pset.getParameter("familyId");
		if(StringUtils.isNotEmpty(familyId)){
			sql.append(" AND FAMILY_ID='"+familyId+"')");
		}else{
			sql.append(" AND FAMILY_ID='0')");
		}		
		return executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(),true);
	}
	/**
	 * 根据peopleId查询信息
	 */
	public DataSet queryPeopleById(ParameterSet pset){
		StringBuffer sql=new StringBuffer("select p.IS_SUPPORT IS_SUPPORT, p.PEOPLE_ID PEOPLE_ID,p.FAMILY_ID FAMILY_ID,p.RELATIONSHIP_TYPE RELATIONSHIP_TYPE,");
		sql.append("GET_CITYNAME(p.DOMICILE_CODE) DOMICILE_CODE,GET_CITYNAME(P.APANAGE_CODE) APANAGE_CODE,p.NAME NAME,p.ID_CARD ID_CARD,");
		sql.append("p.SEX SEX,p.BIRTHDAY BIRTHDAY,p.NATION NATION,p.EDU_CODE EDU_CODE,p.HEALTH_CODE HEALTH_CODE,p.MARRIAGE_CODE MARRIAGE_CODE,");
		sql.append("p.CAREER_CODE CAREER_CODE,p.POLITICAL_CODE POLITICAL_CODE,p.DOMICILE_TYPE DOMICILE_TYPE,p.TEL_MOBILE TEL_MOBILE,");
		sql.append("p.TEL_OTHER TEL_OTHER,p.ADDRESS ADDRESS,p.POST_CODE POST_CODE,p.INCOME_YEAR INCOME_YEAR,p.INCOME_MONTH INCOME_MONTH,");
		sql.append("p.EMPLOYMENT_CODE EMPLOYMENT_CODE,p.PERSONAL_STATS_TAG PERSONAL_STATS_TAG,s.INCOME_YEAR SUM_INCOME_YEAR,");
		sql.append("s.INCOME_MONTH SUM_INCOME_MONTH  from SAM_ESUREY_PEOPLE p, SAM_ESUREY_PEOPLE_SUM s  where p.PEOPLE_ID=s.PEOPLE_ID ");
		String peopleId=(String)pset.getParameter("peopleId");
			sql.append("AND p.PEOPLE_ID='"+peopleId+"'");
			DataSet ds=executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(),true);
			if(ds.getCount()==0){
				StringBuffer sql2=new StringBuffer("select p.IS_SUPPORT IS_SUPPORT, p.PEOPLE_ID PEOPLE_ID,p.FAMILY_ID FAMILY_ID,p.RELATIONSHIP_TYPE RELATIONSHIP_TYPE,");
				sql2.append("GET_CITYNAME(p.DOMICILE_CODE) DOMICILE_CODE,GET_CITYNAME(P.APANAGE_CODE) APANAGE_CODE,p.NAME NAME,p.ID_CARD ID_CARD,");
				sql2.append("p.SEX SEX,p.BIRTHDAY BIRTHDAY,p.NATION NATION,p.EDU_CODE EDU_CODE,p.HEALTH_CODE HEALTH_CODE,p.MARRIAGE_CODE MARRIAGE_CODE,");
				sql2.append("p.CAREER_CODE CAREER_CODE,p.POLITICAL_CODE POLITICAL_CODE,p.DOMICILE_TYPE DOMICILE_TYPE,p.TEL_MOBILE TEL_MOBILE,");
				sql2.append("p.TEL_OTHER TEL_OTHER,p.ADDRESS ADDRESS,p.POST_CODE POST_CODE,p.INCOME_YEAR INCOME_YEAR,p.INCOME_MONTH INCOME_MONTH,");
				sql2.append("p.EMPLOYMENT_CODE EMPLOYMENT_CODE,p.PERSONAL_STATS_TAG PERSONAL_STATS_TAG,'0' SUM_INCOME_YEAR,");
				sql2.append(" '0' SUM_INCOME_MONTH  from SAM_ESUREY_PEOPLE p WHERE 1=1  ");
				sql2.append("AND p.PEOPLE_ID='"+peopleId+"'");
				return executeDataset(sql2.toString(),pset.getPageStart(),pset.getPageLimit(),true);
			}else{
				return ds;
			}
	}
	/**
	 * 检查家庭成员中身份证的唯一性
	 */
	public String queryUnqiue(ParameterSet pset){
		StringBuffer sql=new StringBuffer("SELECT PEOPLE_ID FROM SAM_ESUREY_PEOPLE WHERE 1=1 AND ");
		String familyId=(String)pset.getParameter("familyId");
		String idCard=(String)pset.getParameter("idCard");
		if(StringUtils.isNotEmpty(familyId)){
			sql.append("FAMILY_ID='"+familyId+"' AND ");
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("ID_CARD='"+idCard+"' ");
		}
		List list=this.executeQuery(sql.toString());
		int num=list.size();
		if(num==0||list==null){
			return "0";
		}else{
			String[] peopleIds=new String[num];
			for(int i=0;i<num;i++){
				String peopleId=(String)((Map)list.get(i)).get("PEOPLE_ID");
				peopleIds[i]=peopleId;
			}
			return peopleIds[0];
		}
	}
}
