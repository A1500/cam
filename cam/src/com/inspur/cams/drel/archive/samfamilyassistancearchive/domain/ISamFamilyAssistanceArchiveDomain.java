package com.inspur.cams.drel.archive.samfamilyassistancearchive.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.samfamilyassistancearchive.data.SamFamilyAssistanceArchive;

/**
 * 社会救助_救助基本信息domain
 * @author 
 * @date 2012-06-28
 */
public interface ISamFamilyAssistanceArchiveDomain {

	/**
	 * 查询 社会救助_救助基本信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 社会救助_救助基本信息
	 * @param pset
	 * @return
	 */
	public SamFamilyAssistanceArchive get(String familyArchiveId, String familyId, String assistanceType);

	/**
	 * 增加 社会救助_救助基本信息
	 * @param samFamilyAssistanceArchive
	 */
	@Trans
	public void insert(SamFamilyAssistanceArchive samFamilyAssistanceArchive);
	
	/**
	 * 修改 社会救助_救助基本信息
	 * @param samFamilyAssistanceArchive
	 */
	@Trans
	public void update(SamFamilyAssistanceArchive samFamilyAssistanceArchive);
	
	/**
	 * 删除 社会救助_救助基本信息
	 * @param familyArchiveId, familyId, assistanceType
	 */
	@Trans
	public void delete(String familyArchiveId, String familyId, String assistanceType);

}