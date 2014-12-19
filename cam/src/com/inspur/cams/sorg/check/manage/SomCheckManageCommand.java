package com.inspur.cams.sorg.check.manage;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.dao.jdbc.ComExtUserDao;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao;
import com.inspur.cams.sorg.check.somcheck.data.SomCheck;
import com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck;
import com.inspur.sdmz.comm.util.IdHelp;

/**
 * @title:SomCheckCommand
 * @description:
 * @author:
 * @since:2011-12-21
 * @version:1.0
*/
public class SomCheckManageCommand extends BaseAjaxCommand{
	
	private SomCheckDao dao = (SomCheckDao) DaoFactory.getDao("com.inspur.cams.sorg.check.somcheck.dao.SomCheckDao");
	//社会组织外网用户
	private ComExtUserDao comExtUserDao = (ComExtUserDao)DaoFactory.getDao("com.inspur.cams.comm.extuser.dao.jdbc.ComExtUserDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheck dataBean=(SomCheck)record.toBean(SomCheck.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheck dataBean=(SomCheck)record.toBean(SomCheck.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	
	public void updateStatusRecevie(){
		String[] taskCodes=(String[]) getParameter("taskCodes");
		String status=(String) getParameter("status");
		String correctNotReason=(String) getParameter("correctNotReason");
		String taskCodeStr = "";
		for (int i = 0; i < taskCodes.length; i++) {
			if (taskCodeStr.length() > 0)
				taskCodeStr += ",";
			taskCodeStr += taskCodes[i];
		}
		dao.updateStatusRecevie(taskCodeStr,status,correctNotReason);
		//dao.updateRecivieDate(taskCodeStr);//更新SOM_CHECK_FLOW表中接收时间和接收人
	}
	
	public void updateStatus(){
		String taskCode=(String) getParameter("taskCode");
		String status=(String) getParameter("status");
		String step=(String) getParameter("step");
		String correctNotReason=(String) getParameter("correctNotReason");
		dao.updateStatus(taskCode,status,correctNotReason);
		dao.updateDateAndName(taskCode,step);
	}
	@Trans
	public void submit(){
		String taskCode=(String) getParameter("taskCode");
		String status=(String) getParameter("status");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", taskCode);
		DataSet ds = dao.query(pset);
		if(ds.getCount() > 0){
			SomCheck somCheck =  (SomCheck)ds.getRecord(0).toBean(SomCheck.class);
			somCheck.setCommitTime(DateUtil.getTime());
			somCheck.setStatus(status);
			dao.update(somCheck);
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
	//TODO 
	public void queryLastYearCheckResult(){
		String returnValue = "";
		ParameterSet pset = getParameterSet();
		String checkYear = (String) pset.getParameter("checkYear");
		String fillPeopleId = (String) pset.getParameter("fillPeopleId");
		pset.clear();
		pset.setParameter("FILL_PEOPLE_ID", fillPeopleId);
		pset.setParameter("CHECK_YEAR", checkYear);
		pset.setParameter("STATUS","8");
		DataSet jxDs = dao.query(pset);
		if(jxDs!=null && jxDs.getCount()==1){
			//年检结果
			String value = (String) jxDs.getRecord(0).get("checkResult");
			if(value !=null && !("".equals(value))){
				if("0".endsWith(value)){
					returnValue = "不合格";
				}
				if("1".endsWith(value)){
					returnValue = "合格";
				}
				if("2".endsWith(value)){
					returnValue = "基本合格";
				}
				if("3".endsWith(value)){
					returnValue = "待处理";
				}
				if("4".endsWith(value)){
					returnValue = "一年未年检";
				}
				if("5".endsWith(value)){
					returnValue = "两年未年检";
				}
			}
			//年检结果描述
			value = (String) jxDs.getRecord(0).get("checkResultDesc");
			if(value !=null && !("".equals(value))){
				returnValue=returnValue+";"+value;
			}
		}
		if("".endsWith(returnValue)){
			pset.clear();
			pset.setParameter("USER_ID", fillPeopleId);
			DataSet ds = comExtUserDao.queryExtUser(pset);
			if(ds!=null && ds.getCount()==1){
				String value = (String) ds.getRecord(0).get("note");
				if(value !=null && !("".equals(value))){
					if("0".endsWith(value)){
						returnValue = "不合格";
					}
					if("1".endsWith(value)){
						returnValue = "合格";
					}
					if("2".endsWith(value)){
						returnValue = "基本合格";
					}
					if("3".endsWith(value)){
						returnValue = "一年未年检";
					}
					if("4".endsWith(value)){
						returnValue = "两年未年检";
					}
				}
			}
		}
		this.setReturn("lastYearCheckResult", returnValue);
	}
	/**
	 * 插入一条未填报的年检信息
	 */
	@Trans
	public void insertNoCheck(){
		ParameterSet pset = getParameterSet();
		SomCheck bean = new SomCheck();
		bean.setTaskCode(IdHelp.getUUID32());
		bean.setCnName((String)pset.getParameter("cnName"));
		bean.setSorgType((String)pset.getParameter("sorgType"));
		bean.setCheckYear((String)pset.getParameter("checkYear"));
		bean.setCheckResult((String)pset.getParameter("checkResult"));
		bean.setCheckResultDesc((String)pset.getParameter("checkResultDesc"));
		bean.setFillPeopleId((String)pset.getParameter("fillPeopleId"));
		bean.setFillPeopleName((String)pset.getParameter("fillPeopleName"));
		bean.setFillPeopleArea((String)pset.getParameter("fillPeopleArea"));
		bean.setStatus("8");
		bean.setCurrentActivity("1");
		dao.insert(bean);
	}
}
