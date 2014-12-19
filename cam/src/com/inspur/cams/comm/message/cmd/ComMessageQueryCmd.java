package com.inspur.cams.comm.message.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.message.domain.IComMessageDomain;


/**
 * 首页消息框查询cmd
 * @author 
 * @date 2014-02-14
 */
public class ComMessageQueryCmd extends BaseQueryCommand {

	private IComMessageDomain comMessageDomain = ScaComponentFactory
			.getService(IComMessageDomain.class, "comMessageDomain/comMessageDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return comMessageDomain.query(pset);
	}
	
}