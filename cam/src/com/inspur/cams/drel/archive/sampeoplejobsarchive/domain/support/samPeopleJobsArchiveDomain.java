package com.inspur.cams.drel.archive.sampeoplejobsarchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.sampeoplejobsarchive.dao.ISamPeopleJobsArchiveDao;
import com.inspur.cams.drel.archive.sampeoplejobsarchive.data.SamPeopleJobsArchive;
import com.inspur.cams.drel.archive.sampeoplejobsarchive.domain.ISamPeopleJobsArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleJobsArchiveDomain implements ISamPeopleJobsArchiveDomain {
	@Reference
	private ISamPeopleJobsArchiveDao samPeopleJobsArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleJobsArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleJobsArchive samPeopleJobsArchive) {
		samPeopleJobsArchiveDao.insert(samPeopleJobsArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleJobsArchive samPeopleJobsArchive) {
		samPeopleJobsArchiveDao.update(samPeopleJobsArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleJobsArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleJobsArchive> list) {
		samPeopleJobsArchiveDao.save(list);
	}
}
