package com.inspur.cams.drel.report.dao.jdbc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.report.dao.ISamBaseCaseReportDao;
import com.inspur.cams.drel.report.data.SamBaseinfoStat;


/**
 * @title:基本情况统计Dao
 * @description: 
 * @author: yanliangliang
 * @since:2012年8月27日
 * @version:1.0
*/
 public class SamBaseCaseReportDao extends EntityDao<SamBaseinfoStat>implements ISamBaseCaseReportDao {

	@SuppressWarnings("unchecked")
	@Override
	protected Class getEntityClass() {
		return SamBaseinfoStat.class;
	}
	/**
	 * 根据月份查询基本情况统计
	 * @return
	 */
	public DataSet queryBaseCaseByMonth(ParameterSet pset) {
		String areaCode=(String)pset.getParameter("domicileCode");
		String repMonth=(String)pset.getParameter("repMonth");
		String assistanceType=(String)pset.getParameter("assistanceType");
		StringBuffer sql = new StringBuffer();
		
		sql.append("select name,                                                                \n");
		sql.append("       id domicile_code,                                                    \n");
		sql.append("       nvl(family_sum, 0) family_sum,                                       \n");
		sql.append("       nvl(class_family_sum, 0) class_family_sum,                           \n");
		sql.append("       nvl(assistance_people_sum, 0) assistance_people_sum,                 \n");
		sql.append("       nvl(class_people_sum, 0) class_people_sum,                           \n");
		sql.append("       nvl(money_sum, 0) money_sum,                                         \n");
		sql.append("       nvl(assistance_money_sum, 0) assistance_money_sum,                   \n");
		sql.append("       nvl(class_money_sum, 0) class_money_sum,                             \n");
		sql.append("       nvl(concentrated_family_sum, 0) concentrated_family_sum,             \n");
		sql.append("       nvl(concentrated_people_sum, 0) concentrated_people_sum,             \n");
		sql.append("       nvl(dispersion_family_sum, 0) dispersion_family_sum,                 \n");
		sql.append("       nvl(dispersion_people_sum, 0) dispersion_people_sum         ,        \n");
		sql.append("       nvl(central_family_sum     ,0)   central_family_sum         , \n");
		sql.append("       nvl(province_family_sum    ,0)   province_family_sum        , \n");
		sql.append("       nvl(city_family_sum        ,0)   city_family_sum            , \n");
		sql.append("       nvl(county_family_sum      ,0)   county_family_sum          , \n");
		sql.append("       nvl(town_family_sum        ,0)   town_family_sum            , \n");
		sql.append("       nvl(central_people_sum     ,0)   central_people_sum         , \n");
		sql.append("       nvl(province_people_sum    ,0)   province_people_sum        , \n");
		sql.append("       nvl(city_people_sum        ,0)   city_people_sum            , \n");
		sql.append("       nvl(county_people_sum      ,0)   county_people_sum          , \n");
		sql.append("       nvl(town_people_sum        ,0)   town_people_sum            , \n");
		sql.append("       nvl(central_matching_mon   ,0)   central_matching_mon       , \n");
		sql.append("       nvl(province_matching_mon  ,0)   province_matching_mon      , \n");
		sql.append("       nvl(city_matching_mon      ,0)   city_matching_mon          , \n");
		sql.append("       nvl(county_matching_mon    ,0)   county_matching_mon        , \n");
		sql.append("       nvl(town_matching_mon      ,0)   town_matching_mon          , \n");
		sql.append("       nvl(central_assistance_mon ,0)   central_assistance_mon     , \n");
		sql.append("       nvl(province_assistance_mon,0)   province_assistance_mon    , \n");
		sql.append("       nvl(city_assistance_mon    ,0)   city_assistance_mon        , \n");
		sql.append("       nvl(county_assistance_mon  ,0)   county_assistance_mon      , \n");
		sql.append("       nvl(town_assistance_mon    ,0)   town_assistance_mon        , \n");
		sql.append("       nvl(central_class_mon      ,0)   central_class_mon          , \n");
		sql.append("       nvl(province_class_mon     ,0)   province_class_mon         , \n");
		sql.append("       nvl(city_class_mon         ,0)   city_class_mon             , \n");
		sql.append("       nvl(county_class_mon       ,0)   county_class_mon           , \n");
		sql.append("       nvl(town_class_mon         ,0)   town_class_mon             ,  \n");
		sql.append("       nvl(central_class_family_sum  ,0)  central_class_family_sum   , \n");
		sql.append("       nvl(province_class_family_sum ,0)  province_class_family_sum  , \n");
		sql.append("       nvl(city_class_family_sum     ,0)  city_class_family_sum      , \n");
		sql.append("       nvl(county_class_family_sum   ,0)  county_class_family_sum    , \n");
		sql.append("       nvl(town_class_family_sum     ,0)  town_class_family_sum      , \n");
		sql.append("       nvl(central_class_people_sum  ,0)  central_class_people_sum   ,  \n");
		sql.append("       nvl(province_class_people_sum ,0)  province_class_people_sum  , \n");
		sql.append("       nvl(city_class_people_sum     ,0)  city_class_people_sum      , \n");
		sql.append("       nvl(county_class_people_sum   ,0)  county_class_people_sum    , \n");
		sql.append("       nvl(town_class_people_sum     ,0)  town_class_people_sum       \n");
		
		sql.append("  from (SELECT rpad(substr(domicile_code, 1, "+getSubstrIndex(areaCode)+"), 12, '0') domicile_code,    \n");
		sql.append("               sum(family_sum) family_sum,                                  \n");
		sql.append("               sum(class_family_sum) class_family_sum,                      \n");
		sql.append("               sum(assistance_people_sum) assistance_people_sum,            \n");
		sql.append("               sum(class_people_sum) class_people_sum,                      \n");
		sql.append("               sum(money_sum) money_sum,                                    \n");
		sql.append("               sum(assistance_money_sum) assistance_money_sum,              \n");
		sql.append("               sum(class_money_sum) class_money_sum,                        \n");
		sql.append("               sum(concentrated_family_sum) concentrated_family_sum,        \n");
		sql.append("               sum(concentrated_people_sum) concentrated_people_sum,        \n");
		sql.append("               sum(dispersion_family_sum) dispersion_family_sum,            \n");
		sql.append("               sum(dispersion_people_sum) dispersion_people_sum,            \n");
		sql.append("               sum(central_family_sum     )   central_family_sum         , \n");
		sql.append("               sum(province_family_sum    )   province_family_sum        , \n");
		sql.append("               sum(city_family_sum        )   city_family_sum            , \n");
		sql.append("               sum(county_family_sum      )   county_family_sum          , \n");
		sql.append("               sum(town_family_sum        )   town_family_sum            , \n");
		sql.append("               sum(central_people_sum     )   central_people_sum         , \n");
		sql.append("               sum(province_people_sum    )   province_people_sum        , \n");
		sql.append("               sum(city_people_sum        )   city_people_sum            , \n");
		sql.append("               sum(county_people_sum      )   county_people_sum          , \n");
		sql.append("               sum(town_people_sum        )   town_people_sum            , \n");
		sql.append("               sum(central_matching_mon   )   central_matching_mon       , \n");
		sql.append("               sum(province_matching_mon  )   province_matching_mon      , \n");
		sql.append("               sum(city_matching_mon      )   city_matching_mon          , \n");
		sql.append("               sum(county_matching_mon    )   county_matching_mon        , \n");
		sql.append("               sum(town_matching_mon      )   town_matching_mon          , \n");
		sql.append("               sum(central_assistance_mon )   central_assistance_mon     , \n");
		sql.append("               sum(province_assistance_mon)   province_assistance_mon    , \n");
		sql.append("               sum(city_assistance_mon    )   city_assistance_mon        , \n");
		sql.append("               sum(county_assistance_mon  )   county_assistance_mon      , \n");
		sql.append("               sum(town_assistance_mon    )   town_assistance_mon        , \n");
		sql.append("               sum(central_class_mon      )   central_class_mon          , \n");
		sql.append("               sum(province_class_mon     )   province_class_mon         , \n");
		sql.append("               sum(city_class_mon         )   city_class_mon             , \n");
		sql.append("               sum(county_class_mon       )   county_class_mon           , \n");
		sql.append("               sum(town_class_mon         )   town_class_mon             , \n");
		sql.append("               sum(central_class_family_sum  )  central_class_family_sum   , \n");
		sql.append("               sum(province_class_family_sum )  province_class_family_sum  , \n");
		sql.append("               sum(city_class_family_sum     )  city_class_family_sum      , \n");
		sql.append("               sum(county_class_family_sum   )  county_class_family_sum    , \n");
		sql.append("               sum(town_class_family_sum     )  town_class_family_sum      , \n");
		sql.append("               sum(central_class_people_sum  )  central_class_people_sum   , \n");
		sql.append("               sum(province_class_people_sum )  province_class_people_sum  , \n");
		sql.append("               sum(city_class_people_sum     )  city_class_people_sum      , \n");
		sql.append("               sum(county_class_people_sum   )  county_class_people_sum    , \n");
		sql.append("               sum(town_class_people_sum     )  town_class_people_sum        \n");
		
		sql.append("          from sam_baseinfo_stat t                                          \n");
		sql.append("         where domicile_code like ?                                         \n");
		sql.append("           and rep_month = ?                                                \n");
		sql.append("           and assistance_type = ?                                          \n");
		sql.append("         group by rpad(substr(domicile_code, 1, "+getSubstrIndex(areaCode)+"), 12, '0')) s,            \n");
		sql.append("       dic_city d                                                           \n");
		sql.append(" where s.domicile_code(+) = d.id                                            \n");
		if(areaCode.endsWith("000")){
			sql.append("   and d.ups = ?                                                        \n");
		}else{
			sql.append("   and d.id = ?                                                         \n");
		}
		sql.append(" order by id                                                                \n");
		
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		
		typeList.add(Types.VARCHAR);
		argsList.add(getAreaCodeLikePrefix(areaCode)+"%");
		
		typeList.add(Types.VARCHAR);
		argsList.add(repMonth);
		
		typeList.add(Types.VARCHAR);
		argsList.add(assistanceType);
		
		typeList.add(Types.VARCHAR);
		argsList.add(areaCode);
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	
	
	private String getAreaCodeLikePrefix(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
        return areaCode;
	}
	private int getSubstrIndex(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return 4;
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return 6;
		} else if (areaCode.endsWith("000000")){//县370104000000
			return 9;
		} else if (areaCode.endsWith("000")){//乡370104003000
			return 12;
		}
        return 12;
	}
	public DataSet queryBaseCaseChangeByMonth(ParameterSet pset) {
		String domicileCode=(String)pset.getParameter("domicileCode");
		String startMonth=(String)pset.getParameter("startMonth");
		String endMonth=(String)pset.getParameter("endMonth");
		String assistanceType=(String)pset.getParameter("assistanceType");
		
		
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		int index=12;
		if(StringUtils.isNotEmpty(domicileCode)){
			if(domicileCode.indexOf("000")<9&&domicileCode.indexOf("000")>0){
				//index=domicileCode.indexOf("000")+3;
				index=getSubstrIndex(domicileCode);
			}
		}
		 sql.append(" select d.id, d.Name, al.* ");
		 sql.append("   from dic_city d ");
		 sql.append("   left join ");
		//区划
		sql.append(" (select  rpad(substr(T.domicile_code,1,"+index+"),12,'0') domicile_code,                                                           \n");
		//停保和其他变更项目统计时，不一样，时间字段为end_date ,其他为start_date
		//当月开始  
		sql.append(" sum(case  when t.change_item is null  \n");
		sql.append(" and ( t.begin_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" then  1  else   0  end ) new_count, \n");
		//当月开始保障金
		sql.append(" sum(case  when  t.change_item is null \n");
		sql.append(" and ( t.begin_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" then  nvl(t.assistance_money,0)  else   0  end ) new_mon , \n");
		//当月结束 
		sql.append(" sum(case  when  t.change_item ='03'   \n");
		sql.append(" and ( t.end_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" then   1   else    0  end) end_count,  \n");
		//当月结束保障金
		sql.append(" sum(case  when  t.change_item ='03'  \n");
		sql.append(" and ( t.end_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append("then  nvl(t.assistance_money,0)  else   0  end ) end_mon , \n");
		//增加保障金的户数
		sql.append(" sum(case  when  t.difference > 0  \n");
		sql.append(" and ( t.begin_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" then  1  else   0  end ) add_count, \n");
		//增加保障金
		sql.append("  sum(case  when  t.difference > 0   \n");
		sql.append(" and ( t.begin_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" then  ABS(nvl(t.difference,0))  else   0  end ) add_mon, \n");
		//当月减少保障金的户数
		sql.append(" sum(case  when  t.difference < 0   \n");
		sql.append(" and ( t.begin_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" then  1  else   0  end ) low_count , \n");
		//当月减少保障金
		sql.append("  sum(case  when  t.difference < 0  \n");
		sql.append(" and ( t.begin_date between ?  \n");
		argsList.add(startMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" and  ?  )\n");
		argsList.add(endMonth);
		typeList.add(Types.VARCHAR);
		sql.append(" then ABS(nvl(t.difference,0))   else   0  end ) low_mon  \n");
		sql.append(" from sam_family_treatment t   \n");
		sql.append(" where 1=1  and t.assistance_type= ? and t.domicile_code like ?           \n");
		typeList.add(Types.VARCHAR);
		argsList.add(assistanceType);
		
		typeList.add(Types.VARCHAR);
		if(domicileCode.indexOf("000")>-1){
	   		argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
	    }else {
	   		argsList.add(domicileCode+"%");
		}
		
		/*typeList.add(Types.VARCHAR);
		if(!startMonth.equals(endMonth)){
			sql.append(" and ( t.begin_date between ?  \n");
			argsList.add(startMonth);
			sql.append(" and  ?  )\n");
			argsList.add(endMonth);
			typeList.add(Types.VARCHAR);
		}else{
			sql.append(" and ( t.begin_date = ?  )\n");
			argsList.add(startMonth);
		}*/
		
		/*typeList.add(Types.VARCHAR);
		if(!startMonth.equals(endMonth)){
			sql.append(" or  t.end_date between ?  \n");
			argsList.add(getLastMonth(startMonth));
			sql.append(" and  ?  )\n");
			argsList.add(getLastMonth(endMonth));
			typeList.add(Types.VARCHAR);
		}else{
			sql.append(" or t.end_date = ?  ) \n");
			argsList.add(getLastMonth(startMonth));
		}*/
		
		sql.append(" group by  rpad(substr(t.domicile_code,1,"+index+"),12,'0')  \n");
		sql.append("  ) al on al.domicile_code = d.id ");
		sql.append(" where d.id = rpad(substr(d.id, 1," +index+"), 12, 0)  " );
		if(domicileCode.endsWith("000")){
	    	sql.append(" and d.ups=?  " );
	    } else {
	    	sql.append(" and d.id=?  " );
	    }
	    sql.append(" order by d.id ");
	    
		argsList.add(domicileCode);
	   	typeList.add(Types.VARCHAR);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	//获取特定月份上个月份
	public String getLastMonth(String currentMonth){
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM");
		 Date date=null;
		try {
			date = formatDate.parse(currentMonth);
			Calendar cal=Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.MONTH,cal.get(Calendar.MONTH)-1); 
			return formatDate.format(cal.getTime());
		} catch (Exception e) {
			e.printStackTrace();
			return currentMonth;
		}
	}
	public DataSet queryDeadByMonth(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
 		String organCode = (String) pset.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("select  d3.d3num ,d6.d6num,d9.d9num,d12.d12num,ds.dsnum   from \n");
		sql.append("(SELECT count(t.people_id) d3num FROM DREL_DEAD_COLLECT t \n"); 
		sql.append("   where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("   add_months（sysdate,-3) and add_months（sysdate,-0) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d3,(SELECT count(t.people_id) d6num FROM DREL_DEAD_COLLECT t \n"); 
		sql.append("   where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("   add_months（sysdate,-6) and  add_months（sysdate,-3) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d6,(SELECT count(t.people_id) d9num FROM DREL_DEAD_COLLECT t \n"); 
		sql.append("    where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("     add_months（sysdate,-9) and add_months（sysdate,-6) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d9,(SELECT count(t.people_id) d12num FROM DREL_DEAD_COLLECT t \n"); 
		sql.append("    where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("     add_months（sysdate,-12) and add_months（sysdate,-9) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d12,(SELECT count(t.people_id) dsnum FROM DREL_DEAD_COLLECT t \n"); 
		sql.append("    where to_date(t.death_date, 'yyyy-mm-dd')<add_months（sysdate，-12) and instr(t.domicile_code,?)=1      ) ds");
		if("370000000000".equals(organCode)){
			for(int i=0;i<5;i++){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2));
			}
		}else if(organCode != null && !organCode.equals("")&&"00000000".equals(organCode.substring(4, 12))){
			for(int i=0;i<5;i++){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4));
			}
		}else {
			for(int i=0;i<5;i++){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6));
			}
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, true);
		} 
		return ds;
	}
	public DataSet queryDeadDrelObject(ParameterSet pset) {
		//int start = pset.getPageStart();
		//int limit = pset.getPageLimit();
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String objectType = (String) pset.getParameter("objectType");
		String queryType = (String) pset.getParameter("queryType");
		String time = (String) pset.getParameter("time");
		StringBuffer sql = new  StringBuffer();

		sql.append("SELECT t.people_id,t.dead_id, \n");
		sql.append("             t.family_id, \n"); 
		sql.append("             t.APPLY_ID, \n");
		sql.append("             t.DOMICILE_FULL_NAME, \n");
		sql.append("             t.name, \n"); 
		sql.append("             t.id_card, \n"); 
		sql.append("             t.sex, \n");
		sql.append("             t.NATION, \n");
		sql.append("             t.ASSISTANCE_TYPE, \n");
		sql.append("             t.death_date, \n"); 
		sql.append("             t.cremation_time, \n"); 
		sql.append("             t.funeral_name \n"); 
		sql.append("        FROM drel_dead_collect t \n"); 
		sql.append("       WHERE 1= 1");
		if("organCode".equals(queryType)&&organCode != null && !organCode.equals("")&&objectType != null ){
			if("01".equals(objectType)){
				sql.append("and t.ASSISTANCE_TYPE ='01' ");
			}else if("02".equals(objectType)){
				sql.append("and t.ASSISTANCE_TYPE ='02'");
			}else if("03".equals(objectType)){
				sql.append("and t.ASSISTANCE_TYPE ='03'");
			}else if("".equals(objectType)){
				sql.append("and t.ASSISTANCE_TYPE IN ('01','02','03')");
			}
			if (!organCode.substring(0, 2).equals("00")
						&& organCode.substring(2, 4).equals("00")) {
				sql.append(" AND  SUBSTR(t.domicile_code,1,2)=?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2));
			} else if (!organCode.substring(2, 4).equals("00")
					&& organCode.substring(4, 6).equals("00")) {
				sql.append(" AND SUBSTR(t.domicile_code,1,4)=?");// 市局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4));
			} else {
				sql.append(" AND SUBSTR(t.domicile_code,1,6)=?");// 区县
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6));
			}
			sql.append(" order by t.death_date asc,t.people_id,t.dead_id");
		}else if("month".equals(queryType) ){
			if("three".equals(time)){
				sql.append(" and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-3) and add_months（sysdate,-0) and instr(t.domicile_code,?)=1 ");
			}else if("six".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-6) and add_months（sysdate,-3) and instr(t.domicile_code,?)=1");
			}else if("nine".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-9) and add_months（sysdate,-6) and instr(t.domicile_code,?)=1");
			}else if("year".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-12) and add_months（sysdate,-9) and instr(t.domicile_code,?)=1");
			}else if("thanyear".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd')<add_months（sysdate，-12) and instr(t.domicile_code,?)=1 ");
			}
			if("370000000000".equals(organCode)){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2));
			}else if(organCode != null && !organCode.equals("")&&"00000000".equals(organCode.substring(4, 12))){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4));
			}else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6));
			}
		}
		
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, getDsStart(pset), getDsLimit(pset),true);
		} else {
			//ds = this.executeDataset(sql.toString(),start,limit, true);
			ds = this.executeDataset(sql.toString(), getDsStart(pset), getDsLimit(pset),true);
		}
		return ds;
	}
	
	public DataSet queryDeadDrelObjectByOrgan(ParameterSet pset){
		DataSet ds = new DataSet();
    	List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
 		String organCode = (String) pset.getParameter("dim");
		StringBuffer sql = new StringBuffer();
		if("370000000000".equals(organCode)){
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,CITY_NUM , COUNTRY_NUM,FIVE_NUM,(CITY_NUM+COUNTRY_NUM+FIVE_NUM) as TOTAL_NUM from V_DREL_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and substr(t.ORGAN_CODE,5,8)='00000000' order by  t.ORGAN_CODE\n");
			ds = this.executeDataset(sql.toString(), true);
		}else if(organCode != null && !organCode.equals("")&&"00000000".equals(organCode.substring(4, 12))){
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,CITY_NUM , COUNTRY_NUM,FIVE_NUM,(CITY_NUM+COUNTRY_NUM+FIVE_NUM) as TOTAL_NUM  from V_DREL_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and instr(t.ORGAN_CODE,?)=1 order by  t.ORGAN_CODE");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
			if(typeList.size() != 0 && argsList.size()!= 0) {
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++) {
					types[i]=(Integer)(typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sql.toString(),types,args, true);
			} 
		}else {
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,CITY_NUM , COUNTRY_NUM,FIVE_NUM,(CITY_NUM+COUNTRY_NUM+FIVE_NUM) as TOTAL_NUM  from V_DREL_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and instr(t.ORGAN_CODE,?)=1 order by  t.ORGAN_CODE");
			if (organCode != null && !organCode.equals("")) {
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
			if(typeList.size() != 0 && argsList.size()!= 0) {
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++) {
					types[i]=(Integer)(typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sql.toString(),types,args, true);
			} 
		}
		//sql.append("select ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR from V_BPT_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and substr(t.ORGAN_CODE,5,8)='00000000' \n");
		//ds = this.executeDataset(sql.toString(), true);
		return ds;
	}
	/**
	 * @Title: getDsStart 
	 * @Description: TODO(excel分页信息A) 
	 * @author wangziming
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	/**
	 * @Title: getDsLimit 
	 * @Description: TODO(excel分页信息B) 
	 * @author wangziming
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit;
	}
}