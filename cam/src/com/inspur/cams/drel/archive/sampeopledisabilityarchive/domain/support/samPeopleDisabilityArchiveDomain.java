package com.inspur.cams.drel.archive.sampeopledisabilityarchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.archive.sampeopledisabilityarchive.dao.ISamPeopleDisabilityArchiveDao;
import com.inspur.cams.drel.archive.sampeopledisabilityarchive.data.SamPeopleDisabilityArchive;
import com.inspur.cams.drel.archive.sampeopledisabilityarchive.domain.ISamPeopleDisabilityArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleDisabilityArchiveDomain implements ISamPeopleDisabilityArchiveDomain {
	@Reference
	private ISamPeopleDisabilityArchiveDao samPeopleDisabilityArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleDisabilityArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleDisabilityArchive samPeopleDisabilityArchive) {
		samPeopleDisabilityArchiveDao.insert(samPeopleDisabilityArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleDisabilityArchive samPeopleDisabilityArchive) {
		samPeopleDisabilityArchiveDao.update(samPeopleDisabilityArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleDisabilityArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleDisabilityArchive> list) {
		samPeopleDisabilityArchiveDao.save(list);
	}
}
