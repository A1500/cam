package com.inspur.cams.marry.query.dept.dao;

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
public class OrganResourceDao extends BaseJdbcDao {

    public OrganResourceDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_ORGAN_RESOURCE_QUERY");
            // 声明参数
            declareParameter(new SqlParameter("IN_XZQH", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("IN_XZQH", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                    record.set("CUM_NUM", rs.getString("CUM_NUM"));
                    record.set("PRINTER_NUM", rs.getString("PRINTER_NUM"));
                    record.set("CARD_READER_NUM", rs.getString("CARD_READER_NUM"));
                    record.set("COPIER_NUM", rs.getString("COPIER_NUM"));
                    record.set("SCANNER_NUM", rs.getString("SCANNER_NUM"));
                    record.set("FAX_NUM", rs.getString("FAX_NUM"));
                    record.set("TV_NUM", rs.getString("TV_NUM"));
                    record.set("CAL_NUM", rs.getString("CAL_NUM"));
                    record.set("SCREEN_NUM", rs.getString("SCREEN_NUM"));
                    record.set("MONITORING_NUM", rs.getString("MONITORING_NUM"));
                    record.set("EVALUATION_NUM", rs.getString("EVALUATION_NUM"));
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
