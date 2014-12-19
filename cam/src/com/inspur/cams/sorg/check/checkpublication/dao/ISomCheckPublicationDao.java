package com.inspur.cams.sorg.check.checkpublication.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkpublication.data.SomCheckPublication;

/**
 * @title:ISomCheckPublicationDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckPublicationDao extends BaseCURD<SomCheckPublication>{
	public void save(List<SomCheckPublication> list);
}

