package com.inspur.cams.sorg.jxcheck.somjxfee.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxFeeDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxFeeDao extends BaseCURD<SomJxFee>{
	public void save(List<SomJxFee> list);
}

