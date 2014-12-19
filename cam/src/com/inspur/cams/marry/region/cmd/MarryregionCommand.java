package com.inspur.cams.marry.region.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import com.inspur.cams.marry.region.domain.IMarryregionDomain;

/**
 * @title: MarryregionCommand
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarryregionCommand extends BaseQueryCommand {

	IMarryregionDomain marryregionDomain = ScaComponentFactory.getService(
			IMarryregionDomain.class, "MarryregionDomain/MarryregionDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = marryregionDomain.query(pset);
		return ds;
	}

	// 获取缓存行政区划信息
	public DataSet getCacheRegion() {
		ParameterSet pset = getParameterSet();
		return marryregionDomain.getCacheRegion(pset);
	}

}