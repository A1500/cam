package com.inspur.cams.marry.query.marry.dao;

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
public class MarryStatusQueryDao extends BaseJdbcDao {

    public MarryStatusQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_RPT_MARRY_STATUS");
            // 声明参数
            declareParameter(new SqlParameter("p_SUM_DATE_start", Types.VARCHAR));
            declareParameter(new SqlParameter("p_SUM_DATE_end", Types.VARCHAR));
            declareParameter(new SqlParameter("p_CITY_CODE", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String cxsj_q,String cxsj_z, String xzqh) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("p_SUM_DATE_start", cxsj_q);
            in.put("p_SUM_DATE_end", cxsj_z);
            in.put("p_CITY_CODE", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                  
                    record.set("ITEM_CODE", rs.getString("ITEM_CODE"));
                    record.set("ITEM_NAME", rs.getString("ITEM_NAME"));
 
                    record.set("MARRY_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("MARRY_NUM"))));
                    record.set("NEW_MARRY_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("NEW_MARRY_NUM"))));
                    record.set("NEW_MARRY_RATE", getPercent(rs.getString("NEW_MARRY_RATE")));
                    record.set("NEW_MARRY_MAN_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("NEW_MARRY_MAN_NUM"))));
                    record.set("NEW_MARRY_WOMAN_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("NEW_MARRY_WOMAN_NUM"))));
                    record.set("REMARRY_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("REMARRY_NUM"))));
                    record.set("REMARRY_RATE",getPercent(rs.getString("REMARRY_RATE")));
                    record.set("REMARRY_MAN_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("REMARRY_MAN_NUM"))));
                    record.set("REMARRY_WOMAN_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("REMARRY_WOMAN_NUM"))));
                    record.set("RENEW_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("RENEW_NUM"))));
                    record.set("RENEW_RATE", getPercent(rs.getString("RENEW_RATE")));
                    
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
