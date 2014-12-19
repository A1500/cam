package com.inspur.cams.prs.prsproblemdeal.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.inspur.cams.prs.util.PrsSQL;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.apache.commons.lang.StringUtils;
/**
 * @title:PrsProblemDealDao
 * @description:
 * @author:
 * @since:2011-08-29
 * @version:1.0
*/
 public class PrsProblemDealDao extends EntityDao<PrsProblemDeal> implements IPrsProblemDealDao{

 	public PrsProblemDealDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<PrsProblemDeal> getEntityClass() {
		return PrsProblemDeal.class;
	}
   /**
    * 查询信息
    */
   public DataSet queryBySql(ParameterSet pset){
	   String organ=(String)pset.getParameter("organ");
	   String curActivity=(String)pset.getParameter("curActivity");
	   String title=(String)pset.getParameter("problemTitle");
	   String supervision=(String)pset.getParameter("supervision");
	   String problemFrom=(String)pset.getParameter("problemFrom");
	   String problemDateBegin=(String)pset.getParameter("problemDateBegin");
	   String problemDateEnd=(String)pset.getParameter("problemDateEnd");
	   String problemCompany=(String)pset.getParameter("problemCompany");
	   String dealFlag=(String)pset.getParameter("dealFlag");
	   StringBuffer sql=new StringBuffer();
	   List<Integer> typeList = new ArrayList<Integer>();
	   List<Object> argsList = new ArrayList<Object>();
		   sql.append(PrsSQL.SELECT_PRS_PROBLEM_DEAL);
	   if(StringUtils.isNotEmpty(organ)){
		   sql.append("  AND ORGAN=? ");
		   typeList.add(Types.VARCHAR);
		   argsList.add(organ);
		   
	   }
	   if(StringUtils.isNotEmpty(problemCompany)){
		   sql.append("  AND PROBLEM_COMPANY=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemCompany);
	   }
	   if(StringUtils.isNotEmpty(curActivity)){
		   sql.append("  AND CUR_ACTIVITY=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(curActivity);
	   }
	   if(StringUtils.isNotEmpty(title)){
		   sql.append("  AND PROBLEM_TITLE like ? ");
		   typeList.add(Types.VARCHAR);
           argsList.add("%"+title+"%");
	   }
	   if(StringUtils.isNotEmpty(supervision)){
		   sql.append("  AND SUPERVISION=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(supervision);
	   }

	   if(StringUtils.isNotEmpty(problemFrom)){
		   sql.append("  AND PROBLEM_FROM=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemFrom);
	   }
	   if(StringUtils.isNotEmpty(dealFlag)){
		   sql.append("  AND DEAL_FLAG=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(dealFlag);
	   }
	   if(StringUtils.isNotEmpty(problemDateBegin)){
		   sql.append("  AND PROBLEM_DATE>=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemDateBegin);
	   }
	   if(StringUtils.isNotEmpty(problemDateEnd)){
		   sql.append("  AND PROBLEM_DATE<=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemDateBegin);
	   }
		   sql.append("UNION "+"\n");
		   sql.append(PrsSQL.SELECT_PRS_PROBLEM_DEAL_PRS_PROBLEM_HISTORY);
	   if(StringUtils.isNotEmpty(organ)){	   
		   sql.append(" AND H.RECEIVEORGAN=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(organ);
	   }
	   if(StringUtils.isNotEmpty(curActivity)){
		   sql.append(" AND D.CUR_ACTIVITY=?  ");
		   typeList.add(Types.VARCHAR);
           argsList.add(curActivity);
	   }
	  /*if(StringUtils.isNotEmpty(dealFlag)){
		  sql.append(" AND h.DEAL_FLAG='"+dealFlag+"' \n");
	  }*/
	   if(StringUtils.isNotEmpty(problemCompany)){
		   sql.append(" AND D.PROBLEM_COMPANY=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemCompany);
	   }
	   if(StringUtils.isNotEmpty(title)){
		   sql.append(" AND D.PROBLEM_TITLE=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(title);
	   }
	   if(StringUtils.isNotEmpty(supervision)){
		   sql.append(" AND D.SUPERVISION=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(supervision);
	   }
	   if(StringUtils.isNotEmpty(problemFrom)){
		   sql.append(" AND D.PROBLEM_FROM=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemFrom);
	   }
	   if(StringUtils.isNotEmpty(problemDateBegin)){
		   sql.append(" AND D.PROBLEM_DATE>=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemDateBegin);
	   }
	   if(StringUtils.isNotEmpty(problemDateEnd)){
		   sql.append(" AND D.PROBLEM_DATE<=? ");
		   typeList.add(Types.VARCHAR);
           argsList.add(problemDateEnd);
	   } 
	   int[] types = new int[typeList.size()];
	   for(int i = 0;i<typeList.size();i++){
	       types[i] = typeList.get(i);
	   }
	   Object[] args = argsList.toArray(); 
	   return executeDataset(sql.toString(), types,args,pset.getPageStart(),pset.getPageLimit(),true);
   }
   
}
