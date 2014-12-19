package com.inspur.cams.sorg.check.somcheckmajordetail.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckMajorDetailDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckMajorDetailDao extends BaseCURD<SomCheckMajorDetail>{
	public void save(List<SomCheckMajorDetail> list);
}

