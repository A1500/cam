package com.inspur.cams.drel.archive.samfamilyassistancearchive.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.samfamilyassistancearchive.dao.ISamFamilyAssistanceArchiveDao;
import com.inspur.cams.drel.archive.samfamilyassistancearchive.data.SamFamilyAssistanceArchive;
import com.inspur.cams.drel.archive.samfamilyassistancearchive.domain.ISamFamilyAssistanceArchiveDomain;

/**
 * 社会救助_救助基本信息domain
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyAssistanceArchiveDomain implements ISamFamilyAssistanceArchiveDomain {

	@Reference
	private ISamFamilyAssistanceArchiveDao samFamilyAssistanceArchiveDao;

	/**
	 * 查询 社会救助_救助基本信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samFamilyAssistanceArchiveDao.query(pset);
	}

	/**
	 * 获取 社会救助_救助基本信息
	 * @param pset
	 * @return
	 */
	public SamFamilyAssistanceArchive get(String familyArchiveId, String familyId, String assistanceType) {
		return samFamilyAssistanceArchiveDao.get(familyArchiveId, familyId, assistanceType);
	}

	/**
	 * 增加 社会救助_救助基本信息
	 * @param samFamilyAssistanceArchive
	 */
	public void insert(SamFamilyAssistanceArchive samFamilyAssistanceArchive) {
		samFamilyAssistanceArchiveDao.insert(samFamilyAssistanceArchive);
	}
	
	/**
	 * 修改 社会救助_救助基本信息
	 * @param samFamilyAssistanceArchive
	 */
	public void update(SamFamilyAssistanceArchive samFamilyAssistanceArchive) {
		samFamilyAssistanceArchiveDao.update(samFamilyAssistanceArchive);
	}
	
	/**
	 * 删除 社会救助_救助基本信息
	 * @param familyArchiveId, familyId, assistanceType
	 */
	public void delete(String familyArchiveId, String familyId, String assistanceType) {
		samFamilyAssistanceArchiveDao.delete(familyArchiveId, familyId, assistanceType);
	}

}