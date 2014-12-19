package com.inspur.cams.sorg.dzjc.monitor.dao;

import java.util.Calendar;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.util.domain.BaseJdbcDao;
import org.loushang.workflow.util.TimeUtils;

import com.inspur.cams.sorg.dzjc.monitor.data.DzjcSomMonitor;
/**
 * @title 社会组织党建报表查询Dao
 * @author 闫亮亮
 * @time 2012年9月25日16:01:44
 */
@SuppressWarnings("unchecked")
public class DzjcSomMonitorDao  extends BaseJdbcDao  {
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 两年党员数综合比较
	 * @param pset
	 * @return
	 */
	public DataSet queryMonitorData(ParameterSet pset) {
		StringBuffer sql=new StringBuffer();
		sql.append(" select *  ");
		sql.append("  from (select b.sorg_name as sorgName,  ");
		sql.append("   to_char(to_date(a.slsj, 'yyyy-MM-dd hh24:mi:ss'),'yyyyMMdd hh24:mi:ss')  as acceptTime,    ");
		sql.append("  to_date(a.slsj, 'yyyy-MM-dd hh24:mi:ss') + a.GDBLSX+'' as toDates,  ");
		sql.append("  a.GDBLSX as GDBLSX, ");
		sql.append("  b.cur_activity as curActivity,  ");
		sql.append("  b.cur_people_name as curPerson,  ");
		sql.append("  c.name as processType,  ");
		sql.append("  b.task_code,  ");
		sql.append("  to_char(round(to_date(to_char(sysdate,'yyyy-MM-dd hh24:mi:ss'),'yyyy-MM-dd hh24:mi:ss')-to_date(slsj, 'yyyy-MM-dd  hh24:mi:ss')-a.GDBLSX,0)) as toDateDays  ");
		sql.append("  from V_ELM_SOM_ACCEPT_VIEW2 a, som_apply b, dic_apply_type c ");
		sql.append(" where to_date(slsj, 'yyyy-MM-dd hh24:mi:ss') + a.GDBLSX -60<= sysdate  ");
		sql.append(" and a.YXTYWLSH = b.task_code  ");
		sql.append(" and b.apply_type = c.code  ");
		sql.append(" and b.accept_area ='370000000000') temp  ");
		sql.append(" where temp.task_code not in  ");
		sql.append(" (select YXTYWLSH from V_ELM_SOM_complete_VIEW d)  ");
		sql.append(" order by toDateDays desc  ");
		DataSet ds = executeDataset(sql.toString(), true);
		List<Record> list = ds.getRecordSet();
		DataSet dsReturn = new DataSet();
		for(int i=0;i<list.size();i++){
			Record rd = (Record) list.get(i);
			DzjcSomMonitor dzjcSomMonitor = new DzjcSomMonitor();
			dzjcSomMonitor.setCommit_time((String) rd.get("COMMIT_TIME"));
			String curActivity = (String) rd.get("CURACTIVITY");
			dzjcSomMonitor.setCurActivity((String) rd.get("CURACTIVITY"));
			dzjcSomMonitor.setCurPerson((String) rd.get("CURPERSON"));
			dzjcSomMonitor.setGDBLSX((String) rd.get("GDBLSX"));
			dzjcSomMonitor.setProcessType((String) rd.get("PROCESSTYPE"));
			dzjcSomMonitor.setSorgName((String) rd.get("SORGNAME"));
			dzjcSomMonitor.setTask_code((String) rd.get("TASK_CODE"));
			String acceptTime = (String) rd.get("ACCEPTTIME");
			dzjcSomMonitor.setAcceptTime(acceptTime);
			int unit = Integer.parseInt((String) rd.get("GDBLSX"));
			//计算到期时间
			long millisLimitTime = TimeUtils.getLimitTime(acceptTime,
					"D", unit);
			//当前时间
			long currentTime = Calendar.getInstance().getTime().getTime();
			//剩余时间
			long actRemainDays = (millisLimitTime - currentTime)/ (3600 * 1000 * 24);
			dzjcSomMonitor.setToDateDays(actRemainDays+"");
			dzjcSomMonitor.setToDate(TimeUtils.formatTime(millisLimitTime));
			if(curActivity.equals("补齐补正")){
				dzjcSomMonitor.setToDateDays("补齐补正清零");
				dzjcSomMonitor.setToDate("");
			}
			dsReturn.addRecord(dzjcSomMonitor);
		}
		dsReturn.setTotalCount(list.size());
		return dsReturn;
	}
	
}
