package com.inspur.cams.fis.base.domain.support;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import cmd.GetBspInfo;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.base.dao.IFisCremationRateDao;
import com.inspur.cams.fis.base.data.FisCremationRate;
import com.inspur.cams.fis.base.domain.IFisCremationRateDomain;

/**
 * 火化率计算表domain
 * @author 
 * @date Thu Apr 19 18:46:28 GMT+08:00 2012
 */
public class FisCremationRateDomain implements IFisCremationRateDomain {

	@Reference
	private IFisCremationRateDao fisCremationRateDao;

	/**
	 * 查询 火化率计算表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return fisCremationRateDao.query(pset);
	}

	/**
	 * 获取 火化率计算表
	 * @param pset
	 * @return
	 */
	public FisCremationRate get(String recordId) {
		return fisCremationRateDao.get(recordId);
	}

	/**
	 * 增加 火化率计算表
	 * @param fisCremationRate
	 */
	public void insert(FisCremationRate fisCremationRate) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("AREA_CODE", fisCremationRate.getAreaCode());
		pset.setParameter("SUM_YEAR", fisCremationRate.getSumYear());
		DataSet ds = fisCremationRateDao.query(pset);
		if(ds.getCount() <= 0) {
			fisCremationRate.setRecordId(IdHelp.getUUID32());
			fisCremationRateDao.insert(fisCremationRate);
		}else {
			fisCremationRate.setRecordId((String)ds.getRecord(0).get("recordId"));
			fisCremationRateDao.update(fisCremationRate);
		}
	}
	
	/**
	 * 修改 火化率计算表
	 * @param fisCremationRate
	 */
	public void update(FisCremationRate fisCremationRate) {
		fisCremationRateDao.update(fisCremationRate);
	}
	
	/**
	 * 删除 火化率计算表
	 * @param recordId
	 */
	public void delete(String recordId) {
		fisCremationRateDao.delete(recordId);
	}

	/**
	 * 获取本地区火化人数
	 * @param 
	 */
	public DataSet queryCremationSum(ParameterSet pset) {
		return fisCremationRateDao.queryCremationSum(pset);
	}

	public DataSet queryCremationRateList(ParameterSet pset) {
		return fisCremationRateDao.queryCremationRateList(pset);
	}

	public List<Map> queryTest() {
		return fisCremationRateDao.queryTest();
	}

}