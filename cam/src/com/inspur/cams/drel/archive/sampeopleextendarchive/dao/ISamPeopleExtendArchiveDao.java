package com.inspur.cams.drel.archive.sampeopleextendarchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeopleextendarchive.data.SamPeopleExtendArchive;

/**
 * @title:ISamPeopleExtendArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleExtendArchiveDao extends BaseCURD<SamPeopleExtendArchive>{
	public void save(List<SamPeopleExtendArchive> list);
}

