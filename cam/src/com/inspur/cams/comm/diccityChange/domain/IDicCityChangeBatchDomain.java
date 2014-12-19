package com.inspur.cams.comm.diccityChange.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch;

/**
 * 变更批次表domain
 * @author 
 * @date 2014-01-02
 */
public interface IDicCityChangeBatchDomain {

	/**
	 * 查询 变更批次表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 变更批次表
	 * @param pset
	 * @return
	 */
	public DicCityChangeBatch get(String batchId);

	/**
	 * 增加 变更批次表
	 * @param dicCityChangeBatch
	 */
	@Trans
	public void insert(DicCityChangeBatch dicCityChangeBatch);
	
	/**
	 * 修改 变更批次表
	 * @param dicCityChangeBatch
	 */
	@Trans
	public void update(DicCityChangeBatch dicCityChangeBatch);
	
	/**
	 * 删除 变更批次表
	 * @param batchId
	 */
	@Trans
	public void delete(String batchId);
	
	/**
	 * 批次中上传附件
	 * 
	 * @param changeId
	 */
	@Trans
	public void batchUpdate(List list);

}