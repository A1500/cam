package com.inspur.cams.sorg.check.businessactivity.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity;

/**
 * @title:ISomCheckBusinessActivityDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckBusinessActivityDao extends BaseCURD<SomCheckBusinessActivity>{
	public void save(List<SomCheckBusinessActivity> list);
}

