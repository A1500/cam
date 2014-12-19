package com.inspur.cams.marry.query.papers.dao;

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
import com.inspur.cams.comm.util.StrUtil;
/**
 * 婚姻登记员统计分析
 *
 */
@SuppressWarnings("unchecked")
public class MarryRegistrarQueryDao extends BaseJdbcDao {

    public MarryRegistrarQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_ORGAN_QUERY");
            // 声明参数
            declareParameter(new SqlParameter("p_CITY_CODE", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }
        public Map call(String xzqh) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("p_CITY_CODE", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                    record.set("TOTAL_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("TOTAL_NUM"))));
                    record.set("XZ", StrUtil.formatInt(Integer.parseInt(rs.getString("XZ"))));
                    record.set("CGGL", StrUtil.formatInt(Integer.parseInt(rs.getString("CGGL"))));
                    record.set("QESYB", StrUtil.formatInt(Integer.parseInt(rs.getString("QESYB"))));
                    //new
                    record.set("CHU", StrUtil.formatInt(Integer.parseInt(rs.getString("CHU"))));
                    record.set("KE", StrUtil.formatInt(Integer.parseInt(rs.getString("KE"))));
                    record.set("FUKE", StrUtil.formatInt(Integer.parseInt(rs.getString("FUKE"))));
                    record.set("GUJI", StrUtil.formatInt(Integer.parseInt(rs.getString("GUJI"))));
                   record.set("AREA", StrUtil.changeTwoDecimal(rs.getString("AREA")));
                   
                    record.set("NULLA", StrUtil.formatInt(Integer.parseInt(rs.getString("NULLA"))));
                    record.set("THREEA", StrUtil.formatInt(Integer.parseInt(rs.getString("THREEA"))));
                    record.set("FOURA", StrUtil.formatInt(Integer.parseInt(rs.getString("FOURA"))));
                    record.set("FIVEA", StrUtil.formatInt(Integer.parseInt(rs.getString("FIVEA"))));
                    
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
        object = procduce.call(xzqu).get("results");
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

    }
    
    private static String getPercent(String num){
  	   if(num==null){
  		   return "0.00";
  	   }
      	float value = Float.parseFloat(num);
      	String returnValue =StrUtil.formatNum(value,"##0.00");
      	return returnValue;
      }
}
