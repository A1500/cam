package com.inspur.cams.sorg.jxcheck.manage;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao;

/**
 * @title:SomCheckCommand
 * @description:
 * @author:
 * @since:2011-12-21
 * @version:1.0
*/
public class SomJxCheckManageCommand extends BaseAjaxCommand{
	private SomJxCheckDao dao = (SomJxCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheckDao");
	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheck dataBean=(SomJxCheck)record.toBean(SomJxCheck.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheck dataBean=(SomJxCheck)record.toBean(SomJxCheck.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	
	public void updateStatus(){
		String taskCode=(String) getParameter("taskCode");
		String status=(String) getParameter("status");
		String correctNotReason=(String) getParameter("correctNotReason");
		dao.updateStatus(taskCode,status,correctNotReason);
	}
	@Trans
	public void submit(){
		String taskCode=(String) getParameter("taskCode");
		String status=(String) getParameter("status");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0){
			SomJxCheck dataBean =  (SomJxCheck)ds.getRecord(0).toBean(SomJxCheck.class);
			dataBean.setCommitTime(DateUtil.getTime());
			dataBean.setStatus(status);
			dao.update(dataBean);
		}
	}
	/**
	 * 查询年检数据是否各个页面全部填写，以控制上报
	 */
	public void queryForReport(){
		String sorgType=(String) getParameter("sorgType");
		String taskCode=(String) getParameter("taskCode");
		String flag="false";
		flag=dao.queryForReport(taskCode,sorgType);
		setReturn("flag",flag);
	}
}
