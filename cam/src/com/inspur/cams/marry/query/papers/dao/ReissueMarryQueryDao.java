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
 * 补领、撤销统计
 *
 */
@SuppressWarnings("unchecked")
public class ReissueMarryQueryDao extends BaseJdbcDao {

    public ReissueMarryQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_RPT_REISSUE_MARRIAGE");
            // 声明参数
            declareParameter(new SqlParameter("P_SUM_DATE_Q", Types.VARCHAR));
            declareParameter(new SqlParameter("P_SUM_DATE_Z", Types.VARCHAR));
            declareParameter(new SqlParameter("p_CITY_CODE", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String cxsj_q,String cxsj_z, String xzqh) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("P_SUM_DATE_Q", cxsj_q);
            in.put("P_SUM_DATE_Z", cxsj_z);
            in.put("p_CITY_CODE", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ITEM_CODE", rs.getString("ITEM_CODE"));
                    record.set("ITEM_NAME", rs.getString("ITEM_NAME"));
                    record.set("TOTAL_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("TOTAL_NUM"))));
                    record.set("TOTAL_ENTRUST_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("TOTAL_ENTRUST_NUM"))));
                    record.set("LOCAL_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LOCAL_NUM"))));
                    record.set("LOCAL_NUM_RATE", getPercent(rs.getString("LOCAL_NUM_RATE")));
                    record.set("LOCAL_ENTRUST_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LOCAL_ENTRUST_NUM"))));
                    record.set("ALLOPATRY_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("ALLOPATRY_NUM"))));
                    record.set("ALLOPATRY_NUM_RATE", getPercent(rs.getString("ALLOPATRY_NUM_RATE")));
                    record.set("ALLOPATRY_ENTRUST_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("ALLOPATRY_ENTRUST_NUM"))));
                    
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
