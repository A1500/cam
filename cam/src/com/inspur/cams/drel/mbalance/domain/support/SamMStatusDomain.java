package com.inspur.cams.drel.mbalance.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.mbalance.dao.ISamMStatusDao;
import com.inspur.cams.drel.mbalance.domain.ISamMStatusDomain;
/**
 * 
 * @author luguosui
 * 救助状态domain实现
 */

public class SamMStatusDomain implements ISamMStatusDomain {
	@Reference
	private  ISamMStatusDao samMStatusDao;
	/**
	 * 查询救助状态方法
	 */
	public DataSet query(ParameterSet pset) {
		
		return samMStatusDao.query(pset);
	}

}
