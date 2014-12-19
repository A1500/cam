package com.inspur.cams.dis.base.dao.support;

import java.util.List;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.dao.IDisBaseFamilyRecordDao;
import com.inspur.cams.dis.base.data.DisBaseFamilyRecord;
/**
 * @title:DisBaseFamilyRecordDao
 * @description:
 * @author:
 * @since:2012-10-23
 * @version:1.0
*/
 public class DisBaseFamilyRecordDao extends EntityDao<DisBaseFamilyRecord> implements IDisBaseFamilyRecordDao{

 	public DisBaseFamilyRecordDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return DisBaseFamilyRecord.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from DisBaseFamilyRecord");
	}
   
   public DataSet loadIdCardMessage(ParameterSet pset){
	   String idCard = (String)pset.getParameter("ID_CARD");
	   StringBuffer sql = new StringBuffer();
	   sql.append("select * from (");
	   sql.append("select a.RECORD_ID,a.ORGAN_CODE,a.ORGAN_NAME,a.TOWN_CODE,a.VILLIAGE_CODE,a.NAME,a.ID_CARD,a.FAMILY_NUM,a.FAMILY_TYPE,a.FAMILY_REGISTER,a.HOUSE_COUNT,a.HOUSE_STRUCTURE\n");
	   sql.append("  from DIS_BASE_FAMILY_RECORD a, DIS_RELIEF_INFO b\n"); 
	   sql.append(" where a.record_id=b.record_id\n"); 
	   sql.append(" and ID_CARD = '").append(idCard).append("'\n");
	   sql.append(" order by b.fill_time desc)");
	   sql.append(" where rownum=1");
	   return executeDataset(sql.toString(), false);
   }
   
}
