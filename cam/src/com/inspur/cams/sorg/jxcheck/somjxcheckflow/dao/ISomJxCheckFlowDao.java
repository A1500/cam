package com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckFlowDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckFlowDao extends BaseCURD<SomJxCheckFlow>{
	public void save(List<SomJxCheckFlow> list);
}

