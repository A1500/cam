package com.inspur.cams.bpt.regulations.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.regulations.data.BptRegulations;

 public class BptRegulationsDao extends EntityDao<BptRegulations> implements IBptRegulationsDao{

 	public BptRegulationsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

    @Override
	public Class<BptRegulations> getEntityClass() {
		return BptRegulations.class;
	}
   
   public void deleteRegulations(ParameterSet pset){
       String[] ids = (String[]) pset.getParameter("ids");
       for(String id:ids){
           this.delete(id);
       }
   }
   
}
