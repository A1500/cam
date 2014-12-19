package com.inspur.cams.comm.informUtil;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;


/**
 * @title:PubOrganDao
 * @description:
 * @author:
 * @since:2010-12-04
 * @version:1.0
*/
 public class InformPubOrganDao extends EntityDao<InformPubOrgan> implements InformIPubOrganDao{

 	public InformPubOrganDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return InformPubOrgan.class;
	}

  	public InformPubOrgan getPubOrganByOrgId(String orgId){
  		ParameterSet pset = new ParameterSet();
  		pset.setParameter("ORGAN_ID", orgId);
  		DataSet ds = this.query(pset);
  		if(ds.getCount()>0){
  			return (InformPubOrgan)ds.getRecord(0).toBean(InformPubOrgan.class);
  		}
  		return null;

  	}

}
