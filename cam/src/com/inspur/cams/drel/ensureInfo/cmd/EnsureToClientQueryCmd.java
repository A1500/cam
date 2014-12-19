package com.inspur.cams.drel.ensureInfo.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.ensureInfo.domain.IEnsureToClientDomain;

/**
 * 核查业务反馈表查询cmd
 * @author 
 * @date 2014-07-23
 */
public class EnsureToClientQueryCmd extends BaseQueryCommand {

	private IEnsureToClientDomain ensureToClientDomain = ScaComponentFactory
			.getService(IEnsureToClientDomain.class, "ensureToClientDomain/ensureToClientDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return ensureToClientDomain.query(pset);
	}
	
	public DataSet queryInfo(){
		ParameterSet pset = getParameterSet();
		return ensureToClientDomain.queryInfo(pset);
	}
	
	public DataSet queryMarryInfo(){
		ParameterSet pset = getParameterSet();
		return ensureToClientDomain.queryMarryInfo(pset);
	}
	
	public DataSet querySuspectInfo(){
		ParameterSet pset = getParameterSet();
		return ensureToClientDomain.querySuspectInfo(pset);
	}
	
}