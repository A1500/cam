package com.inspur.cams.drel.archive.sampeopleeduarchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.sampeopleeduarchive.dao.ISamPeopleEduArchiveDao;
import com.inspur.cams.drel.archive.sampeopleeduarchive.data.SamPeopleEduArchive;
import com.inspur.cams.drel.archive.sampeopleeduarchive.domain.ISamPeopleEduArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleEduArchiveDomain implements ISamPeopleEduArchiveDomain {
	@Reference
	private ISamPeopleEduArchiveDao samPeopleEduArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleEduArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleEduArchive samPeopleEduArchive) {
		samPeopleEduArchiveDao.insert(samPeopleEduArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleEduArchive samPeopleEduArchive) {
		samPeopleEduArchiveDao.update(samPeopleEduArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleEduArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleEduArchive> list) {
		samPeopleEduArchiveDao.save(list);
	}
}
