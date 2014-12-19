package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.dao.IFisVersionDao;
import com.inspur.cams.fis.base.data.FisVersion;
/**
* @Package com.inspur.cams.fis.base.dao.jdbc.FisVersionDao
* @Description: TODO
* @author luguosui 
* @date 2012-3-12
 */
 public class FisVersionDao extends EntityDao<FisVersion> implements IFisVersionDao{

 	public FisVersionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisVersion.class;
	}

	public String getVersion() {
		DataSet ds=this.executeDataset("select * from fis_Version ", true);
		if (ds.getCount()>0) {
			return (String)ds.getRecord(0).get("VERSION_NUM");
		}
		return "Test";
	}
   
}
