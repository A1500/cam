package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.esurey.data.SamEsureyPeopleSum;

/**
 * @title:ISamEsureyPeopleSumDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyPeopleSumDao extends BaseCURD<SamEsureyPeopleSum>{
	public void save(List<SamEsureyPeopleSum> list);
}

