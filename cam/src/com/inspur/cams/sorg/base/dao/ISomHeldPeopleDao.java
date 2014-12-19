package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomHeldPeople;

/**
 * 社会组织发起人（自然人）dao接口
 * @author shgtch
 * @date 2011-8-15
 */
public interface ISomHeldPeopleDao extends BaseCURD<SomHeldPeople> {

	/**
	 * 通过社会组织内码删除所有发起人（自然人）
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId);
	
	/**
	 * 查询不翻页的发起人（自然人）
	 * @param pset
	 * @return
	 */
	public DataSet queryHeldPeople(ParameterSet pset);
	
}
