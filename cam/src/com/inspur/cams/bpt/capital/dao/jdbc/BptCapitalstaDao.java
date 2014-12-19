package com.inspur.cams.bpt.capital.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.capital.dao.IBptCapitalstaDao;
import com.inspur.cams.bpt.capital.data.BptCapitalsta;

/**
 * @title:资金发放标准 Dao 层
 * @description:资金发放标准 Dao 层
 */
public class BptCapitalstaDao extends
		EntityDao<BptCapitalsta> implements
		IBptCapitalstaDao {

	public BptCapitalstaDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<BptCapitalsta> getEntityClass() {
		return BptCapitalsta.class;
	}

	
    
	/**
	 * 标准列表查询
	 */
	public DataSet queryDataSet(ParameterSet pset) {
		String counties= (String) pset.getParameter("counties");
		String type= (String) pset.getParameter("type");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT DISTINCT P.START_DATE,\n" );
		sql.append("                P.END_DATE,\n" ); 
		sql.append("                P.REG_ID,\n" ); 
		sql.append("                SUBSTR(P.REG_TIME, 1, 10) REG_TIME,\n" ); 
		sql.append("                T.ORGAN_NAME STANDARDS_COUNTIES,\n" ); 
		sql.append("                P.STANDARDS_COUNTIES STANDARDS_CODE\n" ); 
		sql.append("  FROM BPT_CAPITAL_STA P, PUB_ORGAN T\n" ); 
		sql.append(" WHERE P.STANDARDS_COUNTIES = T.ORGAN_CODE\n" ); 
		sql.append("   AND P.TYPE = ?\n" ); 
		sql.append("   AND P.STANDARDS_COUNTIES = ?\n" ); 
		sql.append(" ORDER BY P.START_DATE");
	    return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{type,counties},true);
	}
	
	/**
	 * 查询最大的标准开始日期
	 */
	public String querynewestStartDate(ParameterSet pset){
		String newestStartDate = "";
		String type = (String)pset.getParameter("TYPE");
		String standardsCounties = (String)pset.getParameter("STANDARDS_COUNTIES");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT DISTINCT MAX(P.START_DATE) AS START_DATE\n" );
		sql.append("  FROM BPT_CAPITAL_STA P\n" ); 
		sql.append(" WHERE P.TYPE = ?\n" ); 
		sql.append("   AND P.STANDARDS_COUNTIES = ?");
		DataSet ds = executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{type,standardsCounties}, true);
		if(ds.getCount()>0){
			newestStartDate = (String)ds.getRecord(0).get("START_DATE");
		}
		return newestStartDate;
	}
	
	/**
	 * 删除资金标准
	 */
	public void deleteStandard(ParameterSet pset){
		String counties = (String) pset.getParameter("countie");
		String start = (String) pset.getParameter("start");
		String type = (String) pset.getParameter("type");
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM BPT_CAPITAL_STA T\n" );
		sql.append(" WHERE T.STANDARDS_COUNTIES = ?\n" ); 
		sql.append("   AND T.START_DATE = ?\n" ); 
		sql.append("   AND T.TYPE = ? ");
		this.executeUpdate(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{counties,start,type});
	}
	
	/**
	 * 资金管理批量删除
	 */
	public void deleteBatch(ParameterSet pset){
		StringBuffer sql =new StringBuffer("DELETE FROM  BPT_CAPITAL_STA ");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> argsList = new ArrayList<String>();
		
		String counties = (String) pset.getParameter("countie");
		String start = (String) pset.getParameter("start");
		String type = (String) pset.getParameter("type");
		
		if(counties != null &&!counties.equals("")){
			sql.append(" WHERE STANDARDS_COUNTIES= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(counties);
		}
		if(start != null &&!start.equals("")){
			sql.append(" AND START_DATE=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(start);
		}
		if(type != null &&!type.equals("")){
			sql.append(" AND TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(type);
		}
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			this.executeUpdate(sql.toString(), types, args);
		}else{
			this.executeUpdate(sql.toString());
		}
	}
    
	/**
	 * 返回前一天
	 * @param startDate
	 */
	public List getBeforeDate(String startDate){
		String start_Date = startDate;
		String sql = "SELECT TO_CHAR(TO_DATE(?,'YYYY-MM-DD')-1,'YYYY-MM-DD') BEFOREDATE FROM DUAL";
		return this.executeQuery(sql,new int[]{Types.VARCHAR},new Object[]{start_Date});
	}
	/**
	 * 返回当前行政区划最大开始时间的数据集
	 * @param pset
	 */
	public DataSet queryDs(ParameterSet pset){
		String organId=(String) pset.getParameter("organId");
		String type=(String) pset.getParameter("type");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.ID, T.START_DATE\n" );
		sql.append("  FROM BPT_CAPITAL_STA T\n" ); 
		sql.append(" WHERE T.START_DATE =\n" ); 
		sql.append("       (SELECT MAX(START_DATE) STARTDATE\n" ); 
		sql.append("          FROM BPT_CAPITAL_STA P\n" ); 
		sql.append("         WHERE P.STANDARDS_COUNTIES = ?\n" ); 
		sql.append("           AND P.TYPE = ? )\n" ); 
		sql.append("   AND T.STANDARDS_COUNTIES = ?\n" ); 
		sql.append("   AND T.TYPE = ? ");
		return this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{organId,type,organId,type}, true);
	}
	
	/**
	 * 返回当前行政区划最大开始时间的数据集
	 * @param pset
	 * @return
	 */
	public DataSet queryDsOther(ParameterSet pset){
		String organId=(String) pset.getParameter("organId");
		String type=(String) pset.getParameter("type");
		
		String sql ="select t.id,t.start_date from bpt_capital_sta t where t.start_date=(select max(start_date) startdate from bpt_capital_sta where standards_counties = ? and type=?)";
		return this.executeDataset(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{organId,type}, true);
	}
	
	/**
	 * 将最后一批的结束日期更新为将要保存的开始日期的前一天
	 * @param pset
	 */
	public void udpateEndDate(ParameterSet pset){
		String end_date= (String) pset.getParameter("endDate");
		String id = (String) pset.getParameter("id");
		String sql ="update BPT_CAPITAL_STA t set t.end_date=? where t.id=?";
		this.executeUpdate(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{end_date,id});
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
	 * 最回PUB_ORGAN中的人
	 * @param pset
	 * @return
	 */
	public DataSet getPerson(ParameterSet pset){
		String personNo =(String) pset.getParameter("personNo");
		String sql ="select organ_name from pub_organ t where t.organ_id=?";
		return this.executeDataset(sql, new int[]{Types.VARCHAR}, new Object[]{personNo}, true);
	}
	
	/**
	 * 返回最大日期
	 * @param pset
	 * @return
	 */
	public DataSet getMaxDate(ParameterSet pset){
		String type=(String) pset.getParameter("type");
		String organCode=(String) pset.getParameter("organCode");
		String sql ="select distinct max(c.start_date) start_date from BPT_CAPITAL_STA c where c.type=? and c.standards_counties=?";
		return this.executeDataset(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{type,organCode}, true);
	}
	
}
