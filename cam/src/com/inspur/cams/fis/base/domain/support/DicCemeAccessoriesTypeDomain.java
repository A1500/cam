package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IDicCemeAccessoriesTypeDao;
import com.inspur.cams.fis.base.data.DicCemeAccessoriesType;
import com.inspur.cams.fis.base.domain.IDicCemeAccessoriesTypeDomain;

/**
 * 公墓年检附件类型字典domain
 * @author 
 * @date 2013-08-01
 */
public class DicCemeAccessoriesTypeDomain implements IDicCemeAccessoriesTypeDomain {

	@Reference
	private IDicCemeAccessoriesTypeDao dicCemeAccessoriesTypeDao;

	/**
	 * 查询 公墓年检附件类型字典
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicCemeAccessoriesTypeDao.query(pset);
	}

	/**
	 * 获取 公墓年检附件类型字典
	 * @param pset
	 * @return
	 */
	public DicCemeAccessoriesType get(String code) {
		return dicCemeAccessoriesTypeDao.get(code);
	}

	/**
	 * 增加 公墓年检附件类型字典
	 * @param dicCemeAccessoriesType
	 */
	public void insert(DicCemeAccessoriesType dicCemeAccessoriesType) {
		dicCemeAccessoriesTypeDao.insert(dicCemeAccessoriesType);
	}
	
	/**
	 * 修改 公墓年检附件类型字典
	 * @param dicCemeAccessoriesType
	 */
	public void update(DicCemeAccessoriesType dicCemeAccessoriesType) {
		dicCemeAccessoriesTypeDao.update(dicCemeAccessoriesType);
	}
	
	/**
	 * 删除 公墓年检附件类型字典
	 * @param code
	 */
	public void delete(String code) {
		dicCemeAccessoriesTypeDao.delete(code);
	}

}