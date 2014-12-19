/**
 * 
 */
package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.domain.IJcmAllPeopleQueryDomain;

/**
 * @author xinming
 * @date 2014-12-15
 */
public class JcmAllPeopleQueryDomain implements IJcmAllPeopleQueryDomain {
	@Reference
	private IJcmAllPeopleQueryDomain jcmAllPeopleQueryDao;

	/**
	 * 查询所有人员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmAllPeopleQueryDao.query(pset);
	}

}
