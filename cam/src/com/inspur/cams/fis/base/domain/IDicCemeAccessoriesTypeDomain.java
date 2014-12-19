package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.DicCemeAccessoriesType;

/**
 * 公墓年检附件类型字典domain
 * @author 
 * @date 2013-08-01
 */
public interface IDicCemeAccessoriesTypeDomain {

	/**
	 * 查询 公墓年检附件类型字典
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公墓年检附件类型字典
	 * @param pset
	 * @return
	 */
	public DicCemeAccessoriesType get(String code);

	/**
	 * 增加 公墓年检附件类型字典
	 * @param dicCemeAccessoriesType
	 */
	@Trans
	public void insert(DicCemeAccessoriesType dicCemeAccessoriesType);
	
	/**
	 * 修改 公墓年检附件类型字典
	 * @param dicCemeAccessoriesType
	 */
	@Trans
	public void update(DicCemeAccessoriesType dicCemeAccessoriesType);
	
	/**
	 * 删除 公墓年检附件类型字典
	 * @param code
	 */
	@Trans
	public void delete(String code);

}