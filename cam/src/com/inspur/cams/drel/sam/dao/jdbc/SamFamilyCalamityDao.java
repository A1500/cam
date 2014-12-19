package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamFamilyCalamityDao;
import com.inspur.cams.drel.sam.data.SamFamilyCalamity;

/**
 * @title:自然灾害
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
 */
public class SamFamilyCalamityDao extends EntityDao<SamFamilyCalamity>
		implements ISamFamilyCalamityDao {

	public SamFamilyCalamityDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamFamilyCalamity.class;
	}

	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  SAM_FAMILY_CALAMITY where FAMILY_ID='" + fkId
				+ "'");
	}
    //家庭信息注销时，删除自然灾害记录
	public void batchDeleteByYgjzJtxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_FAMILY_CALAMITY where FAMILY_ID='" + fkId[i]
					+ "'";
		}
		batchUpdate(sql);
	}

}
