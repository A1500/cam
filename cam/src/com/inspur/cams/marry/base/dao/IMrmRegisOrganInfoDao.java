package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmRegisOrganInfo;

/**
 * @title:IMrmRegisOrganInfoDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public interface IMrmRegisOrganInfoDao extends BaseCURD<MrmRegisOrganInfo>{
	public void save(List<MrmRegisOrganInfo> list);
	
	/**
	 * 查询婚姻登记处列表
	 * @param pset
	 * @return
	 */
	public DataSet queryOrganInfoList(ParameterSet pset);
	/**
	 * 查询所有带等级的登记处
	 * @return
	 */
	public DataSet queryLevelOrgan(ParameterSet pset);

	public void setLevel(String applyLevel, String organCode);
}

