package com.inspur.sdmz.jtxx.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.sdmz.jtxx.dao.ISamFamilyAssistanceDao;
import com.inspur.sdmz.jtxx.data.SamFamilyAssistance;


/**
 * @title:SamFamilyAssistanceDao
 * @description:
 * @author:save
 * @since:2011-04-18
 * @version:1.0
 */
public class SamFamilyAssistanceDao extends EntityDao<SamFamilyAssistance>
		implements ISamFamilyAssistanceDao {

	public SamFamilyAssistanceDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamFamilyAssistance.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SamFamilyAssistance");
	}

	// 删除救助信息表中的相关家庭的记录，单条记录删除
	public void deleteByFamilyId(String familyId) {

		String sql = "delete from SAM_FAMILY_ASSISTANCE where FAMILY_ID='"
				+ familyId + "'";

		executeUpdate(sql);
	}

	// 批量注销
	public void bathchDeleteByFamilyId(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_FAMILY_ASSISTANCE where FAMILY_ID='"
					+ fkId[i] + "'";
		}
		batchUpdate(sql);
	}
}
