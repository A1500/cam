package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousInstituteDao;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousInstitute;


/**
 * @title:BptGloriousInstituteDao
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 public class BptGloriousInstituteDao extends EntityDao<BptGloriousInstitute> implements IBptGloriousInstituteDao{

 	public BptGloriousInstituteDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return BptGloriousInstitute.class;
	}
  
   public void batchDeleteGlorious(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from bpt_glorious_institute where GLORIOUS_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   public DataSet getMaxYear(ParameterSet pset){
		String gloriousId = (String)pset.get("gloriousId");
		String sql = "select max(t.years) as mx  from BPT_GLORIOUS_DETAIL t where t.GLORIOUS_ID='"+gloriousId+"'";
		return super.executeDataset(sql.toString(), true);
	}
   
}
