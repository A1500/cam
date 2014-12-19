package com.inspur.cams.comm.menuconfig.dao;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;

/**
 * @title:PubMenuConfigDao
 * @description:
 * @author:
 * @since:2011-08-09
 * @version:1.0
 */
public class PubMenuConfigDao extends EntityDao<PubMenuConfig> implements
		IPubMenuConfigDao {

	public PubMenuConfigDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return PubMenuConfig.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from PubMenuConfig");
	}

	public String getMenuTypeById(String id) {
		String sql = "SELECT MENU_TYPE_ID,MENU_TYPE_NAME FROM PUB_MENU_TYPE WHERE MENU_TYPE_ID = ?";
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { id };
		DataSet ds = executeDataset(sql.toString(), types, args, true);
		Record record = (Record) ds.getRecord(0);
		String menuTypeName = (String) record.get("MENU_TYPE_NAME");
		return menuTypeName;
	}

	public int exeUpdate(String sql) {
		return this.executeUpdate(sql);
	}
	
	public int exeUpdate(String sql, int[] types, Object[] args) {
		return this.executeUpdate(sql, types, args);
	}
}
