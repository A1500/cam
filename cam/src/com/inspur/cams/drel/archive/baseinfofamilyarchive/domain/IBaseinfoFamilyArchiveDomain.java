package com.inspur.cams.drel.archive.baseinfofamilyarchive.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public interface IBaseinfoFamilyArchiveDomain {
	/**
	 * 查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加
	 * 
	 * @param aseinfoFamilyArchive
	 */
	@Trans
	public void insert(BaseinfoFamilyArchive baseinfoFamilyArchive);

	/**
	 * 更新
	 * 
	 * @param aseinfoFamilyArchive
	 */
	@Trans
	public void update(BaseinfoFamilyArchive baseinfoFamilyArchive);
}
