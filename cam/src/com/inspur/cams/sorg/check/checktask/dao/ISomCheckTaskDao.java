package com.inspur.cams.sorg.check.checktask.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checktask.data.SomCheckTask;

/**
 * @title:ISomCheckTaskDao
 * @description:
 * @author:
 * @since:2011-12-28
 * @version:1.0
*/
 public interface ISomCheckTaskDao extends BaseCURD<SomCheckTask>{
	public void save(List<SomCheckTask> list);
}

