package com.inspur.cams.marry.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title: IMarrydicDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public interface IMarrydicDomain {
	public DataSet query(ParameterSet pset);
	
	//获取字典缓存信息
	public DataSet getCacheDic(ParameterSet ps);
}