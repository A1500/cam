package com.inspur.cams.sorg.check.somchecksupervisoropinion.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckSupervisorOpinionDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckSupervisorOpinionDao extends BaseCURD<SomCheckSupervisorOpinion>{
	public void save(List<SomCheckSupervisorOpinion> list);
}

