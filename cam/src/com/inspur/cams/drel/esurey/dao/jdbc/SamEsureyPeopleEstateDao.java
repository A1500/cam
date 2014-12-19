package com.inspur.cams.drel.esurey.dao.jdbc;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleEstateDao;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate;

/**
 * @title:SamEsureyPeopleEstateDao
 * @description:经济核对_财产收入申报信息
 * @author:路国隋
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyPeopleEstateDao extends EntityDao<SamEsureyPeopleEstate> implements ISamEsureyPeopleEstateDao{

 	public SamEsureyPeopleEstateDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyPeopleEstate.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyPeopleEstate");
	}
   public void deleteById(String id){
	   String sql="delete from SAM_ESUREY_PEOPLE_ESTATE where ID='"+id+"'";
	   executeUpdate(sql);
   }
   public void delete(String peopleId){
	   String sql="DELETE FROM SAM_ESUREY_PEOPLE_ESTATE WHERE TYPE='1' AND PEOPLE_ID='"+peopleId+"'";
	   executeUpdate(sql);
   }

   public void upadetPeopleEstate(SamEsureyPeopleEstate samEsureyPeopleEstate) {
	   StringBuffer sql=new StringBuffer();
	   sql.append("update  SAM_ESUREY_PEOPLE_ESTATE \n");
	   sql.append("set PERIOD='"+samEsureyPeopleEstate.getPeriod()+"' \n");
	   sql.append(",ITEM='"+samEsureyPeopleEstate.getItem()+"' \n");
	   sql.append(",NUM='"+samEsureyPeopleEstate.getNum()+"' \n");
	   sql.append(",FAMILY_ID= '"+samEsureyPeopleEstate.getFamilyId()+"'\n");
	   sql.append("where FEEDBACK_ID='"+samEsureyPeopleEstate.getFeedbackId()+"' \n");
	   executeUpdate(sql.toString());
   }
   /**
	 * 查询家庭成员的收入
	 * @param paramSet
	 * @return
	 */
	public DataSet queryPeopleIncom(ParameterSet paramSet) {
		StringBuffer sql=new StringBuffer();
		sql.append("select people_id,sum(num) income \n");
		sql.append("from SAM_ESUREY_PEOPLE_ESTATE \n");
		sql.append("	where type = '1'  \n");
		sql.append("		and item in ('1', '2', '3') \n");
		String peopleIds=paramSet.get("peopleIds").toString();
		sql.append("		and people_id in('"+peopleIds+"')  \n");
		sql.append("		group by people_id \n");
		return executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(),true);
	}
	/**
	 * 查询家庭财产
	 * @param paramSet
	 * @return
	 */
	public DataSet queryFamilyWorth(ParameterSet paramSet) {
		StringBuffer sql=new StringBuffer();
		sql.append("select SURVEY_ID, sum(num) \n");
		sql.append("  from SAM_ESUREY_PEOPLE_ESTATE \n");
		sql.append(" where type = '2' \n");
		sql.append("   and item in ('4', '5', '6', '7') \n");
		String surveyId=paramSet.get("surveyId").toString();
		sql.append("and survey_id='"+surveyId+"' \n");
		sql.append(" \n");
		sql.append(" group by SURVEY_ID \n");
		return executeDataset(sql.toString(),paramSet.getPageStart(),paramSet.getPageLimit(),true);
	}
	/**
	 * 查询家庭或个人收入
	 * @param pset
	 * @return
	 */
	public DataSet queryFamilyIncome(ParameterSet pset){
		StringBuffer sql= new StringBuffer();
		sql.append("  select sum(case when type = '1' and item in ('1', '2', '3') then  num else 0 end) \n");
		sql.append(" + sum(case when type = '2' and item = '8' then   decode(PERIOD, 'Y', num / 12, num)   else 0 end) money \n");
		
		String familyIds=(String)pset.getParameter("familyId");
		if(StringUtils.isNotEmpty(familyIds)){
			sql.append(" ,sum(case when a.item in ('4','5','6','7') and a.type='2' then num else 0 end) worth \n");
			sql.append(" ,a.family_id,b.people_num,b.domicile_type ,b.family_address  \n");
			sql.append(" from sam_esurey_people_estate a,sam_esurey_family b  \n");
			sql.append(" where a.family_id = b.family_id \n");
		
			sql.append(" and a.family_id in ('"+familyIds+"') \n");
			
			sql.append("group by a.family_id,b.people_num,b.domicile_type,b.family_address ");
		}else{
			String peopleIds=(String)pset.getParameter("peopleId");
			if(StringUtils.isNotEmpty(peopleIds)){
				sql.append(", b.people_id ,b.family_Id\n");
				sql.append(" from  sam_esurey_people_estate a,sam_esurey_people b \n");
				sql.append(" where a.people_id=b.people_id \n");
				sql.append(" and a.people_id in ('"+peopleIds+"') \n");
				sql.append("group by b.people_id,b.family_Id  ");
			}
		}
		return executeDataset(sql.toString(), true);
	}
}
