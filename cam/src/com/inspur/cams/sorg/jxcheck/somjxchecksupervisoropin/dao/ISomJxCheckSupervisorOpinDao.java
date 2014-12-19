package com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckSupervisorOpinDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckSupervisorOpinDao extends BaseCURD<SomJxCheckSupervisorOpin>{
	public void save(List<SomJxCheckSupervisorOpin> list);
}

