package com.inspur.cams.fis.base.domain.support;

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

import com.inspur.cams.fis.base.dao.IFisCemeWorkflowQueryDao;
import com.inspur.cams.fis.base.domain.IFisCemeWorkflowQueryDomain;
/**
 * @title:TaskInfoQueryDomain
 * @description:
 * @author:
 * @since:2011-5-11
 * @version:1.0
 */
public class FisCemeWorkflowQueryDomain implements IFisCemeWorkflowQueryDomain {
	@Reference
	private IFisCemeWorkflowQueryDao fisCemeWorkflowQueryDao;
	// 环节限时定义
	@Reference
	private IActivityLimitDefDao activityLimitDefDao;
	private ProcessLimitJdbcDao processLimitJdbcDao = (ProcessLimitJdbcDao) DaoFactory
	.getDao("org.loushang.workflow.engine.limit.dao.support.ProcessLimitJdbcDao");
	

	public DataSet queryDaiBan(ParameterSet pset) {
		DataSet dataSet = fisCemeWorkflowQueryDao.queryDaiBan(pset);
		setLimitWarnAndTaskState(dataSet.getRecordSet());
		return dataSet;
	}

	public DataSet queryYiBan(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryYiBan(pset);
	}

	public DataSet queryEnd(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryEnd(pset);
	}
	public DataSet queryWorkflow(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryWorkflow(pset);
	}

	//年检
	public DataSet queryDaiBanNJ(ParameterSet pset) {
		DataSet dataSet = fisCemeWorkflowQueryDao.queryDaiBanNJ(pset);
		setLimitWarnAndTaskState(dataSet.getRecordSet());
		return dataSet;
	}
	//年检
	public DataSet queryYiBanNJ(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryYiBanNJ(pset);
	}
	//年检
	public DataSet queryEndNJ(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryEndNJ(pset);
	}
	//查询新建流程
	public DataSet queryCreateFlow(ParameterSet pset){
		
		return fisCemeWorkflowQueryDao.queryCreateFlow(pset);
		
	}
	public IFisCemeWorkflowQueryDao getTaskInfoQueryDao() {
		return fisCemeWorkflowQueryDao;
	}

	public void setTaskInfoQueryDao(IFisCemeWorkflowQueryDao fisCemeWorkflowQueryDao) {
		this.fisCemeWorkflowQueryDao = fisCemeWorkflowQueryDao;
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
			// 环节定义唯一Id
			String actDefUniqueId = (String) record.get("ACT_DEF_UNIQUE_ID");

			// 环节预警
			long currentTime = Calendar.getInstance().getTime().getTime();
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
			//添加上整个流程的超时时间判定
			ProcessLimit processLimit = processLimitJdbcDao.getProcessLimitByProcessId((String)record.get("PROCESS_ID"));
			long limitTime = TimeUtils.parseLong(processLimit.getLimitTime());
			if (limitTime!=0&&currentTime - limitTime > 0) {
				record.set("TASK_STATE", "2");
			}
		}
	}

	public IActivityLimitDefDao getActivityLimitDefDao() {
		return activityLimitDefDao;
	}

	public void setActivityLimitDefDao(IActivityLimitDefDao activityLimitDefDao) {
		this.activityLimitDefDao = activityLimitDefDao;
	}
	public DataSet queryDaiBanEx(ParameterSet pset) {
		DataSet dataSet = fisCemeWorkflowQueryDao.queryDaiBanEx(pset);
		setLimitWarnAndTaskState(dataSet.getRecordSet());
		return dataSet;
	}

	public DataSet queryYiBanEx(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryYiBanEx(pset);
	}

	public DataSet queryEndEx(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryEndEx(pset);
	}
	public DataSet queryDaiBanYS(ParameterSet pset) {
		DataSet dataSet = fisCemeWorkflowQueryDao.queryDaiBanYS(pset);
		setLimitWarnAndTaskState(dataSet.getRecordSet());
		return dataSet;
	}

	public DataSet queryYiBanYS(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryYiBanYS(pset);
	}

	public DataSet queryEndYS(ParameterSet pset) {
		return fisCemeWorkflowQueryDao.queryEndYS(pset);
	}
}