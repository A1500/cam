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
public class MarriageCertifierQueryDao extends BaseJdbcDao {

    public MarriageCertifierQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_MARRIAGE_CERTIFIER");
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
                    record.set("ITEM_CODE", rs.getString("ITEM_CODE"));
                    record.set("ITEM_NAME", rs.getString("ITEM_NAME"));
                    record.set("TOTAL_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("TOTAL_NUM"))));
                    record.set("XZDW_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("XZDW_NUM"))));
                    record.set("CGGLSYDW_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("CGGLSYDW_NUM"))));
                    record.set("QEBKSYDW_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("QEBKSYDW_NUM"))));
                    record.set("MAN_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("MAN_NUM"))));
                    record.set("WOMAN_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("WOMAN_NUM"))));
                    record.set("HANZU_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("HANZU_NUM"))));
                    record.set("SHAO_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("SHAO_NUM"))));
                    record.set("AGE_AVG", getPercent(rs.getString("AGE_AVG")));
                    record.set("AGE35_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("AGE35_NUM"))));
                    record.set("PARTY_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("PARTY_NUM"))));
                    record.set("LEAGUE_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LEAGUE_NUM"))));
                    record.set("UNDERGRADUATES_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("UNDERGRADUATES_NUM"))));
                    record.set("JUNIOR_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("JUNIOR_NUM"))));
                    record.set("YEAR5_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("YEAR5_NUM"))));
                    record.set("YEAR6_10_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("YEAR6_10_NUM"))));
                    record.set("YEAR11_20_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("YEAR11_20_NUM"))));
                    record.set("YEAR21_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("YEAR21_NUM"))));
                    record.set("FIRST_TOTAL_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("FIRST_TOTAL_NUM"))));
                    record.set("FIRST_HG_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("FIRST_HG_NUM"))));
                    record.set("FIRST_BK_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("FIRST_BK_NUM"))));
                    record.set("FIRST_BKHG_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("FIRST_BKHG_NUM"))));
                    record.set("FIRST_BKBHG_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("FIRST_BKBHG_NUM"))));
                    record.set("LAST_YK_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LAST_YK_NUM"))));
                    record.set("LAST_SK_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LAST_SK_NUM"))));
                    record.set("LAST_HG_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LAST_HG_NUM"))));
                    record.set("LAST_BK_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LAST_BK_NUM"))));
                    record.set("LAST_BKHG_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LAST_BKHG_NUM"))));
                    record.set("LAST_CXZGZ_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LAST_CXZGZ_NUM"))));
                    record.set("LAST_ZGZZDSX_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("LAST_ZGZZDSX_NUM"))));
                    record.set("DEPARTURE_NUM", StrUtil.formatInt(Integer.parseInt(rs.getString("DEPARTURE_NUM"))));
                    
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
