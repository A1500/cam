package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCatalogueArchivesQueryCommand
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
public class BptCatalogueArchivesQueryCommand extends BaseQueryCommand{
	private IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setSortField("CATALOG_ORDER");
		DataSet ds = service.queryCatalogueArchives(pset);
		ds.getMetaData().setIdProperty("UP_CATALOG_CODE");
		return ds;
	}
	
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		BptCatalogueArchivesDao dao = (BptCatalogueArchivesDao) DaoFactory
				.getDao(BptCatalogueArchivesDao.class);
		pset.setParameter("UP_CATALOG_CODE@=", "1");
		
		DataSet ds = dao.query(pset);
		//ds.getMetaData().setIdProperty("UP_CATALOG_CODE");
		System.out.println("2...........");
		return ds;
	}
	
	public DataSet queryOrgan(){
		BptCatalogueArchivesDao dao = (BptCatalogueArchivesDao) DaoFactory
		.getDao(BptCatalogueArchivesDao.class);
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.queryOrgan(pset);
		return ds;
	}
	
} 
