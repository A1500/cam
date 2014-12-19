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

@SuppressWarnings("unchecked")
public class DisabilityDeviceTongJiDao extends BaseJdbcDao {

    public DisabilityDeviceTongJiDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_BPT_QUERY_DISABILITY_DEVICE");
            // 声明参数
            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_q", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_z", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh, String cxsj_q, String cxsj_z) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("in_xzqh", xzqh);
            in.put("in_cxsj_q", cxsj_q);
            in.put("in_cxsj_z", cxsj_z);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                    record.set("Y1", rs.getString("Y1"));
                    record.set("Y2", rs.getString("Y2"));
                    record.set("Y3", rs.getString("Y3"));
                    record.set("Y4", rs.getString("Y4"));
                    record.set("Y5", rs.getString("Y5"));
                    record.set("Y6", rs.getString("Y6"));
                    record.set("Y7", rs.getString("Y7"));
                    record.set("Y8", rs.getString("Y8"));
                    record.set("Y9", rs.getString("Y9"));
                    record.set("Y10", rs.getString("Y10"));
                    record.set("Y11", rs.getString("Y11"));
                    record.set("Y12", rs.getString("Y12"));
                    record.set("Y13", rs.getString("Y13"));
                    record.set("Y14", rs.getString("Y14"));
                    record.set("Y15", rs.getString("Y15"));
                    record.set("Y16", rs.getString("Y16"));
                    record.set("Y17", rs.getString("Y17"));
                    record.set("Y18", rs.getString("Y18"));
                    record.set("Y19", rs.getString("Y19"));
                    record.set("Y20", rs.getString("Y20"));
                    record.set("Y21", rs.getString("Y21"));
                    record.set("Y22", rs.getString("Y22"));
                    record.set("Y23", rs.getString("Y23"));
                    record.set("Y24", rs.getString("Y24"));
                    record.set("Y25", rs.getString("Y25"));
                    record.set("Y26", rs.getString("Y26"));
                    
                    
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
        String cxsj_q = (String) pset.getParameter("cxsjq");// 查询时间_起
        String cxsj_z = (String) pset.getParameter("cxsjz");// 查询时间_止
        object = procduce.call(xzqu,cxsj_q,cxsj_z).get("results");
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
