package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcElectionProgramDao;
import com.inspur.cams.cdc.base.data.CdcElectionProgram;

/**
 * 民主选举选举程序信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcElectionProgramDao extends EntityDao<CdcElectionProgram> implements ICdcElectionProgramDao {
	
	@Override
	public Class<CdcElectionProgram> getEntityClass() {
		return CdcElectionProgram.class;
	}

	public DataSet querySum(ParameterSet pset) {
		String reportDate = (String) pset.getParameter("reportDate");
		String organCode = (String) pset.getParameter("ORGAN_CODE");
		String reportType = (String) pset.getParameter("REPORT_TYPE");
		List<Object> argList = new ArrayList<Object>();
		List<Integer> typeList = new ArrayList<Integer>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT NVL(SUM(CASE WHEN T.IF_MEETING = '1' THEN 1 ELSE 0 END),0) IFMEETING,");
		sql.append("NVL(SUM(CASE WHEN T.IF_STATION = '1' THEN 1 ELSE 0 END),0) IFSTATION,");
		sql.append("NVL(SUM(CASE WHEN T.IF_SECRET = '1' THEN 1 ELSE 0 END),0) IFSECRET,");
		sql.append("NVL(SUM(CASE WHEN T.IF_FLOW = '1' THEN 1 ELSE 0 END),0)  IFFLOW,");
		sql.append("NVL(SUM(CASE WHEN T.IF_PUBLIC = '1' THEN 1 ELSE 0 END ),0) IFPUBLIC ,");
		sql.append("NVL(SUM(CASE WHEN T.IF_PUBLIC_RESULT = '1' THEN 1 ELSE 0 END ),0) IFPUBLICRESULT ");
		sql.append(" FROM CDC_ELECTION_PROGRAM T  WHERE 1 = 1 ");
		if(reportDate!=null &&!("".equals(reportDate))){
			sql.append(" AND T.REPORT_DATE = ? ");
			argList.add(reportDate);
			typeList.add(Types.VARCHAR);
		}
		if(organCode!=null &&!("".equals(organCode))){
			sql.append(" AND T.ORGAN_CODE LIKE ? ");
			argList.add(organCode+"%");
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