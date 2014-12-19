package com.inspur.cams.bpt.edoc.domain.support;

import java.util.List;

import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.edoc.dao.IBptCatalogueArchivesDao;
import com.inspur.cams.bpt.edoc.domain.IBptCatalogueArchivesSaveDomain;
public class BptCatalogueArchivesSaveDomain implements IBptCatalogueArchivesSaveDomain {
    
	@Reference
	private IBptCatalogueArchivesDao  bptCatalogueArchivesSaveDao;
	public void deleteCatalogueArchives(String delId) {
		// TODO Auto-generated method stub
		bptCatalogueArchivesSaveDao.delete(delId);
	}

	public void saveCatalogueArchives(List list) {
		// TODO Auto-generated method stub
		bptCatalogueArchivesSaveDao.save(list);
	}

}
