package com.inspur.cams.drel.archive.samfamilyhousearchive.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.samfamilyhousearchive.data.SamFamilyHouseArchive;

/**
 * 基础信息_房屋信息domain
 * @author 
 * @date 2012-06-28
 */
public interface ISamFamilyHouseArchiveDomain {

	/**
	 * 查询 基础信息_房屋信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 基础信息_房屋信息
	 * @param pset
	 * @return
	 */
	public SamFamilyHouseArchive get(String houseArchiveId);

	/**
	 * 增加 基础信息_房屋信息
	 * @param samFamilyHouseArchive
	 */
	@Trans
	public void insert(SamFamilyHouseArchive samFamilyHouseArchive);
	
	/**
	 * 修改 基础信息_房屋信息
	 * @param samFamilyHouseArchive
	 */
	@Trans
	public void update(SamFamilyHouseArchive samFamilyHouseArchive);
	
	/**
	 * 删除 基础信息_房屋信息
	 * @param houseArchiveId
	 */
	@Trans
	public void delete(String houseArchiveId);

}