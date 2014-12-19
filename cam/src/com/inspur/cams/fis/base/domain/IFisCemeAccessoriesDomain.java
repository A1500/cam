package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeAccessories;

/**
 * 公墓审批附件表domain
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeAccessoriesDomain {

	/**
	 * 查询 公墓审批附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公墓审批附件表
	 * @param pset
	 * @return
	 */
	public FisCemeAccessories get(String accessoriesId);

	/**
	 * 增加 公墓审批附件表
	 * @param fisCemeAccessories
	 */
	@Trans
	public void insert(FisCemeAccessories fisCemeAccessories);
	
	/**
	 * 修改 公墓审批附件表
	 * @param fisCemeAccessories
	 */
	@Trans
	public void update(FisCemeAccessories fisCemeAccessories);
	
	/**
	 * 删除 公墓审批附件表
	 * @param accessoriesId
	 */
	@Trans
	public void delete(String accessoriesId);
	@Trans
	public void deleteAll(ParameterSet pset);

}