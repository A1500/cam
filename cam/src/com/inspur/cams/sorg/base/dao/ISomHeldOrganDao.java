package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomHeldOrgan;

/**
 * 社会组织发起人（单位）dao实现类
 * @author shgtch
 * @date 2011-8-15
 */
public interface ISomHeldOrganDao extends BaseCURD<SomHeldOrgan> {

	/**
	 * 通过社会组织内码删除所有发起人（自然人）
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId);
	
	public DataSet queryHeldOrgan(ParameterSet pset);

}
