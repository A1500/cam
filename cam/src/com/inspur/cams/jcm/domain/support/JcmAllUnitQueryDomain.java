package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmAllUnitQueryDao;
import com.inspur.cams.jcm.domain.IJcmAllUnitQueryDomain;
/**
 * 人员照片表domain
 * @author 陈寿业
 * @date 2014-05-16
 */
public class JcmAllUnitQueryDomain implements IJcmAllUnitQueryDomain {

	private IJcmAllUnitQueryDao iJcmAllUnitQueryDao=ScaComponentFactory
	.getService(IJcmAllUnitQueryDao.class, "iJcmAllUnitQueryDao/iJcmAllUnitQueryDao");
	
	public DataSet queryCompany(ParameterSet pset){
		return iJcmAllUnitQueryDao.queryAllUnit(pset);
	}
	

}
