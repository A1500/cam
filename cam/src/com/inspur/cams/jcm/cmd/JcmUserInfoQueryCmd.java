package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmUserInfoDomain;

/**
 * 用户表查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmUserInfoQueryCmd extends BaseQueryCommand {

	private IJcmUserInfoDomain jcmUserInfoDomain = ScaComponentFactory
			.getService(IJcmUserInfoDomain.class, "jcmUserInfoDomain/jcmUserInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmUserInfoDomain.query(pset);
	}
	
}