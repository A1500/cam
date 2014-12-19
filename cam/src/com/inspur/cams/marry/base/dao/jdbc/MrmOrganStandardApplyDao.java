package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.marry.base.dao.IMrmOrganStandardApplyDao;
import com.inspur.cams.marry.base.data.MrmOrganStandardApply;

/**
 * 婚姻登记机关等级评定标准业务表dao
 * @author 
 * @date 2012-11-28
 */
public class MrmOrganStandardApplyDao extends EntityDao<MrmOrganStandardApply> implements IMrmOrganStandardApplyDao {
	
	@Override
	public Class<MrmOrganStandardApply> getEntityClass() {
		return MrmOrganStandardApply.class;
	}

}