package com.inspur.cams.bpt.edoc.domain;

import java.util.List;

public interface IBptCatalogueArchivesSaveDomain {
  
	public void saveCatalogueArchives(List list);
	public void deleteCatalogueArchives(String delId);
}
