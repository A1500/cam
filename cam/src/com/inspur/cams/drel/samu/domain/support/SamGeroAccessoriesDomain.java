package com.inspur.cams.drel.samu.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.samu.dao.ISamGeroAccessoriesDao;
import com.inspur.cams.drel.samu.data.SamGeroAccessories;
import com.inspur.cams.drel.samu.domain.ISamGeroAccessoriesDomain;

/**
 * 敬老院附件信息表domain
 * @author 
 * @date 2012-10-24
 */
public class SamGeroAccessoriesDomain implements ISamGeroAccessoriesDomain {

	@Reference
	private ISamGeroAccessoriesDao samGeroAccessoriesDao;

	/**
	 * 查询 敬老院附件信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samGeroAccessoriesDao.query(pset);
	}

	/**
	 * 获取 敬老院附件信息表
	 * @param pset
	 * @return
	 */
	public SamGeroAccessories get(String accessoriesId) {
		return samGeroAccessoriesDao.get(accessoriesId);
	}

	/**
	 * 增加 敬老院附件信息表
	 * @param samGeroAccessories
	 */
	public void insert(SamGeroAccessories samGeroAccessories) {
		samGeroAccessoriesDao.insert(samGeroAccessories);
	}
	
	/**
	 * 修改 敬老院附件信息表
	 * @param samGeroAccessories
	 */
	public void update(SamGeroAccessories samGeroAccessories) {
		samGeroAccessoriesDao.update(samGeroAccessories);
	}
	
	/**
	 * 删除 敬老院附件信息表
	 * @param accessoriesId
	 */
	public void delete(String accessoriesId) {
		samGeroAccessoriesDao.delete(accessoriesId);
	}

}