package com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckInterOrgDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckInterOrgDao extends BaseCURD<SomJxCheckInterOrg>{
	public void save(List<SomJxCheckInterOrg> list);
}

