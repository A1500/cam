package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcElectionCommitteeDao;
import com.inspur.cams.cdc.base.data.CdcElectionCommittee;

/**
 * @title:CdcElectionCommitteeDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public class CdcElectionCommitteeDao extends EntityDao<CdcElectionCommittee> implements ICdcElectionCommitteeDao{

 	public CdcElectionCommitteeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<CdcElectionCommittee> getEntityClass() {
		return CdcElectionCommittee.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from CdcElectionCommittee");
	}

public DataSet querySum(ParameterSet pset) {
	StringBuffer sql = new StringBuffer();
	String reportDate = (String) pset.getParameter("reportDate");
	String organCode = (String) pset.getParameter("ORGAN_CODE");
	String reportType = (String) pset.getParameter("REPORT_TYPE");
	List<Object> argList = new ArrayList<Object>();
	List<Integer> typeList = new ArrayList<Integer>();
	sql.append("SELECT NVL(SUM(T.CADRE_NUM),0) CADERNUM," );
	sql.append(" NVL(SUM(T.CADRE_FEMALE_NUM),0) CADREFEMALENUM," );
	sql.append(" NVL(SUM(T.CADRE_PARTY_NUM),0) CADREPARTYNUM," );
	sql.append(" NVL(SUM(T.CADRE_SEQUENCE_NUM),0) CADRESEQUENCENUM," );
	sql.append(" NVL(SUM(T.CADRE_NEW_NUM),0) CADRENEWNUM," );
	sql.append(" NVL(SUM(T.CADRE_THIRTY_NUM),0) CADRETHIRTYNUM," );
	sql.append(" NVL(SUM(T.CADRE_USIXTY_NUM),0) CADREUSIXTYNUM," );
	sql.append(" NVL(SUM(T.CADRE_SIXTY_NUM),0)  CADRESIXTYNUM," );
	sql.append(" NVL(SUM(T.CADRE_COLLEGE_NUM),0) CADRECOLLEGENUM," );
	sql.append(" NVL(SUM(T.CADRE_HIGHT_NUM),0)   CADREHIGHTNUM," );
	sql.append(" NVL(SUM(T.CADRE_ACROSS_NUM),0)  CADREACROSSNUM," );
	sql.append(" NVL(SUM(CASE WHEN T.IF_SIDELINE = '1' THEN 1 ELSE 0 END),0) IFSIDELINE," );
	sql.append(" NVL(SUM(CASE WHEN T.IF_GROUP = '1' THEN 1 ELSE 0 END),0) IFGROUP," );
	sql.append(" NVL(SUM(T.HEADMAN_NUM),0) HEADMANNUM," );
	sql.append(" NVL(SUM(CASE WHEN T.IF_DELEGATE = '1' THEN 1 ELSE 0 END ),0) IFDELEGATE," );
	sql.append(" NVL(SUM(T.DELEGATE_NUM),0) IFDELEGATE," );
	sql.append(" NVL(SUM(CASE WHEN T.IF_PUBLIC ='1' THEN 1 ELSE 0 END  ),0) IFPUBLIC," );
	sql.append(" NVL(SUM(CASE WHEN T.IF_FINANCE = '1' THEN 1 ELSE 0 END ),0) IFFINANCE," );
	sql.append(" NVL(SUM(CASE WHEN T.IF_UNDER ='1' THEN 1 ELSE 0 END ),0)IFUNDER," );
	sql.append(" NVL(SUM(T.CADRE_RESIDE_NUM),0) CADRERESIDENUM," );
	sql.append(" NVL(SUM(T.CADRE_ECONOMY_NUM),0) CADREECONOMYNUM," );
	sql.append(" NVL(SUM(T.CADRE_UNION_NUM),0) CADREUNIONNUM," );
	sql.append(" NVL(SUM(T.CADRE_BACK_NUM),0) CADREBACKNUM," );
	sql.append("  NVL(SUM(T.CADRE_DISPATCH_NUM),0) CADREDISPATCHNUM," );
	sql.append("  NVL(SUM(T.CADRE_GRAD_NUM),0) CADREGRADNUM," );
	sql.append("  NVL(SUM(T.CADRE_STUDENT_NUM),0) CADRESTUDENTNUM," );
	sql.append(" NVL(SUM(T.CADRE_RETIRE_NUM),0) CADRERETIRENUM " );
	sql.append("FROM CDC_ELECTION_COMMITTEE T  WHERE 1 = 1" );
	
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
   
}
