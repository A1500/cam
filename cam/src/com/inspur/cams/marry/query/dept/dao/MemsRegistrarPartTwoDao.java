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
public class MemsRegistrarPartTwoDao extends BaseJdbcDao {

    public MemsRegistrarPartTwoDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_MRM_REGISTRAR_PART2");
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
                    /**
                     * TOTAL_NUM          NUMBER(16),
       PARTY_NUM          NUMBER(16),
      UNDERGRADUATES_NUM NUMBER(16),
      JUNIOR_NUM         NUMBER(16),
      YEAR5_NUM          NUMBER(16),
      YEAR6_10_NUM       NUMBER(16),
      YEAR11_20_NUM      NUMBER(16),
      YEAR21_NUM         NUMBER(16),
      DEPARTURE_NUM      NUMBER(16)
                     */
                    
                    int partyNum = rs.getInt("PARTY_NUM");//党员
                    record.set("PARTY_NUM", getNum(partyNum));
                    record.set("PARTY_RATE", getPercent(partyNum,totalNum));//党员比率
                    
                    int undergraduatesNum = rs.getInt("UNDERGRADUATES_NUM");//本科
                    record.set("UNDERGRADUATES_NUM", getNum(undergraduatesNum));
                    record.set("UNDERGRADUATES_RATE", getPercent(undergraduatesNum,totalNum));//本科比率
                    
                    int juniorNum = rs.getInt("JUNIOR_NUM");//全日大专
                    record.set("JUNIOR_NUM", getNum(juniorNum));
                    record.set("JUNIOR_RATE", getPercent(juniorNum,totalNum));//全日大专比率
                    
                    int YEAR5_NUM = rs.getInt("YEAR5_NUM");//从业5年
                    record.set("YEAR5_NUM", getNum(YEAR5_NUM));
                    record.set("YEAR5_RATE", getPercent(YEAR5_NUM,totalNum));//从业5年政比率
                    
                    int YEAR6_10_NUM = rs.getInt("YEAR6_10_NUM");//从业6~10年
                    record.set("YEAR6_10_NUM", getNum(YEAR6_10_NUM));
                    record.set("YEAR6_10_RATE", getPercent(YEAR6_10_NUM,totalNum));//从业6~10年比率
                    
                    int YEAR11_20_NUM = rs.getInt("YEAR11_20_NUM");//从业11~20年
                    record.set("YEAR11_20_NUM", getNum(YEAR11_20_NUM));
                    record.set("YEAR11_20_RATE", getPercent(YEAR11_20_NUM,totalNum));//从业11~20年比率
                    
                    int YEAR21_NUM = rs.getInt("YEAR21_NUM");//从业21年以上
                    record.set("YEAR21_NUM", getNum(YEAR21_NUM));
                    record.set("YEAR21_RATE", getPercent(YEAR21_NUM,totalNum));//从业21年以上比率
                    
                    int DEPARTURE_NUM = rs.getInt("DEPARTURE_NUM");//离岗
                    record.set("DEPARTURE_NUM", getNum(DEPARTURE_NUM));
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
		MemsRegistrarPartTwoDao dao = new MemsRegistrarPartTwoDao();
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
    private static String getNum(int value){
 	   String returnValue =StrUtil.formatNum(value,"###,##0");
 	   return returnValue;
    }
}
