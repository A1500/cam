package com.inspur.cams.drel.archive.sampeopleextendarchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.sampeopleextendarchive.dao.ISamPeopleExtendArchiveDao;
import com.inspur.cams.drel.archive.sampeopleextendarchive.data.SamPeopleExtendArchive;
import com.inspur.cams.drel.archive.sampeopleextendarchive.domain.ISamPeopleExtendArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleExtendArchiveDomain implements ISamPeopleExtendArchiveDomain {
	@Reference
	private ISamPeopleExtendArchiveDao samPeopleExtendArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleExtendArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleExtendArchive samPeopleExtendArchive) {
		samPeopleExtendArchiveDao.insert(samPeopleExtendArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleExtendArchive samPeopleExtendArchive) {
		samPeopleExtendArchiveDao.update(samPeopleExtendArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleExtendArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleExtendArchive> list) {
		samPeopleExtendArchiveDao.save(list);
	}
}
