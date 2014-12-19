package com.inspur.cams.sorg.check.somcheck.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.check.somcheck.data.SomCheck;

/**
 * @title:ISomCheckDao
 * @description:
 * @author:
 * @since:2011-12-21
 * @version:1.0
*/
 public interface ISomCheckDao extends BaseCURD<SomCheck>{
	public void save(List<SomCheck> list);
	@Trans
	public void updateStatus(String taskCode,String status,String correctNotReason);
}

