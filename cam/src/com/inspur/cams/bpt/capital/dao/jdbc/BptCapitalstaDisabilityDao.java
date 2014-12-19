package com.inspur.cams.bpt.capital.dao.jdbc;

import java.sql.Types;
import java.util.*;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;

import com.inspur.cams.bpt.capital.dao.IBptCapitalstaDisabilityDao;
import com.inspur.cams.bpt.capital.data.BptCapitalstaDisability;



/**
 * @title:BptCapitalstaDisabilityDao
 * @description:
 * @author:
 * @since:2011-05-23
 * @version:1.0
 */
public class BptCapitalstaDisabilityDao extends
		EntityDao<BptCapitalstaDisability> implements
		IBptCapitalstaDisabilityDao {

	public BptCapitalstaDisabilityDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return BptCapitalstaDisability.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from BptCapitalstaDisability");
	}
    
	/**
	 * 
	 * 资金管理(批量显示,生效日期起，生效日期止，录入人，录入时间)
	 */
	public DataSet queryDataSet() {
		String sql = "SELECT DISTINCT START_DATE,END_DATE,REG_ID,SUBSTR(REG_TIME,1,10) REG_TIME, STANDARDS_COUNTIES FROM BPT_CAPITALSTA_DISABILITY WHERE STANDARDS_COUNTIES='1' ORDER BY START_DATE";
		return this.executeDataset(sql, true);
	}
    
	/**
	 * 
	 * 资金管理(增加操作)
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryStr(String counties,String date) {
		StringBuffer sql = new StringBuffer();
			sql.append("select e.id,'1' object_type,d.disabilityLevelCode,d.disabilityNature,nvl(e.newmoon_standards,0) as spotStandards,");
				sql.append( "d.newmoonStandards,e.end_date as startDate,d.endDate from (select '1' as standardscounties,a.code as disabilityLevelCode,");
				sql.append( "b.code as disabilityNature,'0' as spotStandards,'0' as newmoonStandards,? as startDate,'2011-06-06' as endDate");
				sql.append( " from dic_disability_level a, dic_disability_case b) d left join");
				sql.append( "(select c.id,c.object_type,c.standards_counties,c.disability_level_code,c.disability_nature,c.newmoon_standards,c.end_date");
				sql.append( "  from bpt_capitalsta_disability c where (select max(end_date)from bpt_capitalsta_disability c where c.standards_counties =?) >= start_date");
				sql.append( " and (select max(end_date)from bpt_capitalsta_disability c where c.standards_counties = ?) <= end_date) e on d.standardscounties = e.standards_counties");
				sql.append( " and d.disabilitylevelcode = e.disability_level_code and d.disabilityNature = e.disability_nature");
				sql.append( " order by d.disabilityLevelCode, d.disabilityNature");

		List list = (List) this.executeQuery(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{date,counties,counties});

		ArrayList newList = new ArrayList();
		//BeanUtils.populate();
		for (int i = 0; i < list.size(); i++) {
			BptCapitalstaDisability ob = new BptCapitalstaDisability();

			HashMap m = (HashMap) list.get(i); //
			ob.setId((String) m.get("ID"));
			ob.setObjectType((String) m.get("OBJECT_TYPE"));
			ob.setDisabilityLevelCode((String) m.get("DISABILITYLEVELCODE"));
			ob.setDisabilityNature(String.valueOf(m.get("DISABILITYNATURE")));
			ob.setSpotStandards(String.valueOf(m.get("SPOTSTANDARDS")));
			ob.setNewmoonStandards(m.get("NEWMOONSTANDARDS").toString());
			ob.setStartDate((String) m.get("STARTDATE"));
			ob.setEndDate((String) m.get("ENDDATE"));
			Record r = new Record(ob);
			newList.add(r);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(newList);
		ds.setTotalCount(newList.size());
		return ds;

	}
	
	/**
	 * 
	 * 资金管理批量删除
	 */
	public void deleteBatch(String counties,String start,String end){
		String sql ="DELETE FROM  BPT_CAPITALSTA_DISABILITY WHERE STANDARDS_COUNTIES=? AND START_DATE=? AND END_DATE=?";
	    this.executeUpdate(sql,new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{counties,start,end});
	}

}
