package com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxExtraPlanConcreteDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxExtraPlanConcreteDao extends BaseCURD<SomJxExtraPlanConcrete>{
	public void save(List<SomJxExtraPlanConcrete> list);
}

