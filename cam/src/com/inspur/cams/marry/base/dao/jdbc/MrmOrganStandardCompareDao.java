package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.marry.base.dao.IMrmOrganStandardCompareDao;
import com.inspur.cams.marry.base.data.MrmOrganStandardCompare;

/**
 * @title:等级评定标准对照dao
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardCompareDao extends EntityDao<MrmOrganStandardCompare> implements
		IMrmOrganStandardCompareDao {
	public Class<MrmOrganStandardCompare> getEntityClass() {
		return MrmOrganStandardCompare.class;
	}


}
