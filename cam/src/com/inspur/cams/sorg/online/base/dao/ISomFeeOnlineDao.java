package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomFeeOnline;

/**
 * @title:ISomFeeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public interface ISomFeeOnlineDao extends BaseCURD<SomFeeOnline>{
	public void save(List<SomFeeOnline> list);
}

