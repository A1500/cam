package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomAspchief;

/**
 * 社会组织拟任负责人dao接口
 * @author shgtch
 * @date 2011-8-15
 */
public interface ISomAspchiefDao extends BaseCURD<SomAspchief> {

	/**
	 * 通过社会组织内码删除所有拟任负责人
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId);
	/**
	 * 通过taskCode删除所有拟任负责人
	 * @param taskCode
	 */
	public void deleteAllAspchiefByTaskCode(String taskCode);
	
	public DataSet queryNoPage(ParameterSet pset);

}
