package com.inspur.cams.sorg.check.somcontribute.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomContributeDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomContributeDao extends BaseCURD<SomContribute>{
	public void save(List<SomContribute> list);
}

