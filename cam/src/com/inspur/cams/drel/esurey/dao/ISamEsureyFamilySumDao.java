package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.esurey.data.SamEsureyFamilySum;

/**
 * @title:ISamEsureyFamilySumDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyFamilySumDao extends BaseCURD<SamEsureyFamilySum>{
	public void save(List<SamEsureyFamilySum> list);
}

