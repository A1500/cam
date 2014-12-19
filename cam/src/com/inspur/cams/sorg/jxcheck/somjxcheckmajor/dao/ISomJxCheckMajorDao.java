package com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckMajorDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public interface ISomJxCheckMajorDao extends BaseCURD<SomJxCheckMajor>{
	public void save(List<SomJxCheckMajor> list);
}

