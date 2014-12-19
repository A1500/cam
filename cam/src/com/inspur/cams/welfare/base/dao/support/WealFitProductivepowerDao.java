package com.inspur.cams.welfare.base.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealFitProductivepowerDao;
import com.inspur.cams.welfare.base.data.WealFitProductivepower;

/**
 * @title:WealFitProductivepowerDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
 */
public class WealFitProductivepowerDao extends
		EntityDao<WealFitProductivepower> implements IWealFitProductivepowerDao {

	public WealFitProductivepowerDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return WealFitProductivepower.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from WealFitProductivepower");
	}

	public void deleteByTaskCode(String taskCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from Weal_Fit_Productivepower w ");
		sql.append(" where 1=1 ");
		if (StringUtils.isNotEmpty(taskCode)) {
			sql.append(" and w.TASK_CODE = '"+ taskCode +"'");
		}
		executeUpdate(sql.toString());
	}
}
