package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IDisabilityIdentificationDao;
import com.inspur.cams.bpt.base.data.DisabilityIdentification;

/**
 * @title:DisabilityIdentificationDao
 * @description:
 * @author:
 * @since:2011-05-18
 * @version:1.0
*/
 public class DisabilityIdentificationDao extends EntityDao<DisabilityIdentification> implements IDisabilityIdentificationDao{

 	public DisabilityIdentificationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<DisabilityIdentification> getEntityClass() {
		return DisabilityIdentification.class;
	}
   
   /**
	 * 获得编号最后三位的最大值
	 */
   public String getMaxNumber(String idPre){
	   StringBuffer sql = new StringBuffer();
	   sql.append("SELECT MAX(SUBSTR(T.NUMBERING, 11, 3)) AS FIX\n");
	   sql.append("  FROM BPT_DISABILITY_IDENTI T\n"); 
	   sql.append(" WHERE SUBSTR(T.NUMBERING, 1, 10) = ? ");
	   DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{idPre},true);
	   String fix;
	   if((String)ds.getRecord(0).get("FIX")==null){
		   fix = "001";
	   }else{
		   fix = (String)ds.getRecord(0).get("FIX");
		   fix = "000"+String.valueOf((Integer.valueOf(fix)+1));
		   fix = fix.substring(fix.length()-3);
	   }
	   return fix;
   }
   
}
