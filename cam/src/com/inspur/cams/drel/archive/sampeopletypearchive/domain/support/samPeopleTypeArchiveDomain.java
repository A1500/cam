package com.inspur.cams.drel.archive.sampeopletypearchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.sampeopletypearchive.dao.ISamPeopleTypeArchiveDao;
import com.inspur.cams.drel.archive.sampeopletypearchive.data.SamPeopleTypeArchive;
import com.inspur.cams.drel.archive.sampeopletypearchive.domain.ISamPeopleTypeArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleTypeArchiveDomain implements ISamPeopleTypeArchiveDomain {
	@Reference
	private ISamPeopleTypeArchiveDao samPeopleTypeArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleTypeArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleTypeArchive samPeopleTypeArchive) {
		samPeopleTypeArchiveDao.insert(samPeopleTypeArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleTypeArchive samPeopleTypeArchive) {
		samPeopleTypeArchiveDao.update(samPeopleTypeArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleTypeArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleTypeArchive> list) {
		samPeopleTypeArchiveDao.save(list);
	}
}
