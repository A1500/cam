package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.workflow.util.ParticipantUtil;
import org.loushang.workflow.util.bsp.BspUtil;

import com.inspur.cams.bpt.base.data.WfProcessBusiness;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;

/**
 * @title:WfProcessBusinessQueryCommand
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
 */
public class WfProcessBusinessQueryCommand extends BaseQueryCommand {

	private IWfProcessBusinessDomain wfprocessBusniessDomain = ScaComponentFactory
			.getService(IWfProcessBusinessDomain.class, "wfProcessBusinessDomain/wfProcessBusinessDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WfProcessBusiness> dao = (EntityDao<WfProcessBusiness>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.WfProcessBusinessDao");
		return dao.query(pset);
	}

	/**
	 * 查询流程待办任务列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDaiBan() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("organ_ids", ParticipantUtil.getParentAndSelfOrganIdArray());
		return wfprocessBusniessDomain.queryDaiBan(pset);
	}
	
	/**
	 * 查询流程已办任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryYiBan() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("organ_id", BspUtil.getInstance().getLoginUserOrganId());
		return wfprocessBusniessDomain.queryYiBan(pset);
	}
	
	/**
	 * 查询结束任务列表
	 * @param pset
	 * @return
	 */
	public DataSet queryEndTask() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("organ_id", BspUtil.getInstance().getLoginUserOrganId());
		return wfprocessBusniessDomain.queryEndTask(pset);
	}
	
	/**
	 * 流程监控（查询某人流程状态）
	 * @param pset
	 * @return
	 */
	public DataSet queryMonitor() {
		ParameterSet pset = getParameterSet();
		return wfprocessBusniessDomain.queryMonitor(pset);
	}
	
	/**
	 * 根据身份证号和业务类型查询流程状态
	 * 用于外网
	 * @param pset
	 * @return
	 */
	public DataSet queryWorkState(){
		ParameterSet pset = getParameterSet();
		return wfprocessBusniessDomain.queryWorkState(pset);
	}
}
