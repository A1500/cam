package com.inspur.cams.bpt.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptApplyDependant;

/**
 * @title:IBptApplyDependantDao
 * @description:
 * @author:
 * @since:2011-08-10
 * @version:1.0
*/
 public interface IBptApplyDependantDao extends BaseCURD<BptApplyDependant>{
	public void save(List<BptApplyDependant> list);
	
	/**
	 * 查询审批信息
	 * @param applyId
	 * @return
	 */
	public DataSet queryApplyDependant(String applyId) ;
	public void deleteDependant (ParameterSet pset);
	 
}

