package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;

/**
 * @title:IBptPeopleMartyrOffspringDao
 * @description:部分烈士（错杀被平反人员）子女 类别信息 domain层接口
 * @author:
 * @since: 
 * @version: 
*/
 public interface IBptPeopleMartyrOffspringDomain{
	 /**
	  * 添加
	  * @param bptPeopleMartyrOffspring
	  */
	 public void insert(BptPeopleMartyrOffspring bptPeopleMartyrOffspring);
	 /**
	  * 删除
	  * @param bptPeopleMartyrOffspring
	  */
	 public void delete(BptPeopleMartyrOffspring bptPeopleMartyrOffspring);
	 /**
	  * 修改
	  * @param bptPeopleMartyrOffspring
	  */
	 public void update(BptPeopleMartyrOffspring bptPeopleMartyrOffspring);
	 /**
	  * 查询
	  * @param pset
	  * @return
	  */
	 public DataSet query(ParameterSet pset);
	 public DataSet queryMartyrOffspring(ParameterSet pset);
}

