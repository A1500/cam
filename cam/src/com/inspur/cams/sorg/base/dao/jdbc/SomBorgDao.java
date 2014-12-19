package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomBorgDao;
import com.inspur.cams.sorg.base.data.SomBorg;

/**
 * 业务主管单位dao
 * @author yanliangliang
 * @date 2011-6-8
 */
public class SomBorgDao extends EntityDao<SomBorg> implements ISomBorgDao {

	@Override
	protected Class<SomBorg> getEntityClass() {
		return SomBorg.class;
	}

}
