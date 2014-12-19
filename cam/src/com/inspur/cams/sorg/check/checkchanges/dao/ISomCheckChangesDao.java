package com.inspur.cams.sorg.check.checkchanges.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges;

/**
 * @title:ISomCheckChangesDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckChangesDao extends BaseCURD<SomCheckChanges>{
	public void save(List<SomCheckChanges> list);
	public void deleteByTaskCode(String taskCode);
}

