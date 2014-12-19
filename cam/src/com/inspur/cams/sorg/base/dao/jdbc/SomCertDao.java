package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import com.inspur.cams.sorg.base.dao.ISomCertDao;
import com.inspur.cams.sorg.base.data.SomCert;

/**
 * 社会组织证书dao接口
 * @author yanliangliang
 * @date 2011-5-11
 */
public class SomCertDao extends EntityDao<SomCert> implements ISomCertDao {

	@Override
	protected Class<SomCert> getEntityClass() {
		return SomCert.class;
	}

}
