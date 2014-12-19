package com.inspur.cams.fis.base.domain;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCremationRate;

/**
 * 火化率计算表domain
 * @author 
 * @date Thu Apr 19 18:46:28 GMT+08:00 2012
 */
public interface IFisCremationRateDomain {

	/**
	 * 查询 火化率计算表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 火化率计算表
	 * @param pset
	 * @return
	 */
	public FisCremationRate get(String recordId);

	/**
	 * 增加 火化率计算表
	 * @param fisCremationRate
	 */
	@Trans
	public void insert(FisCremationRate fisCremationRate);
	
	/**
	 * 修改 火化率计算表
	 * @param fisCremationRate
	 */
	@Trans
	public void update(FisCremationRate fisCremationRate);
	
	/**
	 * 删除 火化率计算表
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);

	/**
	 * 获取本地区火化人数
	 * @param 
	 */
	@Trans
	public DataSet queryCremationSum(ParameterSet pset);

	/**
	 * 获取本地区火化率计算结果报表
	 * @param 
	 */
	@Trans
	public DataSet queryCremationRateList(ParameterSet pset);

	public List<Map> queryTest();
}