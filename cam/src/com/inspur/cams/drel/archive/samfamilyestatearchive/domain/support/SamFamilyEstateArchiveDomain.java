package com.inspur.cams.drel.archive.samfamilyestatearchive.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.samfamilyestatearchive.dao.ISamFamilyEstateArchiveDao;
import com.inspur.cams.drel.archive.samfamilyestatearchive.data.SamFamilyEstateArchive;
import com.inspur.cams.drel.archive.samfamilyestatearchive.domain.ISamFamilyEstateArchiveDomain;

/**
 * 家庭财产信息domain
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyEstateArchiveDomain implements ISamFamilyEstateArchiveDomain {

	@Reference
	private ISamFamilyEstateArchiveDao samFamilyEstateArchiveDao;

	/**
	 * 查询 家庭财产信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samFamilyEstateArchiveDao.query(pset);
	}

	/**
	 * 获取 家庭财产信息
	 * @param pset
	 * @return
	 */
	public SamFamilyEstateArchive get(String estateId) {
		return samFamilyEstateArchiveDao.get(estateId);
	}

	/**
	 * 增加 家庭财产信息
	 * @param samFamilyEstateArchive
	 */
	public void insert(SamFamilyEstateArchive samFamilyEstateArchive) {
		samFamilyEstateArchiveDao.insert(samFamilyEstateArchive);
	}
	
	/**
	 * 修改 家庭财产信息
	 * @param samFamilyEstateArchive
	 */
	public void update(SamFamilyEstateArchive samFamilyEstateArchive) {
		samFamilyEstateArchiveDao.update(samFamilyEstateArchive);
	}
	
	/**
	 * 删除 家庭财产信息
	 * @param estateId
	 */
	public void delete(String estateId) {
		samFamilyEstateArchiveDao.delete(estateId);
	}

}