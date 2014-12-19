package com.inspur.cams.sorg.check.checkorgdetail.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkorgdetail.data.SomCheckOrgDetail;

/**
 * @title:ISomCheckOrgDetailDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckOrgDetailDao extends BaseCURD<SomCheckOrgDetail>{
	public void save(List<SomCheckOrgDetail> list);
}

