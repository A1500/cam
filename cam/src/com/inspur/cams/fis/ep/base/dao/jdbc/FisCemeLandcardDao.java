package com.inspur.cams.fis.ep.base.dao.jdbc;

import java.util.ArrayList;
import java.util.List;
import java.sql.Types;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.ep.base.dao.IFisCemeDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeLandcardDao;
import com.inspur.cams.fis.ep.base.data.FisCeme;
import com.inspur.cams.fis.ep.base.data.FisCemeLandcard;

/**
 * @title: FisCemeLandcardDao
 * @description:公墓政府部门批准dao
 * @author:lidongdong（xxz）
 * @since:2011-11-11
 * @version:1.0
 */
public class FisCemeLandcardDao extends EntityDao<FisCemeLandcard> implements
		IFisCemeLandcardDao {

	public FisCemeLandcardDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCemeLandcard.class;
	}
}
