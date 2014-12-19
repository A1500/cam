package com.inspur.cams.fis.ep.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.fis.ep.base.dao.IFisCemeGovApprovalDao;
import com.inspur.cams.fis.ep.base.data.FisCemeGovApproval;

/**
 * @title: FisCemeGovApprovalDao
 * @description:公墓土地证dao
 * @author:lidongdong（xxz）
 * @since:2011-11-11
 * @version:1.0
 */
public class FisCemeGovApprovalDao extends EntityDao<FisCemeGovApproval>
		implements IFisCemeGovApprovalDao {

	public FisCemeGovApprovalDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCemeGovApproval.class;
	}
}
