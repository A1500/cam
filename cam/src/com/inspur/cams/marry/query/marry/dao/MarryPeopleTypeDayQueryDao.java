package com.inspur.cams.marry.query.marry.dao;

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

@SuppressWarnings("unchecked")
public class MarryPeopleTypeDayQueryDao extends BaseJdbcDao {

    public MarryPeopleTypeDayQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_RPT_MARRY_MONTH_DAY");
            // 声明参数
            declareParameter(new SqlParameter("p_SUM_DATE_q", Types.VARCHAR));
            declareParameter(new SqlParameter("p_SUM_DATE_z", Types.VARCHAR));
            declareParameter(new SqlParameter("p_CITY_CODE", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String cxsj_q,String cxsj_z, String xzqh) {
            Map in = new HashMap();
           
            // 设置入参的值，key要和声明参数的名称一致
            in.put("p_SUM_DATE_q", cxsj_q);
            in.put("p_SUM_DATE_z", cxsj_z);
            in.put("p_CITY_CODE", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ITEM_CODE", rs.getString("ITEM_CODE"));
                    record.set("ITEM_NAME", rs.getString("ITEM_NAME"));
                    record.set("MARRY_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("MARRY_NUM")),",###"));
                    record.set("MAINLAND_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("MAINLAND_NUM")),",###"));
                    record.set("FOREIGNER_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("FOREIGNER_NUM")),",###"));
                    record.set("FOREIGNER_WOMAN_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("FOREIGNER_WOMAN_NUM")),",###"));
                    record.set("HK_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("HK_NUM")),",###"));
                    record.set("HK_WOMAN_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("HK_WOMAN_NUM")),",###"));
                    record.set("MO_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("MO_NUM")),",###"));
                    record.set("MO_WOMAN_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("MO_WOMAN_NUM")),",###"));
                    record.set("TW_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("TW_NUM")),",###"));
                    record.set("TW_WOMAN_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("TW_WOMAN_NUM")),",###"));
                    record.set("HQ_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("HQ_NUM")),",###"));
                    record.set("HQ_WOMAN_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("HQ_WOMAN_NUM")),",###"));
                     
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
/**
 * 结婚登记业务查询：按结婚登记居住地分类
 * @param pset
 * @return
 */
    public DataSet getDataSet(ParameterSet pset) {
        init();
        DataSet set = new DataSet();
        List results = null;
        Object object = null;
        String xzqu = (String) pset.getParameter("xzqu");// 行政区划
        String cxsj_q = (String) pset.getParameter("cxsjq");// 查询时间
        String cxsj_z = (String) pset.getParameter("cxsjz");// 查询时间
        
        object = procduce.call(cxsj_q,cxsj_z,xzqu).get("results");
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
