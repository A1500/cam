package com.inspur.cams.sorg.check.checkdues.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkdues.data.SomCheckDues;

/**
 * @title:ISomCheckDuesDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckDuesDao extends BaseCURD<SomCheckDues>{
	public void save(List<SomCheckDues> list);
}

