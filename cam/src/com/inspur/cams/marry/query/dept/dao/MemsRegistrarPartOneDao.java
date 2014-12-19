package com.inspur.cams.marry.query.dept.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.junit.Test;
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
public class MemsRegistrarPartOneDao extends BaseJdbcDao {

    public MemsRegistrarPartOneDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_REGISTRAR_PART1");
            // 声明参数
            declareParameter(new SqlParameter("P_CITY_CODE", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }

        public Map call(String xzqh) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("P_CITY_CODE", xzqh);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Record record = new Record();
                    record.set("ITEM_CODE", rs.getString("ITEM_CODE"));
                    record.set("ITEM_NAME", rs.getString("ITEM_NAME"));
                    int totalNum = rs.getInt("TOTAL_NUM");
                    record.set("TOTAL_NUM", getNum(totalNum));
                    
                    int xzdwNum = rs.getInt("XZDW_NUM");//行政
                    record.set("XZDW_NUM", getNum(xzdwNum));
                    record.set("XZDW_RATE", getPercent(xzdwNum,totalNum));//行政比率
                    
                    int cgglsydwNum = rs.getInt("CGGLSYDW_NUM");//参公管理
                    record.set("CGGLSYDW_NUM", getNum(cgglsydwNum));
                    record.set("CGGLSYDW_RATE", getPercent(cgglsydwNum,totalNum));//参公管理比率
                    
                    int qebksydwNum = rs.getInt("QEBKSYDW_NUM");//全额拨款
                    record.set("QEBKSYDW_NUM", getNum(qebksydwNum));
                    record.set("QEBKSYDW_RATE", getPercent(qebksydwNum,totalNum));//行政比率
                    
                    int manNum = rs.getInt("MAN_NUM");//男
                    record.set("MAN_NUM", getNum(manNum));
                    record.set("MAN_RATE", getPercent(manNum,totalNum));//行政比率
                    
                    int womanNum = rs.getInt("WOMAN_NUM");//行政
                    record.set("WOMAN_NUM", getNum(womanNum));
                    record.set("WOMAN_RATE", getPercent(womanNum,totalNum));//行政比率
                    
                    int hanzuNum = rs.getInt("HANZU_NUM");//行政
                    record.set("HANZU_NUM", getNum(hanzuNum));
                    record.set("HANZU_RATE", getPercent(hanzuNum,totalNum));//行政比率
                    
                    int shaoshuNum = rs.getInt("SHAOSHU_NUM");//行政
                    record.set("SHAOSHU_NUM", getNum(shaoshuNum));
                    record.set("SHAOSHU_RATE", getPercent(shaoshuNum,totalNum));//行政比率
                    
                    float avgAge = rs.getFloat("AVG_AGE");//行政
                    record.set("AVG_AGE", getPercent(avgAge));
                    
                    int under35age = rs.getInt("UNDER35AGE");//行政
                    record.set("UNDER35AGE", getNum(under35age));
                    record.set("UNDER35AGE_RATE", getPercent(under35age,totalNum));//行政比率
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

    @Test
    public void test() {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("xzqu","370000000000");
		MemsRegistrarPartOneDao dao = new MemsRegistrarPartOneDao();
		DataSet ds =dao.getDataSet(pset);
		System.out.println(ds.getCount());
	}
    @Override
    protected void initDao() {

    }
    private static String getPercent(int i,int j){
    	float num = (float)i /(float)j;
     	String returnValue =StrUtil.formatNum(num*100,"#0.00");
     	return returnValue;
     }
    
    private static String getPercent(float value){
     	String returnValue =StrUtil.formatNum(value,"#0");
     	return returnValue;
     }
    private static String getNum(int value){
 	   String returnValue =StrUtil.formatNum(value,"###,##0");
 	   return returnValue;
    }
}
