package com.inspur.cams.drel.archive.sampeoplediseasearchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.sampeoplediseasearchive.dao.ISamPeopleDiseaseArchiveDao;
import com.inspur.cams.drel.archive.sampeoplediseasearchive.data.SamPeopleDiseaseArchive;
import com.inspur.cams.drel.archive.sampeoplediseasearchive.domain.ISamPeopleDiseaseArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleDiseaseArchiveDomain implements ISamPeopleDiseaseArchiveDomain {
	@Reference
	private ISamPeopleDiseaseArchiveDao samPeopleDiseaseArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleDiseaseArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleDiseaseArchive samPeopleDiseaseArchive) {
		samPeopleDiseaseArchiveDao.insert(samPeopleDiseaseArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleDiseaseArchive samPeopleDiseaseArchive) {
		samPeopleDiseaseArchiveDao.update(samPeopleDiseaseArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleDiseaseArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleDiseaseArchive> list) {
		samPeopleDiseaseArchiveDao.save(list);
	}
}
