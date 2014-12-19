package com.inspur.cams.drel.archive.sampeoplejobsarchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeoplejobsarchive.data.SamPeopleJobsArchive;

/**
 * @title:ISamPeopleJobsArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleJobsArchiveDao extends BaseCURD<SamPeopleJobsArchive>{
	public void save(List<SamPeopleJobsArchive> list);
}

