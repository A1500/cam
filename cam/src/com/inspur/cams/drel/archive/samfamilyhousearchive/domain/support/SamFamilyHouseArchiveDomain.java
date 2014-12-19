package com.inspur.cams.drel.archive.samfamilyhousearchive.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.samfamilyhousearchive.dao.ISamFamilyHouseArchiveDao;
import com.inspur.cams.drel.archive.samfamilyhousearchive.data.SamFamilyHouseArchive;
import com.inspur.cams.drel.archive.samfamilyhousearchive.domain.ISamFamilyHouseArchiveDomain;

/**
 * 基础信息_房屋信息domain
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyHouseArchiveDomain implements ISamFamilyHouseArchiveDomain {

	@Reference
	private ISamFamilyHouseArchiveDao samFamilyHouseArchiveDao;

	/**
	 * 查询 基础信息_房屋信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samFamilyHouseArchiveDao.query(pset);
	}

	/**
	 * 获取 基础信息_房屋信息
	 * @param pset
	 * @return
	 */
	public SamFamilyHouseArchive get(String houseArchiveId) {
		return samFamilyHouseArchiveDao.get(houseArchiveId);
	}

	/**
	 * 增加 基础信息_房屋信息
	 * @param samFamilyHouseArchive
	 */
	public void insert(SamFamilyHouseArchive samFamilyHouseArchive) {
		samFamilyHouseArchiveDao.insert(samFamilyHouseArchive);
	}
	
	/**
	 * 修改 基础信息_房屋信息
	 * @param samFamilyHouseArchive
	 */
	public void update(SamFamilyHouseArchive samFamilyHouseArchive) {
		samFamilyHouseArchiveDao.update(samFamilyHouseArchive);
	}
	
	/**
	 * 删除 基础信息_房屋信息
	 * @param houseArchiveId
	 */
	public void delete(String houseArchiveId) {
		samFamilyHouseArchiveDao.delete(houseArchiveId);
	}

}