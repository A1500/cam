package com.inspur.cams.sorg.check.checkdonatedetail.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkdonatedetail.data.SomCheckDonateDetail;


/**
 * @title:ISomCheckDonateDetailDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 public interface ISomCheckDonateDetailDao extends BaseCURD<SomCheckDonateDetail>{
	public void save(List<SomCheckDonateDetail> list);
}

