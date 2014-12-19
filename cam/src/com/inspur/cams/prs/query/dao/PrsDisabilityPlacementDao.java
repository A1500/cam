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


public class PrsDisabilityPlacementDao extends BaseJdbcDao {

	public PrsDisabilityPlacementDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_PRS_DISABILITY_PLAN_PLAME");
            // 声明参数
            declareParameter(new SqlParameter("IN_XZQH", Types.VARCHAR));
            declareParameter(new SqlParameter("IN_PLAN_YEAR", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh, String planYear) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("IN_XZQH", xzqh);
            in.put("IN_PLAN_YEAR", planYear);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                    
                    record.set("PLACEMENTED", rs.getString("PLACEMENTED"));
                    record.set("UNPLACEMENTED", rs.getString("UNPLACEMENTED"));
                    
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
        String planYear = (String) pset.getParameter("planYear");// 查询时间_起
        object = procduce.call(xzqu,planYear).get("results");
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
