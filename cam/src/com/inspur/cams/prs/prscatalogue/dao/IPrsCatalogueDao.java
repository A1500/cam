package com.inspur.cams.prs.prscatalogue.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IPrsCatalogueDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public interface IPrsCatalogueDao extends BaseCURD<PrsCatalogue>{
	public void save(List<PrsCatalogue> list);
}

