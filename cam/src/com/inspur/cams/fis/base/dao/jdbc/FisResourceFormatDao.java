package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.fis.base.dao.IFisResourceFormatDao;
import com.inspur.cams.fis.base.data.FisResourceFormat;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisResourceFormatDao
 * @Description: TODO 殡葬业务资源规格表dao实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceFormatDao extends EntityDao<FisResourceFormat> implements IFisResourceFormatDao {

	public FisResourceFormatDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisResourceFormat.class;
	}

}
