package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisResourceRuleDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceRuleQueryCmd  
 * @Description: TODO 殡葬业务资源级别规则定义QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceRuleQueryCmd extends BaseQueryCommand{
	
	IFisResourceRuleDomain service = ScaComponentFactory.getService(IFisResourceRuleDomain.class,
	"FisResourceRuleDomain/FisResourceRuleDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		DataSet ds=service.queryRuleList(pset);
		ds.getMetaData().setIdProperty("ruleId");
		return ds;
	}
}