package com.inspur.cams.sorg.check.somcheckmajor.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckMajorDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckMajorDao extends BaseCURD<SomCheckMajor>{
	public void save(List<SomCheckMajor> list);
}

