package com.inspur.cams.welfare.dzjc.monitor.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.util.domain.BaseJdbcDao;
import org.loushang.workflow.util.TimeUtils;

import com.inspur.cams.comm.util.BspUtil;

/**
 * @title 社会福利流程业务超时情况监控
 * @author 孙磊
 * @time 2013年8月2日12：35
 */
@SuppressWarnings("unchecked")
public class DzjcWealMonitorDao  extends BaseJdbcDao  {
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryMonitorFitData(ParameterSet pset) {
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT W.*,  ");
		sql.append("   T.APPLY_TYPE,T.TASK_CODE,T.COMPANY_NAME, T.LEGAL_PEOPLE,  "); 
		sql.append("   T.CUR_ACTIVITY,T.CUR_OPINION_ID,T.CUR_PEOPLE_NAME,  "); 
		sql.append("   to_char(round(to_date(W.ACT_LIMIT_TIME, 'yyyy-MM-dd hh24:mi:ss') -  ");
		sql.append("    to_date(to_char(sysdate, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy-MM-dd hh24:mi:ss'), 0)) as LIMIT_DAYS  ");
		sql.append("   FROM WF_DAI_BAN_TASK W, V_FIT_APPLYANDINFO T    ");
		sql.append("  WHERE W.PRIMARY_KEY = T.TASK_CODE  ");
		sql.append("  AND W.IS_VISIBLE = '1' ");
		//   注释部分：只能查看当前登录用户OrganId下的业务超时监控数据
		//sql.append("  AND W.ORGAN_ID = ?  ");
		//argsList.add(BspUtil.getEmpOrgan().getOrganId());
 		//typeList.add(Types.VARCHAR);
		sql.append("   ORDER BY W.CREATE_TIME  DESC  ");
		/*
	 	int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		*/
		DataSet ds = executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	/**
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryMonitorUnitData(ParameterSet pset) {
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT W.*,  ");
		sql.append("   T.APPLY_TYPE,T.TASK_CODE,T.COMPANY_NAME, T.LEGAL_PEOPLE,  "); 
		sql.append("   T.CUR_ACTIVITY,T.CUR_OPINION_ID,T.CUR_PEOPLE_NAME,  "); 
		sql.append("   to_char(round(to_date(W.ACT_LIMIT_TIME, 'yyyy-MM-dd hh24:mi:ss') -  ");
		sql.append("    to_date(to_char(sysdate, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy-MM-dd hh24:mi:ss'), 0)) as LIMIT_DAYS  ");
		sql.append("   FROM WF_DAI_BAN_TASK W, v_unit_applyandinfo T    ");
		sql.append("  WHERE W.PRIMARY_KEY = T.TASK_CODE  ");
		sql.append("  AND W.IS_VISIBLE = '1' ");
		//   注释部分：只能查看当前登录用户OrganId下的业务超时监控数据
		//sql.append("  AND W.ORGAN_ID = ?  ");
		//argsList.add(BspUtil.getEmpOrgan().getOrganId());
 		//typeList.add(Types.VARCHAR);
		sql.append("   ORDER BY W.CREATE_TIME  DESC  ");
		/*
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		*/
		DataSet ds = executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
}
