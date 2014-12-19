package com.inspur.cams.comm.diccityChange.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatchAttach;

/**
 * 区划变更上传附件表domain
 * @author 
 * @date 2014-01-13
 */
public interface IDicCityChangeBatchAttachDomain {

	/**
	 * 查询 区划变更上传附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 区划变更上传附件表
	 * @param pset
	 * @return
	 */
	public DicCityChangeBatchAttach get();

	/**
	 * 增加 区划变更上传附件表
	 * @param dicCityChangeBatchAttach
	 */
	@Trans
	public void insert(DicCityChangeBatchAttach dicCityChangeBatchAttach);
	
	/**
	 * 修改 区划变更上传附件表
	 * @param dicCityChangeBatchAttach
	 */
	@Trans
	public void update(DicCityChangeBatchAttach dicCityChangeBatchAttach);
	
	/**
	 * 删除 区划变更上传附件表
	 * @param 
	 */
	@Trans
	public void delete(String delId);
	
	
	/**
	 * 批量新增
	 * @param 
	 */
	@Trans
	public void saveAll(List list);

}