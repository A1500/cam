package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisServicesDutyInfoDao;
import com.inspur.cams.fis.base.data.FisServicesDutyInfo;

/**
 * 殡葬服务机构人员岗位信息表dao
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesDutyInfoDao extends EntityDao<FisServicesDutyInfo> implements IFisServicesDutyInfoDao {
	
	@Override
	public Class<FisServicesDutyInfo> getEntityClass() {
		return FisServicesDutyInfo.class;
	}

}