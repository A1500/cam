package com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxLargeDonationDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public interface ISomJxLargeDonationDao extends BaseCURD<SomJxLargeDonation>{
	public void save(List<SomJxLargeDonation> list);
}

