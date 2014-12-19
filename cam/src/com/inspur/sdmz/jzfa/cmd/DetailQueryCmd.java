package com.inspur.sdmz.jzfa.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.jzfa.dao.jdbc.DetailDao;
import com.inspur.sdmz.jzfa.dao.jdbc.PlanDao;
import com.inspur.sdmz.jzfa.domain.IPlanDomain;

/**
 * 救助方案明细查询Cmd
 * @author shgtch
 * @date 2011-4-18
 */
public class DetailQueryCmd extends BaseQueryCommand {
	
	IPlanDomain planDomain = ScaComponentFactory.getService(IPlanDomain.class, "HelpDomain/HelpService");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = planDomain.jzfamxQuery(pset);
		return ds;
	}
	public DataSet sjtjmx(){
		//ParameterSet pset = getParameterSet();
		//String jzfaid=(String)pset.getParameter("PLAN_ID");
		//DataSet ds=planDomain.sjtjmx(jzfaid);
		//return ds;
		
		DetailDao dao= (DetailDao) DaoFactory.getDao(DetailDao.class);
		ParameterSet pset = getParameterSet();
		String jzfaid=(String)pset.getParameter("PLAN_ID");
		DataSet ds=dao.sjtjmx(getParameterSet(),jzfaid);
		return ds;
	}
	
	public DataSet queryOtherAssisted(){
		ParameterSet pset = getParameterSet();
		return planDomain.queryOtherAssisted(pset);
	}
}
