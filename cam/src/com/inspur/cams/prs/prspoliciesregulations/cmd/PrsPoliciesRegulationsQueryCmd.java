package com.inspur.cams.prs.prspoliciesregulations.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.prs.prspoliciesregulations.domain.IPrsPoliciesRegulationsDomain;
/**
 * @title:IPrsPoliciesRegulationsDomain
 * @description:政策法规信息查询cmd
 * @author:jiangzhaobao
 * @since:2011年8月26日20:44:46
 * @version:1.0
*/
public class PrsPoliciesRegulationsQueryCmd extends BaseQueryCommand{
	IPrsPoliciesRegulationsDomain service=ScaComponentFactory.getService(IPrsPoliciesRegulationsDomain.class,"PrsPoliciesRegulationsDomain/PrsPoliciesRegulationsDomain");
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return service.query(pset);
	}
	
}
