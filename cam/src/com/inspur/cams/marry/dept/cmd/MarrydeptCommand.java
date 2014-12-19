package com.inspur.cams.marry.dept.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import com.inspur.cams.marry.dept.domain.IMarrydeptDomain;

/**
 * @title: MarrydeptCommand
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrydeptCommand extends BaseQueryCommand {

	IMarrydeptDomain marrydeptDomain = ScaComponentFactory.getService(
			IMarrydeptDomain.class, "MarrydeptDomain/MarrydeptDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = marrydeptDomain.query(pset);
		return ds;
	}
	
	//获取缓存部门信息
	public DataSet getCacheDept() {
		ParameterSet pset = getParameterSet();
		return marrydeptDomain.getCacheDept(pset);
	}

}