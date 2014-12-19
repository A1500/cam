package com.inspur.cams.drel.esurey.dao.jdbc;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.dao.ISamEsureySurveyDao;
import com.inspur.cams.drel.esurey.data.SamEsureySurvey;

/**
 * @title:SamEsureySurveyDao
 * @description:经济核对_核对流水
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureySurveyDao extends EntityDao<SamEsureySurvey> implements ISamEsureySurveyDao{

 	public SamEsureySurveyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureySurvey.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureySurvey");
	}
   public void delete(String peopleId){
	   String sql="DELETE FROM SAM_ESUREY_SURVEY where TYPE='1' AND PEOPLE_ID='"+peopleId+"'";
	   executeUpdate(sql);
   }

	/**
	 * 查询家庭核对流水
	 * @return
	 */
	public DataSet queryForEsureyList(ParameterSet pset) {
		StringBuffer sql=new StringBuffer();
		sql.append("SELECT decode((select count(*) from sam_esurey_feedback b  where b.survey_id = survey_id  and b.check_flg = '0'  and b.family_id=s.family_id), 0, '已全部提交', '未全部提交') CHECK_IN,  s.*,f.FAMILY_NAME,f.FAMILY_ADDRESS,f.ASSISTANCE_TYPE,f.DOMICILE_TYPE,get_CITY_NAME(f.FAMILY_ADDRESS) AS FAMILY_ADDRESS_NAME,f.YEAR_INCOME,f.YEAR_AVERAGE_INCOME,f.MONTH_INCOME,f.MONTH_AVERAGE_INCOME,f.PEOPLE_NUM,f.FAMILY_CARD_NO,f.CUR_ACTIVITY,f.CUR_STATE \n");
		sql.append("FROM sam_esurey_survey s, sam_esurey_family f \n");
		sql.append( " WHERE s.family_id = f.family_id");
		sql.append( " AND f.CUR_ACTIVITY='03' ");//过滤：只显示核对代办业务
		String curState =(String) pset.getParameter("curStatus");
		if(StringUtils.isNotEmpty(curState)){
			sql.append(" AND  f.CUR_STATE='"+curState+"' ");
			
		}else {
			sql.append(" AND  f.CUR_STATE='1' ");
		}
		String name =(String) pset.getParameter("name");
		if(StringUtils.isNotEmpty(name)){
			sql.append(" and f.FAMILY_NAME='" + name + "'");
		}
		String idCard =(String) pset.getParameter("idCard");
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" and f.FAMILY_CARD_NO='" + idCard + "'");
		}
		String surveyOrg =(String) pset.getParameter("surveyOrg");
		if(StringUtils.isNotEmpty(surveyOrg)){
			sql.append(" and s.survey_Org='" + surveyOrg + "'");
		}
		sql.append("   order by s.SURVEY_DATE desc ");
		return executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(),true);
	}
}
