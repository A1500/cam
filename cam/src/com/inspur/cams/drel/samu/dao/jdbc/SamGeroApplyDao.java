package com.inspur.cams.drel.samu.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.drel.samu.dao.ISamGeroApplyDao;
import com.inspur.cams.drel.samu.data.SamGeroApply;

/**
 * 敬老院业务主表dao
 * @author 
 * @date 2012-10-24
 */
public class SamGeroApplyDao extends EntityDao<SamGeroApply> implements ISamGeroApplyDao {
	
	@Override
	public Class<SamGeroApply> getEntityClass() {
		return SamGeroApply.class;
	}
	/**
	 * 查询 查体名册
	 * @param pset
	 * @return
	 */
	public DataSet queryList(ParameterSet pset){
		String gerocomiumId=(String)pset.getParameter("gerocomiumName");
		String checkDate=(String)pset.getParameter("checkDate");
		String areaLevelId=(String)pset.getParameter("areaLevelId");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select p.GEROCOMIUM_ID,f.gerocomium_name,p.CHECK_DATE,p.REMARKS,COUNT(*) AS TOTALNUM ,");
		sql.append("  SUM(case when p.CHECK_RESULT = '0' then 1 else 0 end) AS JK_NUM ,");
		sql.append("  SUM(case when p.CHECK_RESULT = '1' then 1 else 0 end) AS YB_NUM ,");
		sql.append("  SUM(case when p.CHECK_RESULT = '2' then 1 else 0 end) AS ZB_NUM ");
		sql.append("FROM sam_gero_apply p,sam_gerocomium_info f  ");
		sql.append("where p.gerocomium_id=f.gerocomium_id and p.APPLY_TYPE='4' ");
		if(StringUtils.isNotEmpty(areaLevelId)){
			sql.append("   AND f.area_level_id like ? ");
			argsList.add(areaLevelId+"%");
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(gerocomiumId)){
			sql.append("   AND p.gerocomium_id = ? ");
			argsList.add(gerocomiumId);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(checkDate)){
			sql.append("   AND p.CHECK_DATE = ? ");
			argsList.add(checkDate);
			typeList.add(Types.VARCHAR);
		}
		sql.append(" GROUP BY p.GEROCOMIUM_ID,p.CHECK_DATE,f.gerocomium_name,p.REMARKS ");
		sql.append(" ORDER BY f.gerocomium_name,p.CHECK_DATE desc" );
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		//sql.append("select GEROCOMIUM_ID,CHECK_DATE,COUNT(*) AS TOTALNUM FROM sam_gero_apply GROUP BY GEROCOMIUM_ID,CHECK_DATE");
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	/**
	 * 增加查体信息
	 * @param pset
	 * @return
	 */
	public void insertCheck(String gerocomiumName,String checkDate,String checkResult){
		StringBuffer sqlQuery=new StringBuffer();
		sqlQuery.append("select PERSON_ID,GEROCOMIUM_ID from SAM_GERO_KEPT_PERSON  where IS_STATUS='1' AND GEROCOMIUM_ID =?");
		DataSet ds=executeDataset(sqlQuery.toString(), new int[]{Types.VARCHAR}, new Object[]{gerocomiumName},  true);
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record=ds.getRecord(i);
				SamGeroApply samGeroApply=(SamGeroApply)RecordToBeanUtil.recordToBeanUtil(record, SamGeroApply.class);
				samGeroApply.setApplyId(IdHelp.getUUID32());
				samGeroApply.setApplyType("4");
				samGeroApply.setCheckDate(checkDate);
				samGeroApply.setCheckResult(checkResult);
				samGeroApply.setRemarks(checkResult);
				this.insert(samGeroApply);
			}
			
		}	
	}
	/**
	 * 维护查体名册时，弹出查询明细
	 * @param pset
	 * @return
	 */
	public DataSet queryCheckDetail(ParameterSet pset){
		String gerocomiumId=(String)pset.getParameter("gerocomiumId");
		String checkDate=(String)pset.getParameter("checkDate");
		String personName=(String)pset.getParameter("personName");
		String idCard=(String)pset.getParameter("idCard");
		String inRoom=(String)pset.getParameter("inRoom");
		String inBed=(String)pset.getParameter("inBed");
		StringBuffer sql=new StringBuffer();
		sql.append("select P.PERSON_NAME,F.PERSON_ID,F.APPLY_ID,P.ID_CARD,P.GEROCOMIUM_ID,Q.GEROCOMIUM_NAME,P.IN_ROOM,P.IN_BED,F.CHECK_DATE,F.CHECK_RESULT,F.REMARKS ");
		sql.append(" from SAM_GERO_KEPT_PERSON P,sam_gero_apply F ,sam_gerocomium_info Q ");
		sql.append("where F.GEROCOMIUM_ID =P.GEROCOMIUM_ID AND F.PERSON_ID=P.PERSON_ID  AND F.GEROCOMIUM_ID =Q.GEROCOMIUM_ID AND F.APPLY_TYPE='4' ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(gerocomiumId)){
			sql.append("   AND F.GEROCOMIUM_ID=? ");
			argsList.add(gerocomiumId);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(checkDate)){
			sql.append(" AND  F.CHECK_DATE=? ");
			argsList.add(checkDate);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(personName)){
			sql.append("   AND p.PERSON_NAME = ? ");
			argsList.add(personName);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("   AND p.ID_CARD = ? ");
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inRoom)){
			sql.append("   AND p.IN_ROOM = ? ");
			argsList.add(inRoom);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inBed)){
			sql.append("   AND p.IN_BED = ? ");
			argsList.add(inBed);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	//零花钱列表查询方法@tr
	public DataSet queryMoneryList(ParameterSet pset){
		String gerocomiumId=(String)pset.getParameter("gerocomiumName");
		String pocketYM=(String)pset.getParameter("pocketYM");
		String areaLevelId=(String)pset.getParameter("areaLevelId");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select p.GEROCOMIUM_ID,f.gerocomium_name,p.POCKET_YM,p.POCKET_STATUS,COUNT(*) AS TOTAL_NUM,SUM(p.POCKET_MONEY) AS APPLY_MONEYNUM ");
		sql.append("FROM sam_gero_apply p,sam_gerocomium_info f  ");
		sql.append("where p.gerocomium_id=f.gerocomium_id  AND P.APPLY_TYPE='2' ");
		if(StringUtils.isNotEmpty(areaLevelId)){
			sql.append("   AND f.area_level_id like ? ");
			argsList.add(areaLevelId+"%");
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(gerocomiumId)){
			sql.append("   AND p.gerocomium_id = ? ");
			argsList.add(gerocomiumId);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(pocketYM)){
			sql.append("   AND p.POCKET_YM = ? ");
			argsList.add(pocketYM);
			typeList.add(Types.VARCHAR);
		}
		sql.append("GROUP BY p.GEROCOMIUM_ID,p.POCKET_YM,f.gerocomium_name,p.POCKET_STATUS ");
		sql.append("ORDER BY f.gerocomium_name,p.POCKET_YM DESC, p.POCKET_STATUS ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		//sql.append("select GEROCOMIUM_ID,CHECK_DATE,COUNT(*) AS TOTALNUM FROM sam_gero_apply GROUP BY GEROCOMIUM_ID,CHECK_DATE");
		DataSet ds=executeDataset(sql.toString(),types,args, true);
		return ds;
	}
	//零花钱统计查询方法@tr
	public DataSet queryPocketList(ParameterSet pset){
		String manaLevel=(String)pset.getParameter("pocketArea");
		String pocketYM=(String)pset.getParameter("pocketYm");
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		sql.append("select ");
		int index=12;
		if(StringUtils.isNotEmpty(manaLevel)){
			if(manaLevel.indexOf("000")<9&&manaLevel.indexOf("000")>0){
				index=manaLevel.indexOf("000")+3;
			}
		}
		sql.append(" rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') ) AREA_LEVEL_NAME,");
	    sql.append("  count(p.PERSON_ID)                        AS TOTAL_NUM, ");
	    sql.append("  SUM(p.POCKET_MONEY)               AS APPLY_MONEYNUM, ");
	    sql.append("  SUM(p.POCKET_MONEY)/count(p.PERSON_ID)            AS AVERAGE_MONEY ");
	    sql.append("  FROM sam_gero_apply p,sam_gerocomium_info s  ");
	    sql.append(" where p.gerocomium_id=s.gerocomium_id  AND p.APPLY_TYPE='2' AND p.POCKET_STATUS='1' AND substr(p.pocket_ym,0,7)=? ");
	    	typeList.add(Types.VARCHAR);
	      	argsList.add(pocketYM);
	    sql.append("group by rpad(substr(s.AREA_LEVEL_ID,1,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') )");
	    sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
	    sql.append("  where d.id = rpad(substr(d.id, 1, "+index+"), 12, 0) ");
	    if (StringUtils.isNotEmpty(manaLevel)) {
	    	if(manaLevel.endsWith("000")){
	    		sql.append(" and d.ups=?  " );
			} else {
			    sql.append(" and d.id=?  " );
			}
	    	typeList.add(Types.VARCHAR);
	      	argsList.add(manaLevel);
	    }
	    sql.append(" order by d.id ");
	    DataSet ds=new DataSet();
       if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}

		return ds;
	}
	//服装统计查询方法@tr
	public DataSet applyClothList(ParameterSet pset){
		String manaLevel=(String)pset.getParameter("manaLevel");
		String queryYear=(String)pset.getParameter("queryYear");
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		sql.append("select ");
		int index=12;
		if(StringUtils.isNotEmpty(manaLevel)){
			if(manaLevel.indexOf("000")<9&&manaLevel.indexOf("000")>0){
				index=manaLevel.indexOf("000")+3;
			}
		}
		sql.append(" rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') ) AREA_LEVEL_NAME,");
	    sql.append("  count(p.PERSON_ID)                        AS TOTAL_NUM, ");
	    sql.append("  SUM(p.CLOTH_NUM)               AS APPLY_CLOTHNUM, ");
	    sql.append("  SUM(case when p.CLOTH_TYPE = '1' then CLOTH_NUM else 0 end) AS SPRING_CLOTH ,");
	    sql.append("  SUM(case when p.CLOTH_TYPE = '2' then CLOTH_NUM else 0 end) AS SUMMER_CLOTH ,");
	    sql.append("  SUM(case when p.CLOTH_TYPE = '3' then CLOTH_NUM else 0 end) AS AUTUMN_CLOTH ,");
	    sql.append("  SUM(case when p.CLOTH_TYPE = '4' then CLOTH_NUM else 0 end) AS WINTER_CLOTH ");
	    sql.append("  FROM sam_gero_apply p,sam_gerocomium_info S  ");
	    sql.append(" where p.gerocomium_id=s.gerocomium_id  AND P.APPLY_TYPE='3' AND p.CLOTH_STATUS='1' AND substr(p.cloth_date,0,4)=? ");
	    typeList.add(Types.VARCHAR);
	    argsList.add(queryYear);
	    sql.append("group by rpad(substr(s.AREA_LEVEL_ID,1,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') )");
	    sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
	    sql.append("  where d.id = rpad(substr(d.id, 1, "+index+"), 12, 0) ");
	    if (StringUtils.isNotEmpty(manaLevel)) {
	    	if(manaLevel.endsWith("000")){
	    		sql.append(" and d.ups=?  " );
			} else {
			    sql.append(" and d.id=?  " );
			}
	    	typeList.add(Types.VARCHAR);
	      	argsList.add(manaLevel);
	    }
	    sql.append(" order by d.id ");
	    DataSet ds=new DataSet();
       if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}

		return ds;
	}
	//查体统计查询方法@tr
	public DataSet applyCheckList(ParameterSet pset){
		String manaLevel=(String)pset.getParameter("manaLevel");
		String queryYear=(String)pset.getParameter("queryYear");
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		sql.append("select ");
		int index=12;
		if(StringUtils.isNotEmpty(manaLevel)){
			if(manaLevel.indexOf("000")<9&&manaLevel.indexOf("000")>0){
				index=manaLevel.indexOf("000")+3;
			}
		}
		sql.append(" rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') ) AREA_LEVEL_NAME,");
	    sql.append("  count(q.PERSON_ID)               AS TOTAL_NUM, ");
	    sql.append("  count(p.PERSON_ID)               AS CHECK_PEOPLENUM, ");
	    sql.append("  count(p.APPLY_ID)               AS CHECK_BODYNUM ,");
	    sql.append("  count(p.APPLY_ID)/count(p.PERSON_ID)    AS AVERAGE_CHECKNUM ");
	    sql.append("  FROM sam_gero_apply p,sam_gerocomium_info S ,sam_gero_kept_person q ");
	    sql.append(" where p.gerocomium_id=s.gerocomium_id AND p.person_id=q.person_id AND p.APPLY_TYPE='4' AND substr(p.check_date,0,4)=? AND q.IS_STATUS='1'");
		typeList.add(Types.VARCHAR);
	    argsList.add(queryYear);
	    sql.append("group by rpad(substr(s.AREA_LEVEL_ID,1,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,1,"+index+"),12,'0') )");
	    sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
	    sql.append("  where d.id = rpad(substr(d.id, 1, "+index+"), 12, 0) ");
	    if (StringUtils.isNotEmpty(manaLevel)) {
	    	if(manaLevel.endsWith("000")){
	    		sql.append(" and d.ups=?  " );
			} else {
			    sql.append(" and d.id=?  " );
			}
	    	typeList.add(Types.VARCHAR);
	      	argsList.add(manaLevel);
	    }
	    sql.append(" order by d.id ");
	    DataSet ds=new DataSet();
       if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}

		return ds;
	}
	//服装列表查询方法@tr
	public DataSet queryClothList(ParameterSet pset){
		String gerocomiumId=(String)pset.getParameter("gerocomiumName");
		String clothDate=(String)pset.getParameter("clothDate");
		String clothType=(String)pset.getParameter("clothType");
		String areaLevelId=(String)pset.getParameter("areaLevelId");
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("select p.GEROCOMIUM_ID,f.gerocomium_name,p.CLOTH_DATE,p.CLOTH_TYPE,p.CLOTH_STATUS,COUNT(*) AS TOTAL_NUM,SUM(p.CLOTH_NUM) AS APPLY_CLOTHNUM ");
		sql.append("FROM sam_gero_apply p,sam_gerocomium_info f ");
		sql.append("where p.gerocomium_id=f.gerocomium_id  AND P.APPLY_TYPE='3'");
		if(StringUtils.isNotEmpty(areaLevelId)){
			sql.append("   AND f.area_level_id like ? ");
			argsList.add(areaLevelId+"%");
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(gerocomiumId)){
			sql.append("   AND p.gerocomium_id = ? ");
			argsList.add(gerocomiumId);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(clothDate)){
			sql.append("   AND p.CLOTH_DATE = ? ");
			argsList.add(clothDate);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(clothType)){
			sql.append("   AND p.CLOTH_TYPE = ? ");
			argsList.add(clothType);
			typeList.add(Types.VARCHAR);
		}
		sql.append("GROUP BY p.GEROCOMIUM_ID,p.CLOTH_DATE,p.CLOTH_TYPE,f.gerocomium_name,p.CLOTH_STATUS ");
		sql.append("ORDER BY f.gerocomium_name,p.CLOTH_DATE DESC ,p.CLOTH_STATUS ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		//sql.append("select GEROCOMIUM_ID,CHECK_DATE,COUNT(*) AS TOTALNUM FROM sam_gero_apply GROUP BY GEROCOMIUM_ID,CHECK_DATE");
		DataSet ds=executeDataset(sql.toString(),types,args, true);
		return ds;
	}
	//零花钱明细查询方法  @tr
	public DataSet queryMoneyDetail(ParameterSet pset){
		String gerocomiumId=(String)pset.getParameter("gerocomiumId");
		String pocketYm=(String)pset.getParameter("pocketYm");
		String personName=(String)pset.getParameter("personName");
		String idCard=(String)pset.getParameter("idCard");
		String inRoom=(String)pset.getParameter("inRoom");
		String inBed=(String)pset.getParameter("inBed");
		String pocketStatus=(String)pset.getParameter("pocketStatus");//用于五保对象查询时，显示确认的发放信息
		StringBuffer sql=new StringBuffer();
		sql.append("select P.PERSON_NAME,F.PERSON_ID,F.APPLY_ID,P.ID_CARD,P.GEROCOMIUM_ID,Q.GEROCOMIUM_NAME,P.IN_ROOM,P.IN_BED,F.POCKET_YM,F.POCKET_MONEY ");
		sql.append(" from SAM_GERO_KEPT_PERSON P,sam_gero_apply F ,sam_gerocomium_info Q ");
		sql.append("where F.GEROCOMIUM_ID =P.GEROCOMIUM_ID AND F.PERSON_ID=P.PERSON_ID AND F.GEROCOMIUM_ID =Q.GEROCOMIUM_ID AND F.APPLY_TYPE='2' ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(gerocomiumId)){
			sql.append("   AND F.GEROCOMIUM_ID = ? ");
			argsList.add(gerocomiumId);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(pocketYm)){
			sql.append("   AND F.POCKET_YM = ? ");
			argsList.add(pocketYm);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(personName)){
			sql.append("   AND p.PERSON_NAME = ? ");
			argsList.add(personName);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("   AND p.ID_CARD = ? ");
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inRoom)){
			sql.append("   AND p.IN_ROOM = ? ");
			argsList.add(inRoom);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inBed)){
			sql.append("   AND p.IN_BED = ? ");
			argsList.add(inBed);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(pocketStatus)){
			sql.append("   AND f.POCKET_STATUS = ? ");
			argsList.add(pocketStatus);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
	//服装明细查询方法@tr
	public DataSet queryClothDetail(ParameterSet pset){
		String gerocomiumId=(String)pset.getParameter("gerocomiumId");
		String clothDate=(String)pset.getParameter("clothDate");
		String personName=(String)pset.getParameter("personName");
		String idCard=(String)pset.getParameter("idCard");
		String inRoom=(String)pset.getParameter("inRoom");
		String inBed=(String)pset.getParameter("inBed");
		String clothStatus=(String)pset.getParameter("clothStatus");//用于五保对象查询时，显示确认的发放信息
		StringBuffer sql=new StringBuffer();
		sql.append("select P.PERSON_NAME,F.PERSON_ID,F.APPLY_ID,P.ID_CARD,P.GEROCOMIUM_ID,Q.GEROCOMIUM_NAME,P.IN_ROOM,P.IN_BED,F.CLOTH_DATE,F.CLOTH_NUM ");
		sql.append(" from SAM_GERO_KEPT_PERSON P,sam_gero_apply F ,sam_gerocomium_info Q ");
		sql.append("where F.GEROCOMIUM_ID =P.GEROCOMIUM_ID AND F.PERSON_ID=P.PERSON_ID AND F.GEROCOMIUM_ID =Q.GEROCOMIUM_ID AND F.APPLY_TYPE='3' ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(gerocomiumId)){
			sql.append("   AND F.GEROCOMIUM_ID=? ");
			argsList.add(gerocomiumId);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(clothDate)){
			sql.append("   AND F.CLOTH_DATE=? ");
			argsList.add(clothDate);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(personName)){
			sql.append("   AND p.PERSON_NAME = ? ");
			argsList.add(personName);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("   AND p.ID_CARD = ? ");
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inRoom)){
			sql.append("   AND p.IN_ROOM = ? ");
			argsList.add(inRoom);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(inBed)){
			sql.append("   AND p.IN_BED = ? ");
			argsList.add(inBed);
			typeList.add(Types.VARCHAR);
		}
		if(StringUtils.isNotEmpty(clothStatus)){
			sql.append("   AND f.CLOTH_STATUS = ? ");
			argsList.add(clothStatus);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		return ds;
	}
}