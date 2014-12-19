package com.inspur.cams.drel.archive.sampeopleinsurancearchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.archive.sampeopleinsurancearchive.data.SamPeopleInsuranceArchive;

/**
 * @title:ISamPeopleInsuranceArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface ISamPeopleInsuranceArchiveDao extends BaseCURD<SamPeopleInsuranceArchive>{
	public void save(List<SamPeopleInsuranceArchive> list);
}

