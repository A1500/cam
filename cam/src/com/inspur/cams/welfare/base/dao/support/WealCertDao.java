package com.inspur.cams.welfare.base.dao.support;


import org.loushang.next.dao.EntityDao;

import com.inspur.cams.welfare.base.dao.IWealCertDao;
import com.inspur.cams.welfare.base.data.WealCert;



/**
 * WealComfortNoDao
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public class WealCertDao extends EntityDao<WealCert> implements IWealCertDao{

	@Override
	protected Class<WealCert> getEntityClass() {
		return WealCert.class;
	}
}
