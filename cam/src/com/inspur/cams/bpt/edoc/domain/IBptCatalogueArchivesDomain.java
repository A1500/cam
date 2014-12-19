package com.inspur.cams.bpt.edoc.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;


public interface IBptCatalogueArchivesDomain {
  
	public void batchInsert(List list);
	
	public DataSet queryCatalogueArchives(ParameterSet pset);
}
