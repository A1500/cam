package com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCommonwealDetailDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCommonwealDetailDao extends BaseCURD<SomJxCommonwealDetail>{
	public void save(List<SomJxCommonwealDetail> list);
}

