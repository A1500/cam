package com.inspur.cams.comm.diccityChange.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.diccityChange.data.DicCityChange;
import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;

/**
 * 行政区划变更domain
 * @author 
 * @date 2013-12-23
 */
public interface IDicCityChangeDomain {

	/**
	 * 查询 行政区划变更
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 查询 序号
	 * @param pset
	 * @return
	 */
	@Trans
	public String getNumber(String batchId);

	/**
	 * 获取 行政区划变更
	 * @param pset
	 * @return
	 */
	public DicCityChange get(String changeId);

	/**
	 * 增加 行政区划变更
	 * @param dicCityChange
	 */
	@Trans
	public void insert(DicCityChange dicCityChange);
	
	@Trans
	public void insertD(DicCityChange dicCityChange);
	
	/**
	 * 修改 行政区划变更
	 * @param dicCityChange
	 */
	@Trans
	public void update(DicCityChange dicCityChange);
	
	@Trans
	public void updateD(DicCityChange dicCityChange);
	
	@Trans
	public void submit(DicCityChange dicCityChange);
	
	@Trans
	public void check(DicCityChange dicCityChange);
	
	/**
	 * 删除 行政区划变更
	 * @param changeId
	 */
	@Trans
	public void delete(String changeId);
	
	@Trans
	public DataSet queryTrans(ParameterSet pset);
	
}