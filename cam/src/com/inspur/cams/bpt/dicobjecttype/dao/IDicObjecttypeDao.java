package com.inspur.cams.bpt.dicobjecttype.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IDicObjecttypeDao
 * @description:
 * @author:
 * @since:2011-08-16
 * @version:1.0
*/
 public interface IDicObjecttypeDao extends BaseCURD<DicObjecttype>{
	public void save(List<DicObjecttype> list);
}

