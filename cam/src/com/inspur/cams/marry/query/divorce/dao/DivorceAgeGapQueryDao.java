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
public class DivorceAgeGapQueryDao extends BaseJdbcDao {

    public DivorceAgeGapQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_RPT_DIVORCE_AGE_GAP");
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
                    record.set("SEX_NAME", rs.getString("SEX_NAME"));
                    record.set("TOTAL_NUM",getNum(rs.getString("TOTAL_NUM")));
                    record.set("GAP0_NUM", getNum(rs.getString("GAP0_NUM")));
                    record.set("GAP0_RATE", getPercent(rs.getString("GAP0_RATE")));
                    record.set("GAP1_NUM", getNum(rs.getString("GAP1_NUM")));
                    record.set("GAP1_RATE", getPercent(rs.getString("GAP1_RATE")));
                    record.set("GAP2_NUM", getNum(rs.getString("GAP2_NUM")));
                    record.set("GAP2_RATE", getPercent(rs.getString("GAP2_RATE")));
                    record.set("GAP3_NUM", getNum(rs.getString("GAP3_NUM")));
                    record.set("GAP3_RATE", getPercent(rs.getString("GAP3_RATE")));
                    record.set("GAP4_NUM", getNum(rs.getString("GAP4_NUM")));
                    record.set("GAP4_RATE", getPercent(rs.getString("GAP4_RATE")));
                    record.set("GAP5_9_NUM", getNum(rs.getString("GAP5_9_NUM")));
                    record.set("GAP5_9_RATE", getPercent(rs.getString("GAP5_9_RATE")));
                    record.set("GAP10_14_NUM", getNum(rs.getString("GAP10_14_NUM")));
                    record.set("GAP10_14_RATE", getPercent(rs.getString("GAP10_14_RATE")));
                    record.set("GAP15_19_NUM", getNum(rs.getString("GAP15_19_NUM")));
                    record.set("GAP15_19_RATE",getPercent( rs.getString("GAP15_19_RATE")));
                    record.set("GAP20_29_NUM", getNum(rs.getString("GAP20_29_NUM")));
                    record.set("GAP20_29_RATE", getPercent(rs.getString("GAP20_29_RATE")));
                    record.set("GAP30_NUM", getNum(rs.getString("GAP30_NUM")));
                    record.set("GAP30_RATE",getPercent( rs.getString("GAP30_RATE")));
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
   
   private static String getNum(String num){
	   if(num==null){
		   return "0";
	   }
	   int value = Integer.parseInt(num);
	   String returnValue =StrUtil.formatNum(value,"###,##0");
	   return returnValue;
   }
   
   
}
