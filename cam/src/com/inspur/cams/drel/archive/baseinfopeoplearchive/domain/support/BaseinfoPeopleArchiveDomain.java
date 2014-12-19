package com.inspur.cams.drel.archive.baseinfopeoplearchive.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.IBaseinfoPeopleArchiveDao;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.domain.IBaseinfoPeopleArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class BaseinfoPeopleArchiveDomain implements IBaseinfoPeopleArchiveDomain {
	@Reference
	private IBaseinfoPeopleArchiveDao baseinfoPeopleArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return baseinfoPeopleArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(BaseinfoPeopleArchive baseinfoPeopleArchive) {
		baseinfoPeopleArchiveDao.insert(baseinfoPeopleArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(BaseinfoPeopleArchive baseinfoPeopleArchive) {
		baseinfoPeopleArchiveDao.update(baseinfoPeopleArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		baseinfoPeopleArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<BaseinfoPeopleArchive> list) {
		baseinfoPeopleArchiveDao.save(list);
	}

	public DataSet queryPeopleDetail(ParameterSet pset) {
		// TODO Auto-generated method stub
		return baseinfoPeopleArchiveDao.queryPeopleDetail(pset);
	}
	/**
	* @Title: queryPeopleForSamArchive
	* @Description: TODO(人员列表)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryPeopleForSamArchive(ParameterSet pset) {
		return baseinfoPeopleArchiveDao.queryPeopleForSamArchive(pset);
	}
}
