package com.inspur.cams.bpt.capital.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import com.inspur.cams.bpt.capital.dao.IBptCapitalSummaryDao;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;

/**
 * @title:BptCapitalSummaryDao
 * @description:
 * @author:
 * @since:2011-05-28
 * @version:1.0
 */
public class BptCapitalSummaryDao extends EntityDao<BptCapitalSummary>
		implements IBptCapitalSummaryDao {

	public BptCapitalSummaryDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return BptCapitalSummary.class;
	}



	/**
	 * 
	 * 查询时间段内抚恤金发放名册（总明细,TYPE为分类类型，包括伤残、三属，定期定量等各方面的抚恤金发放名册）
	 */
	public DataSet queryDataSet(ParameterSet pset) {

		StringBuffer sql = new StringBuffer();
				sql.append("SELECT REGISTER_ID,\n" );
		sql.append("       REGISTER_NAME,\n" ); 
		sql.append("       REGISTER_TYPE,\n" ); 
		sql.append("       ORGAN_CODE,\n" ); 
		sql.append("       RESPECTIVE_YEARS,\n" ); 
		sql.append("       GRANT_MON_SUM,\n" ); 
		sql.append("       GRANT_FLAG,\n" );
		sql.append("       GRANT_DATE,\n" );
		sql.append("       GRANT_SURE_DATE,\n" );
		sql.append("       FEEDBACK_NUMBER,---\n" ); 
		sql.append("       BUILD_DATE,---\n" );
		sql.append("       START_DATE,---\n" );
		sql.append("       END_DATE,----\n" ); 
		sql.append("       NOTE,\n" );
		sql.append("       REG_ID,\n"); 
		sql.append("       REG_TIME,\n");
		sql.append("       MOD_ID,\n"); 
		sql.append("       MOD_TIME\n"); 
		sql.append("  FROM BPT_CAPITAL_SUMMARY A\n"); 
		sql.append(" WHERE REGISTER_TYPE = ?");
		String regi_type=(String) pset.getParameter("registerType");
		String organCode = (String) pset.getParameter("organCode");
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		String userOrganCode = (String) pset.getParameter("userOrganCode");
		String args_organCode="";
		if (organCode == null || organCode.equals(""))
			organCode = userOrganCode;

		if (!organCode.substring(0, 2).equals("00")&& organCode.substring(3, 5).equals("00")) {// 省
			sql.append(" AND  SUBSTR(ORGAN_CODE,1,2)=? ");
			args_organCode=organCode.substring(0, 2);
		} else if (!organCode.substring(3, 5).equals("00")&& organCode.substring(5, 7).equals("00")) {// 市
			sql.append(" AND SUBSTR(ORGAN_CODE,1,4)=? ");
			args_organCode=organCode.substring(0, 4);
		} else {// 区县
			sql.append(" AND SUBSTR(ORGAN_CODE,1,6)=? ");
			args_organCode=organCode.substring(0, 6);
		}
		if (startDate != null && endDate != null) {
			sql.append(" AND GRANT_DATE >=? and GRANT_DATE<=? ");
		}
		sql.append(" ORDER BY A.ORGAN_CODE");
		int[] types={Types.CHAR,Types.CHAR,Types.CHAR,Types.CHAR};
		String[] args={regi_type,args_organCode,startDate,endDate};
		List list = (List) this.executeQuery(sql.toString(), types, args);//.executeQuery(sql.toString());
		ArrayList resultList = new ArrayList();
		for (int i = 0; i < list.size(); i++) {
			BptCapitalSummary ob = new BptCapitalSummary();
			HashMap m = (HashMap) list.get(i); //
			ob.setRegisterId((String) m.get("REGISTER_ID"));
			ob.setRegisterName((String) m.get("REGISTER_NAME"));
			ob.setRegisterType((String) m.get("REGISTER_TYPE"));
			ob.setOrganCode((String) m.get("ORGAN_CODE"));
			ob.setRespectiveYears((String) m.get("RESPECTIVE_YEARS"));
			ob.setGrantMonSum((BigDecimal) m.get("GRANT_MON_SUM"));
			ob.setGrantFlag((String) m.get("GRANT_FLAG"));
			ob.setGrantDate((String) m.get("GRANT_DATE"));
			ob.setGrantSureDate((String) m.get("GRANT_SURE_DATE"));
			ob.setFeedbackNumber((String)m.get("FEEDBACK_NUMBER"));
			ob.setBuildDate((String)m.get("BUILD_DATE"));
			ob.setStartDate((String)m.get("START_DATE"));
			ob.setEndDate((String)m.get("END_DATE"));
			ob.setNote((String) m.get("NOTE"));
			ob.setRegId((String) m.get("REG_ID"));
			ob.setRegTime((String) m.get("REG_TIME"));
			ob.setModId((String) m.get("MOD_ID"));
			ob.setModTime((String) m.get("MOD_TIME"));
			Record r = new Record(ob);
			resultList.add(r);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(resultList);
		ds.setTotalCount(resultList.size());
		return ds;
   }
	
	/**
	 * 查询经费发放信息
	 */
	public DataSet queryFundingGrant(ParameterSet pset){
		DataSet resultDataSet = new DataSet();
		String peopleId = pset.getParameter("peopleId").toString();
		String currentYear = pset.getParameter("currentYear").toString();
		StringBuffer sql = new StringBuffer();
	sql.append("SELECT S.REGISTER_TYPE,\n");
	sql.append("       D.OBJECT_TYPE,\n"); 
	sql.append("       S.GRANT_DATE,\n"); 
	sql.append("       S.START_DATE,\n"); 
	sql.append("       S.END_DATE,\n"); 
	sql.append("       D.GRANT_MON_SUM\n"); 
	sql.append("  FROM BPT_CAPITAL_DETAIL D, BPT_CAPITAL_SUMMARY S\n"); 
	sql.append(" WHERE D.REGISTER_ID = S.REGISTER_ID\n"); 
	sql.append("   AND D.PEOPLE_ID = ?\n");
	sql.append("	AND S.RESPECTIVE_YEARS = ?\n"); 
	sql.append("UNION ALL\n"); 
	sql.append("SELECT F.TYPE,\n"); 
	sql.append("       E.OBJECT_TYPE_CODE,\n"); 
	sql.append("       F.GRANT_DATE,\n"); 
	sql.append("       F.START_DATE,\n"); 
	sql.append("       F.END_DATE,\n"); 
	sql.append("       E.GRANT_MON_SUM\n"); 
	sql.append("  FROM BPT_COMPULSORY_DETAILS E, BPT_COMPULSORY_SUMMARY F\n"); 
	sql.append(" WHERE E.REGISTER_ID = F.REGISTER_ID\n"); 
	sql.append("   AND E.PEOPLE_ID = ?\n");
	sql.append("	AND F.RESPECTIVE_YEARS = ?\n");
	sql.append("UNION ALL\n"); 
	sql.append("SELECT '81' AS REGISTER_TYPE,\n");
	sql.append("       H.OBJECT_TYPE,\n"); 
	sql.append("       '' GRANT_DATE,\n"); 
	sql.append("       '' START_DATE,\n"); 
	sql.append("       '' END_DATE,\n"); 
	sql.append("       H.APPLY_MON AS GRANT_MON_SUM\n"); 
	sql.append("  FROM BPT_TEMPORARY_HELP H\n"); 
	sql.append(" WHERE H.PEOPLE_ID = ?\n"); 
	sql.append("   AND H.SUBMIT_FLAG = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{peopleId,currentYear,peopleId,currentYear,peopleId,1}, pset.getPageStart(), pset.getPageLimit(), true);
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				Record rd = ds.getRecord(i);
				rd.set("registerType",(String)rd.get("REGISTER_TYPE"));
				rd.set("objectType",(String)rd.get("OBJECT_TYPE"));
				rd.set("grantDate",(String)rd.get("GRANT_DATE"));
				rd.set("startDate",(String)rd.get("START_DATE"));
				rd.set("endDate",(String)rd.get("END_DATE"));
				rd.set("grantMonSum",rd.get("GRANT_MON_SUM")==null||rd.get("GRANT_MON_SUM").equals("")?"0.0":rd.get("GRANT_MON_SUM").toString());
				resultDataSet.addRecord(rd);
			}
		}
		return resultDataSet;
	}
	
	/**
	 * 返回所属机构名称
	 * @param pset
	 * @return
	 */
	public DataSet getCounties(ParameterSet pset){
		String counties =(String) pset.getParameter("counties");
		String sql ="select organ_name from pub_organ t where t.organ_code=?";
		return this.executeDataset(sql, new int[]{Types.VARCHAR}, new Object[]{counties}, true);
	}
	
	/**
	 * 修改优抚资金发放汇总
	 */
	public void updateSummary(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId");
		StringBuffer sql = new StringBuffer();
	sql.append("UPDATE BPT_CAPITAL_SUMMARY S\n");
	sql.append("   SET S.GRANT_MON_SUM =\n"); 
	sql.append("       (SELECT SUM(D.GRANT_MON_SUM)\n"); 
	sql.append("          FROM BPT_CAPITAL_DETAIL D\n"); 
	sql.append("         WHERE D.REGISTER_ID = ?)\n"); 
	sql.append(" WHERE S.REGISTER_ID = ?");
		this.executeUpdate(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{registerId,registerId});
	}

}
