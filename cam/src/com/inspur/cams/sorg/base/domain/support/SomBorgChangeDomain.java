package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.sorg.base.dao.ISomBorgChangeDao;
import com.inspur.cams.sorg.base.data.SomBorgChange;
import com.inspur.cams.sorg.base.domain.ISomBorgChangeDomain;

/**
 * 业务主管单位变更domain
 */
public class SomBorgChangeDomain implements ISomBorgChangeDomain {
	
	@Reference
	private ISomBorgChangeDao somBorgChangeDao;

	public DataSet query(ParameterSet pset) {
		return somBorgChangeDao.query(pset);
	}
	/**
	 * 查询数量
	 * @param pset
	 * @return
	 */
	public int queryCount(ParameterSet pset) {
		return somBorgChangeDao.queryCount(pset);
	}

	/**
	 * 查询变更数量
	 * @param pset
	 * @return
	 */
	public DataSet queryBeforeCount(ParameterSet pset) {
		return somBorgChangeDao.query(pset);
	}
	
	/**
	 * 业务主管单位变更历史
	 */
	public DataSet showChange(ParameterSet pset){
		return RecordToBeanUtil.uppercaseToLowercase(somBorgChangeDao.showChange(pset));
	}
	
	/**
	 * 当前业务主管单位名称
	 * @param pset
	 * @return
	 */
	public String nowBorgName(ParameterSet pset){
		return somBorgChangeDao.nowBorgName(pset);
	}
	
	public void insert(SomBorgChange somBorgChange) {
		somBorgChangeDao.insert(somBorgChange);
	}
}
