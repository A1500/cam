package com.inspur.cams.drel.archive.sampeopletypearchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeopletypearchive.data.SamPeopleTypeArchive;

/**
 * @title:ISamPeopleTypeArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleTypeArchiveDao extends BaseCURD<SamPeopleTypeArchive>{
	public void save(List<SamPeopleTypeArchive> list);
}

