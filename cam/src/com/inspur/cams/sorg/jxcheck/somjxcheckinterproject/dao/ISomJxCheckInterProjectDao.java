package com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckInterProjectDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckInterProjectDao extends BaseCURD<SomJxCheckInterProject>{
	public void save(List<SomJxCheckInterProject> list);
}

