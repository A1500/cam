package com.inspur.cams.marry.dept.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.dept.data.Marrydept;

/**
 * @title: IMarrydeptDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
*/
 public interface IMarrydeptDao extends BaseCURD<Marrydept>{
	 //获取缓存部门信息
	 public DataSet getCacheDept(ParameterSet pset);
}

