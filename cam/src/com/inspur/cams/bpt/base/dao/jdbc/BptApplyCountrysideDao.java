package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.bpt.base.dao.IBptApplyCountrysideDao;
import com.inspur.cams.bpt.base.data.BptApplyCountryside;

/**
 * @title:BptApplyCountrysideDao
 * @description:在乡复员军人【带病回乡退伍军人】审批
 * @author:
 * @since:2011-06-16
 * @version:1.0
*/
 public class BptApplyCountrysideDao extends EntityDao<BptApplyCountryside> implements IBptApplyCountrysideDao{

 	public BptApplyCountrysideDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyCountryside> getEntityClass() {
		return BptApplyCountryside.class;
	}
}
