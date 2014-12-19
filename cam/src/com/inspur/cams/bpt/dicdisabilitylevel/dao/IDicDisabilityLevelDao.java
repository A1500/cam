package com.inspur.cams.bpt.dicdisabilitylevel.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IDicDisabilityLevelDao
 * @description:
 * @author:
 * @since:2011-11-03
 * @version:1.0
*/
 public interface IDicDisabilityLevelDao extends BaseCURD<DicDisabilityLevel>{
	public void save(List<DicDisabilityLevel> list);
}

