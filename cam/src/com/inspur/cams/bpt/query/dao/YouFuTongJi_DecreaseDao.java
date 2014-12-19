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
public class YouFuTongJi_DecreaseDao extends BaseJdbcDao {

    public YouFuTongJi_DecreaseDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_BPT_QUERY_DECREASE");
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
                    record.set("DISABLED_SOLDIER", rs.getString("DISABLED_SOLDIER"));
                    record.set("DISABLED_OFFICER", rs.getString("DISABLED_OFFICER"));
                    record.set("DISABLED_POLICE", rs.getString("DISABLED_POLICE"));
                    record.set("DISABLED_WAR_OFFICIAL", rs.getString("DISABLED_WAR_OFFICIAL"));
                    record.set("DISABLED_MILITIA_MIGRANT", rs.getString("DISABLED_MILITIA_MIGRANT"));
                    record.set("COUNT_DISABLED", rs.getString("COUNT_DISABLED"));
                    record.set("MARTYR_DEPENDANT", rs.getString("MARTYR_DEPENDANT"));
                    record.set("DUTY_DEPENDANT", rs.getString("DUTY_DEPENDANT"));
                    record.set("ILLSOLDIER_DEPENDANT", rs.getString("ILLSOLDIER_DEPENDANT"));
                    record.set("COUNT_DEPENDANT", rs.getString("COUNT_DEPENDANT"));
                    record.set("RESERVIST", rs.getString("RESERVIST"));
                    record.set("ILLNESS_RESERVIST", rs.getString("ILLNESS_RESERVIST"));
                    record.set("COUNT_RESERVIST", rs.getString("COUNT_RESERVIST"));
                    record.set("COUNT_TOTAL_TEMP", rs.getString("COUNT_TOTAL_TEMP"));
                    record.set("CZ_RETIRED", rs.getString("CZ_RETIRED"));
                    record.set("RETIRED_8023", rs.getString("RETIRED_8023"));
                    record.set("CS_RETIRED", rs.getString("CS_RETIRED"));
                    record.set("CS_EXPLOIT", rs.getString("CS_EXPLOIT"));
                    record.set("COUNT_RETIRED", rs.getString("COUNT_RETIRED"));
                    record.set("COUNT_TOTAL", rs.getString("COUNT_TOTAL"));
                    
                    record.set("SOLDIER", rs.getString("SOLDIER"));
                    record.set("OFFSPRINGL", rs.getString("OFFSPRINGL"));
                    record.set("OFFSPRINGP", rs.getString("OFFSPRINGP"));
                    record.set("COUNT_SOLDIER_OFFSPRING", rs.getString("COUNT_SOLDIER_OFFSPRING"));
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
