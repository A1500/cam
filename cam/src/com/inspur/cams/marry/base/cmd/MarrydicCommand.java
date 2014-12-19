package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import com.inspur.cams.marry.base.domain.IMarrydicDomain;

/**
 * @title:MarrydicCommand
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrydicCommand extends BaseQueryCommand {

	IMarrydicDomain marrydicDomain = ScaComponentFactory.getService(
			IMarrydicDomain.class, "MarrydicDomain/MarrydicDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return marrydicDomain.query(pset);
	}
	
	//获取字典缓存信息
	public DataSet getCacheDic() {
		ParameterSet pset = getParameterSet();
		return marrydicDomain.getCacheDic(pset);
	}

}