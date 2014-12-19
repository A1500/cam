package com.inspur.cams.sorg.check.checkworker.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkworker.data.SomCheckWorker;

/**
 * @title:ISomCheckWorkerDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckWorkerDao extends BaseCURD<SomCheckWorker>{
	public void save(List<SomCheckWorker> list);
}

