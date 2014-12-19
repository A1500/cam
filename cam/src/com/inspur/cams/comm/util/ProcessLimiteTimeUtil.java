package com.inspur.cams.comm.util;
import org.loushang.next.dao.DaoFactory;
import org.loushang.workflow.engine.limit.dao.support.ProcessLimitJdbcDao;
import org.loushang.workflow.engine.process.dao.support.ProcessJdbcDao;
import org.loushang.workflow.engine.process.data.Process;
import org.loushang.workflow.processdefinition.dao.support.ProcessLimitDefJdbcDao;
import org.loushang.workflow.processdefinition.data.ProcessLimitDef;
import org.loushang.workflow.util.TimeUtils;

public class ProcessLimiteTimeUtil {
	private static ProcessLimitJdbcDao dao = (ProcessLimitJdbcDao) DaoFactory
	.getDao("org.loushang.workflow.engine.limit.dao.support.ProcessLimitJdbcDao");	
	
	private static ProcessJdbcDao processJdbcDao = (ProcessJdbcDao) DaoFactory
	.getDao("org.loushang.workflow.engine.process.dao.support.ProcessJdbcDao");	
	
	private static ProcessLimitDefJdbcDao processLimitDefJdbcDao = (ProcessLimitDefJdbcDao) DaoFactory
	.getDao("org.loushang.workflow.processdefinition.dao.support.ProcessLimitDefJdbcDao");	
	/**
	 * 重新更新超时时间并更新
	 * 
	 * @param process
	 *            流程实例
	 * @param processLimitDef
	 *            流程限时定义
	 * 
	 * @return ProcessLimit 流程限时实例
	 */
	public static void reCreateProcessLimit(String processId) {
		String newTime = TimeUtils.getCurrentDateTime();
		Process process = processJdbcDao.get(processId);
		ProcessLimitDef processLimitDef = processLimitDefJdbcDao
		.getProcessLimitDef(process.getProcDefUniqueId());
		// 限时时间(毫秒)
		long millisLimitTime = TimeUtils.getLimitTime(newTime,
				processLimitDef.getUnit(), processLimitDef.getLimit());
		dao.updateProcessLimit(processId, TimeUtils.formatTime(millisLimitTime), millisLimitTime);
	}
	/**
	 * 转到补齐补正环节时将超时时间更新到一个大的日期，以保证补齐补正没有办理时不超时
	 * @param processId
	 */
	public static void updateMaxProcessLimit(String processId) {
		dao.updateProcessLimit(processId, "99991231 12:12:12", 0);
	}
}
