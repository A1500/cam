package com.inspur.cams.prs.query.dao;

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
public class PrsMilitaryQueryDao extends BaseJdbcDao {

    public PrsMilitaryQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_PRS_QUERY_MILITARY");
            // 声明参数
            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_q", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_z", Types.VARCHAR));
            declareParameter(new SqlParameter("in_military", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh, String cxsj_q, String cxsj_z,String military ) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("in_xzqh", xzqh);
            in.put("in_cxsj_q", cxsj_q);
            in.put("in_cxsj_z", cxsj_z);
            in.put("in_military", military);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                   
                    record.set("retiredSoldiers", rs.getString("retiredSoldiers"));
                    
                    record.set("transferredOfficer", rs.getString("transferredOfficer"));
                    record.set("demobilizedOfficer", rs.getString("demobilizedOfficer"));
                    record.set("disabilitySoldiers", rs.getString("disabilitySoldiers"));     
                    record.set("totalCount", rs.getString("totalCount"));   
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
        String military = (String) pset.getParameter("military");// 
        object = procduce.call(xzqu,cxsj_q,cxsj_z,military).get("results");
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
