package com.inspur.cams.comm.diccityChange.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;

/**
 * 数据迁移domain
 * @author 
 * @date 2013-12-23
 */
public interface IDicCityDataTransDomain {

	/**
	 * 查询 数据迁移
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	public DataSet getUnder(ParameterSet pset);

	/**
	 * 获取 数据迁移
	 * @param pset
	 * @return
	 */
	public DicCityDataTrans get(String transId);

	/**
	 * 增加 数据迁移
	 * @param dicCityDataTrans
	 */
	@Trans
	public void insert(DicCityDataTrans dicCityDataTrans);
	
	/**
	 * 修改 数据迁移
	 * @param dicCityDataTrans
	 */
	@Trans
	public void update(DicCityDataTrans dicCityDataTrans);
	
	/**
	 * 删除 数据迁移
	 * @param transId
	 */
	@Trans
	public void delete(String transId);
	
	@Trans
	public void deleteByTrans(String changeId);

	@Trans
	public void transSave(DicCityDataTrans dicCityDataTrans,String changeId,String batchId);

}