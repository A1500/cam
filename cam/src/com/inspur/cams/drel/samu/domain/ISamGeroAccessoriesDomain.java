package com.inspur.cams.drel.samu.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.samu.data.SamGeroAccessories;

/**
 * 敬老院附件信息表domain
 * @author 
 * @date 2012-10-24
 */
public interface ISamGeroAccessoriesDomain {

	/**
	 * 查询 敬老院附件信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 敬老院附件信息表
	 * @param pset
	 * @return
	 */
	public SamGeroAccessories get(String accessoriesId);

	/**
	 * 增加 敬老院附件信息表
	 * @param samGeroAccessories
	 */
	@Trans
	public void insert(SamGeroAccessories samGeroAccessories);
	
	/**
	 * 修改 敬老院附件信息表
	 * @param samGeroAccessories
	 */
	@Trans
	public void update(SamGeroAccessories samGeroAccessories);
	
	/**
	 * 删除 敬老院附件信息表
	 * @param accessoriesId
	 */
	@Trans
	public void delete(String accessoriesId);

}