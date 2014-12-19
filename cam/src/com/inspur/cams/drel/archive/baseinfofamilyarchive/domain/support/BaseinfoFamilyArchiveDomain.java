package com.inspur.cams.drel.archive.baseinfofamilyarchive.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.IBaseinfoFamilyArchiveDao;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.domain.IBaseinfoFamilyArchiveDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class BaseinfoFamilyArchiveDomain implements IBaseinfoFamilyArchiveDomain {
	@Reference
	private IBaseinfoFamilyArchiveDao baseinfoFamilyArchiveDao;

	/**
	 * 查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return baseinfoFamilyArchiveDao.query(pset);
	}

	/**
	 * 增加
	 * 
	 * @param samAssistanceItem
	 */
	public void insert(BaseinfoFamilyArchive baseinfoFamilyArchive) {
		baseinfoFamilyArchiveDao.insert(baseinfoFamilyArchive);
	}

	/**
	 * 更新
	 * 
	 * @param samAssistanceItem
	 */
	public void update(BaseinfoFamilyArchive baseinfoFamilyArchive) {
		baseinfoFamilyArchiveDao.update(baseinfoFamilyArchive);
	}
}
