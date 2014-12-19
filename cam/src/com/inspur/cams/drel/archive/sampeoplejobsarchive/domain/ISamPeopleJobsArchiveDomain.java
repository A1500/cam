package com.inspur.cams.drel.archive.sampeoplejobsarchive.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.sampeoplejobsarchive.data.SamPeopleJobsArchive;




/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public interface ISamPeopleJobsArchiveDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(SamPeopleJobsArchive samPeopleJobsArchive);

	@Trans
	public void update(SamPeopleJobsArchive samPeopleJobsArchive);

	@Trans
	public void delete(String key);
	
	@Trans
	public void save(List<SamPeopleJobsArchive> list);
}
