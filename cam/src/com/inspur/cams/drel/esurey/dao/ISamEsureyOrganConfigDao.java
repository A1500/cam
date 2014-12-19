package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig;

/**
 * @title:ISamEsureyOrganConfigDao
 * @description:
 * @author:
 * @since:2011-07-05
 * @version:1.0
*/
 public interface ISamEsureyOrganConfigDao extends BaseCURD<SamEsureyOrganConfig>{
	public void save(List<SamEsureyOrganConfig> list);
}

