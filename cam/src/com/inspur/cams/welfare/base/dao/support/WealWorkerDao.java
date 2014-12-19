package com.inspur.cams.welfare.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.welfare.base.dao.IWealWorkerDao;
import com.inspur.cams.welfare.base.data.WealWorker;

/**
 * @title:WealWorkerDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealWorkerDao extends EntityDao<WealWorker> implements IWealWorkerDao{

 	public WealWorkerDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealWorker.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealWorker");
	}
  
	public DataSet queryFitWorkerSum(ParameterSet pset){
		String taskCode=(String)pset.getParameter("taskCode");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select  ");
		sql.append("  count(p.WORKER_ID)                        AS TOTAL_NUM, ");
		sql.append("  SUM(case when p.DISABILITY_TYPE is not null then 1 else 0 end) AS DIS_NUM ,");
	    sql.append("  SUM(case when p.IF_PRODUCTOR = '0' then 1 else 0 end) AS NO_PRO_NUM ,");
	    sql.append("  SUM(case when p.IF_PRODUCTOR = '1' then 1 else 0 end) AS PRO_NUM ");
	    sql.append("  FROM WEAL_WORKER p  where 1=1 and ");
	    sql.append("  p.task_code=?  ");
	    argsList.add(taskCode);
		typeList.add(Types.VARCHAR);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args, true);
		return ds;
	}
	 /**
	 * 查询 职工信息统计信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUnitWorkerSum(ParameterSet pset) {
		String taskCode=(String)pset.getParameter("taskCode");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select  ");
		sql.append("  count(p.WORKER_ID)                        AS TOTAL_NUM, ");
		sql.append("  SUM(case when p.DISABILITY_TYPE is not null then 1 else 0 end) AS DIS_NUM ,");
	    sql.append("  SUM(case when p.IF_PRODUCTOR = '0' then 1 else 0 end) AS NO_PRO_NUM ,");
	    sql.append("  SUM(case when p.IF_PRODUCTOR = '1' then 1 else 0 end) AS PRO_NUM ");
	    sql.append("  FROM WEAL_WORKER p  where 1=1 and ");
	    sql.append("  p.task_code=?  ");
	    argsList.add(taskCode);
		typeList.add(Types.VARCHAR);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args, true);
		return ds;
	}
	 /**
	 * 查询 残疾职工明细
	 * @param pset
	 * @return
	 */
	public DataSet queryUnitWorkerDisability(ParameterSet pset){
		String taskCode = (String)pset.getParameter("taskCode");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" SELECT ");
		sql.append(" SUM(case when p.DISABILITY_TYPE='61' then 1 else 0 end ) AS slcj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='62' then 1 else 0 end ) AS tlcj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='63' then 1 else 0 end ) AS yycj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='64' then 1 else 0 end ) AS ztcj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='65' then 1 else 0 end ) AS zlcj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='66' then 1 else 0 end ) AS jscj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='67' then 1 else 0 end ) AS dccj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='69' then 1 else 0 end ) AS qtcj ,");
		sql.append(" SUM(case when p.DISABILITY_TYPE='65' or p.DISABILITY_TYPE='66'  then 1 else 0 end ) AS zljscj ");
		sql.append(" FROM WEAL_WORKER p where 1 = 1 and ");
		sql.append(" p.task_code = ? ");
		argsList.add(taskCode);
		typeList.add(Types.VARCHAR);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args, true);
		return ds;
	}

	public DataSet getWorker(ParameterSet pset) {
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		typeList.add(Types.VARCHAR);
		List<Object> objList = new ArrayList<Object>();
		String taskCode=(String)pset.getParameter("taskCode");
		objList.add(taskCode);
		sql.append("SELECT A.* FROM WEAL_WORKER A WHERE A.TASK_CODE = ? ");
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		}else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	
	
	}
	
	/**
	 * @Title: getDsStart 
	 * @Description: TODO(excel分页信息A) 
	 * @author wangziming
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	/**
	 * @Title: getDsLimit 
	 * @Description: TODO(excel分页信息B) 
	 * @author wangziming
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit;
	}
}
