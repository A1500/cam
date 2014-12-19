package com.inspur.cams.sorg.check.somcheckflow.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao;
import com.inspur.cams.sorg.check.somcheck.data.SomCheck;
import com.inspur.cams.sorg.check.somcheckflow.dao.SomCheckFlowDao;
import com.inspur.cams.sorg.check.somcheckflow.data.SomCheckFlow;

/**
 * @title:SomCheckFlowCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckFlowCommand extends BaseAjaxCommand{
	private SomCheckFlowDao dao = (SomCheckFlowDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckflow.dao.SomCheckFlowDao");
	private SomCheckDao checkDao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckFlow dataBean=(SomCheckFlow)record.toBean(SomCheckFlow.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckFlow dataBean=(SomCheckFlow)record.toBean(SomCheckFlow.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	
	@Trans
	public void save() {
		// get the Record Array from UI
		Record record = (Record) getParameter("record");
		Record checkRecord = (Record) getParameter("somCheckRecord");
		String taskCode = (String) getParameter("taskCode");
		String status = (String) getParameter("status");
		SomCheckFlow somCheckFlowDataBean=(SomCheckFlow)record.toBean(SomCheckFlow.class);
		SomCheck somCheckDataBean=(SomCheck)checkRecord.toBean(SomCheck.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = dao.query(pset);
		somCheckFlowDataBean.setTaskCode(taskCode);
		if(ds.getCount() == 0){
			somCheckFlowDataBean.setId(IdHelp.getUUID32());
			dao.insert(somCheckFlowDataBean);
		}else{
			somCheckFlowDataBean.setId((String)ds.getRecord(0).get("id"));
			dao.update(somCheckFlowDataBean);
		}
		if(status.equals("7")){
			somCheckDataBean.setCheckTime(DateUtil.getTime());
		}
		somCheckDataBean.setStatus(status);
		checkDao.update(somCheckDataBean);
	}
}
