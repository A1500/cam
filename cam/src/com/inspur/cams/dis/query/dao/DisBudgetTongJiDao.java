package com.inspur.cams.dis.query.dao;

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

@SuppressWarnings("unchecked")
public class DisBudgetTongJiDao extends BaseJdbcDao {

    public DisBudgetTongJiDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_DIS_BUDGET_TONGJI");
            // 声明参数
            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("in_xzqh", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                    record.set("DCNUM", rs.getString("DCNUM"));
                    record.set("DCFOOD", rs.getString("DCFOOD"));
                    record.set("DCCLOTHES", rs.getString("DCCLOTHES"));
                    record.set("DCMONEY", rs.getString("DCMONEY"));
                    record.set("SWNUM", rs.getString("SWNUM"));
                    record.set("SWMONEY", rs.getString("SWMONEY"));
                    record.set("YJNUM", rs.getString("YJNUM"));
                    record.set("YJFOOD", rs.getString("YJFOOD"));
                    record.set("YJCLOTHES", rs.getString("YJCLOTHES"));
                    record.set("YJMONEY", rs.getString("YJMONEY"));
                    record.set("GDNUM", rs.getString("GDNUM"));
                    record.set("GDFOOD", rs.getString("GDFOOD"));
                    record.set("GDCLOTHES", rs.getString("GDCLOTHES"));
                    record.set("GDMONEY", rs.getString("GDMONEY"));
                    record.set("CJNUM", rs.getString("CJNUM"));
                    record.set("CJRBHOUSE", rs.getString("CJRBHOUSE"));
                    record.set("CJRPHOUSE", rs.getString("CJRPHOUSE"));
                    record.set("CJMONEY", rs.getString("CJMONEY"));
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
}
