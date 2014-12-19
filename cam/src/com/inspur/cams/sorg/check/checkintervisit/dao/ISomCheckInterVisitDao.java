package com.inspur.cams.sorg.check.checkintervisit.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.sorg.check.checkintervisit.data.SomCheckInterVisit;

/**
 * @title:ISomCheckInterVisitDao
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
 public interface ISomCheckInterVisitDao extends BaseCURD<SomCheckInterVisit>{
	public void save(List<SomCheckInterVisit> list);
}

