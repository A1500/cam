package com.inspur.cams.sorg.check.checkcouncil.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil;

/**
 * @title:ISomCheckCouncilDao
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 public interface ISomCheckCouncilDao extends BaseCURD<SomCheckCouncil>{
	public void save(List<SomCheckCouncil> list);
}

