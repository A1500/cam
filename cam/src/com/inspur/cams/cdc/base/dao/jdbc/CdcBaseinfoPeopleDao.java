package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcBaseinfoPeopleDao;
import com.inspur.cams.cdc.base.data.CdcBaseinfoPeople;

/**
 * 人员基础信息dao
 * @author 
 * @date 2012-05-25
 */
public class CdcBaseinfoPeopleDao extends EntityDao<CdcBaseinfoPeople> implements ICdcBaseinfoPeopleDao {
	
	@Override
	public Class<CdcBaseinfoPeople> getEntityClass() {
		return CdcBaseinfoPeople.class;
	}

	/**
	 * 删除家庭所有成员
	 */
	public void deleteFamily(String peopleId) {
		this.executeUpdate("DELETE FROM CDC_BASEINFO_PEOPLE WHERE FAMILY_ID = ? ", new int[]{Types.VARCHAR}, new Object[]{peopleId});
	}

}