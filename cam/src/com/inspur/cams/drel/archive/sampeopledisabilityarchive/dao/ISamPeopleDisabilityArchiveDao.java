package com.inspur.cams.drel.archive.sampeopledisabilityarchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeopledisabilityarchive.data.SamPeopleDisabilityArchive;

/**
 * @title:ISamPeopleDisabilityArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleDisabilityArchiveDao extends BaseCURD<SamPeopleDisabilityArchive>{
	public void save(List<SamPeopleDisabilityArchive> list);
}

