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
public class GloriousDao extends BaseJdbcDao {

    public GloriousDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_BPT_QUERY_GLORIOUS");
            // 声明参数
            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
            declareParameter(new SqlParameter("in_year", Types.VARCHAR));
            declareParameter(new SqlParameter("in_pxzd",Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh, String cxsj,String pxzd) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("in_xzqh", xzqh);
            in.put("in_year", cxsj);
            in.put("in_pxzd", pxzd);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ID", rs.getString("ID"));
                    record.set("NAME", rs.getString("NAME"));                    
                    record.set("BUILDED", rs.getString("BUILDED"));                    
                    record.set("BUILD", rs.getString("BUILD"));
                    record.set("BUILDING", rs.getString("BUILDING"));
                    record.set("JOINTLYBUILT", rs.getString("JOINTLYBUILT"));
                    record.set("SINGLEBUILDING", rs.getString("SINGLEBUILDING"));
                    record.set("APPROVAL_NUM", rs.getString("APPROVAL_NUM"));
                    record.set("UNAPPROVAL_NUM", rs.getString("UNAPPROVAL_NUM"));
                    record.set("PREPARE_NUM", rs.getString("PREPARE_NUM"));
                    record.set("BED_NUM", rs.getString("BED_NUM"));
                    record.set("TOTAL_FUNDS", rs.getString("TOTAL_FUNDS"));
                    record.set("COUNTYFUNDS", rs.getString("COUNTYFUNDS"));
                    record.set("CITYFUNDS", rs.getString("CITYFUNDS"));
                    record.set("ABOVE_CITYFUNDS", rs.getString("ABOVE_CITYFUNDS"));
                    record.set("SPECIALASSISTANCE", rs.getString("SPECIALASSISTANCE"));
                    record.set("OTHER_NUM", rs.getString("OTHER_NUM"));
                    record.set("CARE_ROTATION", rs.getString("CARE_ROTATION"));
                    record.set("GLORYROOM", rs.getString("GLORYROOM"));
                    record.set("CARE_PEOPLE", rs.getString("CARE_PEOPLE"));
                    
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
        String xzqh = (String) pset.getParameter("xzqh");// 行政区划
        String cxsj = (String) pset.getParameter("cxsj");// 查询时间_起
        object = procduce.call(xzqh,cxsj,"ID").get("results");
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
