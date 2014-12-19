package com.inspur.cams.drel.application.cityLow.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.application.cityLow.dao.ISamLowApplyInfoDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowApplyInfo;

/**
 * 低收入家庭认定业务表dao
 * @author 
 * @date 2014-03-11
 */
public class SamLowApplyInfoDao extends EntityDao<SamLowApplyInfo> implements ISamLowApplyInfoDao {
	
	@Override
	public Class<SamLowApplyInfo> getEntityClass() {
		return SamLowApplyInfo.class;
	}

}