package com.inspur.cams.bpt.base.domain;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo;

/**
 * @title:IBptHouseSubsidyInfoDao
 * @description:建购房补助信息
 * @author:
 * @since:2011-07-04
 * @version:1.0
*/
 public interface IBptHouseSubsidyInfoDomain{
	 /**
	  * 添加一条记录
	  */
	public void insert(BptHouseSubsidyInfo bptHouseSubsidyInfo); 
	
	/**
	 * 更新一条记录
	 */
	public void update(BptHouseSubsidyInfo bptHouseSubsidyInfo);
	
	/**
	 * 查询记录集
	 */
	public DataSet query(ParameterSet pset);
	
	 /**
	  * 批量操作
	  */
	public void save(List<BptHouseSubsidyInfo> list);
	
	/**
	 * 批量删除
	 */
	public void batchDelete(String[] delIds);
}

