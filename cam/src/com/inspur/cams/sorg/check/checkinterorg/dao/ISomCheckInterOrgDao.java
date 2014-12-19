package com.inspur.cams.sorg.check.checkinterorg.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkinterorg.data.SomCheckInterOrg;

/**
 * @title:ISomCheckInterOrgDao
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
 public interface ISomCheckInterOrgDao extends BaseCURD<SomCheckInterOrg>{
	public void save(List<SomCheckInterOrg> list);
}

