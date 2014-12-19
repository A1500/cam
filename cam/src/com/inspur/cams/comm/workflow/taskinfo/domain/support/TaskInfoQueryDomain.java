package com.inspur.cams.comm.workflow.taskinfo.domain.support;

import java.util.Calendar;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.workflow.engine.limit.dao.support.ProcessLimitJdbcDao;
import org.loushang.workflow.engine.limit.data.ProcessLimit;
import org.loushang.workflow.processdefinition.dao.IActivityLimitDefDao;
import org.loushang.workflow.processdefinition.data.ActivityLimitDef;
import org.loushang.workflow.util.TimeUtils;
import org.loushang.workflow.util.bsp.BspUtil;
import org.loushang.workflow.util.bsp.IWorkDay;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.workflow.taskinfo.dao.ITaskInfoQueryDao;
import com.inspur.cams.comm.workflow.taskinfo.domain.ITaskInfoQueryDomain;
/**
 * @title:TaskInfoQueryDomain
 * @description:
 * @author:
 * @since:2011-5-11
 * @version:1.0
 */
public class TaskInfoQueryDomain implements ITaskInfoQueryDomain {
	@Reference
	private ITaskInfoQueryDao taskInfoQueryDao;
	// 环节限时定义
	@Reference
	private IActivityLimitDefDao activityLimitDefDao;
	private ProcessLimitJdbcDao processLimitJdbcDao = (ProcessLimitJdbcDao) DaoFactory
	.getDao("org.loushang.workflow.engine.limit.dao.support.ProcessLimitJdbcDao");
	

	public DataSet queryDaiBan(ParameterSet pset) {
		DataSet dataSet = taskInfoQueryDao.queryDaiBan(pset);
		setLimitWarnAndTaskState(dataSet.getRecordSet());
		return dataSet;
	}

	public DataSet queryYiBan(ParameterSet pset) {
		return taskInfoQueryDao.queryYiBan(pset);
	}

	public DataSet queryEnd(ParameterSet pset) {
		return taskInfoQueryDao.queryEnd(pset);
	}
	
	public ITaskInfoQueryDao getTaskInfoQueryDao() {
		return taskInfoQueryDao;
	}

	public void setTaskInfoQueryDao(ITaskInfoQueryDao taskInfoQueryDao) {
		this.taskInfoQueryDao = taskInfoQueryDao;
	}

	/**
	 * 获取工作日历
	 * 
	 * @return
	 */
	public IWorkDay getWorkdayDomain() {
		return BspUtil.getInstance().getWorkDayDomain();
	}
	
	/**
	 * 设置流、环节超时预警时间以及任务状态,0:正常,1：预警,2:超时
	 * 
	 * @param rs
	 */
	private void setLimitWarnAndTaskState(RecordSet recordSet) {
		for (int i = 0; i < recordSet.size(); i++) {
			Record record = (Record) recordSet.get(i);
			// 任务状态
			record.set("TASK_STATE", "0");
			long currentTime = Calendar.getInstance().getTime().getTime();
			//添加上整个流程的超时时间判定
			ProcessLimit processLimit = processLimitJdbcDao.getProcessLimitByProcessId((String)record.get("PROCESS_ID"));
			record.set("LIMITE_TIME",  "");
			record.set("TO_LIMITE_TIME", "");
			//没有限定超时时间的下边的parseLong会报错
			try{
				long limitTime = TimeUtils.parseLong(processLimit.getLimitTime());
				if (limitTime!=0) {
					if(limitTime-currentTime<0){
						record.set("TASK_STATE", "2");
					}
					record.set("LIMITE_TIME",  TimeUtils.formatTime(limitTime));
					long actRemainDays = (limitTime - currentTime)
					/ (3600 * 1000 * 24);
					//record.set("TO_LIMITE_TIME", TimeUtils.convertMillsTimeDiffToDisplayTimeStr(limitTime-currentTime));
					record.set("TO_LIMITE_TIME", actRemainDays);
					if(actRemainDays<=3&&actRemainDays>=0){
						record.set("TASK_STATE", "1");
					}
				}
			}catch(Exception e){
				
			}
			
			// 环节定义唯一Id
			String actDefUniqueId = (String) record.get("ACT_DEF_UNIQUE_ID");

			// 环节预警
			if (record.get("ACT_WARN_TIME") != null) {
				if (currentTime
						- TimeUtils.parseLong((String) record
								.get("ACT_WARN_TIME")) > 0) {
					record.set("TASK_STATE", "1");
				}
			}

			// 环节限时
			long actLimitTime = TimeUtils.parseLong((String) record
					.get("ACT_LIMIT_TIME"));
			if (actLimitTime != 0) {
				if (currentTime - actLimitTime > 0) {
					record.set("TASK_STATE", "2");
				}
			}

			// 环节剩余时间
			if (actLimitTime != 0) {
				// 未超时回传环节剩余时间数
				if (actLimitTime - currentTime > 0) {
					ActivityLimitDef activityLimitDef = getActivityLimitDefDao().getActivityLimitDef(actDefUniqueId);
					if(activityLimitDef!=null){
						String unit = activityLimitDef.getUnit();
						if (unit != null) {
							if ("D".equals(unit)) {
								IWorkDay workdayDomain = getWorkdayDomain();
								int actRemainTime = workdayDomain.getCountWorkDayInStruType(
										null, TimeUtils.getCurrentDateTime()
												.substring(0, 8), ((String) record
												.get("ACT_LIMIT_TIME")).substring(0,
												8));
								record.set("ACT_REMAIN_TIME", actRemainTime - 1
										+ " 工作日");
								long actRemainTimeNumOnly = new Long(
										actRemainTime - 1);
								record.set("ACT_REMAIN_TIME_NUM_ONLY",
										actRemainTimeNumOnly);
							}
							if ("N".equals(unit) || "Y".equals(unit)) {
								long actRemainDays = (actLimitTime - currentTime)
										/ (3600 * 1000 * 24);
								long actRemainHours = (actLimitTime - currentTime)
										/ (3600 * 1000) - actRemainDays * 24;
								long actRemainminutes = (actLimitTime - currentTime)
										/ (60 * 1000)
										- actRemainDays
										* 1440
										- actRemainHours * 60;
								if (actRemainHours > 0 || actRemainminutes > 0) {
									actRemainDays++;
								}
								record.set("ACT_REMAIN_TIME", actRemainDays + " 自然日");
								record.set("ACT_REMAIN_TIME_NUM_ONLY", actRemainDays);
							}
						}
					}else{
						record.set("ACT_REMAIN_TIME", new Long(0));
						record.set("ACT_REMAIN_TIME_NUM_ONLY",new Long(0));
					}
					
				} else {
					// 超时--环节剩余时间数为0
					record.set("ACT_REMA_IN_TIME", new Long(0));
					record.set("ACT_REMAIN_TIME_NUM_ONLY", new Long(0));
				}
			}
		}
	}

	public IActivityLimitDefDao getActivityLimitDefDao() {
		return activityLimitDefDao;
	}

	public void setActivityLimitDefDao(IActivityLimitDefDao activityLimitDefDao) {
		this.activityLimitDefDao = activityLimitDefDao;
	}
}