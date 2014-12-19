package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmDicDomain;

/**
 * 字典管理查询cmd
 * @author 
 * @date 2014-12-15
 */
public class JcmDicQueryCmd extends BaseQueryCommand {

	private IJcmDicDomain jcmDicDomain = ScaComponentFactory
			.getService(IJcmDicDomain.class, "jcmDicDomain/jcmDicDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmDicDomain.query(pset);
	}
	
}