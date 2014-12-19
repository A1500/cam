package com.inspur.cams.bpt.edoc.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.edoc.data.BptCatalogueArchives;

/**
 * @title:IBptCatalogueArchivesDao
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
 public interface IBptCatalogueArchivesDao extends BaseCURD<BptCatalogueArchives>{
	public void save(List<BptCatalogueArchives> list);
	public DataSet queryOrgan(ParameterSet param);
}

