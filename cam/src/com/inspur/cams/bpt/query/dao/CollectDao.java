package com.inspur.cams.bpt.query.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Procedure;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.PubUtils;

@SuppressWarnings("unchecked")
public class CollectDao extends BaseJdbcDao {

    public CollectDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }


    @Override
    protected void initDao() {

    }
    
    public DataSet queryTotal(ParameterSet pset){
    	DataSet ds = new DataSet();
    	List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
 		String type = (String) pset.getParameter("type");
 		String organCode = (String) pset.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR, TYPE from bpt_collect t, dic_city c where t.ORGAN_CODE=c.id  \n");
		
		if (type != null && !type.equals("")) {
			sql.append(" and t.type =?");
			typeList.add(Types.VARCHAR);
			argsList.add(type);
		}
		if (organCode != null && !organCode.equals("")) {
			sql.append(" and t.organ_code=?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
		} 
		return ds;
 	}
    
    public DataSet queryMap(ParameterSet pset){
    	DataSet ds = new DataSet();
    	List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
 		String type = (String) pset.getParameter("type");
 		String organCode = (String) pset.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR, TYPE from bpt_collect t, dic_city c where t.ORGAN_CODE=c.id  \n");
		sql.append("and substr(t.organ_code,5,8)='00000000'and substr(t.organ_code,3,2)!='00' ");
		if (type != null && !type.equals("")) {
			sql.append(" and t.type =?");
			typeList.add(Types.VARCHAR);
			argsList.add(type);
		}
		
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
		} 
		return ds;
 	}
    
    public DataSet queryAllProvince(){
    	DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR, TYPE from bpt_collect t, dic_city c where t.ORGAN_CODE=c.id  \n");
		sql.append("and substr(t.organ_code,5,8)='00000000' and type='A' order by ORGAN_CODE");
		ds = this.executeDataset(sql.toString(), true);
		return ds;
 	}
}
