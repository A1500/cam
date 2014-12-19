package com.inspur.cams.marry.query.divorce.dao;

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

@SuppressWarnings("unchecked")
public class MrmJobQueryDao extends BaseJdbcDao {

    public MrmJobQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_RPT_MARRY_JOB");
            // 声明参数
            declareParameter(new SqlParameter("p_SUM_DATE_q", Types.VARCHAR));
            declareParameter(new SqlParameter("p_SUM_DATE_z", Types.VARCHAR));
            declareParameter(new SqlParameter("p_CITY_CODE", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String cxsj_q,String cxsj_z, String xzqh) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("p_SUM_DATE_q", cxsj_q);
            in.put("p_SUM_DATE_z", cxsj_z);
            in.put("p_CITY_CODE", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ITEM_CODE", rs.getString("ITEM_CODE"));
                    record.set("ITEM_NAME", rs.getString("ITEM_NAME"));
                    record.set("TOTAL_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("TOTAL_NUM"))));
                    record.set("JOB0_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB0_NUM"))));
                    record.set("JOB0_RATE", getPercent(rs.getString("JOB0_RATE")));
                    record.set("JOB1_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB1_NUM"))));
                    record.set("JOB1_RATE", getPercent(rs.getString("JOB1_RATE")));
                    record.set("JOB2_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB2_NUM"))));
                    record.set("JOB2_RATE", getPercent(rs.getString("JOB2_RATE")));
                    record.set("JOB3_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB3_NUM"))));
                    record.set("JOB3_RATE",getPercent(rs.getString("JOB3_RATE")));
                    record.set("JOB4_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB4_NUM"))));
                    record.set("JOB4_RATE",getPercent(rs.getString("JOB4_RATE")));
                    record.set("JOB5_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB5_NUM"))));
                    record.set("JOB5_RATE",getPercent(rs.getString("JOB5_RATE")));
                    record.set("JOB6_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB6_NUM"))));
                    record.set("JOB6_RATE", getPercent(rs.getString("JOB6_RATE")));
                    record.set("JOB7_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB7_NUM"))));
                    record.set("JOB7_RATE",getPercent(rs.getString("JOB7_RATE")));
                    record.set("JOB8_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JOB8_NUM"))));
                    record.set("JOB8_RATE", getPercent(rs.getString("JOB8_RATE")));
                    
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
        String cxsj_q = (String) pset.getParameter("cxsjq");// 查询时间
        String cxsj_z = (String) pset.getParameter("cxsjz");// 查询时间
        object = procduce.call(cxsj_q,cxsj_z,xzqu).get("results");
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
      	String returnValue =StrUtil.formatNum(value*100,"##0.00");
      	return returnValue;
      } 
}
