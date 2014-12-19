package com.inspur.cams.fis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisCremationInfoSumDao;
import com.inspur.cams.fis.base.domain.IFisCremationInfoSumDomain;

public class FisCremationInfoSumDomain implements IFisCremationInfoSumDomain{
	@Reference
	private  IFisCremationInfoSumDao fisCremationInfoSumDao ;

	public void setFisCremationInfoSumDao(
			IFisCremationInfoSumDao fisCremationInfoSumDao) {
		this.fisCremationInfoSumDao = fisCremationInfoSumDao;
	}
	
	public DataSet query(ParameterSet pset) {
		return fisCremationInfoSumDao.query(pset);
	}
	
	public DataSet queyDeadInfo(ParameterSet pset) {
		DataSet ds= fisCremationInfoSumDao.queyDeadInfo(pset);
		return ds;
	}
	
	/**
	 * @Description: 查询统计信息
	 * @author xuexzh
	 */
	public DataSet queyAllSum(ParameterSet pset) {
		DataSet ds= fisCremationInfoSumDao.queyAllSum(pset);
		return ds;
	}
	

}
