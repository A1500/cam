package com.inspur.cams.sorg.check.checkevent.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;

/**
 * @title:ISomCheckEventDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 public interface ISomCheckEventDao extends BaseCURD<SomCheckEvent>{
	public void save(List<SomCheckEvent> list);
	
	public void deleteByTaskCode(String taskCode);
}

