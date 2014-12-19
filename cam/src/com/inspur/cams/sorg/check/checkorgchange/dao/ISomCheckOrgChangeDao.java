package com.inspur.cams.sorg.check.checkorgchange.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkorgchange.data.SomCheckOrgChange;

/**
 * @title:ISomCheckOrgChangeDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public interface ISomCheckOrgChangeDao extends BaseCURD<SomCheckOrgChange>{
	public void save(List<SomCheckOrgChange> list);
}

