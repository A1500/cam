package com.inspur.cams.sorg.check.somchecklargedonation.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckLargeDonationDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckLargeDonationDao extends BaseCURD<SomCheckLargeDonation>{
	public void save(List<SomCheckLargeDonation> list);
}

