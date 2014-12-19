package com.inspur.cams.welfare.base.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealFitApplyDao;
import com.inspur.cams.welfare.base.data.WealFitApply;

/**
 * @title:WealFitApplyDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealFitApplyDao extends EntityDao<WealFitApply> implements IWealFitApplyDao{

 	public WealFitApplyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealFitApply.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealFitApply");
	}
   
   public DataSet queryInfo(ParameterSet pset){
	   String applyType = (String) pset.getParameter("applyType");
	   String fitId = (String) pset.getParameter("fitId");
	   List<Object> typeList = new ArrayList<Object>();
	   List<Object> argsList = new ArrayList<Object>();
	   StringBuffer sql = new StringBuffer();
	   sql.append(" select a.*,b.APPLY_YEAR from WEAL_FIT_APPLY a,WEAL_FIT_INFO b where a.TASK_CODE = b.TASK_CODE(+)  ");
	   if(StringUtils.isNotEmpty(fitId)){
	    	sql.append(" and a.FIT_ID= ?  ");
	 	    argsList.add(fitId);
	 		typeList.add(Types.VARCHAR);
	   }
	   if(StringUtils.isNotEmpty(applyType)){
	    	sql.append(" and a.APPLY_TYPE= ?  ");
	 	    argsList.add(applyType);
	 		typeList.add(Types.VARCHAR);
	   }
	   int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	   
	   
   }
   public DataSet queryQualificationList(ParameterSet pset) {
		// TODO Auto-generated method stub
		String companyName=(String)pset.getParameter("companyName");
		String dataSource=(String)pset.getParameter("dataSource");
		String applyStauts=(String)pset.getParameter("applyStauts");
		String applyType=(String)pset.getParameter("applyType");
		String applyYear=(String)pset.getParameter("applyYear");
		String serialNum=(String)pset.getParameter("serialNum");
		String morgArea=(String)pset.getParameter("morgArea");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select p.TASK_CODE,p.SERIAL_NUM,p.COMPANY_NAME,p.MORG_AREA,p.APPLY_STAUTS,p.DATA_SOURCE,p.REG_DATE,p.APPLY_YEAR from v_fit_applyandinfo p ");
	    sql.append("   where 1=1  ");
	    if(StringUtils.isNotEmpty(companyName)){
	    	sql.append(" and p.COMPANY_NAME LIKE ?  ");
	 	    argsList.add(companyName);
	 		typeList.add(Types.VARCHAR);
	    }
	    if(StringUtils.isNotEmpty(dataSource)){
	    	sql.append(" and p.DATA_SOURCE=?  ");
	 	    argsList.add(dataSource);
	 		typeList.add(Types.VARCHAR);
	    }
	    if(StringUtils.isNotEmpty(serialNum)){
	    	sql.append(" and p.SERIAL_NUM=?  ");
	 	    argsList.add(serialNum);
	 		typeList.add(Types.VARCHAR);
	    }
	    if(StringUtils.isNotEmpty(applyYear)){
	    	sql.append(" and p.APPLY_YEAR=? ");
	 	    argsList.add(applyYear);
	 		typeList.add(Types.VARCHAR);
	    }
	    if(StringUtils.isNotEmpty(morgArea)){
	    	sql.append(" and p.MORG_AREA LIKE ? ");
	 	    argsList.add(morgArea);
	 		typeList.add(Types.VARCHAR);
	    }
	    if(StringUtils.isNotEmpty(applyStauts)){
	    	sql.append(" and p.APPLY_STAUTS=?  ");
	 	    argsList.add(applyStauts);
	 		typeList.add(Types.VARCHAR);
	    }
	    if(StringUtils.isNotEmpty(applyType)){
	    	sql.append(" and p.APPLY_TYPE=?  ");
	 	    argsList.add(applyType);
	 		typeList.add(Types.VARCHAR);
	    }
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
   public DataSet queryQualificationPrintList(ParameterSet pset) {
		// TODO Auto-generated method stub
		String companyName=(String)pset.getParameter("companyName");
		String dataSource=(String)pset.getParameter("dataSource");
		String applyStauts=(String)pset.getParameter("applyStauts");
		String applyType=(String)pset.getParameter("applyType");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select p.TASK_CODE,p.COMPANY_NAME,p.APPLY_STAUTS,p.DATA_SOURCE,p.REG_DATE,p.DIRECTOR_BASE_OPINION from v_fit_applyandinfo p ");
	    sql.append("   where   p.APPLY_STAUTS IN('4','5') ");
	    if(StringUtils.isNotEmpty(companyName)){
	    	sql.append(" and p.COMPANY_NAME LIKE ?  ");
	 	    argsList.add(companyName);
	 		typeList.add(Types.VARCHAR);
	    }
	    if(StringUtils.isNotEmpty(dataSource)){
	    	sql.append(" and p.DATA_SOURCE=?  ");
	 	    argsList.add(dataSource);
	 		typeList.add(Types.VARCHAR);
	    }
	   /* if(StringUtils.isNotEmpty(applyStauts)){
	    	sql.append(" and p.APPLY_STAUTS=?  ");
	 	    argsList.add(applyStauts);
	 		typeList.add(Types.VARCHAR);
	    }*/
	    if(StringUtils.isNotEmpty(applyType)){
	    	sql.append(" and p.APPLY_TYPE=?  ");
	 	    argsList.add(applyType);
	 		typeList.add(Types.VARCHAR);
	    }
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
}
