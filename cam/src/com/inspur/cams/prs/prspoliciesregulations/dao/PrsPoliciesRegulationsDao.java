package com.inspur.cams.prs.prspoliciesregulations.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import com.inspur.cams.prs.util.PrsSQL;
import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title:PrsPoliciesRegulationsDao
 * @description:
 * @author:
 * @since:2011-08-26
 * @version:1.0
*/
 public class PrsPoliciesRegulationsDao extends EntityDao<PrsPoliciesRegulations> implements IPrsPoliciesRegulationsDao{

 	public PrsPoliciesRegulationsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<PrsPoliciesRegulations> getEntityClass() {
		return PrsPoliciesRegulations.class;
	}

  	public void batchDelete(String[] delIds) {
		for(int i=0;i<delIds.length;i++){
			executeUpdate(PrsSQL.DELETE_PRS_POLICIES_REGULATIONS_BY_POLICIES_REGULATIONS_ID,new int[]{Types.VARCHAR},new Object[]{delIds[i]});
		}
	}

  	public DataSet queryBySql(ParameterSet pset) {
		String policiesRegId=(String)pset.getParameter("policiesRegId");
		String releaseCompany=(String)pset.getParameter("releaseCompany");
		String titlequery=(String)pset.getParameter("titlequery");
		String fileNum=(String)pset.getParameter("fileNum");
		String yearly=(String)pset.getParameter("yearly");
		String sendDateBegin=(String)pset.getParameter("sendDateBegin");
		String sendDateEnd=(String)pset.getParameter("sendDateEnd");
		String flag = (String) pset.getParameter("flag");
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(PrsSQL.SELECT_PRS_POLICIES_REGULATIONS);
		if(StringUtils.isNotEmpty(flag)){
			if("send".equals(flag)){
				if(StringUtils.isNotEmpty(releaseCompany)){
					sql.append(" AND RELEASE_COMPANY LIKE ? ");
					typeList.add(Types.VARCHAR);
					if(releaseCompany.endsWith("0000000000")){
						argsList.add(releaseCompany.substring(0, 2)+"%");
					}else if(releaseCompany.endsWith("00000000")){
						argsList.add(releaseCompany.substring(0, 4)+"%");
					}else{
						argsList.add(releaseCompany.substring(0,6)+"%");
					}
				}
			}else if("receive".equals(flag)){
				if(StringUtils.isNotEmpty(releaseCompany)){
					sql.append(" AND (INSTR( ACCEPTING_COMPANY_CODE, ? ) >0 ");
					typeList.add(Types.VARCHAR);
					argsList.add(releaseCompany);
					if(releaseCompany.endsWith("0000000000")){
						sql.append("OR ACCEPTING_COMPANY_CODE IS NULL )");
					}else if(releaseCompany.endsWith("00000000")){
						sql.append("OR (ACCEPTING_COMPANY_CODE IS NULL AND RELEASE_COMPANY IN (?,?)))");
						typeList.add(Types.VARCHAR);
						argsList.add(releaseCompany.substring(0, 2)+"0000000000");
						typeList.add(Types.VARCHAR);
						argsList.add(releaseCompany.substring(0, 4)+"00000000");
					}else{
						sql.append("OR (ACCEPTING_COMPANY_CODE IS NULL AND RELEASE_COMPANY IN (?,?,?)))");
						typeList.add(Types.VARCHAR);
						argsList.add(releaseCompany.substring(0, 2)+"0000000000");
						typeList.add(Types.VARCHAR);
						argsList.add(releaseCompany.substring(0, 4)+"00000000");
						typeList.add(Types.VARCHAR);
						argsList.add(releaseCompany.substring(0, 6)+"000000");
					}
					
				}
			}
		}
		if(StringUtils.isNotEmpty(titlequery)){
			sql.append(" AND REGULATIONS_TITLE LIKE ? ");
			typeList.add(Types.VARCHAR);
	        argsList.add("%"+titlequery+"%");
		}
		if(StringUtils.isNotEmpty(sendDateBegin)){
			sql.append(" AND RELEASE_DATE>=? ");
			typeList.add(Types.VARCHAR);
	        argsList.add(sendDateBegin);
		}
		if(StringUtils.isNotEmpty(sendDateEnd)){
			sql.append(" AND RELEASE_DATE<=? ");
			typeList.add(Types.VARCHAR);
	        argsList.add(sendDateEnd);
		}
		if(StringUtils.isNotEmpty(policiesRegId)){
			sql.append(" AND POLICIES_REGULATIONS_ID= ? ");
			typeList.add(Types.VARCHAR);
	        argsList.add(policiesRegId);
		}
		if(StringUtils.isNotEmpty(fileNum)){
			sql.append(" AND FILE_NUM LIKE ? ");
			typeList.add(Types.VARCHAR);
	        argsList.add("%"+fileNum+"%");
		}
		if(StringUtils.isNotEmpty(yearly)){
			sql.append(" AND YEARLY = ? ");
			typeList.add(Types.VARCHAR);
	        argsList.add(yearly);
		}
		
		sql.append(" ORDER BY RELEASE_DATE DESC ");
		int[] types = new int[typeList.size()];
		for(int i = 0;i<typeList.size();i++){
		    types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		return executeDataset(sql.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
  	}
   
   
}
