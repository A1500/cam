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
public class TestedQueryDao extends BaseJdbcDao {

    public TestedQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_BPT_QUERY_TESTED");
            // 声明参数
            declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_q", Types.VARCHAR));
            declareParameter(new SqlParameter("in_cxsj_z", Types.VARCHAR));
            //declareParameter(new SqlParameter("in_cxzt", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh, String cxsj_q,String cxsj_z) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("in_xzqh", xzqh);
            in.put("in_cxsj_q", cxsj_q);
            in.put("in_cxsj_z", cxsj_z);
            //in.put("in_cxzt", cxzt);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
                    record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
                    record.set("T1", rs.getString("T1"));
                    record.set("T2", rs.getString("T2"));
                    record.set("T3", rs.getString("T3"));
                    record.set("T4", rs.getString("T4"));
                    record.set("T5", rs.getString("T5"));
                    record.set("T6", rs.getString("T6"));
                    record.set("T7", rs.getString("T7"));
                    record.set("T8", rs.getString("T8"));
                    record.set("T9", rs.getString("T9"));
                    record.set("T10", rs.getString("T10"));
                    record.set("T11", rs.getString("T11"));
                    record.set("T12", rs.getString("T12"));
                    record.set("T13", rs.getString("T13"));
                    record.set("T14", rs.getString("T14"));
                    record.set("T15", rs.getString("T15"));
                    record.set("T16", rs.getString("T16"));
                    record.set("T17", rs.getString("T17"));
                    record.set("T18", rs.getString("T18"));
                    record.set("T19", rs.getString("T19"));
                    record.set("T20", rs.getString("T20"));
                    record.set("T21", rs.getString("T21"));
                    record.set("T22", rs.getString("T22"));
                    record.set("T23", rs.getString("T23"));
                    record.set("T24", rs.getString("T24"));
                    record.set("T25", rs.getString("T25"));
                    record.set("T26", rs.getString("T26"));
                    record.set("T27", rs.getString("T27"));
                    record.set("T28", rs.getString("T28"));
                    record.set("T29", rs.getString("T29"));
                    record.set("T30", rs.getString("T30"));
                    record.set("T31", rs.getString("T31"));
                    record.set("T32", rs.getString("T32"));
                    record.set("T33", rs.getString("T33"));
                    record.set("T34", rs.getString("T34"));
                    record.set("T35", rs.getString("T35"));
                    record.set("T36", rs.getString("T36"));
                    record.set("T37", rs.getString("T37"));
                    record.set("T38", rs.getString("T38"));
                    record.set("T39", rs.getString("T39"));
                    record.set("T40", rs.getString("T40"));
                    record.set("T41", rs.getString("T41"));
                    record.set("T42", rs.getString("T42"));
                    record.set("T43", rs.getString("T43"));
                    record.set("T44", rs.getString("T44"));
                    record.set("T45", rs.getString("T45"));
                    record.set("T46", rs.getString("T46"));
                    record.set("T47", rs.getString("T47"));
                    record.set("T48", rs.getString("T48"));
                    record.set("T49", rs.getString("T49"));
                    record.set("T50", rs.getString("T50"));
                    record.set("T51", rs.getString("T51"));
                    record.set("T52", rs.getString("T52"));
                    record.set("T53", rs.getString("T53"));
                    record.set("T54", rs.getString("T54"));
                    record.set("T55", rs.getString("T55"));
                    record.set("T56", rs.getString("T56"));
                    record.set("T57", rs.getString("T57"));
                    record.set("T58", rs.getString("T58"));
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
    
    public static void main(String[] args){
    	for(int i =1 ;i<56;i++){
    		System.out.println("<td align=\"right\" nowrap=\"nowrap\" class=\"td\"><a href=\"#\" style=\"cursor:hand\"><label onclick=\"redirectQuery(this.parentNode.parentNode,'3','1')\" field=\"T"+i+"\" ></label></a></td>/>");
    	}
    }
    
}
