package com.inspur.cams.drel.archive.sampeoplediseasearchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeoplediseasearchive.data.SamPeopleDiseaseArchive;

/**
 * @title:ISamPeopleDiseaseArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleDiseaseArchiveDao extends BaseCURD<SamPeopleDiseaseArchive>{
	public void save(List<SamPeopleDiseaseArchive> list);
}

