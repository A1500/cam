package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.base.data.Demobilizedflow;
import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;


/**
 * @title:DemobilizedflowQueryCommand
 * @description:
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
public class DemobilizedflowQueryCommand extends BaseQueryCommand{


		/**
		 * 在乡复员人员信息服务接口
		 */
		IBptApplyDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptApplyDemobilizedDomain.class,
		"bptApplyDemobilizedDomain/bptApplyDemobilizedDomain");
		
		/**
		 *  工作流信息的服务接口
		 */
		IWfProcessBusinessDomain processBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
		"wfProcessBusinessDomain/wfProcessBusinessDomain");
		
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<Demobilizedflow> dao = (EntityDao<Demobilizedflow>) DaoFactory
				.getDao("org.baseinfopeople.dao.DemobilizedflowDao");
		return dao.query(pset);
	}
	public DataSet query2() {
		ParameterSet pset = getParameterSet();
		DataSet ds = null ;
		if(pset.containsKey("APPLY_ID")) {
			ds = demobilizedService.query(pset);
		} else {
			if(pset.containsKey("PROCESS_ID")){
				String processId = (String)pset.getParameter("PROCESS_ID");
				String applyId = processBusinessService.queryByProcessId(processId);
				pset.clear();
				pset.setParameter("APPLY_ID", applyId);
				 ds=demobilizedService.query(pset);
			
			}else{
				String assignmentId = (String)pset.getParameter("assignmentId");
				String processId = processBusinessService.getProcessId(assignmentId);
				pset.clear();
				String applyId = processBusinessService.queryByProcessId(processId);
				pset.remove("PROCESS_ID");
				pset.setParameter("APPLY_ID", applyId);
				ds = demobilizedService.query(pset);
			}
		}
		return ds;
}
	public DataSet query3() {
		ParameterSet pset = getParameterSet();
		DataSet ds = null ;
			ds = demobilizedService.query(pset);
		return ds;
}
	public DataSet queryDemobilized(){
		
		ParameterSet pset = getParameterSet();
		
		return demobilizedService.queryDemobilized(pset);
		
	}
}
