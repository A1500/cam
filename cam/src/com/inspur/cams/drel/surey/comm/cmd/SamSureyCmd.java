package com.inspur.cams.drel.surey.comm.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.surey.comm.domain.ISamSureyDomain;

public class SamSureyCmd extends BaseAjaxCommand{
	// 获取SCA组件
	private ISamSureyDomain service = ScaComponentFactory.getService(ISamSureyDomain.class,"SamSureyDomain/SamSureyDomain");
	
}
