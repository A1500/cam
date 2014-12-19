package com.inspur.cams.sorg.check.checkinterproject.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkinterproject.data.SomCheckInterProject;

/**
 * @title:ISomCheckInterProjectDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 public interface ISomCheckInterProjectDao extends BaseCURD<SomCheckInterProject>{
	public void save(List<SomCheckInterProject> list);
	public void deleteByTaskCode(String taskCode);
}

