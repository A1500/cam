package com.inspur.cams.marry.region.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.marry.region.data.Marryregion;

/**
 * @title: IMarryregionDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
*/
 public interface IMarryregionDao extends BaseCURD<Marryregion>{
	 //获取缓存行政区划信息
	 public DataSet getCacheRegion(ParameterSet pset);
}

