package com.inspur.cams.bpt.edoc.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptElectronicDao;
import com.inspur.cams.bpt.edoc.dao.IBptCatalogueArchivesDao;
import com.inspur.cams.bpt.edoc.domain.IBptCatalogueArchivesDomain;


public class BptCatalogueArchivesDomain implements IBptCatalogueArchivesDomain {
	@Reference
	private IBptCatalogueArchivesDao bptCatalogueArchivesDao;
	
	public void batchInsert(List list){
		//bptCatalogueArchivesDao.save(list);
		bptCatalogueArchivesDao.batchInsert(list);
	}

	public DataSet queryCatalogueArchives(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptCatalogueArchivesDao.query(pset);
	}
}
