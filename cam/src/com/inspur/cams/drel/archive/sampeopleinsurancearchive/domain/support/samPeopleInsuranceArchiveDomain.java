package com.inspur.cams.drel.archive.sampeopleinsurancearchive.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.sampeopleinsurancearchive.dao.ISamPeopleInsuranceArchiveDao;
import com.inspur.cams.drel.archive.sampeopleinsurancearchive.data.SamPeopleInsuranceArchive;
import com.inspur.cams.drel.archive.sampeopleinsurancearchive.domain.ISamPeopleInsuranceArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class samPeopleInsuranceArchiveDomain implements ISamPeopleInsuranceArchiveDomain {
	@Reference
	private ISamPeopleInsuranceArchiveDao samPeopleInsuranceArchiveDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleInsuranceArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamPeopleInsuranceArchive samPeopleInsuranceArchive) {
		samPeopleInsuranceArchiveDao.insert(samPeopleInsuranceArchive);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamPeopleInsuranceArchive samPeopleInsuranceArchive) {
		samPeopleInsuranceArchiveDao.update(samPeopleInsuranceArchive);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samPeopleInsuranceArchiveDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamPeopleInsuranceArchive> list) {
		samPeopleInsuranceArchiveDao.save(list);
	}
}
