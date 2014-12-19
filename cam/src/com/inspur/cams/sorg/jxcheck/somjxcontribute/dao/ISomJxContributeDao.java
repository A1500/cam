package com.inspur.cams.sorg.jxcheck.somjxcontribute.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxContributeDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxContributeDao extends BaseCURD<SomJxContribute>{
	public void save(List<SomJxContribute> list);
}

