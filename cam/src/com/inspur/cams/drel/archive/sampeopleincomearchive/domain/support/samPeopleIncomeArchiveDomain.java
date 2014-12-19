package com.inspur.cams.drel.archive.sampeopleincomearchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.sampeopleincomearchive.dao.ISamPeopleIncomeArchiveDao;
import com.inspur.cams.drel.archive.sampeopleincomearchive.data.SamPeopleIncomeArchive;
import com.inspur.cams.drel.archive.sampeopleincomearchive.domain.ISamPeopleIncomeArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleIncomeArchiveDomain implements ISamPeopleIncomeArchiveDomain {
	@Reference
	private ISamPeopleIncomeArchiveDao samPeopleIncomeArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleIncomeArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleIncomeArchive samPeopleIncomeArchive) {
		samPeopleIncomeArchiveDao.insert(samPeopleIncomeArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleIncomeArchive samPeopleIncomeArchive) {
		samPeopleIncomeArchiveDao.update(samPeopleIncomeArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleIncomeArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleIncomeArchive> list) {
		samPeopleIncomeArchiveDao.save(list);
	}
}
