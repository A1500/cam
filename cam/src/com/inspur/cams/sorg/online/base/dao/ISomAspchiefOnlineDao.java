package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomAspchiefOnline;

/**
 * @title:ISomAspchiefOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public interface ISomAspchiefOnlineDao extends BaseCURD<SomAspchiefOnline>{
	public void save(List<SomAspchiefOnline> list);
}

