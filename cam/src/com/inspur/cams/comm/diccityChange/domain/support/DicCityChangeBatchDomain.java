package com.inspur.cams.comm.diccityChange.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.diccityChange.dao.IDicCityChangeBatchDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeBatchDomain;

/**
 * 变更批次表domain
 * @author 
 * @date 2014-01-02
 */
public class DicCityChangeBatchDomain implements IDicCityChangeBatchDomain {

	@Reference
	private IDicCityChangeBatchDao dicCityChangeBatchDao;

	/**
	 * 查询 变更批次表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicCityChangeBatchDao.query(pset);
	}

	/**
	 * 获取 变更批次表
	 * @param pset
	 * @return
	 */
	public DicCityChangeBatch get(String batchId) {
		return dicCityChangeBatchDao.get(batchId);
	}

	/**
	 * 增加 变更批次表
	 * @param dicCityChangeBatch
	 */
	public void insert(DicCityChangeBatch dicCityChangeBatch) {
		dicCityChangeBatchDao.insert(dicCityChangeBatch);
	}
	
	/**
	 * 修改 变更批次表
	 * @param dicCityChangeBatch
	 */
	public void update(DicCityChangeBatch dicCityChangeBatch) {
		dicCityChangeBatchDao.update(dicCityChangeBatch);
	}

	
	/**
	 * 删除 变更批次表
	 * @param batchId
	 */
	public void delete(String batchId) {
		dicCityChangeBatchDao.delete(batchId);
	}

	public void batchUpdate(List list) {
		dicCityChangeBatchDao.batchUpdate(list);
		
	}

}