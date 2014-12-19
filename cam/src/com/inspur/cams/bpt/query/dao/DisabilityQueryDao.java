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
public class DisabilityQueryDao extends BaseJdbcDao {

    public DisabilityQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_BPT_QUERY_DISABILITY");
            // 声明参数
            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_q", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_z", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxzt", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh, String cxsj_q,String cxsj_z, String cxzt) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("in_xzqh", xzqh);
            in.put("in_cxsj_q", cxsj_q);
            in.put("in_cxsj_z", cxsj_z);
            in.put("in_cxzt", cxzt);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                    record.set("yzzxcount_1", rs.getString("yzzxcount_1"));
                    record.set("yzzzcount_1", rs.getString("yzzzcount_1"));
                    record.set("yzcount_1", rs.getString("yzcount_1"));
                    record.set("ygzxcount_1", rs.getString("ygzxcount_1"));
                    record.set("ygzzcount_1", rs.getString("ygzzcount_1"));
                    record.set("ygcount_1", rs.getString("ygcount_1"));
                    record.set("ybzxcount_1", rs.getString("ybzxcount_1"));
                    record.set("ybzzcount_1", rs.getString("ybzzcount_1"));
                    record.set("ybcount_1", rs.getString("ybcount_1"));
                    record.set("totalcount_1", rs.getString("totalcount_1"));
                    record.set("yzzxcount_2", rs.getString("yzzxcount_2"));
                    record.set("yzzzcount_2", rs.getString("yzzzcount_2"));
                    record.set("yzcount_2", rs.getString("yzcount_2"));
                    record.set("ygzxcount_2", rs.getString("ygzxcount_2"));
                    record.set("ygzzcount_2", rs.getString("ygzzcount_2"));
                    record.set("ygcount_2", rs.getString("ygcount_2"));
                    record.set("ybzxcount_2", rs.getString("ybzxcount_2"));
                    record.set("ybzzcount_2", rs.getString("ybzzcount_2"));
                    record.set("ybcount_2", rs.getString("ybcount_2"));
                    record.set("totalcount_2", rs.getString("totalcount_2"));
                    record.set("yzzxcount_3", rs.getString("yzzxcount_3"));
                    record.set("yzzzcount_3", rs.getString("yzzzcount_3"));
                    record.set("yzcount_3", rs.getString("yzcount_3"));
                    record.set("ygzxcount_3", rs.getString("ygzxcount_3"));
                    record.set("ygzzcount_3", rs.getString("ygzzcount_3"));
                    record.set("ygcount_3", rs.getString("ygcount_3"));
                    record.set("ybzxcount_3", rs.getString("ybzxcount_3"));
                    record.set("ybzzcount_3", rs.getString("ybzzcount_3"));
                    record.set("ybcount_3", rs.getString("ybcount_3"));
                    record.set("totalcount_3", rs.getString("totalcount_3"));
                    record.set("yzzxcount_4", rs.getString("yzzxcount_4"));
                    record.set("yzzzcount_4", rs.getString("yzzzcount_4"));
                    record.set("yzcount_4", rs.getString("yzcount_4"));
                    record.set("ygzxcount_4", rs.getString("ygzxcount_4"));
                    record.set("ygzzcount_4", rs.getString("ygzzcount_4"));
                    record.set("ygcount_4", rs.getString("ygcount_4"));
                    record.set("ybzxcount_4", rs.getString("ybzxcount_4"));
                    record.set("ybzzcount_4", rs.getString("ybzzcount_4"));
                    record.set("ybcount_4", rs.getString("ybcount_4"));
                    record.set("totalcount_4", rs.getString("totalcount_4"));
                    record.set("yzzxcount_5", rs.getString("yzzxcount_5"));
                    record.set("yzzzcount_5", rs.getString("yzzzcount_5"));
                    record.set("yzcount_5", rs.getString("yzcount_5"));
                    record.set("ygzxcount_5", rs.getString("ygzxcount_5"));
                    record.set("ygzzcount_5", rs.getString("ygzzcount_5"));
                    record.set("ygcount_5", rs.getString("ygcount_5"));
                    record.set("ybzxcount_5", rs.getString("ybzxcount_5"));
                    record.set("ybzzcount_5", rs.getString("ybzzcount_5"));
                    record.set("ybcount_5", rs.getString("ybcount_5"));
                    record.set("totalcount_5", rs.getString("totalcount_5"));
                    record.set("yzzxcount_6", rs.getString("yzzxcount_6"));
                    record.set("yzzzcount_6", rs.getString("yzzzcount_6"));
                    record.set("yzcount_6", rs.getString("yzcount_6"));
                    record.set("ygzxcount_6", rs.getString("ygzxcount_6"));
                    record.set("ygzzcount_6", rs.getString("ygzzcount_6"));
                    record.set("ygcount_6", rs.getString("ygcount_6"));
                    record.set("ybzxcount_6", rs.getString("ybzxcount_6"));
                    record.set("ybzzcount_6", rs.getString("ybzzcount_6"));
                    record.set("ybcount_6", rs.getString("ybcount_6"));
                    record.set("totalcount_6", rs.getString("totalcount_6"));
                    record.set("yzzxcount_7", rs.getString("yzzxcount_7"));
                    record.set("yzzzcount_7", rs.getString("yzzzcount_7"));
                    record.set("yzcount_7", rs.getString("yzcount_7"));
                    record.set("ygzxcount_7", rs.getString("ygzxcount_7"));
                    record.set("ygzzcount_7", rs.getString("ygzzcount_7"));
                    record.set("ygcount_7", rs.getString("ygcount_7"));
                    record.set("ybzxcount_7", rs.getString("ybzxcount_7"));
                    record.set("ybzzcount_7", rs.getString("ybzzcount_7"));
                    record.set("ybcount_7", rs.getString("ybcount_7"));
                    record.set("totalcount_7", rs.getString("totalcount_7"));
                    record.set("yzzxcount_8", rs.getString("yzzxcount_8"));
                    record.set("yzzzcount_8", rs.getString("yzzzcount_8"));
                    record.set("yzcount_8", rs.getString("yzcount_8"));
                    record.set("ygzxcount_8", rs.getString("ygzxcount_8"));
                    record.set("ygzzcount_8", rs.getString("ygzzcount_8"));
                    record.set("ygcount_8", rs.getString("ygcount_8"));
                    record.set("ybzxcount_8", rs.getString("ybzxcount_8"));
                    record.set("ybzzcount_8", rs.getString("ybzzcount_8"));
                    record.set("ybcount_8", rs.getString("ybcount_8"));
                    record.set("totalcount_8", rs.getString("totalcount_8"));
                    record.set("yzzxcount_9", rs.getString("yzzxcount_9"));
                    record.set("yzzzcount_9", rs.getString("yzzzcount_9"));
                    record.set("yzcount_9", rs.getString("yzcount_9"));
                    record.set("ygzxcount_9", rs.getString("ygzxcount_9"));
                    record.set("ygzzcount_9", rs.getString("ygzzcount_9"));
                    record.set("ygcount_9", rs.getString("ygcount_9"));
                    record.set("ybzxcount_9", rs.getString("ybzxcount_9"));
                    record.set("ybzzcount_9", rs.getString("ybzzcount_9"));
                    record.set("ybcount_9", rs.getString("ybcount_9"));
                    record.set("totalcount_9", rs.getString("totalcount_9"));
                    record.set("yzzxcount_10", rs.getString("yzzxcount_10"));
                    record.set("yzzzcount_10", rs.getString("yzzzcount_10"));
                    record.set("yzcount_10", rs.getString("yzcount_10"));
                    record.set("ygzxcount_10", rs.getString("ygzxcount_10"));
                    record.set("ygzzcount_10", rs.getString("ygzzcount_10"));
                    record.set("ygcount_10", rs.getString("ygcount_10"));
                    record.set("ybzxcount_10", rs.getString("ybzxcount_10"));
                    record.set("ybzzcount_10", rs.getString("ybzzcount_10"));
                    record.set("ybcount_10", rs.getString("ybcount_10"));
                    record.set("totalcount_10", rs.getString("totalcount_10"));
                    record.set("totalcount", rs.getString("totalcount"));
                    
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
        if("".equals(cxsj_q)){
            cxsj_q = "1900-01-01";
        }
        String cxsj_z = (String) pset.getParameter("cxsjz");// 查询时间
        String cxzt = (String) pset.getParameter("cxzt");// 优抚状态
        object = procduce.call(xzqu,cxsj_q,cxsj_z,cxzt).get("results");
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
