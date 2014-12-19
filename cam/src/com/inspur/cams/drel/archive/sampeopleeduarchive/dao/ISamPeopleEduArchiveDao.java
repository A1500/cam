package com.inspur.cams.drel.archive.sampeopleeduarchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeopleeduarchive.data.SamPeopleEduArchive;

/**
 * @title:ISamPeopleEduArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleEduArchiveDao extends BaseCURD<SamPeopleEduArchive>{
	public void save(List<SamPeopleEduArchive> list);
}

