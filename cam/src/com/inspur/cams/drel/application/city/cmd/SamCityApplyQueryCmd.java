package com.inspur.cams.drel.application.city.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.application.city.domain.ISamCityApplyDomain;

public class SamCityApplyQueryCmd extends BaseQueryCommand{
	// 获取SCA组件
	private ISamCityApplyDomain service = ScaComponentFactory.getService(ISamCityApplyDomain.class, "samCityApplyDomain/samCityApplyDomain");

}
