package com.inspur.cams.welfare.base.dao.support;


import org.loushang.next.dao.EntityDao;

import com.inspur.cams.welfare.base.dao.IWealElectronicfileCatalogDao;
import com.inspur.cams.welfare.base.data.WealElectronicfileCatalog;



/**
 * WealElectronicfileCatalogDao
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public class WealElectronicfileCatalogDao extends EntityDao<WealElectronicfileCatalog> implements IWealElectronicfileCatalogDao{

	@Override
	protected Class<WealElectronicfileCatalog> getEntityClass() {
		return WealElectronicfileCatalog.class;
	}
}
