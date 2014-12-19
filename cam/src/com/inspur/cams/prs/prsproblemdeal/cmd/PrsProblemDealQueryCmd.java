package com.inspur.cams.prs.prsproblemdeal.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.prs.prsproblemdeal.domain.IPrsProblemDealDomain;

/**
 * @title:PrsProblemDealQueryCmd
 * @description:问题处理信息管理
 * @author:jiangzhaobao
 * @since:2011年8月26日16:32:52
 * @version:1.0
*/
public class PrsProblemDealQueryCmd extends BaseQueryCommand{

	IPrsProblemDealDomain service = ScaComponentFactory.getService(IPrsProblemDealDomain.class,"PrsProblemDealDomain/PrsProblemDealDomain");
	
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		String problemId=(String)pset.getParameter("PROBLEM_ID"); 
		return service.querySql(problemId);
	}
	
	public DataSet queryBySql(){
		ParameterSet pset=getParameterSet();
		return service.queryBySql(pset);
	}
}
