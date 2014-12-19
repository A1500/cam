package com.inspur.cams.bpt.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyDisability;

/**
 * @title:IBptApplyDisabilityDao
 * @description:
 * @author:
 * @since:2011-06-10
 * @version:1.0
*/
 public interface IBptApplyDisabilityDao extends BaseCURD<BptApplyDisability>{
	public void save(List<BptApplyDisability> list);
	
	/**
	 * 查询未提交的调残人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiAdjust(ParameterSet pset);
	/**
	 * 删除伤残相关信息
	 * @param pset
	 */
	public void deleteAboutDisability(ParameterSet pset);
	
	/**
	 * 查询审批后打证信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryPrintInfo(ParameterSet pset);
	
	/**
	 * 修改打印标示
	 * @param pset
	 */
	public void editPrintFlag(ParameterSet pset);

	public DataSet queryApplyInfoForCheck(ParameterSet pset);
}

