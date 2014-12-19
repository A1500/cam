package com.inspur.cams.sorg.jxcheck.somjxextraplan.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxExtraPlanDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxExtraPlanDao extends BaseCURD<SomJxExtraPlan>{
	public void save(List<SomJxExtraPlan> list);
}

