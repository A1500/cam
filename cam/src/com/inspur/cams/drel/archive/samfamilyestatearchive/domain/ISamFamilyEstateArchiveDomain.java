package com.inspur.cams.drel.archive.samfamilyestatearchive.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.samfamilyestatearchive.data.SamFamilyEstateArchive;

/**
 * 家庭财产信息domain
 * @author 
 * @date 2012-06-28
 */
public interface ISamFamilyEstateArchiveDomain {

	/**
	 * 查询 家庭财产信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 家庭财产信息
	 * @param pset
	 * @return
	 */
	public SamFamilyEstateArchive get(String estateId);

	/**
	 * 增加 家庭财产信息
	 * @param samFamilyEstateArchive
	 */
	@Trans
	public void insert(SamFamilyEstateArchive samFamilyEstateArchive);
	
	/**
	 * 修改 家庭财产信息
	 * @param samFamilyEstateArchive
	 */
	@Trans
	public void update(SamFamilyEstateArchive samFamilyEstateArchive);
	
	/**
	 * 删除 家庭财产信息
	 * @param estateId
	 */
	@Trans
	public void delete(String estateId);

}