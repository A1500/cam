package com.inspur.cams.drel.samu.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.drel.samu.dao.ISamWorkerInfoDao;
import com.inspur.cams.drel.samu.data.SamWorkerInfo;

/**
 * 工作人员信息dao
 * @author 
 * @date 2012-09-26
 */
public class SamWorkerInfoDao extends EntityDao<SamWorkerInfo> implements ISamWorkerInfoDao {
	
	@Override
	public Class<SamWorkerInfo> getEntityClass() {
		return SamWorkerInfo.class;
	}
	//统计-敬老院工作员工
	public DataSet reportWorkerInfo(ParameterSet pset){
//		 StringBuffer sql=new StringBuffer(); 
//				List<Integer> typeList = new ArrayList<Integer>();
//		List<Object> argsList = new ArrayList<Object>();
//		       String areaLevelId=(String)pset.getParameter("areaLevelId");
//		       sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
//		   sql.append("select ");
//		   int index=12;
//		if(StringUtils.isNotEmpty(areaLevelId)){
//			if(areaLevelId.indexOf("000")<9&&areaLevelId.indexOf("000")>0){
//				index=areaLevelId.indexOf("000")+3;
//			}
//		}
//	   sql.append(" rpad(substr(p.AREA_LEVEL_ID,1,"+index+"),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(p.AREA_LEVEL_ID,1,"+index+"),12,'0') ) AREA_LEVEL_NAME,");
//	   sql.append("  count(S.WORKER_ID) AS NUM_SUM, ");
//	   sql.append("  sum(case when s.POST_PROPERTY = '0' then 1 else 0 end) AS POST_ZS , ");
//	   sql.append("  sum(case when s.POST_PROPERTY = '1' then 1 else 0 end) AS POST_HT , ");
//	   sql.append("  sum(case when s.POST_PROPERTY = '2' then 1 else 0 end) AS POST_LS , ");
//	  sql.append("  sum(case when s.POST_PROPERTY = '3' then 1 else 0 end) AS POST_WB , ");
//	   sql.append("  sum(case when s.POST_PROPERTY = '4' then 1 else 0 end) AS POST_QT , ");
//	   sql.append("  sum(case when s.SEX = '1' then 1 else 0 end)  			AS SEX_MALE , ");
//	   sql.append("  sum(case when s.SEX = '2' then 1 else 0 end) 			AS SEX_FEMALE , ");
//	   sql.append("  AVG (getage_card_no(ID_CARD)) 			                AS AVG_AGE , ");
//	   sql.append("  SUM(CASE WHEN getage_card_no(ID_CARD)>'35' THEN 1 ELSE 0 END) 		AS LOW_AGE_NUM , ");
//	   sql.append("  sum(case when s.WORK_TYPE = '0' then 1 else 0 end) 	AS WORK_GL , ");
//	   sql.append("  sum(case when s.WORK_TYPE = '1' then 1 else 0 end) 	AS WORK_CS , ");
//	    sql.append("  sum(case when s.WORK_TYPE = '2' then 1 else 0 end) 	AS WORK_WS , ");
//	   sql.append("  sum(case when s.WORK_TYPE = '3' then 1 else 0 end) 	AS WORK_QT , ");
//	   sql.append("  sum(case when s.SALARY = '0' then 1 else 0 end) 		AS SALARY_ONE , ");
//	   sql.append("  sum(case when s.SALARY = '1' then 1 else 0 end) 		AS SALARY_TWO , ");
//	  sql.append("  sum(case when s.SALARY = '2' then 1 else 0 end) 		AS SALARY_THREE , ");
//	   sql.append("  sum(case when s.SALARY = '3' then 1 else 0 end) 		AS SALARY_FOUR  "); 
//	    
//	  sql.append("  from SAM_WORKER_INFO s,SAM_GEROCOMIUM_INFO P where 1=1 ");
//	  sql.append("  and s.GEROCOMIUM_ID=p.GEROCOMIUM_ID  and s.IS_ONDUTY='1' ");   
//	   sql.append("group by rpad(substr(p.AREA_LEVEL_ID,1,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(p.AREA_LEVEL_ID,1,"+index+"),12,'0') )");
//	   sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
//	  sql.append("  where d.id = rpad(substr(d.id, 1, "+index+"), 12, 0) ");
//	  if (StringUtils.isNotEmpty(areaLevelId)) {
//		   if(areaLevelId.endsWith("000")){
//		    	sql.append(" and d.ups=?  " );
//		   } else {
//		    	sql.append(" and d.id=?  " );
//		   }
//			typeList.add(Types.VARCHAR);
//	  		argsList.add(areaLevelId);
//	   }
//	   sql.append(" order by d.id ");
//	   DataSet ds=new DataSet();
//	    if (typeList.size() != 0 && argsList.size() != 0) {
//			int[] types = new int[typeList.size()];
//			for (int i = 0; i < typeList.size(); i++) {
//				types[i] = typeList.get(i);
//			}
//			Object[] args = argsList.toArray(new Object[argsList.size()]);
//			ds = this.executeDataset(sql.toString(), types, args,true);
//		} else {
//			ds = this.executeDataset(sql.toString(), true);
//		}
//		return ds;
		String areaLevelId=(String)pset.getParameter("areaLevelId");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAMU_WORKER_REPORT");
		map.put("parameterNum", 1);
		map.put("NumberOfResultSet",1);
		map.put("parameterName_1", "area_id");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", areaLevelId);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}
}