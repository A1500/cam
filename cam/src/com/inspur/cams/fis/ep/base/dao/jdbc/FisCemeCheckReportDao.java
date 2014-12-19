package com.inspur.cams.fis.ep.base.dao.jdbc;

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


/**
 * @title:FisCemeCheckScoreDao
 * @description:
 * @author:
 * @since:2011-12-14
 * @version:1.0
*/
@SuppressWarnings("unchecked")
 public class FisCemeCheckReportDao extends BaseJdbcDao{

	 public FisCemeCheckReportDao() {
	        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
	    }

	    private static class Proc extends Procedure {

	        public Proc(DataSource ds) {

	            super(ds, "FIS_QUERY_CEME_CHECK");
	            // 声明参数
	            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
	            declareParameter(new SqlParameter("in_year", Types.VARCHAR));
	            declareParameter(new SqlParameter("in_xz", Types.VARCHAR));
	            // 声明结果集的个数
	            setNumberOfResultSet(1);
	            compile();
	        }

	        public Map call(String xzqh, String year, String xz) {
	            Map in = new HashMap();
	            // 设置入参的值，key要和声明参数的名称一致
	            in.put("in_xzqh", xzqh);
	            in.put("in_year", year);
	            in.put("in_xz", xz);
	            ResultReader resultReader = new ResultReaderImpl() {
	                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
	                    Record record = new Record();
	                    record.set("CITYNAME", rs.getString("CITYNAME"));
	                    record.set("CITYCODE", rs.getString("CITYCODE"));
	                    
	                    record.set("IFSUM", rs.getString("IFSUM"));
	                    record.set("TOTALNUM", rs.getString("TOTALNUM"));
	                    record.set("TOTALCHECKNUM", rs.getString("TOTALCHECKNUM"));
	                    
	                    record.set("UNDOCHECKNUM", rs.getString("UNDOCHECKNUM"));
	                    record.set("PASSNUM", rs.getString("PASSNUM"));
	                    record.set("NOTPASSNUM", rs.getString("NOTPASSNUM"));
	                    
	                    record.set("FIRSTNOTPASSNUM", rs.getString("FIRSTNOTPASSNUM"));
	                    record.set("FIRPASSNUM", rs.getString("FIRPASSNUM"));
	                    record.set("FIRNOTPASSNUM", rs.getString("FIRNOTPASSNUM"));
	                    
	                    record.set("SECPASSNUM", rs.getString("SECPASSNUM"));
	                    record.set("SECNOTPASSNUM", rs.getString("SECNOTPASSNUM"));
	                    record.set("PASSPER", rs.getString("PASSPER"));
	                    record.set("FIRPASSPER", rs.getString("FIRPASSPER"));
	                    record.set("SECPASSPER", rs.getString("SECPASSPER"));
	                    return record;
	                }
	            };
	            ResultReader[] readerA = new ResultReader[] { resultReader };

	            Map ret = execute(in, readerA);
	            ret.put("results", resultReader.getResults());
	            return ret;
	        }
	    }

	    private Proc procduce = null;

	    protected void init() {
	        if (procduce == null) {
	            procduce = new Proc(getDataSource());
	        }
	    }

	    public DataSet getDataSet(ParameterSet pset) {
	        init();
	        DataSet set = new DataSet();
	        List results = null;
	        Object object = null;
	        String xzqu = (String) pset.getParameter("xzqu");// 行政区划
	        String year = (String) pset.getParameter("year");// 查询年份
	        String xz = (String) pset.getParameter("xz");// 公墓性质
	        object = procduce.call(xzqu,year,xz).get("results");
	        if (object instanceof ArrayList) {
	            results = (List) object;
	            for (Object o : results) {
	                set.add((Record) o);
	            }
	        }
	        return set;
	    }
	    
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}

   
}
