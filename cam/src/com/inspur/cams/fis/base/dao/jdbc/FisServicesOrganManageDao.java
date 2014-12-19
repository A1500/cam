package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisServicesOrganManageDao;
import com.inspur.cams.fis.base.data.FisServicesOrganManage;

/**
 * 殡葬服务机构信息表dao
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesOrganManageDao extends EntityDao<FisServicesOrganManage> implements IFisServicesOrganManageDao {
	
	@Override
	public Class<FisServicesOrganManage> getEntityClass() {
		return FisServicesOrganManage.class;
	}

}