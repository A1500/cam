package com.inspur.cams.drel.archive.sampeopleincomearchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeopleincomearchive.data.SamPeopleIncomeArchive;

/**
 * @title:ISamPeopleIncomeArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleIncomeArchiveDao extends BaseCURD<SamPeopleIncomeArchive>{
	public void save(List<SamPeopleIncomeArchive> list);
}

