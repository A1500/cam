package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmPoliciesRegulationsDao;
import com.inspur.cams.jcm.data.JcmPoliciesRegulations;

/**
 * 政策法规表dao
 * @author 
 * @date 2014-05-16
 */
public class JcmPoliciesRegulationsDao extends EntityDao<JcmPoliciesRegulations> implements IJcmPoliciesRegulationsDao {
	
	@Override
	public Class<JcmPoliciesRegulations> getEntityClass() {
		return JcmPoliciesRegulations.class;
	}

}