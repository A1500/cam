package com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxMajorDetailDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public interface ISomJxMajorDetailDao extends BaseCURD<SomJxMajorDetail>{
	public void save(List<SomJxMajorDetail> list);
}

