package com.inspur.cams.low.query.dao;

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
public class LowAreaSortQueryDao extends BaseJdbcDao {

    public LowAreaSortQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }

    private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_LOW_RPT_AREA_SORT");
            // 声明参数
            declareParameter(new SqlParameter("p_SUM_DATE_q", Types.VARCHAR));
            declareParameter(new SqlParameter("p_SUM_DATE_z", Types.VARCHAR));
            declareParameter(new SqlParameter("p_CITY_CODE", Types.VARCHAR));
            // 声明结果集的个数
            setNumberOfResultSet(1);
            compile();
        }
        /**
         * 最低生活保障业务查询
         * @param cxsj_q
         * @param cxsj_z
         * @param xzqh
         * @return
         */
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
                    record.set("CENTER_FAMILY_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("CENTER_FAMILY_NUM")),",###"));
                    record.set("CENTER_PEOPLE_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("CENTER_PEOPLE_NUM")),",###"));
                    record.set("CENTER_MONEY_MONTH", StrUtil.formatNum(Integer.parseInt(rs.getString("CENTER_MONEY_MONTH")),",###"));
                    record.set("PROVINCE_FAMILY_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("PROVINCE_FAMILY_NUM")),",###"));
                    record.set("PROVINCE_PEOPLE_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("PROVINCE_PEOPLE_NUM")),",###"));
                    record.set("PROVINCE_MONEY_MONTH", StrUtil.formatNum(Integer.parseInt(rs.getString("PROVINCE_MONEY_MONTH")),",###"));
                    record.set("CITY_FAMILY_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("CITY_FAMILY_NUM")),",###"));
                    record.set("CITY_PEOPLE_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("CITY_PEOPLE_NUM")),",###"));
                    record.set("CITY_MONEY_MONTH", StrUtil.formatNum(Integer.parseInt(rs.getString("CITY_MONEY_MONTH")),",###"));
                    record.set("TOWN_FAMILY_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("TOWN_FAMILY_NUM")),",###"));
                    record.set("TOWN_PEOPLE_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("TOWN_PEOPLE_NUM")),",###"));
                    record.set("TOWN_MONEY_MONTH", StrUtil.formatNum(Integer.parseInt(rs.getString("TOWN_MONEY_MONTH")),",###"));
                    record.set("TOTAL_FAMILY_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("TOTAL_FAMILY_NUM")),",###"));
                    record.set("TOTAL_PEOPLE_NUM", StrUtil.formatNum(Integer.parseInt(rs.getString("TOTAL_PEOPLE_NUM")),",###"));
                    record.set("TOTAL_MONEY_MONTH", StrUtil.formatNum(Integer.parseInt(rs.getString("TOTAL_MONEY_MONTH")),",###"));
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
 * 城市低保最低生活保障业务查询：按低保属地分类
 * @param pset
 * @return
 */
    public DataSet getDataSet(ParameterSet pset) {
        init();
        DataSet set = new DataSet();
        List results = null;
        Object object = null;
        String xzqu = (String) pset.getParameter("xzqu");// 行政区划
        String cxsj_q = (String) pset.getParameter("cxsjq");// 查询时间起
        String cxsj_z = (String) pset.getParameter("cxsjz");// 查询时间止
 
        object = procduce.call(cxsj_q,cxsj_z,xzqu).get("results");
        if (object instanceof ArrayList) {
            results = (List) object;
            for (Object o : results) {
                set.add((Record) o);
            }
        }
        return set;
    }

    /**
     * 1-点击户数查看明细
     * @param pset
     * @return
     */
	public DataSet getFamilyDataSet(ParameterSet pset) {
		DataSet resultDs = new DataSet();
        StringBuffer jtxxSql = new StringBuffer();
        List typeList = new ArrayList();
	    List<Object> argsList = new ArrayList();
		//当前登陆人单位区划
		String organCode = (String) pset.getParameter("query_organCode");//行政区划
		String startTime="";
		String timeS= (String) pset.getParameter("startTime");//查询时间起
		    startTime=timeS.substring(0, 4)+"-"+timeS.substring(4,6)+"-"+timeS.substring(6, 8);
		String endTime="";
		String timeT= (String) pset.getParameter("endTime");//录入时间止
	    	endTime=timeT.substring(0, 4)+"-"+timeT.substring(4,6)+"-"+timeT.substring(6, 8);
		String name = (String) pset.getParameter("name");//姓名
		String idCard = (String) pset.getParameter("idCard");//身份证号码
		String sortType = (String) pset.getParameter("sortType");//属别
		 
		jtxxSql.append(" SELECT * FROM  (SELECT   T.PEOPLE_ID, T.PEOPLE_NAME AS PEOPLE_NAME, LOW_HZ_NAME(T.FAMILY_ID) AS HZXM, LOW_HZ_IDCARD(T.FAMILY_ID) AS HZID, ");
		jtxxSql.append("  T.LOW_NO AS LOW_NO,T.FAMILY_NUM AS FAMILY_NUM,T.LOW_NUM AS LOW_NUM,T.ADDRESS AS ADDRESS, ");
		jtxxSql.append("  T.TOWN AS TOWN,T.STREET AS STREET,T.VILLAGE AS VILLAGE,T.CARD_NO AS CARD_NO,T.AUDIT_TIME AS AUDIT_TIME");
		jtxxSql.append("  ,ROW_NUMBER() OVER (PARTITION BY T.FAMILY_ID ORDER BY T.FAMILY_ID) AS PEOPLE_ID_ORDER ");
		jtxxSql.append("  FROM  saas_collect.LOW_BI_AREA_SORT_BASEINFO T ");
		jtxxSql.append("  WHERE  1=1 ");
		//1-属别过滤条件
		if (sortType != null && !"".equals(sortType)) {
			jtxxSql.append(" and  T.sort_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(sortType);
		}
		//查询条件
		//2-行政区划查询条件
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			jtxxSql.append(" and substr(T.CITY_CODE,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			jtxxSql.append(" and substr(T.CITY_CODE,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			jtxxSql.append(" and substr(T.CITY_CODE,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			jtxxSql.append(" and substr(T.CITY_CODE,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			jtxxSql.append(" and T.CITY_CODE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		// 3-户主姓名
		if (name != null && !"".equals(name)) {
			jtxxSql.append(" and  low_hz_name(t.family_id) like ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name + "%");
		}
		// 4-户主身份证件号码
		if (idCard != null && !"".equals(idCard)) {
			jtxxSql.append(" and  LOW_HZ_IDCARD(t.family_id) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		// 5-查询时间起
		if (startTime != null && !"".equals(startTime)) {
			jtxxSql.append(" and  T.SUM_DATE >= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
		}
		// 6-查询时间止
		if (endTime != null && !"".equals(endTime)) {
			jtxxSql.append(" and  T.SUM_DATE < = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(endTime);
		}
		jtxxSql.append("  ) WHERE  people_id_order=1 ");
		//分页设置
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtxxSql.toString(),types,args,start,limit,true);
		}else{
			resultDs = this.executeDataset(jtxxSql.toString(),start,limit,true);
		}
		return resultDs;
	}
    /**
     * 2-点击人数查看明细
     * @param pset
     * @return
     */
	public DataSet getPeopleDataSet(ParameterSet pset) {
		DataSet resultDs = new DataSet();
        StringBuffer jtxxSql = new StringBuffer();
        List typeList = new ArrayList();
	    List<Object> argsList = new ArrayList();
		//当前登陆人单位区划
	    String organCode = (String) pset.getParameter("query_organCode");//行政区划
		String startTime = (String) pset.getParameter("startTime");//查询时间起
		String endTime = (String) pset.getParameter("endTime");//录入时间止
		String name = (String) pset.getParameter("name");//姓名
		String idCard = (String) pset.getParameter("idCard");//身份证号码
		String sortType = (String) pset.getParameter("sortType");//属别
		 
		jtxxSql.append(" SELECT  t.people_id,t.people_name as people_name ,t.ID_CARD AS ID_CARD, low_hz_name(t.family_id) as HZXM, ");
		jtxxSql.append("  LOW_HZ_IDCARD(t.family_id) AS HZID,T.LOW_NO AS  LOW_NO , T.FAMILY_NUM AS FAMILY_NUM ,T.LOW_NUM AS LOW_NUM, ");
		jtxxSql.append("  T.ADDRESS AS ADDRESS,T.TOWN AS TOWN, T.STREET AS STREET, T.VILLAGE AS VILLAGE, T.CARD_NO AS CARD_NO, T.AUDIT_TIME AS AUDIT_TIME  ");
		jtxxSql.append("  FROM  saas_collect.LOW_BI_AREA_SORT_BASEINFO T ");
		jtxxSql.append("  WHERE  1=1 ");
		// 姓名
		if (sortType != null && !"".equals(sortType)) {
			jtxxSql.append(" and  T.sort_type = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(sortType);
		}
		 
		//查询条件
		//行政区划设置
		if ("0000000000".equals(organCode.substring(2))) { // 省级
			jtxxSql.append(" and substr(t.CITY_CODE,1,2) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 2));
		} else if ("00000000".equals(organCode.substring(4))) { // 市级
			jtxxSql.append(" and substr(t.CITY_CODE,1,4) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
		} else if ("000000".equals(organCode.substring(6))) { // 县级
			jtxxSql.append(" and substr(t.CITY_CODE,1,6) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 6));
		} else if ("000".equals(organCode.substring(9))) { // 街道
			jtxxSql.append(" and substr(t.CITY_CODE,1,9) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 9));
		} else { // 村
			jtxxSql.append(" and t.CITY_CODE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		// 姓名
		if (name != null && !"".equals(name)) {
			jtxxSql.append(" and  t.PEOPLE_NAME like ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + name + "%");
		}
		//身份证件号码
		if (idCard != null && !"".equals(idCard)) {
			jtxxSql.append(" and  t.ID_CARD = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		//分页设置
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtxxSql.toString(),types,args,start,limit,true);
		}else{
			resultDs = this.executeDataset(jtxxSql.toString(),start,limit,true);
		}
		return resultDs;
	}

    @Override
    protected void initDao() {

    }
 
}
