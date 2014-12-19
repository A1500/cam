package com.inspur.cams.bpt.capital.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.capital.dao.IBptCompulsorySummaryDao;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;
/**
 * @title:BptCompulsorySummaryDao
 * @description: 优待金发放汇总 Dao 层
 * @author:
 * @since:2011-06-07
 * @version:1.0
 */
public class BptCompulsorySummaryDao extends EntityDao<BptCompulsorySummary>
		implements IBptCompulsorySummaryDao {

	public BptCompulsorySummaryDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return BptCompulsorySummary.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from BptCompulsorySummary");
	}

	public void deleteRegisterId(ParameterSet param) {
		String sql ="DELETE FROM BPT_COMPULSORY_DETAILS WHERE REGISTER_ID='"+param.getParameter("delId")+"'";
		this.executeUpdate(sql);
	}
	
	/**
	 * 查询除义务兵家庭外其他优抚对象优待金发放汇总
	 */
	public DataSet queryCompulsorySummary(ParameterSet pset){
		DataSet tempDs = new DataSet();
		DataSet resultDs = new DataSet();
		String organCode = pset.getParameter("organCode").toString();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT S.REGISTER_ID, S.REGISTER_NAME, S.TYPE, S.RESPECTIVE_YEARS,\n");
		sql.append("       S.GRANT_UNIT, S.START_DATE, S.END_DATE, S.GRANT_MON,\n"); 
		sql.append("       S.FEEDBACK_NUMBER, S.GRANT_FLAG, S.GRANT_DATE, S.GRANT_SURE_DATE,\n"); 
		sql.append("       S.NOTE, S.REG_ID, S.REG_TIME, S.MOD_ID, S.MOD_TIME, C.NAME\n"); 
		sql.append("  FROM BPT_COMPULSORY_SUMMARY S, DIC_CITY C\n"); 
		sql.append(" WHERE S.GRANT_UNIT = C.ID");

		if (pset.getParameter("grantUnit") != null && !pset.getParameter("grantUnit").equals("")) {
			String grantUnit = pset.getParameter("grantUnit").toString();
			if (!grantUnit.substring(0, 2).equals("00") && grantUnit.substring(2, 4).equals("00")) {
				sql.append(" AND  SUBSTR(S.GRANT_UNIT,1,2)= ? ");// 省局
				grantUnit = grantUnit.substring(0, 2);
				typeList.add(Types.VARCHAR);
				argsList.add(grantUnit);
			}else if(!grantUnit.substring(2, 4).equals("00")&&grantUnit.substring(4, 6).equals("00")){
				sql.append(" AND SUBSTR(S.GRANT_UNIT,1,4)= ? ");//市局
				grantUnit = grantUnit.substring(0, 4);
				typeList.add(Types.VARCHAR);
				argsList.add(grantUnit);
			}else{
				sql.append(" AND SUBSTR(S.GRANT_UNIT,1,6)= ? ");//区县
				grantUnit = grantUnit.substring(0, 6);
				typeList.add(Types.VARCHAR);
				argsList.add(grantUnit);
			}
		}else{
			if (!organCode.substring(0, 2).equals("00") && organCode.substring(2, 4).equals("00")) {
				sql.append(" AND  SUBSTR(S.GRANT_UNIT,1,2)= ? ");// 省局
				organCode = organCode.substring(0, 2);
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}else if(!organCode.substring(2, 4).equals("00")&&organCode.substring(4, 6).equals("00")){
				sql.append(" AND SUBSTR(S.GRANT_UNIT,1,4)= ? ");//市局
				organCode = organCode.substring(0, 4);
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}else{
				sql.append(" AND SUBSTR(S.GRANT_UNIT,1,6)= ? ");//区县
				organCode = organCode.substring(0, 6);
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
		}
		//是否存在所属年度
		if(pset.getParameter("respectiveYears") != null && !pset.getParameter("respectiveYears").equals("")){
			String respectiveYears = pset.getParameter("respectiveYears").toString();
			sql.append("AND S.RESPECTIVE_YEARS = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(respectiveYears);
		}
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			tempDs = this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),true);
		}else{
			tempDs = this.executeDataset(sql.toString(),pset.getPageStart(),pset.getPageLimit(),true);
		}
		if(tempDs.getCount()>0){
			for(int i=0;i<tempDs.getCount();i++){
				Record rd = tempDs.getRecord(i);
				rd.set("registerId",(String)rd.get("REGISTER_ID"));
				rd.set("registerName",(String)rd.get("REGISTER_NAME"));
				rd.set("type",(String)rd.get("TYPE"));
				rd.set("respectiveYears",(String)rd.get("RESPECTIVE_YEARS"));
				rd.set("grantUnit",(String)rd.get("GRANT_UNIT"));
				rd.set("startDate",(String)rd.get("START_DATE"));
				rd.set("endDate",(String)rd.get("END_DATE"));
				rd.set("grantMon",rd.get("GRANT_MON")==null||rd.get("GRANT_MON").equals("")?"0.0":rd.get("GRANT_MON").toString());
				rd.set("feedbackNumber",(String)rd.get("FEEDBACK_NUMBER"));
				rd.set("grantFlag",(String)rd.get("GRANT_FLAG"));
				rd.set("grantDate",(String)rd.get("GRANT_DATE"));
				rd.set("grantSureDate",(String)rd.get("GRANT_SURE_DATE"));
				rd.set("note",(String)rd.get("NOTE"));
				rd.set("regId",(String)rd.get("REG_ID"));
				rd.set("regTime",(String)rd.get("REG_TIME"));
				rd.set("modId",(String)rd.get("MOD_ID"));
				rd.set("modTime",(String)rd.get("MOD_TIME"));
				rd.set("name",(String)rd.get("NAME"));
				resultDs.addRecord(rd);
			}
		}
		return resultDs;
	}
	
	/**
	 * 修改优待金总额
	 */
	public void updateNonCompuSumm(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId");
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE BPT_COMPULSORY_SUMMARY \n");
		sql.append("   SET GRANT_MON =  (SELECT SUM(GRANT_MON_SUM) \n"); 
		sql.append("                        FROM BPT_COMPULSORY_DETAILS \n"); 
		sql.append("                       WHERE REGISTER_ID = ?) \n"); 
		sql.append(" WHERE REGISTER_ID = ?");

		this.executeUpdate(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{registerId,registerId});
	}
}
