package com.inspur.cams.bpt.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptHouseSubsidyInfoDao;
import com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo;
import com.inspur.cams.bpt.base.domain.IBptHouseSubsidyInfoDomain;

/**
*建购房补助信息
*/
public class BptHouseSubsidyInfoDomain implements IBptHouseSubsidyInfoDomain{
	
	@Reference
	IBptHouseSubsidyInfoDao bptHouseSubsidyInfoDao;
	
	 /**
	  * 添加一条记录
	  */
	public void insert(BptHouseSubsidyInfo bptHouseSubsidyInfo){
		bptHouseSubsidyInfoDao.insert(bptHouseSubsidyInfo);
	}
	
	/**
	 * 更新一条记录
	 */
	public void update(BptHouseSubsidyInfo bptHouseSubsidyInfo){
		bptHouseSubsidyInfoDao.update(bptHouseSubsidyInfo);
	}
	
	
	/**
	 * 查询记录集
	 */
	public DataSet query(ParameterSet pset){
		return bptHouseSubsidyInfoDao.query(pset);
	}
	
	 /**
	  * 批量操作
	  */
	public void save(List<BptHouseSubsidyInfo> list){
		bptHouseSubsidyInfoDao.save(list);
	}
	
	/**
	 * 批量删除
	 */
	public void batchDelete(String[] delIds){
		bptHouseSubsidyInfoDao.batchDelete(delIds);
	}
}
