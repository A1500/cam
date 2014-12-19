package com.inspur.cams.marry.dept.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title: IMarrydeptDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public interface IMarrydeptDomain {
	public DataSet query(ParameterSet pset);
	
	//获取缓存部门信息
	public DataSet getCacheDept(ParameterSet pset);
}