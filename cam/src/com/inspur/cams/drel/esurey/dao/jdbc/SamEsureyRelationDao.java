package com.inspur.cams.drel.esurey.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.dao.ISamEsureyRelationDao;
import com.inspur.cams.drel.esurey.data.SamEsureyRelation;

/**
 * @title:SamEsureyRelationDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyRelationDao extends EntityDao<SamEsureyRelation> implements ISamEsureyRelationDao{

 	public SamEsureyRelationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyRelation.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyRelation");
	}
   public void delete(String supportId){
	   String sql="delete from SAM_ESUREY_RELATION WHERE SUPPORT_FAMILY_ID='"+supportId+"'";
	   executeUpdate(sql);
   }
   public void deleteByPeopleId(String peopleId){
	   String sql="delete from SAM_ESUREY_RELATION WHERE PEOPLE_ID='"+peopleId+"'";
	   executeUpdate(sql);	   
   }
   public void deleteSupFamily(String supFamId, String famId) {
	   StringBuffer sql=new StringBuffer();
	   sql.append("delete from SAM_ESUREY_RELATION WHERE SUPPORT_FAMILY_ID='");
	   sql.append(supFamId+"'");
	   sql.append("AND FAMILY_ID='");
	   sql.append(famId+"'");
	   executeUpdate(sql.toString());	 
   }
   /**
	 * 根据家庭Id查找赡养家庭Id及人口数
	 * @param pset
	 * @return
	 */
	public DataSet queryRelFamiyIdNum(ParameterSet pset) {
		StringBuffer sql=new StringBuffer();
		sql.append("select a.family_id, a.PEOPLE_NUM, a.DOMICILE_TYPE,a.family_Address   \n");
		sql.append("  from sam_esurey_family a  \n");
		String familyId=pset.getParameter("familyId").toString();
		sql.append(" where a.family_id in (select support_family_Id  from sam_esurey_relation  where family_id = '"+familyId+"'  group by support_family_Id)\n");
		return executeDataset(sql.toString(), true);
	}
}
