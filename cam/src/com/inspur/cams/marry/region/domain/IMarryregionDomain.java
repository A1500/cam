package com.inspur.cams.marry.region.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title: IMarryregionDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public interface IMarryregionDomain {
	public DataSet query(ParameterSet pset);
	
	//获取缓存行政区划信息
	public DataSet getCacheRegion(ParameterSet pset);
}