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
import com.inspur.cams.drel.samu.dao.ISamGeroKeptPersonDao;
import com.inspur.cams.drel.samu.data.SamGeroKeptPerson;

/**
 * 供养对象信息表dao
 * @author 
 * @date 2012-10-24
 */
public class SamGeroKeptPersonDao extends EntityDao<SamGeroKeptPerson> implements ISamGeroKeptPersonDao {
	
	@Override
	public Class<SamGeroKeptPerson> getEntityClass() {
		return SamGeroKeptPerson.class;
	}
	/**
	 * 维护查体名册时，增加时查询不在查体名册的人员
	 * @param pset
	 * @return
	 */
	public DataSet queryInsertPerson(ParameterSet pset){
		String gerocomiumId=(String)pset.getParameter("gerocomiumId");
		String[] recordPersonId=(String[])pset.getParameter("recordPersonId");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select * from SAM_GERO_KEPT_PERSON  where IS_STATUS='1' AND GEROCOMIUM_ID =?");
		argsList.add(gerocomiumId);
		typeList.add(Types.VARCHAR);
		if(recordPersonId!=null){
			sql.append("and person_id not in ( ");
			for(int i=0;i<recordPersonId.length;i++){
				sql.append(" ?,");
				argsList.add(recordPersonId[i]);
				typeList.add(Types.VARCHAR);
			}
			sql.deleteCharAt(sql.length()-1);
			sql.append(" ) ");
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	//查询入出院供养对象列表
	public DataSet queryInoutList(ParameterSet pset){
		String gerocomiumName=(String)pset.getParameter("gerocomiumName");
		String personName=(String)pset.getParameter("personName");
		String idCard=(String)pset.getParameter("idCard");
		String inRoom=(String)pset.getParameter("inRoom");
		String inBed=(String)pset.getParameter("inBed");
		String manaLevel=(String)pset.getParameter("manaLevel");
		String areaLevelId=(String)pset.getParameter("areaLevelId");
		String isStatus=(String)pset.getParameter("isStatus");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select f.*,p.gerocomium_name,p.mana_level  ");
		sql.append("from sam_gerocomium_info p,sam_gero_kept_person f ");
		sql.append("where p.gerocomium_id=f.gerocomium_id ");
		if(StringUtils.isNotEmpty(areaLevelId)){
			sql.append(" and p.area_level_id like ? ");
			argsList.add(areaLevelId+"%");
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(gerocomiumName)){
			sql.append("   AND p.gerocomium_name = ? ");
			argsList.add(gerocomiumName);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(personName)){
			sql.append("   AND f.person_name = ? ");
			argsList.add(personName);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("   AND f.id_card = ? ");
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inRoom)){
			sql.append("   AND f.in_room = ? ");
			argsList.add(inRoom);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inBed)){
			sql.append("   AND f.in_bed = ? ");
			argsList.add(inBed);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(manaLevel)){
			sql.append("   AND p.mana_level = ? ");
			argsList.add(manaLevel);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(isStatus)){
			sql.append("   AND f.is_status = ? ");
			argsList.add(isStatus);
			typeList.add(Types.VARCHAR);
		}
		sql.append("order by p.gerocomium_name,f.person_name");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	//统计五保供养对象信息表
	public DataSet reportSupportInfo(ParameterSet pset){
//		StringBuffer sql=new StringBuffer(); 
//		List<Integer> typeList = new ArrayList<Integer>();
//		List<Object> argsList = new ArrayList<Object>();
//	   String queryYear=(String)pset.getParameter("queryYear");
//	   String areaLevelId=(String)pset.getParameter("areaLevelId");
//	   sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
//	   sql.append("select ");
//	   int index=12;
//		if(StringUtils.isNotEmpty(areaLevelId)){
//			if(areaLevelId.indexOf("000")<9&&areaLevelId.indexOf("000")>0){
//				index=areaLevelId.indexOf("000")+3;
//			}
//		}
//	   sql.append(" rpad(substr(p.AREA_LEVEL_ID,1,"+index+"),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(p.AREA_LEVEL_ID,1,"+index+"),12,'0') ) AREA_LEVEL_NAME,");
//	   sql.append("  count(S.PERSON_ID) AS NUM_SUM, ");
//	   sql.append("  AVG (getage_card_no(s.ID_CARD)) 			                AS AVG_AGE , ");
//	   sql.append("  MAX (getage_card_no(s.ID_CARD)) 			                AS MAX_AGE , ");
//	   sql.append("  MIN (getage_card_no(s.ID_CARD)) 			                AS MIN_AGE , ");
//	   sql.append("  sum(case when s.SEX = '1' then 1 else 0 end) 		        AS SEX_MALE , ");
//	   sql.append("  sum(case when s.SEX = '2' then 1 else 0 end) 		        AS SEX_FEMALE ");   
//	   
//	   sql.append("  from SAM_GERO_KEPT_PERSON s,SAM_GEROCOMIUM_INFO P where 1=1 ");
//	   sql.append("  and s.GEROCOMIUM_ID=p.GEROCOMIUM_ID  and s.IS_STATUS='1' ");
//	   sql.append("  AND p.YEAR=? ");
//	   typeList.add(Types.VARCHAR);
//	   argsList.add(queryYear);
//	   
//	   sql.append("group by rpad(substr(p.AREA_LEVEL_ID,1,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(p.AREA_LEVEL_ID,1,"+index+"),12,'0') )");
//	   sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
//	   sql.append("  where d.id = rpad(substr(d.id, 1, "+index+"), 12, 0) ");
//	   if (StringUtils.isNotEmpty(areaLevelId)) {
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
//	   if (typeList.size() != 0 && argsList.size() != 0) {
//			int[] types = new int[typeList.size()];
//			for (int i = 0; i < typeList.size(); i++) {
//				types[i] = typeList.get(i);
//			}
//			Object[] args = argsList.toArray(new Object[argsList.size()]);
//			ds = this.executeDataset(sql.toString(), types, args,true);
//		} else {
//			ds = this.executeDataset(sql.toString(), true);
//		}
//	
//		return ds;
		String queryYear=(String)pset.getParameter("queryYear");
		String areaLevelId=(String)pset.getParameter("areaLevelId");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAMU_SUPPORT_REPORT");
		map.put("parameterNum", 2);
		map.put("NumberOfResultSet",1);
		map.put("parameterName_1", "area_id");
		map.put("parameterName_2", "query_date");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", areaLevelId);
		map.put("parameterValue_2", queryYear);
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
	//入出院记录信息查询
	public DataSet queryInoutRecord(ParameterSet pset){
		String gerocomiumName=(String)pset.getParameter("gerocomiumName");
		String personName=(String)pset.getParameter("personName");
		String idCard=(String)pset.getParameter("idCard");
		String inRoom=(String)pset.getParameter("inRoom");
		String inBed=(String)pset.getParameter("inBed");
		String manaLevel=(String)pset.getParameter("manaLevel");
		String isStatus=(String)pset.getParameter("isStatus");
		String startInDate=(String)pset.getParameter("startInDate");
		String endInDate=(String)pset.getParameter("endInDate");
		String startOutDate=(String)pset.getParameter("startOutDate");
		String endOutDate=(String)pset.getParameter("endOutDate");
		String areaLevelId=(String)pset.getParameter("areaLevelId");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select f.*,p.gerocomium_name,p.mana_level,al.current_in_room,al.current_in_bed, al.in_date,bl.out_date, ");
		sql.append("GETAGE_CARD_NO(f.ID_CARD) AS AGE");
		sql.append(" from sam_gerocomium_info p,sam_gero_kept_person f ");
		sql.append(" right join (select person_id,gerocomium_id,in_date,in_room as current_in_room,in_bed as current_in_bed from sam_gero_apply a where a.apply_type='0' ");
		if(StringUtils.isNotEmpty(startInDate)){
			sql.append("   AND a.in_date >= ? ");
			argsList.add(startInDate);
			typeList.add(Types.VARCHAR);
			if(StringUtils.isNotEmpty(endInDate)){
				sql.append("   AND a.in_date <= ? ");
				argsList.add(endInDate);
				typeList.add(Types.VARCHAR);
			}
		}
		sql.append(" ) al  ");
		sql.append(" on al.person_id=f.person_Id and al.gerocomium_id=f.gerocomium_id ");
		if(StringUtils.isNotEmpty(startOutDate)){
			sql.append(" right join(select person_id,gerocomium_id,out_date from sam_gero_apply b where b.apply_type='1' ");
			sql.append("   AND b.out_date >= ? ");
			argsList.add(startOutDate);
			typeList.add(Types.VARCHAR);
			if(StringUtils.isNotEmpty(endOutDate)){
				sql.append("   AND b.out_date <= ? ");
				argsList.add(endOutDate);
				typeList.add(Types.VARCHAR);
			}
			sql.append(" ) bl   ");
	        sql.append(" on bl.person_id=f.person_Id and bl.gerocomium_id=f.gerocomium_id ");
		}else{
			sql.append(" left join(select person_id,gerocomium_id,out_date from sam_gero_apply b where b.apply_type='1' ");
			sql.append(" ) bl   ");
	        sql.append(" on bl.person_id=f.person_Id and bl.gerocomium_id=f.gerocomium_id ");
		}
        sql.append(" where p.gerocomium_id=f.gerocomium_id ");
		if(StringUtils.isNotEmpty(gerocomiumName)){
			sql.append("   AND p.gerocomium_name = ? ");
			argsList.add(gerocomiumName);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(areaLevelId)){
			sql.append("   AND p.area_level_id like ? ");
			argsList.add(areaLevelId+"%");
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(personName)){
			sql.append("   AND f.person_name = ? ");
			argsList.add(personName);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("   AND f.id_card = ? ");
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inRoom)){
			sql.append("   AND f.in_room = ? ");
			argsList.add(inRoom);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inBed)){
			sql.append("   AND f.in_bed = ? ");
			argsList.add(inBed);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(manaLevel)){
			sql.append("   AND p.mana_level = ? ");
			argsList.add(manaLevel);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(isStatus)){
			sql.append("   AND f.is_status = ? ");
			argsList.add(isStatus);
			typeList.add(Types.VARCHAR);
		}
		sql.append("order by p.gerocomium_name,f.person_name");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
}