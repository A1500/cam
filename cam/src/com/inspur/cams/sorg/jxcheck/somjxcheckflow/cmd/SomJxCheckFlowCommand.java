package com.inspur.cams.sorg.jxcheck.somjxcheckflow.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao;
import com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao.SomJxCheckFlow;
import com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao.SomJxCheckFlowDao;

/**
 * @title:SomJxCheckFlowCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckFlowCommand extends BaseAjaxCommand{
	private SomJxCheckFlowDao dao = (SomJxCheckFlowDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao.SomJxCheckFlowDao");
	private SomJxCheckDao checkDao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckFlow dataBean=(SomJxCheckFlow)record.toBean(SomJxCheckFlow.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckFlow dataBean=(SomJxCheckFlow)record.toBean(SomJxCheckFlow.class);
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
		SomJxCheckFlow somJxCheckFlowDataBean=(SomJxCheckFlow)record.toBean(SomJxCheckFlow.class);
		SomJxCheck somJxCheckDataBean=(SomJxCheck)checkRecord.toBean(SomJxCheck.class);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = dao.query(pset);
		somJxCheckFlowDataBean.setTaskCode(taskCode);
		if(ds.getCount() == 0){
			somJxCheckFlowDataBean.setId(IdHelp.getUUID32());
			dao.insert(somJxCheckFlowDataBean);
		}else{
			somJxCheckFlowDataBean.setId((String)ds.getRecord(0).get("id"));
			dao.update(somJxCheckFlowDataBean);
		}
		somJxCheckDataBean.setStatus(status);
		checkDao.update(somJxCheckDataBean);
	}
}
