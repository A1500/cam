package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcElectionInfoDao;
import com.inspur.cams.cdc.base.data.CdcElectionInfo;

/**
 * 民主选举选举信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcElectionInfoDao extends EntityDao<CdcElectionInfo> implements ICdcElectionInfoDao {
	
	@Override
	public Class<CdcElectionInfo> getEntityClass() {
		return CdcElectionInfo.class;
	}

	public DataSet queryCompletionSum(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String reportDate = (String) pset.getParameter("reportDate");
		String organCode = (String) pset.getParameter("ORGAN_CODE");
		String reportType = (String) pset.getParameter("REPORT_TYPE");
		List<Object> argList = new ArrayList<Object>();
		List<Integer> typeList = new ArrayList<Integer>();
		sql.append("SELECT NVL(SUM(CASE WHEN T.IF_ELECTION = '1' THEN 1 ELSE 0 END ),0)IFELECTION,");
		sql.append("NVL(SUM(CASE WHEN T.IF_COMPLETE = '1' THEN 1 ELSE 0 END),0) COMPLETED,");
		sql.append("NVL(SUM(CASE WHEN T.IF_COMPLETE = '0' THEN 1 ELSE 0 END),0) UNCOMPLETED,");
		sql.append("NVL(SUM(CASE WHEN T.COMPLETE_RESULT = '1' THEN 1 ELSE 0 END),0) ANOTHER ,");
		sql.append("NVL(SUM(CASE WHEN T.COMPLETE_RESULT = '2' THEN 1 ELSE 0 END),0) AFRESH,");
		sql.append("NVL(SUM(CASE WHEN T.COMPLETE_RESULT = '3' THEN 1 ELSE 0 END),0) ONCE ");
		sql.append("FROM CDC_ELECTION_INFO T  WHERE 1 =1 ");
		if(reportDate!=null &&!("".equals(reportDate))){
			sql.append(" AND T.REPORT_DATE = ? ");
			argList.add(reportDate);
			typeList.add(Types.VARCHAR);
		}
		if(organCode!=null &&!("".equals(organCode))){
			sql.append(" AND T.ORGAN_CODE LIKE ''||?||'%'  ");
			argList.add(organCode);
			typeList.add(Types.VARCHAR);
		}
		if(reportType!=null &&!("".equals(reportType))){
			sql.append(" AND T.REPORT_TYPE = ? ");
			argList.add(reportType);
			typeList.add(Types.VARCHAR);
		}
		Object[] args = argList.toArray();
		int[] types =new int[typeList.size()];
		for(int i = 0 ;i<types.length;i++){
			types[i] = typeList.get(i);
		}
		return this.executeDataset(sql.toString(),types,args,true);
	}

	public DataSet querySumCompletion(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String reportDate = (String) pset.getParameter("reportDate");
		String organCode = (String) pset.getParameter("ORGAN_CODE");
		String reportType = (String) pset.getParameter("REPORT_TYPE");
		List<Object> argList = new ArrayList<Object>();
		List<Integer> typeList = new ArrayList<Integer>();
		sql.append("SELECT NVL(B.TOTALNUM,0) TOTALNUM, NVL(A.ELECTION,0)ELECTION,NVL(A.COMPLETED,0)COMPLETED," );
		sql.append("NVL(A.UNCOMPLETED,0)UNCOMPLETED,NVL(B.TOTALNUM -A.ELECTION,0) UNELECTION ");
		sql.append("FROM (SELECT 'Z' T,SUM(CASE WHEN T.IF_ELECTION = '1' THEN 1 ELSE 0 END) ELECTION,");
		sql.append("SUM(CASE WHEN T.IF_COMPLETE = '1' THEN 1 ELSE 0 END) COMPLETED,");
		sql.append("SUM(CASE WHEN T.IF_COMPLETE = '0' THEN 1 ELSE 0 END) UNCOMPLETED "); 
		sql.append("FROM CDC_ELECTION_INFO T WHERE 1=1 ");
		if(reportDate!=null &&!("".equals(reportDate))){
			sql.append(" AND T.REPORT_DATE = ? ");
			argList.add(reportDate);
			typeList.add(Types.VARCHAR);
		}
		if(organCode!=null &&!("".equals(organCode))){
			sql.append(" AND T.ORGAN_CODE LIKE ''||?||'%'  ");
			argList.add(organCode);
			typeList.add(Types.VARCHAR);
		}
		if(reportType!=null &&!("".equals(reportType))){
			sql.append(" AND T.REPORT_TYPE = ? ");
			argList.add(reportType);
			typeList.add(Types.VARCHAR);
		}
		sql.append(" ) A,(SELECT 'Z' T, COUNT(1) TOTALNUM FROM  COM_EXT_USER SS WHERE  1=1 ");
		if(organCode!=null &&!("".equals(organCode))){
			sql.append(" AND SS.ORGAN_ID LIKE ''||?||'%' ");
			argList.add(organCode);
			typeList.add(Types.VARCHAR);
		}
		if(reportType!=null &&!("".equals(reportType))){
			sql.append(" AND SS.COMMUNITY_TYPE = ?");
			argList.add(reportType);
			typeList.add(Types.VARCHAR);
		}
		sql.append(" )B WHERE A.T=B.T");
		Object[] args = argList.toArray();
		int[] types =new int[typeList.size()];
		for(int i = 0 ;i<types.length;i++){
			types[i] = typeList.get(i);
		}
		DataSet ds =  this.executeDataset(sql.toString(),types,args,true);
		return ds;
	}
}