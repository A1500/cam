package com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCommonwealOutputDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCommonwealOutputDao extends BaseCURD<SomJxCommonwealOutput>{
	public void save(List<SomJxCommonwealOutput> list);
}

