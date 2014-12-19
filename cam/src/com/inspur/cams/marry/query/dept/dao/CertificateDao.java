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
public class CertificateDao extends BaseJdbcDao {

    public CertificateDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_ORGAN_TYBZS_QUERY ");
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
                    record.set("TOTALNUM", rs.getString("TOTALNUM"));
                    record.set("NAN_NUM", rs.getString("NAN_NUM"));
                    record.set("NV_NUM", rs.getString("NV_NUM"));
                    record.set("DY_NUM", rs.getString("DY_NUM"));
                    record.set("TY_NUM", rs.getString("TY_NUM"));
                    record.set("YJS_NUM", rs.getString("YJS_NUM"));
                    record.set("DXBK_NUM", rs.getString("DXBK_NUM"));
                    record.set("ZK_NUM", rs.getString("ZK_NUM"));
                    record.set("SG_NUM", rs.getString("SG_NUM"));
                    record.set("XLZXS_NUM", rs.getString("XLZXS_NUM"));
                    record.set("HYJTZXS_NUM", rs.getString("HYJTZXS_NUM"));
                    record.set("LS_NUM", rs.getString("LS_NUM"));
                    record.set("ZFGMFW_NUM", rs.getString("ZFGMFW_NUM"));
                    record.set("GKZM_NUM", rs.getString("GKZM_NUM"));
                    record.set("ZYZ_NUM", rs.getString("ZYZ_NUM"));
                    record.set("QT_NUM", rs.getString("QT_NUM"));
                    record.set("XLZX_NUM", rs.getString("XLZX_NUM"));
                    record.set("FL_NUM", rs.getString("FL_NUM"));
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
