package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.fis.base.dao.IFisEquipmentRepairDao;
import com.inspur.cams.fis.base.data.FisEquipmentRepair;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisEquipmentRepairDao
 * @Description: TODO 殡葬业务维修记录表dao实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisEquipmentRepairDao extends EntityDao<FisEquipmentRepair> implements IFisEquipmentRepairDao {

	public FisEquipmentRepairDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisEquipmentRepair.class;
	}

}
