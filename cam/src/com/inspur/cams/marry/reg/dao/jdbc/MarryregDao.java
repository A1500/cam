package com.inspur.cams.marry.reg.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.marry.reg.dao.IMarryregDao;
import com.inspur.cams.marry.reg.data.Marryreg;

/**
 * @title:MarryregDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarryregDao extends EntityDao<Marryreg> implements IMarryregDao {

	public MarryregDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return Marryreg.class;
	}

}
