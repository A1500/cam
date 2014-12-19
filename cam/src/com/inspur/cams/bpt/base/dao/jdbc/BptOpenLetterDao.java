package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptOpenLetterDao;
import com.inspur.cams.bpt.base.data.BptOpenLetter;

public class BptOpenLetterDao extends EntityDao<BptOpenLetter> implements IBptOpenLetterDao {
	public BptOpenLetterDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}
	@Override
	protected Class<BptOpenLetter> getEntityClass() {
		return BptOpenLetter.class;
	}

}
