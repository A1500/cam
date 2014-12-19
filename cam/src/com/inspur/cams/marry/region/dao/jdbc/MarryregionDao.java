package com.inspur.cams.marry.region.dao.jdbc;

import java.util.HashMap;
import java.util.Map;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.marry.region.dao.IMarryregionDao;
import com.inspur.cams.marry.region.data.Marryregion;

/**
 * @title: MarryregionDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarryregionDao extends EntityDao<Marryregion> implements IMarryregionDao {

	private Map CacheRegion = new HashMap();

	public MarryregionDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return Marryregion.class;
	}

	/**
	 * 获取缓存行政区划信息
	 * 
	 * @param
	 * @return
	 */
	public DataSet getCacheRegion(ParameterSet pset) {
		String pid = (String) pset.get("PID@=");
		DataSet ds = null;
		if (pid != null)
			ds = (DataSet) CacheRegion.get(pid);

		if (ds == null) {
			ds = query(pset);
			CacheRegion.put(pid, ds);

//			System.out.println("marry_无此缓存，从数据库中获取行政区划:" + pid);
		} 
//		else {
//			System.out.println("marry_缓存生效，从缓存中获取行政区划:" + pid);
//		}
		return ds;
	}
}
