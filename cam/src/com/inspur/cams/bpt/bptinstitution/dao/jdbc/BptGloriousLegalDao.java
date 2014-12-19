package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousLegalDao;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal;

/**
 * @title:BptGloriousLegalDao
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 public class BptGloriousLegalDao extends EntityDao<BptGloriousLegal> implements IBptGloriousLegalDao{
 
 	public BptGloriousLegalDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return BptGloriousLegal.class;
	}
	
	public void deleteByBptGloriousInstitute(String fkId) {
		executeUpdate("delete from  BPT_GLORIOUS_LEGAL where GLORIOUS_DETAIL_ID='" + fkId + "'");
	}

	public void batchDeleteByBptGloriousInstitute(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BPT_GLORIOUS_LEGAL where GLORIOUS_DETAIL_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	public void batchDeleteByGloriousIds(String[] gIds){
		String[] sql = new String[gIds.length];
		for (int i = 0; i < gIds.length; i++) {
			sql[i] = "delete from bpt_glorious_legal c where c.glorious_detail_id= (select v.id from bpt_glorious_detail v where v.glorious_id = '" + gIds[i] + "')";
		}
		batchUpdate(sql);
	}
}
