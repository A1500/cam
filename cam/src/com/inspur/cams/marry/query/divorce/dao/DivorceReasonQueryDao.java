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
/**
 * 离婚原因查询统计
 * @author douyn
 *
 */
@SuppressWarnings("unchecked")
public class DivorceReasonQueryDao extends BaseJdbcDao {

    public DivorceReasonQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_RPT_DIVORCE_REASON");
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
                    record.set("TOTAL_NUM",getNum(rs.getString("TOTAL_NUM")));
                    record.set("INCOMPATIBLE_NUM", getNum(rs.getString("INCOMPATIBLE_NUM")));
                    record.set("INCOMPATIBLE_RATE", getPercent(rs.getString("INCOMPATIBLE_RATE")));
                    record.set("FINANCIAL_NUM", getNum(rs.getString("FINANCIAL_NUM")));
                    record.set("FINANCIAL_RATE", getPercent(rs.getString("FINANCIAL_RATE")));
                    record.set("THIRD_NUM", getNum(rs.getString("THIRD_NUM")));
                    record.set("THIRD_RATE", getPercent(rs.getString("THIRD_RATE")));
                    record.set("BOTH_PLACES_NUM", getNum(rs.getString("BOTH_PLACES_NUM")));
                    record.set("BOTH_PLACES_RATE", getPercent(rs.getString("BOTH_PLACES_RATE")));
                    record.set("EDUCATION_NUM", getNum(rs.getString("EDUCATION_NUM")));
                    record.set("EDUCATION_RATE", getPercent(rs.getString("EDUCATION_RATE")));
                    record.set("DISSENSION_NUM", getNum(rs.getString("DISSENSION_NUM")));
                    record.set("DISSENSION_RATE", getPercent(rs.getString("DISSENSION_RATE")));
                    record.set("SEXUAL_NUM", getNum(rs.getString("SEXUAL_NUM")));
                    record.set("SEXUAL_RATE", getPercent(rs.getString("SEXUAL_RATE")));
                    record.set("ILLEGAL_NUM", getNum(rs.getString("ILLEGAL_NUM")));
                    record.set("ILLEGAL_RATE",getPercent( rs.getString("ILLEGAL_RATE")));
                    record.set("BAD_HADIT_NUM", getNum(rs.getString("BAD_HADIT_NUM")));
                    record.set("BAD_HADIT_RATE", getPercent(rs.getString("BAD_HADIT_RATE")));
                    record.set("NOT_FAMILIAR_NUM", getNum(rs.getString("NOT_FAMILIAR_NUM")));
                    record.set("NOT_FAMILIAR_RATE",getPercent( rs.getString("NOT_FAMILIAR_RATE")));
                    record.set("OTHERS_NUM", getNum(rs.getString("OTHERS_NUM")));
                    record.set("OTHERS_RATE",getPercent( rs.getString("OTHERS_RATE")));
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
